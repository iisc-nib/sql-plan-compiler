#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_55d9d61ff050(uint64_t* COUNT55d9d61dc060, DBStringType* n1___n_name, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n1___n_name = n1___n_name[tid];
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
//Materialize count
atomicAdd((int*)COUNT55d9d61dc060, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_55d9d61ff050(uint64_t* BUF_55d9d61dc060, uint64_t* BUF_IDX_55d9d61dc060, HASHTABLE_INSERT HT_55d9d61dc060, DBStringType* n1___n_name, DBI32Type* n1___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n1___n_name = n1___n_name[tid];
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
uint64_t KEY_55d9d61dc060 = 0;
auto reg_n1___n_nationkey = n1___n_nationkey[tid];

KEY_55d9d61dc060 |= reg_n1___n_nationkey;
// Insert hash table kernel;
auto buf_idx_55d9d61dc060 = atomicAdd((int*)BUF_IDX_55d9d61dc060, 1);
HT_55d9d61dc060.insert(cuco::pair{KEY_55d9d61dc060, buf_idx_55d9d61dc060});
BUF_55d9d61dc060[buf_idx_55d9d61dc060 * 1 + 0] = tid;
}
__global__ void count_55d9d6202ac0(uint64_t* COUNT55d9d61fb1f0, DBStringType* n2___n_name, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n2___n_name = n2___n_name[tid];
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
//Materialize count
atomicAdd((int*)COUNT55d9d61fb1f0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_55d9d6202ac0(uint64_t* BUF_55d9d61fb1f0, uint64_t* BUF_IDX_55d9d61fb1f0, HASHTABLE_INSERT HT_55d9d61fb1f0, DBStringType* n2___n_name, DBI32Type* n2___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n2___n_name = n2___n_name[tid];
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
uint64_t KEY_55d9d61fb1f0 = 0;
auto reg_n2___n_nationkey = n2___n_nationkey[tid];

KEY_55d9d61fb1f0 |= reg_n2___n_nationkey;
// Insert hash table kernel;
auto buf_idx_55d9d61fb1f0 = atomicAdd((int*)BUF_IDX_55d9d61fb1f0, 1);
HT_55d9d61fb1f0.insert(cuco::pair{KEY_55d9d61fb1f0, buf_idx_55d9d61fb1f0});
BUF_55d9d61fb1f0[buf_idx_55d9d61fb1f0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_55d9d6203cb0(uint64_t* BUF_55d9d61fb1f0, uint64_t* COUNT55d9d61f0350, HASHTABLE_PROBE HT_55d9d61fb1f0, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_55d9d61fb1f0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_55d9d61fb1f0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_55d9d61fb1f0.for_each(KEY_55d9d61fb1f0, [&] __device__ (auto const SLOT_55d9d61fb1f0) {

auto const [slot_first55d9d61fb1f0, slot_second55d9d61fb1f0] = SLOT_55d9d61fb1f0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT55d9d61f0350, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_55d9d6203cb0(uint64_t* BUF_55d9d61f0350, uint64_t* BUF_55d9d61fb1f0, uint64_t* BUF_IDX_55d9d61f0350, HASHTABLE_INSERT HT_55d9d61f0350, HASHTABLE_PROBE HT_55d9d61fb1f0, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_55d9d61fb1f0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_55d9d61fb1f0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_55d9d61fb1f0.for_each(KEY_55d9d61fb1f0, [&] __device__ (auto const SLOT_55d9d61fb1f0) {
auto const [slot_first55d9d61fb1f0, slot_second55d9d61fb1f0] = SLOT_55d9d61fb1f0;
if (!(true)) return;
uint64_t KEY_55d9d61f0350 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_55d9d61f0350 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_55d9d61f0350 = atomicAdd((int*)BUF_IDX_55d9d61f0350, 1);
HT_55d9d61f0350.insert(cuco::pair{KEY_55d9d61f0350, buf_idx_55d9d61f0350});
BUF_55d9d61f0350[buf_idx_55d9d61f0350 * 2 + 0] = BUF_55d9d61fb1f0[slot_second55d9d61fb1f0 * 1 + 0];
BUF_55d9d61f0350[buf_idx_55d9d61f0350 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_55d9d61fd630(uint64_t* BUF_55d9d61f0350, uint64_t* COUNT55d9d61f2090, HASHTABLE_PROBE HT_55d9d61f0350, DBI32Type* orders__o_custkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_55d9d61f0350 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_55d9d61f0350 |= reg_orders__o_custkey;
//Probe Hash table
HT_55d9d61f0350.for_each(KEY_55d9d61f0350, [&] __device__ (auto const SLOT_55d9d61f0350) {

auto const [slot_first55d9d61f0350, slot_second55d9d61f0350] = SLOT_55d9d61f0350;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT55d9d61f2090, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_55d9d61fd630(uint64_t* BUF_55d9d61f0350, uint64_t* BUF_55d9d61f2090, uint64_t* BUF_IDX_55d9d61f2090, HASHTABLE_PROBE HT_55d9d61f0350, HASHTABLE_INSERT HT_55d9d61f2090, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_55d9d61f0350 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_55d9d61f0350 |= reg_orders__o_custkey;
//Probe Hash table
HT_55d9d61f0350.for_each(KEY_55d9d61f0350, [&] __device__ (auto const SLOT_55d9d61f0350) {
auto const [slot_first55d9d61f0350, slot_second55d9d61f0350] = SLOT_55d9d61f0350;
if (!(true)) return;
uint64_t KEY_55d9d61f2090 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_55d9d61f2090 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_55d9d61f2090 = atomicAdd((int*)BUF_IDX_55d9d61f2090, 1);
HT_55d9d61f2090.insert(cuco::pair{KEY_55d9d61f2090, buf_idx_55d9d61f2090});
BUF_55d9d61f2090[buf_idx_55d9d61f2090 * 3 + 0] = tid;
BUF_55d9d61f2090[buf_idx_55d9d61f2090 * 3 + 1] = BUF_55d9d61f0350[slot_second55d9d61f0350 * 2 + 0];
BUF_55d9d61f2090[buf_idx_55d9d61f2090 * 3 + 2] = BUF_55d9d61f0350[slot_second55d9d61f0350 * 2 + 1];
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_55d9d61dae10(uint64_t* BUF_55d9d61dc060, uint64_t* COUNT55d9d61f21a0, HASHTABLE_PROBE HT_55d9d61dc060, DBI32Type* supplier__s_nationkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_55d9d61dc060 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_55d9d61dc060 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_55d9d61dc060.for_each(KEY_55d9d61dc060, [&] __device__ (auto const SLOT_55d9d61dc060) {

auto const [slot_first55d9d61dc060, slot_second55d9d61dc060] = SLOT_55d9d61dc060;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT55d9d61f21a0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_55d9d61dae10(uint64_t* BUF_55d9d61dc060, uint64_t* BUF_55d9d61f21a0, uint64_t* BUF_IDX_55d9d61f21a0, HASHTABLE_PROBE HT_55d9d61dc060, HASHTABLE_INSERT HT_55d9d61f21a0, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_55d9d61dc060 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_55d9d61dc060 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_55d9d61dc060.for_each(KEY_55d9d61dc060, [&] __device__ (auto const SLOT_55d9d61dc060) {
auto const [slot_first55d9d61dc060, slot_second55d9d61dc060] = SLOT_55d9d61dc060;
if (!(true)) return;
uint64_t KEY_55d9d61f21a0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_55d9d61f21a0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_55d9d61f21a0 = atomicAdd((int*)BUF_IDX_55d9d61f21a0, 1);
HT_55d9d61f21a0.insert(cuco::pair{KEY_55d9d61f21a0, buf_idx_55d9d61f21a0});
BUF_55d9d61f21a0[buf_idx_55d9d61f21a0 * 2 + 0] = tid;
BUF_55d9d61f21a0[buf_idx_55d9d61f21a0 * 2 + 1] = BUF_55d9d61dc060[slot_second55d9d61dc060 * 1 + 0];
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_55d9d61db3e0(uint64_t* BUF_55d9d61f2090, uint64_t* BUF_55d9d61f21a0, HASHTABLE_INSERT HT_55d9d61a8de0, HASHTABLE_PROBE HT_55d9d61f2090, HASHTABLE_PROBE HT_55d9d61f21a0, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBI16Type* n1___n_name_encoded, DBStringType* n2___n_name, DBI16Type* n2___n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9861, Predicate::lte))) return;
uint64_t KEY_55d9d61f2090 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_55d9d61f2090 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_55d9d61f2090.for_each(KEY_55d9d61f2090, [&] __device__ (auto const SLOT_55d9d61f2090) {

auto const [slot_first55d9d61f2090, slot_second55d9d61f2090] = SLOT_55d9d61f2090;
if (!(true)) return;
uint64_t KEY_55d9d61f21a0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_55d9d61f21a0 |= reg_lineitem__l_suppkey;
//Probe Hash table
HT_55d9d61f21a0.for_each(KEY_55d9d61f21a0, [&] __device__ (auto const SLOT_55d9d61f21a0) {

auto const [slot_first55d9d61f21a0, slot_second55d9d61f21a0] = SLOT_55d9d61f21a0;
auto reg_n1___n_name = n1___n_name[BUF_55d9d61f21a0[slot_second55d9d61f21a0 * 2 + 1]];
auto reg_n2___n_name = n2___n_name[BUF_55d9d61f2090[slot_second55d9d61f2090 * 3 + 1]];
if (!((((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) && (true))) return;
uint64_t KEY_55d9d61a8de0 = 0;
auto reg_n1___n_name_encoded = n1___n_name_encoded[BUF_55d9d61f21a0[slot_second55d9d61f21a0 * 2 + 1]];

KEY_55d9d61a8de0 |= reg_n1___n_name_encoded;
auto reg_n2___n_name_encoded = n2___n_name_encoded[BUF_55d9d61f2090[slot_second55d9d61f2090 * 3 + 1]];
KEY_55d9d61a8de0 <<= 16;
KEY_55d9d61a8de0 |= reg_n2___n_name_encoded;
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_lineitem__l_shipdate);
KEY_55d9d61a8de0 <<= 32;
KEY_55d9d61a8de0 |= (DBI32Type)reg_map0__tmp_attr0;
//Create aggregation hash table
HT_55d9d61a8de0.insert(cuco::pair{KEY_55d9d61a8de0, 1});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_55d9d61db3e0(uint64_t* BUF_55d9d61f2090, uint64_t* BUF_55d9d61f21a0, HASHTABLE_FIND HT_55d9d61a8de0, HASHTABLE_PROBE HT_55d9d61f2090, HASHTABLE_PROBE HT_55d9d61f21a0, DBI64Type* KEY_55d9d61a8de0map0__tmp_attr0, DBI16Type* KEY_55d9d61a8de0n1___n_name_encoded, DBI16Type* KEY_55d9d61a8de0n2___n_name_encoded, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBI16Type* n1___n_name_encoded, DBStringType* n2___n_name, DBI16Type* n2___n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9861, Predicate::lte))) return;
uint64_t KEY_55d9d61f2090 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_55d9d61f2090 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_55d9d61f2090.for_each(KEY_55d9d61f2090, [&] __device__ (auto const SLOT_55d9d61f2090) {
auto const [slot_first55d9d61f2090, slot_second55d9d61f2090] = SLOT_55d9d61f2090;
if (!(true)) return;
uint64_t KEY_55d9d61f21a0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_55d9d61f21a0 |= reg_lineitem__l_suppkey;
//Probe Hash table
HT_55d9d61f21a0.for_each(KEY_55d9d61f21a0, [&] __device__ (auto const SLOT_55d9d61f21a0) {
auto const [slot_first55d9d61f21a0, slot_second55d9d61f21a0] = SLOT_55d9d61f21a0;
auto reg_n1___n_name = n1___n_name[BUF_55d9d61f21a0[slot_second55d9d61f21a0 * 2 + 1]];
auto reg_n2___n_name = n2___n_name[BUF_55d9d61f2090[slot_second55d9d61f2090 * 3 + 1]];
if (!((((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) && (true))) return;
uint64_t KEY_55d9d61a8de0 = 0;
auto reg_n1___n_name_encoded = n1___n_name_encoded[BUF_55d9d61f21a0[slot_second55d9d61f21a0 * 2 + 1]];

KEY_55d9d61a8de0 |= reg_n1___n_name_encoded;
auto reg_n2___n_name_encoded = n2___n_name_encoded[BUF_55d9d61f2090[slot_second55d9d61f2090 * 3 + 1]];
KEY_55d9d61a8de0 <<= 16;
KEY_55d9d61a8de0 |= reg_n2___n_name_encoded;
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_lineitem__l_shipdate);
KEY_55d9d61a8de0 <<= 32;
KEY_55d9d61a8de0 |= (DBI32Type)reg_map0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_55d9d61a8de0 = HT_55d9d61a8de0.find(KEY_55d9d61a8de0)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_55d9d61a8de0], reg_map0__tmp_attr1);
KEY_55d9d61a8de0n1___n_name_encoded[buf_idx_55d9d61a8de0] = reg_n1___n_name_encoded;
KEY_55d9d61a8de0n2___n_name_encoded[buf_idx_55d9d61a8de0] = reg_n2___n_name_encoded;
KEY_55d9d61a8de0map0__tmp_attr0[buf_idx_55d9d61a8de0] = reg_map0__tmp_attr0;
});
});
}
__global__ void count_55d9d6217d40(size_t COUNT55d9d61a8de0, uint64_t* COUNT55d9d61bd2d0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT55d9d61a8de0) return;
//Materialize count
atomicAdd((int*)COUNT55d9d61bd2d0, 1);
}
__global__ void main_55d9d6217d40(size_t COUNT55d9d61a8de0, DBDecimalType* MAT55d9d61bd2d0aggr0__tmp_attr2, DBI64Type* MAT55d9d61bd2d0map0__tmp_attr0, DBI16Type* MAT55d9d61bd2d0n1___n_name_encoded, DBI16Type* MAT55d9d61bd2d0n2___n_name_encoded, uint64_t* MAT_IDX55d9d61bd2d0, DBDecimalType* aggr0__tmp_attr2, DBI64Type* map0__tmp_attr0, DBI16Type* n1___n_name_encoded, DBI16Type* n2___n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT55d9d61a8de0) return;
//Materialize buffers
auto mat_idx55d9d61bd2d0 = atomicAdd((int*)MAT_IDX55d9d61bd2d0, 1);
auto reg_n1___n_name_encoded = n1___n_name_encoded[tid];
MAT55d9d61bd2d0n1___n_name_encoded[mat_idx55d9d61bd2d0] = reg_n1___n_name_encoded;
auto reg_n2___n_name_encoded = n2___n_name_encoded[tid];
MAT55d9d61bd2d0n2___n_name_encoded[mat_idx55d9d61bd2d0] = reg_n2___n_name_encoded;
auto reg_map0__tmp_attr0 = map0__tmp_attr0[tid];
MAT55d9d61bd2d0map0__tmp_attr0[mat_idx55d9d61bd2d0] = reg_map0__tmp_attr0;
auto reg_aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
MAT55d9d61bd2d0aggr0__tmp_attr2[mat_idx55d9d61bd2d0] = reg_aggr0__tmp_attr2;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map) {
//Materialize count
uint64_t* d_COUNT55d9d61dc060;
cudaMalloc(&d_COUNT55d9d61dc060, sizeof(uint64_t));
cudaMemset(d_COUNT55d9d61dc060, 0, sizeof(uint64_t));
count_55d9d61ff050<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT55d9d61dc060, d_nation__n_name, nation_size);
uint64_t COUNT55d9d61dc060;
cudaMemcpy(&COUNT55d9d61dc060, d_COUNT55d9d61dc060, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_55d9d61dc060;
cudaMalloc(&d_BUF_IDX_55d9d61dc060, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_55d9d61dc060, 0, sizeof(uint64_t));
uint64_t* d_BUF_55d9d61dc060;
cudaMalloc(&d_BUF_55d9d61dc060, sizeof(uint64_t) * COUNT55d9d61dc060 * 1);
auto d_HT_55d9d61dc060 = cuco::experimental::static_multimap{ (int)COUNT55d9d61dc060*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_55d9d61ff050<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_55d9d61dc060, d_BUF_IDX_55d9d61dc060, d_HT_55d9d61dc060.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
//Materialize count
uint64_t* d_COUNT55d9d61fb1f0;
cudaMalloc(&d_COUNT55d9d61fb1f0, sizeof(uint64_t));
cudaMemset(d_COUNT55d9d61fb1f0, 0, sizeof(uint64_t));
count_55d9d6202ac0<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT55d9d61fb1f0, d_nation__n_name, nation_size);
uint64_t COUNT55d9d61fb1f0;
cudaMemcpy(&COUNT55d9d61fb1f0, d_COUNT55d9d61fb1f0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_55d9d61fb1f0;
cudaMalloc(&d_BUF_IDX_55d9d61fb1f0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_55d9d61fb1f0, 0, sizeof(uint64_t));
uint64_t* d_BUF_55d9d61fb1f0;
cudaMalloc(&d_BUF_55d9d61fb1f0, sizeof(uint64_t) * COUNT55d9d61fb1f0 * 1);
auto d_HT_55d9d61fb1f0 = cuco::experimental::static_multimap{ (int)COUNT55d9d61fb1f0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_55d9d6202ac0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_55d9d61fb1f0, d_BUF_IDX_55d9d61fb1f0, d_HT_55d9d61fb1f0.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
//Materialize count
uint64_t* d_COUNT55d9d61f0350;
cudaMalloc(&d_COUNT55d9d61f0350, sizeof(uint64_t));
cudaMemset(d_COUNT55d9d61f0350, 0, sizeof(uint64_t));
count_55d9d6203cb0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_55d9d61fb1f0, d_COUNT55d9d61f0350, d_HT_55d9d61fb1f0.ref(cuco::for_each), d_customer__c_nationkey, customer_size);
uint64_t COUNT55d9d61f0350;
cudaMemcpy(&COUNT55d9d61f0350, d_COUNT55d9d61f0350, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_55d9d61f0350;
cudaMalloc(&d_BUF_IDX_55d9d61f0350, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_55d9d61f0350, 0, sizeof(uint64_t));
uint64_t* d_BUF_55d9d61f0350;
cudaMalloc(&d_BUF_55d9d61f0350, sizeof(uint64_t) * COUNT55d9d61f0350 * 2);
auto d_HT_55d9d61f0350 = cuco::experimental::static_multimap{ (int)COUNT55d9d61f0350*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_55d9d6203cb0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_55d9d61f0350, d_BUF_55d9d61fb1f0, d_BUF_IDX_55d9d61f0350, d_HT_55d9d61f0350.ref(cuco::insert), d_HT_55d9d61fb1f0.ref(cuco::for_each), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
//Materialize count
uint64_t* d_COUNT55d9d61f2090;
cudaMalloc(&d_COUNT55d9d61f2090, sizeof(uint64_t));
cudaMemset(d_COUNT55d9d61f2090, 0, sizeof(uint64_t));
count_55d9d61fd630<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_55d9d61f0350, d_COUNT55d9d61f2090, d_HT_55d9d61f0350.ref(cuco::for_each), d_orders__o_custkey, orders_size);
uint64_t COUNT55d9d61f2090;
cudaMemcpy(&COUNT55d9d61f2090, d_COUNT55d9d61f2090, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_55d9d61f2090;
cudaMalloc(&d_BUF_IDX_55d9d61f2090, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_55d9d61f2090, 0, sizeof(uint64_t));
uint64_t* d_BUF_55d9d61f2090;
cudaMalloc(&d_BUF_55d9d61f2090, sizeof(uint64_t) * COUNT55d9d61f2090 * 3);
auto d_HT_55d9d61f2090 = cuco::experimental::static_multimap{ (int)COUNT55d9d61f2090*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_55d9d61fd630<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_55d9d61f0350, d_BUF_55d9d61f2090, d_BUF_IDX_55d9d61f2090, d_HT_55d9d61f0350.ref(cuco::for_each), d_HT_55d9d61f2090.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderkey, orders_size);
//Materialize count
uint64_t* d_COUNT55d9d61f21a0;
cudaMalloc(&d_COUNT55d9d61f21a0, sizeof(uint64_t));
cudaMemset(d_COUNT55d9d61f21a0, 0, sizeof(uint64_t));
count_55d9d61dae10<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_55d9d61dc060, d_COUNT55d9d61f21a0, d_HT_55d9d61dc060.ref(cuco::for_each), d_supplier__s_nationkey, supplier_size);
uint64_t COUNT55d9d61f21a0;
cudaMemcpy(&COUNT55d9d61f21a0, d_COUNT55d9d61f21a0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_55d9d61f21a0;
cudaMalloc(&d_BUF_IDX_55d9d61f21a0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_55d9d61f21a0, 0, sizeof(uint64_t));
uint64_t* d_BUF_55d9d61f21a0;
cudaMalloc(&d_BUF_55d9d61f21a0, sizeof(uint64_t) * COUNT55d9d61f21a0 * 2);
auto d_HT_55d9d61f21a0 = cuco::experimental::static_multimap{ (int)COUNT55d9d61f21a0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_55d9d61dae10<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_55d9d61dc060, d_BUF_55d9d61f21a0, d_BUF_IDX_55d9d61f21a0, d_HT_55d9d61dc060.ref(cuco::for_each), d_HT_55d9d61f21a0.ref(cuco::insert), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
//Create aggregation hash table
auto d_HT_55d9d61a8de0 = cuco::static_map{ (int)13634*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_55d9d61db3e0<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_55d9d61f2090, d_BUF_55d9d61f21a0, d_HT_55d9d61a8de0.ref(cuco::insert), d_HT_55d9d61f2090.ref(cuco::for_each), d_HT_55d9d61f21a0.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name_encoded, d_nation__n_name, d_nation__n_name_encoded);
size_t COUNT55d9d61a8de0 = d_HT_55d9d61a8de0.size();
thrust::device_vector<int64_t> keys_55d9d61a8de0(COUNT55d9d61a8de0), vals_55d9d61a8de0(COUNT55d9d61a8de0);
d_HT_55d9d61a8de0.retrieve_all(keys_55d9d61a8de0.begin(), vals_55d9d61a8de0.begin());
d_HT_55d9d61a8de0.clear();
int64_t* raw_keys55d9d61a8de0 = thrust::raw_pointer_cast(keys_55d9d61a8de0.data());
insertKeys<<<std::ceil((float)COUNT55d9d61a8de0/32.), 32>>>(raw_keys55d9d61a8de0, d_HT_55d9d61a8de0.ref(cuco::insert), COUNT55d9d61a8de0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT55d9d61a8de0);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT55d9d61a8de0);
DBI16Type* d_KEY_55d9d61a8de0n1___n_name_encoded;
cudaMalloc(&d_KEY_55d9d61a8de0n1___n_name_encoded, sizeof(DBI16Type) * COUNT55d9d61a8de0);
cudaMemset(d_KEY_55d9d61a8de0n1___n_name_encoded, 0, sizeof(DBI16Type) * COUNT55d9d61a8de0);
DBI16Type* d_KEY_55d9d61a8de0n2___n_name_encoded;
cudaMalloc(&d_KEY_55d9d61a8de0n2___n_name_encoded, sizeof(DBI16Type) * COUNT55d9d61a8de0);
cudaMemset(d_KEY_55d9d61a8de0n2___n_name_encoded, 0, sizeof(DBI16Type) * COUNT55d9d61a8de0);
DBI64Type* d_KEY_55d9d61a8de0map0__tmp_attr0;
cudaMalloc(&d_KEY_55d9d61a8de0map0__tmp_attr0, sizeof(DBI64Type) * COUNT55d9d61a8de0);
cudaMemset(d_KEY_55d9d61a8de0map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT55d9d61a8de0);
main_55d9d61db3e0<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_55d9d61f2090, d_BUF_55d9d61f21a0, d_HT_55d9d61a8de0.ref(cuco::find), d_HT_55d9d61f2090.ref(cuco::for_each), d_HT_55d9d61f21a0.ref(cuco::for_each), d_KEY_55d9d61a8de0map0__tmp_attr0, d_KEY_55d9d61a8de0n1___n_name_encoded, d_KEY_55d9d61a8de0n2___n_name_encoded, d_aggr0__tmp_attr2, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name_encoded, d_nation__n_name, d_nation__n_name_encoded);
//Materialize count
uint64_t* d_COUNT55d9d61bd2d0;
cudaMalloc(&d_COUNT55d9d61bd2d0, sizeof(uint64_t));
cudaMemset(d_COUNT55d9d61bd2d0, 0, sizeof(uint64_t));
count_55d9d6217d40<<<std::ceil((float)COUNT55d9d61a8de0/32.), 32>>>(COUNT55d9d61a8de0, d_COUNT55d9d61bd2d0);
uint64_t COUNT55d9d61bd2d0;
cudaMemcpy(&COUNT55d9d61bd2d0, d_COUNT55d9d61bd2d0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX55d9d61bd2d0;
cudaMalloc(&d_MAT_IDX55d9d61bd2d0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX55d9d61bd2d0, 0, sizeof(uint64_t));
auto MAT55d9d61bd2d0n1___n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT55d9d61bd2d0);
DBI16Type* d_MAT55d9d61bd2d0n1___n_name_encoded;
cudaMalloc(&d_MAT55d9d61bd2d0n1___n_name_encoded, sizeof(DBI16Type) * COUNT55d9d61bd2d0);
auto MAT55d9d61bd2d0n2___n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT55d9d61bd2d0);
DBI16Type* d_MAT55d9d61bd2d0n2___n_name_encoded;
cudaMalloc(&d_MAT55d9d61bd2d0n2___n_name_encoded, sizeof(DBI16Type) * COUNT55d9d61bd2d0);
auto MAT55d9d61bd2d0map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT55d9d61bd2d0);
DBI64Type* d_MAT55d9d61bd2d0map0__tmp_attr0;
cudaMalloc(&d_MAT55d9d61bd2d0map0__tmp_attr0, sizeof(DBI64Type) * COUNT55d9d61bd2d0);
auto MAT55d9d61bd2d0aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT55d9d61bd2d0);
DBDecimalType* d_MAT55d9d61bd2d0aggr0__tmp_attr2;
cudaMalloc(&d_MAT55d9d61bd2d0aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT55d9d61bd2d0);
main_55d9d6217d40<<<std::ceil((float)COUNT55d9d61a8de0/32.), 32>>>(COUNT55d9d61a8de0, d_MAT55d9d61bd2d0aggr0__tmp_attr2, d_MAT55d9d61bd2d0map0__tmp_attr0, d_MAT55d9d61bd2d0n1___n_name_encoded, d_MAT55d9d61bd2d0n2___n_name_encoded, d_MAT_IDX55d9d61bd2d0, d_aggr0__tmp_attr2, d_KEY_55d9d61a8de0map0__tmp_attr0, d_KEY_55d9d61a8de0n1___n_name_encoded, d_KEY_55d9d61a8de0n2___n_name_encoded);
cudaMemcpy(MAT55d9d61bd2d0n1___n_name_encoded, d_MAT55d9d61bd2d0n1___n_name_encoded, sizeof(DBI16Type) * COUNT55d9d61bd2d0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT55d9d61bd2d0n2___n_name_encoded, d_MAT55d9d61bd2d0n2___n_name_encoded, sizeof(DBI16Type) * COUNT55d9d61bd2d0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT55d9d61bd2d0map0__tmp_attr0, d_MAT55d9d61bd2d0map0__tmp_attr0, sizeof(DBI64Type) * COUNT55d9d61bd2d0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT55d9d61bd2d0aggr0__tmp_attr2, d_MAT55d9d61bd2d0aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT55d9d61bd2d0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT55d9d61bd2d0; i++) { std::cout << n1___n_name_map[MAT55d9d61bd2d0n1___n_name_encoded[i]] << "\t";
std::cout << n2___n_name_map[MAT55d9d61bd2d0n2___n_name_encoded[i]] << "\t";
std::cout << MAT55d9d61bd2d0map0__tmp_attr0[i] << "\t";
std::cout << MAT55d9d61bd2d0aggr0__tmp_attr2[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_55d9d61dc060);
cudaFree(d_BUF_IDX_55d9d61dc060);
cudaFree(d_COUNT55d9d61dc060);
cudaFree(d_BUF_55d9d61fb1f0);
cudaFree(d_BUF_IDX_55d9d61fb1f0);
cudaFree(d_COUNT55d9d61fb1f0);
cudaFree(d_BUF_55d9d61f0350);
cudaFree(d_BUF_IDX_55d9d61f0350);
cudaFree(d_COUNT55d9d61f0350);
cudaFree(d_BUF_55d9d61f2090);
cudaFree(d_BUF_IDX_55d9d61f2090);
cudaFree(d_COUNT55d9d61f2090);
cudaFree(d_BUF_55d9d61f21a0);
cudaFree(d_BUF_IDX_55d9d61f21a0);
cudaFree(d_COUNT55d9d61f21a0);
cudaFree(d_KEY_55d9d61a8de0map0__tmp_attr0);
cudaFree(d_KEY_55d9d61a8de0n1___n_name_encoded);
cudaFree(d_KEY_55d9d61a8de0n2___n_name_encoded);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_COUNT55d9d61bd2d0);
cudaFree(d_MAT55d9d61bd2d0aggr0__tmp_attr2);
cudaFree(d_MAT55d9d61bd2d0map0__tmp_attr0);
cudaFree(d_MAT55d9d61bd2d0n1___n_name_encoded);
cudaFree(d_MAT55d9d61bd2d0n2___n_name_encoded);
cudaFree(d_MAT_IDX55d9d61bd2d0);
free(MAT55d9d61bd2d0aggr0__tmp_attr2);
free(MAT55d9d61bd2d0map0__tmp_attr0);
free(MAT55d9d61bd2d0n1___n_name_encoded);
free(MAT55d9d61bd2d0n2___n_name_encoded);
}