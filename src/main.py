
from Aggregation import Aggregation
from Scan import Scan
from helper import Aggregate, Context


if __name__ == "__main__":
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
