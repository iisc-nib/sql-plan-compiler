#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_611b03fad7f0(uint64_t* COUNT611b03fa7e60, DBStringType* n1___n_name, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n1___n_name = n1___n_name[tid];
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
//Materialize count
atomicAdd((int*)COUNT611b03fa7e60, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_611b03fad7f0(uint64_t* BUF_611b03fa7e60, uint64_t* BUF_IDX_611b03fa7e60, HASHTABLE_INSERT HT_611b03fa7e60, DBStringType* n1___n_name, DBI32Type* n1___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n1___n_name = n1___n_name[tid];
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
uint64_t KEY_611b03fa7e60 = 0;
auto reg_n1___n_nationkey = n1___n_nationkey[tid];

KEY_611b03fa7e60 |= reg_n1___n_nationkey;
// Insert hash table kernel;
auto buf_idx_611b03fa7e60 = atomicAdd((int*)BUF_IDX_611b03fa7e60, 1);
HT_611b03fa7e60.insert(cuco::pair{KEY_611b03fa7e60, buf_idx_611b03fa7e60});
BUF_611b03fa7e60[buf_idx_611b03fa7e60 * 1 + 0] = tid;
}
__global__ void count_611b03fb1360(uint64_t* COUNT611b03fa7b40, DBStringType* n2___n_name, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n2___n_name = n2___n_name[tid];
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
//Materialize count
atomicAdd((int*)COUNT611b03fa7b40, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_611b03fb1360(uint64_t* BUF_611b03fa7b40, uint64_t* BUF_IDX_611b03fa7b40, HASHTABLE_INSERT HT_611b03fa7b40, DBStringType* n2___n_name, DBI32Type* n2___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n2___n_name = n2___n_name[tid];
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
uint64_t KEY_611b03fa7b40 = 0;
auto reg_n2___n_nationkey = n2___n_nationkey[tid];

KEY_611b03fa7b40 |= reg_n2___n_nationkey;
// Insert hash table kernel;
auto buf_idx_611b03fa7b40 = atomicAdd((int*)BUF_IDX_611b03fa7b40, 1);
HT_611b03fa7b40.insert(cuco::pair{KEY_611b03fa7b40, buf_idx_611b03fa7b40});
BUF_611b03fa7b40[buf_idx_611b03fa7b40 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_611b03fb26f0(uint64_t* BUF_611b03fa7b40, uint64_t* COUNT611b03f9e270, HASHTABLE_PROBE HT_611b03fa7b40, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_611b03fa7b40 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_611b03fa7b40 |= reg_customer__c_nationkey;
//Probe Hash table
HT_611b03fa7b40.for_each(KEY_611b03fa7b40, [&] __device__ (auto const SLOT_611b03fa7b40) {

auto const [slot_first611b03fa7b40, slot_second611b03fa7b40] = SLOT_611b03fa7b40;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT611b03f9e270, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_611b03fb26f0(uint64_t* BUF_611b03f9e270, uint64_t* BUF_611b03fa7b40, uint64_t* BUF_IDX_611b03f9e270, HASHTABLE_INSERT HT_611b03f9e270, HASHTABLE_PROBE HT_611b03fa7b40, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_611b03fa7b40 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_611b03fa7b40 |= reg_customer__c_nationkey;
//Probe Hash table
HT_611b03fa7b40.for_each(KEY_611b03fa7b40, [&] __device__ (auto const SLOT_611b03fa7b40) {
auto const [slot_first611b03fa7b40, slot_second611b03fa7b40] = SLOT_611b03fa7b40;
if (!(true)) return;
uint64_t KEY_611b03f9e270 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_611b03f9e270 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_611b03f9e270 = atomicAdd((int*)BUF_IDX_611b03f9e270, 1);
HT_611b03f9e270.insert(cuco::pair{KEY_611b03f9e270, buf_idx_611b03f9e270});
BUF_611b03f9e270[buf_idx_611b03f9e270 * 2 + 0] = BUF_611b03fa7b40[slot_second611b03fa7b40 * 1 + 0];
BUF_611b03f9e270[buf_idx_611b03f9e270 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_611b03fab9c0(uint64_t* BUF_611b03f9e270, uint64_t* COUNT611b03f9d9e0, HASHTABLE_PROBE HT_611b03f9e270, DBI32Type* orders__o_custkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_611b03f9e270 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_611b03f9e270 |= reg_orders__o_custkey;
//Probe Hash table
HT_611b03f9e270.for_each(KEY_611b03f9e270, [&] __device__ (auto const SLOT_611b03f9e270) {

auto const [slot_first611b03f9e270, slot_second611b03f9e270] = SLOT_611b03f9e270;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT611b03f9d9e0, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_611b03fab9c0(uint64_t* BUF_611b03f9d9e0, uint64_t* BUF_611b03f9e270, uint64_t* BUF_IDX_611b03f9d9e0, HASHTABLE_INSERT HT_611b03f9d9e0, HASHTABLE_PROBE HT_611b03f9e270, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_611b03f9e270 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_611b03f9e270 |= reg_orders__o_custkey;
//Probe Hash table
HT_611b03f9e270.for_each(KEY_611b03f9e270, [&] __device__ (auto const SLOT_611b03f9e270) {
auto const [slot_first611b03f9e270, slot_second611b03f9e270] = SLOT_611b03f9e270;
if (!(true)) return;
uint64_t KEY_611b03f9d9e0 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_611b03f9d9e0 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_611b03f9d9e0 = atomicAdd((int*)BUF_IDX_611b03f9d9e0, 1);
HT_611b03f9d9e0.insert(cuco::pair{KEY_611b03f9d9e0, buf_idx_611b03f9d9e0});
BUF_611b03f9d9e0[buf_idx_611b03f9d9e0 * 3 + 0] = tid;
BUF_611b03f9d9e0[buf_idx_611b03f9d9e0 * 3 + 1] = BUF_611b03f9e270[slot_second611b03f9e270 * 2 + 0];
BUF_611b03f9d9e0[buf_idx_611b03f9d9e0 * 3 + 2] = BUF_611b03f9e270[slot_second611b03f9e270 * 2 + 1];
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_611b03f88730(uint64_t* BUF_611b03fa7e60, uint64_t* COUNT611b03f9ffa0, HASHTABLE_PROBE HT_611b03fa7e60, DBI32Type* supplier__s_nationkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_611b03fa7e60 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_611b03fa7e60 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_611b03fa7e60.for_each(KEY_611b03fa7e60, [&] __device__ (auto const SLOT_611b03fa7e60) {

auto const [slot_first611b03fa7e60, slot_second611b03fa7e60] = SLOT_611b03fa7e60;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT611b03f9ffa0, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_611b03f88730(uint64_t* BUF_611b03f9ffa0, uint64_t* BUF_611b03fa7e60, uint64_t* BUF_IDX_611b03f9ffa0, HASHTABLE_INSERT HT_611b03f9ffa0, HASHTABLE_PROBE HT_611b03fa7e60, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_611b03fa7e60 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_611b03fa7e60 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_611b03fa7e60.for_each(KEY_611b03fa7e60, [&] __device__ (auto const SLOT_611b03fa7e60) {
auto const [slot_first611b03fa7e60, slot_second611b03fa7e60] = SLOT_611b03fa7e60;
if (!(true)) return;
uint64_t KEY_611b03f9ffa0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_611b03f9ffa0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_611b03f9ffa0 = atomicAdd((int*)BUF_IDX_611b03f9ffa0, 1);
HT_611b03f9ffa0.insert(cuco::pair{KEY_611b03f9ffa0, buf_idx_611b03f9ffa0});
BUF_611b03f9ffa0[buf_idx_611b03f9ffa0 * 2 + 0] = tid;
BUF_611b03f9ffa0[buf_idx_611b03f9ffa0 * 2 + 1] = BUF_611b03fa7e60[slot_second611b03fa7e60 * 1 + 0];
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_611b03f88d00(uint64_t* BUF_611b03f9d9e0, uint64_t* BUF_611b03f9ffa0, HASHTABLE_INSERT HT_611b03f57ca0, HASHTABLE_PROBE HT_611b03f9d9e0, HASHTABLE_PROBE HT_611b03f9ffa0, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBI16Type* n1___n_name_encoded, DBStringType* n2___n_name, DBI16Type* n2___n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9861, Predicate::lte))) return;
uint64_t KEY_611b03f9d9e0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_611b03f9d9e0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_611b03f9d9e0.for_each(KEY_611b03f9d9e0, [&] __device__ (auto const SLOT_611b03f9d9e0) {

auto const [slot_first611b03f9d9e0, slot_second611b03f9d9e0] = SLOT_611b03f9d9e0;
if (!(true)) return;
uint64_t KEY_611b03f9ffa0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_611b03f9ffa0 |= reg_lineitem__l_suppkey;
//Probe Hash table
HT_611b03f9ffa0.for_each(KEY_611b03f9ffa0, [&] __device__ (auto const SLOT_611b03f9ffa0) {

auto const [slot_first611b03f9ffa0, slot_second611b03f9ffa0] = SLOT_611b03f9ffa0;
auto reg_n1___n_name = n1___n_name[BUF_611b03f9ffa0[slot_second611b03f9ffa0 * 2 + 1]];
auto reg_n2___n_name = n2___n_name[BUF_611b03f9d9e0[slot_second611b03f9d9e0 * 3 + 1]];
if (!((((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) && (true))) return;
uint64_t KEY_611b03f57ca0 = 0;
auto reg_n1___n_name_encoded = n1___n_name_encoded[BUF_611b03f9ffa0[slot_second611b03f9ffa0 * 2 + 1]];

KEY_611b03f57ca0 |= reg_n1___n_name_encoded;
auto reg_n2___n_name_encoded = n2___n_name_encoded[BUF_611b03f9d9e0[slot_second611b03f9d9e0 * 3 + 1]];
KEY_611b03f57ca0 <<= 16;
KEY_611b03f57ca0 |= reg_n2___n_name_encoded;
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_lineitem__l_shipdate);
KEY_611b03f57ca0 <<= 32;
KEY_611b03f57ca0 |= (DBI32Type)reg_map0__tmp_attr0;
//Create aggregation hash table
HT_611b03f57ca0.insert(cuco::pair{KEY_611b03f57ca0, 1});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_611b03f88d00(uint64_t* BUF_611b03f9d9e0, uint64_t* BUF_611b03f9ffa0, HASHTABLE_FIND HT_611b03f57ca0, HASHTABLE_PROBE HT_611b03f9d9e0, HASHTABLE_PROBE HT_611b03f9ffa0, DBI64Type* KEY_611b03f57ca0map0__tmp_attr0, DBI16Type* KEY_611b03f57ca0n1___n_name_encoded, DBI16Type* KEY_611b03f57ca0n2___n_name_encoded, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBI16Type* n1___n_name_encoded, DBStringType* n2___n_name, DBI16Type* n2___n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9861, Predicate::lte))) return;
uint64_t KEY_611b03f9d9e0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_611b03f9d9e0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_611b03f9d9e0.for_each(KEY_611b03f9d9e0, [&] __device__ (auto const SLOT_611b03f9d9e0) {
auto const [slot_first611b03f9d9e0, slot_second611b03f9d9e0] = SLOT_611b03f9d9e0;
if (!(true)) return;
uint64_t KEY_611b03f9ffa0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_611b03f9ffa0 |= reg_lineitem__l_suppkey;
//Probe Hash table
HT_611b03f9ffa0.for_each(KEY_611b03f9ffa0, [&] __device__ (auto const SLOT_611b03f9ffa0) {
auto const [slot_first611b03f9ffa0, slot_second611b03f9ffa0] = SLOT_611b03f9ffa0;
auto reg_n1___n_name = n1___n_name[BUF_611b03f9ffa0[slot_second611b03f9ffa0 * 2 + 1]];
auto reg_n2___n_name = n2___n_name[BUF_611b03f9d9e0[slot_second611b03f9d9e0 * 3 + 1]];
if (!((((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) && (true))) return;
uint64_t KEY_611b03f57ca0 = 0;
auto reg_n1___n_name_encoded = n1___n_name_encoded[BUF_611b03f9ffa0[slot_second611b03f9ffa0 * 2 + 1]];

KEY_611b03f57ca0 |= reg_n1___n_name_encoded;
auto reg_n2___n_name_encoded = n2___n_name_encoded[BUF_611b03f9d9e0[slot_second611b03f9d9e0 * 3 + 1]];
KEY_611b03f57ca0 <<= 16;
KEY_611b03f57ca0 |= reg_n2___n_name_encoded;
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_lineitem__l_shipdate);
KEY_611b03f57ca0 <<= 32;
KEY_611b03f57ca0 |= (DBI32Type)reg_map0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_611b03f57ca0 = HT_611b03f57ca0.find(KEY_611b03f57ca0)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_611b03f57ca0], reg_map0__tmp_attr1);
KEY_611b03f57ca0n1___n_name_encoded[buf_idx_611b03f57ca0] = reg_n1___n_name_encoded;
KEY_611b03f57ca0n2___n_name_encoded[buf_idx_611b03f57ca0] = reg_n2___n_name_encoded;
KEY_611b03f57ca0map0__tmp_attr0[buf_idx_611b03f57ca0] = reg_map0__tmp_attr0;
});
});
}
__global__ void count_611b03fc6700(size_t COUNT611b03f57ca0, uint64_t* COUNT611b03f6b3a0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT611b03f57ca0) return;
//Materialize count
atomicAdd((int*)COUNT611b03f6b3a0, 1);
}
__global__ void main_611b03fc6700(size_t COUNT611b03f57ca0, DBDecimalType* MAT611b03f6b3a0aggr0__tmp_attr2, DBI64Type* MAT611b03f6b3a0map0__tmp_attr0, DBI16Type* MAT611b03f6b3a0n1___n_name_encoded, DBI16Type* MAT611b03f6b3a0n2___n_name_encoded, uint64_t* MAT_IDX611b03f6b3a0, DBDecimalType* aggr0__tmp_attr2, DBI64Type* map0__tmp_attr0, DBI16Type* n1___n_name_encoded, DBI16Type* n2___n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT611b03f57ca0) return;
//Materialize buffers
auto mat_idx611b03f6b3a0 = atomicAdd((int*)MAT_IDX611b03f6b3a0, 1);
auto reg_n1___n_name_encoded = n1___n_name_encoded[tid];
MAT611b03f6b3a0n1___n_name_encoded[mat_idx611b03f6b3a0] = reg_n1___n_name_encoded;
auto reg_n2___n_name_encoded = n2___n_name_encoded[tid];
MAT611b03f6b3a0n2___n_name_encoded[mat_idx611b03f6b3a0] = reg_n2___n_name_encoded;
auto reg_map0__tmp_attr0 = map0__tmp_attr0[tid];
MAT611b03f6b3a0map0__tmp_attr0[mat_idx611b03f6b3a0] = reg_map0__tmp_attr0;
auto reg_aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
MAT611b03f6b3a0aggr0__tmp_attr2[mat_idx611b03f6b3a0] = reg_aggr0__tmp_attr2;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map) {
//Materialize count
uint64_t* d_COUNT611b03fa7e60;
cudaMalloc(&d_COUNT611b03fa7e60, sizeof(uint64_t));
cudaMemset(d_COUNT611b03fa7e60, 0, sizeof(uint64_t));
count_611b03fad7f0<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT611b03fa7e60, d_nation__n_name, nation_size);
uint64_t COUNT611b03fa7e60;
cudaMemcpy(&COUNT611b03fa7e60, d_COUNT611b03fa7e60, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_611b03fa7e60;
cudaMalloc(&d_BUF_IDX_611b03fa7e60, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_611b03fa7e60, 0, sizeof(uint64_t));
uint64_t* d_BUF_611b03fa7e60;
cudaMalloc(&d_BUF_611b03fa7e60, sizeof(uint64_t) * COUNT611b03fa7e60 * 1);
auto d_HT_611b03fa7e60 = cuco::experimental::static_multimap{ (int)COUNT611b03fa7e60*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_611b03fad7f0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_611b03fa7e60, d_BUF_IDX_611b03fa7e60, d_HT_611b03fa7e60.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
//Materialize count
uint64_t* d_COUNT611b03fa7b40;
cudaMalloc(&d_COUNT611b03fa7b40, sizeof(uint64_t));
cudaMemset(d_COUNT611b03fa7b40, 0, sizeof(uint64_t));
count_611b03fb1360<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT611b03fa7b40, d_nation__n_name, nation_size);
uint64_t COUNT611b03fa7b40;
cudaMemcpy(&COUNT611b03fa7b40, d_COUNT611b03fa7b40, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_611b03fa7b40;
cudaMalloc(&d_BUF_IDX_611b03fa7b40, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_611b03fa7b40, 0, sizeof(uint64_t));
uint64_t* d_BUF_611b03fa7b40;
cudaMalloc(&d_BUF_611b03fa7b40, sizeof(uint64_t) * COUNT611b03fa7b40 * 1);
auto d_HT_611b03fa7b40 = cuco::experimental::static_multimap{ (int)COUNT611b03fa7b40*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_611b03fb1360<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_611b03fa7b40, d_BUF_IDX_611b03fa7b40, d_HT_611b03fa7b40.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
//Materialize count
uint64_t* d_COUNT611b03f9e270;
cudaMalloc(&d_COUNT611b03f9e270, sizeof(uint64_t));
cudaMemset(d_COUNT611b03f9e270, 0, sizeof(uint64_t));
count_611b03fb26f0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_611b03fa7b40, d_COUNT611b03f9e270, d_HT_611b03fa7b40.ref(cuco::for_each), d_customer__c_nationkey, customer_size);
uint64_t COUNT611b03f9e270;
cudaMemcpy(&COUNT611b03f9e270, d_COUNT611b03f9e270, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_611b03f9e270;
cudaMalloc(&d_BUF_IDX_611b03f9e270, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_611b03f9e270, 0, sizeof(uint64_t));
uint64_t* d_BUF_611b03f9e270;
cudaMalloc(&d_BUF_611b03f9e270, sizeof(uint64_t) * COUNT611b03f9e270 * 2);
auto d_HT_611b03f9e270 = cuco::experimental::static_multimap{ (int)COUNT611b03f9e270*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_611b03fb26f0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_611b03f9e270, d_BUF_611b03fa7b40, d_BUF_IDX_611b03f9e270, d_HT_611b03f9e270.ref(cuco::insert), d_HT_611b03fa7b40.ref(cuco::for_each), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
//Materialize count
uint64_t* d_COUNT611b03f9d9e0;
cudaMalloc(&d_COUNT611b03f9d9e0, sizeof(uint64_t));
cudaMemset(d_COUNT611b03f9d9e0, 0, sizeof(uint64_t));
count_611b03fab9c0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_611b03f9e270, d_COUNT611b03f9d9e0, d_HT_611b03f9e270.ref(cuco::for_each), d_orders__o_custkey, orders_size);
uint64_t COUNT611b03f9d9e0;
cudaMemcpy(&COUNT611b03f9d9e0, d_COUNT611b03f9d9e0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_611b03f9d9e0;
cudaMalloc(&d_BUF_IDX_611b03f9d9e0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_611b03f9d9e0, 0, sizeof(uint64_t));
uint64_t* d_BUF_611b03f9d9e0;
cudaMalloc(&d_BUF_611b03f9d9e0, sizeof(uint64_t) * COUNT611b03f9d9e0 * 3);
auto d_HT_611b03f9d9e0 = cuco::experimental::static_multimap{ (int)COUNT611b03f9d9e0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_611b03fab9c0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_611b03f9d9e0, d_BUF_611b03f9e270, d_BUF_IDX_611b03f9d9e0, d_HT_611b03f9d9e0.ref(cuco::insert), d_HT_611b03f9e270.ref(cuco::for_each), d_orders__o_custkey, d_orders__o_orderkey, orders_size);
//Materialize count
uint64_t* d_COUNT611b03f9ffa0;
cudaMalloc(&d_COUNT611b03f9ffa0, sizeof(uint64_t));
cudaMemset(d_COUNT611b03f9ffa0, 0, sizeof(uint64_t));
count_611b03f88730<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_611b03fa7e60, d_COUNT611b03f9ffa0, d_HT_611b03fa7e60.ref(cuco::for_each), d_supplier__s_nationkey, supplier_size);
uint64_t COUNT611b03f9ffa0;
cudaMemcpy(&COUNT611b03f9ffa0, d_COUNT611b03f9ffa0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_611b03f9ffa0;
cudaMalloc(&d_BUF_IDX_611b03f9ffa0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_611b03f9ffa0, 0, sizeof(uint64_t));
uint64_t* d_BUF_611b03f9ffa0;
cudaMalloc(&d_BUF_611b03f9ffa0, sizeof(uint64_t) * COUNT611b03f9ffa0 * 2);
auto d_HT_611b03f9ffa0 = cuco::experimental::static_multimap{ (int)COUNT611b03f9ffa0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_611b03f88730<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_611b03f9ffa0, d_BUF_611b03fa7e60, d_BUF_IDX_611b03f9ffa0, d_HT_611b03f9ffa0.ref(cuco::insert), d_HT_611b03fa7e60.ref(cuco::for_each), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
//Create aggregation hash table
auto d_HT_611b03f57ca0 = cuco::static_map{ (int)13634*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_611b03f88d00<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_611b03f9d9e0, d_BUF_611b03f9ffa0, d_HT_611b03f57ca0.ref(cuco::insert), d_HT_611b03f9d9e0.ref(cuco::for_each), d_HT_611b03f9ffa0.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name_encoded, d_nation__n_name, d_nation__n_name_encoded);
size_t COUNT611b03f57ca0 = d_HT_611b03f57ca0.size();
thrust::device_vector<int64_t> keys_611b03f57ca0(COUNT611b03f57ca0), vals_611b03f57ca0(COUNT611b03f57ca0);
d_HT_611b03f57ca0.retrieve_all(keys_611b03f57ca0.begin(), vals_611b03f57ca0.begin());
d_HT_611b03f57ca0.clear();
int64_t* raw_keys611b03f57ca0 = thrust::raw_pointer_cast(keys_611b03f57ca0.data());
insertKeys<<<std::ceil((float)COUNT611b03f57ca0/32.), 32>>>(raw_keys611b03f57ca0, d_HT_611b03f57ca0.ref(cuco::insert), COUNT611b03f57ca0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT611b03f57ca0);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT611b03f57ca0);
DBI16Type* d_KEY_611b03f57ca0n1___n_name_encoded;
cudaMalloc(&d_KEY_611b03f57ca0n1___n_name_encoded, sizeof(DBI16Type) * COUNT611b03f57ca0);
cudaMemset(d_KEY_611b03f57ca0n1___n_name_encoded, 0, sizeof(DBI16Type) * COUNT611b03f57ca0);
DBI16Type* d_KEY_611b03f57ca0n2___n_name_encoded;
cudaMalloc(&d_KEY_611b03f57ca0n2___n_name_encoded, sizeof(DBI16Type) * COUNT611b03f57ca0);
cudaMemset(d_KEY_611b03f57ca0n2___n_name_encoded, 0, sizeof(DBI16Type) * COUNT611b03f57ca0);
DBI64Type* d_KEY_611b03f57ca0map0__tmp_attr0;
cudaMalloc(&d_KEY_611b03f57ca0map0__tmp_attr0, sizeof(DBI64Type) * COUNT611b03f57ca0);
cudaMemset(d_KEY_611b03f57ca0map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT611b03f57ca0);
main_611b03f88d00<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_611b03f9d9e0, d_BUF_611b03f9ffa0, d_HT_611b03f57ca0.ref(cuco::find), d_HT_611b03f9d9e0.ref(cuco::for_each), d_HT_611b03f9ffa0.ref(cuco::for_each), d_KEY_611b03f57ca0map0__tmp_attr0, d_KEY_611b03f57ca0n1___n_name_encoded, d_KEY_611b03f57ca0n2___n_name_encoded, d_aggr0__tmp_attr2, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name_encoded, d_nation__n_name, d_nation__n_name_encoded);
//Materialize count
uint64_t* d_COUNT611b03f6b3a0;
cudaMalloc(&d_COUNT611b03f6b3a0, sizeof(uint64_t));
cudaMemset(d_COUNT611b03f6b3a0, 0, sizeof(uint64_t));
count_611b03fc6700<<<std::ceil((float)COUNT611b03f57ca0/32.), 32>>>(COUNT611b03f57ca0, d_COUNT611b03f6b3a0);
uint64_t COUNT611b03f6b3a0;
cudaMemcpy(&COUNT611b03f6b3a0, d_COUNT611b03f6b3a0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX611b03f6b3a0;
cudaMalloc(&d_MAT_IDX611b03f6b3a0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX611b03f6b3a0, 0, sizeof(uint64_t));
auto MAT611b03f6b3a0n1___n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT611b03f6b3a0);
DBI16Type* d_MAT611b03f6b3a0n1___n_name_encoded;
cudaMalloc(&d_MAT611b03f6b3a0n1___n_name_encoded, sizeof(DBI16Type) * COUNT611b03f6b3a0);
auto MAT611b03f6b3a0n2___n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT611b03f6b3a0);
DBI16Type* d_MAT611b03f6b3a0n2___n_name_encoded;
cudaMalloc(&d_MAT611b03f6b3a0n2___n_name_encoded, sizeof(DBI16Type) * COUNT611b03f6b3a0);
auto MAT611b03f6b3a0map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT611b03f6b3a0);
DBI64Type* d_MAT611b03f6b3a0map0__tmp_attr0;
cudaMalloc(&d_MAT611b03f6b3a0map0__tmp_attr0, sizeof(DBI64Type) * COUNT611b03f6b3a0);
auto MAT611b03f6b3a0aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT611b03f6b3a0);
DBDecimalType* d_MAT611b03f6b3a0aggr0__tmp_attr2;
cudaMalloc(&d_MAT611b03f6b3a0aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT611b03f6b3a0);
main_611b03fc6700<<<std::ceil((float)COUNT611b03f57ca0/32.), 32>>>(COUNT611b03f57ca0, d_MAT611b03f6b3a0aggr0__tmp_attr2, d_MAT611b03f6b3a0map0__tmp_attr0, d_MAT611b03f6b3a0n1___n_name_encoded, d_MAT611b03f6b3a0n2___n_name_encoded, d_MAT_IDX611b03f6b3a0, d_aggr0__tmp_attr2, d_KEY_611b03f57ca0map0__tmp_attr0, d_KEY_611b03f57ca0n1___n_name_encoded, d_KEY_611b03f57ca0n2___n_name_encoded);
cudaMemcpy(MAT611b03f6b3a0n1___n_name_encoded, d_MAT611b03f6b3a0n1___n_name_encoded, sizeof(DBI16Type) * COUNT611b03f6b3a0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT611b03f6b3a0n2___n_name_encoded, d_MAT611b03f6b3a0n2___n_name_encoded, sizeof(DBI16Type) * COUNT611b03f6b3a0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT611b03f6b3a0map0__tmp_attr0, d_MAT611b03f6b3a0map0__tmp_attr0, sizeof(DBI64Type) * COUNT611b03f6b3a0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT611b03f6b3a0aggr0__tmp_attr2, d_MAT611b03f6b3a0aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT611b03f6b3a0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT611b03f6b3a0; i++) { std::cout << n1___n_name_map[MAT611b03f6b3a0n1___n_name_encoded[i]] << "\t";
std::cout << n2___n_name_map[MAT611b03f6b3a0n2___n_name_encoded[i]] << "\t";
std::cout << MAT611b03f6b3a0map0__tmp_attr0[i] << "\t";
std::cout << MAT611b03f6b3a0aggr0__tmp_attr2[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_611b03fa7e60);
cudaFree(d_BUF_IDX_611b03fa7e60);
cudaFree(d_COUNT611b03fa7e60);
cudaFree(d_BUF_611b03fa7b40);
cudaFree(d_BUF_IDX_611b03fa7b40);
cudaFree(d_COUNT611b03fa7b40);
cudaFree(d_BUF_611b03f9e270);
cudaFree(d_BUF_IDX_611b03f9e270);
cudaFree(d_COUNT611b03f9e270);
cudaFree(d_BUF_611b03f9d9e0);
cudaFree(d_BUF_IDX_611b03f9d9e0);
cudaFree(d_COUNT611b03f9d9e0);
cudaFree(d_BUF_611b03f9ffa0);
cudaFree(d_BUF_IDX_611b03f9ffa0);
cudaFree(d_COUNT611b03f9ffa0);
cudaFree(d_KEY_611b03f57ca0map0__tmp_attr0);
cudaFree(d_KEY_611b03f57ca0n1___n_name_encoded);
cudaFree(d_KEY_611b03f57ca0n2___n_name_encoded);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_COUNT611b03f6b3a0);
cudaFree(d_MAT611b03f6b3a0aggr0__tmp_attr2);
cudaFree(d_MAT611b03f6b3a0map0__tmp_attr0);
cudaFree(d_MAT611b03f6b3a0n1___n_name_encoded);
cudaFree(d_MAT611b03f6b3a0n2___n_name_encoded);
cudaFree(d_MAT_IDX611b03f6b3a0);
free(MAT611b03f6b3a0aggr0__tmp_attr2);
free(MAT611b03f6b3a0map0__tmp_attr0);
free(MAT611b03f6b3a0n1___n_name_encoded);
free(MAT611b03f6b3a0n2___n_name_encoded);
}