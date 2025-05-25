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
__global__ void main_8(uint64_t* BUF_28, uint64_t* BUF_IDX_28, HASHTABLE_INSERT HT_28, int64_t* cycles_per_warp_main_8_join_build_28, int64_t* cycles_per_warp_main_8_selection_10, int64_t* cycles_per_warp_main_8_selection_11, int64_t* cycles_per_warp_main_8_selection_12, int64_t* cycles_per_warp_main_8_selection_7, int64_t* cycles_per_warp_main_8_selection_9, DBStringType* supplier__s_nation, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_supplier__s_nation[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_nation[ITEM] = supplier__s_nation[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_supplier__s_nation[ITEM], "UNITED STATES", Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_8_selection_7[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_8_selection_9[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_8_selection_10[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_8_selection_11[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_8_selection_12[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_28[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_28[ITEM] = 0;
KEY_28[ITEM] |= reg_supplier__s_suppkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_28.insert(cuco::pair{KEY_28[ITEM], ITEM*TB + tid});
BUF_28[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_8_join_build_28[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_14(uint64_t* BUF_29, uint64_t* BUF_IDX_29, HASHTABLE_INSERT HT_29, int64_t* cycles_per_warp_main_14_join_build_29, int64_t* cycles_per_warp_main_14_selection_13, int64_t* cycles_per_warp_main_14_selection_15, int64_t* cycles_per_warp_main_14_selection_16, int64_t* cycles_per_warp_main_14_selection_17, int64_t* cycles_per_warp_main_14_selection_18, DBStringType* part__p_category, DBI32Type* part__p_partkey, size_t part_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_part__p_category[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_category[ITEM] = part__p_category[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_part__p_category[ITEM], "MFGR#14", Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_selection_13[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_selection_15[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_selection_16[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_selection_17[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_selection_18[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_29[ITEMS_PER_THREAD];
DBI32Type reg_part__p_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_partkey[ITEM] = part__p_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_29[ITEM] = 0;
KEY_29[ITEM] |= reg_part__p_partkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_29.insert(cuco::pair{KEY_29[ITEM], ITEM*TB + tid});
BUF_29[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_join_build_29[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_30, uint64_t* BUF_IDX_30, HASHTABLE_INSERT HT_30, int64_t* cycles_per_warp_main_1_join_build_30, int64_t* cycles_per_warp_main_1_selection_0, int64_t* cycles_per_warp_main_1_selection_2, int64_t* cycles_per_warp_main_1_selection_3, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
reg_date__d_year[ITEM] = date__d_year[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_date__d_year[ITEM], 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year[ITEM], 1998, Predicate::eq));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_3[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_30[ITEMS_PER_THREAD];
DBI32Type reg_date__d_datekey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
reg_date__d_datekey[ITEM] = date__d_datekey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_30[ITEM] = 0;
KEY_30[ITEM] |= reg_date__d_datekey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_30.insert(cuco::pair{KEY_30[ITEM], ITEM*TB + tid});
BUF_30[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_build_30[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_5(uint64_t* BUF_31, uint64_t* BUF_IDX_31, HASHTABLE_INSERT HT_31, DBI32Type* customer__c_custkey, size_t customer_size, int64_t* cycles_per_warp_main_5_join_build_31, int64_t* cycles_per_warp_main_5_selection_4, int64_t* cycles_per_warp_main_5_selection_6) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_6[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_31[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_31[ITEM] = 0;
KEY_31[ITEM] |= reg_customer__c_custkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_31.insert(cuco::pair{KEY_31[ITEM], ITEM*TB + tid});
BUF_31[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_join_build_31[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_20(uint64_t* BUF_28, uint64_t* BUF_29, uint64_t* BUF_30, uint64_t* BUF_31, HASHTABLE_PROBE HT_28, HASHTABLE_PROBE HT_29, HASHTABLE_PROBE HT_30, HASHTABLE_PROBE HT_31, HASHTABLE_FIND HT_33, DBI32Type* KEY_33date__d_year, DBI16Type* KEY_33part__p_brand1_encoded, DBI16Type* KEY_33supplier__s_city_encoded, int* SLOT_COUNT_33, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_20_aggregation_33, int64_t* cycles_per_warp_main_20_join_probe_28, int64_t* cycles_per_warp_main_20_join_probe_29, int64_t* cycles_per_warp_main_20_join_probe_30, int64_t* cycles_per_warp_main_20_join_probe_31, int64_t* cycles_per_warp_main_20_map_32, int64_t* cycles_per_warp_main_20_selection_19, int64_t* cycles_per_warp_main_20_selection_21, int64_t* cycles_per_warp_main_20_selection_22, int64_t* cycles_per_warp_main_20_selection_23, int64_t* cycles_per_warp_main_20_selection_24, int64_t* cycles_per_warp_main_20_selection_25, int64_t* cycles_per_warp_main_20_selection_26, int64_t* cycles_per_warp_main_20_selection_27, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, DBDecimalType* lineorder__lo_supplycost, size_t lineorder_size, DBI16Type* part__p_brand1_encoded, DBI16Type* supplier__s_city_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_selection_19[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_selection_21[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_selection_22[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_selection_23[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_selection_24[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_selection_25[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_selection_26[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_selection_27[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_28[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_suppkey[ITEM] = lineorder__lo_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_28[ITEM] = 0;
KEY_28[ITEM] |= reg_lineorder__lo_suppkey[ITEM];
}
//Probe Hash table
int64_t slot_second28[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_28 = HT_28.find(KEY_28[ITEM]);
if (SLOT_28 == HT_28.end()) {selection_flags[ITEM] = 0; continue;}
slot_second28[ITEM] = SLOT_28->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_join_probe_28[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_29[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_partkey[ITEM] = lineorder__lo_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_29[ITEM] = 0;
KEY_29[ITEM] |= reg_lineorder__lo_partkey[ITEM];
}
//Probe Hash table
int64_t slot_second29[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_29 = HT_29.find(KEY_29[ITEM]);
if (SLOT_29 == HT_29.end()) {selection_flags[ITEM] = 0; continue;}
slot_second29[ITEM] = SLOT_29->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_join_probe_29[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_30[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_orderdate[ITEM] = lineorder__lo_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_30[ITEM] = 0;
KEY_30[ITEM] |= reg_lineorder__lo_orderdate[ITEM];
}
//Probe Hash table
int64_t slot_second30[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_30 = HT_30.find(KEY_30[ITEM]);
if (SLOT_30 == HT_30.end()) {selection_flags[ITEM] = 0; continue;}
slot_second30[ITEM] = SLOT_30->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_join_probe_30[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_31[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_custkey[ITEM] = lineorder__lo_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_31[ITEM] = 0;
KEY_31[ITEM] |= reg_lineorder__lo_custkey[ITEM];
}
//Probe Hash table
int64_t slot_second31[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_31 = HT_31.find(KEY_31[ITEM]);
if (SLOT_31 == HT_31.end()) {selection_flags[ITEM] = 0; continue;}
slot_second31[ITEM] = SLOT_31->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_join_probe_31[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_map_32[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_33[ITEMS_PER_THREAD];
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_date__d_year[ITEM] = date__d_year[BUF_30[slot_second30[ITEM] * 1 + 0]];
}
DBI16Type reg_supplier__s_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_supplier__s_city_encoded[ITEM] = supplier__s_city_encoded[BUF_28[slot_second28[ITEM] * 1 + 0]];
}
DBI16Type reg_part__p_brand1_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_brand1_encoded[ITEM] = part__p_brand1_encoded[BUF_29[slot_second29[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_33[ITEM] = 0;
KEY_33[ITEM] |= reg_date__d_year[ITEM];
KEY_33[ITEM] <<= 16;
KEY_33[ITEM] |= reg_supplier__s_city_encoded[ITEM];
KEY_33[ITEM] <<= 16;
KEY_33[ITEM] |= reg_part__p_brand1_encoded[ITEM];
}
//Aggregate in hashtable
DBDecimalType reg_lineorder__lo_supplycost[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_supplycost[ITEM] = lineorder__lo_supplycost[ITEM*TB + tid];
}
DBDecimalType reg_lineorder__lo_revenue[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_revenue[ITEM] = lineorder__lo_revenue[ITEM*TB + tid];
}
DBDecimalType reg_map0__tmp_attr1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr1[ITEM] = (reg_lineorder__lo_revenue[ITEM]) - (reg_lineorder__lo_supplycost[ITEM]);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_33 = get_aggregation_slot(KEY_33[ITEM], HT_33, SLOT_COUNT_33);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_33], reg_map0__tmp_attr1[ITEM]);
KEY_33date__d_year[buf_idx_33] = reg_date__d_year[ITEM];
KEY_33supplier__s_city_encoded[buf_idx_33] = reg_supplier__s_city_encoded[ITEM];
KEY_33part__p_brand1_encoded[buf_idx_33] = reg_part__p_brand1_encoded[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_20_aggregation_33[blockIdx.x] = cycles_per_warp;}
}
__global__ void main_35(size_t COUNT33, DBDecimalType* MAT34aggr0__tmp_attr0, DBI32Type* MAT34date__d_year, DBI16Type* MAT34part__p_brand1_encoded, DBI16Type* MAT34supplier__s_city_encoded, uint64_t* MAT_IDX34, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_35_materialize_34, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded, DBI16Type* supplier__s_city_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT33); ++ITEM) {
reg_date__d_year[ITEM] = date__d_year[ITEM*TB + tid];
}
DBI16Type reg_supplier__s_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT33); ++ITEM) {
reg_supplier__s_city_encoded[ITEM] = supplier__s_city_encoded[ITEM*TB + tid];
}
DBI16Type reg_part__p_brand1_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT33); ++ITEM) {
reg_part__p_brand1_encoded[ITEM] = part__p_brand1_encoded[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT33); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT33); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx34 = atomicAdd((int*)MAT_IDX34, 1);
MAT34date__d_year[mat_idx34] = reg_date__d_year[ITEM];
MAT34supplier__s_city_encoded[mat_idx34] = reg_supplier__s_city_encoded[ITEM];
MAT34part__p_brand1_encoded[mat_idx34] = reg_part__p_brand1_encoded[ITEM];
MAT34aggr0__tmp_attr0[mat_idx34] = reg_aggr0__tmp_attr0[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_35_materialize_34[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_8_selection_7;
auto main_8_selection_7_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_8_selection_7, sizeof(int64_t) * main_8_selection_7_cpw_size);
cudaMemset(d_cycles_per_warp_main_8_selection_7, -1, sizeof(int64_t) * main_8_selection_7_cpw_size);
int64_t* d_cycles_per_warp_main_8_selection_9;
auto main_8_selection_9_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_8_selection_9, sizeof(int64_t) * main_8_selection_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_8_selection_9, -1, sizeof(int64_t) * main_8_selection_9_cpw_size);
int64_t* d_cycles_per_warp_main_8_selection_10;
auto main_8_selection_10_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_8_selection_10, sizeof(int64_t) * main_8_selection_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_8_selection_10, -1, sizeof(int64_t) * main_8_selection_10_cpw_size);
int64_t* d_cycles_per_warp_main_8_selection_11;
auto main_8_selection_11_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_8_selection_11, sizeof(int64_t) * main_8_selection_11_cpw_size);
cudaMemset(d_cycles_per_warp_main_8_selection_11, -1, sizeof(int64_t) * main_8_selection_11_cpw_size);
int64_t* d_cycles_per_warp_main_8_selection_12;
auto main_8_selection_12_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_8_selection_12, sizeof(int64_t) * main_8_selection_12_cpw_size);
cudaMemset(d_cycles_per_warp_main_8_selection_12, -1, sizeof(int64_t) * main_8_selection_12_cpw_size);
int64_t* d_cycles_per_warp_main_8_join_build_28;
auto main_8_join_build_28_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_8_join_build_28, sizeof(int64_t) * main_8_join_build_28_cpw_size);
cudaMemset(d_cycles_per_warp_main_8_join_build_28, -1, sizeof(int64_t) * main_8_join_build_28_cpw_size);
size_t COUNT28 = supplier_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_28;
cudaMalloc(&d_BUF_IDX_28, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_28, 0, sizeof(uint64_t));
uint64_t* d_BUF_28;
cudaMalloc(&d_BUF_28, sizeof(uint64_t) * COUNT28 * 1);
auto d_HT_28 = cuco::static_map{ (int)COUNT28*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_8<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TB>>>(d_BUF_28, d_BUF_IDX_28, d_HT_28.ref(cuco::insert), d_cycles_per_warp_main_8_join_build_28, d_cycles_per_warp_main_8_selection_10, d_cycles_per_warp_main_8_selection_11, d_cycles_per_warp_main_8_selection_12, d_cycles_per_warp_main_8_selection_7, d_cycles_per_warp_main_8_selection_9, d_supplier__s_nation, d_supplier__s_suppkey, supplier_size);
int64_t* cycles_per_warp_main_8_selection_7 = (int64_t*)malloc(sizeof(int64_t) * main_8_selection_7_cpw_size);
cudaMemcpy(cycles_per_warp_main_8_selection_7, d_cycles_per_warp_main_8_selection_7, sizeof(int64_t) * main_8_selection_7_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_8_selection_7 ";
for (auto i=0ull; i < main_8_selection_7_cpw_size; i++) std::cout << cycles_per_warp_main_8_selection_7[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_8_selection_9 = (int64_t*)malloc(sizeof(int64_t) * main_8_selection_9_cpw_size);
cudaMemcpy(cycles_per_warp_main_8_selection_9, d_cycles_per_warp_main_8_selection_9, sizeof(int64_t) * main_8_selection_9_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_8_selection_9 ";
for (auto i=0ull; i < main_8_selection_9_cpw_size; i++) std::cout << cycles_per_warp_main_8_selection_9[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_8_selection_10 = (int64_t*)malloc(sizeof(int64_t) * main_8_selection_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_8_selection_10, d_cycles_per_warp_main_8_selection_10, sizeof(int64_t) * main_8_selection_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_8_selection_10 ";
for (auto i=0ull; i < main_8_selection_10_cpw_size; i++) std::cout << cycles_per_warp_main_8_selection_10[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_8_selection_11 = (int64_t*)malloc(sizeof(int64_t) * main_8_selection_11_cpw_size);
cudaMemcpy(cycles_per_warp_main_8_selection_11, d_cycles_per_warp_main_8_selection_11, sizeof(int64_t) * main_8_selection_11_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_8_selection_11 ";
for (auto i=0ull; i < main_8_selection_11_cpw_size; i++) std::cout << cycles_per_warp_main_8_selection_11[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_8_selection_12 = (int64_t*)malloc(sizeof(int64_t) * main_8_selection_12_cpw_size);
cudaMemcpy(cycles_per_warp_main_8_selection_12, d_cycles_per_warp_main_8_selection_12, sizeof(int64_t) * main_8_selection_12_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_8_selection_12 ";
for (auto i=0ull; i < main_8_selection_12_cpw_size; i++) std::cout << cycles_per_warp_main_8_selection_12[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_8_join_build_28 = (int64_t*)malloc(sizeof(int64_t) * main_8_join_build_28_cpw_size);
cudaMemcpy(cycles_per_warp_main_8_join_build_28, d_cycles_per_warp_main_8_join_build_28, sizeof(int64_t) * main_8_join_build_28_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_8_join_build_28 ";
for (auto i=0ull; i < main_8_join_build_28_cpw_size; i++) std::cout << cycles_per_warp_main_8_join_build_28[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_14_selection_13;
auto main_14_selection_13_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_selection_13, sizeof(int64_t) * main_14_selection_13_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_selection_13, -1, sizeof(int64_t) * main_14_selection_13_cpw_size);
int64_t* d_cycles_per_warp_main_14_selection_15;
auto main_14_selection_15_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_selection_15, sizeof(int64_t) * main_14_selection_15_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_selection_15, -1, sizeof(int64_t) * main_14_selection_15_cpw_size);
int64_t* d_cycles_per_warp_main_14_selection_16;
auto main_14_selection_16_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_selection_16, sizeof(int64_t) * main_14_selection_16_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_selection_16, -1, sizeof(int64_t) * main_14_selection_16_cpw_size);
int64_t* d_cycles_per_warp_main_14_selection_17;
auto main_14_selection_17_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_selection_17, sizeof(int64_t) * main_14_selection_17_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_selection_17, -1, sizeof(int64_t) * main_14_selection_17_cpw_size);
int64_t* d_cycles_per_warp_main_14_selection_18;
auto main_14_selection_18_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_selection_18, sizeof(int64_t) * main_14_selection_18_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_selection_18, -1, sizeof(int64_t) * main_14_selection_18_cpw_size);
int64_t* d_cycles_per_warp_main_14_join_build_29;
auto main_14_join_build_29_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_join_build_29, sizeof(int64_t) * main_14_join_build_29_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_join_build_29, -1, sizeof(int64_t) * main_14_join_build_29_cpw_size);
size_t COUNT29 = part_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_29;
cudaMalloc(&d_BUF_IDX_29, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_29, 0, sizeof(uint64_t));
uint64_t* d_BUF_29;
cudaMalloc(&d_BUF_29, sizeof(uint64_t) * COUNT29 * 1);
auto d_HT_29 = cuco::static_map{ (int)COUNT29*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_14<<<std::ceil((float)part_size/(float)TILE_SIZE), TB>>>(d_BUF_29, d_BUF_IDX_29, d_HT_29.ref(cuco::insert), d_cycles_per_warp_main_14_join_build_29, d_cycles_per_warp_main_14_selection_13, d_cycles_per_warp_main_14_selection_15, d_cycles_per_warp_main_14_selection_16, d_cycles_per_warp_main_14_selection_17, d_cycles_per_warp_main_14_selection_18, d_part__p_category, d_part__p_partkey, part_size);
int64_t* cycles_per_warp_main_14_selection_13 = (int64_t*)malloc(sizeof(int64_t) * main_14_selection_13_cpw_size);
cudaMemcpy(cycles_per_warp_main_14_selection_13, d_cycles_per_warp_main_14_selection_13, sizeof(int64_t) * main_14_selection_13_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_14_selection_13 ";
for (auto i=0ull; i < main_14_selection_13_cpw_size; i++) std::cout << cycles_per_warp_main_14_selection_13[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_14_selection_15 = (int64_t*)malloc(sizeof(int64_t) * main_14_selection_15_cpw_size);
cudaMemcpy(cycles_per_warp_main_14_selection_15, d_cycles_per_warp_main_14_selection_15, sizeof(int64_t) * main_14_selection_15_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_14_selection_15 ";
for (auto i=0ull; i < main_14_selection_15_cpw_size; i++) std::cout << cycles_per_warp_main_14_selection_15[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_14_selection_16 = (int64_t*)malloc(sizeof(int64_t) * main_14_selection_16_cpw_size);
cudaMemcpy(cycles_per_warp_main_14_selection_16, d_cycles_per_warp_main_14_selection_16, sizeof(int64_t) * main_14_selection_16_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_14_selection_16 ";
for (auto i=0ull; i < main_14_selection_16_cpw_size; i++) std::cout << cycles_per_warp_main_14_selection_16[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_14_selection_17 = (int64_t*)malloc(sizeof(int64_t) * main_14_selection_17_cpw_size);
cudaMemcpy(cycles_per_warp_main_14_selection_17, d_cycles_per_warp_main_14_selection_17, sizeof(int64_t) * main_14_selection_17_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_14_selection_17 ";
for (auto i=0ull; i < main_14_selection_17_cpw_size; i++) std::cout << cycles_per_warp_main_14_selection_17[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_14_selection_18 = (int64_t*)malloc(sizeof(int64_t) * main_14_selection_18_cpw_size);
cudaMemcpy(cycles_per_warp_main_14_selection_18, d_cycles_per_warp_main_14_selection_18, sizeof(int64_t) * main_14_selection_18_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_14_selection_18 ";
for (auto i=0ull; i < main_14_selection_18_cpw_size; i++) std::cout << cycles_per_warp_main_14_selection_18[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_14_join_build_29 = (int64_t*)malloc(sizeof(int64_t) * main_14_join_build_29_cpw_size);
cudaMemcpy(cycles_per_warp_main_14_join_build_29, d_cycles_per_warp_main_14_join_build_29, sizeof(int64_t) * main_14_join_build_29_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_14_join_build_29 ";
for (auto i=0ull; i < main_14_join_build_29_cpw_size; i++) std::cout << cycles_per_warp_main_14_join_build_29[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_2;
auto main_1_selection_2_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_2, sizeof(int64_t) * main_1_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_2, -1, sizeof(int64_t) * main_1_selection_2_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_3;
auto main_1_selection_3_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_3, sizeof(int64_t) * main_1_selection_3_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_3, -1, sizeof(int64_t) * main_1_selection_3_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_build_30;
auto main_1_join_build_30_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_build_30, sizeof(int64_t) * main_1_join_build_30_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_build_30, -1, sizeof(int64_t) * main_1_join_build_30_cpw_size);
size_t COUNT30 = date_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_30;
cudaMalloc(&d_BUF_IDX_30, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_30, 0, sizeof(uint64_t));
uint64_t* d_BUF_30;
cudaMalloc(&d_BUF_30, sizeof(uint64_t) * COUNT30 * 1);
auto d_HT_30 = cuco::static_map{ (int)COUNT30*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)date_size/(float)TILE_SIZE), TB>>>(d_BUF_30, d_BUF_IDX_30, d_HT_30.ref(cuco::insert), d_cycles_per_warp_main_1_join_build_30, d_cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_2, d_cycles_per_warp_main_1_selection_3, d_date__d_datekey, d_date__d_year, date_size);
int64_t* cycles_per_warp_main_1_selection_0 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_0 ";
for (auto i=0ull; i < main_1_selection_0_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_0[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_selection_2 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_2_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_2, d_cycles_per_warp_main_1_selection_2, sizeof(int64_t) * main_1_selection_2_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_2 ";
for (auto i=0ull; i < main_1_selection_2_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_2[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_selection_3 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_3_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_3, d_cycles_per_warp_main_1_selection_3, sizeof(int64_t) * main_1_selection_3_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_3 ";
for (auto i=0ull; i < main_1_selection_3_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_3[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_build_30 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_build_30_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_build_30, d_cycles_per_warp_main_1_join_build_30, sizeof(int64_t) * main_1_join_build_30_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_build_30 ";
for (auto i=0ull; i < main_1_join_build_30_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_build_30[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_5_selection_4;
auto main_5_selection_4_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_4, sizeof(int64_t) * main_5_selection_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_4, -1, sizeof(int64_t) * main_5_selection_4_cpw_size);
int64_t* d_cycles_per_warp_main_5_selection_6;
auto main_5_selection_6_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_6, sizeof(int64_t) * main_5_selection_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_6, -1, sizeof(int64_t) * main_5_selection_6_cpw_size);
int64_t* d_cycles_per_warp_main_5_join_build_31;
auto main_5_join_build_31_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_join_build_31, sizeof(int64_t) * main_5_join_build_31_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_join_build_31, -1, sizeof(int64_t) * main_5_join_build_31_cpw_size);
size_t COUNT31 = customer_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_31;
cudaMalloc(&d_BUF_IDX_31, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_31, 0, sizeof(uint64_t));
uint64_t* d_BUF_31;
cudaMalloc(&d_BUF_31, sizeof(uint64_t) * COUNT31 * 1);
auto d_HT_31 = cuco::static_map{ (int)COUNT31*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)customer_size/(float)TILE_SIZE), TB>>>(d_BUF_31, d_BUF_IDX_31, d_HT_31.ref(cuco::insert), d_customer__c_custkey, customer_size, d_cycles_per_warp_main_5_join_build_31, d_cycles_per_warp_main_5_selection_4, d_cycles_per_warp_main_5_selection_6);
int64_t* cycles_per_warp_main_5_selection_4 = (int64_t*)malloc(sizeof(int64_t) * main_5_selection_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_selection_4, d_cycles_per_warp_main_5_selection_4, sizeof(int64_t) * main_5_selection_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_selection_4 ";
for (auto i=0ull; i < main_5_selection_4_cpw_size; i++) std::cout << cycles_per_warp_main_5_selection_4[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_selection_6 = (int64_t*)malloc(sizeof(int64_t) * main_5_selection_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_selection_6, d_cycles_per_warp_main_5_selection_6, sizeof(int64_t) * main_5_selection_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_selection_6 ";
for (auto i=0ull; i < main_5_selection_6_cpw_size; i++) std::cout << cycles_per_warp_main_5_selection_6[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_join_build_31 = (int64_t*)malloc(sizeof(int64_t) * main_5_join_build_31_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_join_build_31, d_cycles_per_warp_main_5_join_build_31, sizeof(int64_t) * main_5_join_build_31_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_join_build_31 ";
for (auto i=0ull; i < main_5_join_build_31_cpw_size; i++) std::cout << cycles_per_warp_main_5_join_build_31[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_20_selection_19;
auto main_20_selection_19_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_selection_19, sizeof(int64_t) * main_20_selection_19_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_selection_19, -1, sizeof(int64_t) * main_20_selection_19_cpw_size);
int64_t* d_cycles_per_warp_main_20_selection_21;
auto main_20_selection_21_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_selection_21, sizeof(int64_t) * main_20_selection_21_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_selection_21, -1, sizeof(int64_t) * main_20_selection_21_cpw_size);
int64_t* d_cycles_per_warp_main_20_selection_22;
auto main_20_selection_22_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_selection_22, sizeof(int64_t) * main_20_selection_22_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_selection_22, -1, sizeof(int64_t) * main_20_selection_22_cpw_size);
int64_t* d_cycles_per_warp_main_20_selection_23;
auto main_20_selection_23_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_selection_23, sizeof(int64_t) * main_20_selection_23_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_selection_23, -1, sizeof(int64_t) * main_20_selection_23_cpw_size);
int64_t* d_cycles_per_warp_main_20_selection_24;
auto main_20_selection_24_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_selection_24, sizeof(int64_t) * main_20_selection_24_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_selection_24, -1, sizeof(int64_t) * main_20_selection_24_cpw_size);
int64_t* d_cycles_per_warp_main_20_selection_25;
auto main_20_selection_25_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_selection_25, sizeof(int64_t) * main_20_selection_25_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_selection_25, -1, sizeof(int64_t) * main_20_selection_25_cpw_size);
int64_t* d_cycles_per_warp_main_20_selection_26;
auto main_20_selection_26_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_selection_26, sizeof(int64_t) * main_20_selection_26_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_selection_26, -1, sizeof(int64_t) * main_20_selection_26_cpw_size);
int64_t* d_cycles_per_warp_main_20_selection_27;
auto main_20_selection_27_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_selection_27, sizeof(int64_t) * main_20_selection_27_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_selection_27, -1, sizeof(int64_t) * main_20_selection_27_cpw_size);
int64_t* d_cycles_per_warp_main_20_join_probe_28;
auto main_20_join_probe_28_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_join_probe_28, sizeof(int64_t) * main_20_join_probe_28_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_join_probe_28, -1, sizeof(int64_t) * main_20_join_probe_28_cpw_size);
int64_t* d_cycles_per_warp_main_20_join_probe_29;
auto main_20_join_probe_29_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_join_probe_29, sizeof(int64_t) * main_20_join_probe_29_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_join_probe_29, -1, sizeof(int64_t) * main_20_join_probe_29_cpw_size);
int64_t* d_cycles_per_warp_main_20_join_probe_30;
auto main_20_join_probe_30_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_join_probe_30, sizeof(int64_t) * main_20_join_probe_30_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_join_probe_30, -1, sizeof(int64_t) * main_20_join_probe_30_cpw_size);
int64_t* d_cycles_per_warp_main_20_join_probe_31;
auto main_20_join_probe_31_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_join_probe_31, sizeof(int64_t) * main_20_join_probe_31_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_join_probe_31, -1, sizeof(int64_t) * main_20_join_probe_31_cpw_size);
int64_t* d_cycles_per_warp_main_20_map_32;
auto main_20_map_32_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_map_32, sizeof(int64_t) * main_20_map_32_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_map_32, -1, sizeof(int64_t) * main_20_map_32_cpw_size);
int64_t* d_cycles_per_warp_main_20_aggregation_33;
auto main_20_aggregation_33_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_20_aggregation_33, sizeof(int64_t) * main_20_aggregation_33_cpw_size);
cudaMemset(d_cycles_per_warp_main_20_aggregation_33, -1, sizeof(int64_t) * main_20_aggregation_33_cpw_size);
size_t COUNT33 = 2259;
auto d_HT_33 = cuco::static_map{ (int)2259*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_33;
cudaMalloc(&d_SLOT_COUNT_33, sizeof(int));
cudaMemset(d_SLOT_COUNT_33, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT33);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT33);
DBI32Type* d_KEY_33date__d_year;
cudaMalloc(&d_KEY_33date__d_year, sizeof(DBI32Type) * COUNT33);
cudaMemset(d_KEY_33date__d_year, 0, sizeof(DBI32Type) * COUNT33);
DBI16Type* d_KEY_33supplier__s_city_encoded;
cudaMalloc(&d_KEY_33supplier__s_city_encoded, sizeof(DBI16Type) * COUNT33);
cudaMemset(d_KEY_33supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT33);
DBI16Type* d_KEY_33part__p_brand1_encoded;
cudaMalloc(&d_KEY_33part__p_brand1_encoded, sizeof(DBI16Type) * COUNT33);
cudaMemset(d_KEY_33part__p_brand1_encoded, 0, sizeof(DBI16Type) * COUNT33);
main_20<<<std::ceil((float)lineorder_size/(float)TILE_SIZE), TB>>>(d_BUF_28, d_BUF_29, d_BUF_30, d_BUF_31, d_HT_28.ref(cuco::find), d_HT_29.ref(cuco::find), d_HT_30.ref(cuco::find), d_HT_31.ref(cuco::find), d_HT_33.ref(cuco::insert_and_find), d_KEY_33date__d_year, d_KEY_33part__p_brand1_encoded, d_KEY_33supplier__s_city_encoded, d_SLOT_COUNT_33, d_aggr0__tmp_attr0, d_cycles_per_warp_main_20_aggregation_33, d_cycles_per_warp_main_20_join_probe_28, d_cycles_per_warp_main_20_join_probe_29, d_cycles_per_warp_main_20_join_probe_30, d_cycles_per_warp_main_20_join_probe_31, d_cycles_per_warp_main_20_map_32, d_cycles_per_warp_main_20_selection_19, d_cycles_per_warp_main_20_selection_21, d_cycles_per_warp_main_20_selection_22, d_cycles_per_warp_main_20_selection_23, d_cycles_per_warp_main_20_selection_24, d_cycles_per_warp_main_20_selection_25, d_cycles_per_warp_main_20_selection_26, d_cycles_per_warp_main_20_selection_27, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, d_lineorder__lo_supplycost, lineorder_size, d_part__p_brand1_encoded, d_supplier__s_city_encoded);
int64_t* cycles_per_warp_main_20_selection_19 = (int64_t*)malloc(sizeof(int64_t) * main_20_selection_19_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_selection_19, d_cycles_per_warp_main_20_selection_19, sizeof(int64_t) * main_20_selection_19_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_selection_19 ";
for (auto i=0ull; i < main_20_selection_19_cpw_size; i++) std::cout << cycles_per_warp_main_20_selection_19[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_20_selection_21 = (int64_t*)malloc(sizeof(int64_t) * main_20_selection_21_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_selection_21, d_cycles_per_warp_main_20_selection_21, sizeof(int64_t) * main_20_selection_21_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_selection_21 ";
for (auto i=0ull; i < main_20_selection_21_cpw_size; i++) std::cout << cycles_per_warp_main_20_selection_21[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_20_selection_22 = (int64_t*)malloc(sizeof(int64_t) * main_20_selection_22_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_selection_22, d_cycles_per_warp_main_20_selection_22, sizeof(int64_t) * main_20_selection_22_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_selection_22 ";
for (auto i=0ull; i < main_20_selection_22_cpw_size; i++) std::cout << cycles_per_warp_main_20_selection_22[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_20_selection_23 = (int64_t*)malloc(sizeof(int64_t) * main_20_selection_23_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_selection_23, d_cycles_per_warp_main_20_selection_23, sizeof(int64_t) * main_20_selection_23_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_selection_23 ";
for (auto i=0ull; i < main_20_selection_23_cpw_size; i++) std::cout << cycles_per_warp_main_20_selection_23[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_20_selection_24 = (int64_t*)malloc(sizeof(int64_t) * main_20_selection_24_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_selection_24, d_cycles_per_warp_main_20_selection_24, sizeof(int64_t) * main_20_selection_24_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_selection_24 ";
for (auto i=0ull; i < main_20_selection_24_cpw_size; i++) std::cout << cycles_per_warp_main_20_selection_24[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_20_selection_25 = (int64_t*)malloc(sizeof(int64_t) * main_20_selection_25_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_selection_25, d_cycles_per_warp_main_20_selection_25, sizeof(int64_t) * main_20_selection_25_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_selection_25 ";
for (auto i=0ull; i < main_20_selection_25_cpw_size; i++) std::cout << cycles_per_warp_main_20_selection_25[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_20_selection_26 = (int64_t*)malloc(sizeof(int64_t) * main_20_selection_26_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_selection_26, d_cycles_per_warp_main_20_selection_26, sizeof(int64_t) * main_20_selection_26_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_selection_26 ";
for (auto i=0ull; i < main_20_selection_26_cpw_size; i++) std::cout << cycles_per_warp_main_20_selection_26[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_20_selection_27 = (int64_t*)malloc(sizeof(int64_t) * main_20_selection_27_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_selection_27, d_cycles_per_warp_main_20_selection_27, sizeof(int64_t) * main_20_selection_27_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_selection_27 ";
for (auto i=0ull; i < main_20_selection_27_cpw_size; i++) std::cout << cycles_per_warp_main_20_selection_27[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_20_join_probe_28 = (int64_t*)malloc(sizeof(int64_t) * main_20_join_probe_28_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_join_probe_28, d_cycles_per_warp_main_20_join_probe_28, sizeof(int64_t) * main_20_join_probe_28_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_join_probe_28 ";
for (auto i=0ull; i < main_20_join_probe_28_cpw_size; i++) std::cout << cycles_per_warp_main_20_join_probe_28[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_20_join_probe_29 = (int64_t*)malloc(sizeof(int64_t) * main_20_join_probe_29_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_join_probe_29, d_cycles_per_warp_main_20_join_probe_29, sizeof(int64_t) * main_20_join_probe_29_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_join_probe_29 ";
for (auto i=0ull; i < main_20_join_probe_29_cpw_size; i++) std::cout << cycles_per_warp_main_20_join_probe_29[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_20_join_probe_30 = (int64_t*)malloc(sizeof(int64_t) * main_20_join_probe_30_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_join_probe_30, d_cycles_per_warp_main_20_join_probe_30, sizeof(int64_t) * main_20_join_probe_30_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_join_probe_30 ";
for (auto i=0ull; i < main_20_join_probe_30_cpw_size; i++) std::cout << cycles_per_warp_main_20_join_probe_30[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_20_join_probe_31 = (int64_t*)malloc(sizeof(int64_t) * main_20_join_probe_31_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_join_probe_31, d_cycles_per_warp_main_20_join_probe_31, sizeof(int64_t) * main_20_join_probe_31_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_join_probe_31 ";
for (auto i=0ull; i < main_20_join_probe_31_cpw_size; i++) std::cout << cycles_per_warp_main_20_join_probe_31[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_20_map_32 = (int64_t*)malloc(sizeof(int64_t) * main_20_map_32_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_map_32, d_cycles_per_warp_main_20_map_32, sizeof(int64_t) * main_20_map_32_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_map_32 ";
for (auto i=0ull; i < main_20_map_32_cpw_size; i++) std::cout << cycles_per_warp_main_20_map_32[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_20_aggregation_33 = (int64_t*)malloc(sizeof(int64_t) * main_20_aggregation_33_cpw_size);
cudaMemcpy(cycles_per_warp_main_20_aggregation_33, d_cycles_per_warp_main_20_aggregation_33, sizeof(int64_t) * main_20_aggregation_33_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_20_aggregation_33 ";
for (auto i=0ull; i < main_20_aggregation_33_cpw_size; i++) std::cout << cycles_per_warp_main_20_aggregation_33[i] << " ";
std::cout << std::endl;
COUNT33 = d_HT_33.size();
int64_t* d_cycles_per_warp_main_35_materialize_34;
auto main_35_materialize_34_cpw_size = std::ceil((float)COUNT33/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_35_materialize_34, sizeof(int64_t) * main_35_materialize_34_cpw_size);
cudaMemset(d_cycles_per_warp_main_35_materialize_34, -1, sizeof(int64_t) * main_35_materialize_34_cpw_size);
size_t COUNT34 = COUNT33;
//Materialize buffers
uint64_t* d_MAT_IDX34;
cudaMalloc(&d_MAT_IDX34, sizeof(uint64_t));
cudaMemset(d_MAT_IDX34, 0, sizeof(uint64_t));
auto MAT34date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT34);
DBI32Type* d_MAT34date__d_year;
cudaMalloc(&d_MAT34date__d_year, sizeof(DBI32Type) * COUNT34);
auto MAT34supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT34);
DBI16Type* d_MAT34supplier__s_city_encoded;
cudaMalloc(&d_MAT34supplier__s_city_encoded, sizeof(DBI16Type) * COUNT34);
auto MAT34part__p_brand1_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT34);
DBI16Type* d_MAT34part__p_brand1_encoded;
cudaMalloc(&d_MAT34part__p_brand1_encoded, sizeof(DBI16Type) * COUNT34);
auto MAT34aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT34);
DBDecimalType* d_MAT34aggr0__tmp_attr0;
cudaMalloc(&d_MAT34aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT34);
main_35<<<std::ceil((float)COUNT33/(float)TILE_SIZE), TB>>>(COUNT33, d_MAT34aggr0__tmp_attr0, d_MAT34date__d_year, d_MAT34part__p_brand1_encoded, d_MAT34supplier__s_city_encoded, d_MAT_IDX34, d_aggr0__tmp_attr0, d_cycles_per_warp_main_35_materialize_34, d_KEY_33date__d_year, d_KEY_33part__p_brand1_encoded, d_KEY_33supplier__s_city_encoded);
uint64_t MATCOUNT_34 = 0;
cudaMemcpy(&MATCOUNT_34, d_MAT_IDX34, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT34date__d_year, d_MAT34date__d_year, sizeof(DBI32Type) * COUNT34, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT34supplier__s_city_encoded, d_MAT34supplier__s_city_encoded, sizeof(DBI16Type) * COUNT34, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT34part__p_brand1_encoded, d_MAT34part__p_brand1_encoded, sizeof(DBI16Type) * COUNT34, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT34aggr0__tmp_attr0, d_MAT34aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT34, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_35_materialize_34 = (int64_t*)malloc(sizeof(int64_t) * main_35_materialize_34_cpw_size);
cudaMemcpy(cycles_per_warp_main_35_materialize_34, d_cycles_per_warp_main_35_materialize_34, sizeof(int64_t) * main_35_materialize_34_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_35_materialize_34 ";
for (auto i=0ull; i < main_35_materialize_34_cpw_size; i++) std::cout << cycles_per_warp_main_35_materialize_34[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_28);
cudaFree(d_BUF_IDX_28);
cudaFree(d_BUF_29);
cudaFree(d_BUF_IDX_29);
cudaFree(d_BUF_30);
cudaFree(d_BUF_IDX_30);
cudaFree(d_BUF_31);
cudaFree(d_BUF_IDX_31);
cudaFree(d_KEY_33date__d_year);
cudaFree(d_KEY_33part__p_brand1_encoded);
cudaFree(d_KEY_33supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_MAT34aggr0__tmp_attr0);
cudaFree(d_MAT34date__d_year);
cudaFree(d_MAT34part__p_brand1_encoded);
cudaFree(d_MAT34supplier__s_city_encoded);
cudaFree(d_MAT_IDX34);
free(MAT34aggr0__tmp_attr0);
free(MAT34date__d_year);
free(MAT34part__p_brand1_encoded);
free(MAT34supplier__s_city_encoded);
}