from Operator import Operator
from helper import RLN, Aggregate, Attribute, Context, Pipeline, allocate_and_initialize, get_pipeline_kernel_code, load_attr_to_register, operator_id, pipeline_id, prepare_keys, prepare_params, prepare_signature, prepare_template, schema, sizeof, typeof


import copy
from typing import Dict, List


class Materialize(Operator):
    def __init__(
        self,
        materialized_name: str,
        child: Operator,
        columns: List[str],
        aliases: List[str]
    ):
        self.child = child
        child.parent = self
        self.materialized_name = materialized_name
        self.keys = columns
        self.aliases = aliases
        self.count_pipeline: Pipeline = None
        self.agg_pipeline: Pipeline = None
        global operator_id
        self.id = next(operator_id)

    def produce(self, context: Context):
        self.child.produce(context)

    def consume(self, context: Context):
        # do a lookup in the hash table
        context.pipeline.other_vars.add(Attribute(ty="int64_t*", val = "d_mat_idx{id}".format(id = self.id)))
        self.agg_pipeline = copy.deepcopy(context.pipeline)
        self.agg_pipeline.id = next(pipeline_id)

        self.count_pipeline = context.pipeline
        self.count_pipeline.kernel_code += (
            "atomicAdd((int*)d_mat_idx{id}, 1);\n".format(id=self.id)
        )
        # end the count pipeline
        for i in range(self.count_pipeline.for_each_count):
                self.count_pipeline.kernel_code += "});\n"

        for key in self.keys:
            load_attr_to_register(key, self.agg_pipeline)
        self.agg_pipeline.kernel_code += "tmp_idx{id} = atomicAdd((int*)d_mat_idx{id}, 1);\n".format(id=self.id)
        for idx, key in enumerate(self.keys):
            self.agg_pipeline.input_attributes.add(Attribute(ty= typeof(key), val= key))
            self.agg_pipeline.kernel_code += (
                "{al}[tmp_idx{id}] = {attr};\n".format(
                    al=self.aliases[idx],
                    id=self.id,
                    attr=load_attr_to_register(key, self.agg_pipeline),
                )
            )
        # end the aggregation pipeline
        for i in range(self.agg_pipeline.for_each_count):
            self.agg_pipeline.kernel_code += "});\n"

        # add new attributes into the schema
        schema[self.materialized_name] = dict()
        for idx, alias in enumerate(self.aliases):
            schema[self.materialized_name][alias] = typeof(self.keys[idx])

        for alias in self.aliases:
            self.agg_pipeline.output_attributes.add(
                Attribute(typeof(alias), alias)
            )
        
        if hasattr(self, "parent") and self.parent != None:
            context.source = self
            self.parent.consume(context)

    def print(self):
        self.child.print()
        print(get_pipeline_kernel_code(self.count_pipeline))
        print(get_pipeline_kernel_code(self.agg_pipeline))

    def print_control(self, allocated_attrs: set[Attribute]):
        self.child.print_control(allocated_attrs)
        # prepare control code
        """
        1. Allocate all input buffers
        2. Create all hash tables
        3. Launch the count pipeline
        4. Allocate the output buffers
        5. Insert sequence as values in hash table
        6. Launch the aggregation pipeline
        """
        # 1
        # declare input and output buffers
        allocate_and_initialize(allocated_attrs, self.agg_pipeline)
        for attr in self.agg_pipeline.output_attributes:
            if attr not in allocated_attrs:
                print("{ty}* d_{attr};\n".format(ty=attr.ty, attr=attr.val))
                # allocated_attrs.add(attr)

        # 2
        # create the count variable
        print("int64_t* d_mat_idx{id};\ncudaMalloc(&d_mat_idx{id}, sizeof(int64_t));\n".format(id=self.id))
        print("cudaMemset(d_mat_idx{id}, 0, sizeof(int64_t));\n".format(id=self.id))
        # 3
        # launch count pipeline
        print(
            "pipeline_{pid}<<<std::ceil((float){rln}_size/(float)32), 32>>>({args});\n".format(
                pid=self.count_pipeline.id,
                rln=self.count_pipeline.base_relation,
                args=prepare_params(self.count_pipeline),
            )
        )

        # 4
        # allocate output buffers
        print("int64_t {}_size;\n".format(self.materialized_name))
        print("cudaMemcpy(&{mat}_size, d_mat_idx{id}, sizeof(int64_t), cudaMemcpyDeviceToHost);\n".format(mat = self.materialized_name, id = self.id))
        print("cudaMemset(d_mat_idx{id}, 0, sizeof(int64_t));\n".format(id=self.id))

        for attr in self.agg_pipeline.output_attributes:
            print(
                "cudaMalloc(&d_{attr}, sizeof({ty}) * {mat}_size);\n".format(
                    attr=attr.val,
                    ty=attr.ty,
                    mat = self.materialized_name
                )
            )
        # initialize them
        for attr in self.agg_pipeline.output_attributes:
            print(
                "cudaMemset(d_{attr}, 0, sizeof({ty}) * {mat}_size);\n".format(
                    attr=attr.val,
                    ty=attr.ty,
                    mat = self.materialized_name
                )
            )

        print(
            "pipeline_{pid}<<<std::ceil((float){rln}_size/(float)32), 32>>>({args});\n".format(
                pid=self.agg_pipeline.id,
                rln=self.agg_pipeline.base_relation,
                args=prepare_params(self.agg_pipeline),
            )
        )
        
        # 7 
        # store the size in variable for further use