## Query 1

- Single table query (lineitem)
    - Filter on `l_shipdate` 
    - groupyby and orderby on `l_returnflag` and `l_linestatus`
    - Aggregation on `l_quantity`, `l_extendedprice`, `l_discount`, and `l_tax` (7 aggregations)
- 85% of the time is spent in the main1 kernel
    - Compute throughput is 5%
    - No warp divergence (31.59 active threads per warp)
- Summary from NCU
    - 
- TODO: Why is the compute throughput so low?

## Query 3

- Three table query (lineitem, orders, customer)
    - Filter on `o_orderdate`, `l_shipdate` and `c_mktsegment`
    - groupyby on `l_orderkey`, `o_orderdate` and `o_shippriority`
    - orderby on revenue desc, o_orderdate
    - Aggregation on `l_discount`, `l_extendedprice`
- Most of the time is spent in the following kernels
    - count3 and main3 -> probe the customer hash table and insert into the (customer, order) hash table
    - count5 and main5 -> probe the (lineitem, customer, order) hash table and insert into the (lineitem, customer, order) hash table
    - warp divergence is pretty bad (5 to 12 active threads per warp)
- Summary from NCU
    - TODO

## Query 5



## Core Observations

- Warp divergence is a problem (at least in probe kernels so far, selection?)
  - Is this because of the way the query is implemented? Can a different implementation without materialization help?
  - 
- Probe kernels are typically the bottlenecks in the query
- GPU bandwidth is not completely saturated. It looks like we are latency bound.
    - One thing to try is to increase the number of memory accesses per thread by processing more elements per thread, unrolling the loop and moving the memory accesses in parallel.
- 


