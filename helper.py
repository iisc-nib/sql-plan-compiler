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

allocated_state: set = set()


@dataclass
class Context:
    relation: str
    rid_dict: Dict[str, str]
    source: any
    pipeline_params: List[str]
    attr_reg_dict: Dict[str, str]
    control_code: str
    kernel_code: str
    pipeline_id: int
    kernel_launch: str


def RLN(attr: str):
    global schema
    for k, v in schema.items():
        if attr in v:
            return k
    return None


def load_to_register(attribute: str, context: Context):
    if attribute not in context.attr_reg_dict.keys():
        context.kernel_code += "{attr_ty} reg_{attr} = {attr}[{attr_tid}];\n".format(
            attr_ty=schema[RLN(attribute)][attribute],
            attr=attribute,
            attr_tid=context.rid_dict[RLN(attribute)],
        )
        context.attr_reg_dict[attribute] = "reg_" + attribute


pipeline_id = 0
hash_table_id = 0

class Operator:
    def produce(self, context: Context):
        """Method to produce data."""
        raise NotImplementedError("Subclasses should implement this method.")

    def consume(self, context: Context):
        """Method to consume data."""
        raise NotImplementedError("Subclasses should implement this method.")
