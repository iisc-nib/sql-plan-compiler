from Operator import Operator
from helper import (
    RLN,
    Aggregate,
    Attribute,
    Context,
    Pipeline,
    allocate_and_initialize,
    get_pipeline_kernel_code,
    load_attr_to_register,
    operator_id,
    pipeline_id,
    prepare_keys,
    prepare_params,
    prepare_signature,
    prepare_template,
    schema,
    sizeof,
    typeof,
)


import copy
from typing import Dict, List


class HashJoin(Operator):
    def __init__(
        self,
        left_keys: List[str],
        right_keys: List[str],
        left_child: Operator,
        right_child: Operator,
    ):
        self.left_child = left_child
        self.right_child = right_child
        self.left_keys = left_keys
        self.right_keys = right_keys
        left_child.parent = self
        right_child.parent = self
        self.id = next(operator_id)
        self.build_count_pipeline: Pipeline = None
        self.build_pipeline: Pipeline = None

    def produce(self, context):
        self.left_child.produce(
            copy.deepcopy(context)
        )  # context is different for build and probe side
        self.right_child.produce(context)

    def consume(self, context):
        if context.source == self.left_child:
            """
            Generate code for the build side
            1. Prepare key
            2. Increment buffer_index
            3. Insert {key, buffer_index} into hash table
            4. Insert RIDs of joined relations into buffer
            5. End the pipeline
            """
            # 1 prepare keys
            prepare_keys(self.id, self.left_keys, context.pipeline)

            # 2 Increment buffer index
            context.pipeline.other_vars.add(
                Attribute("int64_t*", "B{}_idx".format(self.id))
            )
            for key in self.left_keys:
                context.pipeline.input_attributes.add(Attribute(ty=typeof(key), val=key))
            for key in self.right_keys:
                context.pipeline.input_attributes.add(Attribute(ty=typeof(key), val=key))        
            # fork the pipeline , one for count, the other for insert
            self.build_count_pipeline = copy.deepcopy(context.pipeline)
            self.build_count_pipeline.id = next(pipeline_id)
            self.build_pipeline = context.pipeline

            self.build_count_pipeline.kernel_code += (
                "atomicAdd((int*)B{}_idx, 1);\n".format(self.id)
            )
            # end the count pipeline

            self.build_pipeline.hash_tables.add(self.id)
            self.build_pipeline.kernel_code += (
                "auto reg_B{id}_idx = atomicAdd((int*)B{id}_idx, 1);\n".format(
                    id=self.id
                )
            )

            # 3 Insert key, idx to hash table
            self.build_pipeline.kernel_code += "auto thread = cg::tiled_partition<1>(cg::this_thread_block());\n"  # reg alloc
            self.build_pipeline.kernel_code += "HT{id}_I.insert(thread, cuco::pair{{key{id}, reg_B{id}_idx}});\n".format(
                id=self.id
            )

            # 4 Insert RIDs of joined relations into buffer
            for rln in self.build_pipeline.joined_relations:
                self.build_pipeline.other_vars.add(
                    Attribute("int64_t*", "B{id}_{rln}".format(id=self.id, rln=rln))
                )
                self.build_pipeline.kernel_code += (
                    "B{id}_{rln}[reg_B{id}_idx] = {rid};\n".format(
                        id=self.id, rln=rln, rid=self.build_pipeline.rid_dict[rln]
                    )
                )

            # 5 End the pipelie
        else:
            """
            For probe side
            1. Prepare key
            2. Probe into hash table using this key
            3. Lookup the buffers by hash_table slot value and add it to rid dictionary
            """
            # 1
            context.pipeline.hash_tables.add(self.id)
            prepare_keys(self.id, self.right_keys, context.pipeline)

            # 2
            context.pipeline.kernel_code += (
                "auto slot{id} = HT{id}_F.find(key{id});\n".format(id=self.id)
            )
            context.pipeline.kernel_code += "if (slot{id} == HT{id}_F.end()) return;\n".format(id = self.id)

            # 3
            for rln in self.build_pipeline.joined_relations:
                context.pipeline.joined_relations.add(rln)
                context.pipeline.rid_dict[rln] = "B{id}_{rln}[slot{id}->second]".format(id = self.id, rln=rln)
                context.pipeline.other_vars.add(
                    Attribute("int64_t*", "B{id}_{rln}".format(id=self.id, rln=rln))
                )
            context.source = self
            self.parent.consume(context)

    def print(self):
        self.left_child.print()
        print(get_pipeline_kernel_code(self.build_count_pipeline))
        print(get_pipeline_kernel_code(self.build_pipeline))
        self.right_child.print()
    def print_control(self, allocated_attrs: set[Attribute]):
        self.left_child.print_control(allocated_attrs)
        #1 declare input and output buffers
        # TODO: for input attributes store some global state so that repeated allocations do not happen
        
        # 1
        # declare input and output buffers
        allocate_and_initialize(allocated_attrs, self.build_pipeline)
        for attr in self.build_pipeline.output_attributes:
            if attr not in allocated_attrs:
                print("{ty}* d_{attr};\n".format(ty=attr.ty, attr=attr.val))
                allocated_attrs.add(attr)
            
        
        for rln in self.build_pipeline.joined_relations:
            print("int64_t* B{id}_{rln};".format(id = self.id, rln = rln))
        print("int64_t* B{id}_idx;".format(id=self.id))
        print("cudaMalloc(&B{id}_idx, sizeof(int64_t));".format(id=self.id))
        print("cudaMemset(B{id}_idx, 0, sizeof(int64_t));".format(id=self.id))
        
        #2 launch the pipeline
        print(
            "pipeline_{pid}<<<std::ceil((float){rln}_size/(float)32), 32>>>({args});\n".format(
                pid=self.build_count_pipeline.id,
                rln=self.build_count_pipeline.base_relation,
                args=prepare_params(self.build_count_pipeline),
            )
        )
        #3 allocate output buffer and hash table
        print("int64_t h_B{id}_idx;".format(id=self.id))
        print("cudaMemcpy(&h_B{id}_idx, B{id}_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);".format(id=self.id))
        print("cudaMemset(B{id}_idx, 0, sizeof(int64_t));".format(id=self.id))
        for rln in self.build_count_pipeline.joined_relations:
            print("cudaMalloc(&B{id}_{rln}, sizeof(int64_t) * h_B{id}_idx);".format(id=self.id, rln=rln))
        print(
            "auto HT{id} = cuco::static_map{{ {est_size} * 2,cuco::empty_key{{(int64_t)-1}},cuco::empty_value{{(int64_t)-1}},thrust::equal_to<int64_t>{{}},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()}};\n".format(
                id=self.id, est_size="h_B{id}_idx".format(id=self.id)
            )
        )
        print("auto d_HT{id}_F = HT{id}.ref(cuco::find);\n".format(id=self.id))
        print("auto d_HT{id}_I = HT{id}.ref(cuco::insert);\n".format(id=self.id))
    
        #4 launch the build pipeline
        print(
            "pipeline_{pid}<<<std::ceil((float){rln}_size/(float)32), 32>>>({args});\n".format(
                pid=self.build_pipeline.id,
                rln=self.build_pipeline.base_relation,
                args=prepare_params(self.build_pipeline),
            )
        )       
        
        self.right_child.print_control(allocated_attrs)

    