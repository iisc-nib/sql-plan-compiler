#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_567196a4a0f0(uint64_t* COUNT567196a3a0b0, DBStringType* region__r_name, size_t region_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= region_size) return;
auto reg_region__r_name = region__r_name[tid];
if (!(evaluatePredicate(reg_region__r_name, "ASIA", Predicate::eq))) return;
//Materialize count
atomicAdd((int*)COUNT567196a3a0b0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_567196a4a0f0(uint64_t* BUF_567196a3a0b0, uint64_t* BUF_IDX_567196a3a0b0, HASHTABLE_INSERT HT_567196a3a0b0, DBStringType* region__r_name, DBI32Type* region__r_regionkey, size_t region_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= region_size) return;
auto reg_region__r_name = region__r_name[tid];
if (!(evaluatePredicate(reg_region__r_name, "ASIA", Predicate::eq))) return;
uint64_t KEY_567196a3a0b0 = 0;
auto reg_region__r_regionkey = region__r_regionkey[tid];

KEY_567196a3a0b0 |= reg_region__r_regionkey;
// Insert hash table kernel;
auto buf_idx_567196a3a0b0 = atomicAdd((int*)BUF_IDX_567196a3a0b0, 1);
HT_567196a3a0b0.insert(cuco::pair{KEY_567196a3a0b0, buf_idx_567196a3a0b0});
BUF_567196a3a0b0[buf_idx_567196a3a0b0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_567196a4b450(uint64_t* BUF_567196a3a0b0, uint64_t* COUNT567196a39af0, HASHTABLE_PROBE HT_567196a3a0b0, DBI32Type* nation__n_regionkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_567196a3a0b0 = 0;
auto reg_nation__n_regionkey = nation__n_regionkey[tid];

KEY_567196a3a0b0 |= reg_nation__n_regionkey;
//Probe Hash table
HT_567196a3a0b0.for_each(KEY_567196a3a0b0, [&] __device__ (auto const SLOT_567196a3a0b0) {

auto const [slot_first567196a3a0b0, slot_second567196a3a0b0] = SLOT_567196a3a0b0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT567196a39af0, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_567196a4b450(uint64_t* BUF_567196a39af0, uint64_t* BUF_567196a3a0b0, uint64_t* BUF_IDX_567196a39af0, HASHTABLE_INSERT HT_567196a39af0, HASHTABLE_PROBE HT_567196a3a0b0, DBI32Type* nation__n_nationkey, DBI32Type* nation__n_regionkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_567196a3a0b0 = 0;
auto reg_nation__n_regionkey = nation__n_regionkey[tid];

KEY_567196a3a0b0 |= reg_nation__n_regionkey;
//Probe Hash table
HT_567196a3a0b0.for_each(KEY_567196a3a0b0, [&] __device__ (auto const SLOT_567196a3a0b0) {
auto const [slot_first567196a3a0b0, slot_second567196a3a0b0] = SLOT_567196a3a0b0;
if (!(true)) return;
uint64_t KEY_567196a39af0 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_567196a39af0 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_567196a39af0 = atomicAdd((int*)BUF_IDX_567196a39af0, 1);
HT_567196a39af0.insert(cuco::pair{KEY_567196a39af0, buf_idx_567196a39af0});
BUF_567196a39af0[buf_idx_567196a39af0 * 2 + 0] = BUF_567196a3a0b0[slot_second567196a3a0b0 * 1 + 0];
BUF_567196a39af0[buf_idx_567196a39af0 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_567196a26fd0(uint64_t* BUF_567196a39af0, uint64_t* COUNT567196a422c0, HASHTABLE_PROBE HT_567196a39af0, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_567196a39af0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_567196a39af0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_567196a39af0.for_each(KEY_567196a39af0, [&] __device__ (auto const SLOT_567196a39af0) {

auto const [slot_first567196a39af0, slot_second567196a39af0] = SLOT_567196a39af0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT567196a422c0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_567196a26fd0(uint64_t* BUF_567196a39af0, uint64_t* BUF_567196a422c0, uint64_t* BUF_IDX_567196a422c0, HASHTABLE_PROBE HT_567196a39af0, HASHTABLE_INSERT HT_567196a422c0, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_567196a39af0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_567196a39af0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_567196a39af0.for_each(KEY_567196a39af0, [&] __device__ (auto const SLOT_567196a39af0) {
auto const [slot_first567196a39af0, slot_second567196a39af0] = SLOT_567196a39af0;
if (!(true)) return;
uint64_t KEY_567196a422c0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_567196a422c0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_567196a422c0 = atomicAdd((int*)BUF_IDX_567196a422c0, 1);
HT_567196a422c0.insert(cuco::pair{KEY_567196a422c0, buf_idx_567196a422c0});
BUF_567196a422c0[buf_idx_567196a422c0 * 3 + 0] = tid;
BUF_567196a422c0[buf_idx_567196a422c0 * 3 + 1] = BUF_567196a39af0[slot_second567196a39af0 * 2 + 0];
BUF_567196a422c0[buf_idx_567196a422c0 * 3 + 2] = BUF_567196a39af0[slot_second567196a39af0 * 2 + 1];
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_567196a27540(uint64_t* BUF_567196a422c0, uint64_t* COUNT567196a42430, HASHTABLE_PROBE HT_567196a422c0, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 9131, Predicate::lt))) return;
uint64_t KEY_567196a422c0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_567196a422c0 |= reg_orders__o_custkey;
//Probe Hash table
HT_567196a422c0.for_each(KEY_567196a422c0, [&] __device__ (auto const SLOT_567196a422c0) {

auto const [slot_first567196a422c0, slot_second567196a422c0] = SLOT_567196a422c0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT567196a42430, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_567196a27540(uint64_t* BUF_567196a422c0, uint64_t* BUF_567196a42430, uint64_t* BUF_IDX_567196a42430, HASHTABLE_PROBE HT_567196a422c0, HASHTABLE_INSERT HT_567196a42430, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 9131, Predicate::lt))) return;
uint64_t KEY_567196a422c0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_567196a422c0 |= reg_orders__o_custkey;
//Probe Hash table
HT_567196a422c0.for_each(KEY_567196a422c0, [&] __device__ (auto const SLOT_567196a422c0) {
auto const [slot_first567196a422c0, slot_second567196a422c0] = SLOT_567196a422c0;
if (!(true)) return;
uint64_t KEY_567196a42430 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_567196a42430 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_567196a42430 = atomicAdd((int*)BUF_IDX_567196a42430, 1);
HT_567196a42430.insert(cuco::pair{KEY_567196a42430, buf_idx_567196a42430});
BUF_567196a42430[buf_idx_567196a42430 * 4 + 0] = BUF_567196a422c0[slot_second567196a422c0 * 3 + 0];
BUF_567196a42430[buf_idx_567196a42430 * 4 + 1] = tid;
BUF_567196a42430[buf_idx_567196a42430 * 4 + 2] = BUF_567196a422c0[slot_second567196a422c0 * 3 + 1];
BUF_567196a42430[buf_idx_567196a42430 * 4 + 3] = BUF_567196a422c0[slot_second567196a422c0 * 3 + 2];
});
}
__global__ void count_567196a559b0(uint64_t* COUNT567196a42540, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
//Materialize count
atomicAdd((int*)COUNT567196a42540, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_567196a559b0(uint64_t* BUF_567196a42540, uint64_t* BUF_IDX_567196a42540, HASHTABLE_INSERT HT_567196a42540, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_567196a42540 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_567196a42540 |= reg_supplier__s_suppkey;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];
KEY_567196a42540 <<= 32;
KEY_567196a42540 |= reg_supplier__s_nationkey;
// Insert hash table kernel;
auto buf_idx_567196a42540 = atomicAdd((int*)BUF_IDX_567196a42540, 1);
HT_567196a42540.insert(cuco::pair{KEY_567196a42540, buf_idx_567196a42540});
BUF_567196a42540[buf_idx_567196a42540 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_567196a473f0(uint64_t* BUF_567196a42430, uint64_t* BUF_567196a42540, HASHTABLE_INSERT HT_5671969f5da0, HASHTABLE_PROBE HT_567196a42430, HASHTABLE_PROBE HT_567196a42540, DBI32Type* customer__c_nationkey, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBI16Type* nation__n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_567196a42430 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_567196a42430 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_567196a42430.for_each(KEY_567196a42430, [&] __device__ (auto const SLOT_567196a42430) {

auto const [slot_first567196a42430, slot_second567196a42430] = SLOT_567196a42430;
if (!(true)) return;
uint64_t KEY_567196a42540 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_567196a42540 |= reg_lineitem__l_suppkey;
auto reg_customer__c_nationkey = customer__c_nationkey[BUF_567196a42430[slot_second567196a42430 * 4 + 0]];
KEY_567196a42540 <<= 32;
KEY_567196a42540 |= reg_customer__c_nationkey;
//Probe Hash table
HT_567196a42540.for_each(KEY_567196a42540, [&] __device__ (auto const SLOT_567196a42540) {

auto const [slot_first567196a42540, slot_second567196a42540] = SLOT_567196a42540;
if (!(true)) return;
uint64_t KEY_5671969f5da0 = 0;
auto reg_nation__n_name_encoded = nation__n_name_encoded[BUF_567196a42430[slot_second567196a42430 * 4 + 3]];

KEY_5671969f5da0 |= reg_nation__n_name_encoded;
//Create aggregation hash table
HT_5671969f5da0.insert(cuco::pair{KEY_5671969f5da0, 1});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_567196a473f0(uint64_t* BUF_567196a42430, uint64_t* BUF_567196a42540, HASHTABLE_FIND HT_5671969f5da0, HASHTABLE_PROBE HT_567196a42430, HASHTABLE_PROBE HT_567196a42540, DBI16Type* KEY_5671969f5da0nation__n_name_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* customer__c_nationkey, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBI16Type* nation__n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_567196a42430 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_567196a42430 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_567196a42430.for_each(KEY_567196a42430, [&] __device__ (auto const SLOT_567196a42430) {
auto const [slot_first567196a42430, slot_second567196a42430] = SLOT_567196a42430;
if (!(true)) return;
uint64_t KEY_567196a42540 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_567196a42540 |= reg_lineitem__l_suppkey;
auto reg_customer__c_nationkey = customer__c_nationkey[BUF_567196a42430[slot_second567196a42430 * 4 + 0]];
KEY_567196a42540 <<= 32;
KEY_567196a42540 |= reg_customer__c_nationkey;
//Probe Hash table
HT_567196a42540.for_each(KEY_567196a42540, [&] __device__ (auto const SLOT_567196a42540) {
auto const [slot_first567196a42540, slot_second567196a42540] = SLOT_567196a42540;
if (!(true)) return;
uint64_t KEY_5671969f5da0 = 0;
auto reg_nation__n_name_encoded = nation__n_name_encoded[BUF_567196a42430[slot_second567196a42430 * 4 + 3]];

KEY_5671969f5da0 |= reg_nation__n_name_encoded;
//Aggregate in hashtable
auto buf_idx_5671969f5da0 = HT_5671969f5da0.find(KEY_5671969f5da0)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5671969f5da0], reg_map0__tmp_attr1);
KEY_5671969f5da0nation__n_name_encoded[buf_idx_5671969f5da0] = reg_nation__n_name_encoded;
});
});
}
__global__ void count_567196a60360(size_t COUNT5671969f5da0, uint64_t* COUNT567196a09930) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5671969f5da0) return;
//Materialize count
atomicAdd((int*)COUNT567196a09930, 1);
}
__global__ void main_567196a60360(size_t COUNT5671969f5da0, DBDecimalType* MAT567196a09930aggr0__tmp_attr0, DBI16Type* MAT567196a09930nation__n_name_encoded, uint64_t* MAT_IDX567196a09930, DBDecimalType* aggr0__tmp_attr0, DBI16Type* nation__n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5671969f5da0) return;
//Materialize buffers
auto mat_idx567196a09930 = atomicAdd((int*)MAT_IDX567196a09930, 1);
auto reg_nation__n_name_encoded = nation__n_name_encoded[tid];
MAT567196a09930nation__n_name_encoded[mat_idx567196a09930] = reg_nation__n_name_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT567196a09930aggr0__tmp_attr0[mat_idx567196a09930] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map) {
//Materialize count
uint64_t* d_COUNT567196a3a0b0;
cudaMalloc(&d_COUNT567196a3a0b0, sizeof(uint64_t));
cudaMemset(d_COUNT567196a3a0b0, 0, sizeof(uint64_t));
count_567196a4a0f0<<<std::ceil((float)region_size/32.), 32>>>(d_COUNT567196a3a0b0, d_region__r_name, region_size);
uint64_t COUNT567196a3a0b0;
cudaMemcpy(&COUNT567196a3a0b0, d_COUNT567196a3a0b0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_567196a3a0b0;
cudaMalloc(&d_BUF_IDX_567196a3a0b0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_567196a3a0b0, 0, sizeof(uint64_t));
uint64_t* d_BUF_567196a3a0b0;
cudaMalloc(&d_BUF_567196a3a0b0, sizeof(uint64_t) * COUNT567196a3a0b0 * 1);
auto d_HT_567196a3a0b0 = cuco::experimental::static_multimap{ (int)COUNT567196a3a0b0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_567196a4a0f0<<<std::ceil((float)region_size/32.), 32>>>(d_BUF_567196a3a0b0, d_BUF_IDX_567196a3a0b0, d_HT_567196a3a0b0.ref(cuco::insert), d_region__r_name, d_region__r_regionkey, region_size);
//Materialize count
uint64_t* d_COUNT567196a39af0;
cudaMalloc(&d_COUNT567196a39af0, sizeof(uint64_t));
cudaMemset(d_COUNT567196a39af0, 0, sizeof(uint64_t));
count_567196a4b450<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_567196a3a0b0, d_COUNT567196a39af0, d_HT_567196a3a0b0.ref(cuco::for_each), d_nation__n_regionkey, nation_size);
uint64_t COUNT567196a39af0;
cudaMemcpy(&COUNT567196a39af0, d_COUNT567196a39af0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_567196a39af0;
cudaMalloc(&d_BUF_IDX_567196a39af0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_567196a39af0, 0, sizeof(uint64_t));
uint64_t* d_BUF_567196a39af0;
cudaMalloc(&d_BUF_567196a39af0, sizeof(uint64_t) * COUNT567196a39af0 * 2);
auto d_HT_567196a39af0 = cuco::experimental::static_multimap{ (int)COUNT567196a39af0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_567196a4b450<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_567196a39af0, d_BUF_567196a3a0b0, d_BUF_IDX_567196a39af0, d_HT_567196a39af0.ref(cuco::insert), d_HT_567196a3a0b0.ref(cuco::for_each), d_nation__n_nationkey, d_nation__n_regionkey, nation_size);
//Materialize count
uint64_t* d_COUNT567196a422c0;
cudaMalloc(&d_COUNT567196a422c0, sizeof(uint64_t));
cudaMemset(d_COUNT567196a422c0, 0, sizeof(uint64_t));
count_567196a26fd0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_567196a39af0, d_COUNT567196a422c0, d_HT_567196a39af0.ref(cuco::for_each), d_customer__c_nationkey, customer_size);
uint64_t COUNT567196a422c0;
cudaMemcpy(&COUNT567196a422c0, d_COUNT567196a422c0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_567196a422c0;
cudaMalloc(&d_BUF_IDX_567196a422c0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_567196a422c0, 0, sizeof(uint64_t));
uint64_t* d_BUF_567196a422c0;
cudaMalloc(&d_BUF_567196a422c0, sizeof(uint64_t) * COUNT567196a422c0 * 3);
auto d_HT_567196a422c0 = cuco::experimental::static_multimap{ (int)COUNT567196a422c0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_567196a26fd0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_567196a39af0, d_BUF_567196a422c0, d_BUF_IDX_567196a422c0, d_HT_567196a39af0.ref(cuco::for_each), d_HT_567196a422c0.ref(cuco::insert), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
//Materialize count
uint64_t* d_COUNT567196a42430;
cudaMalloc(&d_COUNT567196a42430, sizeof(uint64_t));
cudaMemset(d_COUNT567196a42430, 0, sizeof(uint64_t));
count_567196a27540<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_567196a422c0, d_COUNT567196a42430, d_HT_567196a422c0.ref(cuco::for_each), d_orders__o_custkey, d_orders__o_orderdate, orders_size);
uint64_t COUNT567196a42430;
cudaMemcpy(&COUNT567196a42430, d_COUNT567196a42430, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_567196a42430;
cudaMalloc(&d_BUF_IDX_567196a42430, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_567196a42430, 0, sizeof(uint64_t));
uint64_t* d_BUF_567196a42430;
cudaMalloc(&d_BUF_567196a42430, sizeof(uint64_t) * COUNT567196a42430 * 4);
auto d_HT_567196a42430 = cuco::experimental::static_multimap{ (int)COUNT567196a42430*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_567196a27540<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_567196a422c0, d_BUF_567196a42430, d_BUF_IDX_567196a42430, d_HT_567196a422c0.ref(cuco::for_each), d_HT_567196a42430.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
//Materialize count
uint64_t* d_COUNT567196a42540;
cudaMalloc(&d_COUNT567196a42540, sizeof(uint64_t));
cudaMemset(d_COUNT567196a42540, 0, sizeof(uint64_t));
count_567196a559b0<<<std::ceil((float)supplier_size/32.), 32>>>(d_COUNT567196a42540, supplier_size);
uint64_t COUNT567196a42540;
cudaMemcpy(&COUNT567196a42540, d_COUNT567196a42540, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_567196a42540;
cudaMalloc(&d_BUF_IDX_567196a42540, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_567196a42540, 0, sizeof(uint64_t));
uint64_t* d_BUF_567196a42540;
cudaMalloc(&d_BUF_567196a42540, sizeof(uint64_t) * COUNT567196a42540 * 1);
auto d_HT_567196a42540 = cuco::experimental::static_multimap{ (int)COUNT567196a42540*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_567196a559b0<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_567196a42540, d_BUF_IDX_567196a42540, d_HT_567196a42540.ref(cuco::insert), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
//Create aggregation hash table
auto d_HT_5671969f5da0 = cuco::static_map{ (int)22857*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_567196a473f0<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_567196a42430, d_BUF_567196a42540, d_HT_5671969f5da0.ref(cuco::insert), d_HT_567196a42430.ref(cuco::for_each), d_HT_567196a42540.ref(cuco::for_each), d_customer__c_nationkey, d_lineitem__l_orderkey, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name_encoded);
size_t COUNT5671969f5da0 = d_HT_5671969f5da0.size();
thrust::device_vector<int64_t> keys_5671969f5da0(COUNT5671969f5da0), vals_5671969f5da0(COUNT5671969f5da0);
d_HT_5671969f5da0.retrieve_all(keys_5671969f5da0.begin(), vals_5671969f5da0.begin());
d_HT_5671969f5da0.clear();
int64_t* raw_keys5671969f5da0 = thrust::raw_pointer_cast(keys_5671969f5da0.data());
insertKeys<<<std::ceil((float)COUNT5671969f5da0/32.), 32>>>(raw_keys5671969f5da0, d_HT_5671969f5da0.ref(cuco::insert), COUNT5671969f5da0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5671969f5da0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5671969f5da0);
DBI16Type* d_KEY_5671969f5da0nation__n_name_encoded;
cudaMalloc(&d_KEY_5671969f5da0nation__n_name_encoded, sizeof(DBI16Type) * COUNT5671969f5da0);
cudaMemset(d_KEY_5671969f5da0nation__n_name_encoded, 0, sizeof(DBI16Type) * COUNT5671969f5da0);
main_567196a473f0<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_567196a42430, d_BUF_567196a42540, d_HT_5671969f5da0.ref(cuco::find), d_HT_567196a42430.ref(cuco::for_each), d_HT_567196a42540.ref(cuco::for_each), d_KEY_5671969f5da0nation__n_name_encoded, d_aggr0__tmp_attr0, d_customer__c_nationkey, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name_encoded);
//Materialize count
uint64_t* d_COUNT567196a09930;
cudaMalloc(&d_COUNT567196a09930, sizeof(uint64_t));
cudaMemset(d_COUNT567196a09930, 0, sizeof(uint64_t));
count_567196a60360<<<std::ceil((float)COUNT5671969f5da0/32.), 32>>>(COUNT5671969f5da0, d_COUNT567196a09930);
uint64_t COUNT567196a09930;
cudaMemcpy(&COUNT567196a09930, d_COUNT567196a09930, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX567196a09930;
cudaMalloc(&d_MAT_IDX567196a09930, sizeof(uint64_t));
cudaMemset(d_MAT_IDX567196a09930, 0, sizeof(uint64_t));
auto MAT567196a09930nation__n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT567196a09930);
DBI16Type* d_MAT567196a09930nation__n_name_encoded;
cudaMalloc(&d_MAT567196a09930nation__n_name_encoded, sizeof(DBI16Type) * COUNT567196a09930);
auto MAT567196a09930aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT567196a09930);
DBDecimalType* d_MAT567196a09930aggr0__tmp_attr0;
cudaMalloc(&d_MAT567196a09930aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT567196a09930);
main_567196a60360<<<std::ceil((float)COUNT5671969f5da0/32.), 32>>>(COUNT5671969f5da0, d_MAT567196a09930aggr0__tmp_attr0, d_MAT567196a09930nation__n_name_encoded, d_MAT_IDX567196a09930, d_aggr0__tmp_attr0, d_KEY_5671969f5da0nation__n_name_encoded);
cudaMemcpy(MAT567196a09930nation__n_name_encoded, d_MAT567196a09930nation__n_name_encoded, sizeof(DBI16Type) * COUNT567196a09930, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT567196a09930aggr0__tmp_attr0, d_MAT567196a09930aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT567196a09930, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT567196a09930; i++) { std::cout << nation__n_name_map[MAT567196a09930nation__n_name_encoded[i]] << "\t";
std::cout << MAT567196a09930aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_567196a3a0b0);
cudaFree(d_BUF_IDX_567196a3a0b0);
cudaFree(d_COUNT567196a3a0b0);
cudaFree(d_BUF_567196a39af0);
cudaFree(d_BUF_IDX_567196a39af0);
cudaFree(d_COUNT567196a39af0);
cudaFree(d_BUF_567196a422c0);
cudaFree(d_BUF_IDX_567196a422c0);
cudaFree(d_COUNT567196a422c0);
cudaFree(d_BUF_567196a42430);
cudaFree(d_BUF_IDX_567196a42430);
cudaFree(d_COUNT567196a42430);
cudaFree(d_BUF_567196a42540);
cudaFree(d_BUF_IDX_567196a42540);
cudaFree(d_COUNT567196a42540);
cudaFree(d_KEY_5671969f5da0nation__n_name_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT567196a09930);
cudaFree(d_MAT567196a09930aggr0__tmp_attr0);
cudaFree(d_MAT567196a09930nation__n_name_encoded);
cudaFree(d_MAT_IDX567196a09930);
free(MAT567196a09930aggr0__tmp_attr0);
free(MAT567196a09930nation__n_name_encoded);
}