#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5b9a27576900(uint64_t* COUNT5b9a27565c70, DBStringType* region__r_name, size_t region_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= region_size) return;
auto reg_region__r_name = region__r_name[tid];
if (!(evaluatePredicate(reg_region__r_name, "ASIA", Predicate::eq))) return;
//Materialize count
atomicAdd((int*)COUNT5b9a27565c70, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5b9a27576900(uint64_t* BUF_5b9a27565c70, uint64_t* BUF_IDX_5b9a27565c70, HASHTABLE_INSERT HT_5b9a27565c70, DBStringType* region__r_name, DBI32Type* region__r_regionkey, size_t region_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= region_size) return;
auto reg_region__r_name = region__r_name[tid];
if (!(evaluatePredicate(reg_region__r_name, "ASIA", Predicate::eq))) return;
uint64_t KEY_5b9a27565c70 = 0;
auto reg_region__r_regionkey = region__r_regionkey[tid];

KEY_5b9a27565c70 |= reg_region__r_regionkey;
// Insert hash table kernel;
auto buf_idx_5b9a27565c70 = atomicAdd((int*)BUF_IDX_5b9a27565c70, 1);
HT_5b9a27565c70.insert(cuco::pair{KEY_5b9a27565c70, buf_idx_5b9a27565c70});
BUF_5b9a27565c70[buf_idx_5b9a27565c70 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5b9a27577ac0(uint64_t* BUF_5b9a27565c70, uint64_t* COUNT5b9a27565ff0, HASHTABLE_PROBE HT_5b9a27565c70, DBI32Type* nation__n_regionkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_5b9a27565c70 = 0;
auto reg_nation__n_regionkey = nation__n_regionkey[tid];

KEY_5b9a27565c70 |= reg_nation__n_regionkey;
//Probe Hash table
HT_5b9a27565c70.for_each(KEY_5b9a27565c70, [&] __device__ (auto const SLOT_5b9a27565c70) {

auto const [slot_first5b9a27565c70, slot_second5b9a27565c70] = SLOT_5b9a27565c70;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5b9a27565ff0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5b9a27577ac0(uint64_t* BUF_5b9a27565c70, uint64_t* BUF_5b9a27565ff0, uint64_t* BUF_IDX_5b9a27565ff0, HASHTABLE_PROBE HT_5b9a27565c70, HASHTABLE_INSERT HT_5b9a27565ff0, DBI32Type* nation__n_nationkey, DBI32Type* nation__n_regionkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_5b9a27565c70 = 0;
auto reg_nation__n_regionkey = nation__n_regionkey[tid];

KEY_5b9a27565c70 |= reg_nation__n_regionkey;
//Probe Hash table
HT_5b9a27565c70.for_each(KEY_5b9a27565c70, [&] __device__ (auto const SLOT_5b9a27565c70) {
auto const [slot_first5b9a27565c70, slot_second5b9a27565c70] = SLOT_5b9a27565c70;
if (!(true)) return;
uint64_t KEY_5b9a27565ff0 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_5b9a27565ff0 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_5b9a27565ff0 = atomicAdd((int*)BUF_IDX_5b9a27565ff0, 1);
HT_5b9a27565ff0.insert(cuco::pair{KEY_5b9a27565ff0, buf_idx_5b9a27565ff0});
BUF_5b9a27565ff0[buf_idx_5b9a27565ff0 * 2 + 0] = BUF_5b9a27565c70[slot_second5b9a27565c70 * 1 + 0];
BUF_5b9a27565ff0[buf_idx_5b9a27565ff0 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_5b9a27552fa0(uint64_t* BUF_5b9a27565ff0, uint64_t* COUNT5b9a2756eea0, HASHTABLE_PROBE HT_5b9a27565ff0, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_5b9a27565ff0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_5b9a27565ff0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_5b9a27565ff0.for_each(KEY_5b9a27565ff0, [&] __device__ (auto const SLOT_5b9a27565ff0) {

auto const [slot_first5b9a27565ff0, slot_second5b9a27565ff0] = SLOT_5b9a27565ff0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5b9a2756eea0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5b9a27552fa0(uint64_t* BUF_5b9a27565ff0, uint64_t* BUF_5b9a2756eea0, uint64_t* BUF_IDX_5b9a2756eea0, HASHTABLE_PROBE HT_5b9a27565ff0, HASHTABLE_INSERT HT_5b9a2756eea0, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_5b9a27565ff0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_5b9a27565ff0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_5b9a27565ff0.for_each(KEY_5b9a27565ff0, [&] __device__ (auto const SLOT_5b9a27565ff0) {
auto const [slot_first5b9a27565ff0, slot_second5b9a27565ff0] = SLOT_5b9a27565ff0;
if (!(true)) return;
uint64_t KEY_5b9a2756eea0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5b9a2756eea0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_5b9a2756eea0 = atomicAdd((int*)BUF_IDX_5b9a2756eea0, 1);
HT_5b9a2756eea0.insert(cuco::pair{KEY_5b9a2756eea0, buf_idx_5b9a2756eea0});
BUF_5b9a2756eea0[buf_idx_5b9a2756eea0 * 3 + 0] = tid;
BUF_5b9a2756eea0[buf_idx_5b9a2756eea0 * 3 + 1] = BUF_5b9a27565ff0[slot_second5b9a27565ff0 * 2 + 0];
BUF_5b9a2756eea0[buf_idx_5b9a2756eea0 * 3 + 2] = BUF_5b9a27565ff0[slot_second5b9a27565ff0 * 2 + 1];
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_5b9a27553510(uint64_t* BUF_5b9a2756eea0, uint64_t* COUNT5b9a2756efb0, HASHTABLE_PROBE HT_5b9a2756eea0, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 9131, Predicate::lt))) return;
uint64_t KEY_5b9a2756eea0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_5b9a2756eea0 |= reg_orders__o_custkey;
//Probe Hash table
HT_5b9a2756eea0.for_each(KEY_5b9a2756eea0, [&] __device__ (auto const SLOT_5b9a2756eea0) {

auto const [slot_first5b9a2756eea0, slot_second5b9a2756eea0] = SLOT_5b9a2756eea0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5b9a2756efb0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5b9a27553510(uint64_t* BUF_5b9a2756eea0, uint64_t* BUF_5b9a2756efb0, uint64_t* BUF_IDX_5b9a2756efb0, HASHTABLE_PROBE HT_5b9a2756eea0, HASHTABLE_INSERT HT_5b9a2756efb0, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 9131, Predicate::lt))) return;
uint64_t KEY_5b9a2756eea0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_5b9a2756eea0 |= reg_orders__o_custkey;
//Probe Hash table
HT_5b9a2756eea0.for_each(KEY_5b9a2756eea0, [&] __device__ (auto const SLOT_5b9a2756eea0) {
auto const [slot_first5b9a2756eea0, slot_second5b9a2756eea0] = SLOT_5b9a2756eea0;
if (!(true)) return;
uint64_t KEY_5b9a2756efb0 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_5b9a2756efb0 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_5b9a2756efb0 = atomicAdd((int*)BUF_IDX_5b9a2756efb0, 1);
HT_5b9a2756efb0.insert(cuco::pair{KEY_5b9a2756efb0, buf_idx_5b9a2756efb0});
BUF_5b9a2756efb0[buf_idx_5b9a2756efb0 * 4 + 0] = BUF_5b9a2756eea0[slot_second5b9a2756eea0 * 3 + 0];
BUF_5b9a2756efb0[buf_idx_5b9a2756efb0 * 4 + 1] = tid;
BUF_5b9a2756efb0[buf_idx_5b9a2756efb0 * 4 + 2] = BUF_5b9a2756eea0[slot_second5b9a2756eea0 * 3 + 1];
BUF_5b9a2756efb0[buf_idx_5b9a2756efb0 * 4 + 3] = BUF_5b9a2756eea0[slot_second5b9a2756eea0 * 3 + 2];
});
}
__global__ void count_5b9a27581e80(uint64_t* COUNT5b9a2756f0c0, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
//Materialize count
atomicAdd((int*)COUNT5b9a2756f0c0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5b9a27581e80(uint64_t* BUF_5b9a2756f0c0, uint64_t* BUF_IDX_5b9a2756f0c0, HASHTABLE_INSERT HT_5b9a2756f0c0, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_5b9a2756f0c0 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_5b9a2756f0c0 |= reg_supplier__s_nationkey;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];
KEY_5b9a2756f0c0 <<= 32;
KEY_5b9a2756f0c0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5b9a2756f0c0 = atomicAdd((int*)BUF_IDX_5b9a2756f0c0, 1);
HT_5b9a2756f0c0.insert(cuco::pair{KEY_5b9a2756f0c0, buf_idx_5b9a2756f0c0});
BUF_5b9a2756f0c0[buf_idx_5b9a2756f0c0 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5b9a27574080(uint64_t* BUF_5b9a2756efb0, uint64_t* BUF_5b9a2756f0c0, HASHTABLE_INSERT HT_5b9a27521cc0, HASHTABLE_PROBE HT_5b9a2756efb0, HASHTABLE_PROBE HT_5b9a2756f0c0, DBI32Type* customer__c_nationkey, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBI16Type* nation__n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_5b9a2756efb0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5b9a2756efb0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5b9a2756efb0.for_each(KEY_5b9a2756efb0, [&] __device__ (auto const SLOT_5b9a2756efb0) {

auto const [slot_first5b9a2756efb0, slot_second5b9a2756efb0] = SLOT_5b9a2756efb0;
if (!(true)) return;
uint64_t KEY_5b9a2756f0c0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[BUF_5b9a2756efb0[slot_second5b9a2756efb0 * 4 + 0]];

KEY_5b9a2756f0c0 |= reg_customer__c_nationkey;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];
KEY_5b9a2756f0c0 <<= 32;
KEY_5b9a2756f0c0 |= reg_lineitem__l_suppkey;
//Probe Hash table
HT_5b9a2756f0c0.for_each(KEY_5b9a2756f0c0, [&] __device__ (auto const SLOT_5b9a2756f0c0) {

auto const [slot_first5b9a2756f0c0, slot_second5b9a2756f0c0] = SLOT_5b9a2756f0c0;
if (!(true)) return;
uint64_t KEY_5b9a27521cc0 = 0;
auto reg_nation__n_name_encoded = nation__n_name_encoded[BUF_5b9a2756efb0[slot_second5b9a2756efb0 * 4 + 3]];

KEY_5b9a27521cc0 |= reg_nation__n_name_encoded;
//Create aggregation hash table
HT_5b9a27521cc0.insert(cuco::pair{KEY_5b9a27521cc0, 1});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5b9a27574080(uint64_t* BUF_5b9a2756efb0, uint64_t* BUF_5b9a2756f0c0, HASHTABLE_FIND HT_5b9a27521cc0, HASHTABLE_PROBE HT_5b9a2756efb0, HASHTABLE_PROBE HT_5b9a2756f0c0, DBI16Type* KEY_5b9a27521cc0nation__n_name_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* customer__c_nationkey, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBI16Type* nation__n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_5b9a2756efb0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5b9a2756efb0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5b9a2756efb0.for_each(KEY_5b9a2756efb0, [&] __device__ (auto const SLOT_5b9a2756efb0) {
auto const [slot_first5b9a2756efb0, slot_second5b9a2756efb0] = SLOT_5b9a2756efb0;
if (!(true)) return;
uint64_t KEY_5b9a2756f0c0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[BUF_5b9a2756efb0[slot_second5b9a2756efb0 * 4 + 0]];

KEY_5b9a2756f0c0 |= reg_customer__c_nationkey;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];
KEY_5b9a2756f0c0 <<= 32;
KEY_5b9a2756f0c0 |= reg_lineitem__l_suppkey;
//Probe Hash table
HT_5b9a2756f0c0.for_each(KEY_5b9a2756f0c0, [&] __device__ (auto const SLOT_5b9a2756f0c0) {
auto const [slot_first5b9a2756f0c0, slot_second5b9a2756f0c0] = SLOT_5b9a2756f0c0;
if (!(true)) return;
uint64_t KEY_5b9a27521cc0 = 0;
auto reg_nation__n_name_encoded = nation__n_name_encoded[BUF_5b9a2756efb0[slot_second5b9a2756efb0 * 4 + 3]];

KEY_5b9a27521cc0 |= reg_nation__n_name_encoded;
//Aggregate in hashtable
auto buf_idx_5b9a27521cc0 = HT_5b9a27521cc0.find(KEY_5b9a27521cc0)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5b9a27521cc0], reg_map0__tmp_attr1);
KEY_5b9a27521cc0nation__n_name_encoded[buf_idx_5b9a27521cc0] = reg_nation__n_name_encoded;
});
});
}
__global__ void count_5b9a2758ce30(size_t COUNT5b9a27521cc0, uint64_t* COUNT5b9a27534e70) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5b9a27521cc0) return;
//Materialize count
atomicAdd((int*)COUNT5b9a27534e70, 1);
}
__global__ void main_5b9a2758ce30(size_t COUNT5b9a27521cc0, DBDecimalType* MAT5b9a27534e70aggr0__tmp_attr0, DBI16Type* MAT5b9a27534e70nation__n_name_encoded, uint64_t* MAT_IDX5b9a27534e70, DBDecimalType* aggr0__tmp_attr0, DBI16Type* nation__n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5b9a27521cc0) return;
//Materialize buffers
auto mat_idx5b9a27534e70 = atomicAdd((int*)MAT_IDX5b9a27534e70, 1);
auto reg_nation__n_name_encoded = nation__n_name_encoded[tid];
MAT5b9a27534e70nation__n_name_encoded[mat_idx5b9a27534e70] = reg_nation__n_name_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5b9a27534e70aggr0__tmp_attr0[mat_idx5b9a27534e70] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map) {
//Materialize count
uint64_t* d_COUNT5b9a27565c70;
cudaMalloc(&d_COUNT5b9a27565c70, sizeof(uint64_t));
cudaMemset(d_COUNT5b9a27565c70, 0, sizeof(uint64_t));
count_5b9a27576900<<<std::ceil((float)region_size/32.), 32>>>(d_COUNT5b9a27565c70, d_region__r_name, region_size);
uint64_t COUNT5b9a27565c70;
cudaMemcpy(&COUNT5b9a27565c70, d_COUNT5b9a27565c70, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b9a27565c70;
cudaMalloc(&d_BUF_IDX_5b9a27565c70, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b9a27565c70, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b9a27565c70;
cudaMalloc(&d_BUF_5b9a27565c70, sizeof(uint64_t) * COUNT5b9a27565c70 * 1);
auto d_HT_5b9a27565c70 = cuco::experimental::static_multimap{ (int)COUNT5b9a27565c70*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b9a27576900<<<std::ceil((float)region_size/32.), 32>>>(d_BUF_5b9a27565c70, d_BUF_IDX_5b9a27565c70, d_HT_5b9a27565c70.ref(cuco::insert), d_region__r_name, d_region__r_regionkey, region_size);
//Materialize count
uint64_t* d_COUNT5b9a27565ff0;
cudaMalloc(&d_COUNT5b9a27565ff0, sizeof(uint64_t));
cudaMemset(d_COUNT5b9a27565ff0, 0, sizeof(uint64_t));
count_5b9a27577ac0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_5b9a27565c70, d_COUNT5b9a27565ff0, d_HT_5b9a27565c70.ref(cuco::for_each), d_nation__n_regionkey, nation_size);
uint64_t COUNT5b9a27565ff0;
cudaMemcpy(&COUNT5b9a27565ff0, d_COUNT5b9a27565ff0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b9a27565ff0;
cudaMalloc(&d_BUF_IDX_5b9a27565ff0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b9a27565ff0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b9a27565ff0;
cudaMalloc(&d_BUF_5b9a27565ff0, sizeof(uint64_t) * COUNT5b9a27565ff0 * 2);
auto d_HT_5b9a27565ff0 = cuco::experimental::static_multimap{ (int)COUNT5b9a27565ff0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b9a27577ac0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_5b9a27565c70, d_BUF_5b9a27565ff0, d_BUF_IDX_5b9a27565ff0, d_HT_5b9a27565c70.ref(cuco::for_each), d_HT_5b9a27565ff0.ref(cuco::insert), d_nation__n_nationkey, d_nation__n_regionkey, nation_size);
//Materialize count
uint64_t* d_COUNT5b9a2756eea0;
cudaMalloc(&d_COUNT5b9a2756eea0, sizeof(uint64_t));
cudaMemset(d_COUNT5b9a2756eea0, 0, sizeof(uint64_t));
count_5b9a27552fa0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5b9a27565ff0, d_COUNT5b9a2756eea0, d_HT_5b9a27565ff0.ref(cuco::for_each), d_customer__c_nationkey, customer_size);
uint64_t COUNT5b9a2756eea0;
cudaMemcpy(&COUNT5b9a2756eea0, d_COUNT5b9a2756eea0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b9a2756eea0;
cudaMalloc(&d_BUF_IDX_5b9a2756eea0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b9a2756eea0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b9a2756eea0;
cudaMalloc(&d_BUF_5b9a2756eea0, sizeof(uint64_t) * COUNT5b9a2756eea0 * 3);
auto d_HT_5b9a2756eea0 = cuco::experimental::static_multimap{ (int)COUNT5b9a2756eea0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b9a27552fa0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5b9a27565ff0, d_BUF_5b9a2756eea0, d_BUF_IDX_5b9a2756eea0, d_HT_5b9a27565ff0.ref(cuco::for_each), d_HT_5b9a2756eea0.ref(cuco::insert), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
//Materialize count
uint64_t* d_COUNT5b9a2756efb0;
cudaMalloc(&d_COUNT5b9a2756efb0, sizeof(uint64_t));
cudaMemset(d_COUNT5b9a2756efb0, 0, sizeof(uint64_t));
count_5b9a27553510<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5b9a2756eea0, d_COUNT5b9a2756efb0, d_HT_5b9a2756eea0.ref(cuco::for_each), d_orders__o_custkey, d_orders__o_orderdate, orders_size);
uint64_t COUNT5b9a2756efb0;
cudaMemcpy(&COUNT5b9a2756efb0, d_COUNT5b9a2756efb0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b9a2756efb0;
cudaMalloc(&d_BUF_IDX_5b9a2756efb0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b9a2756efb0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b9a2756efb0;
cudaMalloc(&d_BUF_5b9a2756efb0, sizeof(uint64_t) * COUNT5b9a2756efb0 * 4);
auto d_HT_5b9a2756efb0 = cuco::experimental::static_multimap{ (int)COUNT5b9a2756efb0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b9a27553510<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5b9a2756eea0, d_BUF_5b9a2756efb0, d_BUF_IDX_5b9a2756efb0, d_HT_5b9a2756eea0.ref(cuco::for_each), d_HT_5b9a2756efb0.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
//Materialize count
uint64_t* d_COUNT5b9a2756f0c0;
cudaMalloc(&d_COUNT5b9a2756f0c0, sizeof(uint64_t));
cudaMemset(d_COUNT5b9a2756f0c0, 0, sizeof(uint64_t));
count_5b9a27581e80<<<std::ceil((float)supplier_size/32.), 32>>>(d_COUNT5b9a2756f0c0, supplier_size);
uint64_t COUNT5b9a2756f0c0;
cudaMemcpy(&COUNT5b9a2756f0c0, d_COUNT5b9a2756f0c0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b9a2756f0c0;
cudaMalloc(&d_BUF_IDX_5b9a2756f0c0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b9a2756f0c0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b9a2756f0c0;
cudaMalloc(&d_BUF_5b9a2756f0c0, sizeof(uint64_t) * COUNT5b9a2756f0c0 * 1);
auto d_HT_5b9a2756f0c0 = cuco::experimental::static_multimap{ (int)COUNT5b9a2756f0c0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b9a27581e80<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_5b9a2756f0c0, d_BUF_IDX_5b9a2756f0c0, d_HT_5b9a2756f0c0.ref(cuco::insert), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
//Create aggregation hash table
auto d_HT_5b9a27521cc0 = cuco::static_map{ (int)22857*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5b9a27574080<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5b9a2756efb0, d_BUF_5b9a2756f0c0, d_HT_5b9a27521cc0.ref(cuco::insert), d_HT_5b9a2756efb0.ref(cuco::for_each), d_HT_5b9a2756f0c0.ref(cuco::for_each), d_customer__c_nationkey, d_lineitem__l_orderkey, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name_encoded);
size_t COUNT5b9a27521cc0 = d_HT_5b9a27521cc0.size();
thrust::device_vector<int64_t> keys_5b9a27521cc0(COUNT5b9a27521cc0), vals_5b9a27521cc0(COUNT5b9a27521cc0);
d_HT_5b9a27521cc0.retrieve_all(keys_5b9a27521cc0.begin(), vals_5b9a27521cc0.begin());
d_HT_5b9a27521cc0.clear();
int64_t* raw_keys5b9a27521cc0 = thrust::raw_pointer_cast(keys_5b9a27521cc0.data());
insertKeys<<<std::ceil((float)COUNT5b9a27521cc0/32.), 32>>>(raw_keys5b9a27521cc0, d_HT_5b9a27521cc0.ref(cuco::insert), COUNT5b9a27521cc0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5b9a27521cc0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5b9a27521cc0);
DBI16Type* d_KEY_5b9a27521cc0nation__n_name_encoded;
cudaMalloc(&d_KEY_5b9a27521cc0nation__n_name_encoded, sizeof(DBI16Type) * COUNT5b9a27521cc0);
cudaMemset(d_KEY_5b9a27521cc0nation__n_name_encoded, 0, sizeof(DBI16Type) * COUNT5b9a27521cc0);
main_5b9a27574080<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5b9a2756efb0, d_BUF_5b9a2756f0c0, d_HT_5b9a27521cc0.ref(cuco::find), d_HT_5b9a2756efb0.ref(cuco::for_each), d_HT_5b9a2756f0c0.ref(cuco::for_each), d_KEY_5b9a27521cc0nation__n_name_encoded, d_aggr0__tmp_attr0, d_customer__c_nationkey, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name_encoded);
//Materialize count
uint64_t* d_COUNT5b9a27534e70;
cudaMalloc(&d_COUNT5b9a27534e70, sizeof(uint64_t));
cudaMemset(d_COUNT5b9a27534e70, 0, sizeof(uint64_t));
count_5b9a2758ce30<<<std::ceil((float)COUNT5b9a27521cc0/32.), 32>>>(COUNT5b9a27521cc0, d_COUNT5b9a27534e70);
uint64_t COUNT5b9a27534e70;
cudaMemcpy(&COUNT5b9a27534e70, d_COUNT5b9a27534e70, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5b9a27534e70;
cudaMalloc(&d_MAT_IDX5b9a27534e70, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5b9a27534e70, 0, sizeof(uint64_t));
auto MAT5b9a27534e70nation__n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5b9a27534e70);
DBI16Type* d_MAT5b9a27534e70nation__n_name_encoded;
cudaMalloc(&d_MAT5b9a27534e70nation__n_name_encoded, sizeof(DBI16Type) * COUNT5b9a27534e70);
auto MAT5b9a27534e70aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5b9a27534e70);
DBDecimalType* d_MAT5b9a27534e70aggr0__tmp_attr0;
cudaMalloc(&d_MAT5b9a27534e70aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5b9a27534e70);
main_5b9a2758ce30<<<std::ceil((float)COUNT5b9a27521cc0/32.), 32>>>(COUNT5b9a27521cc0, d_MAT5b9a27534e70aggr0__tmp_attr0, d_MAT5b9a27534e70nation__n_name_encoded, d_MAT_IDX5b9a27534e70, d_aggr0__tmp_attr0, d_KEY_5b9a27521cc0nation__n_name_encoded);
cudaMemcpy(MAT5b9a27534e70nation__n_name_encoded, d_MAT5b9a27534e70nation__n_name_encoded, sizeof(DBI16Type) * COUNT5b9a27534e70, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5b9a27534e70aggr0__tmp_attr0, d_MAT5b9a27534e70aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5b9a27534e70, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5b9a27534e70; i++) { std::cout << nation__n_name_map[MAT5b9a27534e70nation__n_name_encoded[i]] << "\t";
std::cout << MAT5b9a27534e70aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_5b9a27565c70);
cudaFree(d_BUF_IDX_5b9a27565c70);
cudaFree(d_COUNT5b9a27565c70);
cudaFree(d_BUF_5b9a27565ff0);
cudaFree(d_BUF_IDX_5b9a27565ff0);
cudaFree(d_COUNT5b9a27565ff0);
cudaFree(d_BUF_5b9a2756eea0);
cudaFree(d_BUF_IDX_5b9a2756eea0);
cudaFree(d_COUNT5b9a2756eea0);
cudaFree(d_BUF_5b9a2756efb0);
cudaFree(d_BUF_IDX_5b9a2756efb0);
cudaFree(d_COUNT5b9a2756efb0);
cudaFree(d_BUF_5b9a2756f0c0);
cudaFree(d_BUF_IDX_5b9a2756f0c0);
cudaFree(d_COUNT5b9a2756f0c0);
cudaFree(d_KEY_5b9a27521cc0nation__n_name_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5b9a27534e70);
cudaFree(d_MAT5b9a27534e70aggr0__tmp_attr0);
cudaFree(d_MAT5b9a27534e70nation__n_name_encoded);
cudaFree(d_MAT_IDX5b9a27534e70);
free(MAT5b9a27534e70aggr0__tmp_attr0);
free(MAT5b9a27534e70nation__n_name_encoded);
}