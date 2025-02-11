from Aggregation import Aggregation
from HashJoin import HashJoin
from Map import BinOp, Map, Var
from Print import Print
from Scan import Scan
from Selection import Selection
from helper import Context, write_query


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
    mped = Map(
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
        col_join,
        "double",
    )
    op = Aggregation(
        "agg",
        mped,
        ["l_orderkey"],
        {
            "revenue": "sum",
            "o_shippriority": "any",
            "o_orderdate": "any",
            "l_orderkey": "any",
        },
        {
            "revenue": "sum_revenue",
            "o_shippriority": "any_o_sp",
            "o_orderdate": "any_o_od",
            "l_orderkey": "any_l_ok",
        },
    )
    printed = Print("agg", ["any_l_ok", "sum_revenue", "any_o_od", "any_o_sp"], op)
    context = Context(set(), {}, None, [], {}, "", "", 0, "", "", "")
    printed.produce(context)
    write_query("tpch_q3.cu", context)
    return context
