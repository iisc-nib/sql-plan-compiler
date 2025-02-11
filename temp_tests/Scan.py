from helper import RLN, Operator, hash_table_id, pipeline_id, allocated_state, load_to_register, schema, control_params


from typing import Dict, List
class Scan(Operator):
    def __init__(self, relation: str):
        self.relation = relation

    def produce(self, context):
        global pipeline_id
        context.pipeline_id = pipeline_id
        pipeline_id += 1
        context.relation = self.relation
        context.kernel_launch = "<<<std::ceil((float){}_size/(float)32), 32>>>".format(
            self.relation
        )

        # assert: attributes contained in context.pipeline_params only belong to self.relation
        pargs = ["size_t {}_size".format(self.relation)]
        template_args = []
        global allocated_state
        new_pipeline_params = []
        for param in context.pipeline_params:
            if RLN(param) != None:
                if schema[RLN(param)][param] + "* " + param not in pargs: 
                    pargs.append(schema[RLN(param)][param] + "* " + param)
                    new_pipeline_params.append(param)
                if param not in allocated_state and RLN(param) == self.relation:
                    context.control_code += "{ty}* d_{param};\n".format(ty = schema[RLN(param)][param], param = param)
                    context.control_code += "cudaMalloc(&d_{param}, {rln}_size * sizeof({ty}));\ncudaMemcpy(d_{param}, {param}, {rln}_size * sizeof({ty}), cudaMemcpyHostToDevice);\n".format(
                        param=param, rln=self.relation, ty=schema[RLN(param)][param]
                    )
                    allocated_state.add(param)
                    control_params[param] = schema[RLN(param)][param]+"*"
                    if self.relation + "_size" not in control_params.keys():
                        control_params[self.relation + "_size"] = "size_t"
            elif param.startswith("HT"):
                template_args.append("typename MAP_" + param)
                if "MAP_" + param + " " + param not in pargs:
                    pargs.append("MAP_" + param + " " + param)
                    new_pipeline_params.append(param)
                ht = param.split("_")[0]
                if ht not in allocated_state:
                    context.control_code += """auto {ht} = cuco::static_map{{ {est_size} * 2,
cuco::empty_key{{(int64_t)-1}},
cuco::empty_value{{(int64_t)-1}},
thrust::equal_to<int64_t>{{}},
cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()}};\n""".format(
                        ht=ht, est_size="---est_size---"
                    )
                    allocated_state.add(ht)
                if param not in allocated_state:
                    if param.split("_")[1] == "I":
                        context.control_code += (
                            "auto d_{param} = {ht}.ref(cuco::insert);\n".format(
                                param=param, ht=ht
                            )
                        )
                    elif param.split("_")[1] == "F":
                        context.control_code += (
                            "auto d_{param} = {ht}.ref(cuco::find);\n".format(
                                param=param, ht=ht
                            )
                        )
                    allocated_state.add(param)
            else:
                if param not in pargs:
                    pargs.append(param)  # for normal index type of variables
                    new_pipeline_params.append(param)
        context.pipeline_params = new_pipeline_params
        context.kernel_code += "template<" + ", ".join(template_args) + ">\n"
        context.kernel_code += "__global__ void pipeline_{pid}({pargs}) {{\n".format(
            pid=context.pipeline_id, pargs=", ".join(pargs)
        )
        context.kernel_code += "auto tid = threadIdx.x + blockDim.x * blockIdx.x;\n"
        context.kernel_code += "if (tid >= {}_size) return;\n".format(self.relation)
        context.rid_dict[self.relation] = "tid"
        context.source = self
        self.parent.consume(
            context
        )  # if there is no parent for this, the graph is not constructed properly

    def consume(self, context):
        return