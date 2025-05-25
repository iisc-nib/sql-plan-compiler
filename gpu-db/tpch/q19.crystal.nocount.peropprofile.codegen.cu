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
__global__ void main_7(uint64_t* BUF_14, uint64_t* BUF_IDX_14, HASHTABLE_INSERT HT_14, int64_t* cycles_per_warp_main_7_join_build_14, int64_t* cycles_per_warp_main_7_selection_10, int64_t* cycles_per_warp_main_7_selection_11, int64_t* cycles_per_warp_main_7_selection_12, int64_t* cycles_per_warp_main_7_selection_13, int64_t* cycles_per_warp_main_7_selection_6, int64_t* cycles_per_warp_main_7_selection_8, int64_t* cycles_per_warp_main_7_selection_9, DBStringType* part__p_brand, DBStringType* part__p_container, DBI32Type* part__p_partkey, DBI32Type* part__p_size, size_t part_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_part__p_brand[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_brand[ITEM] = part__p_brand[ITEM*TB + tid];
}
DBI32Type reg_part__p_size[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_size[ITEM] = part__p_size[ITEM*TB + tid];
}
DBStringType reg_part__p_container[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_container[ITEM] = part__p_container[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_6[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_9[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_10[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_11[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_12[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_13[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_14[ITEMS_PER_THREAD];
DBI32Type reg_part__p_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_partkey[ITEM] = part__p_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_14[ITEM] = 0;
KEY_14[ITEM] |= reg_part__p_partkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_14.insert(cuco::pair{KEY_14[ITEM], ITEM*TB + tid});
BUF_14[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_build_14[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_1(uint64_t* BUF_14, HASHTABLE_PROBE HT_14, HASHTABLE_FIND HT_16, int* SLOT_COUNT_16, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_1_aggregation_16, int64_t* cycles_per_warp_main_1_join_probe_14, int64_t* cycles_per_warp_main_1_map_15, int64_t* cycles_per_warp_main_1_selection_0, int64_t* cycles_per_warp_main_1_selection_2, int64_t* cycles_per_warp_main_1_selection_3, int64_t* cycles_per_warp_main_1_selection_4, int64_t* cycles_per_warp_main_1_selection_5, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_partkey, DBDecimalType* lineitem__l_quantity, DBStringType* lineitem__l_shipinstruct, DBStringType* lineitem__l_shipmode, size_t lineitem_size, DBStringType* part__p_brand, DBStringType* part__p_container, DBI32Type* part__p_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_lineitem__l_shipinstruct[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_shipinstruct[ITEM] = lineitem__l_shipinstruct[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_shipinstruct[ITEM], "DELIVER IN PERSON", Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
DBDecimalType reg_lineitem__l_quantity[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_quantity[ITEM] = lineitem__l_quantity[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 1.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 11.00, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 10.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 30.00, Predicate::lte));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 1.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 11.00, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 10.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 30.00, Predicate::lte));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_3[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 1.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 11.00, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 10.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 30.00, Predicate::lte));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
DBStringType reg_lineitem__l_shipmode[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_shipmode[ITEM] = lineitem__l_shipmode[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_lineitem__l_shipmode[ITEM], "AIR", Predicate::eq)) || (evaluatePredicate(reg_lineitem__l_shipmode[ITEM], "AIR REG", Predicate::eq));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_5[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_14[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_partkey[ITEM] = lineitem__l_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_14[ITEM] = 0;
KEY_14[ITEM] |= reg_lineitem__l_partkey[ITEM];
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
DBStringType reg_part__p_brand[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_brand[ITEM] = part__p_brand[BUF_14[slot_second14[ITEM] * 1 + 0]];
}
DBI32Type reg_part__p_size[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_size[ITEM] = part__p_size[BUF_14[slot_second14[ITEM] * 1 + 0]];
}
DBStringType reg_part__p_container[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_container[ITEM] = part__p_container[BUF_14[slot_second14[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (((evaluatePredicate(reg_lineitem__l_quantity[ITEM], 1.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 11.00, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_lineitem__l_quantity[ITEM], 10.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq)))) || ((evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 30.00, Predicate::lte)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)))) && (true);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_probe_14[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_map_15[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_16[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_16[ITEM] = 0;
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
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_16 = get_aggregation_slot(KEY_16[ITEM], HT_16, SLOT_COUNT_16);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_16], reg_map0__tmp_attr1[ITEM]);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_aggregation_16[blockIdx.x] = cycles_per_warp;}
}
__global__ void main_18(size_t COUNT16, DBDecimalType* MAT17aggr0__tmp_attr0, uint64_t* MAT_IDX17, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_18_materialize_17) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT16); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT16); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx17 = atomicAdd((int*)MAT_IDX17, 1);
MAT17aggr0__tmp_attr0[mat_idx17] = reg_aggr0__tmp_attr0[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_18_materialize_17[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_7_selection_6;
auto main_7_selection_6_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_6, sizeof(int64_t) * main_7_selection_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_6, -1, sizeof(int64_t) * main_7_selection_6_cpw_size);
int64_t* d_cycles_per_warp_main_7_selection_8;
auto main_7_selection_8_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_8, sizeof(int64_t) * main_7_selection_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_8, -1, sizeof(int64_t) * main_7_selection_8_cpw_size);
int64_t* d_cycles_per_warp_main_7_selection_9;
auto main_7_selection_9_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_9, sizeof(int64_t) * main_7_selection_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_9, -1, sizeof(int64_t) * main_7_selection_9_cpw_size);
int64_t* d_cycles_per_warp_main_7_selection_10;
auto main_7_selection_10_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_10, sizeof(int64_t) * main_7_selection_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_10, -1, sizeof(int64_t) * main_7_selection_10_cpw_size);
int64_t* d_cycles_per_warp_main_7_selection_11;
auto main_7_selection_11_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_11, sizeof(int64_t) * main_7_selection_11_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_11, -1, sizeof(int64_t) * main_7_selection_11_cpw_size);
int64_t* d_cycles_per_warp_main_7_selection_12;
auto main_7_selection_12_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_12, sizeof(int64_t) * main_7_selection_12_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_12, -1, sizeof(int64_t) * main_7_selection_12_cpw_size);
int64_t* d_cycles_per_warp_main_7_selection_13;
auto main_7_selection_13_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_13, sizeof(int64_t) * main_7_selection_13_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_13, -1, sizeof(int64_t) * main_7_selection_13_cpw_size);
int64_t* d_cycles_per_warp_main_7_join_build_14;
auto main_7_join_build_14_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_build_14, sizeof(int64_t) * main_7_join_build_14_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_build_14, -1, sizeof(int64_t) * main_7_join_build_14_cpw_size);
size_t COUNT14 = part_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_14;
cudaMalloc(&d_BUF_IDX_14, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_14, 0, sizeof(uint64_t));
uint64_t* d_BUF_14;
cudaMalloc(&d_BUF_14, sizeof(uint64_t) * COUNT14 * 1);
auto d_HT_14 = cuco::static_map{ (int)COUNT14*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_7<<<std::ceil((float)part_size/(float)TILE_SIZE), TB>>>(d_BUF_14, d_BUF_IDX_14, d_HT_14.ref(cuco::insert), d_cycles_per_warp_main_7_join_build_14, d_cycles_per_warp_main_7_selection_10, d_cycles_per_warp_main_7_selection_11, d_cycles_per_warp_main_7_selection_12, d_cycles_per_warp_main_7_selection_13, d_cycles_per_warp_main_7_selection_6, d_cycles_per_warp_main_7_selection_8, d_cycles_per_warp_main_7_selection_9, d_part__p_brand, d_part__p_container, d_part__p_partkey, d_part__p_size, part_size);
int64_t* cycles_per_warp_main_7_selection_6 = (int64_t*)malloc(sizeof(int64_t) * main_7_selection_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_selection_6, d_cycles_per_warp_main_7_selection_6, sizeof(int64_t) * main_7_selection_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_selection_6 ";
for (auto i=0ull; i < main_7_selection_6_cpw_size; i++) std::cout << cycles_per_warp_main_7_selection_6[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_selection_8 = (int64_t*)malloc(sizeof(int64_t) * main_7_selection_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_selection_8, d_cycles_per_warp_main_7_selection_8, sizeof(int64_t) * main_7_selection_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_selection_8 ";
for (auto i=0ull; i < main_7_selection_8_cpw_size; i++) std::cout << cycles_per_warp_main_7_selection_8[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_selection_9 = (int64_t*)malloc(sizeof(int64_t) * main_7_selection_9_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_selection_9, d_cycles_per_warp_main_7_selection_9, sizeof(int64_t) * main_7_selection_9_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_selection_9 ";
for (auto i=0ull; i < main_7_selection_9_cpw_size; i++) std::cout << cycles_per_warp_main_7_selection_9[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_selection_10 = (int64_t*)malloc(sizeof(int64_t) * main_7_selection_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_selection_10, d_cycles_per_warp_main_7_selection_10, sizeof(int64_t) * main_7_selection_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_selection_10 ";
for (auto i=0ull; i < main_7_selection_10_cpw_size; i++) std::cout << cycles_per_warp_main_7_selection_10[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_selection_11 = (int64_t*)malloc(sizeof(int64_t) * main_7_selection_11_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_selection_11, d_cycles_per_warp_main_7_selection_11, sizeof(int64_t) * main_7_selection_11_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_selection_11 ";
for (auto i=0ull; i < main_7_selection_11_cpw_size; i++) std::cout << cycles_per_warp_main_7_selection_11[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_selection_12 = (int64_t*)malloc(sizeof(int64_t) * main_7_selection_12_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_selection_12, d_cycles_per_warp_main_7_selection_12, sizeof(int64_t) * main_7_selection_12_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_selection_12 ";
for (auto i=0ull; i < main_7_selection_12_cpw_size; i++) std::cout << cycles_per_warp_main_7_selection_12[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_selection_13 = (int64_t*)malloc(sizeof(int64_t) * main_7_selection_13_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_selection_13, d_cycles_per_warp_main_7_selection_13, sizeof(int64_t) * main_7_selection_13_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_selection_13 ";
for (auto i=0ull; i < main_7_selection_13_cpw_size; i++) std::cout << cycles_per_warp_main_7_selection_13[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_join_build_14 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_build_14_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_build_14, d_cycles_per_warp_main_7_join_build_14, sizeof(int64_t) * main_7_join_build_14_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_build_14 ";
for (auto i=0ull; i < main_7_join_build_14_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_build_14[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_2;
auto main_1_selection_2_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_2, sizeof(int64_t) * main_1_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_2, -1, sizeof(int64_t) * main_1_selection_2_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_3;
auto main_1_selection_3_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_3, sizeof(int64_t) * main_1_selection_3_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_3, -1, sizeof(int64_t) * main_1_selection_3_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_4;
auto main_1_selection_4_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_4, sizeof(int64_t) * main_1_selection_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_4, -1, sizeof(int64_t) * main_1_selection_4_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_5;
auto main_1_selection_5_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_5, sizeof(int64_t) * main_1_selection_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_5, -1, sizeof(int64_t) * main_1_selection_5_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_probe_14;
auto main_1_join_probe_14_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_probe_14, sizeof(int64_t) * main_1_join_probe_14_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_probe_14, -1, sizeof(int64_t) * main_1_join_probe_14_cpw_size);
int64_t* d_cycles_per_warp_main_1_map_15;
auto main_1_map_15_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_map_15, sizeof(int64_t) * main_1_map_15_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_map_15, -1, sizeof(int64_t) * main_1_map_15_cpw_size);
int64_t* d_cycles_per_warp_main_1_aggregation_16;
auto main_1_aggregation_16_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_aggregation_16, sizeof(int64_t) * main_1_aggregation_16_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_aggregation_16, -1, sizeof(int64_t) * main_1_aggregation_16_cpw_size);
size_t COUNT16 = 1;
auto d_HT_16 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_16;
cudaMalloc(&d_SLOT_COUNT_16, sizeof(int));
cudaMemset(d_SLOT_COUNT_16, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT16);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT16);
main_1<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TB>>>(d_BUF_14, d_HT_14.ref(cuco::find), d_HT_16.ref(cuco::insert_and_find), d_SLOT_COUNT_16, d_aggr0__tmp_attr0, d_cycles_per_warp_main_1_aggregation_16, d_cycles_per_warp_main_1_join_probe_14, d_cycles_per_warp_main_1_map_15, d_cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_2, d_cycles_per_warp_main_1_selection_3, d_cycles_per_warp_main_1_selection_4, d_cycles_per_warp_main_1_selection_5, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_partkey, d_lineitem__l_quantity, d_lineitem__l_shipinstruct, d_lineitem__l_shipmode, lineitem_size, d_part__p_brand, d_part__p_container, d_part__p_size);
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
int64_t* cycles_per_warp_main_1_join_probe_14 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_probe_14_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_probe_14, d_cycles_per_warp_main_1_join_probe_14, sizeof(int64_t) * main_1_join_probe_14_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_probe_14 ";
for (auto i=0ull; i < main_1_join_probe_14_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_probe_14[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_map_15 = (int64_t*)malloc(sizeof(int64_t) * main_1_map_15_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_map_15, d_cycles_per_warp_main_1_map_15, sizeof(int64_t) * main_1_map_15_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_map_15 ";
for (auto i=0ull; i < main_1_map_15_cpw_size; i++) std::cout << cycles_per_warp_main_1_map_15[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_aggregation_16 = (int64_t*)malloc(sizeof(int64_t) * main_1_aggregation_16_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_aggregation_16, d_cycles_per_warp_main_1_aggregation_16, sizeof(int64_t) * main_1_aggregation_16_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_aggregation_16 ";
for (auto i=0ull; i < main_1_aggregation_16_cpw_size; i++) std::cout << cycles_per_warp_main_1_aggregation_16[i] << " ";
std::cout << std::endl;
COUNT16 = d_HT_16.size();
int64_t* d_cycles_per_warp_main_18_materialize_17;
auto main_18_materialize_17_cpw_size = std::ceil((float)COUNT16/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_18_materialize_17, sizeof(int64_t) * main_18_materialize_17_cpw_size);
cudaMemset(d_cycles_per_warp_main_18_materialize_17, -1, sizeof(int64_t) * main_18_materialize_17_cpw_size);
size_t COUNT17 = COUNT16;
//Materialize buffers
uint64_t* d_MAT_IDX17;
cudaMalloc(&d_MAT_IDX17, sizeof(uint64_t));
cudaMemset(d_MAT_IDX17, 0, sizeof(uint64_t));
auto MAT17aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT17);
DBDecimalType* d_MAT17aggr0__tmp_attr0;
cudaMalloc(&d_MAT17aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT17);
main_18<<<std::ceil((float)COUNT16/(float)TILE_SIZE), TB>>>(COUNT16, d_MAT17aggr0__tmp_attr0, d_MAT_IDX17, d_aggr0__tmp_attr0, d_cycles_per_warp_main_18_materialize_17);
uint64_t MATCOUNT_17 = 0;
cudaMemcpy(&MATCOUNT_17, d_MAT_IDX17, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT17aggr0__tmp_attr0, d_MAT17aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT17, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_18_materialize_17 = (int64_t*)malloc(sizeof(int64_t) * main_18_materialize_17_cpw_size);
cudaMemcpy(cycles_per_warp_main_18_materialize_17, d_cycles_per_warp_main_18_materialize_17, sizeof(int64_t) * main_18_materialize_17_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_18_materialize_17 ";
for (auto i=0ull; i < main_18_materialize_17_cpw_size; i++) std::cout << cycles_per_warp_main_18_materialize_17[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_14);
cudaFree(d_BUF_IDX_14);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_MAT17aggr0__tmp_attr0);
cudaFree(d_MAT_IDX17);
free(MAT17aggr0__tmp_attr0);
}