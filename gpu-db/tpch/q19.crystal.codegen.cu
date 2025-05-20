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
__global__ void count_1(uint64_t* COUNT0, DBStringType* part__p_brand, DBStringType* part__p_container, DBI32Type* part__p_size, size_t part_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBI32Type reg_part__p_size[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_size[ITEM] = part__p_size[ITEM*TB + tid];
}
DBStringType reg_part__p_brand[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_brand[ITEM] = part__p_brand[ITEM*TB + tid];
}
DBStringType reg_part__p_container[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_container[ITEM] = part__p_container[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT0, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT HT_0, DBStringType* part__p_brand, DBStringType* part__p_container, DBI32Type* part__p_partkey, DBI32Type* part__p_size, size_t part_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBI32Type reg_part__p_size[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_size[ITEM] = part__p_size[ITEM*TB + tid];
}
DBStringType reg_part__p_brand[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_brand[ITEM] = part__p_brand[ITEM*TB + tid];
}
DBStringType reg_part__p_container[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_container[ITEM] = part__p_container[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= ((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))));
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
auto buf_idx_0 = atomicAdd((int*)BUF_IDX_0, 1);
HT_0.insert(cuco::pair{KEY_0[ITEM], buf_idx_0});
BUF_0[(buf_idx_0) * 1 + 0] = ITEM*TB + tid;
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void count_3(uint64_t* BUF_0, HASHTABLE_PROBE HT_0, HASHTABLE_INSERT HT_2, DBI32Type* lineitem__l_partkey, DBDecimalType* lineitem__l_quantity, DBStringType* lineitem__l_shipinstruct, DBStringType* lineitem__l_shipmode, size_t lineitem_size, DBStringType* part__p_brand, DBStringType* part__p_container, DBI32Type* part__p_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
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
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 1.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 11.00, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 10.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 30.00, Predicate::lte));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 1.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 11.00, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 10.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 30.00, Predicate::lte));
}
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
int64_t slot_second0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_0 = HT_0.find(KEY_0[ITEM]);
if (SLOT_0 == HT_0.end()) {selection_flags[ITEM] = 0; continue;}
slot_second0[ITEM] = SLOT_0->second;
}
DBI32Type reg_part__p_size[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_size[ITEM] = part__p_size[BUF_0[slot_second0[ITEM] * 1 + 0]];
}
DBStringType reg_part__p_brand[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_brand[ITEM] = part__p_brand[BUF_0[slot_second0[ITEM] * 1 + 0]];
}
DBStringType reg_part__p_container[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_container[ITEM] = part__p_container[BUF_0[slot_second0[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 1.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 11.00, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 10.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::lte)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 30.00, Predicate::lte)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))))) && (true);
}
uint64_t KEY_2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_2[ITEM] = 0;
}
//Create aggregation hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_2.insert(cuco::pair{KEY_2[ITEM], 1});
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_3(uint64_t* BUF_0, HASHTABLE_PROBE HT_0, HASHTABLE_FIND HT_2, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_partkey, DBDecimalType* lineitem__l_quantity, DBStringType* lineitem__l_shipinstruct, DBStringType* lineitem__l_shipmode, size_t lineitem_size, DBStringType* part__p_brand, DBStringType* part__p_container, DBI32Type* part__p_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
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
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 1.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 11.00, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 10.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 30.00, Predicate::lte));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 1.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 11.00, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 10.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::lte)) || (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 30.00, Predicate::lte));
}
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
int64_t slot_second0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_0 = HT_0.find(KEY_0[ITEM]);
if (SLOT_0 == HT_0.end()) {selection_flags[ITEM] = 0; continue;}
slot_second0[ITEM] = SLOT_0->second;
}
DBI32Type reg_part__p_size[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_size[ITEM] = part__p_size[BUF_0[slot_second0[ITEM] * 1 + 0]];
}
DBStringType reg_part__p_brand[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_brand[ITEM] = part__p_brand[BUF_0[slot_second0[ITEM] * 1 + 0]];
}
DBStringType reg_part__p_container[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_container[ITEM] = part__p_container[BUF_0[slot_second0[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (((evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 5, Predicate::lte)) && (evaluatePredicate(reg_part__p_brand[ITEM], "Brand#12", Predicate::eq)) && (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 1.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 11.00, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "SM CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "SM PKG", Predicate::eq)))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#23", Predicate::eq)) && ((evaluatePredicate(reg_part__p_container[ITEM], "MED BAG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PKG", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "MED PACK", Predicate::eq))) && (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 10.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::lte)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 10, Predicate::lte))) || ((evaluatePredicate(reg_part__p_brand[ITEM], "Brand#34", Predicate::eq)) && (evaluatePredicate(reg_lineitem__l_quantity[ITEM], 20.0, Predicate::gte) && evaluatePredicate(reg_lineitem__l_quantity[ITEM], 30.00, Predicate::lte)) && (evaluatePredicate(reg_part__p_size[ITEM], 1, Predicate::gte) && evaluatePredicate(reg_part__p_size[ITEM], 15, Predicate::lte)) && ((evaluatePredicate(reg_part__p_container[ITEM], "LG CASE", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG BOX", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PACK", Predicate::eq)) || (evaluatePredicate(reg_part__p_container[ITEM], "LG PKG", Predicate::eq))))) && (true);
}
uint64_t KEY_2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_2[ITEM] = 0;
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
auto buf_idx_2 = HT_2.find(KEY_2[ITEM])->second;
aggregate_sum(&aggr0__tmp_attr0[buf_idx_2], reg_map0__tmp_attr1[ITEM]);
}
}
__global__ void count_5(size_t COUNT2, uint64_t* COUNT4) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT2); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT4, 1);
}
}
__global__ void main_5(size_t COUNT2, DBDecimalType* MAT4aggr0__tmp_attr0, uint64_t* MAT_IDX4, DBDecimalType* aggr0__tmp_attr0) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize buffers
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT2); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT2); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx4 = atomicAdd((int*)MAT_IDX4, 1);
MAT4aggr0__tmp_attr0[mat_idx4] = reg_aggr0__tmp_attr0[ITEM];
}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto start = std::chrono::high_resolution_clock::now();
//Materialize count
uint64_t* d_COUNT0;
cudaMalloc(&d_COUNT0, sizeof(uint64_t));
cudaMemset(d_COUNT0, 0, sizeof(uint64_t));
count_1<<<std::ceil((float)part_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT0, d_part__p_brand, d_part__p_container, d_part__p_size, part_size);
uint64_t COUNT0;
cudaMemcpy(&COUNT0, d_COUNT0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_0;
cudaMalloc(&d_BUF_IDX_0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_0, 0, sizeof(uint64_t));
uint64_t* d_BUF_0;
cudaMalloc(&d_BUF_0, sizeof(uint64_t) * COUNT0 * 1);
auto d_HT_0 = cuco::static_map{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)part_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_part__p_brand, d_part__p_container, d_part__p_partkey, d_part__p_size, part_size);
//Create aggregation hash table
auto d_HT_2 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_3<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_0, d_HT_0.ref(cuco::find), d_HT_2.ref(cuco::insert), d_lineitem__l_partkey, d_lineitem__l_quantity, d_lineitem__l_shipinstruct, d_lineitem__l_shipmode, lineitem_size, d_part__p_brand, d_part__p_container, d_part__p_size);
size_t COUNT2 = d_HT_2.size();
thrust::device_vector<int64_t> keys_2(COUNT2), vals_2(COUNT2);
d_HT_2.retrieve_all(keys_2.begin(), vals_2.begin());
d_HT_2.clear();
int64_t* raw_keys2 = thrust::raw_pointer_cast(keys_2.data());
insertKeys<<<std::ceil((float)COUNT2/128.), 128>>>(raw_keys2, d_HT_2.ref(cuco::insert), COUNT2);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT2);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT2);
main_3<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_0, d_HT_0.ref(cuco::find), d_HT_2.ref(cuco::find), d_aggr0__tmp_attr0, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_partkey, d_lineitem__l_quantity, d_lineitem__l_shipinstruct, d_lineitem__l_shipmode, lineitem_size, d_part__p_brand, d_part__p_container, d_part__p_size);
//Materialize count
uint64_t* d_COUNT4;
cudaMalloc(&d_COUNT4, sizeof(uint64_t));
cudaMemset(d_COUNT4, 0, sizeof(uint64_t));
count_5<<<std::ceil((float)COUNT2/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT2, d_COUNT4);
uint64_t COUNT4;
cudaMemcpy(&COUNT4, d_COUNT4, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX4;
cudaMalloc(&d_MAT_IDX4, sizeof(uint64_t));
cudaMemset(d_MAT_IDX4, 0, sizeof(uint64_t));
auto MAT4aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT4);
DBDecimalType* d_MAT4aggr0__tmp_attr0;
cudaMalloc(&d_MAT4aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT4);
main_5<<<std::ceil((float)COUNT2/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT2, d_MAT4aggr0__tmp_attr0, d_MAT_IDX4, d_aggr0__tmp_attr0);
cudaMemcpy(MAT4aggr0__tmp_attr0, d_MAT4aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT4, cudaMemcpyDeviceToHost);
auto end = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
std::clog << "Query execution time: " << duration.count() / 1000. << " milliseconds." << std::endl;

for (auto i=0ull; i < COUNT4; i++) { std::cout << "" << MAT4aggr0__tmp_attr0[i];
std::cout << std::endl; }
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
      size_t aux_mem = usedGpuMem() - used_mem;
      std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_0);
cudaFree(d_BUF_IDX_0);
cudaFree(d_COUNT0);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT4);
cudaFree(d_MAT4aggr0__tmp_attr0);
cudaFree(d_MAT_IDX4);
free(MAT4aggr0__tmp_attr0);
}