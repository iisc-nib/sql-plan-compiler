from Aggregation import Aggregation
from Map import BinOp, Map, Var
from Print import Print
from Scan import Scan
from HashJoin import HashJoin
from Selection import Selection
from helper import Aggregate, Context, typeof
from Operator import print_plan

import pyarrow as pa
from datetime import date

def get_date(dt: str):
    sp = [int(a) for a in dt.split('-')]
    t = date(sp[0], sp[1], sp[2])
    return str(pa.scalar(t, type=pa.date32()).value)
    

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
            "*": Aggregate("count_order", "count")
        },
    )
    f = Print(["agg_l_returnflag", "agg_l_linestatus", "sum_qty", "sum_discount", "sum_base_price",
               "sum_disc_price", "sum_charge", "count_order"], q)
    print_plan(f)

def tpch_q3():
    join = HashJoin(["c_custkey"], ["o_custkey"], 
                    Selection(Scan("customer"), "c_mktsegment", "== 0"), 
                    Selection(Scan("orders"), "o_orderdate", "< 9204"))
    join2 = HashJoin(["o_orderkey"], ["l_orderkey"], join, 
                     Selection(Scan("lineitem"), "l_shipdate", "> 9204"))
    s = Map("revenue", BinOp(
                BinOp(None, None, Var("attr", "l_extendedprice"), ""),
                BinOp(
                    BinOp(None, None, Var("const", "1"), ""),
                    BinOp(None, None, Var("attr", "l_discount"), ""),
                    None,
                    " - ",
                ),
                None,
                " * ",
            ), join2, "double")
    agg = Aggregation("agg", 
                      s,
                      ["l_orderkey"],
                      {
                          "l_orderkey": Aggregate("agg_l_orderkey", "any"),
                          "l_discount": Aggregate("agg_l_discount", "sum"),
                          "o_shippriority": Aggregate("agg_o_shippriority", "any"),
                          "revenue": Aggregate("revenue", "sum"),
                          "o_orderdate": Aggregate("agg_o_orderdate", "any"),
                      })
    p = Print(["agg_l_orderkey", "revenue", "agg_o_orderdate", "agg_o_shippriority"],
              agg)
    print_plan(p)

def tpch_q6():
    s1 = Selection(Scan(
            "lineitem"
        ), "l_shipdate", " >= " + get_date("1994-01-01"))
    s2 = Selection(s1, "l_shipdate", " < " + get_date("1995-01-01"))
    s3 = Selection(s2, "l_quantity", " < 24")
    s4 = Selection(s3, "l_discount", ">= 0.05")
    s5 = Selection(s4, "l_discount", "<= 0.07")
    s6 = Map("revenue", BinOp(BinOp(None, None, Var("attr", "l_extendedprice"), ""),
                             BinOp(None, None, Var("attr", "l_discount"), "*"),
                             None, 
                             " * "), s5, "double")
    q = Aggregation(
        "agg", 
        s6,
        [],
        {
            "revenue": Aggregate("agg_revenue", "sum")
        }
    )
    p = Print(["agg_revenue"], q)
    print_plan(p)

def tpch_q18():
    agg1 = Aggregation(
        "agg1", 
        Scan("lineitem"),
        ["l_orderkey"],
        {
            "l_orderkey": Aggregate("agg1_l_orderkey", "any"),
            "l_quantity": Aggregate("agg1_l_quantity", "sum")
        }
    )
    print_plan(agg1)
    sel1 = Selection(Scan("agg1"), "agg1_l_quantity", " > 300")
    join1 = HashJoin(["o_orderkey"], ["agg1_l_orderkey"], Scan("orders"), sel1)
    join2 = HashJoin(["c_custkey"], ["o_custkey"], Scan("customer"), join1)
    join3 = HashJoin(["o_orderkey"], ["l_orderkey"], join2, Scan("lineitem"))
    agg2 = Aggregation("agg2", join3, ["o_orderkey"], {
        "o_orderkey": Aggregate("agg2_o_orderkey", "any"),
        "l_quantity": Aggregate("agg2_l_quantity", "sum"),
    })
    p = Print(["agg2_o_orderkey", "agg2_l_quantity"], agg2)
    print_plan(p)

if __name__ == "__main__":
    tpch_q18()    
