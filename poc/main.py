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
}

hashtable_id = 0

class Operator:
    def produce(self):
        """Method to produce data."""
        raise NotImplementedError("Subclasses should implement this method.")

    def consume(self, attributes, operator):
        """Method to consume data."""
        raise NotImplementedError("Subclasses should implement this method.")


class Materialize(Operator):
    def __init__(self, child: Operator):
        self.child = child
        child.parent = self

    def produce(self):
        self.child.produce({"output": "buffer"})

    def consume(self, attributes, operator):
        print("materialize ", attributes)


class HashJoin(Operator):
    def __init__(
        self, build: Operator, probe: Operator, left_join_attr, right_join_attr
    ):
        global hashtable_id
        self.build = build
        self.probe = probe
        self.left_join_attr = left_join_attr
        self.right_join_attr = right_join_attr
        self.additional_attributes: set = {}
        self.hash_table_id = hashtable_id
        hashtable_id += 1
        build.parent = self
        probe.parent = self

    def produce(self):
        self.build.produce()
        self.probe.produce()

    def consume(self, attributes: set, operator: Operator):
        if operator == self.build:
            print(
                "materialize tuple {} in hash_table_{}".format(attributes, self.hash_table_id),
                "using key: ",
                self.left_join_attr,
            )
            self.additional_attributes = attributes
        else:
            print(
                "for each match {} in hash_table_{}".format(self.additional_attributes, self.hash_table_id),
                "[",
                self.right_join_attr,
                "] {",
            )
            self.parent.consume(attributes.union(self.additional_attributes), self)
            print("}")


class Scan(Operator):
    def __init__(self, relation):
        self.relation = relation

    def produce(self):
        print("for each tuple {} in relation - {}".format(schema[self.relation], self.relation), "{")
        self.parent.consume(schema[self.relation], self)
        print("}")


class Selection(Operator):
    def __init__(self, predicate, child: Operator):
        self.predicate = predicate
        self.child = child
        child.parent = self
    def produce(self):
        self.child.produce()
    def consume(self, attributes, operator):
        print("if ({})".format(self.predicate), "{")
        self.parent.consume(attributes, self)
        print("}")

if __name__ == "__main__":
    l = HashJoin(
        	HashJoin(
             Selection( "p_name like \%green\%", Scan("part")), Scan("lineitem"), "p_partkey", "l_partkey"),
			Scan("orders"),
			"l_orderkey", "o_orderkey"
         )
    r = HashJoin(
            HashJoin(Scan("nation"), Scan("supplier"), "n_nationkey", "s_nationkey"),
            Scan("partsupplier"),
            "s_suppkey",
            "ps_suppkey",
        )
    op = Materialize(HashJoin(l, r, ["l_suppkey", "l_partkey"], ["s_suppkey", "ps_partkey"]))
    op.produce()
