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
__global__ void count_1(uint64_t* COUNT3, DBStringType* part__p_brand, DBStringType* part__p_container, size_t part_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBStringType reg_part__p_container[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_container[ITEM] = part__p_container[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq);
}
DBStringType reg_part__p_brand[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_brand[ITEM] = part__p_brand[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq);
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT3, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_3, uint64_t* BUF_IDX_3, HASHTABLE_INSERT HT_3, int64_t* cycles_per_warp_main_1_join_build_3, int64_t* cycles_per_warp_main_1_selection_0, int64_t* cycles_per_warp_main_1_selection_2, DBStringType* part__p_brand, DBStringType* part__p_container, DBI32Type* part__p_partkey, size_t part_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_part__p_container[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_container[ITEM] = part__p_container[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
DBStringType reg_part__p_brand[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_brand[ITEM] = part__p_brand[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_3[ITEMS_PER_THREAD];
DBI32Type reg_part__p_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_partkey[ITEM] = part__p_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_3[ITEM] = 0;
KEY_3[ITEM] |= reg_part__p_partkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_3 = atomicAdd((int*)BUF_IDX_3, 1);
HT_3.insert(cuco::pair{KEY_3[ITEM], buf_idx_3});
BUF_3[(buf_idx_3) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_build_3[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void count_4(uint64_t* BUF_3, HASHTABLE_PROBE HT_3, HASHTABLE_INSERT HT_5, size_t lineitem_size, DBI32Type* lineitem_u_1__l_partkey) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_3[ITEMS_PER_THREAD];
DBI32Type reg_lineitem_u_1__l_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem_u_1__l_partkey[ITEM] = lineitem_u_1__l_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_3[ITEM] = 0;
KEY_3[ITEM] |= reg_lineitem_u_1__l_partkey[ITEM];
}
int64_t slot_second3[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_3 = HT_3.find(KEY_3[ITEM]);
if (SLOT_3 == HT_3.end()) {selection_flags[ITEM] = 0; continue;}
slot_second3[ITEM] = SLOT_3->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_5[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_5[ITEM] = 0;
KEY_5[ITEM] |= reg_lineitem_u_1__l_partkey[ITEM];
}
//Create aggregation hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_5.insert(cuco::pair{KEY_5[ITEM], 1});
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_4(uint64_t* BUF_3, HASHTABLE_PROBE HT_3, HASHTABLE_FIND HT_5, DBI32Type* KEY_5lineitem_u_1__l_partkey, DBDecimalType* aggr_rw__rw0, DBI64Type* aggr_rw__rw1, int64_t* cycles_per_warp_main_4_aggregation_5, int64_t* cycles_per_warp_main_4_join_probe_3, size_t lineitem_size, DBI32Type* lineitem_u_1__l_partkey, DBDecimalType* lineitem_u_1__l_quantity, DBI32Type* moved_aggr__p_partkey, DBI32Type* part__p_partkey) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_3[ITEMS_PER_THREAD];
DBI32Type reg_lineitem_u_1__l_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem_u_1__l_partkey[ITEM] = lineitem_u_1__l_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_3[ITEM] = 0;
KEY_3[ITEM] |= reg_lineitem_u_1__l_partkey[ITEM];
}
int64_t slot_second3[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_3 = HT_3.find(KEY_3[ITEM]);
if (SLOT_3 == HT_3.end()) {selection_flags[ITEM] = 0; continue;}
slot_second3[ITEM] = SLOT_3->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_4_join_probe_3[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_5[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_5[ITEM] = 0;
KEY_5[ITEM] |= reg_lineitem_u_1__l_partkey[ITEM];
}
//Aggregate in hashtable
DBDecimalType reg_lineitem_u_1__l_quantity[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem_u_1__l_quantity[ITEM] = lineitem_u_1__l_quantity[ITEM*TB + tid];
}
DBI32Type reg_part__p_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_partkey[ITEM] = part__p_partkey[BUF_3[slot_second3[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_5 = HT_5.find(KEY_5[ITEM])->second;
aggregate_sum(&aggr_rw__rw0[buf_idx_5], reg_lineitem_u_1__l_quantity[ITEM]);
aggregate_sum(&aggr_rw__rw1[buf_idx_5], 1);
aggregate_any(&moved_aggr__p_partkey[buf_idx_5], reg_part__p_partkey[ITEM]);
KEY_5lineitem_u_1__l_partkey[buf_idx_5] = reg_lineitem_u_1__l_partkey[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_4_aggregation_5[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_7(uint64_t* COUNT10, size_t COUNT5, DBI32Type* moved_aggr__p_partkey) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT5); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT5); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT10, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_7(uint64_t* BUF_10, uint64_t* BUF_IDX_10, size_t COUNT5, HASHTABLE_INSERT HT_10, int64_t* cycles_per_warp_main_7_join_build_10, int64_t* cycles_per_warp_main_7_map_6, int64_t* cycles_per_warp_main_7_map_8, int64_t* cycles_per_warp_main_7_selection_9, DBI32Type* moved_aggr__p_partkey) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_map_6[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_map_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT5); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_9[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_10[ITEMS_PER_THREAD];
DBI32Type reg_part__p_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT5); ++ITEM) {
reg_part__p_partkey[ITEM] = moved_aggr__p_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT5); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_10[ITEM] = 0;
KEY_10[ITEM] |= reg_part__p_partkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT5); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_10 = atomicAdd((int*)BUF_IDX_10, 1);
HT_10.insert(cuco::pair{KEY_10[ITEM], buf_idx_10});
BUF_10[(buf_idx_10) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_build_10[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void count_11(uint64_t* BUF_10, HASHTABLE_PROBE HT_10, HASHTABLE_INSERT HT_12, DBDecimalType* aggr_rw__rw0, DBI64Type* aggr_rw__rw1, DBI32Type* lineitem__l_partkey, DBDecimalType* lineitem__l_quantity, size_t lineitem_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_10[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_partkey[ITEM] = lineitem__l_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_10[ITEM] = 0;
KEY_10[ITEM] |= reg_lineitem__l_partkey[ITEM];
}
int64_t slot_second10[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_10 = HT_10.find(KEY_10[ITEM]);
if (SLOT_10 == HT_10.end()) {selection_flags[ITEM] = 0; continue;}
slot_second10[ITEM] = SLOT_10->second;
}
DBDecimalType reg_lineitem__l_quantity[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_quantity[ITEM] = lineitem__l_quantity[ITEM*TB + tid];
}
DBI64Type reg_aggr_rw__rw1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_aggr_rw__rw1[ITEM] = aggr_rw__rw1[BUF_10[slot_second10[ITEM] * 1 + 0]];
}
DBDecimalType reg_aggr_rw__rw0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_aggr_rw__rw0[ITEM] = aggr_rw__rw0[BUF_10[slot_second10[ITEM] * 1 + 0]];
}
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_aggr0__tmp_attr0[ITEM] = (reg_aggr_rw__rw0[ITEM]) / ((DBDecimalType)(reg_aggr_rw__rw1[ITEM]));
}
DBDecimalType reg_map0__tmp_attr1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr1[ITEM] = (0.2) * (reg_aggr0__tmp_attr0[ITEM]);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(((DBDecimalType)reg_lineitem__l_quantity[ITEM]), reg_map0__tmp_attr1[ITEM], Predicate::lt)) && (true);
}
uint64_t KEY_12[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_12[ITEM] = 0;
}
//Create aggregation hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_12.insert(cuco::pair{KEY_12[ITEM], 1});
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_11(uint64_t* BUF_10, HASHTABLE_PROBE HT_10, HASHTABLE_FIND HT_12, DBDecimalType* aggr1__tmp_attr2, DBDecimalType* aggr_rw__rw0, DBI64Type* aggr_rw__rw1, int64_t* cycles_per_warp_main_11_aggregation_12, int64_t* cycles_per_warp_main_11_join_probe_10, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_partkey, DBDecimalType* lineitem__l_quantity, size_t lineitem_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_10[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_partkey[ITEM] = lineitem__l_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_10[ITEM] = 0;
KEY_10[ITEM] |= reg_lineitem__l_partkey[ITEM];
}
int64_t slot_second10[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_10 = HT_10.find(KEY_10[ITEM]);
if (SLOT_10 == HT_10.end()) {selection_flags[ITEM] = 0; continue;}
slot_second10[ITEM] = SLOT_10->second;
}
DBDecimalType reg_lineitem__l_quantity[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_quantity[ITEM] = lineitem__l_quantity[ITEM*TB + tid];
}
DBI64Type reg_aggr_rw__rw1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_aggr_rw__rw1[ITEM] = aggr_rw__rw1[BUF_10[slot_second10[ITEM] * 1 + 0]];
}
DBDecimalType reg_aggr_rw__rw0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_aggr_rw__rw0[ITEM] = aggr_rw__rw0[BUF_10[slot_second10[ITEM] * 1 + 0]];
}
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_aggr0__tmp_attr0[ITEM] = (reg_aggr_rw__rw0[ITEM]) / ((DBDecimalType)(reg_aggr_rw__rw1[ITEM]));
}
DBDecimalType reg_map0__tmp_attr1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr1[ITEM] = (0.2) * (reg_aggr0__tmp_attr0[ITEM]);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(((DBDecimalType)reg_lineitem__l_quantity[ITEM]), reg_map0__tmp_attr1[ITEM], Predicate::lt)) && (true);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_join_probe_10[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_12[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_12[ITEM] = 0;
}
//Aggregate in hashtable
DBDecimalType reg_lineitem__l_extendedprice[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_extendedprice[ITEM] = lineitem__l_extendedprice[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_12 = HT_12.find(KEY_12[ITEM])->second;
aggregate_sum(&aggr1__tmp_attr2[buf_idx_12], reg_lineitem__l_extendedprice[ITEM]);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_aggregation_12[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_14(size_t COUNT12, uint64_t* COUNT15) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT12); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT15, 1);
}
}
__global__ void main_14(size_t COUNT12, DBDecimalType* MAT15map1__tmp_attr3, uint64_t* MAT_IDX15, DBDecimalType* aggr1__tmp_attr2, int64_t* cycles_per_warp_main_14_map_13, int64_t* cycles_per_warp_main_14_materialize_15) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_map_13[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBDecimalType reg_aggr1__tmp_attr2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT12); ++ITEM) {
reg_aggr1__tmp_attr2[ITEM] = aggr1__tmp_attr2[ITEM*TB + tid];
}
DBDecimalType reg_map1__tmp_attr3[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT12); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map1__tmp_attr3[ITEM] = (reg_aggr1__tmp_attr2[ITEM]) / (7.0);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT12); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx15 = atomicAdd((int*)MAT_IDX15, 1);
MAT15map1__tmp_attr3[mat_idx15] = reg_map1__tmp_attr3[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_materialize_15[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_2;
auto main_1_selection_2_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_2, sizeof(int64_t) * main_1_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_2, -1, sizeof(int64_t) * main_1_selection_2_cpw_size);
//Materialize count
uint64_t* d_COUNT3;
cudaMalloc(&d_COUNT3, sizeof(uint64_t));
cudaMemset(d_COUNT3, 0, sizeof(uint64_t));
count_1<<<std::ceil((float)part_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT3, d_part__p_brand, d_part__p_container, part_size);
uint64_t COUNT3;
cudaMemcpy(&COUNT3, d_COUNT3, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_1_join_build_3;
auto main_1_join_build_3_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_build_3, sizeof(int64_t) * main_1_join_build_3_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_build_3, -1, sizeof(int64_t) * main_1_join_build_3_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_3;
cudaMalloc(&d_BUF_IDX_3, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_3, 0, sizeof(uint64_t));
uint64_t* d_BUF_3;
cudaMalloc(&d_BUF_3, sizeof(uint64_t) * COUNT3 * 1);
auto d_HT_3 = cuco::static_map{ (int)COUNT3*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)part_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_3, d_BUF_IDX_3, d_HT_3.ref(cuco::insert), d_cycles_per_warp_main_1_join_build_3, d_cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_2, d_part__p_brand, d_part__p_container, d_part__p_partkey, part_size);
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
int64_t* cycles_per_warp_main_1_join_build_3 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_build_3_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_build_3, d_cycles_per_warp_main_1_join_build_3, sizeof(int64_t) * main_1_join_build_3_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_build_3 ";
for (auto i=0ull; i < main_1_join_build_3_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_build_3[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_4_join_probe_3;
auto main_4_join_probe_3_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_4_join_probe_3, sizeof(int64_t) * main_4_join_probe_3_cpw_size);
cudaMemset(d_cycles_per_warp_main_4_join_probe_3, -1, sizeof(int64_t) * main_4_join_probe_3_cpw_size);
//Create aggregation hash table
auto d_HT_5 = cuco::static_map{ (int)6001215*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_4<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_3, d_HT_3.ref(cuco::find), d_HT_5.ref(cuco::insert), lineitem_size, d_lineitem__l_partkey);
size_t COUNT5 = d_HT_5.size();
thrust::device_vector<int64_t> keys_5(COUNT5), vals_5(COUNT5);
d_HT_5.retrieve_all(keys_5.begin(), vals_5.begin());
d_HT_5.clear();
int64_t* raw_keys5 = thrust::raw_pointer_cast(keys_5.data());
insertKeys<<<std::ceil((float)COUNT5/128.), 128>>>(raw_keys5, d_HT_5.ref(cuco::insert), COUNT5);
int64_t* d_cycles_per_warp_main_4_aggregation_5;
auto main_4_aggregation_5_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_4_aggregation_5, sizeof(int64_t) * main_4_aggregation_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_4_aggregation_5, -1, sizeof(int64_t) * main_4_aggregation_5_cpw_size);
//Aggregate in hashtable
DBDecimalType* d_aggr_rw__rw0;
cudaMalloc(&d_aggr_rw__rw0, sizeof(DBDecimalType) * COUNT5);
cudaMemset(d_aggr_rw__rw0, 0, sizeof(DBDecimalType) * COUNT5);
DBI64Type* d_aggr_rw__rw1;
cudaMalloc(&d_aggr_rw__rw1, sizeof(DBI64Type) * COUNT5);
cudaMemset(d_aggr_rw__rw1, 0, sizeof(DBI64Type) * COUNT5);
DBI32Type* d_moved_aggr__p_partkey;
cudaMalloc(&d_moved_aggr__p_partkey, sizeof(DBI32Type) * COUNT5);
cudaMemset(d_moved_aggr__p_partkey, 0, sizeof(DBI32Type) * COUNT5);
DBI32Type* d_KEY_5lineitem_u_1__l_partkey;
cudaMalloc(&d_KEY_5lineitem_u_1__l_partkey, sizeof(DBI32Type) * COUNT5);
cudaMemset(d_KEY_5lineitem_u_1__l_partkey, 0, sizeof(DBI32Type) * COUNT5);
main_4<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_3, d_HT_3.ref(cuco::find), d_HT_5.ref(cuco::find), d_KEY_5lineitem_u_1__l_partkey, d_aggr_rw__rw0, d_aggr_rw__rw1, d_cycles_per_warp_main_4_aggregation_5, d_cycles_per_warp_main_4_join_probe_3, lineitem_size, d_lineitem__l_partkey, d_lineitem__l_quantity, d_moved_aggr__p_partkey, d_part__p_partkey);
int64_t* cycles_per_warp_main_4_join_probe_3 = (int64_t*)malloc(sizeof(int64_t) * main_4_join_probe_3_cpw_size);
cudaMemcpy(cycles_per_warp_main_4_join_probe_3, d_cycles_per_warp_main_4_join_probe_3, sizeof(int64_t) * main_4_join_probe_3_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_4_join_probe_3 ";
for (auto i=0ull; i < main_4_join_probe_3_cpw_size; i++) std::cout << cycles_per_warp_main_4_join_probe_3[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_4_aggregation_5 = (int64_t*)malloc(sizeof(int64_t) * main_4_aggregation_5_cpw_size);
cudaMemcpy(cycles_per_warp_main_4_aggregation_5, d_cycles_per_warp_main_4_aggregation_5, sizeof(int64_t) * main_4_aggregation_5_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_4_aggregation_5 ";
for (auto i=0ull; i < main_4_aggregation_5_cpw_size; i++) std::cout << cycles_per_warp_main_4_aggregation_5[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_7_map_6;
auto main_7_map_6_cpw_size = std::ceil((float)COUNT5/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_map_6, sizeof(int64_t) * main_7_map_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_map_6, -1, sizeof(int64_t) * main_7_map_6_cpw_size);
int64_t* d_cycles_per_warp_main_7_map_8;
auto main_7_map_8_cpw_size = std::ceil((float)COUNT5/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_map_8, sizeof(int64_t) * main_7_map_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_map_8, -1, sizeof(int64_t) * main_7_map_8_cpw_size);
int64_t* d_cycles_per_warp_main_7_selection_9;
auto main_7_selection_9_cpw_size = std::ceil((float)COUNT5/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_9, sizeof(int64_t) * main_7_selection_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_9, -1, sizeof(int64_t) * main_7_selection_9_cpw_size);
//Materialize count
uint64_t* d_COUNT10;
cudaMalloc(&d_COUNT10, sizeof(uint64_t));
cudaMemset(d_COUNT10, 0, sizeof(uint64_t));
count_7<<<std::ceil((float)COUNT5/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT10, COUNT5, d_moved_aggr__p_partkey);
uint64_t COUNT10;
cudaMemcpy(&COUNT10, d_COUNT10, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_7_join_build_10;
auto main_7_join_build_10_cpw_size = std::ceil((float)COUNT5/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_build_10, sizeof(int64_t) * main_7_join_build_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_build_10, -1, sizeof(int64_t) * main_7_join_build_10_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_10;
cudaMalloc(&d_BUF_IDX_10, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_10, 0, sizeof(uint64_t));
uint64_t* d_BUF_10;
cudaMalloc(&d_BUF_10, sizeof(uint64_t) * COUNT10 * 1);
auto d_HT_10 = cuco::static_map{ (int)COUNT10*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_7<<<std::ceil((float)COUNT5/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_10, d_BUF_IDX_10, COUNT5, d_HT_10.ref(cuco::insert), d_cycles_per_warp_main_7_join_build_10, d_cycles_per_warp_main_7_map_6, d_cycles_per_warp_main_7_map_8, d_cycles_per_warp_main_7_selection_9, d_moved_aggr__p_partkey);
int64_t* cycles_per_warp_main_7_map_6 = (int64_t*)malloc(sizeof(int64_t) * main_7_map_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_map_6, d_cycles_per_warp_main_7_map_6, sizeof(int64_t) * main_7_map_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_map_6 ";
for (auto i=0ull; i < main_7_map_6_cpw_size; i++) std::cout << cycles_per_warp_main_7_map_6[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_map_8 = (int64_t*)malloc(sizeof(int64_t) * main_7_map_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_map_8, d_cycles_per_warp_main_7_map_8, sizeof(int64_t) * main_7_map_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_map_8 ";
for (auto i=0ull; i < main_7_map_8_cpw_size; i++) std::cout << cycles_per_warp_main_7_map_8[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_selection_9 = (int64_t*)malloc(sizeof(int64_t) * main_7_selection_9_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_selection_9, d_cycles_per_warp_main_7_selection_9, sizeof(int64_t) * main_7_selection_9_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_selection_9 ";
for (auto i=0ull; i < main_7_selection_9_cpw_size; i++) std::cout << cycles_per_warp_main_7_selection_9[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_join_build_10 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_build_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_build_10, d_cycles_per_warp_main_7_join_build_10, sizeof(int64_t) * main_7_join_build_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_build_10 ";
for (auto i=0ull; i < main_7_join_build_10_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_build_10[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_11_join_probe_10;
auto main_11_join_probe_10_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_join_probe_10, sizeof(int64_t) * main_11_join_probe_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_join_probe_10, -1, sizeof(int64_t) * main_11_join_probe_10_cpw_size);
//Create aggregation hash table
auto d_HT_12 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_11<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_10, d_HT_10.ref(cuco::find), d_HT_12.ref(cuco::insert), d_aggr_rw__rw0, d_aggr_rw__rw1, d_lineitem__l_partkey, d_lineitem__l_quantity, lineitem_size);
size_t COUNT12 = d_HT_12.size();
thrust::device_vector<int64_t> keys_12(COUNT12), vals_12(COUNT12);
d_HT_12.retrieve_all(keys_12.begin(), vals_12.begin());
d_HT_12.clear();
int64_t* raw_keys12 = thrust::raw_pointer_cast(keys_12.data());
insertKeys<<<std::ceil((float)COUNT12/128.), 128>>>(raw_keys12, d_HT_12.ref(cuco::insert), COUNT12);
int64_t* d_cycles_per_warp_main_11_aggregation_12;
auto main_11_aggregation_12_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_aggregation_12, sizeof(int64_t) * main_11_aggregation_12_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_aggregation_12, -1, sizeof(int64_t) * main_11_aggregation_12_cpw_size);
//Aggregate in hashtable
DBDecimalType* d_aggr1__tmp_attr2;
cudaMalloc(&d_aggr1__tmp_attr2, sizeof(DBDecimalType) * COUNT12);
cudaMemset(d_aggr1__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT12);
main_11<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_10, d_HT_10.ref(cuco::find), d_HT_12.ref(cuco::find), d_aggr1__tmp_attr2, d_aggr_rw__rw0, d_aggr_rw__rw1, d_cycles_per_warp_main_11_aggregation_12, d_cycles_per_warp_main_11_join_probe_10, d_lineitem__l_extendedprice, d_lineitem__l_partkey, d_lineitem__l_quantity, lineitem_size);
int64_t* cycles_per_warp_main_11_join_probe_10 = (int64_t*)malloc(sizeof(int64_t) * main_11_join_probe_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_join_probe_10, d_cycles_per_warp_main_11_join_probe_10, sizeof(int64_t) * main_11_join_probe_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_join_probe_10 ";
for (auto i=0ull; i < main_11_join_probe_10_cpw_size; i++) std::cout << cycles_per_warp_main_11_join_probe_10[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_11_aggregation_12 = (int64_t*)malloc(sizeof(int64_t) * main_11_aggregation_12_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_aggregation_12, d_cycles_per_warp_main_11_aggregation_12, sizeof(int64_t) * main_11_aggregation_12_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_aggregation_12 ";
for (auto i=0ull; i < main_11_aggregation_12_cpw_size; i++) std::cout << cycles_per_warp_main_11_aggregation_12[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_14_map_13;
auto main_14_map_13_cpw_size = std::ceil((float)COUNT12/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_map_13, sizeof(int64_t) * main_14_map_13_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_map_13, -1, sizeof(int64_t) * main_14_map_13_cpw_size);
//Materialize count
uint64_t* d_COUNT15;
cudaMalloc(&d_COUNT15, sizeof(uint64_t));
cudaMemset(d_COUNT15, 0, sizeof(uint64_t));
count_14<<<std::ceil((float)COUNT12/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT12, d_COUNT15);
uint64_t COUNT15;
cudaMemcpy(&COUNT15, d_COUNT15, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_14_materialize_15;
auto main_14_materialize_15_cpw_size = std::ceil((float)COUNT12/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_materialize_15, sizeof(int64_t) * main_14_materialize_15_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_materialize_15, -1, sizeof(int64_t) * main_14_materialize_15_cpw_size);
//Materialize buffers
uint64_t* d_MAT_IDX15;
cudaMalloc(&d_MAT_IDX15, sizeof(uint64_t));
cudaMemset(d_MAT_IDX15, 0, sizeof(uint64_t));
auto MAT15map1__tmp_attr3 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT15);
DBDecimalType* d_MAT15map1__tmp_attr3;
cudaMalloc(&d_MAT15map1__tmp_attr3, sizeof(DBDecimalType) * COUNT15);
main_14<<<std::ceil((float)COUNT12/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT12, d_MAT15map1__tmp_attr3, d_MAT_IDX15, d_aggr1__tmp_attr2, d_cycles_per_warp_main_14_map_13, d_cycles_per_warp_main_14_materialize_15);
cudaMemcpy(MAT15map1__tmp_attr3, d_MAT15map1__tmp_attr3, sizeof(DBDecimalType) * COUNT15, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_14_map_13 = (int64_t*)malloc(sizeof(int64_t) * main_14_map_13_cpw_size);
cudaMemcpy(cycles_per_warp_main_14_map_13, d_cycles_per_warp_main_14_map_13, sizeof(int64_t) * main_14_map_13_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_14_map_13 ";
for (auto i=0ull; i < main_14_map_13_cpw_size; i++) std::cout << cycles_per_warp_main_14_map_13[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_14_materialize_15 = (int64_t*)malloc(sizeof(int64_t) * main_14_materialize_15_cpw_size);
cudaMemcpy(cycles_per_warp_main_14_materialize_15, d_cycles_per_warp_main_14_materialize_15, sizeof(int64_t) * main_14_materialize_15_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_14_materialize_15 ";
for (auto i=0ull; i < main_14_materialize_15_cpw_size; i++) std::cout << cycles_per_warp_main_14_materialize_15[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
      size_t aux_mem = usedGpuMem() - used_mem;
      std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_3);
cudaFree(d_BUF_IDX_3);
cudaFree(d_COUNT3);
cudaFree(d_KEY_5lineitem_u_1__l_partkey);
cudaFree(d_aggr_rw__rw0);
cudaFree(d_aggr_rw__rw1);
cudaFree(d_moved_aggr__p_partkey);
cudaFree(d_BUF_10);
cudaFree(d_BUF_IDX_10);
cudaFree(d_COUNT10);
cudaFree(d_aggr1__tmp_attr2);
cudaFree(d_COUNT15);
cudaFree(d_MAT15map1__tmp_attr3);
cudaFree(d_MAT_IDX15);
free(MAT15map1__tmp_attr3);
}