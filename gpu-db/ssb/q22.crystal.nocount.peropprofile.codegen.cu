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
__global__ void main_11(uint64_t* BUF_22, uint64_t* BUF_IDX_22, HASHTABLE_INSERT HT_22, int64_t* cycles_per_warp_main_11_join_build_22, int64_t* cycles_per_warp_main_11_selection_10, int64_t* cycles_per_warp_main_11_selection_12, int64_t* cycles_per_warp_main_11_selection_13, int64_t* cycles_per_warp_main_11_selection_14, int64_t* cycles_per_warp_main_11_selection_15, DBStringType* part__p_brand1, DBI32Type* part__p_partkey, size_t part_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_part__p_brand1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_brand1[ITEM] = part__p_brand1[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_part__p_brand1[ITEM], "MFGR#2221", Predicate::gte) && evaluatePredicate(reg_part__p_brand1[ITEM], "MFGR#2228", Predicate::lte);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_selection_10[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_selection_12[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_selection_13[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_selection_14[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_selection_15[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_22[ITEMS_PER_THREAD];
DBI32Type reg_part__p_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_partkey[ITEM] = part__p_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_22[ITEM] = 0;
KEY_22[ITEM] |= reg_part__p_partkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_22.insert(cuco::pair{KEY_22[ITEM], ITEM*TB + tid});
BUF_22[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_join_build_22[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_17(uint64_t* BUF_23, uint64_t* BUF_IDX_23, HASHTABLE_INSERT HT_23, int64_t* cycles_per_warp_main_17_join_build_23, int64_t* cycles_per_warp_main_17_selection_16, int64_t* cycles_per_warp_main_17_selection_18, int64_t* cycles_per_warp_main_17_selection_19, int64_t* cycles_per_warp_main_17_selection_20, int64_t* cycles_per_warp_main_17_selection_21, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_supplier__s_region[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_region[ITEM] = supplier__s_region[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_supplier__s_region[ITEM], "ASIA", Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_selection_16[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_selection_18[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_selection_19[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_selection_20[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_selection_21[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_23[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_23[ITEM] = 0;
KEY_23[ITEM] |= reg_supplier__s_suppkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_23.insert(cuco::pair{KEY_23[ITEM], ITEM*TB + tid});
BUF_23[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_join_build_23[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_8(uint64_t* BUF_24, uint64_t* BUF_IDX_24, HASHTABLE_INSERT HT_24, int64_t* cycles_per_warp_main_8_join_build_24, int64_t* cycles_per_warp_main_8_selection_7, int64_t* cycles_per_warp_main_8_selection_9, DBI32Type* date__d_datekey, size_t date_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_8_selection_7[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_8_selection_9[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_24[ITEMS_PER_THREAD];
DBI32Type reg_date__d_datekey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
reg_date__d_datekey[ITEM] = date__d_datekey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_24[ITEM] = 0;
KEY_24[ITEM] |= reg_date__d_datekey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_24.insert(cuco::pair{KEY_24[ITEM], ITEM*TB + tid});
BUF_24[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_8_join_build_24[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_1(uint64_t* BUF_22, uint64_t* BUF_23, uint64_t* BUF_24, HASHTABLE_PROBE HT_22, HASHTABLE_PROBE HT_23, HASHTABLE_PROBE HT_24, HASHTABLE_FIND HT_25, DBI32Type* KEY_25date__d_year, DBI16Type* KEY_25part__p_brand1_encoded, int* SLOT_COUNT_25, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_1_aggregation_25, int64_t* cycles_per_warp_main_1_join_probe_22, int64_t* cycles_per_warp_main_1_join_probe_23, int64_t* cycles_per_warp_main_1_join_probe_24, int64_t* cycles_per_warp_main_1_selection_0, int64_t* cycles_per_warp_main_1_selection_2, int64_t* cycles_per_warp_main_1_selection_3, int64_t* cycles_per_warp_main_1_selection_4, int64_t* cycles_per_warp_main_1_selection_5, int64_t* cycles_per_warp_main_1_selection_6, DBI32Type* date__d_year, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* part__p_brand1_encoded) {
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_3[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_5[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_6[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_22[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_partkey[ITEM] = lineorder__lo_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_22[ITEM] = 0;
KEY_22[ITEM] |= reg_lineorder__lo_partkey[ITEM];
}
//Probe Hash table
int64_t slot_second22[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_22 = HT_22.find(KEY_22[ITEM]);
if (SLOT_22 == HT_22.end()) {selection_flags[ITEM] = 0; continue;}
slot_second22[ITEM] = SLOT_22->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_probe_22[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_23[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_suppkey[ITEM] = lineorder__lo_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_23[ITEM] = 0;
KEY_23[ITEM] |= reg_lineorder__lo_suppkey[ITEM];
}
//Probe Hash table
int64_t slot_second23[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_23 = HT_23.find(KEY_23[ITEM]);
if (SLOT_23 == HT_23.end()) {selection_flags[ITEM] = 0; continue;}
slot_second23[ITEM] = SLOT_23->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_probe_23[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_24[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_orderdate[ITEM] = lineorder__lo_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_24[ITEM] = 0;
KEY_24[ITEM] |= reg_lineorder__lo_orderdate[ITEM];
}
//Probe Hash table
int64_t slot_second24[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_24 = HT_24.find(KEY_24[ITEM]);
if (SLOT_24 == HT_24.end()) {selection_flags[ITEM] = 0; continue;}
slot_second24[ITEM] = SLOT_24->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_probe_24[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_25[ITEMS_PER_THREAD];
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_date__d_year[ITEM] = date__d_year[BUF_24[slot_second24[ITEM] * 1 + 0]];
}
DBI16Type reg_part__p_brand1_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_brand1_encoded[ITEM] = part__p_brand1_encoded[BUF_22[slot_second22[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_25[ITEM] = 0;
KEY_25[ITEM] |= reg_date__d_year[ITEM];
KEY_25[ITEM] <<= 16;
KEY_25[ITEM] |= reg_part__p_brand1_encoded[ITEM];
}
//Aggregate in hashtable
DBDecimalType reg_lineorder__lo_revenue[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_revenue[ITEM] = lineorder__lo_revenue[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_25 = get_aggregation_slot(KEY_25[ITEM], HT_25, SLOT_COUNT_25);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_25], reg_lineorder__lo_revenue[ITEM]);
KEY_25date__d_year[buf_idx_25] = reg_date__d_year[ITEM];
KEY_25part__p_brand1_encoded[buf_idx_25] = reg_part__p_brand1_encoded[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_aggregation_25[blockIdx.x] = cycles_per_warp;}
}
__global__ void main_27(size_t COUNT25, DBDecimalType* MAT26aggr0__tmp_attr0, DBI32Type* MAT26date__d_year, DBI16Type* MAT26part__p_brand1_encoded, uint64_t* MAT_IDX26, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_27_materialize_26, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT25); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT25); ++ITEM) {
reg_date__d_year[ITEM] = date__d_year[ITEM*TB + tid];
}
DBI16Type reg_part__p_brand1_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT25); ++ITEM) {
reg_part__p_brand1_encoded[ITEM] = part__p_brand1_encoded[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT25); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx26 = atomicAdd((int*)MAT_IDX26, 1);
MAT26aggr0__tmp_attr0[mat_idx26] = reg_aggr0__tmp_attr0[ITEM];
MAT26date__d_year[mat_idx26] = reg_date__d_year[ITEM];
MAT26part__p_brand1_encoded[mat_idx26] = reg_part__p_brand1_encoded[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_27_materialize_26[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_11_selection_10;
auto main_11_selection_10_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_selection_10, sizeof(int64_t) * main_11_selection_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_selection_10, -1, sizeof(int64_t) * main_11_selection_10_cpw_size);
int64_t* d_cycles_per_warp_main_11_selection_12;
auto main_11_selection_12_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_selection_12, sizeof(int64_t) * main_11_selection_12_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_selection_12, -1, sizeof(int64_t) * main_11_selection_12_cpw_size);
int64_t* d_cycles_per_warp_main_11_selection_13;
auto main_11_selection_13_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_selection_13, sizeof(int64_t) * main_11_selection_13_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_selection_13, -1, sizeof(int64_t) * main_11_selection_13_cpw_size);
int64_t* d_cycles_per_warp_main_11_selection_14;
auto main_11_selection_14_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_selection_14, sizeof(int64_t) * main_11_selection_14_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_selection_14, -1, sizeof(int64_t) * main_11_selection_14_cpw_size);
int64_t* d_cycles_per_warp_main_11_selection_15;
auto main_11_selection_15_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_selection_15, sizeof(int64_t) * main_11_selection_15_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_selection_15, -1, sizeof(int64_t) * main_11_selection_15_cpw_size);
int64_t* d_cycles_per_warp_main_11_join_build_22;
auto main_11_join_build_22_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_join_build_22, sizeof(int64_t) * main_11_join_build_22_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_join_build_22, -1, sizeof(int64_t) * main_11_join_build_22_cpw_size);
size_t COUNT22 = part_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_22;
cudaMalloc(&d_BUF_IDX_22, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_22, 0, sizeof(uint64_t));
uint64_t* d_BUF_22;
cudaMalloc(&d_BUF_22, sizeof(uint64_t) * COUNT22 * 1);
auto d_HT_22 = cuco::static_map{ (int)COUNT22*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_11<<<std::ceil((float)part_size/(float)TILE_SIZE), TB>>>(d_BUF_22, d_BUF_IDX_22, d_HT_22.ref(cuco::insert), d_cycles_per_warp_main_11_join_build_22, d_cycles_per_warp_main_11_selection_10, d_cycles_per_warp_main_11_selection_12, d_cycles_per_warp_main_11_selection_13, d_cycles_per_warp_main_11_selection_14, d_cycles_per_warp_main_11_selection_15, d_part__p_brand1, d_part__p_partkey, part_size);
int64_t* cycles_per_warp_main_11_selection_10 = (int64_t*)malloc(sizeof(int64_t) * main_11_selection_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_selection_10, d_cycles_per_warp_main_11_selection_10, sizeof(int64_t) * main_11_selection_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_selection_10 ";
for (auto i=0ull; i < main_11_selection_10_cpw_size; i++) std::cout << cycles_per_warp_main_11_selection_10[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_11_selection_12 = (int64_t*)malloc(sizeof(int64_t) * main_11_selection_12_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_selection_12, d_cycles_per_warp_main_11_selection_12, sizeof(int64_t) * main_11_selection_12_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_selection_12 ";
for (auto i=0ull; i < main_11_selection_12_cpw_size; i++) std::cout << cycles_per_warp_main_11_selection_12[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_11_selection_13 = (int64_t*)malloc(sizeof(int64_t) * main_11_selection_13_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_selection_13, d_cycles_per_warp_main_11_selection_13, sizeof(int64_t) * main_11_selection_13_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_selection_13 ";
for (auto i=0ull; i < main_11_selection_13_cpw_size; i++) std::cout << cycles_per_warp_main_11_selection_13[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_11_selection_14 = (int64_t*)malloc(sizeof(int64_t) * main_11_selection_14_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_selection_14, d_cycles_per_warp_main_11_selection_14, sizeof(int64_t) * main_11_selection_14_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_selection_14 ";
for (auto i=0ull; i < main_11_selection_14_cpw_size; i++) std::cout << cycles_per_warp_main_11_selection_14[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_11_selection_15 = (int64_t*)malloc(sizeof(int64_t) * main_11_selection_15_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_selection_15, d_cycles_per_warp_main_11_selection_15, sizeof(int64_t) * main_11_selection_15_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_selection_15 ";
for (auto i=0ull; i < main_11_selection_15_cpw_size; i++) std::cout << cycles_per_warp_main_11_selection_15[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_11_join_build_22 = (int64_t*)malloc(sizeof(int64_t) * main_11_join_build_22_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_join_build_22, d_cycles_per_warp_main_11_join_build_22, sizeof(int64_t) * main_11_join_build_22_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_join_build_22 ";
for (auto i=0ull; i < main_11_join_build_22_cpw_size; i++) std::cout << cycles_per_warp_main_11_join_build_22[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_17_selection_16;
auto main_17_selection_16_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_selection_16, sizeof(int64_t) * main_17_selection_16_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_selection_16, -1, sizeof(int64_t) * main_17_selection_16_cpw_size);
int64_t* d_cycles_per_warp_main_17_selection_18;
auto main_17_selection_18_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_selection_18, sizeof(int64_t) * main_17_selection_18_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_selection_18, -1, sizeof(int64_t) * main_17_selection_18_cpw_size);
int64_t* d_cycles_per_warp_main_17_selection_19;
auto main_17_selection_19_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_selection_19, sizeof(int64_t) * main_17_selection_19_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_selection_19, -1, sizeof(int64_t) * main_17_selection_19_cpw_size);
int64_t* d_cycles_per_warp_main_17_selection_20;
auto main_17_selection_20_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_selection_20, sizeof(int64_t) * main_17_selection_20_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_selection_20, -1, sizeof(int64_t) * main_17_selection_20_cpw_size);
int64_t* d_cycles_per_warp_main_17_selection_21;
auto main_17_selection_21_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_selection_21, sizeof(int64_t) * main_17_selection_21_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_selection_21, -1, sizeof(int64_t) * main_17_selection_21_cpw_size);
int64_t* d_cycles_per_warp_main_17_join_build_23;
auto main_17_join_build_23_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_join_build_23, sizeof(int64_t) * main_17_join_build_23_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_join_build_23, -1, sizeof(int64_t) * main_17_join_build_23_cpw_size);
size_t COUNT23 = supplier_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_23;
cudaMalloc(&d_BUF_IDX_23, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_23, 0, sizeof(uint64_t));
uint64_t* d_BUF_23;
cudaMalloc(&d_BUF_23, sizeof(uint64_t) * COUNT23 * 1);
auto d_HT_23 = cuco::static_map{ (int)COUNT23*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_17<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TB>>>(d_BUF_23, d_BUF_IDX_23, d_HT_23.ref(cuco::insert), d_cycles_per_warp_main_17_join_build_23, d_cycles_per_warp_main_17_selection_16, d_cycles_per_warp_main_17_selection_18, d_cycles_per_warp_main_17_selection_19, d_cycles_per_warp_main_17_selection_20, d_cycles_per_warp_main_17_selection_21, d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
int64_t* cycles_per_warp_main_17_selection_16 = (int64_t*)malloc(sizeof(int64_t) * main_17_selection_16_cpw_size);
cudaMemcpy(cycles_per_warp_main_17_selection_16, d_cycles_per_warp_main_17_selection_16, sizeof(int64_t) * main_17_selection_16_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_17_selection_16 ";
for (auto i=0ull; i < main_17_selection_16_cpw_size; i++) std::cout << cycles_per_warp_main_17_selection_16[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_17_selection_18 = (int64_t*)malloc(sizeof(int64_t) * main_17_selection_18_cpw_size);
cudaMemcpy(cycles_per_warp_main_17_selection_18, d_cycles_per_warp_main_17_selection_18, sizeof(int64_t) * main_17_selection_18_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_17_selection_18 ";
for (auto i=0ull; i < main_17_selection_18_cpw_size; i++) std::cout << cycles_per_warp_main_17_selection_18[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_17_selection_19 = (int64_t*)malloc(sizeof(int64_t) * main_17_selection_19_cpw_size);
cudaMemcpy(cycles_per_warp_main_17_selection_19, d_cycles_per_warp_main_17_selection_19, sizeof(int64_t) * main_17_selection_19_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_17_selection_19 ";
for (auto i=0ull; i < main_17_selection_19_cpw_size; i++) std::cout << cycles_per_warp_main_17_selection_19[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_17_selection_20 = (int64_t*)malloc(sizeof(int64_t) * main_17_selection_20_cpw_size);
cudaMemcpy(cycles_per_warp_main_17_selection_20, d_cycles_per_warp_main_17_selection_20, sizeof(int64_t) * main_17_selection_20_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_17_selection_20 ";
for (auto i=0ull; i < main_17_selection_20_cpw_size; i++) std::cout << cycles_per_warp_main_17_selection_20[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_17_selection_21 = (int64_t*)malloc(sizeof(int64_t) * main_17_selection_21_cpw_size);
cudaMemcpy(cycles_per_warp_main_17_selection_21, d_cycles_per_warp_main_17_selection_21, sizeof(int64_t) * main_17_selection_21_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_17_selection_21 ";
for (auto i=0ull; i < main_17_selection_21_cpw_size; i++) std::cout << cycles_per_warp_main_17_selection_21[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_17_join_build_23 = (int64_t*)malloc(sizeof(int64_t) * main_17_join_build_23_cpw_size);
cudaMemcpy(cycles_per_warp_main_17_join_build_23, d_cycles_per_warp_main_17_join_build_23, sizeof(int64_t) * main_17_join_build_23_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_17_join_build_23 ";
for (auto i=0ull; i < main_17_join_build_23_cpw_size; i++) std::cout << cycles_per_warp_main_17_join_build_23[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_8_selection_7;
auto main_8_selection_7_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_8_selection_7, sizeof(int64_t) * main_8_selection_7_cpw_size);
cudaMemset(d_cycles_per_warp_main_8_selection_7, -1, sizeof(int64_t) * main_8_selection_7_cpw_size);
int64_t* d_cycles_per_warp_main_8_selection_9;
auto main_8_selection_9_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_8_selection_9, sizeof(int64_t) * main_8_selection_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_8_selection_9, -1, sizeof(int64_t) * main_8_selection_9_cpw_size);
int64_t* d_cycles_per_warp_main_8_join_build_24;
auto main_8_join_build_24_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_8_join_build_24, sizeof(int64_t) * main_8_join_build_24_cpw_size);
cudaMemset(d_cycles_per_warp_main_8_join_build_24, -1, sizeof(int64_t) * main_8_join_build_24_cpw_size);
size_t COUNT24 = date_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_24;
cudaMalloc(&d_BUF_IDX_24, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_24, 0, sizeof(uint64_t));
uint64_t* d_BUF_24;
cudaMalloc(&d_BUF_24, sizeof(uint64_t) * COUNT24 * 1);
auto d_HT_24 = cuco::static_map{ (int)COUNT24*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_8<<<std::ceil((float)date_size/(float)TILE_SIZE), TB>>>(d_BUF_24, d_BUF_IDX_24, d_HT_24.ref(cuco::insert), d_cycles_per_warp_main_8_join_build_24, d_cycles_per_warp_main_8_selection_7, d_cycles_per_warp_main_8_selection_9, d_date__d_datekey, date_size);
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
int64_t* cycles_per_warp_main_8_join_build_24 = (int64_t*)malloc(sizeof(int64_t) * main_8_join_build_24_cpw_size);
cudaMemcpy(cycles_per_warp_main_8_join_build_24, d_cycles_per_warp_main_8_join_build_24, sizeof(int64_t) * main_8_join_build_24_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_8_join_build_24 ";
for (auto i=0ull; i < main_8_join_build_24_cpw_size; i++) std::cout << cycles_per_warp_main_8_join_build_24[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_2;
auto main_1_selection_2_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_2, sizeof(int64_t) * main_1_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_2, -1, sizeof(int64_t) * main_1_selection_2_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_3;
auto main_1_selection_3_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_3, sizeof(int64_t) * main_1_selection_3_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_3, -1, sizeof(int64_t) * main_1_selection_3_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_4;
auto main_1_selection_4_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_4, sizeof(int64_t) * main_1_selection_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_4, -1, sizeof(int64_t) * main_1_selection_4_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_5;
auto main_1_selection_5_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_5, sizeof(int64_t) * main_1_selection_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_5, -1, sizeof(int64_t) * main_1_selection_5_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_6;
auto main_1_selection_6_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_6, sizeof(int64_t) * main_1_selection_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_6, -1, sizeof(int64_t) * main_1_selection_6_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_probe_22;
auto main_1_join_probe_22_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_probe_22, sizeof(int64_t) * main_1_join_probe_22_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_probe_22, -1, sizeof(int64_t) * main_1_join_probe_22_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_probe_23;
auto main_1_join_probe_23_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_probe_23, sizeof(int64_t) * main_1_join_probe_23_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_probe_23, -1, sizeof(int64_t) * main_1_join_probe_23_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_probe_24;
auto main_1_join_probe_24_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_probe_24, sizeof(int64_t) * main_1_join_probe_24_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_probe_24, -1, sizeof(int64_t) * main_1_join_probe_24_cpw_size);
int64_t* d_cycles_per_warp_main_1_aggregation_25;
auto main_1_aggregation_25_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_aggregation_25, sizeof(int64_t) * main_1_aggregation_25_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_aggregation_25, -1, sizeof(int64_t) * main_1_aggregation_25_cpw_size);
size_t COUNT25 = 3846;
auto d_HT_25 = cuco::static_map{ (int)3846*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_25;
cudaMalloc(&d_SLOT_COUNT_25, sizeof(int));
cudaMemset(d_SLOT_COUNT_25, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT25);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT25);
DBI32Type* d_KEY_25date__d_year;
cudaMalloc(&d_KEY_25date__d_year, sizeof(DBI32Type) * COUNT25);
cudaMemset(d_KEY_25date__d_year, 0, sizeof(DBI32Type) * COUNT25);
DBI16Type* d_KEY_25part__p_brand1_encoded;
cudaMalloc(&d_KEY_25part__p_brand1_encoded, sizeof(DBI16Type) * COUNT25);
cudaMemset(d_KEY_25part__p_brand1_encoded, 0, sizeof(DBI16Type) * COUNT25);
main_1<<<std::ceil((float)lineorder_size/(float)TILE_SIZE), TB>>>(d_BUF_22, d_BUF_23, d_BUF_24, d_HT_22.ref(cuco::find), d_HT_23.ref(cuco::find), d_HT_24.ref(cuco::find), d_HT_25.ref(cuco::insert_and_find), d_KEY_25date__d_year, d_KEY_25part__p_brand1_encoded, d_SLOT_COUNT_25, d_aggr0__tmp_attr0, d_cycles_per_warp_main_1_aggregation_25, d_cycles_per_warp_main_1_join_probe_22, d_cycles_per_warp_main_1_join_probe_23, d_cycles_per_warp_main_1_join_probe_24, d_cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_2, d_cycles_per_warp_main_1_selection_3, d_cycles_per_warp_main_1_selection_4, d_cycles_per_warp_main_1_selection_5, d_cycles_per_warp_main_1_selection_6, d_date__d_year, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_part__p_brand1_encoded);
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
int64_t* cycles_per_warp_main_1_selection_4 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_4, d_cycles_per_warp_main_1_selection_4, sizeof(int64_t) * main_1_selection_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_4 ";
for (auto i=0ull; i < main_1_selection_4_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_4[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_selection_5 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_5_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_5, d_cycles_per_warp_main_1_selection_5, sizeof(int64_t) * main_1_selection_5_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_5 ";
for (auto i=0ull; i < main_1_selection_5_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_5[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_selection_6 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_6, d_cycles_per_warp_main_1_selection_6, sizeof(int64_t) * main_1_selection_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_6 ";
for (auto i=0ull; i < main_1_selection_6_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_6[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_probe_22 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_probe_22_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_probe_22, d_cycles_per_warp_main_1_join_probe_22, sizeof(int64_t) * main_1_join_probe_22_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_probe_22 ";
for (auto i=0ull; i < main_1_join_probe_22_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_probe_22[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_probe_23 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_probe_23_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_probe_23, d_cycles_per_warp_main_1_join_probe_23, sizeof(int64_t) * main_1_join_probe_23_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_probe_23 ";
for (auto i=0ull; i < main_1_join_probe_23_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_probe_23[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_probe_24 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_probe_24_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_probe_24, d_cycles_per_warp_main_1_join_probe_24, sizeof(int64_t) * main_1_join_probe_24_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_probe_24 ";
for (auto i=0ull; i < main_1_join_probe_24_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_probe_24[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_aggregation_25 = (int64_t*)malloc(sizeof(int64_t) * main_1_aggregation_25_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_aggregation_25, d_cycles_per_warp_main_1_aggregation_25, sizeof(int64_t) * main_1_aggregation_25_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_aggregation_25 ";
for (auto i=0ull; i < main_1_aggregation_25_cpw_size; i++) std::cout << cycles_per_warp_main_1_aggregation_25[i] << " ";
std::cout << std::endl;
COUNT25 = d_HT_25.size();
int64_t* d_cycles_per_warp_main_27_materialize_26;
auto main_27_materialize_26_cpw_size = std::ceil((float)COUNT25/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_27_materialize_26, sizeof(int64_t) * main_27_materialize_26_cpw_size);
cudaMemset(d_cycles_per_warp_main_27_materialize_26, -1, sizeof(int64_t) * main_27_materialize_26_cpw_size);
size_t COUNT26 = COUNT25;
//Materialize buffers
uint64_t* d_MAT_IDX26;
cudaMalloc(&d_MAT_IDX26, sizeof(uint64_t));
cudaMemset(d_MAT_IDX26, 0, sizeof(uint64_t));
auto MAT26aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT26);
DBDecimalType* d_MAT26aggr0__tmp_attr0;
cudaMalloc(&d_MAT26aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT26);
auto MAT26date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT26);
DBI32Type* d_MAT26date__d_year;
cudaMalloc(&d_MAT26date__d_year, sizeof(DBI32Type) * COUNT26);
auto MAT26part__p_brand1_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT26);
DBI16Type* d_MAT26part__p_brand1_encoded;
cudaMalloc(&d_MAT26part__p_brand1_encoded, sizeof(DBI16Type) * COUNT26);
main_27<<<std::ceil((float)COUNT25/(float)TILE_SIZE), TB>>>(COUNT25, d_MAT26aggr0__tmp_attr0, d_MAT26date__d_year, d_MAT26part__p_brand1_encoded, d_MAT_IDX26, d_aggr0__tmp_attr0, d_cycles_per_warp_main_27_materialize_26, d_KEY_25date__d_year, d_KEY_25part__p_brand1_encoded);
uint64_t MATCOUNT_26 = 0;
cudaMemcpy(&MATCOUNT_26, d_MAT_IDX26, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT26aggr0__tmp_attr0, d_MAT26aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT26, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT26date__d_year, d_MAT26date__d_year, sizeof(DBI32Type) * COUNT26, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT26part__p_brand1_encoded, d_MAT26part__p_brand1_encoded, sizeof(DBI16Type) * COUNT26, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_27_materialize_26 = (int64_t*)malloc(sizeof(int64_t) * main_27_materialize_26_cpw_size);
cudaMemcpy(cycles_per_warp_main_27_materialize_26, d_cycles_per_warp_main_27_materialize_26, sizeof(int64_t) * main_27_materialize_26_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_27_materialize_26 ";
for (auto i=0ull; i < main_27_materialize_26_cpw_size; i++) std::cout << cycles_per_warp_main_27_materialize_26[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_22);
cudaFree(d_BUF_IDX_22);
cudaFree(d_BUF_23);
cudaFree(d_BUF_IDX_23);
cudaFree(d_BUF_24);
cudaFree(d_BUF_IDX_24);
cudaFree(d_KEY_25date__d_year);
cudaFree(d_KEY_25part__p_brand1_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_MAT26aggr0__tmp_attr0);
cudaFree(d_MAT26date__d_year);
cudaFree(d_MAT26part__p_brand1_encoded);
cudaFree(d_MAT_IDX26);
free(MAT26aggr0__tmp_attr0);
free(MAT26date__d_year);
free(MAT26part__p_brand1_encoded);
}