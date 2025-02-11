from Aggregation import Aggregation
from Map import BinOp, Map, Var
from Print import Print
from Scan import Scan
from Selection import Selection
from helper import Context, write_query


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
            "l_extendedprice": "sum_base_price",
            "l_discount": "sum_discount",
            "sum_disc_price": "sum_disc_price",
            "sum_charge": "sum_charge",
            "*": "count_order",
        },
    )
    printed = Print("agg", ["agg_l_returnflag", "agg_l_linestatus", "sum_qty", "sum_base_price", "sum_disc_price", "sum_charge", "count_order"], op)
    context = Context(set(), {}, None, [], {}, "", "", 0, "", "", "")
    printed.produce(context)
    write_query("tpch_q1.cu", context)
    return context