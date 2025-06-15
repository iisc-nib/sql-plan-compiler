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
template<typename HASHTABLE_INSERT_SJ>
__global__ void main_3(HASHTABLE_INSERT_SJ HT_6, int64_t* cycles_per_warp_main_3_selection_2, int64_t* cycles_per_warp_main_3_semi_join_build_6, DBStringType* part__p_name, DBI32Type* part__p_partkey, size_t part_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_part__p_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_name[ITEM] = part__p_name[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= Like(reg_part__p_name[ITEM], "forest", "", nullptr, nullptr, 0);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_part__p_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_partkey[ITEM] = part__p_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_part__p_partkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_6.insert(cuco::pair{KEY_6[ITEM], 1});
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_semi_join_build_6[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE_SJ, typename HASHTABLE_INSERT>
__global__ void main_7(uint64_t* BUF_8, uint64_t* BUF_IDX_8, HASHTABLE_PROBE_SJ HT_6, HASHTABLE_INSERT HT_8, int64_t* cycles_per_warp_main_7_join_build_8, int64_t* cycles_per_warp_main_7_semi_join_probe_6, DBI32Type* partsupp__ps_partkey, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_partsupp__ps_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
reg_partsupp__ps_partkey[ITEM] = partsupp__ps_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_partsupp__ps_partkey[ITEM];
}
//Probe Hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_6 = HT_6.find(KEY_6[ITEM]);
if (SLOT_6 == HT_6.end()) {selection_flags[ITEM] = 0;}
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_semi_join_probe_6[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_8[ITEMS_PER_THREAD];
DBI32Type reg_partsupp__ps_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
reg_partsupp__ps_suppkey[ITEM] = partsupp__ps_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_partsupp__ps_partkey[ITEM];
KEY_8[ITEM] <<= 32;
KEY_8[ITEM] |= reg_partsupp__ps_suppkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_8.insert(cuco::pair{KEY_8[ITEM], ITEM*TB + tid});
BUF_8[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_build_8[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_5(uint64_t* BUF_8, HASHTABLE_PROBE HT_8, HASHTABLE_FIND HT_9, DBI32Type* KEY_9lineitem__l_partkey, DBI32Type* KEY_9lineitem__l_suppkey, int* SLOT_COUNT_9, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_5_aggregation_9, int64_t* cycles_per_warp_main_5_join_probe_8, int64_t* cycles_per_warp_main_5_selection_4, DBI32Type* lineitem__l_partkey, DBDecimalType* lineitem__l_quantity, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBI32Type* moved_aggr__ps_suppkey, DBI32Type* moved_aggr_u_1__ps_availqty, DBI32Type* moved_aggr_u_2__ps_partkey, DBI32Type* partsupp__ps_availqty, DBI32Type* partsupp__ps_partkey, DBI32Type* partsupp__ps_suppkey) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBDateType reg_lineitem__l_shipdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_shipdate[ITEM] = lineitem__l_shipdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_shipdate[ITEM], 8766, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate[ITEM], 9131, Predicate::lt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_8[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_partkey[ITEM] = lineitem__l_partkey[ITEM*TB + tid];
}
DBI32Type reg_lineitem__l_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_suppkey[ITEM] = lineitem__l_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_lineitem__l_partkey[ITEM];
KEY_8[ITEM] <<= 32;
KEY_8[ITEM] |= reg_lineitem__l_suppkey[ITEM];
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_join_probe_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_9[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_9[ITEM] = 0;
KEY_9[ITEM] |= reg_lineitem__l_suppkey[ITEM];
KEY_9[ITEM] <<= 32;
KEY_9[ITEM] |= reg_lineitem__l_partkey[ITEM];
}
//Aggregate in hashtable
DBDecimalType reg_lineitem__l_quantity[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_quantity[ITEM] = lineitem__l_quantity[ITEM*TB + tid];
}
DBI32Type reg_partsupp__ps_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_partsupp__ps_suppkey[ITEM] = partsupp__ps_suppkey[BUF_8[slot_second8[ITEM] * 1 + 0]];
}
DBI32Type reg_partsupp__ps_availqty[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_partsupp__ps_availqty[ITEM] = partsupp__ps_availqty[BUF_8[slot_second8[ITEM] * 1 + 0]];
}
DBI32Type reg_partsupp__ps_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_partsupp__ps_partkey[ITEM] = partsupp__ps_partkey[BUF_8[slot_second8[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_9 = get_aggregation_slot(KEY_9[ITEM], HT_9, SLOT_COUNT_9);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_9], reg_lineitem__l_quantity[ITEM]);
aggregate_any(&moved_aggr__ps_suppkey[buf_idx_9], reg_partsupp__ps_suppkey[ITEM]);
aggregate_any(&moved_aggr_u_1__ps_availqty[buf_idx_9], reg_partsupp__ps_availqty[ITEM]);
aggregate_any(&moved_aggr_u_2__ps_partkey[buf_idx_9], reg_partsupp__ps_partkey[ITEM]);
KEY_9lineitem__l_suppkey[buf_idx_9] = reg_lineitem__l_suppkey[ITEM];
KEY_9lineitem__l_partkey[buf_idx_9] = reg_lineitem__l_partkey[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_aggregation_9[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_10, uint64_t* BUF_IDX_10, HASHTABLE_INSERT HT_10, int64_t* cycles_per_warp_main_1_join_build_10, int64_t* cycles_per_warp_main_1_selection_0, DBStringType* nation__n_name, DBI32Type* nation__n_nationkey, size_t nation_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_nation__n_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_nation__n_name[ITEM] = nation__n_name[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_nation__n_name[ITEM], "CANADA", Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_10[ITEMS_PER_THREAD];
DBI32Type reg_nation__n_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_nation__n_nationkey[ITEM] = nation__n_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_10[ITEM] = 0;
KEY_10[ITEM] |= reg_nation__n_nationkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_10.insert(cuco::pair{KEY_10[ITEM], ITEM*TB + tid});
BUF_10[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_build_10[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT_SJ>
__global__ void main_13(size_t COUNT9, HASHTABLE_INSERT_SJ HT_16, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_13_map_12, int64_t* cycles_per_warp_main_13_selection_14, int64_t* cycles_per_warp_main_13_selection_15, int64_t* cycles_per_warp_main_13_semi_join_build_16, DBI32Type* moved_aggr__ps_suppkey, DBI32Type* moved_aggr_u_1__ps_availqty, DBI32Type* moved_aggr_u_2__ps_partkey) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_13_map_12[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_13_selection_14[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
DBI32Type reg_partsupp__ps_availqty[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_partsupp__ps_availqty[ITEM] = moved_aggr_u_1__ps_availqty[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
DBDecimalType reg_map0__tmp_attr1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr1[ITEM] = (0.5) * (reg_aggr0__tmp_attr0[ITEM]);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((true) && (evaluatePredicate(((DBDecimalType)reg_partsupp__ps_availqty[ITEM]), reg_map0__tmp_attr1[ITEM], Predicate::gt))) && (true);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_13_selection_15[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_16[ITEMS_PER_THREAD];
DBI32Type reg_partsupp__ps_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_partsupp__ps_suppkey[ITEM] = moved_aggr__ps_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_16[ITEM] = 0;
KEY_16[ITEM] |= reg_partsupp__ps_suppkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_16.insert(cuco::pair{KEY_16[ITEM], 1});
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_13_semi_join_build_16[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_PROBE_SJ>
__global__ void main_11(uint64_t* BUF_10, HASHTABLE_PROBE HT_10, HASHTABLE_PROBE_SJ HT_16, DBI16Type* MAT17supplier__s_address_encoded, DBI16Type* MAT17supplier__s_name_encoded, uint64_t* MAT_IDX17, int64_t* cycles_per_warp_main_11_join_probe_10, int64_t* cycles_per_warp_main_11_materialize_17, int64_t* cycles_per_warp_main_11_semi_join_probe_16, DBI16Type* supplier__s_address_encoded, DBI16Type* supplier__s_name_encoded, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_10[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_nationkey[ITEM] = supplier__s_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_10[ITEM] = 0;
KEY_10[ITEM] |= reg_supplier__s_nationkey[ITEM];
}
//Probe Hash table
int64_t slot_second10[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_10 = HT_10.find(KEY_10[ITEM]);
if (SLOT_10 == HT_10.end()) {selection_flags[ITEM] = 0; continue;}
slot_second10[ITEM] = SLOT_10->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_join_probe_10[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_16[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_16[ITEM] = 0;
KEY_16[ITEM] |= reg_supplier__s_suppkey[ITEM];
}
//Probe Hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_16 = HT_16.find(KEY_16[ITEM]);
if (SLOT_16 == HT_16.end()) {selection_flags[ITEM] = 0;}
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_semi_join_probe_16[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI16Type reg_supplier__s_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_name_encoded[ITEM] = supplier__s_name_encoded[ITEM*TB + tid];
}
DBI16Type reg_supplier__s_address_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_address_encoded[ITEM] = supplier__s_address_encoded[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx17 = atomicAdd((int*)MAT_IDX17, 1);
MAT17supplier__s_name_encoded[mat_idx17] = reg_supplier__s_name_encoded[ITEM];
MAT17supplier__s_address_encoded[mat_idx17] = reg_supplier__s_address_encoded[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_materialize_17[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_3_selection_2;
auto main_3_selection_2_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_selection_2, sizeof(int64_t) * main_3_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_selection_2, -1, sizeof(int64_t) * main_3_selection_2_cpw_size);
int64_t* d_cycles_per_warp_main_3_semi_join_build_6;
auto main_3_semi_join_build_6_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_semi_join_build_6, sizeof(int64_t) * main_3_semi_join_build_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_semi_join_build_6, -1, sizeof(int64_t) * main_3_semi_join_build_6_cpw_size);
size_t COUNT6 = part_size;
// Insert hash table control;
auto d_HT_6 = cuco::static_map{ (int)COUNT6*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)part_size/(float)TILE_SIZE), TB>>>(d_HT_6.ref(cuco::insert), d_cycles_per_warp_main_3_selection_2, d_cycles_per_warp_main_3_semi_join_build_6, d_part__p_name, d_part__p_partkey, part_size);
int64_t* d_cycles_per_warp_main_7_semi_join_probe_6;
auto main_7_semi_join_probe_6_cpw_size = std::ceil((float)partsupp_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_semi_join_probe_6, sizeof(int64_t) * main_7_semi_join_probe_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_semi_join_probe_6, -1, sizeof(int64_t) * main_7_semi_join_probe_6_cpw_size);
int64_t* d_cycles_per_warp_main_7_join_build_8;
auto main_7_join_build_8_cpw_size = std::ceil((float)partsupp_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_build_8, sizeof(int64_t) * main_7_join_build_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_build_8, -1, sizeof(int64_t) * main_7_join_build_8_cpw_size);
size_t COUNT8 = partsupp_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_8;
cudaMalloc(&d_BUF_IDX_8, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_8, 0, sizeof(uint64_t));
uint64_t* d_BUF_8;
cudaMalloc(&d_BUF_8, sizeof(uint64_t) * COUNT8 * 1);
auto d_HT_8 = cuco::static_map{ (int)COUNT8*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_7<<<std::ceil((float)partsupp_size/(float)TILE_SIZE), TB>>>(d_BUF_8, d_BUF_IDX_8, d_HT_6.ref(cuco::find), d_HT_8.ref(cuco::insert), d_cycles_per_warp_main_7_join_build_8, d_cycles_per_warp_main_7_semi_join_probe_6, d_partsupp__ps_partkey, d_partsupp__ps_suppkey, partsupp_size);
int64_t* cycles_per_warp_main_7_semi_join_probe_6 = (int64_t*)malloc(sizeof(int64_t) * main_7_semi_join_probe_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_semi_join_probe_6, d_cycles_per_warp_main_7_semi_join_probe_6, sizeof(int64_t) * main_7_semi_join_probe_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_semi_join_probe_6 ";
for (auto i=0ull; i < main_7_semi_join_probe_6_cpw_size; i++) std::cout << cycles_per_warp_main_7_semi_join_probe_6[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_join_build_8 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_build_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_build_8, d_cycles_per_warp_main_7_join_build_8, sizeof(int64_t) * main_7_join_build_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_build_8 ";
for (auto i=0ull; i < main_7_join_build_8_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_build_8[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_5_selection_4;
auto main_5_selection_4_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_4, sizeof(int64_t) * main_5_selection_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_4, -1, sizeof(int64_t) * main_5_selection_4_cpw_size);
int64_t* d_cycles_per_warp_main_5_join_probe_8;
auto main_5_join_probe_8_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_join_probe_8, sizeof(int64_t) * main_5_join_probe_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_join_probe_8, -1, sizeof(int64_t) * main_5_join_probe_8_cpw_size);
int64_t* d_cycles_per_warp_main_5_aggregation_9;
auto main_5_aggregation_9_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_aggregation_9, sizeof(int64_t) * main_5_aggregation_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_aggregation_9, -1, sizeof(int64_t) * main_5_aggregation_9_cpw_size);
size_t COUNT9 = 861503;
auto d_HT_9 = cuco::static_map{ (int)861503*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_9;
cudaMalloc(&d_SLOT_COUNT_9, sizeof(int));
cudaMemset(d_SLOT_COUNT_9, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT9);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT9);
DBI32Type* d_moved_aggr__ps_suppkey;
cudaMalloc(&d_moved_aggr__ps_suppkey, sizeof(DBI32Type) * COUNT9);
cudaMemset(d_moved_aggr__ps_suppkey, 0, sizeof(DBI32Type) * COUNT9);
DBI32Type* d_moved_aggr_u_1__ps_availqty;
cudaMalloc(&d_moved_aggr_u_1__ps_availqty, sizeof(DBI32Type) * COUNT9);
cudaMemset(d_moved_aggr_u_1__ps_availqty, 0, sizeof(DBI32Type) * COUNT9);
DBI32Type* d_moved_aggr_u_2__ps_partkey;
cudaMalloc(&d_moved_aggr_u_2__ps_partkey, sizeof(DBI32Type) * COUNT9);
cudaMemset(d_moved_aggr_u_2__ps_partkey, 0, sizeof(DBI32Type) * COUNT9);
DBI32Type* d_KEY_9lineitem__l_suppkey;
cudaMalloc(&d_KEY_9lineitem__l_suppkey, sizeof(DBI32Type) * COUNT9);
cudaMemset(d_KEY_9lineitem__l_suppkey, 0, sizeof(DBI32Type) * COUNT9);
DBI32Type* d_KEY_9lineitem__l_partkey;
cudaMalloc(&d_KEY_9lineitem__l_partkey, sizeof(DBI32Type) * COUNT9);
cudaMemset(d_KEY_9lineitem__l_partkey, 0, sizeof(DBI32Type) * COUNT9);
main_5<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TB>>>(d_BUF_8, d_HT_8.ref(cuco::find), d_HT_9.ref(cuco::insert_and_find), d_KEY_9lineitem__l_partkey, d_KEY_9lineitem__l_suppkey, d_SLOT_COUNT_9, d_aggr0__tmp_attr0, d_cycles_per_warp_main_5_aggregation_9, d_cycles_per_warp_main_5_join_probe_8, d_cycles_per_warp_main_5_selection_4, d_lineitem__l_partkey, d_lineitem__l_quantity, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_moved_aggr__ps_suppkey, d_moved_aggr_u_1__ps_availqty, d_moved_aggr_u_2__ps_partkey, d_partsupp__ps_availqty, d_partsupp__ps_partkey, d_partsupp__ps_suppkey);
int64_t* cycles_per_warp_main_5_selection_4 = (int64_t*)malloc(sizeof(int64_t) * main_5_selection_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_selection_4, d_cycles_per_warp_main_5_selection_4, sizeof(int64_t) * main_5_selection_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_selection_4 ";
for (auto i=0ull; i < main_5_selection_4_cpw_size; i++) std::cout << cycles_per_warp_main_5_selection_4[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_join_probe_8 = (int64_t*)malloc(sizeof(int64_t) * main_5_join_probe_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_join_probe_8, d_cycles_per_warp_main_5_join_probe_8, sizeof(int64_t) * main_5_join_probe_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_join_probe_8 ";
for (auto i=0ull; i < main_5_join_probe_8_cpw_size; i++) std::cout << cycles_per_warp_main_5_join_probe_8[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_aggregation_9 = (int64_t*)malloc(sizeof(int64_t) * main_5_aggregation_9_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_aggregation_9, d_cycles_per_warp_main_5_aggregation_9, sizeof(int64_t) * main_5_aggregation_9_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_aggregation_9 ";
for (auto i=0ull; i < main_5_aggregation_9_cpw_size; i++) std::cout << cycles_per_warp_main_5_aggregation_9[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_build_10;
auto main_1_join_build_10_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_build_10, sizeof(int64_t) * main_1_join_build_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_build_10, -1, sizeof(int64_t) * main_1_join_build_10_cpw_size);
size_t COUNT10 = nation_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_10;
cudaMalloc(&d_BUF_IDX_10, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_10, 0, sizeof(uint64_t));
uint64_t* d_BUF_10;
cudaMalloc(&d_BUF_10, sizeof(uint64_t) * COUNT10 * 1);
auto d_HT_10 = cuco::static_map{ (int)COUNT10*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)nation_size/(float)TILE_SIZE), TB>>>(d_BUF_10, d_BUF_IDX_10, d_HT_10.ref(cuco::insert), d_cycles_per_warp_main_1_join_build_10, d_cycles_per_warp_main_1_selection_0, d_nation__n_name, d_nation__n_nationkey, nation_size);
int64_t* cycles_per_warp_main_1_selection_0 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_0 ";
for (auto i=0ull; i < main_1_selection_0_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_0[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_build_10 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_build_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_build_10, d_cycles_per_warp_main_1_join_build_10, sizeof(int64_t) * main_1_join_build_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_build_10 ";
for (auto i=0ull; i < main_1_join_build_10_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_build_10[i] << " ";
std::cout << std::endl;
COUNT9 = d_HT_9.size();
int64_t* d_cycles_per_warp_main_13_map_12;
auto main_13_map_12_cpw_size = std::ceil((float)COUNT9/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_13_map_12, sizeof(int64_t) * main_13_map_12_cpw_size);
cudaMemset(d_cycles_per_warp_main_13_map_12, -1, sizeof(int64_t) * main_13_map_12_cpw_size);
int64_t* d_cycles_per_warp_main_13_selection_14;
auto main_13_selection_14_cpw_size = std::ceil((float)COUNT9/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_13_selection_14, sizeof(int64_t) * main_13_selection_14_cpw_size);
cudaMemset(d_cycles_per_warp_main_13_selection_14, -1, sizeof(int64_t) * main_13_selection_14_cpw_size);
int64_t* d_cycles_per_warp_main_13_selection_15;
auto main_13_selection_15_cpw_size = std::ceil((float)COUNT9/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_13_selection_15, sizeof(int64_t) * main_13_selection_15_cpw_size);
cudaMemset(d_cycles_per_warp_main_13_selection_15, -1, sizeof(int64_t) * main_13_selection_15_cpw_size);
int64_t* d_cycles_per_warp_main_13_semi_join_build_16;
auto main_13_semi_join_build_16_cpw_size = std::ceil((float)COUNT9/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_13_semi_join_build_16, sizeof(int64_t) * main_13_semi_join_build_16_cpw_size);
cudaMemset(d_cycles_per_warp_main_13_semi_join_build_16, -1, sizeof(int64_t) * main_13_semi_join_build_16_cpw_size);
size_t COUNT16 = COUNT9;
// Insert hash table control;
auto d_HT_16 = cuco::static_map{ (int)COUNT16*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_13<<<std::ceil((float)COUNT9/(float)TILE_SIZE), TB>>>(COUNT9, d_HT_16.ref(cuco::insert), d_aggr0__tmp_attr0, d_cycles_per_warp_main_13_map_12, d_cycles_per_warp_main_13_selection_14, d_cycles_per_warp_main_13_selection_15, d_cycles_per_warp_main_13_semi_join_build_16, d_moved_aggr__ps_suppkey, d_moved_aggr_u_1__ps_availqty, d_moved_aggr_u_2__ps_partkey);
int64_t* d_cycles_per_warp_main_11_join_probe_10;
auto main_11_join_probe_10_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_join_probe_10, sizeof(int64_t) * main_11_join_probe_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_join_probe_10, -1, sizeof(int64_t) * main_11_join_probe_10_cpw_size);
int64_t* d_cycles_per_warp_main_11_semi_join_probe_16;
auto main_11_semi_join_probe_16_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_semi_join_probe_16, sizeof(int64_t) * main_11_semi_join_probe_16_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_semi_join_probe_16, -1, sizeof(int64_t) * main_11_semi_join_probe_16_cpw_size);
int64_t* d_cycles_per_warp_main_11_materialize_17;
auto main_11_materialize_17_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_materialize_17, sizeof(int64_t) * main_11_materialize_17_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_materialize_17, -1, sizeof(int64_t) * main_11_materialize_17_cpw_size);
size_t COUNT17 = supplier_size;
//Materialize buffers
uint64_t* d_MAT_IDX17;
cudaMalloc(&d_MAT_IDX17, sizeof(uint64_t));
cudaMemset(d_MAT_IDX17, 0, sizeof(uint64_t));
auto MAT17supplier__s_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT17);
DBI16Type* d_MAT17supplier__s_name_encoded;
cudaMalloc(&d_MAT17supplier__s_name_encoded, sizeof(DBI16Type) * COUNT17);
auto MAT17supplier__s_address_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT17);
DBI16Type* d_MAT17supplier__s_address_encoded;
cudaMalloc(&d_MAT17supplier__s_address_encoded, sizeof(DBI16Type) * COUNT17);
main_11<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TB>>>(d_BUF_10, d_HT_10.ref(cuco::find), d_HT_16.ref(cuco::find), d_MAT17supplier__s_address_encoded, d_MAT17supplier__s_name_encoded, d_MAT_IDX17, d_cycles_per_warp_main_11_join_probe_10, d_cycles_per_warp_main_11_materialize_17, d_cycles_per_warp_main_11_semi_join_probe_16, d_supplier__s_address_encoded, d_supplier__s_name_encoded, d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
uint64_t MATCOUNT_17 = 0;
cudaMemcpy(&MATCOUNT_17, d_MAT_IDX17, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT17supplier__s_name_encoded, d_MAT17supplier__s_name_encoded, sizeof(DBI16Type) * COUNT17, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT17supplier__s_address_encoded, d_MAT17supplier__s_address_encoded, sizeof(DBI16Type) * COUNT17, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_11_join_probe_10 = (int64_t*)malloc(sizeof(int64_t) * main_11_join_probe_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_join_probe_10, d_cycles_per_warp_main_11_join_probe_10, sizeof(int64_t) * main_11_join_probe_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_join_probe_10 ";
for (auto i=0ull; i < main_11_join_probe_10_cpw_size; i++) std::cout << cycles_per_warp_main_11_join_probe_10[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_11_semi_join_probe_16 = (int64_t*)malloc(sizeof(int64_t) * main_11_semi_join_probe_16_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_semi_join_probe_16, d_cycles_per_warp_main_11_semi_join_probe_16, sizeof(int64_t) * main_11_semi_join_probe_16_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_semi_join_probe_16 ";
for (auto i=0ull; i < main_11_semi_join_probe_16_cpw_size; i++) std::cout << cycles_per_warp_main_11_semi_join_probe_16[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_11_materialize_17 = (int64_t*)malloc(sizeof(int64_t) * main_11_materialize_17_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_materialize_17, d_cycles_per_warp_main_11_materialize_17, sizeof(int64_t) * main_11_materialize_17_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_materialize_17 ";
for (auto i=0ull; i < main_11_materialize_17_cpw_size; i++) std::cout << cycles_per_warp_main_11_materialize_17[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_8);
cudaFree(d_BUF_IDX_8);
cudaFree(d_KEY_9lineitem__l_partkey);
cudaFree(d_KEY_9lineitem__l_suppkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_moved_aggr__ps_suppkey);
cudaFree(d_moved_aggr_u_1__ps_availqty);
cudaFree(d_moved_aggr_u_2__ps_partkey);
cudaFree(d_BUF_10);
cudaFree(d_BUF_IDX_10);
cudaFree(d_MAT17supplier__s_address_encoded);
cudaFree(d_MAT17supplier__s_name_encoded);
cudaFree(d_MAT_IDX17);
free(MAT17supplier__s_address_encoded);
free(MAT17supplier__s_name_encoded);
}