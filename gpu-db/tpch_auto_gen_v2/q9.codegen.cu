#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5b4bf5099a40(uint64_t* COUNT5b4bf508bf60, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
//Materialize count
atomicAdd((int*)COUNT5b4bf508bf60, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5b4bf5099a40(uint64_t* BUF_5b4bf508bf60, uint64_t* BUF_IDX_5b4bf508bf60, HASHTABLE_INSERT HT_5b4bf508bf60, DBI32Type* nation__n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_5b4bf508bf60 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_5b4bf508bf60 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_5b4bf508bf60 = atomicAdd((int*)BUF_IDX_5b4bf508bf60, 1);
HT_5b4bf508bf60.insert(cuco::pair{KEY_5b4bf508bf60, buf_idx_5b4bf508bf60});
BUF_5b4bf508bf60[buf_idx_5b4bf508bf60 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5b4bf5079010(uint64_t* BUF_5b4bf508bf60, uint64_t* COUNT5b4bf508c340, HASHTABLE_PROBE HT_5b4bf508bf60, DBI32Type* supplier__s_nationkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_5b4bf508bf60 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_5b4bf508bf60 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_5b4bf508bf60.for_each(KEY_5b4bf508bf60, [&] __device__ (auto const SLOT_5b4bf508bf60) {

auto const [slot_first5b4bf508bf60, slot_second5b4bf508bf60] = SLOT_5b4bf508bf60;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5b4bf508c340, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5b4bf5079010(uint64_t* BUF_5b4bf508bf60, uint64_t* BUF_5b4bf508c340, uint64_t* BUF_IDX_5b4bf508c340, HASHTABLE_PROBE HT_5b4bf508bf60, HASHTABLE_INSERT HT_5b4bf508c340, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_5b4bf508bf60 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_5b4bf508bf60 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_5b4bf508bf60.for_each(KEY_5b4bf508bf60, [&] __device__ (auto const SLOT_5b4bf508bf60) {
auto const [slot_first5b4bf508bf60, slot_second5b4bf508bf60] = SLOT_5b4bf508bf60;
if (!(true)) return;
uint64_t KEY_5b4bf508c340 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5b4bf508c340 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5b4bf508c340 = atomicAdd((int*)BUF_IDX_5b4bf508c340, 1);
HT_5b4bf508c340.insert(cuco::pair{KEY_5b4bf508c340, buf_idx_5b4bf508c340});
BUF_5b4bf508c340[buf_idx_5b4bf508c340 * 2 + 0] = tid;
BUF_5b4bf508c340[buf_idx_5b4bf508c340 * 2 + 1] = BUF_5b4bf508bf60[slot_second5b4bf508bf60 * 1 + 0];
});
}
__global__ void count_5b4bf509f630(uint64_t* COUNT5b4bf508f980, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
//Materialize count
atomicAdd((int*)COUNT5b4bf508f980, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5b4bf509f630(uint64_t* BUF_5b4bf508f980, uint64_t* BUF_IDX_5b4bf508f980, HASHTABLE_INSERT HT_5b4bf508f980, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_5b4bf508f980 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_5b4bf508f980 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_5b4bf508f980 = atomicAdd((int*)BUF_IDX_5b4bf508f980, 1);
HT_5b4bf508f980.insert(cuco::pair{KEY_5b4bf508f980, buf_idx_5b4bf508f980});
BUF_5b4bf508f980[buf_idx_5b4bf508f980 * 1 + 0] = tid;
}
__global__ void count_5b4bf50789e0(uint64_t* COUNT5b4bf508fa90, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
//Materialize count
atomicAdd((int*)COUNT5b4bf508fa90, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5b4bf50789e0(uint64_t* BUF_5b4bf508fa90, uint64_t* BUF_IDX_5b4bf508fa90, HASHTABLE_INSERT HT_5b4bf508fa90, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
uint64_t KEY_5b4bf508fa90 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_5b4bf508fa90 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_5b4bf508fa90 = atomicAdd((int*)BUF_IDX_5b4bf508fa90, 1);
HT_5b4bf508fa90.insert(cuco::pair{KEY_5b4bf508fa90, buf_idx_5b4bf508fa90});
BUF_5b4bf508fa90[buf_idx_5b4bf508fa90 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5b4bf5098b00(uint64_t* BUF_5b4bf508c340, uint64_t* COUNT5b4bf508fba0, HASHTABLE_PROBE HT_5b4bf508c340, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= partsupp_size) return;
uint64_t KEY_5b4bf508c340 = 0;
auto reg_partsupp__ps_suppkey = partsupp__ps_suppkey[tid];

KEY_5b4bf508c340 |= reg_partsupp__ps_suppkey;
//Probe Hash table
HT_5b4bf508c340.for_each(KEY_5b4bf508c340, [&] __device__ (auto const SLOT_5b4bf508c340) {

auto const [slot_first5b4bf508c340, slot_second5b4bf508c340] = SLOT_5b4bf508c340;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5b4bf508fba0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5b4bf5098b00(uint64_t* BUF_5b4bf508c340, uint64_t* BUF_5b4bf508fba0, uint64_t* BUF_IDX_5b4bf508fba0, HASHTABLE_PROBE HT_5b4bf508c340, HASHTABLE_INSERT HT_5b4bf508fba0, DBI32Type* partsupp__ps_partkey, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size, DBI32Type* supplier__s_suppkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= partsupp_size) return;
uint64_t KEY_5b4bf508c340 = 0;
auto reg_partsupp__ps_suppkey = partsupp__ps_suppkey[tid];

KEY_5b4bf508c340 |= reg_partsupp__ps_suppkey;
//Probe Hash table
HT_5b4bf508c340.for_each(KEY_5b4bf508c340, [&] __device__ (auto const SLOT_5b4bf508c340) {
auto const [slot_first5b4bf508c340, slot_second5b4bf508c340] = SLOT_5b4bf508c340;
if (!(true)) return;
uint64_t KEY_5b4bf508fba0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[BUF_5b4bf508c340[slot_second5b4bf508c340 * 2 + 0]];

KEY_5b4bf508fba0 |= reg_supplier__s_suppkey;
auto reg_partsupp__ps_partkey = partsupp__ps_partkey[tid];
KEY_5b4bf508fba0 <<= 32;
KEY_5b4bf508fba0 |= reg_partsupp__ps_partkey;
// Insert hash table kernel;
auto buf_idx_5b4bf508fba0 = atomicAdd((int*)BUF_IDX_5b4bf508fba0, 1);
HT_5b4bf508fba0.insert(cuco::pair{KEY_5b4bf508fba0, buf_idx_5b4bf508fba0});
BUF_5b4bf508fba0[buf_idx_5b4bf508fba0 * 3 + 0] = BUF_5b4bf508c340[slot_second5b4bf508c340 * 2 + 0];
BUF_5b4bf508fba0[buf_idx_5b4bf508fba0 * 3 + 1] = tid;
BUF_5b4bf508fba0[buf_idx_5b4bf508fba0 * 3 + 2] = BUF_5b4bf508c340[slot_second5b4bf508c340 * 2 + 1];
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5b4bf5096650(uint64_t* BUF_5b4bf508f980, uint64_t* BUF_5b4bf508fa90, uint64_t* BUF_5b4bf508fba0, HASHTABLE_INSERT HT_5b4bf5048910, HASHTABLE_PROBE HT_5b4bf508f980, HASHTABLE_PROBE HT_5b4bf508fa90, HASHTABLE_PROBE HT_5b4bf508fba0, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_partkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBDateType* orders__o_orderdate) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_5b4bf508f980 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5b4bf508f980 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5b4bf508f980.for_each(KEY_5b4bf508f980, [&] __device__ (auto const SLOT_5b4bf508f980) {

auto const [slot_first5b4bf508f980, slot_second5b4bf508f980] = SLOT_5b4bf508f980;
if (!(true)) return;
uint64_t KEY_5b4bf508fa90 = 0;
auto reg_lineitem__l_partkey = lineitem__l_partkey[tid];

KEY_5b4bf508fa90 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_5b4bf508fa90.for_each(KEY_5b4bf508fa90, [&] __device__ (auto const SLOT_5b4bf508fa90) {

auto const [slot_first5b4bf508fa90, slot_second5b4bf508fa90] = SLOT_5b4bf508fa90;
if (!(true)) return;
uint64_t KEY_5b4bf508fba0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_5b4bf508fba0 |= reg_lineitem__l_suppkey;
KEY_5b4bf508fba0 <<= 32;
KEY_5b4bf508fba0 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_5b4bf508fba0.for_each(KEY_5b4bf508fba0, [&] __device__ (auto const SLOT_5b4bf508fba0) {

auto const [slot_first5b4bf508fba0, slot_second5b4bf508fba0] = SLOT_5b4bf508fba0;
if (!(true)) return;
uint64_t KEY_5b4bf5048910 = 0;
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_5b4bf508f980[slot_second5b4bf508f980 * 1 + 0]];
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_orders__o_orderdate);

KEY_5b4bf5048910 |= reg_map0__tmp_attr0;
//Create aggregation hash table
HT_5b4bf5048910.insert(cuco::pair{KEY_5b4bf5048910, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5b4bf5096650(uint64_t* BUF_5b4bf508f980, uint64_t* BUF_5b4bf508fa90, uint64_t* BUF_5b4bf508fba0, HASHTABLE_FIND HT_5b4bf5048910, HASHTABLE_PROBE HT_5b4bf508f980, HASHTABLE_PROBE HT_5b4bf508fa90, HASHTABLE_PROBE HT_5b4bf508fba0, DBI64Type* KEY_5b4bf5048910map0__tmp_attr0, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_partkey, DBDecimalType* lineitem__l_quantity, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBDateType* orders__o_orderdate, DBDecimalType* partsupp__ps_supplycost) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_5b4bf508f980 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5b4bf508f980 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5b4bf508f980.for_each(KEY_5b4bf508f980, [&] __device__ (auto const SLOT_5b4bf508f980) {
auto const [slot_first5b4bf508f980, slot_second5b4bf508f980] = SLOT_5b4bf508f980;
if (!(true)) return;
uint64_t KEY_5b4bf508fa90 = 0;
auto reg_lineitem__l_partkey = lineitem__l_partkey[tid];

KEY_5b4bf508fa90 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_5b4bf508fa90.for_each(KEY_5b4bf508fa90, [&] __device__ (auto const SLOT_5b4bf508fa90) {
auto const [slot_first5b4bf508fa90, slot_second5b4bf508fa90] = SLOT_5b4bf508fa90;
if (!(true)) return;
uint64_t KEY_5b4bf508fba0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_5b4bf508fba0 |= reg_lineitem__l_suppkey;
KEY_5b4bf508fba0 <<= 32;
KEY_5b4bf508fba0 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_5b4bf508fba0.for_each(KEY_5b4bf508fba0, [&] __device__ (auto const SLOT_5b4bf508fba0) {
auto const [slot_first5b4bf508fba0, slot_second5b4bf508fba0] = SLOT_5b4bf508fba0;
if (!(true)) return;
uint64_t KEY_5b4bf5048910 = 0;
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_5b4bf508f980[slot_second5b4bf508f980 * 1 + 0]];
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_orders__o_orderdate);

KEY_5b4bf5048910 |= reg_map0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_5b4bf5048910 = HT_5b4bf5048910.find(KEY_5b4bf5048910)->second;
auto reg_lineitem__l_quantity = lineitem__l_quantity[tid];
auto reg_partsupp__ps_supplycost = partsupp__ps_supplycost[BUF_5b4bf508fba0[slot_second5b4bf508fba0 * 3 + 1]];
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = ((reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount))) - ((reg_partsupp__ps_supplycost) * (reg_lineitem__l_quantity));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_5b4bf5048910], reg_map0__tmp_attr1);
KEY_5b4bf5048910map0__tmp_attr0[buf_idx_5b4bf5048910] = reg_map0__tmp_attr0;
});
});
});
}
__global__ void count_5b4bf50ac720(size_t COUNT5b4bf5048910, uint64_t* COUNT5b4bf505bb00) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5b4bf5048910) return;
//Materialize count
atomicAdd((int*)COUNT5b4bf505bb00, 1);
}
__global__ void main_5b4bf50ac720(size_t COUNT5b4bf5048910, DBDecimalType* MAT5b4bf505bb00aggr0__tmp_attr2, DBI64Type* MAT5b4bf505bb00map0__tmp_attr0, uint64_t* MAT_IDX5b4bf505bb00, DBDecimalType* aggr0__tmp_attr2, DBI64Type* map0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5b4bf5048910) return;
//Materialize buffers
auto mat_idx5b4bf505bb00 = atomicAdd((int*)MAT_IDX5b4bf505bb00, 1);
auto reg_map0__tmp_attr0 = map0__tmp_attr0[tid];
MAT5b4bf505bb00map0__tmp_attr0[mat_idx5b4bf505bb00] = reg_map0__tmp_attr0;
auto reg_aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
MAT5b4bf505bb00aggr0__tmp_attr2[mat_idx5b4bf505bb00] = reg_aggr0__tmp_attr2;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT5b4bf508bf60;
cudaMalloc(&d_COUNT5b4bf508bf60, sizeof(uint64_t));
cudaMemset(d_COUNT5b4bf508bf60, 0, sizeof(uint64_t));
count_5b4bf5099a40<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT5b4bf508bf60, nation_size);
uint64_t COUNT5b4bf508bf60;
cudaMemcpy(&COUNT5b4bf508bf60, d_COUNT5b4bf508bf60, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b4bf508bf60;
cudaMalloc(&d_BUF_IDX_5b4bf508bf60, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b4bf508bf60, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b4bf508bf60;
cudaMalloc(&d_BUF_5b4bf508bf60, sizeof(uint64_t) * COUNT5b4bf508bf60 * 1);
auto d_HT_5b4bf508bf60 = cuco::experimental::static_multimap{ (int)COUNT5b4bf508bf60*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b4bf5099a40<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_5b4bf508bf60, d_BUF_IDX_5b4bf508bf60, d_HT_5b4bf508bf60.ref(cuco::insert), d_nation__n_nationkey, nation_size);
//Materialize count
uint64_t* d_COUNT5b4bf508c340;
cudaMalloc(&d_COUNT5b4bf508c340, sizeof(uint64_t));
cudaMemset(d_COUNT5b4bf508c340, 0, sizeof(uint64_t));
count_5b4bf5079010<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_5b4bf508bf60, d_COUNT5b4bf508c340, d_HT_5b4bf508bf60.ref(cuco::for_each), d_supplier__s_nationkey, supplier_size);
uint64_t COUNT5b4bf508c340;
cudaMemcpy(&COUNT5b4bf508c340, d_COUNT5b4bf508c340, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b4bf508c340;
cudaMalloc(&d_BUF_IDX_5b4bf508c340, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b4bf508c340, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b4bf508c340;
cudaMalloc(&d_BUF_5b4bf508c340, sizeof(uint64_t) * COUNT5b4bf508c340 * 2);
auto d_HT_5b4bf508c340 = cuco::experimental::static_multimap{ (int)COUNT5b4bf508c340*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b4bf5079010<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_5b4bf508bf60, d_BUF_5b4bf508c340, d_BUF_IDX_5b4bf508c340, d_HT_5b4bf508bf60.ref(cuco::for_each), d_HT_5b4bf508c340.ref(cuco::insert), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT5b4bf508f980;
cudaMalloc(&d_COUNT5b4bf508f980, sizeof(uint64_t));
cudaMemset(d_COUNT5b4bf508f980, 0, sizeof(uint64_t));
count_5b4bf509f630<<<std::ceil((float)orders_size/32.), 32>>>(d_COUNT5b4bf508f980, orders_size);
uint64_t COUNT5b4bf508f980;
cudaMemcpy(&COUNT5b4bf508f980, d_COUNT5b4bf508f980, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b4bf508f980;
cudaMalloc(&d_BUF_IDX_5b4bf508f980, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b4bf508f980, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b4bf508f980;
cudaMalloc(&d_BUF_5b4bf508f980, sizeof(uint64_t) * COUNT5b4bf508f980 * 1);
auto d_HT_5b4bf508f980 = cuco::experimental::static_multimap{ (int)COUNT5b4bf508f980*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b4bf509f630<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5b4bf508f980, d_BUF_IDX_5b4bf508f980, d_HT_5b4bf508f980.ref(cuco::insert), d_orders__o_orderkey, orders_size);
//Materialize count
uint64_t* d_COUNT5b4bf508fa90;
cudaMalloc(&d_COUNT5b4bf508fa90, sizeof(uint64_t));
cudaMemset(d_COUNT5b4bf508fa90, 0, sizeof(uint64_t));
count_5b4bf50789e0<<<std::ceil((float)part_size/32.), 32>>>(d_COUNT5b4bf508fa90, part_size);
uint64_t COUNT5b4bf508fa90;
cudaMemcpy(&COUNT5b4bf508fa90, d_COUNT5b4bf508fa90, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b4bf508fa90;
cudaMalloc(&d_BUF_IDX_5b4bf508fa90, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b4bf508fa90, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b4bf508fa90;
cudaMalloc(&d_BUF_5b4bf508fa90, sizeof(uint64_t) * COUNT5b4bf508fa90 * 1);
auto d_HT_5b4bf508fa90 = cuco::experimental::static_multimap{ (int)COUNT5b4bf508fa90*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b4bf50789e0<<<std::ceil((float)part_size/32.), 32>>>(d_BUF_5b4bf508fa90, d_BUF_IDX_5b4bf508fa90, d_HT_5b4bf508fa90.ref(cuco::insert), d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT5b4bf508fba0;
cudaMalloc(&d_COUNT5b4bf508fba0, sizeof(uint64_t));
cudaMemset(d_COUNT5b4bf508fba0, 0, sizeof(uint64_t));
count_5b4bf5098b00<<<std::ceil((float)partsupp_size/32.), 32>>>(d_BUF_5b4bf508c340, d_COUNT5b4bf508fba0, d_HT_5b4bf508c340.ref(cuco::for_each), d_partsupp__ps_suppkey, partsupp_size);
uint64_t COUNT5b4bf508fba0;
cudaMemcpy(&COUNT5b4bf508fba0, d_COUNT5b4bf508fba0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b4bf508fba0;
cudaMalloc(&d_BUF_IDX_5b4bf508fba0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b4bf508fba0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b4bf508fba0;
cudaMalloc(&d_BUF_5b4bf508fba0, sizeof(uint64_t) * COUNT5b4bf508fba0 * 3);
auto d_HT_5b4bf508fba0 = cuco::experimental::static_multimap{ (int)COUNT5b4bf508fba0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b4bf5098b00<<<std::ceil((float)partsupp_size/32.), 32>>>(d_BUF_5b4bf508c340, d_BUF_5b4bf508fba0, d_BUF_IDX_5b4bf508fba0, d_HT_5b4bf508c340.ref(cuco::for_each), d_HT_5b4bf508fba0.ref(cuco::insert), d_partsupp__ps_partkey, d_partsupp__ps_suppkey, partsupp_size, d_supplier__s_suppkey);
//Create aggregation hash table
auto d_HT_5b4bf5048910 = cuco::static_map{ (int)48009721*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5b4bf5096650<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5b4bf508f980, d_BUF_5b4bf508fa90, d_BUF_5b4bf508fba0, d_HT_5b4bf5048910.ref(cuco::insert), d_HT_5b4bf508f980.ref(cuco::for_each), d_HT_5b4bf508fa90.ref(cuco::for_each), d_HT_5b4bf508fba0.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_partkey, d_lineitem__l_suppkey, lineitem_size, d_orders__o_orderdate);
size_t COUNT5b4bf5048910 = d_HT_5b4bf5048910.size();
thrust::device_vector<int64_t> keys_5b4bf5048910(COUNT5b4bf5048910), vals_5b4bf5048910(COUNT5b4bf5048910);
d_HT_5b4bf5048910.retrieve_all(keys_5b4bf5048910.begin(), vals_5b4bf5048910.begin());
d_HT_5b4bf5048910.clear();
int64_t* raw_keys5b4bf5048910 = thrust::raw_pointer_cast(keys_5b4bf5048910.data());
insertKeys<<<std::ceil((float)COUNT5b4bf5048910/32.), 32>>>(raw_keys5b4bf5048910, d_HT_5b4bf5048910.ref(cuco::insert), COUNT5b4bf5048910);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT5b4bf5048910);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT5b4bf5048910);
DBI64Type* d_KEY_5b4bf5048910map0__tmp_attr0;
cudaMalloc(&d_KEY_5b4bf5048910map0__tmp_attr0, sizeof(DBI64Type) * COUNT5b4bf5048910);
cudaMemset(d_KEY_5b4bf5048910map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT5b4bf5048910);
main_5b4bf5096650<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5b4bf508f980, d_BUF_5b4bf508fa90, d_BUF_5b4bf508fba0, d_HT_5b4bf5048910.ref(cuco::find), d_HT_5b4bf508f980.ref(cuco::for_each), d_HT_5b4bf508fa90.ref(cuco::for_each), d_HT_5b4bf508fba0.ref(cuco::for_each), d_KEY_5b4bf5048910map0__tmp_attr0, d_aggr0__tmp_attr2, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_partkey, d_lineitem__l_quantity, d_lineitem__l_suppkey, lineitem_size, d_orders__o_orderdate, d_partsupp__ps_supplycost);
//Materialize count
uint64_t* d_COUNT5b4bf505bb00;
cudaMalloc(&d_COUNT5b4bf505bb00, sizeof(uint64_t));
cudaMemset(d_COUNT5b4bf505bb00, 0, sizeof(uint64_t));
count_5b4bf50ac720<<<std::ceil((float)COUNT5b4bf5048910/32.), 32>>>(COUNT5b4bf5048910, d_COUNT5b4bf505bb00);
uint64_t COUNT5b4bf505bb00;
cudaMemcpy(&COUNT5b4bf505bb00, d_COUNT5b4bf505bb00, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5b4bf505bb00;
cudaMalloc(&d_MAT_IDX5b4bf505bb00, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5b4bf505bb00, 0, sizeof(uint64_t));
auto MAT5b4bf505bb00map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT5b4bf505bb00);
DBI64Type* d_MAT5b4bf505bb00map0__tmp_attr0;
cudaMalloc(&d_MAT5b4bf505bb00map0__tmp_attr0, sizeof(DBI64Type) * COUNT5b4bf505bb00);
auto MAT5b4bf505bb00aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5b4bf505bb00);
DBDecimalType* d_MAT5b4bf505bb00aggr0__tmp_attr2;
cudaMalloc(&d_MAT5b4bf505bb00aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT5b4bf505bb00);
main_5b4bf50ac720<<<std::ceil((float)COUNT5b4bf5048910/32.), 32>>>(COUNT5b4bf5048910, d_MAT5b4bf505bb00aggr0__tmp_attr2, d_MAT5b4bf505bb00map0__tmp_attr0, d_MAT_IDX5b4bf505bb00, d_aggr0__tmp_attr2, d_KEY_5b4bf5048910map0__tmp_attr0);
cudaMemcpy(MAT5b4bf505bb00map0__tmp_attr0, d_MAT5b4bf505bb00map0__tmp_attr0, sizeof(DBI64Type) * COUNT5b4bf505bb00, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5b4bf505bb00aggr0__tmp_attr2, d_MAT5b4bf505bb00aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT5b4bf505bb00, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5b4bf505bb00; i++) { std::cout << MAT5b4bf505bb00map0__tmp_attr0[i] << "\t";
std::cout << MAT5b4bf505bb00aggr0__tmp_attr2[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_5b4bf508bf60);
cudaFree(d_BUF_IDX_5b4bf508bf60);
cudaFree(d_COUNT5b4bf508bf60);
cudaFree(d_BUF_5b4bf508c340);
cudaFree(d_BUF_IDX_5b4bf508c340);
cudaFree(d_COUNT5b4bf508c340);
cudaFree(d_BUF_5b4bf508f980);
cudaFree(d_BUF_IDX_5b4bf508f980);
cudaFree(d_COUNT5b4bf508f980);
cudaFree(d_BUF_5b4bf508fa90);
cudaFree(d_BUF_IDX_5b4bf508fa90);
cudaFree(d_COUNT5b4bf508fa90);
cudaFree(d_BUF_5b4bf508fba0);
cudaFree(d_BUF_IDX_5b4bf508fba0);
cudaFree(d_COUNT5b4bf508fba0);
cudaFree(d_KEY_5b4bf5048910map0__tmp_attr0);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_COUNT5b4bf505bb00);
cudaFree(d_MAT5b4bf505bb00aggr0__tmp_attr2);
cudaFree(d_MAT5b4bf505bb00map0__tmp_attr0);
cudaFree(d_MAT_IDX5b4bf505bb00);
free(MAT5b4bf505bb00aggr0__tmp_attr2);
free(MAT5b4bf505bb00map0__tmp_attr0);
}