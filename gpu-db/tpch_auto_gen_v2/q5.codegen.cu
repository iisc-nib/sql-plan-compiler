#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_6476f24fdae0(uint64_t* COUNT6476f24ee790, DBStringType* region__r_name, size_t region_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= region_size) return;
auto reg_region__r_name = region__r_name[tid];
if (!(evaluatePredicate(reg_region__r_name, "ASIA", Predicate::eq))) return;
//Materialize count
atomicAdd((int*)COUNT6476f24ee790, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_6476f24fdae0(uint64_t* BUF_6476f24ee790, uint64_t* BUF_IDX_6476f24ee790, HASHTABLE_INSERT HT_6476f24ee790, DBStringType* region__r_name, DBI32Type* region__r_regionkey, size_t region_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= region_size) return;
auto reg_region__r_name = region__r_name[tid];
if (!(evaluatePredicate(reg_region__r_name, "ASIA", Predicate::eq))) return;
uint64_t KEY_6476f24ee790 = 0;
auto reg_region__r_regionkey = region__r_regionkey[tid];

KEY_6476f24ee790 |= reg_region__r_regionkey;
// Insert hash table kernel;
auto buf_idx_6476f24ee790 = atomicAdd((int*)BUF_IDX_6476f24ee790, 1);
HT_6476f24ee790.insert(cuco::pair{KEY_6476f24ee790, buf_idx_6476f24ee790});
BUF_6476f24ee790[buf_idx_6476f24ee790 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_6476f24fe9d0(uint64_t* BUF_6476f24ee790, uint64_t* COUNT6476f24f42c0, HASHTABLE_PROBE HT_6476f24ee790, DBI32Type* nation__n_regionkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_6476f24ee790 = 0;
auto reg_nation__n_regionkey = nation__n_regionkey[tid];

KEY_6476f24ee790 |= reg_nation__n_regionkey;
//Probe Hash table
HT_6476f24ee790.for_each(KEY_6476f24ee790, [&] __device__ (auto const SLOT_6476f24ee790) {

auto const [slot_first6476f24ee790, slot_second6476f24ee790] = SLOT_6476f24ee790;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT6476f24f42c0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_6476f24fe9d0(uint64_t* BUF_6476f24ee790, uint64_t* BUF_6476f24f42c0, uint64_t* BUF_IDX_6476f24f42c0, HASHTABLE_PROBE HT_6476f24ee790, HASHTABLE_INSERT HT_6476f24f42c0, DBI32Type* nation__n_nationkey, DBI32Type* nation__n_regionkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_6476f24ee790 = 0;
auto reg_nation__n_regionkey = nation__n_regionkey[tid];

KEY_6476f24ee790 |= reg_nation__n_regionkey;
//Probe Hash table
HT_6476f24ee790.for_each(KEY_6476f24ee790, [&] __device__ (auto const SLOT_6476f24ee790) {
auto const [slot_first6476f24ee790, slot_second6476f24ee790] = SLOT_6476f24ee790;
if (!(true)) return;
uint64_t KEY_6476f24f42c0 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_6476f24f42c0 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_6476f24f42c0 = atomicAdd((int*)BUF_IDX_6476f24f42c0, 1);
HT_6476f24f42c0.insert(cuco::pair{KEY_6476f24f42c0, buf_idx_6476f24f42c0});
BUF_6476f24f42c0[buf_idx_6476f24f42c0 * 2 + 0] = BUF_6476f24ee790[slot_second6476f24ee790 * 1 + 0];
BUF_6476f24f42c0[buf_idx_6476f24f42c0 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_6476f24db130(uint64_t* BUF_6476f24f42c0, uint64_t* COUNT6476f24ee210, HASHTABLE_PROBE HT_6476f24f42c0, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_6476f24f42c0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_6476f24f42c0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_6476f24f42c0.for_each(KEY_6476f24f42c0, [&] __device__ (auto const SLOT_6476f24f42c0) {

auto const [slot_first6476f24f42c0, slot_second6476f24f42c0] = SLOT_6476f24f42c0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT6476f24ee210, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_6476f24db130(uint64_t* BUF_6476f24ee210, uint64_t* BUF_6476f24f42c0, uint64_t* BUF_IDX_6476f24ee210, HASHTABLE_INSERT HT_6476f24ee210, HASHTABLE_PROBE HT_6476f24f42c0, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_6476f24f42c0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_6476f24f42c0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_6476f24f42c0.for_each(KEY_6476f24f42c0, [&] __device__ (auto const SLOT_6476f24f42c0) {
auto const [slot_first6476f24f42c0, slot_second6476f24f42c0] = SLOT_6476f24f42c0;
if (!(true)) return;
uint64_t KEY_6476f24ee210 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_6476f24ee210 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_6476f24ee210 = atomicAdd((int*)BUF_IDX_6476f24ee210, 1);
HT_6476f24ee210.insert(cuco::pair{KEY_6476f24ee210, buf_idx_6476f24ee210});
BUF_6476f24ee210[buf_idx_6476f24ee210 * 3 + 0] = tid;
BUF_6476f24ee210[buf_idx_6476f24ee210 * 3 + 1] = BUF_6476f24f42c0[slot_second6476f24f42c0 * 2 + 0];
BUF_6476f24ee210[buf_idx_6476f24ee210 * 3 + 2] = BUF_6476f24f42c0[slot_second6476f24f42c0 * 2 + 1];
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_6476f24db6a0(uint64_t* BUF_6476f24ee210, uint64_t* COUNT6476f24f67b0, HASHTABLE_PROBE HT_6476f24ee210, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 9131, Predicate::lt))) return;
uint64_t KEY_6476f24ee210 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_6476f24ee210 |= reg_orders__o_custkey;
//Probe Hash table
HT_6476f24ee210.for_each(KEY_6476f24ee210, [&] __device__ (auto const SLOT_6476f24ee210) {

auto const [slot_first6476f24ee210, slot_second6476f24ee210] = SLOT_6476f24ee210;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT6476f24f67b0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_6476f24db6a0(uint64_t* BUF_6476f24ee210, uint64_t* BUF_6476f24f67b0, uint64_t* BUF_IDX_6476f24f67b0, HASHTABLE_PROBE HT_6476f24ee210, HASHTABLE_INSERT HT_6476f24f67b0, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 9131, Predicate::lt))) return;
uint64_t KEY_6476f24ee210 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_6476f24ee210 |= reg_orders__o_custkey;
//Probe Hash table
HT_6476f24ee210.for_each(KEY_6476f24ee210, [&] __device__ (auto const SLOT_6476f24ee210) {
auto const [slot_first6476f24ee210, slot_second6476f24ee210] = SLOT_6476f24ee210;
if (!(true)) return;
uint64_t KEY_6476f24f67b0 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_6476f24f67b0 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_6476f24f67b0 = atomicAdd((int*)BUF_IDX_6476f24f67b0, 1);
HT_6476f24f67b0.insert(cuco::pair{KEY_6476f24f67b0, buf_idx_6476f24f67b0});
BUF_6476f24f67b0[buf_idx_6476f24f67b0 * 4 + 0] = BUF_6476f24ee210[slot_second6476f24ee210 * 3 + 0];
BUF_6476f24f67b0[buf_idx_6476f24f67b0 * 4 + 1] = tid;
BUF_6476f24f67b0[buf_idx_6476f24f67b0 * 4 + 2] = BUF_6476f24ee210[slot_second6476f24ee210 * 3 + 1];
BUF_6476f24f67b0[buf_idx_6476f24f67b0 * 4 + 3] = BUF_6476f24ee210[slot_second6476f24ee210 * 3 + 2];
});
}
__global__ void count_6476f2507010(uint64_t* COUNT6476f24f68c0, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
//Materialize count
atomicAdd((int*)COUNT6476f24f68c0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_6476f2507010(uint64_t* BUF_6476f24f68c0, uint64_t* BUF_IDX_6476f24f68c0, HASHTABLE_INSERT HT_6476f24f68c0, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_6476f24f68c0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_6476f24f68c0 |= reg_supplier__s_suppkey;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];
KEY_6476f24f68c0 <<= 32;
KEY_6476f24f68c0 |= reg_supplier__s_nationkey;
// Insert hash table kernel;
auto buf_idx_6476f24f68c0 = atomicAdd((int*)BUF_IDX_6476f24f68c0, 1);
HT_6476f24f68c0.insert(cuco::pair{KEY_6476f24f68c0, buf_idx_6476f24f68c0});
BUF_6476f24f68c0[buf_idx_6476f24f68c0 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_6476f24fb590(uint64_t* BUF_6476f24f67b0, uint64_t* BUF_6476f24f68c0, HASHTABLE_INSERT HT_6476f24aa320, HASHTABLE_PROBE HT_6476f24f67b0, HASHTABLE_PROBE HT_6476f24f68c0, DBI32Type* customer__c_nationkey, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_6476f24f67b0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_6476f24f67b0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_6476f24f67b0.for_each(KEY_6476f24f67b0, [&] __device__ (auto const SLOT_6476f24f67b0) {

auto const [slot_first6476f24f67b0, slot_second6476f24f67b0] = SLOT_6476f24f67b0;
if (!(true)) return;
uint64_t KEY_6476f24f68c0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_6476f24f68c0 |= reg_lineitem__l_suppkey;
auto reg_customer__c_nationkey = customer__c_nationkey[BUF_6476f24f67b0[slot_second6476f24f67b0 * 4 + 0]];
KEY_6476f24f68c0 <<= 32;
KEY_6476f24f68c0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_6476f24f68c0.for_each(KEY_6476f24f68c0, [&] __device__ (auto const SLOT_6476f24f68c0) {

auto const [slot_first6476f24f68c0, slot_second6476f24f68c0] = SLOT_6476f24f68c0;
if (!(true)) return;
uint64_t KEY_6476f24aa320 = 0;
//Create aggregation hash table
HT_6476f24aa320.insert(cuco::pair{KEY_6476f24aa320, 1});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_6476f24fb590(uint64_t* BUF_6476f24f67b0, uint64_t* BUF_6476f24f68c0, HASHTABLE_FIND HT_6476f24aa320, HASHTABLE_PROBE HT_6476f24f67b0, HASHTABLE_PROBE HT_6476f24f68c0, DBDecimalType* aggr0__tmp_attr0, DBI32Type* customer__c_nationkey, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_6476f24f67b0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_6476f24f67b0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_6476f24f67b0.for_each(KEY_6476f24f67b0, [&] __device__ (auto const SLOT_6476f24f67b0) {
auto const [slot_first6476f24f67b0, slot_second6476f24f67b0] = SLOT_6476f24f67b0;
if (!(true)) return;
uint64_t KEY_6476f24f68c0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_6476f24f68c0 |= reg_lineitem__l_suppkey;
auto reg_customer__c_nationkey = customer__c_nationkey[BUF_6476f24f67b0[slot_second6476f24f67b0 * 4 + 0]];
KEY_6476f24f68c0 <<= 32;
KEY_6476f24f68c0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_6476f24f68c0.for_each(KEY_6476f24f68c0, [&] __device__ (auto const SLOT_6476f24f68c0) {
auto const [slot_first6476f24f68c0, slot_second6476f24f68c0] = SLOT_6476f24f68c0;
if (!(true)) return;
uint64_t KEY_6476f24aa320 = 0;
//Aggregate in hashtable
auto buf_idx_6476f24aa320 = HT_6476f24aa320.find(KEY_6476f24aa320)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_6476f24aa320], reg_map0__tmp_attr1);
});
});
}
__global__ void count_6476f250f860(size_t COUNT6476f24aa320, uint64_t* COUNT6476f24bda90) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT6476f24aa320) return;
//Materialize count
atomicAdd((int*)COUNT6476f24bda90, 1);
}
__global__ void main_6476f250f860(size_t COUNT6476f24aa320, DBDecimalType* MAT6476f24bda90aggr0__tmp_attr0, uint64_t* MAT_IDX6476f24bda90, DBDecimalType* aggr0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT6476f24aa320) return;
//Materialize buffers
auto mat_idx6476f24bda90 = atomicAdd((int*)MAT_IDX6476f24bda90, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT6476f24bda90aggr0__tmp_attr0[mat_idx6476f24bda90] = reg_aggr0__tmp_attr0;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT6476f24ee790;
cudaMalloc(&d_COUNT6476f24ee790, sizeof(uint64_t));
cudaMemset(d_COUNT6476f24ee790, 0, sizeof(uint64_t));
count_6476f24fdae0<<<std::ceil((float)region_size/32.), 32>>>(d_COUNT6476f24ee790, d_region__r_name, region_size);
uint64_t COUNT6476f24ee790;
cudaMemcpy(&COUNT6476f24ee790, d_COUNT6476f24ee790, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_6476f24ee790;
cudaMalloc(&d_BUF_IDX_6476f24ee790, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6476f24ee790, 0, sizeof(uint64_t));
uint64_t* d_BUF_6476f24ee790;
cudaMalloc(&d_BUF_6476f24ee790, sizeof(uint64_t) * COUNT6476f24ee790 * 1);
auto d_HT_6476f24ee790 = cuco::experimental::static_multimap{ (int)COUNT6476f24ee790*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6476f24fdae0<<<std::ceil((float)region_size/32.), 32>>>(d_BUF_6476f24ee790, d_BUF_IDX_6476f24ee790, d_HT_6476f24ee790.ref(cuco::insert), d_region__r_name, d_region__r_regionkey, region_size);
//Materialize count
uint64_t* d_COUNT6476f24f42c0;
cudaMalloc(&d_COUNT6476f24f42c0, sizeof(uint64_t));
cudaMemset(d_COUNT6476f24f42c0, 0, sizeof(uint64_t));
count_6476f24fe9d0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_6476f24ee790, d_COUNT6476f24f42c0, d_HT_6476f24ee790.ref(cuco::for_each), d_nation__n_regionkey, nation_size);
uint64_t COUNT6476f24f42c0;
cudaMemcpy(&COUNT6476f24f42c0, d_COUNT6476f24f42c0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_6476f24f42c0;
cudaMalloc(&d_BUF_IDX_6476f24f42c0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6476f24f42c0, 0, sizeof(uint64_t));
uint64_t* d_BUF_6476f24f42c0;
cudaMalloc(&d_BUF_6476f24f42c0, sizeof(uint64_t) * COUNT6476f24f42c0 * 2);
auto d_HT_6476f24f42c0 = cuco::experimental::static_multimap{ (int)COUNT6476f24f42c0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6476f24fe9d0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_6476f24ee790, d_BUF_6476f24f42c0, d_BUF_IDX_6476f24f42c0, d_HT_6476f24ee790.ref(cuco::for_each), d_HT_6476f24f42c0.ref(cuco::insert), d_nation__n_nationkey, d_nation__n_regionkey, nation_size);
//Materialize count
uint64_t* d_COUNT6476f24ee210;
cudaMalloc(&d_COUNT6476f24ee210, sizeof(uint64_t));
cudaMemset(d_COUNT6476f24ee210, 0, sizeof(uint64_t));
count_6476f24db130<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_6476f24f42c0, d_COUNT6476f24ee210, d_HT_6476f24f42c0.ref(cuco::for_each), d_customer__c_nationkey, customer_size);
uint64_t COUNT6476f24ee210;
cudaMemcpy(&COUNT6476f24ee210, d_COUNT6476f24ee210, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_6476f24ee210;
cudaMalloc(&d_BUF_IDX_6476f24ee210, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6476f24ee210, 0, sizeof(uint64_t));
uint64_t* d_BUF_6476f24ee210;
cudaMalloc(&d_BUF_6476f24ee210, sizeof(uint64_t) * COUNT6476f24ee210 * 3);
auto d_HT_6476f24ee210 = cuco::experimental::static_multimap{ (int)COUNT6476f24ee210*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6476f24db130<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_6476f24ee210, d_BUF_6476f24f42c0, d_BUF_IDX_6476f24ee210, d_HT_6476f24ee210.ref(cuco::insert), d_HT_6476f24f42c0.ref(cuco::for_each), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
//Materialize count
uint64_t* d_COUNT6476f24f67b0;
cudaMalloc(&d_COUNT6476f24f67b0, sizeof(uint64_t));
cudaMemset(d_COUNT6476f24f67b0, 0, sizeof(uint64_t));
count_6476f24db6a0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_6476f24ee210, d_COUNT6476f24f67b0, d_HT_6476f24ee210.ref(cuco::for_each), d_orders__o_custkey, d_orders__o_orderdate, orders_size);
uint64_t COUNT6476f24f67b0;
cudaMemcpy(&COUNT6476f24f67b0, d_COUNT6476f24f67b0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_6476f24f67b0;
cudaMalloc(&d_BUF_IDX_6476f24f67b0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6476f24f67b0, 0, sizeof(uint64_t));
uint64_t* d_BUF_6476f24f67b0;
cudaMalloc(&d_BUF_6476f24f67b0, sizeof(uint64_t) * COUNT6476f24f67b0 * 4);
auto d_HT_6476f24f67b0 = cuco::experimental::static_multimap{ (int)COUNT6476f24f67b0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6476f24db6a0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_6476f24ee210, d_BUF_6476f24f67b0, d_BUF_IDX_6476f24f67b0, d_HT_6476f24ee210.ref(cuco::for_each), d_HT_6476f24f67b0.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
//Materialize count
uint64_t* d_COUNT6476f24f68c0;
cudaMalloc(&d_COUNT6476f24f68c0, sizeof(uint64_t));
cudaMemset(d_COUNT6476f24f68c0, 0, sizeof(uint64_t));
count_6476f2507010<<<std::ceil((float)supplier_size/32.), 32>>>(d_COUNT6476f24f68c0, supplier_size);
uint64_t COUNT6476f24f68c0;
cudaMemcpy(&COUNT6476f24f68c0, d_COUNT6476f24f68c0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_6476f24f68c0;
cudaMalloc(&d_BUF_IDX_6476f24f68c0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6476f24f68c0, 0, sizeof(uint64_t));
uint64_t* d_BUF_6476f24f68c0;
cudaMalloc(&d_BUF_6476f24f68c0, sizeof(uint64_t) * COUNT6476f24f68c0 * 1);
auto d_HT_6476f24f68c0 = cuco::experimental::static_multimap{ (int)COUNT6476f24f68c0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6476f2507010<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_6476f24f68c0, d_BUF_IDX_6476f24f68c0, d_HT_6476f24f68c0.ref(cuco::insert), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
//Create aggregation hash table
auto d_HT_6476f24aa320 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_6476f24fb590<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_6476f24f67b0, d_BUF_6476f24f68c0, d_HT_6476f24aa320.ref(cuco::insert), d_HT_6476f24f67b0.ref(cuco::for_each), d_HT_6476f24f68c0.ref(cuco::for_each), d_customer__c_nationkey, d_lineitem__l_orderkey, d_lineitem__l_suppkey, lineitem_size);
size_t COUNT6476f24aa320 = d_HT_6476f24aa320.size();
thrust::device_vector<int64_t> keys_6476f24aa320(COUNT6476f24aa320), vals_6476f24aa320(COUNT6476f24aa320);
d_HT_6476f24aa320.retrieve_all(keys_6476f24aa320.begin(), vals_6476f24aa320.begin());
d_HT_6476f24aa320.clear();
int64_t* raw_keys6476f24aa320 = thrust::raw_pointer_cast(keys_6476f24aa320.data());
insertKeys<<<std::ceil((float)COUNT6476f24aa320/32.), 32>>>(raw_keys6476f24aa320, d_HT_6476f24aa320.ref(cuco::insert), COUNT6476f24aa320);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6476f24aa320);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT6476f24aa320);
main_6476f24fb590<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_6476f24f67b0, d_BUF_6476f24f68c0, d_HT_6476f24aa320.ref(cuco::find), d_HT_6476f24f67b0.ref(cuco::for_each), d_HT_6476f24f68c0.ref(cuco::for_each), d_aggr0__tmp_attr0, d_customer__c_nationkey, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_suppkey, lineitem_size);
//Materialize count
uint64_t* d_COUNT6476f24bda90;
cudaMalloc(&d_COUNT6476f24bda90, sizeof(uint64_t));
cudaMemset(d_COUNT6476f24bda90, 0, sizeof(uint64_t));
count_6476f250f860<<<std::ceil((float)COUNT6476f24aa320/32.), 32>>>(COUNT6476f24aa320, d_COUNT6476f24bda90);
uint64_t COUNT6476f24bda90;
cudaMemcpy(&COUNT6476f24bda90, d_COUNT6476f24bda90, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX6476f24bda90;
cudaMalloc(&d_MAT_IDX6476f24bda90, sizeof(uint64_t));
cudaMemset(d_MAT_IDX6476f24bda90, 0, sizeof(uint64_t));
auto MAT6476f24bda90aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT6476f24bda90);
DBDecimalType* d_MAT6476f24bda90aggr0__tmp_attr0;
cudaMalloc(&d_MAT6476f24bda90aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6476f24bda90);
main_6476f250f860<<<std::ceil((float)COUNT6476f24aa320/32.), 32>>>(COUNT6476f24aa320, d_MAT6476f24bda90aggr0__tmp_attr0, d_MAT_IDX6476f24bda90, d_aggr0__tmp_attr0);
cudaMemcpy(MAT6476f24bda90aggr0__tmp_attr0, d_MAT6476f24bda90aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6476f24bda90, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT6476f24bda90; i++) { std::cout << MAT6476f24bda90aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_6476f24ee790);
cudaFree(d_BUF_IDX_6476f24ee790);
cudaFree(d_COUNT6476f24ee790);
cudaFree(d_BUF_6476f24f42c0);
cudaFree(d_BUF_IDX_6476f24f42c0);
cudaFree(d_COUNT6476f24f42c0);
cudaFree(d_BUF_6476f24ee210);
cudaFree(d_BUF_IDX_6476f24ee210);
cudaFree(d_COUNT6476f24ee210);
cudaFree(d_BUF_6476f24f67b0);
cudaFree(d_BUF_IDX_6476f24f67b0);
cudaFree(d_COUNT6476f24f67b0);
cudaFree(d_BUF_6476f24f68c0);
cudaFree(d_BUF_IDX_6476f24f68c0);
cudaFree(d_COUNT6476f24f68c0);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT6476f24bda90);
cudaFree(d_MAT6476f24bda90aggr0__tmp_attr0);
cudaFree(d_MAT_IDX6476f24bda90);
free(MAT6476f24bda90aggr0__tmp_attr0);
}