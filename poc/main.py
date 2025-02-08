from dataclasses import dataclass
from typing import Dict, List


@dataclass
class ParamsType:
    hash_tables: List[str]
    hash_table_types: List[str]
    attributes: List[str]


schema = {
    "nation": {"n_nationkey", "n_name", "n_regionkey", "n_comment"},
    "supplier": {
        "s_suppkey",
        "s_nationkey",
        "s_name",
        "s_address",
        "s_phone",
        "s_acctbal",
        "s_comment",
    },
    "partsupplier": {
        "ps_suppkey",
        "ps_partkey",
        "ps_avialqty",
        "ps_supplycost",
        "ps_comment",
    },
    "part": {
        "p_partkey",
        "p_name",
        "p_mfgr",
        "p_brand",
        "p_type",
        "p_size",
        "p_container",
        "p_retailprice",
        "p_comment",
    },
    "lineitem": {
        "l_orderkey",
        "l_partkey",
        "l_suppkey",
        "l_linenumber",
        "l_quantity",
        "l_extendedprice",
        "l_discount",
        "l_tax",
        "l_returnflag",
        "l_linestatus",
        "l_shipdate",
        "l_commitdate",
        "l_receiptdate",
        "l_shipinstruct",
        "l_shipmode",
        "l_comment",
    },
    "orders": {
        "o_orderkey",
        "o_orderstatus",
        "o_custkey",
        "o_totalprice",
        "o_orderdate",
        "o_orderpriority",
        "o_clerk",
        "o_shippriority",
        "o_comment",
    },
    "customer": {
        "c_custkey",
        "c_name",
        "c_address",
        "c_nationkey",
        "c_phone",
        "c_acctbal",
        "c_mktsegment",
        "c_comment",
    },
}

hashtable_id = 0
kernel_id = 0


class Operator:
    def produce(self, params: ParamsType = ParamsType([], [], [])):
        """Method to produce data."""
        raise NotImplementedError("Subclasses should implement this method.")

    def consume(
        self, attributes: set, operator, oid_buffers: set = {}, lookup: str = ""
    ):
        """Method to consume data."""
        raise NotImplementedError("Subclasses should implement this method.")


class Materialize(Operator):
    def __init__(self, child: Operator):
        self.child = child
        child.parent = self

    def produce(self, params: ParamsType = ParamsType([], [], [])):
        self.child.produce(params)

    def consume(self, attributes, operator, oid_buffers: set = {}, lookup: str = ""):
        print("materialize ", attributes)


class HashJoin(Operator):
    def __init__(
        self,
        build: Operator,
        probe: Operator,
        left_join_attr: List[str],
        right_join_attr: List[str],
    ):
        global hashtable_id
        self.build = build
        self.probe = probe
        self.left_join_attr = left_join_attr
        self.right_join_attr = right_join_attr
        self.additional_attributes: set = {}
        self.hash_table_id = hashtable_id
        self.oid_buffers_content: set = set()
        hashtable_id += 1
        build.parent = self
        probe.parent = self

    def produce(self, params: ParamsType = ParamsType([], [], [])):
        self.build.produce(
            ParamsType(
                ["hash_table_{}".format(self.hash_table_id), *params.hash_tables],
                ["InsertMap{}".format(self.hash_table_id), *params.hash_table_types],
                [*self.left_join_attr, *params.attributes],
            )
        )
        self.probe.produce(
            ParamsType(
                ["hash_table_{}".format(self.hash_table_id), *params.hash_tables],
                ["FindMap{}".format(self.hash_table_id), *params.hash_table_types],
                [*self.right_join_attr, *params.attributes],
            )
        )

    def consume(
        self,
        attributes: set,
        operator: Operator,
        oid_buffers_content: set = set(),
        lookup: str = "",
    ):
        if operator == self.build:
            print(
                "reg_buffer_idx_{} = atomicAdd(buffer_idx_{}, 1);".format(
                    self.hash_table_id, self.hash_table_id
                )
            )
            print(
                "hash_table_{}.insert(pair({}, reg_buffer_idx_{}));".format(
                    self.hash_table_id,
                    ["reg_{}".format(item) for item in self.left_join_attr],
                    self.hash_table_id,
                )
            )
            buffer_tuple = ""
            if len(oid_buffers_content) == 0:
                buffer_tuple = "tid"
            else:
                print("oid_buffers_content: ", oid_buffers_content)
                buffer_tuple = ", ".join(
                    [
                        "buffer{lid}[lookup_{lid}->second][{idx}]".format(
                            lid=lookup, idx=idx
                        )
                        for idx, item in enumerate(oid_buffers_content)
                    ]
                )
                buffer_tuple += ", tid"
            print(
                "buffer_{hid}[reg_buffer_idx_{hid}] = <{bt}>".format(
                    hid=self.hash_table_id, bt=buffer_tuple
                )
            )
            self.oid_buffers_content = oid_buffers_content
            self.oid_buffers_content.add(str(self.left_join_attr))
            self.additional_attributes = attributes
        else:
            print(
                "lookup_{} = hash_table_{}.find({});".format(
                    self.hash_table_id,
                    self.hash_table_id,
                    ["reg_{}".format(item) for item in self.right_join_attr],
                )
            )
            print("if (lookup_{} != empty)".format(self.hash_table_id), "{")
            
            self.parent.consume(
                attributes.union(self.additional_attributes),
                self,
                self.oid_buffers_content,
                self.hash_table_id,
            )
            print("}")


class Scan(Operator):
    def __init__(self, relation):
        self.relation = relation

    def produce(self, params: ParamsType = ParamsType([], [], [])):
        template_map = "<"
        for i in range(len(params.hash_table_types)):
            template_map += "typename " + params.hash_table_types[i]
            if i + 1 == len(params.hash_table_types):
                template_map += ">"
            else:
                template_map += ", "

        kernel_args = "("
        for i in range(len(params.hash_tables)):
            kernel_args += (
                params.hash_table_types[i] + " " + params.hash_tables[i] + ", "
            )
        filtered_params = []
        for p in params.attributes:
            if p in schema[self.relation]:
                filtered_params.append(p)
        for i in range(len(filtered_params)):
            kernel_args += filtered_params[i]
            if i + 1 < len(filtered_params):
                kernel_args += ", "
        kernel_args += ")"
        global kernel_id
        print(template_map)
        print("__global__ void kernel_{}{}".format(kernel_id, kernel_args), "{")
        print("int tid = blockIdx.x * blockDim.x + threadIdx.x;")
        register_attrs: set = set()
        for p in filtered_params:
            variable = "reg_{}".format(p)
            print("{} = {}[tid];".format(variable, p))
            register_attrs.add(variable)
        kernel_id += 1
        self.parent.consume(register_attrs, self)
        print("}")


class Selection(Operator):
    def __init__(self, predicate, child: Operator):
        self.predicate = predicate
        self.child = child
        child.parent = self

    def produce(self, params: ParamsType = ParamsType([], [], [])):
        self.child.produce(params)

    def consume(
        self,
        attributes: set,
        operator: Operator,
        oid_buffers: set = {},
        lookup: str = "",
    ):
        print("if ({})".format(self.predicate), "{")
        self.parent.consume(attributes, self)
        print("}")


class Aggregation(Operator):
    def __init__(self, child: Operator, keys: List[str], aggregates: Dict[str, str]):
        global hashtable_id
        self.keys = keys
        self.aggregates = aggregates
        self.child = child
        self.hash_table_id = hashtable_id
        hashtable_id += 1
        child.parent = self

    def produce(self, params: ParamsType = ParamsType([], [], [])):
        attrs = []
        for k in self.keys:
            attrs.append(k)
        for k in self.aggregates:
            attrs.append(k)
        self.child.produce(
            ParamsType(
                ["hash_table_{}".format(self.hash_table_id), *params.hash_tables],
                ["InsertAndFindMap{}".format(self.hash_table_id), *params.hash_table_types],
                attributes=[*attrs, *params.attributes],
            )
        )

    def consume(
        self,
        attributes: set,
        operator: Operator,
        oid_buffers: set = {},
        lookup: str = "",
    ):
        print("l = hash_table_{}.find_and_update({}, {})".format(self.hash_table_id, 
                                                                self.keys,
                                                                self.aggregates))
        attrs = []
        for k in self.keys:
            attrs.append(k)
        for k in self.aggregates:
            attrs.append(k)
        self.parent.consume(attrs, self)


if __name__ == "__main__":
    # gb = {"l_quantity": "sum"}
    l = HashJoin(
        Scan("orders"),
        HashJoin(
            Selection("p_name like \%green\%", Scan("part")),
            Scan("lineitem"),
            ["p_partkey"],
            ["l_partkey"],
        ),
        ["o_orderkey"],
        ["l_orderkey"],
    )
    # r = HashJoin(
    #     HashJoin(Scan("nation"), Scan("supplier"), ["n_nationkey"], ["s_nationkey"]),
    #     Scan("partsupplier"),
    #     ["s_suppkey"],
    #     ["ps_suppkey"],
    # )
    test = HashJoin(l, Scan("partsupplier"), ["l_suppkey", "l_partkey"], ["ps_suppkey", "ps_partkey"])
    op = Materialize(test)
    op.produce()

    # test for q3 in tpch
    # t1 = HashJoin(
    #     Selection("reg_c_mktsegment = BUILDING", Scan("customer")),
    #     Selection("reg_o_orderdate < 1995-03-15", Scan("orders")),
    #     ["c_custkey"],
    #     ["o_custkey"],
    # )
    # t2 = Selection("reg_l_shipdate > 1995-03-15", Scan("lineitem"))
    # j = HashJoin(t1, t2, ["o_orderkey"], ["l_orderkey"])
    # q3 = Materialize(
    #     Aggregation(
    #         j,
    #         ["l_orderkey"],
    #         {"l_extendedprice": "sum", "o_orderdate": "any", "o_shippriority": "any"},
    #     )
    # )
    # q3.produce()
    
