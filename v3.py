from Aggregation import Aggregation
from HashJoin import HashJoin
from Map import BinOp, Map, Var
from Scan import Scan
from Selection import Selection

from helper import Context


def tpch_q1():
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
        Selection(Scan("lineitem"), "l_shipdate", "<= 10471"),
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
    op = Aggregation(
        "agg",
        s2,
        ["l_returnflag", "l_linestatus"],
        {
            "l_returnflag": "any",
            "l_linestatus": "any",
            "l_quantity": "sum",
            "l_extendedprice": "sum",
            "l_discount": "sum",
            "sum_disc_price": "sum",
            "sum_charge": "sum",
            "*": "count",
        },
        {
            "l_quantity": "sum_qty",
            "l_returnflag": "agg_l_returnflag",
            "l_linestatus": "agg_l_linestatus",
            "l_extendedprice": "sum_base_charge",
            "l_discount": "sum_discount",
            "sum_disc_price": "sum_disc_price",
            "sum_charge": "sum_charge",
            "*": "count_order",
        },
    )
    op.produce(Context(set(), {}, None, [], {}, "", "", 0, ""))


def tpch_q3():
    c_o_join = HashJoin(
        Selection(Scan("customer"), "c_mktsegment", "= BUILDING"),
        Selection(Scan("orders"), "o_orderdate", "< 9204"),
        ["c_custkey"],
        ["o_custkey"],
    )
    col_join = HashJoin(
        c_o_join,
        Selection(Scan("lineitem"), "l_shipdate", " > 9204"),
        ["o_orderkey"],
        ["l_orderkey"],
    )
    op = Aggregation(
        "agg",
        col_join,
        ["l_orderkey"],
        {
            "l_extendedprice": "sum",
            "o_shippriority": "any",
            "o_orderdate": "any",
            "l_orderkey": "any",
        },
        {
            "l_extendedprice": "sum_l_ep",
            "o_shippriority": "any_o_sp",
            "o_orderdate": "any_o_od",
            "l_orderkey": "any_l_ok",
        },
    )
    op.produce(Context(set(), {}, None, [], {}, "", "", 0, ""))


tpch_q1()
