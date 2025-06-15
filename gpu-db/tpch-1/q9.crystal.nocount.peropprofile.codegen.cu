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
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT HT_0, int64_t* cycles_per_warp_main_1_join_build_0, DBI32Type* nation__n_nationkey, size_t nation_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_0[ITEMS_PER_THREAD];
DBI32Type reg_nation__n_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_nation__n_nationkey[ITEM] = nation__n_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_0[ITEM] = 0;
KEY_0[ITEM] |= reg_nation__n_nationkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_0.insert(cuco::pair{KEY_0[ITEM], ITEM*TB + tid});
BUF_0[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_build_0[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_2(uint64_t* BUF_0, uint64_t* BUF_3, uint64_t* BUF_IDX_3, HASHTABLE_PROBE HT_0, HASHTABLE_INSERT HT_3, int64_t* cycles_per_warp_main_2_join_build_3, int64_t* cycles_per_warp_main_2_join_probe_0, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_0[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_nationkey[ITEM] = supplier__s_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_0[ITEM] = 0;
KEY_0[ITEM] |= reg_supplier__s_nationkey[ITEM];
}
//Probe Hash table
int64_t slot_second0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_0 = HT_0.find(KEY_0[ITEM]);
if (SLOT_0 == HT_0.end()) {selection_flags[ITEM] = 0; continue;}
slot_second0[ITEM] = SLOT_0->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_2_join_probe_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_3[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_3[ITEM] = 0;
KEY_3[ITEM] |= reg_supplier__s_suppkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_3.insert(cuco::pair{KEY_3[ITEM], ITEM*TB + tid});
BUF_3[(ITEM*TB + tid) * 2 + 0] = ITEM*TB + tid;
BUF_3[(ITEM*TB + tid) * 2 + 1] = BUF_0[slot_second0[ITEM] * 1 + 0];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_2_join_build_3[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_6(uint64_t* BUF_5, uint64_t* BUF_IDX_5, HASHTABLE_INSERT HT_5, int64_t* cycles_per_warp_main_6_join_build_5, DBI32Type* orders__o_orderkey, size_t orders_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_5[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_5[ITEM] = 0;
KEY_5[ITEM] |= reg_orders__o_orderkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_5.insert(cuco::pair{KEY_5[ITEM], ITEM*TB + tid});
BUF_5[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_6_join_build_5[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_9(uint64_t* BUF_8, uint64_t* BUF_IDX_8, HASHTABLE_INSERT HT_8, int64_t* cycles_per_warp_main_9_join_build_8, DBI32Type* part__p_partkey, size_t part_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_8[ITEMS_PER_THREAD];
DBI32Type reg_part__p_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_partkey[ITEM] = part__p_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_part__p_partkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_8.insert(cuco::pair{KEY_8[ITEM], ITEM*TB + tid});
BUF_8[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_9_join_build_8[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_4(uint64_t* BUF_10, uint64_t* BUF_3, uint64_t* BUF_IDX_10, HASHTABLE_INSERT HT_10, HASHTABLE_PROBE HT_3, int64_t* cycles_per_warp_main_4_join_build_10, int64_t* cycles_per_warp_main_4_join_probe_3, DBI32Type* partsupp__ps_partkey, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size, DBI32Type* supplier__s_suppkey) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_3[ITEMS_PER_THREAD];
DBI32Type reg_partsupp__ps_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
reg_partsupp__ps_suppkey[ITEM] = partsupp__ps_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_3[ITEM] = 0;
KEY_3[ITEM] |= reg_partsupp__ps_suppkey[ITEM];
}
//Probe Hash table
int64_t slot_second3[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_3 = HT_3.find(KEY_3[ITEM]);
if (SLOT_3 == HT_3.end()) {selection_flags[ITEM] = 0; continue;}
slot_second3[ITEM] = SLOT_3->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_4_join_probe_3[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_10[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[BUF_3[slot_second3[ITEM] * 2 + 0]];
}
DBI32Type reg_partsupp__ps_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
reg_partsupp__ps_partkey[ITEM] = partsupp__ps_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_10[ITEM] = 0;
KEY_10[ITEM] |= reg_supplier__s_suppkey[ITEM];
KEY_10[ITEM] <<= 32;
KEY_10[ITEM] |= reg_partsupp__ps_partkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_10.insert(cuco::pair{KEY_10[ITEM], ITEM*TB + tid});
BUF_10[(ITEM*TB + tid) * 3 + 0] = BUF_3[slot_second3[ITEM] * 2 + 0];
BUF_10[(ITEM*TB + tid) * 3 + 1] = ITEM*TB + tid;
BUF_10[(ITEM*TB + tid) * 3 + 2] = BUF_3[slot_second3[ITEM] * 2 + 1];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_4_join_build_10[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_7(uint64_t* BUF_10, uint64_t* BUF_5, uint64_t* BUF_8, HASHTABLE_PROBE HT_10, HASHTABLE_FIND HT_13, HASHTABLE_PROBE HT_5, HASHTABLE_PROBE HT_8, DBI64Type* KEY_13map0__tmp_attr0, DBI16Type* KEY_13nation__n_name_encoded, int* SLOT_COUNT_13, DBDecimalType* aggr0__tmp_attr2, int64_t* cycles_per_warp_main_7_aggregation_13, int64_t* cycles_per_warp_main_7_join_probe_10, int64_t* cycles_per_warp_main_7_join_probe_5, int64_t* cycles_per_warp_main_7_join_probe_8, int64_t* cycles_per_warp_main_7_map_11, int64_t* cycles_per_warp_main_7_map_12, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_partkey, DBDecimalType* lineitem__l_quantity, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBI16Type* nation__n_name_encoded, DBDateType* orders__o_orderdate, DBDecimalType* partsupp__ps_supplycost) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_5[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_5[ITEM] = 0;
KEY_5[ITEM] |= reg_lineitem__l_orderkey[ITEM];
}
//Probe Hash table
int64_t slot_second5[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_5 = HT_5.find(KEY_5[ITEM]);
if (SLOT_5 == HT_5.end()) {selection_flags[ITEM] = 0; continue;}
slot_second5[ITEM] = SLOT_5->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_probe_5[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_8[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_partkey[ITEM] = lineitem__l_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_lineitem__l_partkey[ITEM];
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_probe_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
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
KEY_10[ITEM] <<= 32;
KEY_10[ITEM] |= reg_lineitem__l_partkey[ITEM];
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_probe_10[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_map_11[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
DBDateType reg_orders__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_orderdate[ITEM] = orders__o_orderdate[BUF_5[slot_second5[ITEM] * 1 + 0]];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_map_12[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_13[ITEMS_PER_THREAD];
DBI16Type reg_nation__n_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_nation__n_name_encoded[ITEM] = nation__n_name_encoded[BUF_10[slot_second10[ITEM] * 3 + 2]];
}
DBI64Type reg_map0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr0[ITEM] = ExtractFromDate("year", reg_orders__o_orderdate[ITEM]);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_13[ITEM] = 0;
KEY_13[ITEM] |= reg_nation__n_name_encoded[ITEM];
KEY_13[ITEM] <<= 32;
KEY_13[ITEM] |= (DBI32Type)reg_map0__tmp_attr0[ITEM];
}
//Aggregate in hashtable
DBDecimalType reg_lineitem__l_quantity[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_quantity[ITEM] = lineitem__l_quantity[ITEM*TB + tid];
}
DBDecimalType reg_partsupp__ps_supplycost[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_partsupp__ps_supplycost[ITEM] = partsupp__ps_supplycost[BUF_10[slot_second10[ITEM] * 3 + 1]];
}
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
reg_map0__tmp_attr1[ITEM] = ((reg_lineitem__l_extendedprice[ITEM]) * ((1.0) - (reg_lineitem__l_discount[ITEM]))) - ((reg_partsupp__ps_supplycost[ITEM]) * (reg_lineitem__l_quantity[ITEM]));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_13 = get_aggregation_slot(KEY_13[ITEM], HT_13, SLOT_COUNT_13);
aggregate_sum(&aggr0__tmp_attr2[buf_idx_13], reg_map0__tmp_attr1[ITEM]);
KEY_13nation__n_name_encoded[buf_idx_13] = reg_nation__n_name_encoded[ITEM];
KEY_13map0__tmp_attr0[buf_idx_13] = reg_map0__tmp_attr0[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_aggregation_13[blockIdx.x] = cycles_per_warp;}
}
__global__ void main_15(size_t COUNT13, DBDecimalType* MAT14aggr0__tmp_attr2, DBI64Type* MAT14map0__tmp_attr0, DBI16Type* MAT14nation__n_name_encoded, uint64_t* MAT_IDX14, DBDecimalType* aggr0__tmp_attr2, int64_t* cycles_per_warp_main_15_materialize_14, DBI64Type* map0__tmp_attr0, DBI16Type* nation__n_name_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI16Type reg_nation__n_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT13); ++ITEM) {
reg_nation__n_name_encoded[ITEM] = nation__n_name_encoded[ITEM*TB + tid];
}
DBI64Type reg_map0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT13); ++ITEM) {
reg_map0__tmp_attr0[ITEM] = map0__tmp_attr0[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT13); ++ITEM) {
reg_aggr0__tmp_attr2[ITEM] = aggr0__tmp_attr2[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT13); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx14 = atomicAdd((int*)MAT_IDX14, 1);
MAT14nation__n_name_encoded[mat_idx14] = reg_nation__n_name_encoded[ITEM];
MAT14map0__tmp_attr0[mat_idx14] = reg_map0__tmp_attr0[ITEM];
MAT14aggr0__tmp_attr2[mat_idx14] = reg_aggr0__tmp_attr2[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_15_materialize_14[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_1_join_build_0;
auto main_1_join_build_0_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_build_0, sizeof(int64_t) * main_1_join_build_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_build_0, -1, sizeof(int64_t) * main_1_join_build_0_cpw_size);
size_t COUNT0 = nation_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_0;
cudaMalloc(&d_BUF_IDX_0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_0, 0, sizeof(uint64_t));
uint64_t* d_BUF_0;
cudaMalloc(&d_BUF_0, sizeof(uint64_t) * COUNT0 * 1);
auto d_HT_0 = cuco::static_map{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)nation_size/(float)TILE_SIZE), TB>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_cycles_per_warp_main_1_join_build_0, d_nation__n_nationkey, nation_size);
int64_t* cycles_per_warp_main_1_join_build_0 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_build_0_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_build_0, d_cycles_per_warp_main_1_join_build_0, sizeof(int64_t) * main_1_join_build_0_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_build_0 ";
for (auto i=0ull; i < main_1_join_build_0_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_build_0[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_2_join_probe_0;
auto main_2_join_probe_0_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_2_join_probe_0, sizeof(int64_t) * main_2_join_probe_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_2_join_probe_0, -1, sizeof(int64_t) * main_2_join_probe_0_cpw_size);
int64_t* d_cycles_per_warp_main_2_join_build_3;
auto main_2_join_build_3_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_2_join_build_3, sizeof(int64_t) * main_2_join_build_3_cpw_size);
cudaMemset(d_cycles_per_warp_main_2_join_build_3, -1, sizeof(int64_t) * main_2_join_build_3_cpw_size);
size_t COUNT3 = supplier_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_3;
cudaMalloc(&d_BUF_IDX_3, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_3, 0, sizeof(uint64_t));
uint64_t* d_BUF_3;
cudaMalloc(&d_BUF_3, sizeof(uint64_t) * COUNT3 * 2);
auto d_HT_3 = cuco::static_map{ (int)COUNT3*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_2<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TB>>>(d_BUF_0, d_BUF_3, d_BUF_IDX_3, d_HT_0.ref(cuco::find), d_HT_3.ref(cuco::insert), d_cycles_per_warp_main_2_join_build_3, d_cycles_per_warp_main_2_join_probe_0, d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
int64_t* cycles_per_warp_main_2_join_probe_0 = (int64_t*)malloc(sizeof(int64_t) * main_2_join_probe_0_cpw_size);
cudaMemcpy(cycles_per_warp_main_2_join_probe_0, d_cycles_per_warp_main_2_join_probe_0, sizeof(int64_t) * main_2_join_probe_0_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_2_join_probe_0 ";
for (auto i=0ull; i < main_2_join_probe_0_cpw_size; i++) std::cout << cycles_per_warp_main_2_join_probe_0[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_2_join_build_3 = (int64_t*)malloc(sizeof(int64_t) * main_2_join_build_3_cpw_size);
cudaMemcpy(cycles_per_warp_main_2_join_build_3, d_cycles_per_warp_main_2_join_build_3, sizeof(int64_t) * main_2_join_build_3_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_2_join_build_3 ";
for (auto i=0ull; i < main_2_join_build_3_cpw_size; i++) std::cout << cycles_per_warp_main_2_join_build_3[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_6_join_build_5;
auto main_6_join_build_5_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_6_join_build_5, sizeof(int64_t) * main_6_join_build_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_6_join_build_5, -1, sizeof(int64_t) * main_6_join_build_5_cpw_size);
size_t COUNT5 = orders_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_5;
cudaMalloc(&d_BUF_IDX_5, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5, 0, sizeof(uint64_t));
uint64_t* d_BUF_5;
cudaMalloc(&d_BUF_5, sizeof(uint64_t) * COUNT5 * 1);
auto d_HT_5 = cuco::static_map{ (int)COUNT5*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6<<<std::ceil((float)orders_size/(float)TILE_SIZE), TB>>>(d_BUF_5, d_BUF_IDX_5, d_HT_5.ref(cuco::insert), d_cycles_per_warp_main_6_join_build_5, d_orders__o_orderkey, orders_size);
int64_t* cycles_per_warp_main_6_join_build_5 = (int64_t*)malloc(sizeof(int64_t) * main_6_join_build_5_cpw_size);
cudaMemcpy(cycles_per_warp_main_6_join_build_5, d_cycles_per_warp_main_6_join_build_5, sizeof(int64_t) * main_6_join_build_5_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_6_join_build_5 ";
for (auto i=0ull; i < main_6_join_build_5_cpw_size; i++) std::cout << cycles_per_warp_main_6_join_build_5[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_9_join_build_8;
auto main_9_join_build_8_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_9_join_build_8, sizeof(int64_t) * main_9_join_build_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_9_join_build_8, -1, sizeof(int64_t) * main_9_join_build_8_cpw_size);
size_t COUNT8 = part_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_8;
cudaMalloc(&d_BUF_IDX_8, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_8, 0, sizeof(uint64_t));
uint64_t* d_BUF_8;
cudaMalloc(&d_BUF_8, sizeof(uint64_t) * COUNT8 * 1);
auto d_HT_8 = cuco::static_map{ (int)COUNT8*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_9<<<std::ceil((float)part_size/(float)TILE_SIZE), TB>>>(d_BUF_8, d_BUF_IDX_8, d_HT_8.ref(cuco::insert), d_cycles_per_warp_main_9_join_build_8, d_part__p_partkey, part_size);
int64_t* cycles_per_warp_main_9_join_build_8 = (int64_t*)malloc(sizeof(int64_t) * main_9_join_build_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_9_join_build_8, d_cycles_per_warp_main_9_join_build_8, sizeof(int64_t) * main_9_join_build_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_9_join_build_8 ";
for (auto i=0ull; i < main_9_join_build_8_cpw_size; i++) std::cout << cycles_per_warp_main_9_join_build_8[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_4_join_probe_3;
auto main_4_join_probe_3_cpw_size = std::ceil((float)partsupp_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_4_join_probe_3, sizeof(int64_t) * main_4_join_probe_3_cpw_size);
cudaMemset(d_cycles_per_warp_main_4_join_probe_3, -1, sizeof(int64_t) * main_4_join_probe_3_cpw_size);
int64_t* d_cycles_per_warp_main_4_join_build_10;
auto main_4_join_build_10_cpw_size = std::ceil((float)partsupp_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_4_join_build_10, sizeof(int64_t) * main_4_join_build_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_4_join_build_10, -1, sizeof(int64_t) * main_4_join_build_10_cpw_size);
size_t COUNT10 = partsupp_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_10;
cudaMalloc(&d_BUF_IDX_10, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_10, 0, sizeof(uint64_t));
uint64_t* d_BUF_10;
cudaMalloc(&d_BUF_10, sizeof(uint64_t) * COUNT10 * 3);
auto d_HT_10 = cuco::static_map{ (int)COUNT10*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_4<<<std::ceil((float)partsupp_size/(float)TILE_SIZE), TB>>>(d_BUF_10, d_BUF_3, d_BUF_IDX_10, d_HT_10.ref(cuco::insert), d_HT_3.ref(cuco::find), d_cycles_per_warp_main_4_join_build_10, d_cycles_per_warp_main_4_join_probe_3, d_partsupp__ps_partkey, d_partsupp__ps_suppkey, partsupp_size, d_supplier__s_suppkey);
int64_t* cycles_per_warp_main_4_join_probe_3 = (int64_t*)malloc(sizeof(int64_t) * main_4_join_probe_3_cpw_size);
cudaMemcpy(cycles_per_warp_main_4_join_probe_3, d_cycles_per_warp_main_4_join_probe_3, sizeof(int64_t) * main_4_join_probe_3_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_4_join_probe_3 ";
for (auto i=0ull; i < main_4_join_probe_3_cpw_size; i++) std::cout << cycles_per_warp_main_4_join_probe_3[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_4_join_build_10 = (int64_t*)malloc(sizeof(int64_t) * main_4_join_build_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_4_join_build_10, d_cycles_per_warp_main_4_join_build_10, sizeof(int64_t) * main_4_join_build_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_4_join_build_10 ";
for (auto i=0ull; i < main_4_join_build_10_cpw_size; i++) std::cout << cycles_per_warp_main_4_join_build_10[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_7_join_probe_5;
auto main_7_join_probe_5_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_probe_5, sizeof(int64_t) * main_7_join_probe_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_probe_5, -1, sizeof(int64_t) * main_7_join_probe_5_cpw_size);
int64_t* d_cycles_per_warp_main_7_join_probe_8;
auto main_7_join_probe_8_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_probe_8, sizeof(int64_t) * main_7_join_probe_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_probe_8, -1, sizeof(int64_t) * main_7_join_probe_8_cpw_size);
int64_t* d_cycles_per_warp_main_7_join_probe_10;
auto main_7_join_probe_10_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_probe_10, sizeof(int64_t) * main_7_join_probe_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_probe_10, -1, sizeof(int64_t) * main_7_join_probe_10_cpw_size);
int64_t* d_cycles_per_warp_main_7_map_11;
auto main_7_map_11_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_map_11, sizeof(int64_t) * main_7_map_11_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_map_11, -1, sizeof(int64_t) * main_7_map_11_cpw_size);
int64_t* d_cycles_per_warp_main_7_map_12;
auto main_7_map_12_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_map_12, sizeof(int64_t) * main_7_map_12_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_map_12, -1, sizeof(int64_t) * main_7_map_12_cpw_size);
int64_t* d_cycles_per_warp_main_7_aggregation_13;
auto main_7_aggregation_13_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_aggregation_13, sizeof(int64_t) * main_7_aggregation_13_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_aggregation_13, -1, sizeof(int64_t) * main_7_aggregation_13_cpw_size);
size_t COUNT13 = 48009721;
auto d_HT_13 = cuco::static_map{ (int)48009721*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_13;
cudaMalloc(&d_SLOT_COUNT_13, sizeof(int));
cudaMemset(d_SLOT_COUNT_13, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT13);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT13);
DBI16Type* d_KEY_13nation__n_name_encoded;
cudaMalloc(&d_KEY_13nation__n_name_encoded, sizeof(DBI16Type) * COUNT13);
cudaMemset(d_KEY_13nation__n_name_encoded, 0, sizeof(DBI16Type) * COUNT13);
DBI64Type* d_KEY_13map0__tmp_attr0;
cudaMalloc(&d_KEY_13map0__tmp_attr0, sizeof(DBI64Type) * COUNT13);
cudaMemset(d_KEY_13map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT13);
main_7<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TB>>>(d_BUF_10, d_BUF_5, d_BUF_8, d_HT_10.ref(cuco::find), d_HT_13.ref(cuco::insert_and_find), d_HT_5.ref(cuco::find), d_HT_8.ref(cuco::find), d_KEY_13map0__tmp_attr0, d_KEY_13nation__n_name_encoded, d_SLOT_COUNT_13, d_aggr0__tmp_attr2, d_cycles_per_warp_main_7_aggregation_13, d_cycles_per_warp_main_7_join_probe_10, d_cycles_per_warp_main_7_join_probe_5, d_cycles_per_warp_main_7_join_probe_8, d_cycles_per_warp_main_7_map_11, d_cycles_per_warp_main_7_map_12, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_partkey, d_lineitem__l_quantity, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name_encoded, d_orders__o_orderdate, d_partsupp__ps_supplycost);
int64_t* cycles_per_warp_main_7_join_probe_5 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_probe_5_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_probe_5, d_cycles_per_warp_main_7_join_probe_5, sizeof(int64_t) * main_7_join_probe_5_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_probe_5 ";
for (auto i=0ull; i < main_7_join_probe_5_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_probe_5[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_join_probe_8 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_probe_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_probe_8, d_cycles_per_warp_main_7_join_probe_8, sizeof(int64_t) * main_7_join_probe_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_probe_8 ";
for (auto i=0ull; i < main_7_join_probe_8_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_probe_8[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_join_probe_10 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_probe_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_probe_10, d_cycles_per_warp_main_7_join_probe_10, sizeof(int64_t) * main_7_join_probe_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_probe_10 ";
for (auto i=0ull; i < main_7_join_probe_10_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_probe_10[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_map_11 = (int64_t*)malloc(sizeof(int64_t) * main_7_map_11_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_map_11, d_cycles_per_warp_main_7_map_11, sizeof(int64_t) * main_7_map_11_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_map_11 ";
for (auto i=0ull; i < main_7_map_11_cpw_size; i++) std::cout << cycles_per_warp_main_7_map_11[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_map_12 = (int64_t*)malloc(sizeof(int64_t) * main_7_map_12_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_map_12, d_cycles_per_warp_main_7_map_12, sizeof(int64_t) * main_7_map_12_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_map_12 ";
for (auto i=0ull; i < main_7_map_12_cpw_size; i++) std::cout << cycles_per_warp_main_7_map_12[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_aggregation_13 = (int64_t*)malloc(sizeof(int64_t) * main_7_aggregation_13_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_aggregation_13, d_cycles_per_warp_main_7_aggregation_13, sizeof(int64_t) * main_7_aggregation_13_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_aggregation_13 ";
for (auto i=0ull; i < main_7_aggregation_13_cpw_size; i++) std::cout << cycles_per_warp_main_7_aggregation_13[i] << " ";
std::cout << std::endl;
COUNT13 = d_HT_13.size();
int64_t* d_cycles_per_warp_main_15_materialize_14;
auto main_15_materialize_14_cpw_size = std::ceil((float)COUNT13/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_15_materialize_14, sizeof(int64_t) * main_15_materialize_14_cpw_size);
cudaMemset(d_cycles_per_warp_main_15_materialize_14, -1, sizeof(int64_t) * main_15_materialize_14_cpw_size);
size_t COUNT14 = COUNT13;
//Materialize buffers
uint64_t* d_MAT_IDX14;
cudaMalloc(&d_MAT_IDX14, sizeof(uint64_t));
cudaMemset(d_MAT_IDX14, 0, sizeof(uint64_t));
auto MAT14nation__n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT14);
DBI16Type* d_MAT14nation__n_name_encoded;
cudaMalloc(&d_MAT14nation__n_name_encoded, sizeof(DBI16Type) * COUNT14);
auto MAT14map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT14);
DBI64Type* d_MAT14map0__tmp_attr0;
cudaMalloc(&d_MAT14map0__tmp_attr0, sizeof(DBI64Type) * COUNT14);
auto MAT14aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT14);
DBDecimalType* d_MAT14aggr0__tmp_attr2;
cudaMalloc(&d_MAT14aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT14);
main_15<<<std::ceil((float)COUNT13/(float)TILE_SIZE), TB>>>(COUNT13, d_MAT14aggr0__tmp_attr2, d_MAT14map0__tmp_attr0, d_MAT14nation__n_name_encoded, d_MAT_IDX14, d_aggr0__tmp_attr2, d_cycles_per_warp_main_15_materialize_14, d_KEY_13map0__tmp_attr0, d_KEY_13nation__n_name_encoded);
uint64_t MATCOUNT_14 = 0;
cudaMemcpy(&MATCOUNT_14, d_MAT_IDX14, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT14nation__n_name_encoded, d_MAT14nation__n_name_encoded, sizeof(DBI16Type) * COUNT14, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT14map0__tmp_attr0, d_MAT14map0__tmp_attr0, sizeof(DBI64Type) * COUNT14, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT14aggr0__tmp_attr2, d_MAT14aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT14, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_15_materialize_14 = (int64_t*)malloc(sizeof(int64_t) * main_15_materialize_14_cpw_size);
cudaMemcpy(cycles_per_warp_main_15_materialize_14, d_cycles_per_warp_main_15_materialize_14, sizeof(int64_t) * main_15_materialize_14_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_15_materialize_14 ";
for (auto i=0ull; i < main_15_materialize_14_cpw_size; i++) std::cout << cycles_per_warp_main_15_materialize_14[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_0);
cudaFree(d_BUF_IDX_0);
cudaFree(d_BUF_3);
cudaFree(d_BUF_IDX_3);
cudaFree(d_BUF_5);
cudaFree(d_BUF_IDX_5);
cudaFree(d_BUF_8);
cudaFree(d_BUF_IDX_8);
cudaFree(d_BUF_10);
cudaFree(d_BUF_IDX_10);
cudaFree(d_KEY_13map0__tmp_attr0);
cudaFree(d_KEY_13nation__n_name_encoded);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_MAT14aggr0__tmp_attr2);
cudaFree(d_MAT14map0__tmp_attr0);
cudaFree(d_MAT14nation__n_name_encoded);
cudaFree(d_MAT_IDX14);
free(MAT14aggr0__tmp_attr2);
free(MAT14map0__tmp_attr0);
free(MAT14nation__n_name_encoded);
}