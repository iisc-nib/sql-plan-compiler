#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_58453863ae50(uint64_t* COUNT58453862c730, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
//Materialize count
atomicAdd((int*)COUNT58453862c730, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_58453863ae50(uint64_t* BUF_58453862c730, uint64_t* BUF_IDX_58453862c730, HASHTABLE_INSERT HT_58453862c730, DBI32Type* nation__n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_58453862c730 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_58453862c730 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_58453862c730 = atomicAdd((int*)BUF_IDX_58453862c730, 1);
HT_58453862c730.insert(cuco::pair{KEY_58453862c730, buf_idx_58453862c730});
BUF_58453862c730[buf_idx_58453862c730 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5845385b6ea0(uint64_t* BUF_58453862c730, uint64_t* COUNT58453862ccc0, HASHTABLE_PROBE HT_58453862c730, DBI32Type* supplier__s_nationkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_58453862c730 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_58453862c730 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_58453862c730.for_each(KEY_58453862c730, [&] __device__ (auto const SLOT_58453862c730) {

auto const [slot_first58453862c730, slot_second58453862c730] = SLOT_58453862c730;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT58453862ccc0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5845385b6ea0(uint64_t* BUF_58453862c730, uint64_t* BUF_58453862ccc0, uint64_t* BUF_IDX_58453862ccc0, HASHTABLE_PROBE HT_58453862c730, HASHTABLE_INSERT HT_58453862ccc0, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_58453862c730 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_58453862c730 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_58453862c730.for_each(KEY_58453862c730, [&] __device__ (auto const SLOT_58453862c730) {
auto const [slot_first58453862c730, slot_second58453862c730] = SLOT_58453862c730;
if (!(true)) return;
uint64_t KEY_58453862ccc0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_58453862ccc0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_58453862ccc0 = atomicAdd((int*)BUF_IDX_58453862ccc0, 1);
HT_58453862ccc0.insert(cuco::pair{KEY_58453862ccc0, buf_idx_58453862ccc0});
BUF_58453862ccc0[buf_idx_58453862ccc0 * 2 + 0] = tid;
BUF_58453862ccc0[buf_idx_58453862ccc0 * 2 + 1] = BUF_58453862c730[slot_second58453862c730 * 1 + 0];
});
}
__global__ void count_5845386402c0(uint64_t* COUNT584538630340, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
//Materialize count
atomicAdd((int*)COUNT584538630340, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5845386402c0(uint64_t* BUF_584538630340, uint64_t* BUF_IDX_584538630340, HASHTABLE_INSERT HT_584538630340, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_584538630340 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_584538630340 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_584538630340 = atomicAdd((int*)BUF_IDX_584538630340, 1);
HT_584538630340.insert(cuco::pair{KEY_584538630340, buf_idx_584538630340});
BUF_584538630340[buf_idx_584538630340 * 1 + 0] = tid;
}
__global__ void count_584538533fd0(uint64_t* COUNT584538630450, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
//Materialize count
atomicAdd((int*)COUNT584538630450, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_584538533fd0(uint64_t* BUF_584538630450, uint64_t* BUF_IDX_584538630450, HASHTABLE_INSERT HT_584538630450, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
uint64_t KEY_584538630450 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_584538630450 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_584538630450 = atomicAdd((int*)BUF_IDX_584538630450, 1);
HT_584538630450.insert(cuco::pair{KEY_584538630450, buf_idx_584538630450});
BUF_584538630450[buf_idx_584538630450 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_584538639f70(uint64_t* BUF_58453862ccc0, uint64_t* COUNT5845386305c0, HASHTABLE_PROBE HT_58453862ccc0, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= partsupp_size) return;
uint64_t KEY_58453862ccc0 = 0;
auto reg_partsupp__ps_suppkey = partsupp__ps_suppkey[tid];

KEY_58453862ccc0 |= reg_partsupp__ps_suppkey;
//Probe Hash table
HT_58453862ccc0.for_each(KEY_58453862ccc0, [&] __device__ (auto const SLOT_58453862ccc0) {

auto const [slot_first58453862ccc0, slot_second58453862ccc0] = SLOT_58453862ccc0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5845386305c0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_584538639f70(uint64_t* BUF_58453862ccc0, uint64_t* BUF_5845386305c0, uint64_t* BUF_IDX_5845386305c0, HASHTABLE_PROBE HT_58453862ccc0, HASHTABLE_INSERT HT_5845386305c0, DBI32Type* partsupp__ps_partkey, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size, DBI32Type* supplier__s_suppkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= partsupp_size) return;
uint64_t KEY_58453862ccc0 = 0;
auto reg_partsupp__ps_suppkey = partsupp__ps_suppkey[tid];

KEY_58453862ccc0 |= reg_partsupp__ps_suppkey;
//Probe Hash table
HT_58453862ccc0.for_each(KEY_58453862ccc0, [&] __device__ (auto const SLOT_58453862ccc0) {
auto const [slot_first58453862ccc0, slot_second58453862ccc0] = SLOT_58453862ccc0;
if (!(true)) return;
uint64_t KEY_5845386305c0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[BUF_58453862ccc0[slot_second58453862ccc0 * 2 + 0]];

KEY_5845386305c0 |= reg_supplier__s_suppkey;
auto reg_partsupp__ps_partkey = partsupp__ps_partkey[tid];
KEY_5845386305c0 <<= 32;
KEY_5845386305c0 |= reg_partsupp__ps_partkey;
// Insert hash table kernel;
auto buf_idx_5845386305c0 = atomicAdd((int*)BUF_IDX_5845386305c0, 1);
HT_5845386305c0.insert(cuco::pair{KEY_5845386305c0, buf_idx_5845386305c0});
BUF_5845386305c0[buf_idx_5845386305c0 * 3 + 0] = BUF_58453862ccc0[slot_second58453862ccc0 * 2 + 0];
BUF_5845386305c0[buf_idx_5845386305c0 * 3 + 1] = tid;
BUF_5845386305c0[buf_idx_5845386305c0 * 3 + 2] = BUF_58453862ccc0[slot_second58453862ccc0 * 2 + 1];
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_584538637b20(uint64_t* BUF_584538630340, uint64_t* BUF_584538630450, uint64_t* BUF_5845386305c0, HASHTABLE_INSERT HT_5845385e9110, HASHTABLE_PROBE HT_584538630340, HASHTABLE_PROBE HT_584538630450, HASHTABLE_PROBE HT_5845386305c0, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_partkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBDateType* orders__o_orderdate) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_584538630340 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_584538630340 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_584538630340.for_each(KEY_584538630340, [&] __device__ (auto const SLOT_584538630340) {

auto const [slot_first584538630340, slot_second584538630340] = SLOT_584538630340;
if (!(true)) return;
uint64_t KEY_584538630450 = 0;
auto reg_lineitem__l_partkey = lineitem__l_partkey[tid];

KEY_584538630450 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_584538630450.for_each(KEY_584538630450, [&] __device__ (auto const SLOT_584538630450) {

auto const [slot_first584538630450, slot_second584538630450] = SLOT_584538630450;
if (!(true)) return;
uint64_t KEY_5845386305c0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_5845386305c0 |= reg_lineitem__l_suppkey;
KEY_5845386305c0 <<= 32;
KEY_5845386305c0 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_5845386305c0.for_each(KEY_5845386305c0, [&] __device__ (auto const SLOT_5845386305c0) {

auto const [slot_first5845386305c0, slot_second5845386305c0] = SLOT_5845386305c0;
if (!(true)) return;
uint64_t KEY_5845385e9110 = 0;
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_584538630340[slot_second584538630340 * 1 + 0]];
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_orders__o_orderdate);

KEY_5845385e9110 |= reg_map0__tmp_attr0;
//Create aggregation hash table
HT_5845385e9110.insert(cuco::pair{KEY_5845385e9110, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_584538637b20(uint64_t* BUF_584538630340, uint64_t* BUF_584538630450, uint64_t* BUF_5845386305c0, HASHTABLE_FIND HT_5845385e9110, HASHTABLE_PROBE HT_584538630340, HASHTABLE_PROBE HT_584538630450, HASHTABLE_PROBE HT_5845386305c0, DBI64Type* KEY_5845385e9110map0__tmp_attr0, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_partkey, DBDecimalType* lineitem__l_quantity, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBDateType* orders__o_orderdate, DBDecimalType* partsupp__ps_supplycost) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_584538630340 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_584538630340 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_584538630340.for_each(KEY_584538630340, [&] __device__ (auto const SLOT_584538630340) {
auto const [slot_first584538630340, slot_second584538630340] = SLOT_584538630340;
if (!(true)) return;
uint64_t KEY_584538630450 = 0;
auto reg_lineitem__l_partkey = lineitem__l_partkey[tid];

KEY_584538630450 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_584538630450.for_each(KEY_584538630450, [&] __device__ (auto const SLOT_584538630450) {
auto const [slot_first584538630450, slot_second584538630450] = SLOT_584538630450;
if (!(true)) return;
uint64_t KEY_5845386305c0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_5845386305c0 |= reg_lineitem__l_suppkey;
KEY_5845386305c0 <<= 32;
KEY_5845386305c0 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_5845386305c0.for_each(KEY_5845386305c0, [&] __device__ (auto const SLOT_5845386305c0) {
auto const [slot_first5845386305c0, slot_second5845386305c0] = SLOT_5845386305c0;
if (!(true)) return;
uint64_t KEY_5845385e9110 = 0;
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_584538630340[slot_second584538630340 * 1 + 0]];
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_orders__o_orderdate);

KEY_5845385e9110 |= reg_map0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_5845385e9110 = HT_5845385e9110.find(KEY_5845385e9110)->second;
auto reg_lineitem__l_quantity = lineitem__l_quantity[tid];
auto reg_partsupp__ps_supplycost = partsupp__ps_supplycost[BUF_5845386305c0[slot_second5845386305c0 * 3 + 1]];
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = ((reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount))) - ((reg_partsupp__ps_supplycost) * (reg_lineitem__l_quantity));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_5845385e9110], reg_map0__tmp_attr1);
KEY_5845385e9110map0__tmp_attr0[buf_idx_5845385e9110] = reg_map0__tmp_attr0;
});
});
});
}
__global__ void count_58453864e8c0(size_t COUNT5845385e9110, uint64_t* COUNT5845385fc300) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5845385e9110) return;
//Materialize count
atomicAdd((int*)COUNT5845385fc300, 1);
}
__global__ void main_58453864e8c0(size_t COUNT5845385e9110, DBDecimalType* MAT5845385fc300aggr0__tmp_attr2, DBI64Type* MAT5845385fc300map0__tmp_attr0, uint64_t* MAT_IDX5845385fc300, DBDecimalType* aggr0__tmp_attr2, DBI64Type* map0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5845385e9110) return;
//Materialize buffers
auto mat_idx5845385fc300 = atomicAdd((int*)MAT_IDX5845385fc300, 1);
auto reg_map0__tmp_attr0 = map0__tmp_attr0[tid];
MAT5845385fc300map0__tmp_attr0[mat_idx5845385fc300] = reg_map0__tmp_attr0;
auto reg_aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
MAT5845385fc300aggr0__tmp_attr2[mat_idx5845385fc300] = reg_aggr0__tmp_attr2;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT58453862c730;
cudaMalloc(&d_COUNT58453862c730, sizeof(uint64_t));
cudaMemset(d_COUNT58453862c730, 0, sizeof(uint64_t));
count_58453863ae50<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT58453862c730, nation_size);
uint64_t COUNT58453862c730;
cudaMemcpy(&COUNT58453862c730, d_COUNT58453862c730, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT58453862c730);
// Insert hash table control;
uint64_t* d_BUF_IDX_58453862c730;
cudaMalloc(&d_BUF_IDX_58453862c730, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_58453862c730, 0, sizeof(uint64_t));
uint64_t* d_BUF_58453862c730;
cudaMalloc(&d_BUF_58453862c730, sizeof(uint64_t) * COUNT58453862c730 * 1);
auto d_HT_58453862c730 = cuco::experimental::static_multimap{ (int)COUNT58453862c730*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_58453863ae50<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_58453862c730, d_BUF_IDX_58453862c730, d_HT_58453862c730.ref(cuco::insert), d_nation__n_nationkey, nation_size);
cudaFree(d_BUF_IDX_58453862c730);
//Materialize count
uint64_t* d_COUNT58453862ccc0;
cudaMalloc(&d_COUNT58453862ccc0, sizeof(uint64_t));
cudaMemset(d_COUNT58453862ccc0, 0, sizeof(uint64_t));
count_5845385b6ea0<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_58453862c730, d_COUNT58453862ccc0, d_HT_58453862c730.ref(cuco::for_each), d_supplier__s_nationkey, supplier_size);
uint64_t COUNT58453862ccc0;
cudaMemcpy(&COUNT58453862ccc0, d_COUNT58453862ccc0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT58453862ccc0);
// Insert hash table control;
uint64_t* d_BUF_IDX_58453862ccc0;
cudaMalloc(&d_BUF_IDX_58453862ccc0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_58453862ccc0, 0, sizeof(uint64_t));
uint64_t* d_BUF_58453862ccc0;
cudaMalloc(&d_BUF_58453862ccc0, sizeof(uint64_t) * COUNT58453862ccc0 * 2);
auto d_HT_58453862ccc0 = cuco::experimental::static_multimap{ (int)COUNT58453862ccc0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5845385b6ea0<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_58453862c730, d_BUF_58453862ccc0, d_BUF_IDX_58453862ccc0, d_HT_58453862c730.ref(cuco::for_each), d_HT_58453862ccc0.ref(cuco::insert), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
cudaFree(d_BUF_IDX_58453862ccc0);
//Materialize count
uint64_t* d_COUNT584538630340;
cudaMalloc(&d_COUNT584538630340, sizeof(uint64_t));
cudaMemset(d_COUNT584538630340, 0, sizeof(uint64_t));
count_5845386402c0<<<std::ceil((float)orders_size/32.), 32>>>(d_COUNT584538630340, orders_size);
uint64_t COUNT584538630340;
cudaMemcpy(&COUNT584538630340, d_COUNT584538630340, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT584538630340);
// Insert hash table control;
uint64_t* d_BUF_IDX_584538630340;
cudaMalloc(&d_BUF_IDX_584538630340, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_584538630340, 0, sizeof(uint64_t));
uint64_t* d_BUF_584538630340;
cudaMalloc(&d_BUF_584538630340, sizeof(uint64_t) * COUNT584538630340 * 1);
auto d_HT_584538630340 = cuco::experimental::static_multimap{ (int)COUNT584538630340*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5845386402c0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_584538630340, d_BUF_IDX_584538630340, d_HT_584538630340.ref(cuco::insert), d_orders__o_orderkey, orders_size);
cudaFree(d_BUF_IDX_584538630340);
//Materialize count
uint64_t* d_COUNT584538630450;
cudaMalloc(&d_COUNT584538630450, sizeof(uint64_t));
cudaMemset(d_COUNT584538630450, 0, sizeof(uint64_t));
count_584538533fd0<<<std::ceil((float)part_size/32.), 32>>>(d_COUNT584538630450, part_size);
uint64_t COUNT584538630450;
cudaMemcpy(&COUNT584538630450, d_COUNT584538630450, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT584538630450);
// Insert hash table control;
uint64_t* d_BUF_IDX_584538630450;
cudaMalloc(&d_BUF_IDX_584538630450, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_584538630450, 0, sizeof(uint64_t));
uint64_t* d_BUF_584538630450;
cudaMalloc(&d_BUF_584538630450, sizeof(uint64_t) * COUNT584538630450 * 1);
auto d_HT_584538630450 = cuco::experimental::static_multimap{ (int)COUNT584538630450*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_584538533fd0<<<std::ceil((float)part_size/32.), 32>>>(d_BUF_584538630450, d_BUF_IDX_584538630450, d_HT_584538630450.ref(cuco::insert), d_part__p_partkey, part_size);
cudaFree(d_BUF_IDX_584538630450);
//Materialize count
uint64_t* d_COUNT5845386305c0;
cudaMalloc(&d_COUNT5845386305c0, sizeof(uint64_t));
cudaMemset(d_COUNT5845386305c0, 0, sizeof(uint64_t));
count_584538639f70<<<std::ceil((float)partsupp_size/32.), 32>>>(d_BUF_58453862ccc0, d_COUNT5845386305c0, d_HT_58453862ccc0.ref(cuco::for_each), d_partsupp__ps_suppkey, partsupp_size);
uint64_t COUNT5845386305c0;
cudaMemcpy(&COUNT5845386305c0, d_COUNT5845386305c0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5845386305c0);
// Insert hash table control;
uint64_t* d_BUF_IDX_5845386305c0;
cudaMalloc(&d_BUF_IDX_5845386305c0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5845386305c0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5845386305c0;
cudaMalloc(&d_BUF_5845386305c0, sizeof(uint64_t) * COUNT5845386305c0 * 3);
auto d_HT_5845386305c0 = cuco::experimental::static_multimap{ (int)COUNT5845386305c0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_584538639f70<<<std::ceil((float)partsupp_size/32.), 32>>>(d_BUF_58453862ccc0, d_BUF_5845386305c0, d_BUF_IDX_5845386305c0, d_HT_58453862ccc0.ref(cuco::for_each), d_HT_5845386305c0.ref(cuco::insert), d_partsupp__ps_partkey, d_partsupp__ps_suppkey, partsupp_size, d_supplier__s_suppkey);
cudaFree(d_BUF_IDX_5845386305c0);
//Create aggregation hash table
auto d_HT_5845385e9110 = cuco::static_map{ (int)48009721*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_584538637b20<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_584538630340, d_BUF_584538630450, d_BUF_5845386305c0, d_HT_5845385e9110.ref(cuco::insert), d_HT_584538630340.ref(cuco::for_each), d_HT_584538630450.ref(cuco::for_each), d_HT_5845386305c0.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_partkey, d_lineitem__l_suppkey, lineitem_size, d_orders__o_orderdate);
size_t COUNT5845385e9110 = d_HT_5845385e9110.size();
thrust::device_vector<int64_t> keys_5845385e9110(COUNT5845385e9110), vals_5845385e9110(COUNT5845385e9110);
d_HT_5845385e9110.retrieve_all(keys_5845385e9110.begin(), vals_5845385e9110.begin());
thrust::host_vector<int64_t> h_keys_5845385e9110(COUNT5845385e9110);
thrust::copy(keys_5845385e9110.begin(), keys_5845385e9110.end(), h_keys_5845385e9110.begin());
thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_5845385e9110(COUNT5845385e9110);
for (int i=0; i < COUNT5845385e9110; i++)
{actual_dict_5845385e9110[i] = cuco::make_pair(h_keys_5845385e9110[i], i);}
d_HT_5845385e9110.clear();
d_HT_5845385e9110.insert(actual_dict_5845385e9110.begin(), actual_dict_5845385e9110.end());
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT5845385e9110);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT5845385e9110);
DBI64Type* d_KEY_5845385e9110map0__tmp_attr0;
cudaMalloc(&d_KEY_5845385e9110map0__tmp_attr0, sizeof(DBI64Type) * COUNT5845385e9110);
cudaMemset(d_KEY_5845385e9110map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT5845385e9110);
main_584538637b20<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_584538630340, d_BUF_584538630450, d_BUF_5845386305c0, d_HT_5845385e9110.ref(cuco::find), d_HT_584538630340.ref(cuco::for_each), d_HT_584538630450.ref(cuco::for_each), d_HT_5845386305c0.ref(cuco::for_each), d_KEY_5845385e9110map0__tmp_attr0, d_aggr0__tmp_attr2, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_partkey, d_lineitem__l_quantity, d_lineitem__l_suppkey, lineitem_size, d_orders__o_orderdate, d_partsupp__ps_supplycost);
//Materialize count
uint64_t* d_COUNT5845385fc300;
cudaMalloc(&d_COUNT5845385fc300, sizeof(uint64_t));
cudaMemset(d_COUNT5845385fc300, 0, sizeof(uint64_t));
count_58453864e8c0<<<std::ceil((float)COUNT5845385e9110/32.), 32>>>(COUNT5845385e9110, d_COUNT5845385fc300);
uint64_t COUNT5845385fc300;
cudaMemcpy(&COUNT5845385fc300, d_COUNT5845385fc300, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5845385fc300);
//Materialize buffers
uint64_t* d_MAT_IDX5845385fc300;
cudaMalloc(&d_MAT_IDX5845385fc300, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5845385fc300, 0, sizeof(uint64_t));
auto MAT5845385fc300map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT5845385fc300);
DBI64Type* d_MAT5845385fc300map0__tmp_attr0;
cudaMalloc(&d_MAT5845385fc300map0__tmp_attr0, sizeof(DBI64Type) * COUNT5845385fc300);
auto MAT5845385fc300aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5845385fc300);
DBDecimalType* d_MAT5845385fc300aggr0__tmp_attr2;
cudaMalloc(&d_MAT5845385fc300aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT5845385fc300);
main_58453864e8c0<<<std::ceil((float)COUNT5845385e9110/32.), 32>>>(COUNT5845385e9110, d_MAT5845385fc300aggr0__tmp_attr2, d_MAT5845385fc300map0__tmp_attr0, d_MAT_IDX5845385fc300, d_aggr0__tmp_attr2, d_KEY_5845385e9110map0__tmp_attr0);
cudaFree(d_MAT_IDX5845385fc300);
cudaMemcpy(MAT5845385fc300map0__tmp_attr0, d_MAT5845385fc300map0__tmp_attr0, sizeof(DBI64Type) * COUNT5845385fc300, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5845385fc300aggr0__tmp_attr2, d_MAT5845385fc300aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT5845385fc300, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5845385fc300; i++) { std::cout << MAT5845385fc300map0__tmp_attr0[i] << "\t";
std::cout << MAT5845385fc300aggr0__tmp_attr2[i] << "\t";
std::cout << std::endl; }
}