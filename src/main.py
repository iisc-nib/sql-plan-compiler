from Aggregation import Aggregation
from Map import BinOp, Map, Var
from Scan import Scan
from HashJoin import HashJoin
from Selection import Selection
from helper import Aggregate, Context, typeof
from Operator import print_plan

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
        },
    )
    print_plan(q)

def tpch_q3():
    join = HashJoin(["c_custkey"], ["o_custkey"], 
                    Selection(Scan("customer"), "c_mktsegment", "== 0"), 
                    Selection(Scan("orders"), "o_orderdate", "< 9204"))
    join2 = HashJoin(["o_orderkey"], ["l_orderkey"], join, 
                     Selection(Scan("lineitem"), "l_shipdate", "> 9204"))
    agg = Aggregation("agg", 
                      join2,
                      ["l_orderkey"],
                      {
                          "l_discount": Aggregate("agg_l_discount", "sum"),
                          "o_shippriority": Aggregate("agg_o_shippriority", "any"),
                          "o_orderdate": Aggregate("agg_o_orderdate", "any"),
                      })
    print_plan(agg)

if __name__ == "__main__":
    tpch_q1()    
