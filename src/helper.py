from dataclasses import dataclass, field
from io import StringIO
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
        "o_shippriority": "int32_t",
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
    raise Exception("{} does not belong to any table in the schema".format(attr))


@dataclass
class Attribute:
    ty: str  # int8_t, int32_t, int64_t, double, char*
    val: str

    def __eq__(self, value):
        return self.ty == value.ty and self.val == value.val

    def __hash__(self):
        return hash(self.ty + self.val)
    def __lt__(self, value):
        return self.val < value.val


@dataclass
class Pipeline:
    id: int
    base_relation: str
    joined_relations: set[str] = field(default_factory=set)
    input_attributes: set[Attribute] = field(default_factory=set)
    output_attributes: set[Attribute] = field(default_factory=set)
    other_vars: set[Attribute] = field(default_factory=set)
    hash_tables: set[int] = field(default_factory=set)
    kernel_code: str = ""
    control_code: str = ""
    rid_dict: Dict[str, str] = field(default_factory=dict)
    register_attrs: Dict[str, str] = field(default_factory=dict)

def get_pipeline_kernel_code(pipeline: Pipeline):
    res = (prepare_template(pipeline))
    res += (
        "\n__global__ void pipeline_{pid} ({sig}) {{\n{code}}}\n".format(
            pid=pipeline.id,
            sig=prepare_signature(pipeline),
            code=pipeline.kernel_code,
        )
    )
    return res

def prepare_signature(pipeline: Pipeline):
    res = []
    for attr in pipeline.input_attributes:
        res.append("{ty}* {attr}".format(ty=attr.ty, attr=attr.val))
    for attr in pipeline.output_attributes:
        res.append("{ty}* {attr}".format(ty=attr.ty, attr=attr.val))
    for id in pipeline.hash_tables:
        res.append("TY_HT{id}_I HT{id}_I".format(id=id))
        res.append("TY_HT{id}_F HT{id}_F".format(id=id))
    for attr in pipeline.other_vars:
        res.append("{ty} {attr}".format(ty=attr.ty, attr=attr.val))
    return ", ".join(res)


def prepare_params(pipeline: Pipeline):
    res = []
    for attr in pipeline.input_attributes:
        res.append("d_{attr}".format(attr=attr.val))
    for attr in pipeline.output_attributes:
        res.append("d_{attr}".format(attr=attr.val))
    for id in pipeline.hash_tables:
        res.append("d_HT{id}_I".format(id=id))
        res.append("d_HT{id}_F".format(id=id))
    for attr in pipeline.other_vars:
        res.append("{attr}".format(attr=attr.val))

    return ", ".join(res)


def prepare_template(pipeline: Pipeline):
    res = []
    if len(pipeline.hash_tables) == 0: 
        return ""
    for id in pipeline.hash_tables:
        res.append("typename TY_HT{}_I".format(id))
        res.append("typename TY_HT{}_F".format(id))
    return "template <{}>".format(", ".join(res))


def id_gen():
    id = 0
    while True:
        yield id
        id += 1


def sizeof(ty: str):
    d = {"int8_t": 1, "int32_t": 4, "int64_t": 8, "double": 8}
    return d[ty]


def typeof(attr: str):
    return schema[RLN(attr)][attr]


def load_attr_to_register(attr: str, pipeline: Pipeline):
    if attr not in pipeline.register_attrs.keys():
        pipeline.kernel_code += "{ty} reg_{attr} = {attr}[{rid}];\n".format(
            ty=typeof(attr), attr=attr, rid=pipeline.rid_dict[RLN(attr)]
        )
        pipeline.register_attrs[attr] = "reg_" + attr
    return pipeline.register_attrs[attr]


def prepare_keys(operator_id: int, keys: List[str], pipeline: Pipeline):
        total_bytes = 0
        for key in keys:
            pipeline.input_attributes.add(Attribute(typeof(key), key))
            load_attr_to_register(key, pipeline)
        pipeline.kernel_code += "int64_t key{} = 0;\n".format(
            operator_id
        )  # register allocated key variable
        for key in keys:
            pipeline.kernel_code += (
                "key{id} |= (((int64_t){attr}) << {shift});\n".format(
                    id=operator_id,
                    attr=load_attr_to_register(key, pipeline),
                    shift=8 * total_bytes,
                )
            )
            total_bytes += sizeof(typeof(key))


@dataclass
class Context:
    source: any = None
    pipeline: Pipeline = None


@dataclass
class Aggregate:
    alias: str = ""
    function: str = ""  # sum, min, max, avg


pipeline_id = id_gen()
operator_id = id_gen()



