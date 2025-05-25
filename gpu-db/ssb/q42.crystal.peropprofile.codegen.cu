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
__global__ void count_11(uint64_t* COUNT29, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBStringType reg_supplier__s_region[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_region[ITEM] = supplier__s_region[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_supplier__s_region[ITEM], "AMERICA", Predicate::eq);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT29, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_11(uint64_t* BUF_29, uint64_t* BUF_IDX_29, HASHTABLE_INSERT HT_29, int64_t* cycles_per_warp_main_11_join_build_29, int64_t* cycles_per_warp_main_11_selection_10, int64_t* cycles_per_warp_main_11_selection_12, int64_t* cycles_per_warp_main_11_selection_13, int64_t* cycles_per_warp_main_11_selection_14, int64_t* cycles_per_warp_main_11_selection_15, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
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
selection_flags[ITEM] &= evaluatePredicate(reg_supplier__s_region[ITEM], "AMERICA", Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_selection_10[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_selection_12[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_selection_13[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_selection_14[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_selection_15[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_29[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_29[ITEM] = 0;
KEY_29[ITEM] |= reg_supplier__s_suppkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_29 = atomicAdd((int*)BUF_IDX_29, 1);
HT_29.insert(cuco::pair{KEY_29[ITEM], buf_idx_29});
BUF_29[(buf_idx_29) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_join_build_29[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_5(uint64_t* COUNT30, DBStringType* customer__c_region, size_t customer_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBStringType reg_customer__c_region[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_region[ITEM] = customer__c_region[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_customer__c_region[ITEM], "AMERICA", Predicate::eq);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT30, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_5(uint64_t* BUF_30, uint64_t* BUF_IDX_30, HASHTABLE_INSERT HT_30, DBI32Type* customer__c_custkey, DBStringType* customer__c_region, size_t customer_size, int64_t* cycles_per_warp_main_5_join_build_30, int64_t* cycles_per_warp_main_5_selection_4, int64_t* cycles_per_warp_main_5_selection_6, int64_t* cycles_per_warp_main_5_selection_7, int64_t* cycles_per_warp_main_5_selection_8, int64_t* cycles_per_warp_main_5_selection_9) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_customer__c_region[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_region[ITEM] = customer__c_region[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_customer__c_region[ITEM], "AMERICA", Predicate::eq);
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
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_7[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_9[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_30[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_30[ITEM] = 0;
KEY_30[ITEM] |= reg_customer__c_custkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_30 = atomicAdd((int*)BUF_IDX_30, 1);
HT_30.insert(cuco::pair{KEY_30[ITEM], buf_idx_30});
BUF_30[(buf_idx_30) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_join_build_30[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_1(uint64_t* COUNT31, DBI32Type* date__d_year, size_t date_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
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
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT31, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_31, uint64_t* BUF_IDX_31, HASHTABLE_INSERT HT_31, int64_t* cycles_per_warp_main_1_join_build_31, int64_t* cycles_per_warp_main_1_selection_0, int64_t* cycles_per_warp_main_1_selection_2, int64_t* cycles_per_warp_main_1_selection_3, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
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
uint64_t KEY_31[ITEMS_PER_THREAD];
DBI32Type reg_date__d_datekey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
reg_date__d_datekey[ITEM] = date__d_datekey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_31[ITEM] = 0;
KEY_31[ITEM] |= reg_date__d_datekey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_31 = atomicAdd((int*)BUF_IDX_31, 1);
HT_31.insert(cuco::pair{KEY_31[ITEM], buf_idx_31});
BUF_31[(buf_idx_31) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_build_31[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_17(uint64_t* COUNT32, DBStringType* part__p_mfgr, size_t part_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBStringType reg_part__p_mfgr[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_mfgr[ITEM] = part__p_mfgr[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_part__p_mfgr[ITEM], "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr[ITEM], "MFGR#2", Predicate::eq));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT32, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_17(uint64_t* BUF_32, uint64_t* BUF_IDX_32, HASHTABLE_INSERT HT_32, int64_t* cycles_per_warp_main_17_join_build_32, int64_t* cycles_per_warp_main_17_selection_16, int64_t* cycles_per_warp_main_17_selection_18, int64_t* cycles_per_warp_main_17_selection_19, DBStringType* part__p_mfgr, DBI32Type* part__p_partkey, size_t part_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_part__p_mfgr[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_mfgr[ITEM] = part__p_mfgr[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_part__p_mfgr[ITEM], "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr[ITEM], "MFGR#2", Predicate::eq));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_selection_16[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_selection_18[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_selection_19[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_32[ITEMS_PER_THREAD];
DBI32Type reg_part__p_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_partkey[ITEM] = part__p_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_32[ITEM] = 0;
KEY_32[ITEM] |= reg_part__p_partkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_32 = atomicAdd((int*)BUF_IDX_32, 1);
HT_32.insert(cuco::pair{KEY_32[ITEM], buf_idx_32});
BUF_32[(buf_idx_32) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_join_build_32[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void count_21(uint64_t* BUF_29, uint64_t* BUF_30, uint64_t* BUF_31, uint64_t* BUF_32, HASHTABLE_PROBE HT_29, HASHTABLE_PROBE HT_30, HASHTABLE_PROBE HT_31, HASHTABLE_PROBE HT_32, HASHTABLE_INSERT HT_34, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* part__p_category_encoded, DBI16Type* supplier__s_nation_encoded) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
uint64_t KEY_29[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_suppkey[ITEM] = lineorder__lo_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_29[ITEM] = 0;
KEY_29[ITEM] |= reg_lineorder__lo_suppkey[ITEM];
}
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
uint64_t KEY_30[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_custkey[ITEM] = lineorder__lo_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_30[ITEM] = 0;
KEY_30[ITEM] |= reg_lineorder__lo_custkey[ITEM];
}
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
uint64_t KEY_31[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_orderdate[ITEM] = lineorder__lo_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_31[ITEM] = 0;
KEY_31[ITEM] |= reg_lineorder__lo_orderdate[ITEM];
}
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
uint64_t KEY_32[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_partkey[ITEM] = lineorder__lo_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_32[ITEM] = 0;
KEY_32[ITEM] |= reg_lineorder__lo_partkey[ITEM];
}
int64_t slot_second32[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_32 = HT_32.find(KEY_32[ITEM]);
if (SLOT_32 == HT_32.end()) {selection_flags[ITEM] = 0; continue;}
slot_second32[ITEM] = SLOT_32->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_34[ITEMS_PER_THREAD];
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_date__d_year[ITEM] = date__d_year[BUF_31[slot_second31[ITEM] * 1 + 0]];
}
DBI16Type reg_supplier__s_nation_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_supplier__s_nation_encoded[ITEM] = supplier__s_nation_encoded[BUF_29[slot_second29[ITEM] * 1 + 0]];
}
DBI16Type reg_part__p_category_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_category_encoded[ITEM] = part__p_category_encoded[BUF_32[slot_second32[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_34[ITEM] = 0;
KEY_34[ITEM] |= reg_date__d_year[ITEM];
KEY_34[ITEM] <<= 16;
KEY_34[ITEM] |= reg_supplier__s_nation_encoded[ITEM];
KEY_34[ITEM] <<= 16;
KEY_34[ITEM] |= reg_part__p_category_encoded[ITEM];
}
//Create aggregation hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_34.insert(cuco::pair{KEY_34[ITEM], 1});
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_21(uint64_t* BUF_29, uint64_t* BUF_30, uint64_t* BUF_31, uint64_t* BUF_32, HASHTABLE_PROBE HT_29, HASHTABLE_PROBE HT_30, HASHTABLE_PROBE HT_31, HASHTABLE_PROBE HT_32, HASHTABLE_FIND HT_34, DBI32Type* KEY_34date__d_year, DBI16Type* KEY_34part__p_category_encoded, DBI16Type* KEY_34supplier__s_nation_encoded, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_21_aggregation_34, int64_t* cycles_per_warp_main_21_join_probe_29, int64_t* cycles_per_warp_main_21_join_probe_30, int64_t* cycles_per_warp_main_21_join_probe_31, int64_t* cycles_per_warp_main_21_join_probe_32, int64_t* cycles_per_warp_main_21_map_33, int64_t* cycles_per_warp_main_21_selection_20, int64_t* cycles_per_warp_main_21_selection_22, int64_t* cycles_per_warp_main_21_selection_23, int64_t* cycles_per_warp_main_21_selection_24, int64_t* cycles_per_warp_main_21_selection_25, int64_t* cycles_per_warp_main_21_selection_26, int64_t* cycles_per_warp_main_21_selection_27, int64_t* cycles_per_warp_main_21_selection_28, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, DBDecimalType* lineorder__lo_supplycost, size_t lineorder_size, DBI16Type* part__p_category_encoded, DBI16Type* supplier__s_nation_encoded) {
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_selection_20[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_selection_22[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_selection_23[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_selection_24[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_selection_25[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_selection_26[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_selection_27[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_selection_28[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_29[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_suppkey[ITEM] = lineorder__lo_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_29[ITEM] = 0;
KEY_29[ITEM] |= reg_lineorder__lo_suppkey[ITEM];
}
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_join_probe_29[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_30[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_custkey[ITEM] = lineorder__lo_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_30[ITEM] = 0;
KEY_30[ITEM] |= reg_lineorder__lo_custkey[ITEM];
}
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_join_probe_30[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_31[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_orderdate[ITEM] = lineorder__lo_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_31[ITEM] = 0;
KEY_31[ITEM] |= reg_lineorder__lo_orderdate[ITEM];
}
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_join_probe_31[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_32[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_partkey[ITEM] = lineorder__lo_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_32[ITEM] = 0;
KEY_32[ITEM] |= reg_lineorder__lo_partkey[ITEM];
}
int64_t slot_second32[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_32 = HT_32.find(KEY_32[ITEM]);
if (SLOT_32 == HT_32.end()) {selection_flags[ITEM] = 0; continue;}
slot_second32[ITEM] = SLOT_32->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_join_probe_32[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_map_33[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_34[ITEMS_PER_THREAD];
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_date__d_year[ITEM] = date__d_year[BUF_31[slot_second31[ITEM] * 1 + 0]];
}
DBI16Type reg_supplier__s_nation_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_supplier__s_nation_encoded[ITEM] = supplier__s_nation_encoded[BUF_29[slot_second29[ITEM] * 1 + 0]];
}
DBI16Type reg_part__p_category_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_category_encoded[ITEM] = part__p_category_encoded[BUF_32[slot_second32[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_34[ITEM] = 0;
KEY_34[ITEM] |= reg_date__d_year[ITEM];
KEY_34[ITEM] <<= 16;
KEY_34[ITEM] |= reg_supplier__s_nation_encoded[ITEM];
KEY_34[ITEM] <<= 16;
KEY_34[ITEM] |= reg_part__p_category_encoded[ITEM];
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
auto buf_idx_34 = HT_34.find(KEY_34[ITEM])->second;
aggregate_sum(&aggr0__tmp_attr0[buf_idx_34], reg_map0__tmp_attr1[ITEM]);
KEY_34date__d_year[buf_idx_34] = reg_date__d_year[ITEM];
KEY_34supplier__s_nation_encoded[buf_idx_34] = reg_supplier__s_nation_encoded[ITEM];
KEY_34part__p_category_encoded[buf_idx_34] = reg_part__p_category_encoded[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_21_aggregation_34[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_36(size_t COUNT34, uint64_t* COUNT35) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT34); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT35, 1);
}
}
__global__ void main_36(size_t COUNT34, DBDecimalType* MAT35aggr0__tmp_attr0, DBI32Type* MAT35date__d_year, DBI16Type* MAT35part__p_category_encoded, DBI16Type* MAT35supplier__s_nation_encoded, uint64_t* MAT_IDX35, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_36_materialize_35, DBI32Type* date__d_year, DBI16Type* part__p_category_encoded, DBI16Type* supplier__s_nation_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT34); ++ITEM) {
reg_date__d_year[ITEM] = date__d_year[ITEM*TB + tid];
}
DBI16Type reg_supplier__s_nation_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT34); ++ITEM) {
reg_supplier__s_nation_encoded[ITEM] = supplier__s_nation_encoded[ITEM*TB + tid];
}
DBI16Type reg_part__p_category_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT34); ++ITEM) {
reg_part__p_category_encoded[ITEM] = part__p_category_encoded[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT34); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT34); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx35 = atomicAdd((int*)MAT_IDX35, 1);
MAT35date__d_year[mat_idx35] = reg_date__d_year[ITEM];
MAT35supplier__s_nation_encoded[mat_idx35] = reg_supplier__s_nation_encoded[ITEM];
MAT35part__p_category_encoded[mat_idx35] = reg_part__p_category_encoded[ITEM];
MAT35aggr0__tmp_attr0[mat_idx35] = reg_aggr0__tmp_attr0[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_36_materialize_35[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_11_selection_10;
auto main_11_selection_10_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_selection_10, sizeof(int64_t) * main_11_selection_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_selection_10, -1, sizeof(int64_t) * main_11_selection_10_cpw_size);
int64_t* d_cycles_per_warp_main_11_selection_12;
auto main_11_selection_12_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_selection_12, sizeof(int64_t) * main_11_selection_12_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_selection_12, -1, sizeof(int64_t) * main_11_selection_12_cpw_size);
int64_t* d_cycles_per_warp_main_11_selection_13;
auto main_11_selection_13_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_selection_13, sizeof(int64_t) * main_11_selection_13_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_selection_13, -1, sizeof(int64_t) * main_11_selection_13_cpw_size);
int64_t* d_cycles_per_warp_main_11_selection_14;
auto main_11_selection_14_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_selection_14, sizeof(int64_t) * main_11_selection_14_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_selection_14, -1, sizeof(int64_t) * main_11_selection_14_cpw_size);
int64_t* d_cycles_per_warp_main_11_selection_15;
auto main_11_selection_15_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_selection_15, sizeof(int64_t) * main_11_selection_15_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_selection_15, -1, sizeof(int64_t) * main_11_selection_15_cpw_size);
//Materialize count
uint64_t* d_COUNT29;
cudaMalloc(&d_COUNT29, sizeof(uint64_t));
cudaMemset(d_COUNT29, 0, sizeof(uint64_t));
count_11<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT29, d_supplier__s_region, supplier_size);
uint64_t COUNT29;
cudaMemcpy(&COUNT29, d_COUNT29, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_11_join_build_29;
auto main_11_join_build_29_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_join_build_29, sizeof(int64_t) * main_11_join_build_29_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_join_build_29, -1, sizeof(int64_t) * main_11_join_build_29_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_29;
cudaMalloc(&d_BUF_IDX_29, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_29, 0, sizeof(uint64_t));
uint64_t* d_BUF_29;
cudaMalloc(&d_BUF_29, sizeof(uint64_t) * COUNT29 * 1);
auto d_HT_29 = cuco::static_map{ (int)COUNT29*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_11<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_29, d_BUF_IDX_29, d_HT_29.ref(cuco::insert), d_cycles_per_warp_main_11_join_build_29, d_cycles_per_warp_main_11_selection_10, d_cycles_per_warp_main_11_selection_12, d_cycles_per_warp_main_11_selection_13, d_cycles_per_warp_main_11_selection_14, d_cycles_per_warp_main_11_selection_15, d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
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
int64_t* cycles_per_warp_main_11_join_build_29 = (int64_t*)malloc(sizeof(int64_t) * main_11_join_build_29_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_join_build_29, d_cycles_per_warp_main_11_join_build_29, sizeof(int64_t) * main_11_join_build_29_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_join_build_29 ";
for (auto i=0ull; i < main_11_join_build_29_cpw_size; i++) std::cout << cycles_per_warp_main_11_join_build_29[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_5_selection_4;
auto main_5_selection_4_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_4, sizeof(int64_t) * main_5_selection_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_4, -1, sizeof(int64_t) * main_5_selection_4_cpw_size);
int64_t* d_cycles_per_warp_main_5_selection_6;
auto main_5_selection_6_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_6, sizeof(int64_t) * main_5_selection_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_6, -1, sizeof(int64_t) * main_5_selection_6_cpw_size);
int64_t* d_cycles_per_warp_main_5_selection_7;
auto main_5_selection_7_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_7, sizeof(int64_t) * main_5_selection_7_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_7, -1, sizeof(int64_t) * main_5_selection_7_cpw_size);
int64_t* d_cycles_per_warp_main_5_selection_8;
auto main_5_selection_8_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_8, sizeof(int64_t) * main_5_selection_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_8, -1, sizeof(int64_t) * main_5_selection_8_cpw_size);
int64_t* d_cycles_per_warp_main_5_selection_9;
auto main_5_selection_9_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_9, sizeof(int64_t) * main_5_selection_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_9, -1, sizeof(int64_t) * main_5_selection_9_cpw_size);
//Materialize count
uint64_t* d_COUNT30;
cudaMalloc(&d_COUNT30, sizeof(uint64_t));
cudaMemset(d_COUNT30, 0, sizeof(uint64_t));
count_5<<<std::ceil((float)customer_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT30, d_customer__c_region, customer_size);
uint64_t COUNT30;
cudaMemcpy(&COUNT30, d_COUNT30, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_5_join_build_30;
auto main_5_join_build_30_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_join_build_30, sizeof(int64_t) * main_5_join_build_30_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_join_build_30, -1, sizeof(int64_t) * main_5_join_build_30_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_30;
cudaMalloc(&d_BUF_IDX_30, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_30, 0, sizeof(uint64_t));
uint64_t* d_BUF_30;
cudaMalloc(&d_BUF_30, sizeof(uint64_t) * COUNT30 * 1);
auto d_HT_30 = cuco::static_map{ (int)COUNT30*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)customer_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_30, d_BUF_IDX_30, d_HT_30.ref(cuco::insert), d_customer__c_custkey, d_customer__c_region, customer_size, d_cycles_per_warp_main_5_join_build_30, d_cycles_per_warp_main_5_selection_4, d_cycles_per_warp_main_5_selection_6, d_cycles_per_warp_main_5_selection_7, d_cycles_per_warp_main_5_selection_8, d_cycles_per_warp_main_5_selection_9);
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
int64_t* cycles_per_warp_main_5_selection_7 = (int64_t*)malloc(sizeof(int64_t) * main_5_selection_7_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_selection_7, d_cycles_per_warp_main_5_selection_7, sizeof(int64_t) * main_5_selection_7_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_selection_7 ";
for (auto i=0ull; i < main_5_selection_7_cpw_size; i++) std::cout << cycles_per_warp_main_5_selection_7[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_selection_8 = (int64_t*)malloc(sizeof(int64_t) * main_5_selection_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_selection_8, d_cycles_per_warp_main_5_selection_8, sizeof(int64_t) * main_5_selection_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_selection_8 ";
for (auto i=0ull; i < main_5_selection_8_cpw_size; i++) std::cout << cycles_per_warp_main_5_selection_8[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_selection_9 = (int64_t*)malloc(sizeof(int64_t) * main_5_selection_9_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_selection_9, d_cycles_per_warp_main_5_selection_9, sizeof(int64_t) * main_5_selection_9_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_selection_9 ";
for (auto i=0ull; i < main_5_selection_9_cpw_size; i++) std::cout << cycles_per_warp_main_5_selection_9[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_join_build_30 = (int64_t*)malloc(sizeof(int64_t) * main_5_join_build_30_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_join_build_30, d_cycles_per_warp_main_5_join_build_30, sizeof(int64_t) * main_5_join_build_30_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_join_build_30 ";
for (auto i=0ull; i < main_5_join_build_30_cpw_size; i++) std::cout << cycles_per_warp_main_5_join_build_30[i] << " ";
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
//Materialize count
uint64_t* d_COUNT31;
cudaMalloc(&d_COUNT31, sizeof(uint64_t));
cudaMemset(d_COUNT31, 0, sizeof(uint64_t));
count_1<<<std::ceil((float)date_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT31, d_date__d_year, date_size);
uint64_t COUNT31;
cudaMemcpy(&COUNT31, d_COUNT31, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_1_join_build_31;
auto main_1_join_build_31_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_build_31, sizeof(int64_t) * main_1_join_build_31_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_build_31, -1, sizeof(int64_t) * main_1_join_build_31_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_31;
cudaMalloc(&d_BUF_IDX_31, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_31, 0, sizeof(uint64_t));
uint64_t* d_BUF_31;
cudaMalloc(&d_BUF_31, sizeof(uint64_t) * COUNT31 * 1);
auto d_HT_31 = cuco::static_map{ (int)COUNT31*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)date_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_31, d_BUF_IDX_31, d_HT_31.ref(cuco::insert), d_cycles_per_warp_main_1_join_build_31, d_cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_2, d_cycles_per_warp_main_1_selection_3, d_date__d_datekey, d_date__d_year, date_size);
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
int64_t* cycles_per_warp_main_1_join_build_31 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_build_31_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_build_31, d_cycles_per_warp_main_1_join_build_31, sizeof(int64_t) * main_1_join_build_31_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_build_31 ";
for (auto i=0ull; i < main_1_join_build_31_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_build_31[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_17_selection_16;
auto main_17_selection_16_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_selection_16, sizeof(int64_t) * main_17_selection_16_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_selection_16, -1, sizeof(int64_t) * main_17_selection_16_cpw_size);
int64_t* d_cycles_per_warp_main_17_selection_18;
auto main_17_selection_18_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_selection_18, sizeof(int64_t) * main_17_selection_18_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_selection_18, -1, sizeof(int64_t) * main_17_selection_18_cpw_size);
int64_t* d_cycles_per_warp_main_17_selection_19;
auto main_17_selection_19_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_selection_19, sizeof(int64_t) * main_17_selection_19_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_selection_19, -1, sizeof(int64_t) * main_17_selection_19_cpw_size);
//Materialize count
uint64_t* d_COUNT32;
cudaMalloc(&d_COUNT32, sizeof(uint64_t));
cudaMemset(d_COUNT32, 0, sizeof(uint64_t));
count_17<<<std::ceil((float)part_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT32, d_part__p_mfgr, part_size);
uint64_t COUNT32;
cudaMemcpy(&COUNT32, d_COUNT32, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_17_join_build_32;
auto main_17_join_build_32_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_join_build_32, sizeof(int64_t) * main_17_join_build_32_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_join_build_32, -1, sizeof(int64_t) * main_17_join_build_32_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_32;
cudaMalloc(&d_BUF_IDX_32, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_32, 0, sizeof(uint64_t));
uint64_t* d_BUF_32;
cudaMalloc(&d_BUF_32, sizeof(uint64_t) * COUNT32 * 1);
auto d_HT_32 = cuco::static_map{ (int)COUNT32*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_17<<<std::ceil((float)part_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_32, d_BUF_IDX_32, d_HT_32.ref(cuco::insert), d_cycles_per_warp_main_17_join_build_32, d_cycles_per_warp_main_17_selection_16, d_cycles_per_warp_main_17_selection_18, d_cycles_per_warp_main_17_selection_19, d_part__p_mfgr, d_part__p_partkey, part_size);
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
int64_t* cycles_per_warp_main_17_join_build_32 = (int64_t*)malloc(sizeof(int64_t) * main_17_join_build_32_cpw_size);
cudaMemcpy(cycles_per_warp_main_17_join_build_32, d_cycles_per_warp_main_17_join_build_32, sizeof(int64_t) * main_17_join_build_32_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_17_join_build_32 ";
for (auto i=0ull; i < main_17_join_build_32_cpw_size; i++) std::cout << cycles_per_warp_main_17_join_build_32[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_21_selection_20;
auto main_21_selection_20_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_selection_20, sizeof(int64_t) * main_21_selection_20_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_selection_20, -1, sizeof(int64_t) * main_21_selection_20_cpw_size);
int64_t* d_cycles_per_warp_main_21_selection_22;
auto main_21_selection_22_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_selection_22, sizeof(int64_t) * main_21_selection_22_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_selection_22, -1, sizeof(int64_t) * main_21_selection_22_cpw_size);
int64_t* d_cycles_per_warp_main_21_selection_23;
auto main_21_selection_23_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_selection_23, sizeof(int64_t) * main_21_selection_23_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_selection_23, -1, sizeof(int64_t) * main_21_selection_23_cpw_size);
int64_t* d_cycles_per_warp_main_21_selection_24;
auto main_21_selection_24_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_selection_24, sizeof(int64_t) * main_21_selection_24_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_selection_24, -1, sizeof(int64_t) * main_21_selection_24_cpw_size);
int64_t* d_cycles_per_warp_main_21_selection_25;
auto main_21_selection_25_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_selection_25, sizeof(int64_t) * main_21_selection_25_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_selection_25, -1, sizeof(int64_t) * main_21_selection_25_cpw_size);
int64_t* d_cycles_per_warp_main_21_selection_26;
auto main_21_selection_26_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_selection_26, sizeof(int64_t) * main_21_selection_26_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_selection_26, -1, sizeof(int64_t) * main_21_selection_26_cpw_size);
int64_t* d_cycles_per_warp_main_21_selection_27;
auto main_21_selection_27_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_selection_27, sizeof(int64_t) * main_21_selection_27_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_selection_27, -1, sizeof(int64_t) * main_21_selection_27_cpw_size);
int64_t* d_cycles_per_warp_main_21_selection_28;
auto main_21_selection_28_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_selection_28, sizeof(int64_t) * main_21_selection_28_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_selection_28, -1, sizeof(int64_t) * main_21_selection_28_cpw_size);
int64_t* d_cycles_per_warp_main_21_join_probe_29;
auto main_21_join_probe_29_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_join_probe_29, sizeof(int64_t) * main_21_join_probe_29_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_join_probe_29, -1, sizeof(int64_t) * main_21_join_probe_29_cpw_size);
int64_t* d_cycles_per_warp_main_21_join_probe_30;
auto main_21_join_probe_30_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_join_probe_30, sizeof(int64_t) * main_21_join_probe_30_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_join_probe_30, -1, sizeof(int64_t) * main_21_join_probe_30_cpw_size);
int64_t* d_cycles_per_warp_main_21_join_probe_31;
auto main_21_join_probe_31_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_join_probe_31, sizeof(int64_t) * main_21_join_probe_31_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_join_probe_31, -1, sizeof(int64_t) * main_21_join_probe_31_cpw_size);
int64_t* d_cycles_per_warp_main_21_join_probe_32;
auto main_21_join_probe_32_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_join_probe_32, sizeof(int64_t) * main_21_join_probe_32_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_join_probe_32, -1, sizeof(int64_t) * main_21_join_probe_32_cpw_size);
int64_t* d_cycles_per_warp_main_21_map_33;
auto main_21_map_33_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_map_33, sizeof(int64_t) * main_21_map_33_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_map_33, -1, sizeof(int64_t) * main_21_map_33_cpw_size);
//Create aggregation hash table
auto d_HT_34 = cuco::static_map{ (int)24650*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_21<<<std::ceil((float)lineorder_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_29, d_BUF_30, d_BUF_31, d_BUF_32, d_HT_29.ref(cuco::find), d_HT_30.ref(cuco::find), d_HT_31.ref(cuco::find), d_HT_32.ref(cuco::find), d_HT_34.ref(cuco::insert), d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size, d_part__p_category_encoded, d_supplier__s_nation_encoded);
size_t COUNT34 = d_HT_34.size();
thrust::device_vector<int64_t> keys_34(COUNT34), vals_34(COUNT34);
d_HT_34.retrieve_all(keys_34.begin(), vals_34.begin());
d_HT_34.clear();
int64_t* raw_keys34 = thrust::raw_pointer_cast(keys_34.data());
insertKeys<<<std::ceil((float)COUNT34/128.), 128>>>(raw_keys34, d_HT_34.ref(cuco::insert), COUNT34);
int64_t* d_cycles_per_warp_main_21_aggregation_34;
auto main_21_aggregation_34_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_21_aggregation_34, sizeof(int64_t) * main_21_aggregation_34_cpw_size);
cudaMemset(d_cycles_per_warp_main_21_aggregation_34, -1, sizeof(int64_t) * main_21_aggregation_34_cpw_size);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT34);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT34);
DBI32Type* d_KEY_34date__d_year;
cudaMalloc(&d_KEY_34date__d_year, sizeof(DBI32Type) * COUNT34);
cudaMemset(d_KEY_34date__d_year, 0, sizeof(DBI32Type) * COUNT34);
DBI16Type* d_KEY_34supplier__s_nation_encoded;
cudaMalloc(&d_KEY_34supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT34);
cudaMemset(d_KEY_34supplier__s_nation_encoded, 0, sizeof(DBI16Type) * COUNT34);
DBI16Type* d_KEY_34part__p_category_encoded;
cudaMalloc(&d_KEY_34part__p_category_encoded, sizeof(DBI16Type) * COUNT34);
cudaMemset(d_KEY_34part__p_category_encoded, 0, sizeof(DBI16Type) * COUNT34);
main_21<<<std::ceil((float)lineorder_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_29, d_BUF_30, d_BUF_31, d_BUF_32, d_HT_29.ref(cuco::find), d_HT_30.ref(cuco::find), d_HT_31.ref(cuco::find), d_HT_32.ref(cuco::find), d_HT_34.ref(cuco::find), d_KEY_34date__d_year, d_KEY_34part__p_category_encoded, d_KEY_34supplier__s_nation_encoded, d_aggr0__tmp_attr0, d_cycles_per_warp_main_21_aggregation_34, d_cycles_per_warp_main_21_join_probe_29, d_cycles_per_warp_main_21_join_probe_30, d_cycles_per_warp_main_21_join_probe_31, d_cycles_per_warp_main_21_join_probe_32, d_cycles_per_warp_main_21_map_33, d_cycles_per_warp_main_21_selection_20, d_cycles_per_warp_main_21_selection_22, d_cycles_per_warp_main_21_selection_23, d_cycles_per_warp_main_21_selection_24, d_cycles_per_warp_main_21_selection_25, d_cycles_per_warp_main_21_selection_26, d_cycles_per_warp_main_21_selection_27, d_cycles_per_warp_main_21_selection_28, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, d_lineorder__lo_supplycost, lineorder_size, d_part__p_category_encoded, d_supplier__s_nation_encoded);
int64_t* cycles_per_warp_main_21_selection_20 = (int64_t*)malloc(sizeof(int64_t) * main_21_selection_20_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_selection_20, d_cycles_per_warp_main_21_selection_20, sizeof(int64_t) * main_21_selection_20_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_selection_20 ";
for (auto i=0ull; i < main_21_selection_20_cpw_size; i++) std::cout << cycles_per_warp_main_21_selection_20[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_21_selection_22 = (int64_t*)malloc(sizeof(int64_t) * main_21_selection_22_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_selection_22, d_cycles_per_warp_main_21_selection_22, sizeof(int64_t) * main_21_selection_22_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_selection_22 ";
for (auto i=0ull; i < main_21_selection_22_cpw_size; i++) std::cout << cycles_per_warp_main_21_selection_22[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_21_selection_23 = (int64_t*)malloc(sizeof(int64_t) * main_21_selection_23_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_selection_23, d_cycles_per_warp_main_21_selection_23, sizeof(int64_t) * main_21_selection_23_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_selection_23 ";
for (auto i=0ull; i < main_21_selection_23_cpw_size; i++) std::cout << cycles_per_warp_main_21_selection_23[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_21_selection_24 = (int64_t*)malloc(sizeof(int64_t) * main_21_selection_24_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_selection_24, d_cycles_per_warp_main_21_selection_24, sizeof(int64_t) * main_21_selection_24_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_selection_24 ";
for (auto i=0ull; i < main_21_selection_24_cpw_size; i++) std::cout << cycles_per_warp_main_21_selection_24[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_21_selection_25 = (int64_t*)malloc(sizeof(int64_t) * main_21_selection_25_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_selection_25, d_cycles_per_warp_main_21_selection_25, sizeof(int64_t) * main_21_selection_25_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_selection_25 ";
for (auto i=0ull; i < main_21_selection_25_cpw_size; i++) std::cout << cycles_per_warp_main_21_selection_25[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_21_selection_26 = (int64_t*)malloc(sizeof(int64_t) * main_21_selection_26_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_selection_26, d_cycles_per_warp_main_21_selection_26, sizeof(int64_t) * main_21_selection_26_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_selection_26 ";
for (auto i=0ull; i < main_21_selection_26_cpw_size; i++) std::cout << cycles_per_warp_main_21_selection_26[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_21_selection_27 = (int64_t*)malloc(sizeof(int64_t) * main_21_selection_27_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_selection_27, d_cycles_per_warp_main_21_selection_27, sizeof(int64_t) * main_21_selection_27_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_selection_27 ";
for (auto i=0ull; i < main_21_selection_27_cpw_size; i++) std::cout << cycles_per_warp_main_21_selection_27[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_21_selection_28 = (int64_t*)malloc(sizeof(int64_t) * main_21_selection_28_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_selection_28, d_cycles_per_warp_main_21_selection_28, sizeof(int64_t) * main_21_selection_28_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_selection_28 ";
for (auto i=0ull; i < main_21_selection_28_cpw_size; i++) std::cout << cycles_per_warp_main_21_selection_28[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_21_join_probe_29 = (int64_t*)malloc(sizeof(int64_t) * main_21_join_probe_29_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_join_probe_29, d_cycles_per_warp_main_21_join_probe_29, sizeof(int64_t) * main_21_join_probe_29_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_join_probe_29 ";
for (auto i=0ull; i < main_21_join_probe_29_cpw_size; i++) std::cout << cycles_per_warp_main_21_join_probe_29[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_21_join_probe_30 = (int64_t*)malloc(sizeof(int64_t) * main_21_join_probe_30_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_join_probe_30, d_cycles_per_warp_main_21_join_probe_30, sizeof(int64_t) * main_21_join_probe_30_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_join_probe_30 ";
for (auto i=0ull; i < main_21_join_probe_30_cpw_size; i++) std::cout << cycles_per_warp_main_21_join_probe_30[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_21_join_probe_31 = (int64_t*)malloc(sizeof(int64_t) * main_21_join_probe_31_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_join_probe_31, d_cycles_per_warp_main_21_join_probe_31, sizeof(int64_t) * main_21_join_probe_31_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_join_probe_31 ";
for (auto i=0ull; i < main_21_join_probe_31_cpw_size; i++) std::cout << cycles_per_warp_main_21_join_probe_31[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_21_join_probe_32 = (int64_t*)malloc(sizeof(int64_t) * main_21_join_probe_32_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_join_probe_32, d_cycles_per_warp_main_21_join_probe_32, sizeof(int64_t) * main_21_join_probe_32_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_join_probe_32 ";
for (auto i=0ull; i < main_21_join_probe_32_cpw_size; i++) std::cout << cycles_per_warp_main_21_join_probe_32[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_21_map_33 = (int64_t*)malloc(sizeof(int64_t) * main_21_map_33_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_map_33, d_cycles_per_warp_main_21_map_33, sizeof(int64_t) * main_21_map_33_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_map_33 ";
for (auto i=0ull; i < main_21_map_33_cpw_size; i++) std::cout << cycles_per_warp_main_21_map_33[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_21_aggregation_34 = (int64_t*)malloc(sizeof(int64_t) * main_21_aggregation_34_cpw_size);
cudaMemcpy(cycles_per_warp_main_21_aggregation_34, d_cycles_per_warp_main_21_aggregation_34, sizeof(int64_t) * main_21_aggregation_34_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_21_aggregation_34 ";
for (auto i=0ull; i < main_21_aggregation_34_cpw_size; i++) std::cout << cycles_per_warp_main_21_aggregation_34[i] << " ";
std::cout << std::endl;
//Materialize count
uint64_t* d_COUNT35;
cudaMalloc(&d_COUNT35, sizeof(uint64_t));
cudaMemset(d_COUNT35, 0, sizeof(uint64_t));
count_36<<<std::ceil((float)COUNT34/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT34, d_COUNT35);
uint64_t COUNT35;
cudaMemcpy(&COUNT35, d_COUNT35, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_36_materialize_35;
auto main_36_materialize_35_cpw_size = std::ceil((float)COUNT34/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_36_materialize_35, sizeof(int64_t) * main_36_materialize_35_cpw_size);
cudaMemset(d_cycles_per_warp_main_36_materialize_35, -1, sizeof(int64_t) * main_36_materialize_35_cpw_size);
//Materialize buffers
uint64_t* d_MAT_IDX35;
cudaMalloc(&d_MAT_IDX35, sizeof(uint64_t));
cudaMemset(d_MAT_IDX35, 0, sizeof(uint64_t));
auto MAT35date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT35);
DBI32Type* d_MAT35date__d_year;
cudaMalloc(&d_MAT35date__d_year, sizeof(DBI32Type) * COUNT35);
auto MAT35supplier__s_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT35);
DBI16Type* d_MAT35supplier__s_nation_encoded;
cudaMalloc(&d_MAT35supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT35);
auto MAT35part__p_category_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT35);
DBI16Type* d_MAT35part__p_category_encoded;
cudaMalloc(&d_MAT35part__p_category_encoded, sizeof(DBI16Type) * COUNT35);
auto MAT35aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT35);
DBDecimalType* d_MAT35aggr0__tmp_attr0;
cudaMalloc(&d_MAT35aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT35);
main_36<<<std::ceil((float)COUNT34/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT34, d_MAT35aggr0__tmp_attr0, d_MAT35date__d_year, d_MAT35part__p_category_encoded, d_MAT35supplier__s_nation_encoded, d_MAT_IDX35, d_aggr0__tmp_attr0, d_cycles_per_warp_main_36_materialize_35, d_KEY_34date__d_year, d_KEY_34part__p_category_encoded, d_KEY_34supplier__s_nation_encoded);
cudaMemcpy(MAT35date__d_year, d_MAT35date__d_year, sizeof(DBI32Type) * COUNT35, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT35supplier__s_nation_encoded, d_MAT35supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT35, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT35part__p_category_encoded, d_MAT35part__p_category_encoded, sizeof(DBI16Type) * COUNT35, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT35aggr0__tmp_attr0, d_MAT35aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT35, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_36_materialize_35 = (int64_t*)malloc(sizeof(int64_t) * main_36_materialize_35_cpw_size);
cudaMemcpy(cycles_per_warp_main_36_materialize_35, d_cycles_per_warp_main_36_materialize_35, sizeof(int64_t) * main_36_materialize_35_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_36_materialize_35 ";
for (auto i=0ull; i < main_36_materialize_35_cpw_size; i++) std::cout << cycles_per_warp_main_36_materialize_35[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
      size_t aux_mem = usedGpuMem() - used_mem;
      std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_29);
cudaFree(d_BUF_IDX_29);
cudaFree(d_COUNT29);
cudaFree(d_BUF_30);
cudaFree(d_BUF_IDX_30);
cudaFree(d_COUNT30);
cudaFree(d_BUF_31);
cudaFree(d_BUF_IDX_31);
cudaFree(d_COUNT31);
cudaFree(d_BUF_32);
cudaFree(d_BUF_IDX_32);
cudaFree(d_COUNT32);
cudaFree(d_KEY_34date__d_year);
cudaFree(d_KEY_34part__p_category_encoded);
cudaFree(d_KEY_34supplier__s_nation_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT35);
cudaFree(d_MAT35aggr0__tmp_attr0);
cudaFree(d_MAT35date__d_year);
cudaFree(d_MAT35part__p_category_encoded);
cudaFree(d_MAT35supplier__s_nation_encoded);
cudaFree(d_MAT_IDX35);
free(MAT35aggr0__tmp_attr0);
free(MAT35date__d_year);
free(MAT35part__p_category_encoded);
free(MAT35supplier__s_nation_encoded);
}