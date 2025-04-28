#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_59055ebe58d0(uint64_t* COUNT59055ebd7580, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
//Materialize count
atomicAdd((int*)COUNT59055ebd7580, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_59055ebe58d0(uint64_t* BUF_59055ebd7580, uint64_t* BUF_IDX_59055ebd7580, HASHTABLE_INSERT HT_59055ebd7580, DBI32Type* nation__n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_59055ebd7580 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_59055ebd7580 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_59055ebd7580 = atomicAdd((int*)BUF_IDX_59055ebd7580, 1);
HT_59055ebd7580.insert(cuco::pair{KEY_59055ebd7580, buf_idx_59055ebd7580});
BUF_59055ebd7580[buf_idx_59055ebd7580 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_59055ebc2740(uint64_t* BUF_59055ebd7580, uint64_t* COUNT59055ebd63c0, HASHTABLE_PROBE HT_59055ebd7580, DBI32Type* supplier__s_nationkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_59055ebd7580 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_59055ebd7580 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_59055ebd7580.for_each(KEY_59055ebd7580, [&] __device__ (auto const SLOT_59055ebd7580) {

auto const [slot_first59055ebd7580, slot_second59055ebd7580] = SLOT_59055ebd7580;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT59055ebd63c0, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_59055ebc2740(uint64_t* BUF_59055ebd63c0, uint64_t* BUF_59055ebd7580, uint64_t* BUF_IDX_59055ebd63c0, HASHTABLE_INSERT HT_59055ebd63c0, HASHTABLE_PROBE HT_59055ebd7580, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_59055ebd7580 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_59055ebd7580 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_59055ebd7580.for_each(KEY_59055ebd7580, [&] __device__ (auto const SLOT_59055ebd7580) {
auto const [slot_first59055ebd7580, slot_second59055ebd7580] = SLOT_59055ebd7580;
if (!(true)) return;
uint64_t KEY_59055ebd63c0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_59055ebd63c0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_59055ebd63c0 = atomicAdd((int*)BUF_IDX_59055ebd63c0, 1);
HT_59055ebd63c0.insert(cuco::pair{KEY_59055ebd63c0, buf_idx_59055ebd63c0});
BUF_59055ebd63c0[buf_idx_59055ebd63c0 * 2 + 0] = tid;
BUF_59055ebd63c0[buf_idx_59055ebd63c0 * 2 + 1] = BUF_59055ebd7580[slot_second59055ebd7580 * 1 + 0];
});
}
__global__ void count_59055ebec730(uint64_t* COUNT59055ebdd8d0, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
//Materialize count
atomicAdd((int*)COUNT59055ebdd8d0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_59055ebec730(uint64_t* BUF_59055ebdd8d0, uint64_t* BUF_IDX_59055ebdd8d0, HASHTABLE_INSERT HT_59055ebdd8d0, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_59055ebdd8d0 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_59055ebdd8d0 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_59055ebdd8d0 = atomicAdd((int*)BUF_IDX_59055ebdd8d0, 1);
HT_59055ebdd8d0.insert(cuco::pair{KEY_59055ebdd8d0, buf_idx_59055ebdd8d0});
BUF_59055ebdd8d0[buf_idx_59055ebdd8d0 * 1 + 0] = tid;
}
__global__ void count_59055ebc2110(uint64_t* COUNT59055ebdd990, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
//Materialize count
atomicAdd((int*)COUNT59055ebdd990, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_59055ebc2110(uint64_t* BUF_59055ebdd990, uint64_t* BUF_IDX_59055ebdd990, HASHTABLE_INSERT HT_59055ebdd990, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
uint64_t KEY_59055ebdd990 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_59055ebdd990 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_59055ebdd990 = atomicAdd((int*)BUF_IDX_59055ebdd990, 1);
HT_59055ebdd990.insert(cuco::pair{KEY_59055ebdd990, buf_idx_59055ebdd990});
BUF_59055ebdd990[buf_idx_59055ebdd990 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_59055ebe4890(uint64_t* BUF_59055ebd63c0, uint64_t* COUNT59055ebddaa0, HASHTABLE_PROBE HT_59055ebd63c0, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= partsupp_size) return;
uint64_t KEY_59055ebd63c0 = 0;
auto reg_partsupp__ps_suppkey = partsupp__ps_suppkey[tid];

KEY_59055ebd63c0 |= reg_partsupp__ps_suppkey;
//Probe Hash table
HT_59055ebd63c0.for_each(KEY_59055ebd63c0, [&] __device__ (auto const SLOT_59055ebd63c0) {

auto const [slot_first59055ebd63c0, slot_second59055ebd63c0] = SLOT_59055ebd63c0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT59055ebddaa0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_59055ebe4890(uint64_t* BUF_59055ebd63c0, uint64_t* BUF_59055ebddaa0, uint64_t* BUF_IDX_59055ebddaa0, HASHTABLE_PROBE HT_59055ebd63c0, HASHTABLE_INSERT HT_59055ebddaa0, DBI32Type* partsupp__ps_partkey, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size, DBI32Type* supplier__s_suppkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= partsupp_size) return;
uint64_t KEY_59055ebd63c0 = 0;
auto reg_partsupp__ps_suppkey = partsupp__ps_suppkey[tid];

KEY_59055ebd63c0 |= reg_partsupp__ps_suppkey;
//Probe Hash table
HT_59055ebd63c0.for_each(KEY_59055ebd63c0, [&] __device__ (auto const SLOT_59055ebd63c0) {
auto const [slot_first59055ebd63c0, slot_second59055ebd63c0] = SLOT_59055ebd63c0;
if (!(true)) return;
uint64_t KEY_59055ebddaa0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[BUF_59055ebd63c0[slot_second59055ebd63c0 * 2 + 0]];

KEY_59055ebddaa0 |= reg_supplier__s_suppkey;
auto reg_partsupp__ps_partkey = partsupp__ps_partkey[tid];
KEY_59055ebddaa0 <<= 32;
KEY_59055ebddaa0 |= reg_partsupp__ps_partkey;
// Insert hash table kernel;
auto buf_idx_59055ebddaa0 = atomicAdd((int*)BUF_IDX_59055ebddaa0, 1);
HT_59055ebddaa0.insert(cuco::pair{KEY_59055ebddaa0, buf_idx_59055ebddaa0});
BUF_59055ebddaa0[buf_idx_59055ebddaa0 * 3 + 0] = BUF_59055ebd63c0[slot_second59055ebd63c0 * 2 + 0];
BUF_59055ebddaa0[buf_idx_59055ebddaa0 * 3 + 1] = tid;
BUF_59055ebddaa0[buf_idx_59055ebddaa0 * 3 + 2] = BUF_59055ebd63c0[slot_second59055ebd63c0 * 2 + 1];
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_59055ebe2030(uint64_t* BUF_59055ebdd8d0, uint64_t* BUF_59055ebdd990, uint64_t* BUF_59055ebddaa0, HASHTABLE_INSERT HT_59055eb91bb0, HASHTABLE_PROBE HT_59055ebdd8d0, HASHTABLE_PROBE HT_59055ebdd990, HASHTABLE_PROBE HT_59055ebddaa0, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_partkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBI16Type* nation__n_name_encoded, DBDateType* orders__o_orderdate) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_59055ebdd8d0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_59055ebdd8d0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_59055ebdd8d0.for_each(KEY_59055ebdd8d0, [&] __device__ (auto const SLOT_59055ebdd8d0) {

auto const [slot_first59055ebdd8d0, slot_second59055ebdd8d0] = SLOT_59055ebdd8d0;
if (!(true)) return;
uint64_t KEY_59055ebdd990 = 0;
auto reg_lineitem__l_partkey = lineitem__l_partkey[tid];

KEY_59055ebdd990 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_59055ebdd990.for_each(KEY_59055ebdd990, [&] __device__ (auto const SLOT_59055ebdd990) {

auto const [slot_first59055ebdd990, slot_second59055ebdd990] = SLOT_59055ebdd990;
if (!(true)) return;
uint64_t KEY_59055ebddaa0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_59055ebddaa0 |= reg_lineitem__l_suppkey;
KEY_59055ebddaa0 <<= 32;
KEY_59055ebddaa0 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_59055ebddaa0.for_each(KEY_59055ebddaa0, [&] __device__ (auto const SLOT_59055ebddaa0) {

auto const [slot_first59055ebddaa0, slot_second59055ebddaa0] = SLOT_59055ebddaa0;
if (!(true)) return;
uint64_t KEY_59055eb91bb0 = 0;
auto reg_nation__n_name_encoded = nation__n_name_encoded[BUF_59055ebddaa0[slot_second59055ebddaa0 * 3 + 2]];

KEY_59055eb91bb0 |= reg_nation__n_name_encoded;
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_59055ebdd8d0[slot_second59055ebdd8d0 * 1 + 0]];
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_orders__o_orderdate);
KEY_59055eb91bb0 <<= 32;
KEY_59055eb91bb0 |= (DBI32Type)reg_map0__tmp_attr0;
//Create aggregation hash table
HT_59055eb91bb0.insert(cuco::pair{KEY_59055eb91bb0, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_59055ebe2030(uint64_t* BUF_59055ebdd8d0, uint64_t* BUF_59055ebdd990, uint64_t* BUF_59055ebddaa0, HASHTABLE_FIND HT_59055eb91bb0, HASHTABLE_PROBE HT_59055ebdd8d0, HASHTABLE_PROBE HT_59055ebdd990, HASHTABLE_PROBE HT_59055ebddaa0, DBI64Type* KEY_59055eb91bb0map0__tmp_attr0, DBI16Type* KEY_59055eb91bb0nation__n_name_encoded, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_partkey, DBDecimalType* lineitem__l_quantity, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBI16Type* nation__n_name_encoded, DBDateType* orders__o_orderdate, DBDecimalType* partsupp__ps_supplycost) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_59055ebdd8d0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_59055ebdd8d0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_59055ebdd8d0.for_each(KEY_59055ebdd8d0, [&] __device__ (auto const SLOT_59055ebdd8d0) {
auto const [slot_first59055ebdd8d0, slot_second59055ebdd8d0] = SLOT_59055ebdd8d0;
if (!(true)) return;
uint64_t KEY_59055ebdd990 = 0;
auto reg_lineitem__l_partkey = lineitem__l_partkey[tid];

KEY_59055ebdd990 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_59055ebdd990.for_each(KEY_59055ebdd990, [&] __device__ (auto const SLOT_59055ebdd990) {
auto const [slot_first59055ebdd990, slot_second59055ebdd990] = SLOT_59055ebdd990;
if (!(true)) return;
uint64_t KEY_59055ebddaa0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_59055ebddaa0 |= reg_lineitem__l_suppkey;
KEY_59055ebddaa0 <<= 32;
KEY_59055ebddaa0 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_59055ebddaa0.for_each(KEY_59055ebddaa0, [&] __device__ (auto const SLOT_59055ebddaa0) {
auto const [slot_first59055ebddaa0, slot_second59055ebddaa0] = SLOT_59055ebddaa0;
if (!(true)) return;
uint64_t KEY_59055eb91bb0 = 0;
auto reg_nation__n_name_encoded = nation__n_name_encoded[BUF_59055ebddaa0[slot_second59055ebddaa0 * 3 + 2]];

KEY_59055eb91bb0 |= reg_nation__n_name_encoded;
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_59055ebdd8d0[slot_second59055ebdd8d0 * 1 + 0]];
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_orders__o_orderdate);
KEY_59055eb91bb0 <<= 32;
KEY_59055eb91bb0 |= (DBI32Type)reg_map0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_59055eb91bb0 = HT_59055eb91bb0.find(KEY_59055eb91bb0)->second;
auto reg_lineitem__l_quantity = lineitem__l_quantity[tid];
auto reg_partsupp__ps_supplycost = partsupp__ps_supplycost[BUF_59055ebddaa0[slot_second59055ebddaa0 * 3 + 1]];
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = ((reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount))) - ((reg_partsupp__ps_supplycost) * (reg_lineitem__l_quantity));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_59055eb91bb0], reg_map0__tmp_attr1);
KEY_59055eb91bb0nation__n_name_encoded[buf_idx_59055eb91bb0] = reg_nation__n_name_encoded;
KEY_59055eb91bb0map0__tmp_attr0[buf_idx_59055eb91bb0] = reg_map0__tmp_attr0;
});
});
});
}
__global__ void count_59055ebfb750(size_t COUNT59055eb91bb0, uint64_t* COUNT59055eba5290) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT59055eb91bb0) return;
//Materialize count
atomicAdd((int*)COUNT59055eba5290, 1);
}
__global__ void main_59055ebfb750(size_t COUNT59055eb91bb0, DBDecimalType* MAT59055eba5290aggr0__tmp_attr2, DBI64Type* MAT59055eba5290map0__tmp_attr0, DBI16Type* MAT59055eba5290nation__n_name_encoded, uint64_t* MAT_IDX59055eba5290, DBDecimalType* aggr0__tmp_attr2, DBI64Type* map0__tmp_attr0, DBI16Type* nation__n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT59055eb91bb0) return;
//Materialize buffers
auto mat_idx59055eba5290 = atomicAdd((int*)MAT_IDX59055eba5290, 1);
auto reg_nation__n_name_encoded = nation__n_name_encoded[tid];
MAT59055eba5290nation__n_name_encoded[mat_idx59055eba5290] = reg_nation__n_name_encoded;
auto reg_map0__tmp_attr0 = map0__tmp_attr0[tid];
MAT59055eba5290map0__tmp_attr0[mat_idx59055eba5290] = reg_map0__tmp_attr0;
auto reg_aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
MAT59055eba5290aggr0__tmp_attr2[mat_idx59055eba5290] = reg_aggr0__tmp_attr2;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map) {
//Materialize count
uint64_t* d_COUNT59055ebd7580;
cudaMalloc(&d_COUNT59055ebd7580, sizeof(uint64_t));
cudaMemset(d_COUNT59055ebd7580, 0, sizeof(uint64_t));
count_59055ebe58d0<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT59055ebd7580, nation_size);
uint64_t COUNT59055ebd7580;
cudaMemcpy(&COUNT59055ebd7580, d_COUNT59055ebd7580, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_59055ebd7580;
cudaMalloc(&d_BUF_IDX_59055ebd7580, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59055ebd7580, 0, sizeof(uint64_t));
uint64_t* d_BUF_59055ebd7580;
cudaMalloc(&d_BUF_59055ebd7580, sizeof(uint64_t) * COUNT59055ebd7580 * 1);
auto d_HT_59055ebd7580 = cuco::experimental::static_multimap{ (int)COUNT59055ebd7580*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59055ebe58d0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_59055ebd7580, d_BUF_IDX_59055ebd7580, d_HT_59055ebd7580.ref(cuco::insert), d_nation__n_nationkey, nation_size);
//Materialize count
uint64_t* d_COUNT59055ebd63c0;
cudaMalloc(&d_COUNT59055ebd63c0, sizeof(uint64_t));
cudaMemset(d_COUNT59055ebd63c0, 0, sizeof(uint64_t));
count_59055ebc2740<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_59055ebd7580, d_COUNT59055ebd63c0, d_HT_59055ebd7580.ref(cuco::for_each), d_supplier__s_nationkey, supplier_size);
uint64_t COUNT59055ebd63c0;
cudaMemcpy(&COUNT59055ebd63c0, d_COUNT59055ebd63c0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_59055ebd63c0;
cudaMalloc(&d_BUF_IDX_59055ebd63c0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59055ebd63c0, 0, sizeof(uint64_t));
uint64_t* d_BUF_59055ebd63c0;
cudaMalloc(&d_BUF_59055ebd63c0, sizeof(uint64_t) * COUNT59055ebd63c0 * 2);
auto d_HT_59055ebd63c0 = cuco::experimental::static_multimap{ (int)COUNT59055ebd63c0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59055ebc2740<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_59055ebd63c0, d_BUF_59055ebd7580, d_BUF_IDX_59055ebd63c0, d_HT_59055ebd63c0.ref(cuco::insert), d_HT_59055ebd7580.ref(cuco::for_each), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT59055ebdd8d0;
cudaMalloc(&d_COUNT59055ebdd8d0, sizeof(uint64_t));
cudaMemset(d_COUNT59055ebdd8d0, 0, sizeof(uint64_t));
count_59055ebec730<<<std::ceil((float)orders_size/32.), 32>>>(d_COUNT59055ebdd8d0, orders_size);
uint64_t COUNT59055ebdd8d0;
cudaMemcpy(&COUNT59055ebdd8d0, d_COUNT59055ebdd8d0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_59055ebdd8d0;
cudaMalloc(&d_BUF_IDX_59055ebdd8d0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59055ebdd8d0, 0, sizeof(uint64_t));
uint64_t* d_BUF_59055ebdd8d0;
cudaMalloc(&d_BUF_59055ebdd8d0, sizeof(uint64_t) * COUNT59055ebdd8d0 * 1);
auto d_HT_59055ebdd8d0 = cuco::experimental::static_multimap{ (int)COUNT59055ebdd8d0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59055ebec730<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_59055ebdd8d0, d_BUF_IDX_59055ebdd8d0, d_HT_59055ebdd8d0.ref(cuco::insert), d_orders__o_orderkey, orders_size);
//Materialize count
uint64_t* d_COUNT59055ebdd990;
cudaMalloc(&d_COUNT59055ebdd990, sizeof(uint64_t));
cudaMemset(d_COUNT59055ebdd990, 0, sizeof(uint64_t));
count_59055ebc2110<<<std::ceil((float)part_size/32.), 32>>>(d_COUNT59055ebdd990, part_size);
uint64_t COUNT59055ebdd990;
cudaMemcpy(&COUNT59055ebdd990, d_COUNT59055ebdd990, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_59055ebdd990;
cudaMalloc(&d_BUF_IDX_59055ebdd990, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59055ebdd990, 0, sizeof(uint64_t));
uint64_t* d_BUF_59055ebdd990;
cudaMalloc(&d_BUF_59055ebdd990, sizeof(uint64_t) * COUNT59055ebdd990 * 1);
auto d_HT_59055ebdd990 = cuco::experimental::static_multimap{ (int)COUNT59055ebdd990*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59055ebc2110<<<std::ceil((float)part_size/32.), 32>>>(d_BUF_59055ebdd990, d_BUF_IDX_59055ebdd990, d_HT_59055ebdd990.ref(cuco::insert), d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT59055ebddaa0;
cudaMalloc(&d_COUNT59055ebddaa0, sizeof(uint64_t));
cudaMemset(d_COUNT59055ebddaa0, 0, sizeof(uint64_t));
count_59055ebe4890<<<std::ceil((float)partsupp_size/32.), 32>>>(d_BUF_59055ebd63c0, d_COUNT59055ebddaa0, d_HT_59055ebd63c0.ref(cuco::for_each), d_partsupp__ps_suppkey, partsupp_size);
uint64_t COUNT59055ebddaa0;
cudaMemcpy(&COUNT59055ebddaa0, d_COUNT59055ebddaa0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_59055ebddaa0;
cudaMalloc(&d_BUF_IDX_59055ebddaa0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59055ebddaa0, 0, sizeof(uint64_t));
uint64_t* d_BUF_59055ebddaa0;
cudaMalloc(&d_BUF_59055ebddaa0, sizeof(uint64_t) * COUNT59055ebddaa0 * 3);
auto d_HT_59055ebddaa0 = cuco::experimental::static_multimap{ (int)COUNT59055ebddaa0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59055ebe4890<<<std::ceil((float)partsupp_size/32.), 32>>>(d_BUF_59055ebd63c0, d_BUF_59055ebddaa0, d_BUF_IDX_59055ebddaa0, d_HT_59055ebd63c0.ref(cuco::for_each), d_HT_59055ebddaa0.ref(cuco::insert), d_partsupp__ps_partkey, d_partsupp__ps_suppkey, partsupp_size, d_supplier__s_suppkey);
//Create aggregation hash table
auto d_HT_59055eb91bb0 = cuco::static_map{ (int)48009721*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_59055ebe2030<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_59055ebdd8d0, d_BUF_59055ebdd990, d_BUF_59055ebddaa0, d_HT_59055eb91bb0.ref(cuco::insert), d_HT_59055ebdd8d0.ref(cuco::for_each), d_HT_59055ebdd990.ref(cuco::for_each), d_HT_59055ebddaa0.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_partkey, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name_encoded, d_orders__o_orderdate);
size_t COUNT59055eb91bb0 = d_HT_59055eb91bb0.size();
thrust::device_vector<int64_t> keys_59055eb91bb0(COUNT59055eb91bb0), vals_59055eb91bb0(COUNT59055eb91bb0);
d_HT_59055eb91bb0.retrieve_all(keys_59055eb91bb0.begin(), vals_59055eb91bb0.begin());
d_HT_59055eb91bb0.clear();
int64_t* raw_keys59055eb91bb0 = thrust::raw_pointer_cast(keys_59055eb91bb0.data());
insertKeys<<<std::ceil((float)COUNT59055eb91bb0/32.), 32>>>(raw_keys59055eb91bb0, d_HT_59055eb91bb0.ref(cuco::insert), COUNT59055eb91bb0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT59055eb91bb0);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT59055eb91bb0);
DBI16Type* d_KEY_59055eb91bb0nation__n_name_encoded;
cudaMalloc(&d_KEY_59055eb91bb0nation__n_name_encoded, sizeof(DBI16Type) * COUNT59055eb91bb0);
cudaMemset(d_KEY_59055eb91bb0nation__n_name_encoded, 0, sizeof(DBI16Type) * COUNT59055eb91bb0);
DBI64Type* d_KEY_59055eb91bb0map0__tmp_attr0;
cudaMalloc(&d_KEY_59055eb91bb0map0__tmp_attr0, sizeof(DBI64Type) * COUNT59055eb91bb0);
cudaMemset(d_KEY_59055eb91bb0map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT59055eb91bb0);
main_59055ebe2030<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_59055ebdd8d0, d_BUF_59055ebdd990, d_BUF_59055ebddaa0, d_HT_59055eb91bb0.ref(cuco::find), d_HT_59055ebdd8d0.ref(cuco::for_each), d_HT_59055ebdd990.ref(cuco::for_each), d_HT_59055ebddaa0.ref(cuco::for_each), d_KEY_59055eb91bb0map0__tmp_attr0, d_KEY_59055eb91bb0nation__n_name_encoded, d_aggr0__tmp_attr2, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_partkey, d_lineitem__l_quantity, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name_encoded, d_orders__o_orderdate, d_partsupp__ps_supplycost);
//Materialize count
uint64_t* d_COUNT59055eba5290;
cudaMalloc(&d_COUNT59055eba5290, sizeof(uint64_t));
cudaMemset(d_COUNT59055eba5290, 0, sizeof(uint64_t));
count_59055ebfb750<<<std::ceil((float)COUNT59055eb91bb0/32.), 32>>>(COUNT59055eb91bb0, d_COUNT59055eba5290);
uint64_t COUNT59055eba5290;
cudaMemcpy(&COUNT59055eba5290, d_COUNT59055eba5290, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX59055eba5290;
cudaMalloc(&d_MAT_IDX59055eba5290, sizeof(uint64_t));
cudaMemset(d_MAT_IDX59055eba5290, 0, sizeof(uint64_t));
auto MAT59055eba5290nation__n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT59055eba5290);
DBI16Type* d_MAT59055eba5290nation__n_name_encoded;
cudaMalloc(&d_MAT59055eba5290nation__n_name_encoded, sizeof(DBI16Type) * COUNT59055eba5290);
auto MAT59055eba5290map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT59055eba5290);
DBI64Type* d_MAT59055eba5290map0__tmp_attr0;
cudaMalloc(&d_MAT59055eba5290map0__tmp_attr0, sizeof(DBI64Type) * COUNT59055eba5290);
auto MAT59055eba5290aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT59055eba5290);
DBDecimalType* d_MAT59055eba5290aggr0__tmp_attr2;
cudaMalloc(&d_MAT59055eba5290aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT59055eba5290);
main_59055ebfb750<<<std::ceil((float)COUNT59055eb91bb0/32.), 32>>>(COUNT59055eb91bb0, d_MAT59055eba5290aggr0__tmp_attr2, d_MAT59055eba5290map0__tmp_attr0, d_MAT59055eba5290nation__n_name_encoded, d_MAT_IDX59055eba5290, d_aggr0__tmp_attr2, d_KEY_59055eb91bb0map0__tmp_attr0, d_KEY_59055eb91bb0nation__n_name_encoded);
cudaMemcpy(MAT59055eba5290nation__n_name_encoded, d_MAT59055eba5290nation__n_name_encoded, sizeof(DBI16Type) * COUNT59055eba5290, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59055eba5290map0__tmp_attr0, d_MAT59055eba5290map0__tmp_attr0, sizeof(DBI64Type) * COUNT59055eba5290, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59055eba5290aggr0__tmp_attr2, d_MAT59055eba5290aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT59055eba5290, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT59055eba5290; i++) { std::cout << nation__n_name_map[MAT59055eba5290nation__n_name_encoded[i]] << "\t";
std::cout << MAT59055eba5290map0__tmp_attr0[i] << "\t";
std::cout << MAT59055eba5290aggr0__tmp_attr2[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_59055ebd7580);
cudaFree(d_BUF_IDX_59055ebd7580);
cudaFree(d_COUNT59055ebd7580);
cudaFree(d_BUF_59055ebd63c0);
cudaFree(d_BUF_IDX_59055ebd63c0);
cudaFree(d_COUNT59055ebd63c0);
cudaFree(d_BUF_59055ebdd8d0);
cudaFree(d_BUF_IDX_59055ebdd8d0);
cudaFree(d_COUNT59055ebdd8d0);
cudaFree(d_BUF_59055ebdd990);
cudaFree(d_BUF_IDX_59055ebdd990);
cudaFree(d_COUNT59055ebdd990);
cudaFree(d_BUF_59055ebddaa0);
cudaFree(d_BUF_IDX_59055ebddaa0);
cudaFree(d_COUNT59055ebddaa0);
cudaFree(d_KEY_59055eb91bb0map0__tmp_attr0);
cudaFree(d_KEY_59055eb91bb0nation__n_name_encoded);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_COUNT59055eba5290);
cudaFree(d_MAT59055eba5290aggr0__tmp_attr2);
cudaFree(d_MAT59055eba5290map0__tmp_attr0);
cudaFree(d_MAT59055eba5290nation__n_name_encoded);
cudaFree(d_MAT_IDX59055eba5290);
free(MAT59055eba5290aggr0__tmp_attr2);
free(MAT59055eba5290map0__tmp_attr0);
free(MAT59055eba5290nation__n_name_encoded);
}