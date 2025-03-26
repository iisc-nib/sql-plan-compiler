#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_6064ce1e8a40(uint64_t* COUNT6064ce1d81b0, DBStringType* region__r_name, size_t region_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= region_size) return;
auto reg_region__r_name = region__r_name[tid];
if (!(evaluatePredicate(reg_region__r_name, "ASIA", Predicate::eq))) return;
//Materialize count
atomicAdd((int*)COUNT6064ce1d81b0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_6064ce1e8a40(uint64_t* BUF_6064ce1d81b0, uint64_t* BUF_IDX_6064ce1d81b0, HASHTABLE_INSERT HT_6064ce1d81b0, DBStringType* region__r_name, DBI32Type* region__r_regionkey, size_t region_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= region_size) return;
auto reg_region__r_name = region__r_name[tid];
if (!(evaluatePredicate(reg_region__r_name, "ASIA", Predicate::eq))) return;
uint64_t KEY_6064ce1d81b0 = 0;
auto reg_region__r_regionkey = region__r_regionkey[tid];

KEY_6064ce1d81b0 |= reg_region__r_regionkey;
// Insert hash table kernel;
auto buf_idx_6064ce1d81b0 = atomicAdd((int*)BUF_IDX_6064ce1d81b0, 1);
HT_6064ce1d81b0.insert(cuco::pair{KEY_6064ce1d81b0, buf_idx_6064ce1d81b0});
BUF_6064ce1d81b0[buf_idx_6064ce1d81b0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_6064ce1e98d0(uint64_t* BUF_6064ce1d81b0, uint64_t* COUNT6064ce1d84a0, HASHTABLE_PROBE HT_6064ce1d81b0, DBI32Type* nation__n_regionkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_6064ce1d81b0 = 0;
auto reg_nation__n_regionkey = nation__n_regionkey[tid];

KEY_6064ce1d81b0 |= reg_nation__n_regionkey;
//Probe Hash table
HT_6064ce1d81b0.for_each(KEY_6064ce1d81b0, [&] __device__ (auto const SLOT_6064ce1d81b0) {

auto const [slot_first6064ce1d81b0, slot_second6064ce1d81b0] = SLOT_6064ce1d81b0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT6064ce1d84a0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_6064ce1e98d0(uint64_t* BUF_6064ce1d81b0, uint64_t* BUF_6064ce1d84a0, uint64_t* BUF_IDX_6064ce1d84a0, HASHTABLE_PROBE HT_6064ce1d81b0, HASHTABLE_INSERT HT_6064ce1d84a0, DBI32Type* nation__n_nationkey, DBI32Type* nation__n_regionkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_6064ce1d81b0 = 0;
auto reg_nation__n_regionkey = nation__n_regionkey[tid];

KEY_6064ce1d81b0 |= reg_nation__n_regionkey;
//Probe Hash table
HT_6064ce1d81b0.for_each(KEY_6064ce1d81b0, [&] __device__ (auto const SLOT_6064ce1d81b0) {
auto const [slot_first6064ce1d81b0, slot_second6064ce1d81b0] = SLOT_6064ce1d81b0;
if (!(true)) return;
uint64_t KEY_6064ce1d84a0 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_6064ce1d84a0 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_6064ce1d84a0 = atomicAdd((int*)BUF_IDX_6064ce1d84a0, 1);
HT_6064ce1d84a0.insert(cuco::pair{KEY_6064ce1d84a0, buf_idx_6064ce1d84a0});
BUF_6064ce1d84a0[buf_idx_6064ce1d84a0 * 2 + 0] = BUF_6064ce1d81b0[slot_second6064ce1d81b0 * 1 + 0];
BUF_6064ce1d84a0[buf_idx_6064ce1d84a0 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_6064ce0dedd0(uint64_t* BUF_6064ce1d84a0, uint64_t* COUNT6064ce1e1480, HASHTABLE_PROBE HT_6064ce1d84a0, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_6064ce1d84a0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_6064ce1d84a0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_6064ce1d84a0.for_each(KEY_6064ce1d84a0, [&] __device__ (auto const SLOT_6064ce1d84a0) {

auto const [slot_first6064ce1d84a0, slot_second6064ce1d84a0] = SLOT_6064ce1d84a0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT6064ce1e1480, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_6064ce0dedd0(uint64_t* BUF_6064ce1d84a0, uint64_t* BUF_6064ce1e1480, uint64_t* BUF_IDX_6064ce1e1480, HASHTABLE_PROBE HT_6064ce1d84a0, HASHTABLE_INSERT HT_6064ce1e1480, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_6064ce1d84a0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_6064ce1d84a0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_6064ce1d84a0.for_each(KEY_6064ce1d84a0, [&] __device__ (auto const SLOT_6064ce1d84a0) {
auto const [slot_first6064ce1d84a0, slot_second6064ce1d84a0] = SLOT_6064ce1d84a0;
if (!(true)) return;
uint64_t KEY_6064ce1e1480 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_6064ce1e1480 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_6064ce1e1480 = atomicAdd((int*)BUF_IDX_6064ce1e1480, 1);
HT_6064ce1e1480.insert(cuco::pair{KEY_6064ce1e1480, buf_idx_6064ce1e1480});
BUF_6064ce1e1480[buf_idx_6064ce1e1480 * 3 + 0] = tid;
BUF_6064ce1e1480[buf_idx_6064ce1e1480 * 3 + 1] = BUF_6064ce1d84a0[slot_second6064ce1d84a0 * 2 + 0];
BUF_6064ce1e1480[buf_idx_6064ce1e1480 * 3 + 2] = BUF_6064ce1d84a0[slot_second6064ce1d84a0 * 2 + 1];
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_6064ce162140(uint64_t* BUF_6064ce1e1480, uint64_t* COUNT6064ce1e15f0, HASHTABLE_PROBE HT_6064ce1e1480, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 9131, Predicate::lt))) return;
uint64_t KEY_6064ce1e1480 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_6064ce1e1480 |= reg_orders__o_custkey;
//Probe Hash table
HT_6064ce1e1480.for_each(KEY_6064ce1e1480, [&] __device__ (auto const SLOT_6064ce1e1480) {

auto const [slot_first6064ce1e1480, slot_second6064ce1e1480] = SLOT_6064ce1e1480;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT6064ce1e15f0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_6064ce162140(uint64_t* BUF_6064ce1e1480, uint64_t* BUF_6064ce1e15f0, uint64_t* BUF_IDX_6064ce1e15f0, HASHTABLE_PROBE HT_6064ce1e1480, HASHTABLE_INSERT HT_6064ce1e15f0, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 9131, Predicate::lt))) return;
uint64_t KEY_6064ce1e1480 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_6064ce1e1480 |= reg_orders__o_custkey;
//Probe Hash table
HT_6064ce1e1480.for_each(KEY_6064ce1e1480, [&] __device__ (auto const SLOT_6064ce1e1480) {
auto const [slot_first6064ce1e1480, slot_second6064ce1e1480] = SLOT_6064ce1e1480;
if (!(true)) return;
uint64_t KEY_6064ce1e15f0 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_6064ce1e15f0 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_6064ce1e15f0 = atomicAdd((int*)BUF_IDX_6064ce1e15f0, 1);
HT_6064ce1e15f0.insert(cuco::pair{KEY_6064ce1e15f0, buf_idx_6064ce1e15f0});
BUF_6064ce1e15f0[buf_idx_6064ce1e15f0 * 4 + 0] = BUF_6064ce1e1480[slot_second6064ce1e1480 * 3 + 0];
BUF_6064ce1e15f0[buf_idx_6064ce1e15f0 * 4 + 1] = tid;
BUF_6064ce1e15f0[buf_idx_6064ce1e15f0 * 4 + 2] = BUF_6064ce1e1480[slot_second6064ce1e1480 * 3 + 1];
BUF_6064ce1e15f0[buf_idx_6064ce1e15f0 * 4 + 3] = BUF_6064ce1e1480[slot_second6064ce1e1480 * 3 + 2];
});
}
__global__ void count_6064ce1f1ad0(uint64_t* COUNT6064ce1e1700, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
//Materialize count
atomicAdd((int*)COUNT6064ce1e1700, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_6064ce1f1ad0(uint64_t* BUF_6064ce1e1700, uint64_t* BUF_IDX_6064ce1e1700, HASHTABLE_INSERT HT_6064ce1e1700, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_6064ce1e1700 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_6064ce1e1700 |= reg_supplier__s_suppkey;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];
KEY_6064ce1e1700 <<= 32;
KEY_6064ce1e1700 |= reg_supplier__s_nationkey;
// Insert hash table kernel;
auto buf_idx_6064ce1e1700 = atomicAdd((int*)BUF_IDX_6064ce1e1700, 1);
HT_6064ce1e1700.insert(cuco::pair{KEY_6064ce1e1700, buf_idx_6064ce1e1700});
BUF_6064ce1e1700[buf_idx_6064ce1e1700 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_6064ce1e6780(uint64_t* BUF_6064ce1e15f0, uint64_t* BUF_6064ce1e1700, HASHTABLE_INSERT HT_6064ce195100, HASHTABLE_PROBE HT_6064ce1e15f0, HASHTABLE_PROBE HT_6064ce1e1700, DBI32Type* customer__c_nationkey, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_6064ce1e15f0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_6064ce1e15f0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_6064ce1e15f0.for_each(KEY_6064ce1e15f0, [&] __device__ (auto const SLOT_6064ce1e15f0) {

auto const [slot_first6064ce1e15f0, slot_second6064ce1e15f0] = SLOT_6064ce1e15f0;
if (!(true)) return;
uint64_t KEY_6064ce1e1700 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_6064ce1e1700 |= reg_lineitem__l_suppkey;
auto reg_customer__c_nationkey = customer__c_nationkey[BUF_6064ce1e15f0[slot_second6064ce1e15f0 * 4 + 0]];
KEY_6064ce1e1700 <<= 32;
KEY_6064ce1e1700 |= reg_customer__c_nationkey;
//Probe Hash table
HT_6064ce1e1700.for_each(KEY_6064ce1e1700, [&] __device__ (auto const SLOT_6064ce1e1700) {

auto const [slot_first6064ce1e1700, slot_second6064ce1e1700] = SLOT_6064ce1e1700;
if (!(true)) return;
uint64_t KEY_6064ce195100 = 0;
//Create aggregation hash table
HT_6064ce195100.insert(cuco::pair{KEY_6064ce195100, 1});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_6064ce1e6780(uint64_t* BUF_6064ce1e15f0, uint64_t* BUF_6064ce1e1700, HASHTABLE_FIND HT_6064ce195100, HASHTABLE_PROBE HT_6064ce1e15f0, HASHTABLE_PROBE HT_6064ce1e1700, DBDecimalType* aggr0__tmp_attr0, DBI32Type* customer__c_nationkey, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_6064ce1e15f0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_6064ce1e15f0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_6064ce1e15f0.for_each(KEY_6064ce1e15f0, [&] __device__ (auto const SLOT_6064ce1e15f0) {
auto const [slot_first6064ce1e15f0, slot_second6064ce1e15f0] = SLOT_6064ce1e15f0;
if (!(true)) return;
uint64_t KEY_6064ce1e1700 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_6064ce1e1700 |= reg_lineitem__l_suppkey;
auto reg_customer__c_nationkey = customer__c_nationkey[BUF_6064ce1e15f0[slot_second6064ce1e15f0 * 4 + 0]];
KEY_6064ce1e1700 <<= 32;
KEY_6064ce1e1700 |= reg_customer__c_nationkey;
//Probe Hash table
HT_6064ce1e1700.for_each(KEY_6064ce1e1700, [&] __device__ (auto const SLOT_6064ce1e1700) {
auto const [slot_first6064ce1e1700, slot_second6064ce1e1700] = SLOT_6064ce1e1700;
if (!(true)) return;
uint64_t KEY_6064ce195100 = 0;
//Aggregate in hashtable
auto buf_idx_6064ce195100 = HT_6064ce195100.find(KEY_6064ce195100)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_6064ce195100], reg_map0__tmp_attr1);
});
});
}
__global__ void count_6064ce1faed0(size_t COUNT6064ce195100, uint64_t* COUNT6064ce1a7fa0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT6064ce195100) return;
//Materialize count
atomicAdd((int*)COUNT6064ce1a7fa0, 1);
}
__global__ void main_6064ce1faed0(size_t COUNT6064ce195100, DBDecimalType* MAT6064ce1a7fa0aggr0__tmp_attr0, uint64_t* MAT_IDX6064ce1a7fa0, DBDecimalType* aggr0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT6064ce195100) return;
//Materialize buffers
auto mat_idx6064ce1a7fa0 = atomicAdd((int*)MAT_IDX6064ce1a7fa0, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT6064ce1a7fa0aggr0__tmp_attr0[mat_idx6064ce1a7fa0] = reg_aggr0__tmp_attr0;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT6064ce1d81b0;
cudaMalloc(&d_COUNT6064ce1d81b0, sizeof(uint64_t));
cudaMemset(d_COUNT6064ce1d81b0, 0, sizeof(uint64_t));
count_6064ce1e8a40<<<std::ceil((float)region_size/32.), 32>>>(d_COUNT6064ce1d81b0, d_region__r_name, region_size);
uint64_t COUNT6064ce1d81b0;
cudaMemcpy(&COUNT6064ce1d81b0, d_COUNT6064ce1d81b0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT6064ce1d81b0);
// Insert hash table control;
uint64_t* d_BUF_IDX_6064ce1d81b0;
cudaMalloc(&d_BUF_IDX_6064ce1d81b0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6064ce1d81b0, 0, sizeof(uint64_t));
uint64_t* d_BUF_6064ce1d81b0;
cudaMalloc(&d_BUF_6064ce1d81b0, sizeof(uint64_t) * COUNT6064ce1d81b0 * 1);
auto d_HT_6064ce1d81b0 = cuco::experimental::static_multimap{ (int)COUNT6064ce1d81b0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6064ce1e8a40<<<std::ceil((float)region_size/32.), 32>>>(d_BUF_6064ce1d81b0, d_BUF_IDX_6064ce1d81b0, d_HT_6064ce1d81b0.ref(cuco::insert), d_region__r_name, d_region__r_regionkey, region_size);
cudaFree(d_BUF_IDX_6064ce1d81b0);
//Materialize count
uint64_t* d_COUNT6064ce1d84a0;
cudaMalloc(&d_COUNT6064ce1d84a0, sizeof(uint64_t));
cudaMemset(d_COUNT6064ce1d84a0, 0, sizeof(uint64_t));
count_6064ce1e98d0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_6064ce1d81b0, d_COUNT6064ce1d84a0, d_HT_6064ce1d81b0.ref(cuco::for_each), d_nation__n_regionkey, nation_size);
uint64_t COUNT6064ce1d84a0;
cudaMemcpy(&COUNT6064ce1d84a0, d_COUNT6064ce1d84a0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT6064ce1d84a0);
// Insert hash table control;
uint64_t* d_BUF_IDX_6064ce1d84a0;
cudaMalloc(&d_BUF_IDX_6064ce1d84a0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6064ce1d84a0, 0, sizeof(uint64_t));
uint64_t* d_BUF_6064ce1d84a0;
cudaMalloc(&d_BUF_6064ce1d84a0, sizeof(uint64_t) * COUNT6064ce1d84a0 * 2);
auto d_HT_6064ce1d84a0 = cuco::experimental::static_multimap{ (int)COUNT6064ce1d84a0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6064ce1e98d0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_6064ce1d81b0, d_BUF_6064ce1d84a0, d_BUF_IDX_6064ce1d84a0, d_HT_6064ce1d81b0.ref(cuco::for_each), d_HT_6064ce1d84a0.ref(cuco::insert), d_nation__n_nationkey, d_nation__n_regionkey, nation_size);
cudaFree(d_BUF_IDX_6064ce1d84a0);
//Materialize count
uint64_t* d_COUNT6064ce1e1480;
cudaMalloc(&d_COUNT6064ce1e1480, sizeof(uint64_t));
cudaMemset(d_COUNT6064ce1e1480, 0, sizeof(uint64_t));
count_6064ce0dedd0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_6064ce1d84a0, d_COUNT6064ce1e1480, d_HT_6064ce1d84a0.ref(cuco::for_each), d_customer__c_nationkey, customer_size);
uint64_t COUNT6064ce1e1480;
cudaMemcpy(&COUNT6064ce1e1480, d_COUNT6064ce1e1480, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT6064ce1e1480);
// Insert hash table control;
uint64_t* d_BUF_IDX_6064ce1e1480;
cudaMalloc(&d_BUF_IDX_6064ce1e1480, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6064ce1e1480, 0, sizeof(uint64_t));
uint64_t* d_BUF_6064ce1e1480;
cudaMalloc(&d_BUF_6064ce1e1480, sizeof(uint64_t) * COUNT6064ce1e1480 * 3);
auto d_HT_6064ce1e1480 = cuco::experimental::static_multimap{ (int)COUNT6064ce1e1480*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6064ce0dedd0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_6064ce1d84a0, d_BUF_6064ce1e1480, d_BUF_IDX_6064ce1e1480, d_HT_6064ce1d84a0.ref(cuco::for_each), d_HT_6064ce1e1480.ref(cuco::insert), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
cudaFree(d_BUF_IDX_6064ce1e1480);
//Materialize count
uint64_t* d_COUNT6064ce1e15f0;
cudaMalloc(&d_COUNT6064ce1e15f0, sizeof(uint64_t));
cudaMemset(d_COUNT6064ce1e15f0, 0, sizeof(uint64_t));
count_6064ce162140<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_6064ce1e1480, d_COUNT6064ce1e15f0, d_HT_6064ce1e1480.ref(cuco::for_each), d_orders__o_custkey, d_orders__o_orderdate, orders_size);
uint64_t COUNT6064ce1e15f0;
cudaMemcpy(&COUNT6064ce1e15f0, d_COUNT6064ce1e15f0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT6064ce1e15f0);
// Insert hash table control;
uint64_t* d_BUF_IDX_6064ce1e15f0;
cudaMalloc(&d_BUF_IDX_6064ce1e15f0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6064ce1e15f0, 0, sizeof(uint64_t));
uint64_t* d_BUF_6064ce1e15f0;
cudaMalloc(&d_BUF_6064ce1e15f0, sizeof(uint64_t) * COUNT6064ce1e15f0 * 4);
auto d_HT_6064ce1e15f0 = cuco::experimental::static_multimap{ (int)COUNT6064ce1e15f0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6064ce162140<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_6064ce1e1480, d_BUF_6064ce1e15f0, d_BUF_IDX_6064ce1e15f0, d_HT_6064ce1e1480.ref(cuco::for_each), d_HT_6064ce1e15f0.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
cudaFree(d_BUF_IDX_6064ce1e15f0);
//Materialize count
uint64_t* d_COUNT6064ce1e1700;
cudaMalloc(&d_COUNT6064ce1e1700, sizeof(uint64_t));
cudaMemset(d_COUNT6064ce1e1700, 0, sizeof(uint64_t));
count_6064ce1f1ad0<<<std::ceil((float)supplier_size/32.), 32>>>(d_COUNT6064ce1e1700, supplier_size);
uint64_t COUNT6064ce1e1700;
cudaMemcpy(&COUNT6064ce1e1700, d_COUNT6064ce1e1700, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT6064ce1e1700);
// Insert hash table control;
uint64_t* d_BUF_IDX_6064ce1e1700;
cudaMalloc(&d_BUF_IDX_6064ce1e1700, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6064ce1e1700, 0, sizeof(uint64_t));
uint64_t* d_BUF_6064ce1e1700;
cudaMalloc(&d_BUF_6064ce1e1700, sizeof(uint64_t) * COUNT6064ce1e1700 * 1);
auto d_HT_6064ce1e1700 = cuco::experimental::static_multimap{ (int)COUNT6064ce1e1700*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6064ce1f1ad0<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_6064ce1e1700, d_BUF_IDX_6064ce1e1700, d_HT_6064ce1e1700.ref(cuco::insert), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
cudaFree(d_BUF_IDX_6064ce1e1700);
//Create aggregation hash table
auto d_HT_6064ce195100 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_6064ce1e6780<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_6064ce1e15f0, d_BUF_6064ce1e1700, d_HT_6064ce195100.ref(cuco::insert), d_HT_6064ce1e15f0.ref(cuco::for_each), d_HT_6064ce1e1700.ref(cuco::for_each), d_customer__c_nationkey, d_lineitem__l_orderkey, d_lineitem__l_suppkey, lineitem_size);
size_t COUNT6064ce195100 = d_HT_6064ce195100.size();
thrust::device_vector<int64_t> keys_6064ce195100(COUNT6064ce195100), vals_6064ce195100(COUNT6064ce195100);
d_HT_6064ce195100.retrieve_all(keys_6064ce195100.begin(), vals_6064ce195100.begin());
d_HT_6064ce195100.clear();
int64_t* raw_keys6064ce195100 = thrust::raw_pointer_cast(keys_6064ce195100.data());
insertKeys<<<std::ceil((float)COUNT6064ce195100/32.), 32>>>(raw_keys6064ce195100, d_HT_6064ce195100.ref(cuco::insert), COUNT6064ce195100);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6064ce195100);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT6064ce195100);
main_6064ce1e6780<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_6064ce1e15f0, d_BUF_6064ce1e1700, d_HT_6064ce195100.ref(cuco::find), d_HT_6064ce1e15f0.ref(cuco::for_each), d_HT_6064ce1e1700.ref(cuco::for_each), d_aggr0__tmp_attr0, d_customer__c_nationkey, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_suppkey, lineitem_size);
//Materialize count
uint64_t* d_COUNT6064ce1a7fa0;
cudaMalloc(&d_COUNT6064ce1a7fa0, sizeof(uint64_t));
cudaMemset(d_COUNT6064ce1a7fa0, 0, sizeof(uint64_t));
count_6064ce1faed0<<<std::ceil((float)COUNT6064ce195100/32.), 32>>>(COUNT6064ce195100, d_COUNT6064ce1a7fa0);
uint64_t COUNT6064ce1a7fa0;
cudaMemcpy(&COUNT6064ce1a7fa0, d_COUNT6064ce1a7fa0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT6064ce1a7fa0);
//Materialize buffers
uint64_t* d_MAT_IDX6064ce1a7fa0;
cudaMalloc(&d_MAT_IDX6064ce1a7fa0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX6064ce1a7fa0, 0, sizeof(uint64_t));
auto MAT6064ce1a7fa0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT6064ce1a7fa0);
DBDecimalType* d_MAT6064ce1a7fa0aggr0__tmp_attr0;
cudaMalloc(&d_MAT6064ce1a7fa0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6064ce1a7fa0);
main_6064ce1faed0<<<std::ceil((float)COUNT6064ce195100/32.), 32>>>(COUNT6064ce195100, d_MAT6064ce1a7fa0aggr0__tmp_attr0, d_MAT_IDX6064ce1a7fa0, d_aggr0__tmp_attr0);
cudaFree(d_MAT_IDX6064ce1a7fa0);
cudaMemcpy(MAT6064ce1a7fa0aggr0__tmp_attr0, d_MAT6064ce1a7fa0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6064ce1a7fa0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT6064ce1a7fa0; i++) { std::cout << MAT6064ce1a7fa0aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
}