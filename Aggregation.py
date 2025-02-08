from helper import RLN, Operator, hash_table_id, load_to_register, schema


from typing import Dict, List


class Aggregation(Operator):
    def __init__(
        self,
        agg_table_name: str,
        child: Operator,
        agg_key: List[str],
        aggregation_map: Dict[str, str],
        alias_map: Dict[str, str],
    ):
        self.child = child
        child.parent = self
        self.agg_table_name = agg_table_name
        self.agg_keys = agg_key
        self.aggregation_map = aggregation_map
        self.alias_map = alias_map
        global hash_table_id
        self.hash_table_id = hash_table_id
        hash_table_id += 1

    def produce(self, context):
        schema[self.agg_table_name] = dict()
        for k in self.alias_map:
            ty = ""
            if k == "*":
                ty = "int64_t"
            else:
                ty = schema[RLN(k)][k]
            if k != "*":  # reserve * for count aggregations
                context.pipeline_params.append(k)
            schema[self.agg_table_name][self.alias_map[k]] = ty
            context.pipeline_params.append(self.alias_map[k])
        context.pipeline_params.append("HT{}_I".format(self.hash_table_id))
        context.pipeline_params.append("HT{}_F".format(self.hash_table_id))
        self.child.produce(context)
        schema[self.agg_table_name] = set()
        for k in self.alias_map:
            schema[self.agg_table_name].add(self.alias_map[k])

    def consume(self, context):
        key_types = [schema[RLN(attr)][attr] for attr in self.agg_keys]
        total_bytes = 0
        byte_map = {"int32_t": 4, "int64_t": 8, "int8_t": 1}
        # this for loop is just for checking if keys are packable in 64 bits (constraint of cuCollection)
        for ty in key_types:
            if ty not in ["int32_t", "int64_t", "int8_t"]:
                context.kernel_code += "Aggregation key is not packable, type {} is not hashable, exiting the loop".format(
                    ty
                )
                return
            total_bytes += byte_map[ty]
            if total_bytes > 8:
                context.kernel_code += (
                    "Aggregation key is not packable, total key bytes exceeds 8 bytes"
                )
                return

        key_text = "int64_t agg_key_{} = 0;\n".format(self.hash_table_id)
        total_bytes = 0
        print(context)
        for attr in self.alias_map:
            if attr != "*":  # reserve * only for count
                load_to_register(attr, context)
        for attr in self.agg_keys:
            # bring things into register if not already there
            key_text += "agg_key_{id} |= (((int64_t){reg_attr}) << {shift});\n".format(
                id=self.hash_table_id,
                reg_attr=context.attr_reg_dict[attr],
                shift=8 * total_bytes,
            )
            total_bytes += byte_map[schema[RLN(attr)][attr]]
        context.kernel_code += key_text
        gather_code = context.kernel_code
        gather_code += (
            "auto this_thread = cg::tiled_partition<1>(cg::this_thread_block());\n"
        )
        gather_code += (
            "HT{id}_I.insert(this_thread, cuco::pair{{agg_key_{id}, 1}});\n}}".format(
                id=self.hash_table_id
            )
        ) # end the gather pipeline
        gather_code = gather_code.replace(
            "pipeline_{}".format(context.pipeline_id),
            "gather_pipeline_{}".format(context.pipeline_id),
        )
        for attr, alias in self.alias_map.items():
            ty = ""
            if attr == "*":
                ty = "int64_t"
            else:
                ty = schema[RLN(attr)][attr]

            context.control_code += """
{ty}* d_{alias};\n""".format(
                ty=ty, alias=alias
            )
        launch_param = ["{}_size".format(context.relation)]
        launch_param.extend(["d_" + attr for attr in context.pipeline_params])
        control_params = ", ".join(launch_param)
        context.control_code += "gather_pipeline_{id}{launch}({params});\nauto HT{id}_size = HT{id}.size();\n".format(
            id=self.hash_table_id, launch=context.kernel_launch, params=control_params
        )
        for attr, alias in self.alias_map.items():
            ty = ""
            if attr == "*":
                ty = "int64_t"
            else:
                ty = schema[RLN(attr)][attr]

            context.control_code += """
{ty}* {alias} = ({ty}*)malloc(sizeof({ty}) * HT{id}_size);
cudaMalloc(&d_{alias}, sizeof({ty}) * HT{id}_size);
cudaMemset(d_{alias}, 0, sizeof({ty}) * HT{id}_size);\n""".format(
                ty=ty, alias=alias, id=self.hash_table_id
            )

        print(gather_code)
        # TODO: add control code for making sequential buffer
        context.control_code += """
thrust::device_vector<int64_t> keys_{id}(HT{id}_size), vals_{id}(HT{id}_size);
HT{id}.retrieve_all(keys_{id}.begin(), vals_{id}.begin());
thrust::host_vector<int64_t> h_keys_{id}(HT{id}_size);
thrust::copy(keys_{id}.begin(), keys_{id}.end(), h_keys_{id}.begin());
thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_{id}(HT{id}_size);
for (int i=0; i < HT{id}_size; i++) {{
	actual_dict_{id}[i] = cuco::make_pair(h_keys_{id}[i], i);
}}
HT{id}.clear();
HT{id}.insert(actual_dict_{id}.begin(), actual_dict_{id}.end());\n""".format(
            id=self.hash_table_id
        )
        # TODO: rename pipeline function name for each print statement here
        agg_code = context.kernel_code
        agg_code += "auto slot = HT{id}_F.find(agg_key_{id});\n".format(
            id=self.hash_table_id
        )
        atomicAggMap = {
            "sum": "atomicAdd",
            "avg": "atomicAvg",
            "min": "atomicMin",
            "max": "atomicMax",
        }
        for k in self.aggregation_map:
            if self.aggregation_map[k] == "any":
                agg_code += "{alias}[slot->second] = {attr};\n".format(
                    alias=self.alias_map[k], attr=context.attr_reg_dict[k]
                )
            elif self.aggregation_map[k] == "count":
                agg_code += "atomicAdd(&({alias}[slot->second]), 1);\n".format(
                    alias=self.alias_map[k]
                )
            else:
                agg_code += "{fn}(&({alias}[slot->second]), {attr});\n".format(
                    fn=atomicAggMap[self.aggregation_map[k]],
                    alias=self.alias_map[k],
                    attr=context.attr_reg_dict[k],
                )
        agg_code += "}" # end the pipeline
        agg_code = agg_code.replace(
            "pipeline_{}".format(context.pipeline_id),
            "aggregate_pipeline_{}".format(context.pipeline_id),
        )
        print(agg_code)
        context.control_code += "aggregate_pipeline_{id}{launch}({params});\n".format(
            id=self.hash_table_id, launch=context.kernel_launch, params=control_params
        )
        for attr, alias in self.alias_map.items():
            ty = ""
            if attr == "*":
                ty = "int64_t"
            else:
                ty = schema[RLN(attr)][attr]
            context.control_code += "cudaMemcpy({alias}, d_{alias}, sizeof({ty}) * HT{id}_size, cudaMemcpyDeviceToHost);\n".format(
                ty=ty, alias=alias, id=self.hash_table_id
            )
        print(context.control_code)