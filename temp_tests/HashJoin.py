import copy
from helper import RLN, Context, Operator, hash_table_id, load_to_register, schema


from typing import Dict, List


def prepare_keys(schema, keys: List[str], context: Context, hash_table_id):
    key_types = [schema[RLN(attr)][attr] for attr in keys]
    total_bytes = 0
    byte_map = {"int32_t": 4, "int64_t": 8, "int8_t": 1}
    for ty in key_types:
        if ty not in ["int32_t", "int64_t", "int8_t"]:
            return None
        total_bytes += byte_map[ty]
        if total_bytes > 8:
            return None
    key_text = "int64_t key_{} = 0;\n".format(hash_table_id)
    total_bytes = 0
    for attr in keys:
        load_to_register(attr, context)
    for attr in keys:
        # bring things into register if not already there
        key_text += "key_{id} |= (((int64_t){reg_attr}) << {shift});\n".format(
            id=hash_table_id,
            reg_attr=context.attr_reg_dict[attr],
            shift=8 * total_bytes,
        )
        total_bytes += byte_map[schema[RLN(attr)][attr]]
    context.kernel_code += key_text
    return True


class HashJoin(Operator):
    # note, left and right cannot be pipeline enders
    def __init__(
        self,
        left: Operator,
        right: Operator,
        left_keys: List[str],
        right_keys: List[str],
    ):
        left.parent = self
        right.parent = self
        self.left = left
        self.right = right
        self.left_keys = left_keys
        self.right_keys = right_keys
        global hash_table_id
        self.hash_table_id = hash_table_id
        hash_table_id += 1
        self.relations: set[str] = set()
        self.left_control_code = ""
        self.left_kernel_code = ""

    def produce(self, context):
        self.left_context = copy.deepcopy(context)
        self.left_context.pipeline_params = [
            *self.left_keys,
            "HT{}_I".format(self.hash_table_id),
            "<placeholder_{id}>".format(id=self.hash_table_id),
            "int64_t* JOIN_IDX_{id}".format(id=self.hash_table_id),
        ]
        self.left.produce(self.left_context)
        context.pipeline_params = [
            *self.right_keys,
            "HT{}_F".format(self.hash_table_id),
            *context.pipeline_params,
            "<placeholder_{id}>".format(id=self.hash_table_id),
            "int64_t* JOIN_IDX_{id}".format(id=self.hash_table_id),
        ]
        self.right.produce(context)

    def consume(self, context: Context):
        if context.source == self.left:
            print("consuming: ",self.left_keys)
            res = prepare_keys(schema, self.left_keys, context, self.hash_table_id)
            if res == None:
                print("Unable to pack keys of hash join, ending code generation")
                return
            context.kernel_code += (
                "auto this_thread = cg::tiled_partition<1>(cg::this_thread_block());\n"
            )
            context.kernel_code += (
                "int64_t B{id}_idx = atomicAdd(JOIN_IDX_{id}, 1);\n".format(
                    id=self.hash_table_id
                )
            )
            context.kernel_code = context.kernel_code.replace(
                "<placeholder_{id}>".format(id=self.hash_table_id),
                ", ".join(
                    [
                        "int64_t* JOIN_BUF_{id}_{rln}".format(
                            id=self.hash_table_id, rln=rln
                        )
                        for rln in context.rid_dict
                    ]
                ),
            )
            count_code = context.kernel_code
            count_code += "}\n"
            count_code = count_code.replace(
                "pipeline_{}".format(self.hash_table_id),
                "build_pipeline_count_{}".format(self.hash_table_id),
            ) # end of build pipeline
            context.global_kernel_code += count_code
            context.control_code += "int64_t *d_JOIN_IDX_{};\n".format(
                self.hash_table_id
            )
            context.control_code += (
                "cudaMalloc(&d_JOIN_IDX_{}, sizeof(int64_t));\n".format(
                    self.hash_table_id
                )
            )
            context.control_code += (
                "cudaMemset(d_JOIN_IDX_{}, 0, sizeof(int64_t));\n".format(
                    self.hash_table_id
                )
            )

            context.kernel_code += "HT{id}_I.insert(this_thread, cuco::pair{{key_{id}, B{id}_idx}});\n".format(
                id=self.hash_table_id,
            )
            for rln in context.rid_dict:
                context.kernel_code += (
                    "JOIN_BUF_{id}_{rln}[B{id}_idx] = {rid};\n".format(
                        id=self.hash_table_id, rln=rln, rid=context.rid_dict[rln]
                    )
                )
                context.control_code += "int64_t* d_JOIN_BUF_{id}_{rln};\n".format(
                    id=self.hash_table_id, rln=rln
                )
                self.relations.add(rln)
            context.kernel_code += "}"  # end the pipeline of build
            templ = ["{}_size".format(context.relation)]
            for p in context.pipeline_params:
                if not p.startswith("<placeholder"):
                    templ.append(p)
            templ.extend([
                        "JOIN_BUF_{id}_{rln}".format(
                            id=self.hash_table_id, rln=rln
                        )
                        for rln in context.rid_dict
                    ])
            launch_params = ", ".join(["d_" + attr for attr in templ])
            context.control_code += (
                "build_pipeline_count_{id}{launch}({params});\n".format(
                    id=self.hash_table_id, launch=context.kernel_launch, params=launch_params
                )
            )
            context.control_code += "int64_t BUILD_SIZE_{id}; cudaMemcpy(&BUILD_SIZE_{id}, d_JOIN_IDX_{id}, sizeof(int64_t), cudaMemcpyDeviceToHost);\n".format(
                id=self.hash_table_id
            )
            context.control_code += (
                "cudaMemset(d_JOIN_IDX_{}, 0, sizeof(int64_t));\n".format(
                    self.hash_table_id
                )
            )
            for rln in context.rid_dict:
                context.control_code += "cudaMalloc(d_JOIN_BUF_{id}_{rln}, sizeof(int64_t) * BUILD_SIZE_{id});\n".format(
                    id=self.hash_table_id, rln=rln
                )
            context.global_kernel_code += (
                context.kernel_code.replace(
                    "pipeline_{}".format(self.hash_table_id),
                    "build_pipeline_{}".format(self.hash_table_id),
                )
            )
            context.control_code += "build_pipeline_{id}{launch}({params});\n".format(
                id=self.hash_table_id, launch=context.kernel_launch, params=launch_params
            )
            context.global_control_code += (context.control_code)
            self.left_control_code += context.global_control_code
            self.left_kernel_code += context.global_kernel_code
        elif context.source == self.right:
            context.control_code += self.left_control_code
            context.global_control_code += self.left_control_code
            context.global_kernel_code += self.left_kernel_code
            res = prepare_keys(schema, self.right_keys, context, self.hash_table_id)
            if res == None:
                print("Unable to pack keys of hash join, ending code generation")
                return
            context.kernel_code += "auto slot_{id} = HT{id}_F.find(key_{id});\n".format(id = self.hash_table_id)
            context.kernel_code = context.kernel_code.replace(
                "<placeholder_{id}>".format(id=self.hash_table_id),
                ", ".join(
                    [
                        "int64_t* JOIN_BUF_{id}_{rln}".format(
                            id=self.hash_table_id, rln=rln
                        )
                        for rln in self.relations 
                    ]
                ),
            )
            for rln in self.relations:
                context.rid_dict[rln] = "JOIN_BUF_{id}_{rln}[slot_{id}->second]".format(id = self.hash_table_id, rln = rln)
            context.source = self
            self.parent.consume(context)
