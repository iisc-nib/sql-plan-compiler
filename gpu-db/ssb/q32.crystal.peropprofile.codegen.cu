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
__global__ void count_14(uint64_t* COUNT19, DBStringType* supplier__s_nation, size_t supplier_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
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
atomicAdd((int*)COUNT19, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_14(uint64_t* BUF_19, uint64_t* BUF_IDX_19, HASHTABLE_INSERT HT_19, int64_t* cycles_per_warp_main_14_join_build_19, int64_t* cycles_per_warp_main_14_selection_13, int64_t* cycles_per_warp_main_14_selection_15, int64_t* cycles_per_warp_main_14_selection_16, int64_t* cycles_per_warp_main_14_selection_17, int64_t* cycles_per_warp_main_14_selection_18, DBStringType* supplier__s_nation, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_selection_13[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_selection_15[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_selection_16[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_selection_17[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_selection_18[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_19[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_19[ITEM] = 0;
KEY_19[ITEM] |= reg_supplier__s_suppkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_19 = atomicAdd((int*)BUF_IDX_19, 1);
HT_19.insert(cuco::pair{KEY_19[ITEM], buf_idx_19});
BUF_19[(buf_idx_19) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_14_join_build_19[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_1(uint64_t* COUNT20, DBStringType* customer__c_nation, size_t customer_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBStringType reg_customer__c_nation[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_nation[ITEM] = customer__c_nation[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_customer__c_nation[ITEM], "UNITED STATES", Predicate::eq);
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
atomicAdd((int*)COUNT20, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_20, uint64_t* BUF_IDX_20, HASHTABLE_INSERT HT_20, DBI32Type* customer__c_custkey, DBStringType* customer__c_nation, size_t customer_size, int64_t* cycles_per_warp_main_1_join_build_20, int64_t* cycles_per_warp_main_1_selection_0, int64_t* cycles_per_warp_main_1_selection_2, int64_t* cycles_per_warp_main_1_selection_3, int64_t* cycles_per_warp_main_1_selection_4, int64_t* cycles_per_warp_main_1_selection_5) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_customer__c_nation[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_nation[ITEM] = customer__c_nation[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_customer__c_nation[ITEM], "UNITED STATES", Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_3[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_5[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_20[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_20[ITEM] = 0;
KEY_20[ITEM] |= reg_customer__c_custkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_20 = atomicAdd((int*)BUF_IDX_20, 1);
HT_20.insert(cuco::pair{KEY_20[ITEM], buf_idx_20});
BUF_20[(buf_idx_20) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_build_20[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_22(uint64_t* COUNT27, DBI32Type* date__d_year, size_t date_size) {
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
selection_flags[ITEM] &= evaluatePredicate(reg_date__d_year[ITEM], 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year[ITEM], 1997, Predicate::lte);
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
atomicAdd((int*)COUNT27, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_22(uint64_t* BUF_27, uint64_t* BUF_IDX_27, HASHTABLE_INSERT HT_27, int64_t* cycles_per_warp_main_22_join_build_27, int64_t* cycles_per_warp_main_22_selection_21, int64_t* cycles_per_warp_main_22_selection_23, int64_t* cycles_per_warp_main_22_selection_24, int64_t* cycles_per_warp_main_22_selection_25, int64_t* cycles_per_warp_main_22_selection_26, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
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
selection_flags[ITEM] &= evaluatePredicate(reg_date__d_year[ITEM], 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year[ITEM], 1997, Predicate::lte);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_22_selection_21[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_22_selection_23[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_22_selection_24[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_22_selection_25[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_22_selection_26[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_27[ITEMS_PER_THREAD];
DBI32Type reg_date__d_datekey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
reg_date__d_datekey[ITEM] = date__d_datekey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_27[ITEM] = 0;
KEY_27[ITEM] |= reg_date__d_datekey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_27 = atomicAdd((int*)BUF_IDX_27, 1);
HT_27.insert(cuco::pair{KEY_27[ITEM], buf_idx_27});
BUF_27[(buf_idx_27) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_22_join_build_27[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void count_7(uint64_t* BUF_19, uint64_t* BUF_20, uint64_t* BUF_27, HASHTABLE_PROBE HT_19, HASHTABLE_PROBE HT_20, HASHTABLE_PROBE HT_27, HASHTABLE_INSERT HT_28, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_city_encoded) {
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
uint64_t KEY_19[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_suppkey[ITEM] = lineorder__lo_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_19[ITEM] = 0;
KEY_19[ITEM] |= reg_lineorder__lo_suppkey[ITEM];
}
int64_t slot_second19[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_19 = HT_19.find(KEY_19[ITEM]);
if (SLOT_19 == HT_19.end()) {selection_flags[ITEM] = 0; continue;}
slot_second19[ITEM] = SLOT_19->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_20[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_custkey[ITEM] = lineorder__lo_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_20[ITEM] = 0;
KEY_20[ITEM] |= reg_lineorder__lo_custkey[ITEM];
}
int64_t slot_second20[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_20 = HT_20.find(KEY_20[ITEM]);
if (SLOT_20 == HT_20.end()) {selection_flags[ITEM] = 0; continue;}
slot_second20[ITEM] = SLOT_20->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_27[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_orderdate[ITEM] = lineorder__lo_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_27[ITEM] = 0;
KEY_27[ITEM] |= reg_lineorder__lo_orderdate[ITEM];
}
int64_t slot_second27[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_27 = HT_27.find(KEY_27[ITEM]);
if (SLOT_27 == HT_27.end()) {selection_flags[ITEM] = 0; continue;}
slot_second27[ITEM] = SLOT_27->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_28[ITEMS_PER_THREAD];
DBI16Type reg_customer__c_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_city_encoded[ITEM] = customer__c_city_encoded[BUF_20[slot_second20[ITEM] * 1 + 0]];
}
DBI16Type reg_supplier__s_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_supplier__s_city_encoded[ITEM] = supplier__s_city_encoded[BUF_19[slot_second19[ITEM] * 1 + 0]];
}
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_date__d_year[ITEM] = date__d_year[BUF_27[slot_second27[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_28[ITEM] = 0;
KEY_28[ITEM] |= reg_customer__c_city_encoded[ITEM];
KEY_28[ITEM] <<= 16;
KEY_28[ITEM] |= reg_supplier__s_city_encoded[ITEM];
KEY_28[ITEM] <<= 32;
KEY_28[ITEM] |= reg_date__d_year[ITEM];
}
//Create aggregation hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_28.insert(cuco::pair{KEY_28[ITEM], 1});
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_7(uint64_t* BUF_19, uint64_t* BUF_20, uint64_t* BUF_27, HASHTABLE_PROBE HT_19, HASHTABLE_PROBE HT_20, HASHTABLE_PROBE HT_27, HASHTABLE_FIND HT_28, DBI16Type* KEY_28customer__c_city_encoded, DBI32Type* KEY_28date__d_year, DBI16Type* KEY_28supplier__s_city_encoded, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, int64_t* cycles_per_warp_main_7_aggregation_28, int64_t* cycles_per_warp_main_7_join_probe_19, int64_t* cycles_per_warp_main_7_join_probe_20, int64_t* cycles_per_warp_main_7_join_probe_27, int64_t* cycles_per_warp_main_7_selection_10, int64_t* cycles_per_warp_main_7_selection_11, int64_t* cycles_per_warp_main_7_selection_12, int64_t* cycles_per_warp_main_7_selection_6, int64_t* cycles_per_warp_main_7_selection_8, int64_t* cycles_per_warp_main_7_selection_9, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_city_encoded) {
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_6[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_9[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_10[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_11[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_selection_12[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_19[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_suppkey[ITEM] = lineorder__lo_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_19[ITEM] = 0;
KEY_19[ITEM] |= reg_lineorder__lo_suppkey[ITEM];
}
int64_t slot_second19[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_19 = HT_19.find(KEY_19[ITEM]);
if (SLOT_19 == HT_19.end()) {selection_flags[ITEM] = 0; continue;}
slot_second19[ITEM] = SLOT_19->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_probe_19[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_20[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_custkey[ITEM] = lineorder__lo_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_20[ITEM] = 0;
KEY_20[ITEM] |= reg_lineorder__lo_custkey[ITEM];
}
int64_t slot_second20[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_20 = HT_20.find(KEY_20[ITEM]);
if (SLOT_20 == HT_20.end()) {selection_flags[ITEM] = 0; continue;}
slot_second20[ITEM] = SLOT_20->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_probe_20[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_27[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_orderdate[ITEM] = lineorder__lo_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_27[ITEM] = 0;
KEY_27[ITEM] |= reg_lineorder__lo_orderdate[ITEM];
}
int64_t slot_second27[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_27 = HT_27.find(KEY_27[ITEM]);
if (SLOT_27 == HT_27.end()) {selection_flags[ITEM] = 0; continue;}
slot_second27[ITEM] = SLOT_27->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_probe_27[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_28[ITEMS_PER_THREAD];
DBI16Type reg_customer__c_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_city_encoded[ITEM] = customer__c_city_encoded[BUF_20[slot_second20[ITEM] * 1 + 0]];
}
DBI16Type reg_supplier__s_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_supplier__s_city_encoded[ITEM] = supplier__s_city_encoded[BUF_19[slot_second19[ITEM] * 1 + 0]];
}
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_date__d_year[ITEM] = date__d_year[BUF_27[slot_second27[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_28[ITEM] = 0;
KEY_28[ITEM] |= reg_customer__c_city_encoded[ITEM];
KEY_28[ITEM] <<= 16;
KEY_28[ITEM] |= reg_supplier__s_city_encoded[ITEM];
KEY_28[ITEM] <<= 32;
KEY_28[ITEM] |= reg_date__d_year[ITEM];
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
auto buf_idx_28 = HT_28.find(KEY_28[ITEM])->second;
aggregate_sum(&aggr0__tmp_attr0[buf_idx_28], reg_lineorder__lo_revenue[ITEM]);
KEY_28customer__c_city_encoded[buf_idx_28] = reg_customer__c_city_encoded[ITEM];
KEY_28supplier__s_city_encoded[buf_idx_28] = reg_supplier__s_city_encoded[ITEM];
KEY_28date__d_year[buf_idx_28] = reg_date__d_year[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_aggregation_28[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_30(size_t COUNT28, uint64_t* COUNT29) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT28); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT29, 1);
}
}
__global__ void main_30(size_t COUNT28, DBDecimalType* MAT29aggr0__tmp_attr0, DBI16Type* MAT29customer__c_city_encoded, DBI32Type* MAT29date__d_year, DBI16Type* MAT29supplier__s_city_encoded, uint64_t* MAT_IDX29, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, int64_t* cycles_per_warp_main_30_materialize_29, DBI32Type* date__d_year, DBI16Type* supplier__s_city_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI16Type reg_customer__c_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT28); ++ITEM) {
reg_customer__c_city_encoded[ITEM] = customer__c_city_encoded[ITEM*TB + tid];
}
DBI16Type reg_supplier__s_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT28); ++ITEM) {
reg_supplier__s_city_encoded[ITEM] = supplier__s_city_encoded[ITEM*TB + tid];
}
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT28); ++ITEM) {
reg_date__d_year[ITEM] = date__d_year[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT28); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT28); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx29 = atomicAdd((int*)MAT_IDX29, 1);
MAT29customer__c_city_encoded[mat_idx29] = reg_customer__c_city_encoded[ITEM];
MAT29supplier__s_city_encoded[mat_idx29] = reg_supplier__s_city_encoded[ITEM];
MAT29date__d_year[mat_idx29] = reg_date__d_year[ITEM];
MAT29aggr0__tmp_attr0[mat_idx29] = reg_aggr0__tmp_attr0[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_30_materialize_29[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_14_selection_13;
auto main_14_selection_13_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_selection_13, sizeof(int64_t) * main_14_selection_13_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_selection_13, -1, sizeof(int64_t) * main_14_selection_13_cpw_size);
int64_t* d_cycles_per_warp_main_14_selection_15;
auto main_14_selection_15_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_selection_15, sizeof(int64_t) * main_14_selection_15_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_selection_15, -1, sizeof(int64_t) * main_14_selection_15_cpw_size);
int64_t* d_cycles_per_warp_main_14_selection_16;
auto main_14_selection_16_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_selection_16, sizeof(int64_t) * main_14_selection_16_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_selection_16, -1, sizeof(int64_t) * main_14_selection_16_cpw_size);
int64_t* d_cycles_per_warp_main_14_selection_17;
auto main_14_selection_17_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_selection_17, sizeof(int64_t) * main_14_selection_17_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_selection_17, -1, sizeof(int64_t) * main_14_selection_17_cpw_size);
int64_t* d_cycles_per_warp_main_14_selection_18;
auto main_14_selection_18_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_selection_18, sizeof(int64_t) * main_14_selection_18_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_selection_18, -1, sizeof(int64_t) * main_14_selection_18_cpw_size);
//Materialize count
uint64_t* d_COUNT19;
cudaMalloc(&d_COUNT19, sizeof(uint64_t));
cudaMemset(d_COUNT19, 0, sizeof(uint64_t));
count_14<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT19, d_supplier__s_nation, supplier_size);
uint64_t COUNT19;
cudaMemcpy(&COUNT19, d_COUNT19, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_14_join_build_19;
auto main_14_join_build_19_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_14_join_build_19, sizeof(int64_t) * main_14_join_build_19_cpw_size);
cudaMemset(d_cycles_per_warp_main_14_join_build_19, -1, sizeof(int64_t) * main_14_join_build_19_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_19;
cudaMalloc(&d_BUF_IDX_19, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_19, 0, sizeof(uint64_t));
uint64_t* d_BUF_19;
cudaMalloc(&d_BUF_19, sizeof(uint64_t) * COUNT19 * 1);
auto d_HT_19 = cuco::static_map{ (int)COUNT19*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_14<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_19, d_BUF_IDX_19, d_HT_19.ref(cuco::insert), d_cycles_per_warp_main_14_join_build_19, d_cycles_per_warp_main_14_selection_13, d_cycles_per_warp_main_14_selection_15, d_cycles_per_warp_main_14_selection_16, d_cycles_per_warp_main_14_selection_17, d_cycles_per_warp_main_14_selection_18, d_supplier__s_nation, d_supplier__s_suppkey, supplier_size);
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
int64_t* cycles_per_warp_main_14_join_build_19 = (int64_t*)malloc(sizeof(int64_t) * main_14_join_build_19_cpw_size);
cudaMemcpy(cycles_per_warp_main_14_join_build_19, d_cycles_per_warp_main_14_join_build_19, sizeof(int64_t) * main_14_join_build_19_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_14_join_build_19 ";
for (auto i=0ull; i < main_14_join_build_19_cpw_size; i++) std::cout << cycles_per_warp_main_14_join_build_19[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_2;
auto main_1_selection_2_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_2, sizeof(int64_t) * main_1_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_2, -1, sizeof(int64_t) * main_1_selection_2_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_3;
auto main_1_selection_3_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_3, sizeof(int64_t) * main_1_selection_3_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_3, -1, sizeof(int64_t) * main_1_selection_3_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_4;
auto main_1_selection_4_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_4, sizeof(int64_t) * main_1_selection_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_4, -1, sizeof(int64_t) * main_1_selection_4_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_5;
auto main_1_selection_5_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_5, sizeof(int64_t) * main_1_selection_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_5, -1, sizeof(int64_t) * main_1_selection_5_cpw_size);
//Materialize count
uint64_t* d_COUNT20;
cudaMalloc(&d_COUNT20, sizeof(uint64_t));
cudaMemset(d_COUNT20, 0, sizeof(uint64_t));
count_1<<<std::ceil((float)customer_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT20, d_customer__c_nation, customer_size);
uint64_t COUNT20;
cudaMemcpy(&COUNT20, d_COUNT20, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_1_join_build_20;
auto main_1_join_build_20_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_build_20, sizeof(int64_t) * main_1_join_build_20_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_build_20, -1, sizeof(int64_t) * main_1_join_build_20_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_20;
cudaMalloc(&d_BUF_IDX_20, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_20, 0, sizeof(uint64_t));
uint64_t* d_BUF_20;
cudaMalloc(&d_BUF_20, sizeof(uint64_t) * COUNT20 * 1);
auto d_HT_20 = cuco::static_map{ (int)COUNT20*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)customer_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_20, d_BUF_IDX_20, d_HT_20.ref(cuco::insert), d_customer__c_custkey, d_customer__c_nation, customer_size, d_cycles_per_warp_main_1_join_build_20, d_cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_2, d_cycles_per_warp_main_1_selection_3, d_cycles_per_warp_main_1_selection_4, d_cycles_per_warp_main_1_selection_5);
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
int64_t* cycles_per_warp_main_1_join_build_20 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_build_20_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_build_20, d_cycles_per_warp_main_1_join_build_20, sizeof(int64_t) * main_1_join_build_20_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_build_20 ";
for (auto i=0ull; i < main_1_join_build_20_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_build_20[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_22_selection_21;
auto main_22_selection_21_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_22_selection_21, sizeof(int64_t) * main_22_selection_21_cpw_size);
cudaMemset(d_cycles_per_warp_main_22_selection_21, -1, sizeof(int64_t) * main_22_selection_21_cpw_size);
int64_t* d_cycles_per_warp_main_22_selection_23;
auto main_22_selection_23_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_22_selection_23, sizeof(int64_t) * main_22_selection_23_cpw_size);
cudaMemset(d_cycles_per_warp_main_22_selection_23, -1, sizeof(int64_t) * main_22_selection_23_cpw_size);
int64_t* d_cycles_per_warp_main_22_selection_24;
auto main_22_selection_24_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_22_selection_24, sizeof(int64_t) * main_22_selection_24_cpw_size);
cudaMemset(d_cycles_per_warp_main_22_selection_24, -1, sizeof(int64_t) * main_22_selection_24_cpw_size);
int64_t* d_cycles_per_warp_main_22_selection_25;
auto main_22_selection_25_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_22_selection_25, sizeof(int64_t) * main_22_selection_25_cpw_size);
cudaMemset(d_cycles_per_warp_main_22_selection_25, -1, sizeof(int64_t) * main_22_selection_25_cpw_size);
int64_t* d_cycles_per_warp_main_22_selection_26;
auto main_22_selection_26_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_22_selection_26, sizeof(int64_t) * main_22_selection_26_cpw_size);
cudaMemset(d_cycles_per_warp_main_22_selection_26, -1, sizeof(int64_t) * main_22_selection_26_cpw_size);
//Materialize count
uint64_t* d_COUNT27;
cudaMalloc(&d_COUNT27, sizeof(uint64_t));
cudaMemset(d_COUNT27, 0, sizeof(uint64_t));
count_22<<<std::ceil((float)date_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT27, d_date__d_year, date_size);
uint64_t COUNT27;
cudaMemcpy(&COUNT27, d_COUNT27, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_22_join_build_27;
auto main_22_join_build_27_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_22_join_build_27, sizeof(int64_t) * main_22_join_build_27_cpw_size);
cudaMemset(d_cycles_per_warp_main_22_join_build_27, -1, sizeof(int64_t) * main_22_join_build_27_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_27;
cudaMalloc(&d_BUF_IDX_27, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_27, 0, sizeof(uint64_t));
uint64_t* d_BUF_27;
cudaMalloc(&d_BUF_27, sizeof(uint64_t) * COUNT27 * 1);
auto d_HT_27 = cuco::static_map{ (int)COUNT27*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_22<<<std::ceil((float)date_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_27, d_BUF_IDX_27, d_HT_27.ref(cuco::insert), d_cycles_per_warp_main_22_join_build_27, d_cycles_per_warp_main_22_selection_21, d_cycles_per_warp_main_22_selection_23, d_cycles_per_warp_main_22_selection_24, d_cycles_per_warp_main_22_selection_25, d_cycles_per_warp_main_22_selection_26, d_date__d_datekey, d_date__d_year, date_size);
int64_t* cycles_per_warp_main_22_selection_21 = (int64_t*)malloc(sizeof(int64_t) * main_22_selection_21_cpw_size);
cudaMemcpy(cycles_per_warp_main_22_selection_21, d_cycles_per_warp_main_22_selection_21, sizeof(int64_t) * main_22_selection_21_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_22_selection_21 ";
for (auto i=0ull; i < main_22_selection_21_cpw_size; i++) std::cout << cycles_per_warp_main_22_selection_21[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_22_selection_23 = (int64_t*)malloc(sizeof(int64_t) * main_22_selection_23_cpw_size);
cudaMemcpy(cycles_per_warp_main_22_selection_23, d_cycles_per_warp_main_22_selection_23, sizeof(int64_t) * main_22_selection_23_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_22_selection_23 ";
for (auto i=0ull; i < main_22_selection_23_cpw_size; i++) std::cout << cycles_per_warp_main_22_selection_23[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_22_selection_24 = (int64_t*)malloc(sizeof(int64_t) * main_22_selection_24_cpw_size);
cudaMemcpy(cycles_per_warp_main_22_selection_24, d_cycles_per_warp_main_22_selection_24, sizeof(int64_t) * main_22_selection_24_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_22_selection_24 ";
for (auto i=0ull; i < main_22_selection_24_cpw_size; i++) std::cout << cycles_per_warp_main_22_selection_24[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_22_selection_25 = (int64_t*)malloc(sizeof(int64_t) * main_22_selection_25_cpw_size);
cudaMemcpy(cycles_per_warp_main_22_selection_25, d_cycles_per_warp_main_22_selection_25, sizeof(int64_t) * main_22_selection_25_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_22_selection_25 ";
for (auto i=0ull; i < main_22_selection_25_cpw_size; i++) std::cout << cycles_per_warp_main_22_selection_25[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_22_selection_26 = (int64_t*)malloc(sizeof(int64_t) * main_22_selection_26_cpw_size);
cudaMemcpy(cycles_per_warp_main_22_selection_26, d_cycles_per_warp_main_22_selection_26, sizeof(int64_t) * main_22_selection_26_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_22_selection_26 ";
for (auto i=0ull; i < main_22_selection_26_cpw_size; i++) std::cout << cycles_per_warp_main_22_selection_26[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_22_join_build_27 = (int64_t*)malloc(sizeof(int64_t) * main_22_join_build_27_cpw_size);
cudaMemcpy(cycles_per_warp_main_22_join_build_27, d_cycles_per_warp_main_22_join_build_27, sizeof(int64_t) * main_22_join_build_27_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_22_join_build_27 ";
for (auto i=0ull; i < main_22_join_build_27_cpw_size; i++) std::cout << cycles_per_warp_main_22_join_build_27[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_7_selection_6;
auto main_7_selection_6_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_6, sizeof(int64_t) * main_7_selection_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_6, -1, sizeof(int64_t) * main_7_selection_6_cpw_size);
int64_t* d_cycles_per_warp_main_7_selection_8;
auto main_7_selection_8_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_8, sizeof(int64_t) * main_7_selection_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_8, -1, sizeof(int64_t) * main_7_selection_8_cpw_size);
int64_t* d_cycles_per_warp_main_7_selection_9;
auto main_7_selection_9_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_9, sizeof(int64_t) * main_7_selection_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_9, -1, sizeof(int64_t) * main_7_selection_9_cpw_size);
int64_t* d_cycles_per_warp_main_7_selection_10;
auto main_7_selection_10_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_10, sizeof(int64_t) * main_7_selection_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_10, -1, sizeof(int64_t) * main_7_selection_10_cpw_size);
int64_t* d_cycles_per_warp_main_7_selection_11;
auto main_7_selection_11_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_11, sizeof(int64_t) * main_7_selection_11_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_11, -1, sizeof(int64_t) * main_7_selection_11_cpw_size);
int64_t* d_cycles_per_warp_main_7_selection_12;
auto main_7_selection_12_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_selection_12, sizeof(int64_t) * main_7_selection_12_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_selection_12, -1, sizeof(int64_t) * main_7_selection_12_cpw_size);
int64_t* d_cycles_per_warp_main_7_join_probe_19;
auto main_7_join_probe_19_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_probe_19, sizeof(int64_t) * main_7_join_probe_19_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_probe_19, -1, sizeof(int64_t) * main_7_join_probe_19_cpw_size);
int64_t* d_cycles_per_warp_main_7_join_probe_20;
auto main_7_join_probe_20_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_probe_20, sizeof(int64_t) * main_7_join_probe_20_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_probe_20, -1, sizeof(int64_t) * main_7_join_probe_20_cpw_size);
int64_t* d_cycles_per_warp_main_7_join_probe_27;
auto main_7_join_probe_27_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_probe_27, sizeof(int64_t) * main_7_join_probe_27_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_probe_27, -1, sizeof(int64_t) * main_7_join_probe_27_cpw_size);
//Create aggregation hash table
auto d_HT_28 = cuco::static_map{ (int)5679*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_7<<<std::ceil((float)lineorder_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_19, d_BUF_20, d_BUF_27, d_HT_19.ref(cuco::find), d_HT_20.ref(cuco::find), d_HT_27.ref(cuco::find), d_HT_28.ref(cuco::insert), d_customer__c_city_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_city_encoded);
size_t COUNT28 = d_HT_28.size();
thrust::device_vector<int64_t> keys_28(COUNT28), vals_28(COUNT28);
d_HT_28.retrieve_all(keys_28.begin(), vals_28.begin());
d_HT_28.clear();
int64_t* raw_keys28 = thrust::raw_pointer_cast(keys_28.data());
insertKeys<<<std::ceil((float)COUNT28/128.), 128>>>(raw_keys28, d_HT_28.ref(cuco::insert), COUNT28);
int64_t* d_cycles_per_warp_main_7_aggregation_28;
auto main_7_aggregation_28_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_aggregation_28, sizeof(int64_t) * main_7_aggregation_28_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_aggregation_28, -1, sizeof(int64_t) * main_7_aggregation_28_cpw_size);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT28);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT28);
DBI16Type* d_KEY_28customer__c_city_encoded;
cudaMalloc(&d_KEY_28customer__c_city_encoded, sizeof(DBI16Type) * COUNT28);
cudaMemset(d_KEY_28customer__c_city_encoded, 0, sizeof(DBI16Type) * COUNT28);
DBI16Type* d_KEY_28supplier__s_city_encoded;
cudaMalloc(&d_KEY_28supplier__s_city_encoded, sizeof(DBI16Type) * COUNT28);
cudaMemset(d_KEY_28supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT28);
DBI32Type* d_KEY_28date__d_year;
cudaMalloc(&d_KEY_28date__d_year, sizeof(DBI32Type) * COUNT28);
cudaMemset(d_KEY_28date__d_year, 0, sizeof(DBI32Type) * COUNT28);
main_7<<<std::ceil((float)lineorder_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_19, d_BUF_20, d_BUF_27, d_HT_19.ref(cuco::find), d_HT_20.ref(cuco::find), d_HT_27.ref(cuco::find), d_HT_28.ref(cuco::find), d_KEY_28customer__c_city_encoded, d_KEY_28date__d_year, d_KEY_28supplier__s_city_encoded, d_aggr0__tmp_attr0, d_customer__c_city_encoded, d_cycles_per_warp_main_7_aggregation_28, d_cycles_per_warp_main_7_join_probe_19, d_cycles_per_warp_main_7_join_probe_20, d_cycles_per_warp_main_7_join_probe_27, d_cycles_per_warp_main_7_selection_10, d_cycles_per_warp_main_7_selection_11, d_cycles_per_warp_main_7_selection_12, d_cycles_per_warp_main_7_selection_6, d_cycles_per_warp_main_7_selection_8, d_cycles_per_warp_main_7_selection_9, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_city_encoded);
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
int64_t* cycles_per_warp_main_7_join_probe_19 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_probe_19_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_probe_19, d_cycles_per_warp_main_7_join_probe_19, sizeof(int64_t) * main_7_join_probe_19_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_probe_19 ";
for (auto i=0ull; i < main_7_join_probe_19_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_probe_19[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_join_probe_20 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_probe_20_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_probe_20, d_cycles_per_warp_main_7_join_probe_20, sizeof(int64_t) * main_7_join_probe_20_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_probe_20 ";
for (auto i=0ull; i < main_7_join_probe_20_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_probe_20[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_join_probe_27 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_probe_27_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_probe_27, d_cycles_per_warp_main_7_join_probe_27, sizeof(int64_t) * main_7_join_probe_27_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_probe_27 ";
for (auto i=0ull; i < main_7_join_probe_27_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_probe_27[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_aggregation_28 = (int64_t*)malloc(sizeof(int64_t) * main_7_aggregation_28_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_aggregation_28, d_cycles_per_warp_main_7_aggregation_28, sizeof(int64_t) * main_7_aggregation_28_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_aggregation_28 ";
for (auto i=0ull; i < main_7_aggregation_28_cpw_size; i++) std::cout << cycles_per_warp_main_7_aggregation_28[i] << " ";
std::cout << std::endl;
//Materialize count
uint64_t* d_COUNT29;
cudaMalloc(&d_COUNT29, sizeof(uint64_t));
cudaMemset(d_COUNT29, 0, sizeof(uint64_t));
count_30<<<std::ceil((float)COUNT28/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT28, d_COUNT29);
uint64_t COUNT29;
cudaMemcpy(&COUNT29, d_COUNT29, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_30_materialize_29;
auto main_30_materialize_29_cpw_size = std::ceil((float)COUNT28/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_30_materialize_29, sizeof(int64_t) * main_30_materialize_29_cpw_size);
cudaMemset(d_cycles_per_warp_main_30_materialize_29, -1, sizeof(int64_t) * main_30_materialize_29_cpw_size);
//Materialize buffers
uint64_t* d_MAT_IDX29;
cudaMalloc(&d_MAT_IDX29, sizeof(uint64_t));
cudaMemset(d_MAT_IDX29, 0, sizeof(uint64_t));
auto MAT29customer__c_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT29);
DBI16Type* d_MAT29customer__c_city_encoded;
cudaMalloc(&d_MAT29customer__c_city_encoded, sizeof(DBI16Type) * COUNT29);
auto MAT29supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT29);
DBI16Type* d_MAT29supplier__s_city_encoded;
cudaMalloc(&d_MAT29supplier__s_city_encoded, sizeof(DBI16Type) * COUNT29);
auto MAT29date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT29);
DBI32Type* d_MAT29date__d_year;
cudaMalloc(&d_MAT29date__d_year, sizeof(DBI32Type) * COUNT29);
auto MAT29aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT29);
DBDecimalType* d_MAT29aggr0__tmp_attr0;
cudaMalloc(&d_MAT29aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT29);
main_30<<<std::ceil((float)COUNT28/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT28, d_MAT29aggr0__tmp_attr0, d_MAT29customer__c_city_encoded, d_MAT29date__d_year, d_MAT29supplier__s_city_encoded, d_MAT_IDX29, d_aggr0__tmp_attr0, d_KEY_28customer__c_city_encoded, d_cycles_per_warp_main_30_materialize_29, d_KEY_28date__d_year, d_KEY_28supplier__s_city_encoded);
cudaMemcpy(MAT29customer__c_city_encoded, d_MAT29customer__c_city_encoded, sizeof(DBI16Type) * COUNT29, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT29supplier__s_city_encoded, d_MAT29supplier__s_city_encoded, sizeof(DBI16Type) * COUNT29, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT29date__d_year, d_MAT29date__d_year, sizeof(DBI32Type) * COUNT29, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT29aggr0__tmp_attr0, d_MAT29aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT29, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_30_materialize_29 = (int64_t*)malloc(sizeof(int64_t) * main_30_materialize_29_cpw_size);
cudaMemcpy(cycles_per_warp_main_30_materialize_29, d_cycles_per_warp_main_30_materialize_29, sizeof(int64_t) * main_30_materialize_29_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_30_materialize_29 ";
for (auto i=0ull; i < main_30_materialize_29_cpw_size; i++) std::cout << cycles_per_warp_main_30_materialize_29[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
      size_t aux_mem = usedGpuMem() - used_mem;
      std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_19);
cudaFree(d_BUF_IDX_19);
cudaFree(d_COUNT19);
cudaFree(d_BUF_20);
cudaFree(d_BUF_IDX_20);
cudaFree(d_COUNT20);
cudaFree(d_BUF_27);
cudaFree(d_BUF_IDX_27);
cudaFree(d_COUNT27);
cudaFree(d_KEY_28customer__c_city_encoded);
cudaFree(d_KEY_28date__d_year);
cudaFree(d_KEY_28supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT29);
cudaFree(d_MAT29aggr0__tmp_attr0);
cudaFree(d_MAT29customer__c_city_encoded);
cudaFree(d_MAT29date__d_year);
cudaFree(d_MAT29supplier__s_city_encoded);
cudaFree(d_MAT_IDX29);
free(MAT29aggr0__tmp_attr0);
free(MAT29customer__c_city_encoded);
free(MAT29date__d_year);
free(MAT29supplier__s_city_encoded);
}