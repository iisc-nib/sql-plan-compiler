from Operator import Operator
from helper import RLN, Aggregate, Attribute, Context, Pipeline, get_pipeline_kernel_code, load_attr_to_register, operator_id, pipeline_id, prepare_keys, prepare_params, prepare_signature, prepare_template, schema, sizeof, typeof


import copy
from typing import Dict, List


class Aggregation(Operator):
    def __init__(
        self,
        materialized_name: str,
        child: Operator,
        keys: List[str],
        agg_map: Dict[str, Aggregate],
    ):
        self.child = child
        child.parent = self
        self.materialized_name = materialized_name
        self.keys = keys
        self.agg_map = agg_map
        self.count_pipeline: Pipeline = None
        self.agg_pipeline: Pipeline = None
        global operator_id
        self.id = next(operator_id)

    def produce(self, context: Context):
        self.child.produce(context)

    def consume(self, context: Context):
        # do a lookup in the hash table
        context.pipeline.hash_tables.add(self.id)
        prepare_keys(self.id, self.keys, context.pipeline)

        # from here we want to fork and add 2 pipelines
        self.agg_pipeline = copy.deepcopy(context.pipeline)
        self.agg_pipeline.id = next(pipeline_id)

        self.count_pipeline = context.pipeline
        self.count_pipeline.kernel_code += "auto thread = cg::tiled_partition<1>(cg::this_thread_block());\n"  # reg alloc
        self.count_pipeline.kernel_code += (
            "HT{id}_I.insert(thread, cuco::pair{{key{id}, 1}});\n".format(id=self.id)
        )

        self.agg_pipeline.kernel_code += (
            "auto slot{id} = HT{id}_F.find(key{id});\n".format(id=self.id)
        )  # another reg alloc
        for key, val in self.agg_map.items():
            load_attr_to_register(key, self.agg_pipeline)
        for key, val in self.agg_map.items():
            if val.function == "any":
                self.agg_pipeline.kernel_code += (
                    "{al}[slot{id}->second] = {attr};\n".format(
                        al=val.alias,
                        id=self.id,
                        attr=load_attr_to_register(key, self.agg_pipeline),
                    )
                )
            elif val.function == "count":
                self.agg_pipeline.kernel_code += (
                    "aggregate_sum(&({al}[slot{id}->second]), 1);\n".format(
                        al=val.alias, id=self.id
                    )
                )
            else:
                self.agg_pipeline.kernel_code += (
                    "aggregate_{fn}(&({al}[slot{id}->second]), {val});\n".format(
                        fn=val.function,
                        al=val.alias,
                        id=self.id,
                        val=load_attr_to_register(key, self.agg_pipeline),
                    )
                )

        # add new attributes into the schema
        schema[self.materialized_name] = dict()
        for k, v in self.agg_map.items():
            ty = ""
            if v.function == "count":
                ty = "int64_t"
            else:
                ty = typeof(k)
            schema[self.materialized_name][v.alias] = ty

        for k, val in self.agg_map.items():
            if RLN(k) != "additional":
                self.agg_pipeline.input_attributes.add(
                    Attribute(typeof(k), k)
                )
            self.agg_pipeline.output_attributes.add(
                Attribute(typeof(val.alias), val.alias)
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
        for attr in self.agg_pipeline.input_attributes:
            if attr not in allocated_attrs:
                print("{ty}* d_{attr};\n".format(ty=attr.ty, attr=attr.val))
                print(
                    "cudaMalloc(&d_{attr}, sizeof({ty}) * {rln}_size);\n".format(
                        attr=attr.val, ty=attr.ty, rln=RLN(attr.val)
                    )
                )
                print(
                    "cudaMemcpy(d_{attr}, {attr}, sizeof({ty}) * {rln}_size, cudaMemcpyHostToDevice);\n".format(
                        attr=attr.val, ty=attr.ty, rln=RLN(attr.val)
                    )
                )
                allocated_attrs.add(attr)
        for attr in self.agg_pipeline.output_attributes:
            if attr not in allocated_attrs:
                print("{ty}* d_{attr};\n".format(ty=attr.ty, attr=attr.val))
                # allocated_attrs.add(attr)

        # 2
        # create the hash table
        print(
            "auto HT{id} = cuco::static_map{{ {est_size} * 2,cuco::empty_key{{(int64_t)-1}},cuco::empty_value{{(int64_t)-1}},thrust::equal_to<int64_t>{{}},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()}};\n".format(
                id=self.id, est_size=self.agg_pipeline.base_relation + "_size"
            )
        )
        print("auto d_HT{id}_F = HT{id}.ref(cuco::find);\n".format(id=self.id))
        print("auto d_HT{id}_I = HT{id}.ref(cuco::insert);\n".format(id=self.id))
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
        print("auto HT{id}_size = HT{id}.size();\n".format(id=self.id))
        for attr in self.agg_pipeline.output_attributes:
            print(
                "cudaMalloc(&d_{attr}, sizeof({ty}) * HT{id}_size);\n".format(
                    attr=attr.val,
                    ty=attr.ty,
                    id=self.id,
                )
            )
        # initialize them
        for attr in self.agg_pipeline.output_attributes:
            print(
                "cudaMemset(d_{attr}, 0, sizeof({ty}) * HT{id}_size);\n".format(
                    attr=attr.val,
                    ty=attr.ty,
                    id=self.id,
                )
            )

        # 5
        # insert sequence as values in hash table
        print(
            "thrust::device_vector<int64_t> keys_{id}(HT{id}_size), vals_{id}(HT{id}_size);\nHT{id}.retrieve_all(keys_{id}.begin(), vals_{id}.begin());\nthrust::host_vector<int64_t> h_keys_{id}(HT{id}_size);\nthrust::copy(keys_{id}.begin(), keys_{id}.end(), h_keys_{id}.begin());\nthrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_{id}(HT{id}_size);\nfor (int i=0; i < HT{id}_size; i++) {{\nactual_dict_{id}[i] = cuco::make_pair(h_keys_{id}[i], i);\n}}\nHT{id}.clear();\nHT{id}.insert(actual_dict_{id}.begin(), actual_dict_{id}.end());".format(
                id=self.id
            )
        )

        # 6
        # launch aggregation pipeline
        print(
            "pipeline_{pid}<<<std::ceil((float){rln}_size/(float)32), 32>>>({args});\n".format(
                pid=self.agg_pipeline.id,
                rln=self.agg_pipeline.base_relation,
                args=prepare_params(self.agg_pipeline),
            )
        )