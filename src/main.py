from Aggregation import Aggregation
from HashJoinMultimap import HashJoinMultimap
from Map import BinOp, Map, Var
from Materialize import Materialize
from Print import Print
from Scan import Scan
from HashJoin import HashJoin
from Selection import Selection
from helper import Aggregate, Context, typeof
from Operator import print_plan

import pyarrow as pa
from datetime import date


def get_date(dt: str):
    sp = [int(a) for a in dt.split("-")]
    t = date(sp[0], sp[1], sp[2])
    return str(pa.scalar(t, type=pa.date32()).value)


def tpch_q1():  # done without sort except average
    s1 = Map(
        "sum_disc_price",
        BinOp(
            BinOp(None, None, Var("attr", "l_extendedprice"), ""),
            BinOp(
                BinOp(None, None, Var("const", "1"), ""),
                BinOp(None, None, Var("attr", "l_discount"), ""),
                None,
                " - ",
            ),
            None,
            " * ",
        ),
        Selection(Scan("lineitem"), "l_comment", "like %hellothere%"),
        "double",
    )
    s2 = Map(
        "sum_charge",
        BinOp(
            BinOp(
                BinOp(None, None, Var("attr", "l_extendedprice"), ""),
                BinOp(
                    BinOp(None, None, Var("const", "1"), ""),
                    BinOp(None, None, Var("attr", "l_discount"), ""),
                    None,
                    " - ",
                ),
                None,
                " * ",
            ),
            BinOp(
                BinOp(None, None, Var("const", "1"), ""),
                BinOp(None, None, Var("attr", "l_tax"), ""),
                None,
                " + ",
            ),
            None,
            " * ",
        ),
        s1,
        "double",
    )
    q = Aggregation(
        "agg",
        s2,
        ["l_returnflag", "l_linestatus"],
        {
            "l_returnflag": Aggregate("agg_l_returnflag", "any"),
            "l_linestatus": Aggregate("agg_l_linestatus", "any"),
            "l_quantity": Aggregate("sum_qty", "sum"),
            "l_discount": Aggregate("sum_discount", "sum"),
            "l_extendedprice": Aggregate("sum_base_price", "sum"),
            "sum_disc_price": Aggregate("sum_disc_price", "sum"),
            "sum_charge": Aggregate("sum_charge", "sum"),
            "*": Aggregate("count_order", "count"),
        },
    )
    f = Print(
        [
            "agg_l_returnflag",
            "agg_l_linestatus",
            "sum_qty",
            "sum_discount",
            "sum_base_price",
            "sum_disc_price",
            "sum_charge",
            "count_order",
        ],
        q,
    )
    print_plan(f)


def tpch_q3():  # done without sort
    join = HashJoin(
        ["c_custkey"],
        ["o_custkey"],
        Selection(
            Scan("customer"), "c_mktsegment", "== 1"
        ),  # 1 is the code for building
        Selection(Scan("orders"), "o_orderdate", "< 9204"),
    )
    join2 = HashJoin(
        ["o_orderkey"],
        ["l_orderkey"],
        join,
        Selection(Scan("lineitem"), "l_shipdate", "> 9204"),
    )
    s = Map(
        "revenue",
        BinOp(
            BinOp(None, None, Var("attr", "l_extendedprice"), ""),
            BinOp(
                BinOp(None, None, Var("const", "1"), ""),
                BinOp(None, None, Var("attr", "l_discount"), ""),
                None,
                " - ",
            ),
            None,
            " * ",
        ),
        join2,
        "double",
    )
    agg = Aggregation(
        "agg",
        s,
        ["l_orderkey"],
        {
            "l_orderkey": Aggregate("agg_l_orderkey", "any"),
            "l_discount": Aggregate("agg_l_discount", "sum"),
            "o_shippriority": Aggregate("agg_o_shippriority", "any"),
            "revenue": Aggregate("revenue", "sum"),
            "o_orderdate": Aggregate("agg_o_orderdate", "any"),
        },
    )
    p = Print(
        ["agg_l_orderkey", "revenue", "agg_o_orderdate", "agg_o_shippriority"], agg
    )
    print_plan(p)


def tpch_q6():  # done without sort
    s1 = Selection(Scan("lineitem"), "l_shipdate", " >= " + get_date("1994-01-01"))
    s2 = Selection(s1, "l_shipdate", " < " + get_date("1995-01-01"))
    s3 = Selection(s2, "l_quantity", " < 24")
    s4 = Selection(s3, "l_discount", ">= 0.05")
    s5 = Selection(s4, "l_discount", "<= 0.07")
    s6 = Map(
        "revenue",
        BinOp(
            BinOp(None, None, Var("attr", "l_extendedprice"), ""),
            BinOp(None, None, Var("attr", "l_discount"), "*"),
            None,
            " * ",
        ),
        s5,
        "double",
    )
    q = Aggregation("agg", s6, [], {"revenue": Aggregate("agg_revenue", "sum")})
    p = Print(["agg_revenue"], q)
    print_plan(p)


def tpch_q9():  # extract year from date part is not yet handled in code generation, for now manually editing the generated code
    l1 = Selection(Scan("part"), "p_name", "like green")
    j1 = HashJoin(["p_partkey"], ["l_partkey"], l1, Scan("lineitem"))
    j2 = HashJoinMultimap(["l_orderkey"], ["o_orderkey"], j1, Scan("orders"))
    ns_join = HashJoin(
        ["n_nationkey"], ["s_nationkey"], Scan("nation"), Scan("supplier")
    )
    j3 = HashJoin(["s_suppkey"], ["ps_suppkey"], ns_join, Scan("partsupp"))
    j4 = HashJoinMultimap(
        ["l_partkey", "l_suppkey"], ["ps_partkey", "s_suppkey"], j2, j3
    )
    mped = Map(
        "profit",
        BinOp(
            lhs=BinOp(
                lhs=BinOp(None, None, Var("attr", "l_extendedprice"), ""),
                rhs=BinOp(
                    lhs=BinOp(None, None, Var("const", "1"), ""),
                    rhs=BinOp(None, None, Var("attr", "l_discount"), ""),
                    leaf_var=None,
                    op=" - ",
                ),
                leaf_var=None,
                op=" * ",
            ),
            rhs=BinOp(
                lhs=BinOp(None, None, Var("attr", "ps_supplycost"), ""),
                rhs=BinOp(None, None, Var("attr", "l_quantity"), ""),
                leaf_var=None,
                op=" * ",
            ),
            leaf_var=None,
            op="-",
        ),
        j4,
        "double",
    )
    agg = Aggregation(
        "agg",
        mped,
        ["n_name", "o_orderdate"],
        {
            "n_name": Aggregate("agg_n_name", "any"),
            "o_orderdate": Aggregate("agg_o_orderdate", "any"),
            "profit": Aggregate("sum_profit", "sum"),
        },
    )
    p = Print(["agg_n_name", "agg_o_orderdate", "sum_profit"], agg)
    print_plan(p)


def tpch_q18():  # done without sort
    agg1 = Aggregation(
        "agg1",
        Scan("lineitem"),
        ["l_orderkey"],
        {
            "l_orderkey": Aggregate("agg1_l_orderkey", "any"),
            "l_quantity": Aggregate("agg1_l_quantity", "sum"),
        },
    )
    print_plan(agg1)
    sel1 = Selection(Scan("agg1"), "agg1_l_quantity", " > 300")
    join1 = HashJoinMultimap(["o_orderkey"], ["agg1_l_orderkey"], Scan("orders"), sel1)
    join2 = HashJoinMultimap(["c_custkey"], ["o_custkey"], Scan("customer"), join1)
    join3 = HashJoinMultimap(["o_orderkey"], ["l_orderkey"], join2, Scan("lineitem"))
    agg2 = Aggregation(
        "agg2",
        join3,
        ["o_orderkey"],
        {
            "o_orderkey": Aggregate("agg2_o_orderkey", "any"),
            "l_quantity": Aggregate("agg2_l_quantity", "sum"),
        },
    )
    p = Print(["agg2_o_orderkey", "agg2_l_quantity"], agg2)
    print_plan(p)


def tpch_q2():  # problem with int32 and double being key for the hash tablek

    j2 = HashJoin(
        ["r_regionkey"],
        ["n_regionkey"],
        Selection(Scan("region"), "r_name", "== 3"),
        Scan("nation"),
    )  # 3 is code for EUROPE
    j3 = HashJoin(["n_nationkey"], ["s_nationkey"], j2, Scan("supplier"))
    j4 = HashJoin(["s_suppkey"], ["ps_suppkey"], j3, Scan("partsupp"))
    l1 = Selection(Selection(Scan("part"), "p_size", "== 15"), "p_type", "like BRASS")
    j5 = HashJoin(["p_partkey"], ["ps_partkey"], l1, j4)
    agg = Aggregation(
        "agg",
        j5,
        ["ps_partkey"],
        {
            "ps_supplycost": Aggregate("min_supplycost", "min"),
            "p_mfgr": Aggregate("agg_p_mfgr", "any"),
            "p_partkey": Aggregate("agg_p_partkey", "any"),
        },
    )
    print_plan(agg)
    j6 = HashJoin(
        ["agg_p_partkey", "min_supplycost"],
        ["ps_partkey", "ps_supplycost"],
        Scan("agg"),
        Scan("partsupp"),
    )
    j7 = HashJoin(["s_suppkey"], ["ps_suppkey"], Scan("supplier"), j6)
    j1 = HashJoin(
        ["r_regionkey"],
        ["n_regionkey"],
        Selection(Scan("region"), "r_name", " == 3"),
        Scan("nation"),
    )
    j8 = HashJoin(["n_nationkey"], ["s_nationkey"], j1, j7)
    p = Materialize(
        "mat",
        j8,
        ["s_acctbal", "n_name", "agg_p_partkey", "agg_p_mfgr"],
        ["mat_s_acctbal", "mat_n_name", "mat_p_partkey", "mat_p_mfgr"],
    )
    pl = Print(["mat_s_acctbal", "mat_n_name", "mat_p_partkey", "mat_p_mfgr"], p)
    print_plan(pl)


def tpch_q4():  # needs semi join to be implemented to work
    l1 = Selection(
        Selection(
            Scan("orders"), "o_orderdate", ">= {}".format(get_date("1993-07-01"))
        ),
        "o_orderdate",
        "< {}".format(get_date("1993-10-01")),
    )
    # TODO: this is supposed to be semi join
    j1 = HashJoin(
        ["o_orderkey"],
        ["l_orderkey"],
        l1,
        Selection(Scan("lineitem"), "l_commitdate", " < l_receiptdate[tid]"),
    )

    agg = Aggregation(
        "agg",
        j1,
        ["o_orderpriority"],
        {
            "o_orderpriority": Aggregate("agg_op", "any"),
            "*": Aggregate("agg_count", "count"),
        },
    )
    plan = Print(["agg_op", "agg_count"], agg)
    print_plan(plan)


def tpch_q5():
    l1 = Selection(Scan("region"), "r_name", " == 2")
    j1 = HashJoin(["r_regionkey"], ["n_regionkey"], l1, Scan("nation"))
    j2 = HashJoin(["n_nationkey"], ["c_nationkey"], j1, Scan("customer"))
    j3 = HashJoin(
        ["c_custkey"],
        ["o_custkey"],
        j2,
        Selection(
            Selection(
                Scan("orders"), "o_orderdate", ">= {}".format(get_date("1994-01-01"))
            ),
        "o_orderdate",
        "< {}".format(get_date("1995-01-01"))
        )
    )
    j4 = HashJoin(["o_orderkey"], ["l_orderkey"], j3, Scan("lineitem"))
    j5 = HashJoin(["s_nationkey", "s_suppkey"], ["c_nationkey", "l_suppkey"],
                  Scan("supplier"), j4)
    mped = Map("revenue", BinOp(
        BinOp(None, None, Var("attr", "l_extendedprice"), ""),
        BinOp(
            BinOp(None, None, Var("const", "1"), ""),
            BinOp(None, None, Var("attr", "l_discount"), ""),
            None, 
            " - "
        ), None, " * "
    ), j5, "double")
    agg = Aggregation("agg", mped, ["n_name"], {
        "n_name": Aggregate("agg_n_name", "any"),
        "revenue": Aggregate("agg_revenue", "sum"),
    })
    plan = Print(["agg_n_name", "agg_revenue"], agg)
    print_plan(plan)


if __name__ == "__main__":
    tpch_q5()
