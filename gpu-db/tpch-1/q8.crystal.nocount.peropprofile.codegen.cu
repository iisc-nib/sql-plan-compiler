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
__global__ void main_1(uint64_t* BUF_2, uint64_t* BUF_IDX_2, HASHTABLE_INSERT HT_2, int64_t* cycles_per_warp_main_1_join_build_2, int64_t* cycles_per_warp_main_1_selection_0, DBI32Type* part__p_partkey, DBStringType* part__p_type, size_t part_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_2[ITEMS_PER_THREAD];
DBI32Type reg_part__p_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_partkey[ITEM] = part__p_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_2[ITEM] = 0;
KEY_2[ITEM] |= reg_part__p_partkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_2.insert(cuco::pair{KEY_2[ITEM], ITEM*TB + tid});
BUF_2[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_build_2[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_5(uint64_t* BUF_6, uint64_t* BUF_IDX_6, HASHTABLE_INSERT HT_6, int64_t* cycles_per_warp_main_5_join_build_6, int64_t* cycles_per_warp_main_5_selection_4, DBStringType* region__r_name, DBI32Type* region__r_regionkey, size_t region_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_region__r_regionkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
reg_region__r_regionkey[ITEM] = region__r_regionkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_region__r_regionkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_6.insert(cuco::pair{KEY_6[ITEM], ITEM*TB + tid});
BUF_6[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_join_build_6[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_9(uint64_t* BUF_10, uint64_t* BUF_IDX_10, HASHTABLE_INSERT HT_10, int64_t* cycles_per_warp_main_9_join_build_10, int64_t* cycles_per_warp_main_9_selection_8, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_9_selection_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_10[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_10[ITEM] = 0;
KEY_10[ITEM] |= reg_orders__o_orderkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_10.insert(cuco::pair{KEY_10[ITEM], ITEM*TB + tid});
BUF_10[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_9_join_build_10[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_12(uint64_t* BUF_11, uint64_t* BUF_IDX_11, HASHTABLE_INSERT HT_11, DBI32Type* customer__c_custkey, size_t customer_size, int64_t* cycles_per_warp_main_12_join_build_11) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_11[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_11[ITEM] = 0;
KEY_11[ITEM] |= reg_customer__c_custkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_11.insert(cuco::pair{KEY_11[ITEM], ITEM*TB + tid});
BUF_11[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_12_join_build_11[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_7(uint64_t* BUF_13, uint64_t* BUF_6, uint64_t* BUF_IDX_13, HASHTABLE_INSERT HT_13, HASHTABLE_PROBE HT_6, int64_t* cycles_per_warp_main_7_join_build_13, int64_t* cycles_per_warp_main_7_join_probe_6, DBI32Type* n1___n_nationkey, DBI32Type* n1___n_regionkey, size_t nation_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_n1___n_regionkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_n1___n_regionkey[ITEM] = n1___n_regionkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_n1___n_regionkey[ITEM];
}
//Probe Hash table
int64_t slot_second6[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_6 = HT_6.find(KEY_6[ITEM]);
if (SLOT_6 == HT_6.end()) {selection_flags[ITEM] = 0; continue;}
slot_second6[ITEM] = SLOT_6->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_probe_6[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_13[ITEMS_PER_THREAD];
DBI32Type reg_n1___n_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_n1___n_nationkey[ITEM] = n1___n_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_13[ITEM] = 0;
KEY_13[ITEM] |= reg_n1___n_nationkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_13.insert(cuco::pair{KEY_13[ITEM], ITEM*TB + tid});
BUF_13[(ITEM*TB + tid) * 2 + 0] = BUF_6[slot_second6[ITEM] * 1 + 0];
BUF_13[(ITEM*TB + tid) * 2 + 1] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_build_13[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_15(uint64_t* BUF_14, uint64_t* BUF_IDX_14, HASHTABLE_INSERT HT_14, int64_t* cycles_per_warp_main_15_join_build_14, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_14[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_14[ITEM] = 0;
KEY_14[ITEM] |= reg_supplier__s_suppkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_14.insert(cuco::pair{KEY_14[ITEM], ITEM*TB + tid});
BUF_14[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_15_join_build_14[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_17(uint64_t* BUF_16, uint64_t* BUF_IDX_16, HASHTABLE_INSERT HT_16, int64_t* cycles_per_warp_main_17_join_build_16, DBI32Type* n2___n_nationkey, size_t nation_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_16[ITEMS_PER_THREAD];
DBI32Type reg_n2___n_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_n2___n_nationkey[ITEM] = n2___n_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_16[ITEM] = 0;
KEY_16[ITEM] |= reg_n2___n_nationkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_16.insert(cuco::pair{KEY_16[ITEM], ITEM*TB + tid});
BUF_16[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_join_build_16[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_3(uint64_t* BUF_10, uint64_t* BUF_11, uint64_t* BUF_13, uint64_t* BUF_14, uint64_t* BUF_16, uint64_t* BUF_2, HASHTABLE_PROBE HT_10, HASHTABLE_PROBE HT_11, HASHTABLE_PROBE HT_13, HASHTABLE_PROBE HT_14, HASHTABLE_PROBE HT_16, HASHTABLE_PROBE HT_2, HASHTABLE_FIND HT_21, DBI64Type* KEY_21map0__tmp_attr0, int* SLOT_COUNT_21, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* aggr0__tmp_attr4, DBI32Type* customer__c_nationkey, int64_t* cycles_per_warp_main_3_aggregation_21, int64_t* cycles_per_warp_main_3_join_probe_10, int64_t* cycles_per_warp_main_3_join_probe_11, int64_t* cycles_per_warp_main_3_join_probe_13, int64_t* cycles_per_warp_main_3_join_probe_14, int64_t* cycles_per_warp_main_3_join_probe_16, int64_t* cycles_per_warp_main_3_join_probe_2, int64_t* cycles_per_warp_main_3_map_18, int64_t* cycles_per_warp_main_3_map_19, int64_t* cycles_per_warp_main_3_map_20, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_partkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n2___n_name, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, DBI32Type* supplier__s_nationkey) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_2[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_partkey[ITEM] = lineitem__l_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_2[ITEM] = 0;
KEY_2[ITEM] |= reg_lineitem__l_partkey[ITEM];
}
//Probe Hash table
int64_t slot_second2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_2 = HT_2.find(KEY_2[ITEM]);
if (SLOT_2 == HT_2.end()) {selection_flags[ITEM] = 0; continue;}
slot_second2[ITEM] = SLOT_2->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_probe_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_10[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_10[ITEM] = 0;
KEY_10[ITEM] |= reg_lineitem__l_orderkey[ITEM];
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_probe_10[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_11[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_custkey[ITEM] = orders__o_custkey[BUF_10[slot_second10[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_11[ITEM] = 0;
KEY_11[ITEM] |= reg_orders__o_custkey[ITEM];
}
//Probe Hash table
int64_t slot_second11[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_11 = HT_11.find(KEY_11[ITEM]);
if (SLOT_11 == HT_11.end()) {selection_flags[ITEM] = 0; continue;}
slot_second11[ITEM] = SLOT_11->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_probe_11[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_13[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_nationkey[ITEM] = customer__c_nationkey[BUF_11[slot_second11[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_13[ITEM] = 0;
KEY_13[ITEM] |= reg_customer__c_nationkey[ITEM];
}
//Probe Hash table
int64_t slot_second13[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_13 = HT_13.find(KEY_13[ITEM]);
if (SLOT_13 == HT_13.end()) {selection_flags[ITEM] = 0; continue;}
slot_second13[ITEM] = SLOT_13->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_probe_13[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_14[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_suppkey[ITEM] = lineitem__l_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_14[ITEM] = 0;
KEY_14[ITEM] |= reg_lineitem__l_suppkey[ITEM];
}
//Probe Hash table
int64_t slot_second14[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_14 = HT_14.find(KEY_14[ITEM]);
if (SLOT_14 == HT_14.end()) {selection_flags[ITEM] = 0; continue;}
slot_second14[ITEM] = SLOT_14->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_probe_14[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_16[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_supplier__s_nationkey[ITEM] = supplier__s_nationkey[BUF_14[slot_second14[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_16[ITEM] = 0;
KEY_16[ITEM] |= reg_supplier__s_nationkey[ITEM];
}
//Probe Hash table
int64_t slot_second16[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_16 = HT_16.find(KEY_16[ITEM]);
if (SLOT_16 == HT_16.end()) {selection_flags[ITEM] = 0; continue;}
slot_second16[ITEM] = SLOT_16->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_probe_16[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_map_18[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
DBDateType reg_orders__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_orderdate[ITEM] = orders__o_orderdate[BUF_10[slot_second10[ITEM] * 1 + 0]];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_map_19[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_map_20[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_21[ITEMS_PER_THREAD];
DBI64Type reg_map0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr0[ITEM] = ExtractFromDate("year", reg_orders__o_orderdate[ITEM]);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_21[ITEM] = 0;
KEY_21[ITEM] |= (DBI32Type)reg_map0__tmp_attr0[ITEM];
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
reg_n2___n_name[ITEM] = n2___n_name[BUF_16[slot_second16[ITEM] * 1 + 0]];
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
auto buf_idx_21 = get_aggregation_slot(KEY_21[ITEM], HT_21, SLOT_COUNT_21);
aggregate_sum(&aggr0__tmp_attr4[buf_idx_21], reg_map0__tmp_attr1[ITEM]);
aggregate_sum(&aggr0__tmp_attr2[buf_idx_21], reg_map1__tmp_attr3[ITEM]);
KEY_21map0__tmp_attr0[buf_idx_21] = reg_map0__tmp_attr0[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_aggregation_21[blockIdx.x] = cycles_per_warp;}
}
__global__ void main_23(size_t COUNT21, DBI64Type* MAT24map0__tmp_attr0, DBDecimalType* MAT24map2__tmp_attr5, uint64_t* MAT_IDX24, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* aggr0__tmp_attr4, int64_t* cycles_per_warp_main_23_map_22, int64_t* cycles_per_warp_main_23_materialize_24, DBI64Type* map0__tmp_attr0) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_23_map_22[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI64Type reg_map0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT21); ++ITEM) {
reg_map0__tmp_attr0[ITEM] = map0__tmp_attr0[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr4[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT21); ++ITEM) {
reg_aggr0__tmp_attr4[ITEM] = aggr0__tmp_attr4[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT21); ++ITEM) {
reg_aggr0__tmp_attr2[ITEM] = aggr0__tmp_attr2[ITEM*TB + tid];
}
DBDecimalType reg_map2__tmp_attr5[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT21); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map2__tmp_attr5[ITEM] = (reg_aggr0__tmp_attr2[ITEM]) / (reg_aggr0__tmp_attr4[ITEM]);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT21); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx24 = atomicAdd((int*)MAT_IDX24, 1);
MAT24map0__tmp_attr0[mat_idx24] = reg_map0__tmp_attr0[ITEM];
MAT24map2__tmp_attr5[mat_idx24] = reg_map2__tmp_attr5[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_23_materialize_24[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_build_2;
auto main_1_join_build_2_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_build_2, sizeof(int64_t) * main_1_join_build_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_build_2, -1, sizeof(int64_t) * main_1_join_build_2_cpw_size);
size_t COUNT2 = part_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_2;
cudaMalloc(&d_BUF_IDX_2, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_2, 0, sizeof(uint64_t));
uint64_t* d_BUF_2;
cudaMalloc(&d_BUF_2, sizeof(uint64_t) * COUNT2 * 1);
auto d_HT_2 = cuco::static_map{ (int)COUNT2*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)part_size/(float)TILE_SIZE), TB>>>(d_BUF_2, d_BUF_IDX_2, d_HT_2.ref(cuco::insert), d_cycles_per_warp_main_1_join_build_2, d_cycles_per_warp_main_1_selection_0, d_part__p_partkey, d_part__p_type, part_size);
int64_t* cycles_per_warp_main_1_selection_0 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_0 ";
for (auto i=0ull; i < main_1_selection_0_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_0[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_build_2 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_build_2_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_build_2, d_cycles_per_warp_main_1_join_build_2, sizeof(int64_t) * main_1_join_build_2_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_build_2 ";
for (auto i=0ull; i < main_1_join_build_2_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_build_2[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_5_selection_4;
auto main_5_selection_4_cpw_size = std::ceil((float)region_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_4, sizeof(int64_t) * main_5_selection_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_4, -1, sizeof(int64_t) * main_5_selection_4_cpw_size);
int64_t* d_cycles_per_warp_main_5_join_build_6;
auto main_5_join_build_6_cpw_size = std::ceil((float)region_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_join_build_6, sizeof(int64_t) * main_5_join_build_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_join_build_6, -1, sizeof(int64_t) * main_5_join_build_6_cpw_size);
size_t COUNT6 = region_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_6;
cudaMalloc(&d_BUF_IDX_6, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6, 0, sizeof(uint64_t));
uint64_t* d_BUF_6;
cudaMalloc(&d_BUF_6, sizeof(uint64_t) * COUNT6 * 1);
auto d_HT_6 = cuco::static_map{ (int)COUNT6*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)region_size/(float)TILE_SIZE), TB>>>(d_BUF_6, d_BUF_IDX_6, d_HT_6.ref(cuco::insert), d_cycles_per_warp_main_5_join_build_6, d_cycles_per_warp_main_5_selection_4, d_region__r_name, d_region__r_regionkey, region_size);
int64_t* cycles_per_warp_main_5_selection_4 = (int64_t*)malloc(sizeof(int64_t) * main_5_selection_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_selection_4, d_cycles_per_warp_main_5_selection_4, sizeof(int64_t) * main_5_selection_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_selection_4 ";
for (auto i=0ull; i < main_5_selection_4_cpw_size; i++) std::cout << cycles_per_warp_main_5_selection_4[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_join_build_6 = (int64_t*)malloc(sizeof(int64_t) * main_5_join_build_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_join_build_6, d_cycles_per_warp_main_5_join_build_6, sizeof(int64_t) * main_5_join_build_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_join_build_6 ";
for (auto i=0ull; i < main_5_join_build_6_cpw_size; i++) std::cout << cycles_per_warp_main_5_join_build_6[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_9_selection_8;
auto main_9_selection_8_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_9_selection_8, sizeof(int64_t) * main_9_selection_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_9_selection_8, -1, sizeof(int64_t) * main_9_selection_8_cpw_size);
int64_t* d_cycles_per_warp_main_9_join_build_10;
auto main_9_join_build_10_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_9_join_build_10, sizeof(int64_t) * main_9_join_build_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_9_join_build_10, -1, sizeof(int64_t) * main_9_join_build_10_cpw_size);
size_t COUNT10 = orders_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_10;
cudaMalloc(&d_BUF_IDX_10, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_10, 0, sizeof(uint64_t));
uint64_t* d_BUF_10;
cudaMalloc(&d_BUF_10, sizeof(uint64_t) * COUNT10 * 1);
auto d_HT_10 = cuco::static_map{ (int)COUNT10*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_9<<<std::ceil((float)orders_size/(float)TILE_SIZE), TB>>>(d_BUF_10, d_BUF_IDX_10, d_HT_10.ref(cuco::insert), d_cycles_per_warp_main_9_join_build_10, d_cycles_per_warp_main_9_selection_8, d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
int64_t* cycles_per_warp_main_9_selection_8 = (int64_t*)malloc(sizeof(int64_t) * main_9_selection_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_9_selection_8, d_cycles_per_warp_main_9_selection_8, sizeof(int64_t) * main_9_selection_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_9_selection_8 ";
for (auto i=0ull; i < main_9_selection_8_cpw_size; i++) std::cout << cycles_per_warp_main_9_selection_8[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_9_join_build_10 = (int64_t*)malloc(sizeof(int64_t) * main_9_join_build_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_9_join_build_10, d_cycles_per_warp_main_9_join_build_10, sizeof(int64_t) * main_9_join_build_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_9_join_build_10 ";
for (auto i=0ull; i < main_9_join_build_10_cpw_size; i++) std::cout << cycles_per_warp_main_9_join_build_10[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_12_join_build_11;
auto main_12_join_build_11_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_12_join_build_11, sizeof(int64_t) * main_12_join_build_11_cpw_size);
cudaMemset(d_cycles_per_warp_main_12_join_build_11, -1, sizeof(int64_t) * main_12_join_build_11_cpw_size);
size_t COUNT11 = customer_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_11;
cudaMalloc(&d_BUF_IDX_11, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_11, 0, sizeof(uint64_t));
uint64_t* d_BUF_11;
cudaMalloc(&d_BUF_11, sizeof(uint64_t) * COUNT11 * 1);
auto d_HT_11 = cuco::static_map{ (int)COUNT11*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_12<<<std::ceil((float)customer_size/(float)TILE_SIZE), TB>>>(d_BUF_11, d_BUF_IDX_11, d_HT_11.ref(cuco::insert), d_customer__c_custkey, customer_size, d_cycles_per_warp_main_12_join_build_11);
int64_t* cycles_per_warp_main_12_join_build_11 = (int64_t*)malloc(sizeof(int64_t) * main_12_join_build_11_cpw_size);
cudaMemcpy(cycles_per_warp_main_12_join_build_11, d_cycles_per_warp_main_12_join_build_11, sizeof(int64_t) * main_12_join_build_11_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_12_join_build_11 ";
for (auto i=0ull; i < main_12_join_build_11_cpw_size; i++) std::cout << cycles_per_warp_main_12_join_build_11[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_7_join_probe_6;
auto main_7_join_probe_6_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_probe_6, sizeof(int64_t) * main_7_join_probe_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_probe_6, -1, sizeof(int64_t) * main_7_join_probe_6_cpw_size);
int64_t* d_cycles_per_warp_main_7_join_build_13;
auto main_7_join_build_13_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_build_13, sizeof(int64_t) * main_7_join_build_13_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_build_13, -1, sizeof(int64_t) * main_7_join_build_13_cpw_size);
size_t COUNT13 = nation_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_13;
cudaMalloc(&d_BUF_IDX_13, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_13, 0, sizeof(uint64_t));
uint64_t* d_BUF_13;
cudaMalloc(&d_BUF_13, sizeof(uint64_t) * COUNT13 * 2);
auto d_HT_13 = cuco::static_map{ (int)COUNT13*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_7<<<std::ceil((float)nation_size/(float)TILE_SIZE), TB>>>(d_BUF_13, d_BUF_6, d_BUF_IDX_13, d_HT_13.ref(cuco::insert), d_HT_6.ref(cuco::find), d_cycles_per_warp_main_7_join_build_13, d_cycles_per_warp_main_7_join_probe_6, d_nation__n_nationkey, d_nation__n_regionkey, nation_size);
int64_t* cycles_per_warp_main_7_join_probe_6 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_probe_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_probe_6, d_cycles_per_warp_main_7_join_probe_6, sizeof(int64_t) * main_7_join_probe_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_probe_6 ";
for (auto i=0ull; i < main_7_join_probe_6_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_probe_6[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_join_build_13 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_build_13_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_build_13, d_cycles_per_warp_main_7_join_build_13, sizeof(int64_t) * main_7_join_build_13_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_build_13 ";
for (auto i=0ull; i < main_7_join_build_13_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_build_13[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_15_join_build_14;
auto main_15_join_build_14_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_15_join_build_14, sizeof(int64_t) * main_15_join_build_14_cpw_size);
cudaMemset(d_cycles_per_warp_main_15_join_build_14, -1, sizeof(int64_t) * main_15_join_build_14_cpw_size);
size_t COUNT14 = supplier_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_14;
cudaMalloc(&d_BUF_IDX_14, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_14, 0, sizeof(uint64_t));
uint64_t* d_BUF_14;
cudaMalloc(&d_BUF_14, sizeof(uint64_t) * COUNT14 * 1);
auto d_HT_14 = cuco::static_map{ (int)COUNT14*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_15<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TB>>>(d_BUF_14, d_BUF_IDX_14, d_HT_14.ref(cuco::insert), d_cycles_per_warp_main_15_join_build_14, d_supplier__s_suppkey, supplier_size);
int64_t* cycles_per_warp_main_15_join_build_14 = (int64_t*)malloc(sizeof(int64_t) * main_15_join_build_14_cpw_size);
cudaMemcpy(cycles_per_warp_main_15_join_build_14, d_cycles_per_warp_main_15_join_build_14, sizeof(int64_t) * main_15_join_build_14_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_15_join_build_14 ";
for (auto i=0ull; i < main_15_join_build_14_cpw_size; i++) std::cout << cycles_per_warp_main_15_join_build_14[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_17_join_build_16;
auto main_17_join_build_16_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_join_build_16, sizeof(int64_t) * main_17_join_build_16_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_join_build_16, -1, sizeof(int64_t) * main_17_join_build_16_cpw_size);
size_t COUNT16 = nation_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_16;
cudaMalloc(&d_BUF_IDX_16, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_16, 0, sizeof(uint64_t));
uint64_t* d_BUF_16;
cudaMalloc(&d_BUF_16, sizeof(uint64_t) * COUNT16 * 1);
auto d_HT_16 = cuco::static_map{ (int)COUNT16*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_17<<<std::ceil((float)nation_size/(float)TILE_SIZE), TB>>>(d_BUF_16, d_BUF_IDX_16, d_HT_16.ref(cuco::insert), d_cycles_per_warp_main_17_join_build_16, d_nation__n_nationkey, nation_size);
int64_t* cycles_per_warp_main_17_join_build_16 = (int64_t*)malloc(sizeof(int64_t) * main_17_join_build_16_cpw_size);
cudaMemcpy(cycles_per_warp_main_17_join_build_16, d_cycles_per_warp_main_17_join_build_16, sizeof(int64_t) * main_17_join_build_16_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_17_join_build_16 ";
for (auto i=0ull; i < main_17_join_build_16_cpw_size; i++) std::cout << cycles_per_warp_main_17_join_build_16[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_3_join_probe_2;
auto main_3_join_probe_2_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_probe_2, sizeof(int64_t) * main_3_join_probe_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_probe_2, -1, sizeof(int64_t) * main_3_join_probe_2_cpw_size);
int64_t* d_cycles_per_warp_main_3_join_probe_10;
auto main_3_join_probe_10_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_probe_10, sizeof(int64_t) * main_3_join_probe_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_probe_10, -1, sizeof(int64_t) * main_3_join_probe_10_cpw_size);
int64_t* d_cycles_per_warp_main_3_join_probe_11;
auto main_3_join_probe_11_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_probe_11, sizeof(int64_t) * main_3_join_probe_11_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_probe_11, -1, sizeof(int64_t) * main_3_join_probe_11_cpw_size);
int64_t* d_cycles_per_warp_main_3_join_probe_13;
auto main_3_join_probe_13_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_probe_13, sizeof(int64_t) * main_3_join_probe_13_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_probe_13, -1, sizeof(int64_t) * main_3_join_probe_13_cpw_size);
int64_t* d_cycles_per_warp_main_3_join_probe_14;
auto main_3_join_probe_14_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_probe_14, sizeof(int64_t) * main_3_join_probe_14_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_probe_14, -1, sizeof(int64_t) * main_3_join_probe_14_cpw_size);
int64_t* d_cycles_per_warp_main_3_join_probe_16;
auto main_3_join_probe_16_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_probe_16, sizeof(int64_t) * main_3_join_probe_16_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_probe_16, -1, sizeof(int64_t) * main_3_join_probe_16_cpw_size);
int64_t* d_cycles_per_warp_main_3_map_18;
auto main_3_map_18_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_map_18, sizeof(int64_t) * main_3_map_18_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_map_18, -1, sizeof(int64_t) * main_3_map_18_cpw_size);
int64_t* d_cycles_per_warp_main_3_map_19;
auto main_3_map_19_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_map_19, sizeof(int64_t) * main_3_map_19_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_map_19, -1, sizeof(int64_t) * main_3_map_19_cpw_size);
int64_t* d_cycles_per_warp_main_3_map_20;
auto main_3_map_20_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_map_20, sizeof(int64_t) * main_3_map_20_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_map_20, -1, sizeof(int64_t) * main_3_map_20_cpw_size);
int64_t* d_cycles_per_warp_main_3_aggregation_21;
auto main_3_aggregation_21_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_aggregation_21, sizeof(int64_t) * main_3_aggregation_21_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_aggregation_21, -1, sizeof(int64_t) * main_3_aggregation_21_cpw_size);
size_t COUNT21 = 5117;
auto d_HT_21 = cuco::static_map{ (int)5117*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_21;
cudaMalloc(&d_SLOT_COUNT_21, sizeof(int));
cudaMemset(d_SLOT_COUNT_21, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr4;
cudaMalloc(&d_aggr0__tmp_attr4, sizeof(DBDecimalType) * COUNT21);
cudaMemset(d_aggr0__tmp_attr4, 0, sizeof(DBDecimalType) * COUNT21);
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT21);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT21);
DBI64Type* d_KEY_21map0__tmp_attr0;
cudaMalloc(&d_KEY_21map0__tmp_attr0, sizeof(DBI64Type) * COUNT21);
cudaMemset(d_KEY_21map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT21);
main_3<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TB>>>(d_BUF_10, d_BUF_11, d_BUF_13, d_BUF_14, d_BUF_16, d_BUF_2, d_HT_10.ref(cuco::find), d_HT_11.ref(cuco::find), d_HT_13.ref(cuco::find), d_HT_14.ref(cuco::find), d_HT_16.ref(cuco::find), d_HT_2.ref(cuco::find), d_HT_21.ref(cuco::insert_and_find), d_KEY_21map0__tmp_attr0, d_SLOT_COUNT_21, d_aggr0__tmp_attr2, d_aggr0__tmp_attr4, d_customer__c_nationkey, d_cycles_per_warp_main_3_aggregation_21, d_cycles_per_warp_main_3_join_probe_10, d_cycles_per_warp_main_3_join_probe_11, d_cycles_per_warp_main_3_join_probe_13, d_cycles_per_warp_main_3_join_probe_14, d_cycles_per_warp_main_3_join_probe_16, d_cycles_per_warp_main_3_join_probe_2, d_cycles_per_warp_main_3_map_18, d_cycles_per_warp_main_3_map_19, d_cycles_per_warp_main_3_map_20, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_partkey, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_orders__o_custkey, d_orders__o_orderdate, d_supplier__s_nationkey);
int64_t* cycles_per_warp_main_3_join_probe_2 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_probe_2_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_probe_2, d_cycles_per_warp_main_3_join_probe_2, sizeof(int64_t) * main_3_join_probe_2_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_probe_2 ";
for (auto i=0ull; i < main_3_join_probe_2_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_probe_2[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_join_probe_10 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_probe_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_probe_10, d_cycles_per_warp_main_3_join_probe_10, sizeof(int64_t) * main_3_join_probe_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_probe_10 ";
for (auto i=0ull; i < main_3_join_probe_10_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_probe_10[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_join_probe_11 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_probe_11_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_probe_11, d_cycles_per_warp_main_3_join_probe_11, sizeof(int64_t) * main_3_join_probe_11_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_probe_11 ";
for (auto i=0ull; i < main_3_join_probe_11_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_probe_11[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_join_probe_13 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_probe_13_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_probe_13, d_cycles_per_warp_main_3_join_probe_13, sizeof(int64_t) * main_3_join_probe_13_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_probe_13 ";
for (auto i=0ull; i < main_3_join_probe_13_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_probe_13[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_join_probe_14 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_probe_14_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_probe_14, d_cycles_per_warp_main_3_join_probe_14, sizeof(int64_t) * main_3_join_probe_14_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_probe_14 ";
for (auto i=0ull; i < main_3_join_probe_14_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_probe_14[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_join_probe_16 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_probe_16_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_probe_16, d_cycles_per_warp_main_3_join_probe_16, sizeof(int64_t) * main_3_join_probe_16_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_probe_16 ";
for (auto i=0ull; i < main_3_join_probe_16_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_probe_16[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_map_18 = (int64_t*)malloc(sizeof(int64_t) * main_3_map_18_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_map_18, d_cycles_per_warp_main_3_map_18, sizeof(int64_t) * main_3_map_18_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_map_18 ";
for (auto i=0ull; i < main_3_map_18_cpw_size; i++) std::cout << cycles_per_warp_main_3_map_18[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_map_19 = (int64_t*)malloc(sizeof(int64_t) * main_3_map_19_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_map_19, d_cycles_per_warp_main_3_map_19, sizeof(int64_t) * main_3_map_19_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_map_19 ";
for (auto i=0ull; i < main_3_map_19_cpw_size; i++) std::cout << cycles_per_warp_main_3_map_19[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_map_20 = (int64_t*)malloc(sizeof(int64_t) * main_3_map_20_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_map_20, d_cycles_per_warp_main_3_map_20, sizeof(int64_t) * main_3_map_20_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_map_20 ";
for (auto i=0ull; i < main_3_map_20_cpw_size; i++) std::cout << cycles_per_warp_main_3_map_20[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_aggregation_21 = (int64_t*)malloc(sizeof(int64_t) * main_3_aggregation_21_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_aggregation_21, d_cycles_per_warp_main_3_aggregation_21, sizeof(int64_t) * main_3_aggregation_21_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_aggregation_21 ";
for (auto i=0ull; i < main_3_aggregation_21_cpw_size; i++) std::cout << cycles_per_warp_main_3_aggregation_21[i] << " ";
std::cout << std::endl;
COUNT21 = d_HT_21.size();
int64_t* d_cycles_per_warp_main_23_map_22;
auto main_23_map_22_cpw_size = std::ceil((float)COUNT21/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_23_map_22, sizeof(int64_t) * main_23_map_22_cpw_size);
cudaMemset(d_cycles_per_warp_main_23_map_22, -1, sizeof(int64_t) * main_23_map_22_cpw_size);
int64_t* d_cycles_per_warp_main_23_materialize_24;
auto main_23_materialize_24_cpw_size = std::ceil((float)COUNT21/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_23_materialize_24, sizeof(int64_t) * main_23_materialize_24_cpw_size);
cudaMemset(d_cycles_per_warp_main_23_materialize_24, -1, sizeof(int64_t) * main_23_materialize_24_cpw_size);
size_t COUNT24 = COUNT21;
//Materialize buffers
uint64_t* d_MAT_IDX24;
cudaMalloc(&d_MAT_IDX24, sizeof(uint64_t));
cudaMemset(d_MAT_IDX24, 0, sizeof(uint64_t));
auto MAT24map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT24);
DBI64Type* d_MAT24map0__tmp_attr0;
cudaMalloc(&d_MAT24map0__tmp_attr0, sizeof(DBI64Type) * COUNT24);
auto MAT24map2__tmp_attr5 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT24);
DBDecimalType* d_MAT24map2__tmp_attr5;
cudaMalloc(&d_MAT24map2__tmp_attr5, sizeof(DBDecimalType) * COUNT24);
main_23<<<std::ceil((float)COUNT21/(float)TILE_SIZE), TB>>>(COUNT21, d_MAT24map0__tmp_attr0, d_MAT24map2__tmp_attr5, d_MAT_IDX24, d_aggr0__tmp_attr2, d_aggr0__tmp_attr4, d_cycles_per_warp_main_23_map_22, d_cycles_per_warp_main_23_materialize_24, d_KEY_21map0__tmp_attr0);
uint64_t MATCOUNT_24 = 0;
cudaMemcpy(&MATCOUNT_24, d_MAT_IDX24, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT24map0__tmp_attr0, d_MAT24map0__tmp_attr0, sizeof(DBI64Type) * COUNT24, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT24map2__tmp_attr5, d_MAT24map2__tmp_attr5, sizeof(DBDecimalType) * COUNT24, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_23_map_22 = (int64_t*)malloc(sizeof(int64_t) * main_23_map_22_cpw_size);
cudaMemcpy(cycles_per_warp_main_23_map_22, d_cycles_per_warp_main_23_map_22, sizeof(int64_t) * main_23_map_22_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_23_map_22 ";
for (auto i=0ull; i < main_23_map_22_cpw_size; i++) std::cout << cycles_per_warp_main_23_map_22[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_23_materialize_24 = (int64_t*)malloc(sizeof(int64_t) * main_23_materialize_24_cpw_size);
cudaMemcpy(cycles_per_warp_main_23_materialize_24, d_cycles_per_warp_main_23_materialize_24, sizeof(int64_t) * main_23_materialize_24_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_23_materialize_24 ";
for (auto i=0ull; i < main_23_materialize_24_cpw_size; i++) std::cout << cycles_per_warp_main_23_materialize_24[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_2);
cudaFree(d_BUF_IDX_2);
cudaFree(d_BUF_6);
cudaFree(d_BUF_IDX_6);
cudaFree(d_BUF_10);
cudaFree(d_BUF_IDX_10);
cudaFree(d_BUF_11);
cudaFree(d_BUF_IDX_11);
cudaFree(d_BUF_13);
cudaFree(d_BUF_IDX_13);
cudaFree(d_BUF_14);
cudaFree(d_BUF_IDX_14);
cudaFree(d_BUF_16);
cudaFree(d_BUF_IDX_16);
cudaFree(d_KEY_21map0__tmp_attr0);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_aggr0__tmp_attr4);
cudaFree(d_MAT24map0__tmp_attr0);
cudaFree(d_MAT24map2__tmp_attr5);
cudaFree(d_MAT_IDX24);
free(MAT24map0__tmp_attr0);
free(MAT24map2__tmp_attr5);
}