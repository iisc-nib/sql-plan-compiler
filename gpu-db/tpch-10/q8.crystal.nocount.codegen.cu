#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
#include <chrono>
#define ITEMS_PER_THREAD 4
#define TILE_SIZE 512
#define TB TILE_SIZE/ITEMS_PER_THREAD
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT HT_0, DBI32Type* part__p_partkey, DBStringType* part__p_type, size_t part_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBStringType reg_part__p_type[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_type[ITEM] = part__p_type[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_part__p_type[ITEM], "ECONOMY ANODIZED STEEL", Predicate::eq);
}
uint64_t KEY_0[ITEMS_PER_THREAD];
DBI32Type reg_part__p_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_partkey[ITEM] = part__p_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_0[ITEM] = 0;
KEY_0[ITEM] |= reg_part__p_partkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_0.insert(cuco::pair{KEY_0[ITEM], ITEM*TB + tid});
BUF_0[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_3(uint64_t* BUF_2, uint64_t* BUF_IDX_2, HASHTABLE_INSERT HT_2, DBStringType* region__r_name, DBI32Type* region__r_regionkey, size_t region_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBStringType reg_region__r_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
reg_region__r_name[ITEM] = region__r_name[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_region__r_name[ITEM], "AMERICA", Predicate::eq);
}
uint64_t KEY_2[ITEMS_PER_THREAD];
DBI32Type reg_region__r_regionkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
reg_region__r_regionkey[ITEM] = region__r_regionkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_2[ITEM] = 0;
KEY_2[ITEM] |= reg_region__r_regionkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_2.insert(cuco::pair{KEY_2[ITEM], ITEM*TB + tid});
BUF_2[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_5(uint64_t* BUF_4, uint64_t* BUF_IDX_4, HASHTABLE_INSERT HT_4, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBDateType reg_orders__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderdate[ITEM] = orders__o_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_orders__o_orderdate[ITEM], 9131, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate[ITEM], 9861, Predicate::lte);
}
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_orders__o_orderkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_4.insert(cuco::pair{KEY_4[ITEM], ITEM*TB + tid});
BUF_4[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_7(uint64_t* BUF_6, uint64_t* BUF_IDX_6, HASHTABLE_INSERT HT_6, DBI32Type* customer__c_custkey, size_t customer_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_customer__c_custkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_6.insert(cuco::pair{KEY_6[ITEM], ITEM*TB + tid});
BUF_6[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_9(uint64_t* BUF_2, uint64_t* BUF_8, uint64_t* BUF_IDX_8, HASHTABLE_PROBE HT_2, HASHTABLE_INSERT HT_8, DBI32Type* n1___n_nationkey, DBI32Type* n1___n_regionkey, size_t nation_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_2[ITEMS_PER_THREAD];
DBI32Type reg_n1___n_regionkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_n1___n_regionkey[ITEM] = n1___n_regionkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_2[ITEM] = 0;
KEY_2[ITEM] |= reg_n1___n_regionkey[ITEM];
}
//Probe Hash table
int64_t slot_second2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_2 = HT_2.find(KEY_2[ITEM]);
if (SLOT_2 == HT_2.end()) {selection_flags[ITEM] = 0; continue;}
slot_second2[ITEM] = SLOT_2->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_8[ITEMS_PER_THREAD];
DBI32Type reg_n1___n_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_n1___n_nationkey[ITEM] = n1___n_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_n1___n_nationkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_8.insert(cuco::pair{KEY_8[ITEM], ITEM*TB + tid});
BUF_8[(ITEM*TB + tid) * 2 + 0] = BUF_2[slot_second2[ITEM] * 1 + 0];
BUF_8[(ITEM*TB + tid) * 2 + 1] = ITEM*TB + tid;
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_11(uint64_t* BUF_10, uint64_t* BUF_IDX_10, HASHTABLE_INSERT HT_10, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_10[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_10[ITEM] = 0;
KEY_10[ITEM] |= reg_supplier__s_suppkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_10.insert(cuco::pair{KEY_10[ITEM], ITEM*TB + tid});
BUF_10[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_13(uint64_t* BUF_12, uint64_t* BUF_IDX_12, HASHTABLE_INSERT HT_12, DBI32Type* n2___n_nationkey, size_t nation_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_12[ITEMS_PER_THREAD];
DBI32Type reg_n2___n_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_n2___n_nationkey[ITEM] = n2___n_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_12[ITEM] = 0;
KEY_12[ITEM] |= reg_n2___n_nationkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_12.insert(cuco::pair{KEY_12[ITEM], ITEM*TB + tid});
BUF_12[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_15(uint64_t* BUF_0, uint64_t* BUF_10, uint64_t* BUF_12, uint64_t* BUF_4, uint64_t* BUF_6, uint64_t* BUF_8, HASHTABLE_PROBE HT_0, HASHTABLE_PROBE HT_10, HASHTABLE_PROBE HT_12, HASHTABLE_FIND HT_14, HASHTABLE_PROBE HT_4, HASHTABLE_PROBE HT_6, HASHTABLE_PROBE HT_8, DBI64Type* KEY_14map0__tmp_attr0, int* SLOT_COUNT_14, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* aggr0__tmp_attr4, DBI32Type* customer__c_nationkey, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_partkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n2___n_name, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, DBI32Type* supplier__s_nationkey) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_0[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_partkey[ITEM] = lineitem__l_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_0[ITEM] = 0;
KEY_0[ITEM] |= reg_lineitem__l_partkey[ITEM];
}
//Probe Hash table
int64_t slot_second0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_0 = HT_0.find(KEY_0[ITEM]);
if (SLOT_0 == HT_0.end()) {selection_flags[ITEM] = 0; continue;}
slot_second0[ITEM] = SLOT_0->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_lineitem__l_orderkey[ITEM];
}
//Probe Hash table
int64_t slot_second4[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_4 = HT_4.find(KEY_4[ITEM]);
if (SLOT_4 == HT_4.end()) {selection_flags[ITEM] = 0; continue;}
slot_second4[ITEM] = SLOT_4->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_custkey[ITEM] = orders__o_custkey[BUF_4[slot_second4[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_orders__o_custkey[ITEM];
}
//Probe Hash table
int64_t slot_second6[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_6 = HT_6.find(KEY_6[ITEM]);
if (SLOT_6 == HT_6.end()) {selection_flags[ITEM] = 0; continue;}
slot_second6[ITEM] = SLOT_6->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_8[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_nationkey[ITEM] = customer__c_nationkey[BUF_6[slot_second6[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_customer__c_nationkey[ITEM];
}
//Probe Hash table
int64_t slot_second8[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_8 = HT_8.find(KEY_8[ITEM]);
if (SLOT_8 == HT_8.end()) {selection_flags[ITEM] = 0; continue;}
slot_second8[ITEM] = SLOT_8->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_10[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_suppkey[ITEM] = lineitem__l_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_10[ITEM] = 0;
KEY_10[ITEM] |= reg_lineitem__l_suppkey[ITEM];
}
//Probe Hash table
int64_t slot_second10[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_10 = HT_10.find(KEY_10[ITEM]);
if (SLOT_10 == HT_10.end()) {selection_flags[ITEM] = 0; continue;}
slot_second10[ITEM] = SLOT_10->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_12[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_supplier__s_nationkey[ITEM] = supplier__s_nationkey[BUF_10[slot_second10[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_12[ITEM] = 0;
KEY_12[ITEM] |= reg_supplier__s_nationkey[ITEM];
}
//Probe Hash table
int64_t slot_second12[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_12 = HT_12.find(KEY_12[ITEM]);
if (SLOT_12 == HT_12.end()) {selection_flags[ITEM] = 0; continue;}
slot_second12[ITEM] = SLOT_12->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
DBDateType reg_orders__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_orderdate[ITEM] = orders__o_orderdate[BUF_4[slot_second4[ITEM] * 1 + 0]];
}
uint64_t KEY_14[ITEMS_PER_THREAD];
DBI64Type reg_map0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr0[ITEM] = ExtractFromDate("year", reg_orders__o_orderdate[ITEM]);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_14[ITEM] = 0;
KEY_14[ITEM] |= (DBI32Type)reg_map0__tmp_attr0[ITEM];
}
//Aggregate in hashtable
DBDecimalType reg_lineitem__l_discount[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_discount[ITEM] = lineitem__l_discount[ITEM*TB + tid];
}
DBDecimalType reg_lineitem__l_extendedprice[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_extendedprice[ITEM] = lineitem__l_extendedprice[ITEM*TB + tid];
}
DBDecimalType reg_map0__tmp_attr1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr1[ITEM] = (reg_lineitem__l_extendedprice[ITEM]) * ((1.0) - (reg_lineitem__l_discount[ITEM]));
}
DBStringType reg_n2___n_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_n2___n_name[ITEM] = n2___n_name[BUF_12[slot_second12[ITEM] * 1 + 0]];
}
DBDecimalType reg_map1__tmp_attr3[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map1__tmp_attr3[ITEM] = ((evaluatePredicate(reg_n2___n_name[ITEM], "BRAZIL", Predicate::eq))) ? ((reg_map0__tmp_attr1[ITEM])) : ((0.0));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_14 = get_aggregation_slot(KEY_14[ITEM], HT_14, SLOT_COUNT_14);
aggregate_sum(&aggr0__tmp_attr4[buf_idx_14], reg_map0__tmp_attr1[ITEM]);
aggregate_sum(&aggr0__tmp_attr2[buf_idx_14], reg_map1__tmp_attr3[ITEM]);
KEY_14map0__tmp_attr0[buf_idx_14] = reg_map0__tmp_attr0[ITEM];
}
}
__global__ void main_17(size_t COUNT14, DBI64Type* MAT16map0__tmp_attr0, DBDecimalType* MAT16map2__tmp_attr5, uint64_t* MAT_IDX16, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* aggr0__tmp_attr4, DBI64Type* map0__tmp_attr0) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize buffers
DBI64Type reg_map0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT14); ++ITEM) {
reg_map0__tmp_attr0[ITEM] = map0__tmp_attr0[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr4[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT14); ++ITEM) {
reg_aggr0__tmp_attr4[ITEM] = aggr0__tmp_attr4[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT14); ++ITEM) {
reg_aggr0__tmp_attr2[ITEM] = aggr0__tmp_attr2[ITEM*TB + tid];
}
DBDecimalType reg_map2__tmp_attr5[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT14); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map2__tmp_attr5[ITEM] = (reg_aggr0__tmp_attr2[ITEM]) / (reg_aggr0__tmp_attr4[ITEM]);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT14); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx16 = atomicAdd((int*)MAT_IDX16, 1);
MAT16map0__tmp_attr0[mat_idx16] = reg_map0__tmp_attr0[ITEM];
MAT16map2__tmp_attr5[mat_idx16] = reg_map2__tmp_attr5[ITEM];
}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
size_t COUNT0 = part_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_0;
cudaMalloc(&d_BUF_IDX_0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_0, 0, sizeof(uint64_t));
uint64_t* d_BUF_0;
cudaMalloc(&d_BUF_0, sizeof(uint64_t) * COUNT0 * 1);
auto d_HT_0 = cuco::static_map{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)part_size/(float)TILE_SIZE), TB>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_part__p_partkey, d_part__p_type, part_size);
size_t COUNT2 = region_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_2;
cudaMalloc(&d_BUF_IDX_2, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_2, 0, sizeof(uint64_t));
uint64_t* d_BUF_2;
cudaMalloc(&d_BUF_2, sizeof(uint64_t) * COUNT2 * 1);
auto d_HT_2 = cuco::static_map{ (int)COUNT2*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)region_size/(float)TILE_SIZE), TB>>>(d_BUF_2, d_BUF_IDX_2, d_HT_2.ref(cuco::insert), d_region__r_name, d_region__r_regionkey, region_size);
size_t COUNT4 = orders_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_4;
cudaMalloc(&d_BUF_IDX_4, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_4, 0, sizeof(uint64_t));
uint64_t* d_BUF_4;
cudaMalloc(&d_BUF_4, sizeof(uint64_t) * COUNT4 * 1);
auto d_HT_4 = cuco::static_map{ (int)COUNT4*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)orders_size/(float)TILE_SIZE), TB>>>(d_BUF_4, d_BUF_IDX_4, d_HT_4.ref(cuco::insert), d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
size_t COUNT6 = customer_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_6;
cudaMalloc(&d_BUF_IDX_6, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6, 0, sizeof(uint64_t));
uint64_t* d_BUF_6;
cudaMalloc(&d_BUF_6, sizeof(uint64_t) * COUNT6 * 1);
auto d_HT_6 = cuco::static_map{ (int)COUNT6*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_7<<<std::ceil((float)customer_size/(float)TILE_SIZE), TB>>>(d_BUF_6, d_BUF_IDX_6, d_HT_6.ref(cuco::insert), d_customer__c_custkey, customer_size);
size_t COUNT8 = nation_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_8;
cudaMalloc(&d_BUF_IDX_8, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_8, 0, sizeof(uint64_t));
uint64_t* d_BUF_8;
cudaMalloc(&d_BUF_8, sizeof(uint64_t) * COUNT8 * 2);
auto d_HT_8 = cuco::static_map{ (int)COUNT8*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_9<<<std::ceil((float)nation_size/(float)TILE_SIZE), TB>>>(d_BUF_2, d_BUF_8, d_BUF_IDX_8, d_HT_2.ref(cuco::find), d_HT_8.ref(cuco::insert), d_nation__n_nationkey, d_nation__n_regionkey, nation_size);
size_t COUNT10 = supplier_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_10;
cudaMalloc(&d_BUF_IDX_10, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_10, 0, sizeof(uint64_t));
uint64_t* d_BUF_10;
cudaMalloc(&d_BUF_10, sizeof(uint64_t) * COUNT10 * 1);
auto d_HT_10 = cuco::static_map{ (int)COUNT10*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_11<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TB>>>(d_BUF_10, d_BUF_IDX_10, d_HT_10.ref(cuco::insert), d_supplier__s_suppkey, supplier_size);
size_t COUNT12 = nation_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_12;
cudaMalloc(&d_BUF_IDX_12, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_12, 0, sizeof(uint64_t));
uint64_t* d_BUF_12;
cudaMalloc(&d_BUF_12, sizeof(uint64_t) * COUNT12 * 1);
auto d_HT_12 = cuco::static_map{ (int)COUNT12*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_13<<<std::ceil((float)nation_size/(float)TILE_SIZE), TB>>>(d_BUF_12, d_BUF_IDX_12, d_HT_12.ref(cuco::insert), d_nation__n_nationkey, nation_size);
size_t COUNT14 = 37872;
auto d_HT_14 = cuco::static_map{ (int)37872*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_14;
cudaMalloc(&d_SLOT_COUNT_14, sizeof(int));
cudaMemset(d_SLOT_COUNT_14, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr4;
cudaMalloc(&d_aggr0__tmp_attr4, sizeof(DBDecimalType) * COUNT14);
cudaMemset(d_aggr0__tmp_attr4, 0, sizeof(DBDecimalType) * COUNT14);
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT14);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT14);
DBI64Type* d_KEY_14map0__tmp_attr0;
cudaMalloc(&d_KEY_14map0__tmp_attr0, sizeof(DBI64Type) * COUNT14);
cudaMemset(d_KEY_14map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT14);
main_15<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TB>>>(d_BUF_0, d_BUF_10, d_BUF_12, d_BUF_4, d_BUF_6, d_BUF_8, d_HT_0.ref(cuco::find), d_HT_10.ref(cuco::find), d_HT_12.ref(cuco::find), d_HT_14.ref(cuco::insert_and_find), d_HT_4.ref(cuco::find), d_HT_6.ref(cuco::find), d_HT_8.ref(cuco::find), d_KEY_14map0__tmp_attr0, d_SLOT_COUNT_14, d_aggr0__tmp_attr2, d_aggr0__tmp_attr4, d_customer__c_nationkey, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_partkey, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_orders__o_custkey, d_orders__o_orderdate, d_supplier__s_nationkey);
COUNT14 = d_HT_14.size();
size_t COUNT16 = COUNT14;
//Materialize buffers
uint64_t* d_MAT_IDX16;
cudaMalloc(&d_MAT_IDX16, sizeof(uint64_t));
cudaMemset(d_MAT_IDX16, 0, sizeof(uint64_t));
auto MAT16map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT16);
DBI64Type* d_MAT16map0__tmp_attr0;
cudaMalloc(&d_MAT16map0__tmp_attr0, sizeof(DBI64Type) * COUNT16);
auto MAT16map2__tmp_attr5 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT16);
DBDecimalType* d_MAT16map2__tmp_attr5;
cudaMalloc(&d_MAT16map2__tmp_attr5, sizeof(DBDecimalType) * COUNT16);
main_17<<<std::ceil((float)COUNT14/(float)TILE_SIZE), TB>>>(COUNT14, d_MAT16map0__tmp_attr0, d_MAT16map2__tmp_attr5, d_MAT_IDX16, d_aggr0__tmp_attr2, d_aggr0__tmp_attr4, d_KEY_14map0__tmp_attr0);
uint64_t MATCOUNT_16 = 0;
cudaMemcpy(&MATCOUNT_16, d_MAT_IDX16, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT16map0__tmp_attr0, d_MAT16map0__tmp_attr0, sizeof(DBI64Type) * COUNT16, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT16map2__tmp_attr5, d_MAT16map2__tmp_attr5, sizeof(DBDecimalType) * COUNT16, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
std::clog << "Query execution time: " << duration.count() / 1000. << " milliseconds." << std::endl;

for (auto i=0ull; i < MATCOUNT_16; i++) { std::cout << "" << MAT16map0__tmp_attr0[i];
std::cout << "|" << MAT16map2__tmp_attr5[i];
std::cout << std::endl; }
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_0);
cudaFree(d_BUF_IDX_0);
cudaFree(d_BUF_2);
cudaFree(d_BUF_IDX_2);
cudaFree(d_BUF_4);
cudaFree(d_BUF_IDX_4);
cudaFree(d_BUF_6);
cudaFree(d_BUF_IDX_6);
cudaFree(d_BUF_8);
cudaFree(d_BUF_IDX_8);
cudaFree(d_BUF_10);
cudaFree(d_BUF_IDX_10);
cudaFree(d_BUF_12);
cudaFree(d_BUF_IDX_12);
cudaFree(d_KEY_14map0__tmp_attr0);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_aggr0__tmp_attr4);
cudaFree(d_MAT16map0__tmp_attr0);
cudaFree(d_MAT16map2__tmp_attr5);
cudaFree(d_MAT_IDX16);
free(MAT16map0__tmp_attr0);
free(MAT16map2__tmp_attr5);
}