
from Aggregation import Aggregation
from Scan import Scan
from HashJoin import HashJoin
from Selection import Selection
from helper import Aggregate, Context, typeof

def tpch_q1():
    q = Aggregation(
        "agg",
        Scan("lineitem"),
        ["l_returnflag", "l_linestatus"],
        {
            "l_returnflag": Aggregate("agg_l_returnflag", "any"),
            "l_linestatus": Aggregate("agg_l_linestatus", "any"),
            "l_quantity": Aggregate("sum_qty", "sum"),
            "l_discount": Aggregate("sum_discount", "sum"),
        },
    )
    q.produce(Context())
    q.print()
    q.print_control()

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
    agg.produce(Context())
    agg.print()
    allocated_attrs = set()
    agg.print_control(allocated_attrs)
    for attr in allocated_attrs:
        print(attr.ty, "*", attr.val, ",")

if __name__ == "__main__":
    tpch_q3()    
