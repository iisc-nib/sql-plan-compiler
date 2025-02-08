import copy
from dataclasses import dataclass
from typing import Dict, List

schema = {
    "nation": {
        "n_nationkey": "int32_t",
        "n_name": "int8_t",
        "n_regionkey": "int32_t",
        "n_comment": "StringColumn",
    },
    "supplier": {
        "s_suppkey": "int32_t",
        "s_nationkey": "int32_t",
        "s_name": "StringColumn",
        "s_address": "StringColumn",
        "s_phone": "StringColumn",
        "s_acctbal": "double",
        "s_comment": "StringColumn",
    },
    "partsupplier": {
        "ps_suppkey": "int32_t",
        "ps_partkey": "int32_t",
        "ps_avialqty": "double",
        "ps_supplycost": "int32_t",
        "ps_comment": "StringColumn",
    },
    "part": {
        "p_partkey": "int32_t",
        "p_name": "StringColumn",
        "p_mfgr": "StringColumn",
        "p_brand": "StringColumn",
        "p_type": "int8_t",
        "p_size": "int32_t",
        "p_container": "int8_t",
        "p_retailprice": "double",
        "p_comment": "StringColumn",
    },
    "lineitem": {
        "l_orderkey": "int32_t",
        "l_partkey": "int32_t",
        "l_suppkey": "int32_t",
        "l_linenumber": "int64_t",
        "l_quantity": "int64_t",
        "l_extendedprice": "double",
        "l_discount": "double",
        "l_tax": "double",
        "l_returnflag": "int8_t",
        "l_linestatus": "int8_t",
        "l_shipdate": "int32_t",
        "l_commitdate": "int32_t",
        "l_receiptdate": "int32_t",
        "l_shipinstruct": "int8_t",
        "l_shipmode": "int8_t",
        "l_comment": "StringColumn",
    },
    "orders": {
        "o_orderkey": "int32_t",
        "o_orderstatus": "int8_t",
        "o_custkey": "int32_t",
        "o_totalprice": "double",
        "o_orderdate": "int32_t",
        "o_orderpriority": "int32_t",
        "o_clerk": "StringColumn",
        "o_shippriority": "int8_t",
        "o_comment": "StringColumn",
    },
    "customer": {
        "c_custkey": "int32_t",
        "c_name": "StringColumn",
        "c_address": "StringColumn",
        "c_nationkey": "int32_t",
        "c_phone": "StringColumn",
        "c_acctbal": "double",
        "c_mktsegment": "int8_t",
        "c_comment": "StringColumn",
    },
    "region": {
        "r_regionkey": "int32_t",
        "r_name": "StringColumn",
        "r_comment": "StringColumn",
    },
}


def RLN(attr: str):
    global schema
    for k, v in schema.items():
        if attr in v:
            return k
    return None


pipeline_id = 0
hash_table_id = 0


@dataclass
class Context:
    relations: set[str]
    rid_dict: Dict[str, str]
    source: any
    pipeline_params: List[str]
    attr_reg_dict: Dict[str, str]


class Operator:
    def produce(self, context: Context):
        """Method to produce data."""
        raise NotImplementedError("Subclasses should implement this method.")

    def consume(self, context: Context):
        """Method to consume data."""
        raise NotImplementedError("Subclasses should implement this method.")


class Scan(Operator):
    def __init__(self, relation: str):
        self.relation = relation

    def produce(self, context):
        context.relations.add(self.relation)
        global pipeline_id
        pargs = []
        template_args = []
        for param in context.pipeline_params:
            if RLN(param) != None:
                pargs.append(schema[RLN(param)][param] + "* " + param)
            elif param.startswith("HT"):
                template_args.append("typename MAP_" + param)
                pargs.append("MAP_" + param + " " + param)
            else:
                pargs.append(param)

        print("template<" + ", ".join(template_args) + ">")
        print(
            "__global__ void pipeline_{pid} ({pargs})".format(pid=pipeline_id, pargs=", ".join(pargs))
        )
        pipeline_id += 1
        print("{")
        print("int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;")
        rid_identifier = "tid"
        context.rid_dict[self.relation] = rid_identifier
        context.source = self
        self.parent.consume(context)
        print("}")

    def consume(self, context):
        return


def load_to_register(attribute: str, context: Context):
    if attribute not in context.attr_reg_dict.keys():
        print(
            "{attr_ty} reg_{attr} = {attr}[{attr_tid}];".format(
                attr_ty=schema[RLN(attribute)][attribute],
                attr=attribute,
                attr_tid=context.rid_dict[RLN(attribute)],
            )
        )
        context.attr_reg_dict[attribute] = "reg_" + attribute


class Selection(Operator):
    # TODO: make the predicate schema aware
    def __init__(self, child: Operator, attribute: str, predicate: str):
        self.predicate = predicate
        self.child = child
        child.parent = self
        self.attribute = attribute

    def produce(self, context):
        context.pipeline_params.append(self.attribute)
        self.child.produce(context)

    def consume(self, context):
        # lazily load the attributes into the register
        load_to_register(self.attribute, context)
        print(
            "if ({reg_attr} {pred})".format(
                reg_attr = context.attr_reg_dict[self.attribute],
                pred=self.predicate,
            ),
            "{",
        )
        context.source = self
        self.parent.consume(context)
        print("}")


class Aggregation(Operator):
    """
    Expecting alias map to have all the alias names for keys as well as aggregate columns
    since these must be unique the alias names must not match the original names
    """

    def __init__(
        self,
        agg_table_name: str,
        child: Operator,
        agg_keys: List[str],
        aggregation_map: Dict[str, str],
        alias_map: Dict[str, str],
    ):
        self.child = child
        self.agg_keys = agg_keys
        self.aggregation_map = aggregation_map
        self.alias_map = alias_map
        global hash_table_id
        self.hash_table_id = hash_table_id
        self.agg_table_name = agg_table_name
        hash_table_id += 1
        child.parent = self

    def produce(self, context):
        for k in self.alias_map:
            context.pipeline_params.append(k)
        context.pipeline_params.append("int* agg_idx_{}".format(self.hash_table_id))
        context.pipeline_params.append("HT{}_I".format(self.hash_table_id))
        context.pipeline_params.append("HT{}_F".format(self.hash_table_id))
        self.child.produce(context)
        schema[self.agg_table_name] = set()
        for k in self.alias_map:
            schema[self.agg_table_name].add(self.alias_map[k])

    def consume(self, context):
        # if key is a multiattribute, try to pack it in 64 bits
        # get type of each agg_key
        key_types = [schema[RLN(attr)][attr] for attr in self.agg_keys]
        total_bytes = 0
        byte_map = {
            "int32_t": 4,
            "int64_t": 8,
            "int8_t": 1
        }
        # this for loop is just for checking if keys are packable in 64 bits (constraint of cuCollection)
        for ty in key_types:
            if ty not in ["int32_t", "int64_t", "int8_t"]:
                print(
                    "Aggregation key is not packable, type {} is not hashable, exiting the loop".format(
                        ty
                    )
                )
                return
            total_bytes += byte_map[ty]
            if total_bytes > 8:
                print(
                    "Aggregation key is not packable, total key bytes exceeds 8 bytes"
                )
                return
        print("auto this_thread = cg::tiled_partition<1>(cg::this_thread_block());")
        key_text = "int64_t agg_key_{} = 0;\n".format(self.hash_table_id)
        total_bytes = 0
        for attr in self.alias_map:
            load_to_register(attr, context)
        for attr in self.agg_keys:
            # bring things into register if not already there
            key_text += "agg_key_{id} |= ({reg_attr} << {shift});\n".format(
                id=self.hash_table_id,
                reg_attr=context.attr_reg_dict[attr],
                shift=8 * total_bytes,
            )
            total_bytes += byte_map[schema[RLN(attr)][attr]]
        print(key_text)
        # insert and do the atomic aggregation

        print(
            "auto slot_{id} = HT{id}_F.find(agg_key_{id});".format(
                id=self.hash_table_id
            )
        )
        print("int64_t slot_val;")
        
        print("if (slot_{id} == HT{id}_F.end())".format(id=self.hash_table_id))
        print("{\n")
        # TODO: figure way to flow this agg_idx into pipeline params
        print("slot_val = atomicAdd(agg_idx_{id}, 1);".format(id=self.hash_table_id))
        print(
            "HT{id}_I.insert(this_thread, cuco::pair{{agg_key_{id}, slot_val}});".format(
                id=self.hash_table_id
            )
        )
        for attr, alias in self.alias_map.items():
            print("{alias}[slot_val] = {attr};".format(alias = alias, attr = context.attr_reg_dict[attr]))
        print("}\n")
        print("else {\n")
        print("slot_val = slot_{id}->second;".format(id=self.hash_table_id))
        atomicAggMap = {
            "sum": "atomicAdd"
        }
        for k in self.aggregation_map:
            if self.aggregation_map[k] != "any":
                print("{fn}(&({alias}[slot_val]), {attr});".format(fn = atomicAggMap[self.aggregation_map[k]],
                                                               alias = self.alias_map[k],
                                                               attr = context.attr_reg_dict[k]))
        print("}\n")
        

        # now conduct the actual search


class Materialize(Operator):
    parent: Operator = None

    def __init__(self, table_name: str, child: Operator, attributes: List[str]):
        self.child = child
        self.table_name = table_name
        self.attributes = attributes
        child.parent = self

    def produce(self, context):
        context.pipeline_params = [*context.pipeline_params, *self.attributes]
        # TODO: add this table also into the schema
        # also add the index variable in pipeline params
        self.child.produce(context)

    def consume(self, context):
        cols = " ".join(
            [
                "{attr}[{tid}]".format(attr=attr, tid=context.rid_dict[RLN(attr)])
                for attr in self.attributes
            ]
        )
        for attr in self.attributes:
            print(
                "{table}_{attr} = {attr}[{tid}];".format(
                    table=self.table_name, attr=attr, tid=context.rid_dict[RLN(attr)]
                )
            )


# def tpch_q2():
#     reg = Selection(Scan("region"), "r_name", "=EUROPE")
#     reg_nat = HashJoin(reg, Scan("nation"), ["r_regionkey"], ["n_regionkey"])
#     reg_nat_supp = HashJoin(reg_nat, Scan("supplier"), ["n_nationkey"], ["s_nationkey"])
#     reg_nat_supp_ps = HashJoin(
#         reg_nat_supp, Scan("partsupplier"), ["s_suppkey"], ["ps_suppkey"]
#     )
#     part = Selection(Selection(Scan("part"), "p_size", "=15"), "p_type", "like %BRASS")
#     part_reg_nat_supp_ps = HashJoin(
#         part, reg_nat_supp_ps, ["p_partkey"], ["ps_partkey"]
#     )
#     agg1 = Aggregation(
#         "agg_table_1",
#         part_reg_nat_supp_ps,
#         ["ps_partkey"],
#         {"ps_supplycost": "min", "p_partkey": "any", "p_mfgr": "any"},
#         {
#             "ps_supplycost": "min_ps_supplycost",
#             "p_partkey": "any_p_partkey",
#             "p_mfgr": "any_p_mfgr",
#             "ps_partkey": "aggr0_ps_partkey",
#         },
#     )
#     agg1.produce(Context(set(), {}, None, []))
#     r = HashJoin(
#         Scan("agg_table_1"),
#         Scan("partsupplier"),
#         ["min_ps_supplycost", "any_p_partkey"],
#         ["ps_supplycost", "ps_partkey"],
#     )
#     r1 = HashJoin(Scan("supplier"), r, ["s_suppkey"], ["ps_suppkey"])
#     op = Materialize(
#         "final_res",
#         HashJoin(reg_nat, r1, ["n_nationkey"], ["s_nationkey"]),
#         [
#             "s_acctbal",
#             "s_name",
#             "n_name",
#             "any_p_partkey",
#             "any_p_mfgr",
#             "s_address",
#             "s_phone",
#             "s_comment",
#         ],
#     )
#     op.produce(Context(set(), {}, None, []))


if __name__ == "__main__":
    """
    select * from
    part join lineitem on p_partkey = l_partkey
    where l_orderdate > 1995
    """
    sel = Selection(Scan("lineitem"), "l_shipdate", " > 1995")
    op = Aggregation(
        "agg_table",
        sel,
        ["l_returnflag", "l_linestatus"],
        {"l_quantity": "sum"},
        {
            "l_quantity": "sum_l_qty",
            "l_returnflag": "agg_l_returnflag",
            "l_linestatus": "agg_l_linestatus",
        },
    )
    op.produce(Context(set(), {}, None, [], {}))
    # tpch_q2()
