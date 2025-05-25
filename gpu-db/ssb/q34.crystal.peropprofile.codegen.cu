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
__global__ void count_1(uint64_t* COUNT15, DBStringType* customer__c_city, size_t customer_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBStringType reg_customer__c_city[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_city[ITEM] = customer__c_city[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_customer__c_city[ITEM], "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_customer__c_city[ITEM], "UNITED KI5", Predicate::eq));
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
atomicAdd((int*)COUNT15, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_15, uint64_t* BUF_IDX_15, HASHTABLE_INSERT HT_15, DBStringType* customer__c_city, DBI32Type* customer__c_custkey, size_t customer_size, int64_t* cycles_per_warp_main_1_join_build_15, int64_t* cycles_per_warp_main_1_selection_0, int64_t* cycles_per_warp_main_1_selection_2, int64_t* cycles_per_warp_main_1_selection_3) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_customer__c_city[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_city[ITEM] = customer__c_city[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_customer__c_city[ITEM], "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_customer__c_city[ITEM], "UNITED KI5", Predicate::eq));
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
uint64_t KEY_15[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_15[ITEM] = 0;
KEY_15[ITEM] |= reg_customer__c_custkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_15 = atomicAdd((int*)BUF_IDX_15, 1);
HT_15.insert(cuco::pair{KEY_15[ITEM], buf_idx_15});
BUF_15[(buf_idx_15) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_build_15[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_12(uint64_t* COUNT22, DBStringType* supplier__s_city, size_t supplier_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBStringType reg_supplier__s_city[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_city[ITEM] = supplier__s_city[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_supplier__s_city[ITEM], "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_supplier__s_city[ITEM], "UNITED KI5", Predicate::eq));
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
atomicAdd((int*)COUNT22, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_12(uint64_t* BUF_22, uint64_t* BUF_IDX_22, HASHTABLE_INSERT HT_22, int64_t* cycles_per_warp_main_12_join_build_22, int64_t* cycles_per_warp_main_12_selection_11, int64_t* cycles_per_warp_main_12_selection_13, int64_t* cycles_per_warp_main_12_selection_14, DBStringType* supplier__s_city, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_supplier__s_city[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_city[ITEM] = supplier__s_city[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_supplier__s_city[ITEM], "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_supplier__s_city[ITEM], "UNITED KI5", Predicate::eq));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_12_selection_11[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_12_selection_13[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_12_selection_14[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_22[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_22[ITEM] = 0;
KEY_22[ITEM] |= reg_supplier__s_suppkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_22 = atomicAdd((int*)BUF_IDX_22, 1);
HT_22.insert(cuco::pair{KEY_22[ITEM], buf_idx_22});
BUF_22[(buf_idx_22) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_12_join_build_22[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_17(uint64_t* COUNT23, DBStringType* date__d_yearmonth, size_t date_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBStringType reg_date__d_yearmonth[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
reg_date__d_yearmonth[ITEM] = date__d_yearmonth[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_date__d_yearmonth[ITEM], "Dec1997", Predicate::eq);
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
atomicAdd((int*)COUNT23, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_17(uint64_t* BUF_23, uint64_t* BUF_IDX_23, HASHTABLE_INSERT HT_23, int64_t* cycles_per_warp_main_17_join_build_23, int64_t* cycles_per_warp_main_17_selection_16, int64_t* cycles_per_warp_main_17_selection_18, int64_t* cycles_per_warp_main_17_selection_19, int64_t* cycles_per_warp_main_17_selection_20, int64_t* cycles_per_warp_main_17_selection_21, DBI32Type* date__d_datekey, DBStringType* date__d_yearmonth, size_t date_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_date__d_yearmonth[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
reg_date__d_yearmonth[ITEM] = date__d_yearmonth[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_date__d_yearmonth[ITEM], "Dec1997", Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_selection_16[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_selection_18[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_selection_19[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_selection_20[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_selection_21[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_23[ITEMS_PER_THREAD];
DBI32Type reg_date__d_datekey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
reg_date__d_datekey[ITEM] = date__d_datekey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_23[ITEM] = 0;
KEY_23[ITEM] |= reg_date__d_datekey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_23 = atomicAdd((int*)BUF_IDX_23, 1);
HT_23.insert(cuco::pair{KEY_23[ITEM], buf_idx_23});
BUF_23[(buf_idx_23) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_17_join_build_23[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void count_5(uint64_t* BUF_15, uint64_t* BUF_22, uint64_t* BUF_23, HASHTABLE_PROBE HT_15, HASHTABLE_PROBE HT_22, HASHTABLE_PROBE HT_23, HASHTABLE_INSERT HT_24, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_city_encoded) {
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
uint64_t KEY_15[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_custkey[ITEM] = lineorder__lo_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_15[ITEM] = 0;
KEY_15[ITEM] |= reg_lineorder__lo_custkey[ITEM];
}
int64_t slot_second15[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_15 = HT_15.find(KEY_15[ITEM]);
if (SLOT_15 == HT_15.end()) {selection_flags[ITEM] = 0; continue;}
slot_second15[ITEM] = SLOT_15->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_22[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_suppkey[ITEM] = lineorder__lo_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_22[ITEM] = 0;
KEY_22[ITEM] |= reg_lineorder__lo_suppkey[ITEM];
}
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
uint64_t KEY_23[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_orderdate[ITEM] = lineorder__lo_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_23[ITEM] = 0;
KEY_23[ITEM] |= reg_lineorder__lo_orderdate[ITEM];
}
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
uint64_t KEY_24[ITEMS_PER_THREAD];
DBI16Type reg_customer__c_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_city_encoded[ITEM] = customer__c_city_encoded[BUF_15[slot_second15[ITEM] * 1 + 0]];
}
DBI16Type reg_supplier__s_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_supplier__s_city_encoded[ITEM] = supplier__s_city_encoded[BUF_22[slot_second22[ITEM] * 1 + 0]];
}
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_date__d_year[ITEM] = date__d_year[BUF_23[slot_second23[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_24[ITEM] = 0;
KEY_24[ITEM] |= reg_customer__c_city_encoded[ITEM];
KEY_24[ITEM] <<= 16;
KEY_24[ITEM] |= reg_supplier__s_city_encoded[ITEM];
KEY_24[ITEM] <<= 32;
KEY_24[ITEM] |= reg_date__d_year[ITEM];
}
//Create aggregation hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_24.insert(cuco::pair{KEY_24[ITEM], 1});
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_5(uint64_t* BUF_15, uint64_t* BUF_22, uint64_t* BUF_23, HASHTABLE_PROBE HT_15, HASHTABLE_PROBE HT_22, HASHTABLE_PROBE HT_23, HASHTABLE_FIND HT_24, DBI16Type* KEY_24customer__c_city_encoded, DBI32Type* KEY_24date__d_year, DBI16Type* KEY_24supplier__s_city_encoded, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, int64_t* cycles_per_warp_main_5_aggregation_24, int64_t* cycles_per_warp_main_5_join_probe_15, int64_t* cycles_per_warp_main_5_join_probe_22, int64_t* cycles_per_warp_main_5_join_probe_23, int64_t* cycles_per_warp_main_5_selection_10, int64_t* cycles_per_warp_main_5_selection_4, int64_t* cycles_per_warp_main_5_selection_6, int64_t* cycles_per_warp_main_5_selection_7, int64_t* cycles_per_warp_main_5_selection_8, int64_t* cycles_per_warp_main_5_selection_9, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_city_encoded) {
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_6[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_7[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_9[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_10[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_15[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_custkey[ITEM] = lineorder__lo_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_15[ITEM] = 0;
KEY_15[ITEM] |= reg_lineorder__lo_custkey[ITEM];
}
int64_t slot_second15[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_15 = HT_15.find(KEY_15[ITEM]);
if (SLOT_15 == HT_15.end()) {selection_flags[ITEM] = 0; continue;}
slot_second15[ITEM] = SLOT_15->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_join_probe_15[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_22[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_suppkey[ITEM] = lineorder__lo_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_22[ITEM] = 0;
KEY_22[ITEM] |= reg_lineorder__lo_suppkey[ITEM];
}
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_join_probe_22[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_23[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_orderdate[ITEM] = lineorder__lo_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_23[ITEM] = 0;
KEY_23[ITEM] |= reg_lineorder__lo_orderdate[ITEM];
}
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_join_probe_23[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_24[ITEMS_PER_THREAD];
DBI16Type reg_customer__c_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_city_encoded[ITEM] = customer__c_city_encoded[BUF_15[slot_second15[ITEM] * 1 + 0]];
}
DBI16Type reg_supplier__s_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_supplier__s_city_encoded[ITEM] = supplier__s_city_encoded[BUF_22[slot_second22[ITEM] * 1 + 0]];
}
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_date__d_year[ITEM] = date__d_year[BUF_23[slot_second23[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_24[ITEM] = 0;
KEY_24[ITEM] |= reg_customer__c_city_encoded[ITEM];
KEY_24[ITEM] <<= 16;
KEY_24[ITEM] |= reg_supplier__s_city_encoded[ITEM];
KEY_24[ITEM] <<= 32;
KEY_24[ITEM] |= reg_date__d_year[ITEM];
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
auto buf_idx_24 = HT_24.find(KEY_24[ITEM])->second;
aggregate_sum(&aggr0__tmp_attr0[buf_idx_24], reg_lineorder__lo_revenue[ITEM]);
KEY_24customer__c_city_encoded[buf_idx_24] = reg_customer__c_city_encoded[ITEM];
KEY_24supplier__s_city_encoded[buf_idx_24] = reg_supplier__s_city_encoded[ITEM];
KEY_24date__d_year[buf_idx_24] = reg_date__d_year[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_aggregation_24[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_26(size_t COUNT24, uint64_t* COUNT25) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT24); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT25, 1);
}
}
__global__ void main_26(size_t COUNT24, DBDecimalType* MAT25aggr0__tmp_attr0, DBI16Type* MAT25customer__c_city_encoded, DBI32Type* MAT25date__d_year, DBI16Type* MAT25supplier__s_city_encoded, uint64_t* MAT_IDX25, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, int64_t* cycles_per_warp_main_26_materialize_25, DBI32Type* date__d_year, DBI16Type* supplier__s_city_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI16Type reg_customer__c_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT24); ++ITEM) {
reg_customer__c_city_encoded[ITEM] = customer__c_city_encoded[ITEM*TB + tid];
}
DBI16Type reg_supplier__s_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT24); ++ITEM) {
reg_supplier__s_city_encoded[ITEM] = supplier__s_city_encoded[ITEM*TB + tid];
}
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT24); ++ITEM) {
reg_date__d_year[ITEM] = date__d_year[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT24); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT24); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx25 = atomicAdd((int*)MAT_IDX25, 1);
MAT25customer__c_city_encoded[mat_idx25] = reg_customer__c_city_encoded[ITEM];
MAT25supplier__s_city_encoded[mat_idx25] = reg_supplier__s_city_encoded[ITEM];
MAT25date__d_year[mat_idx25] = reg_date__d_year[ITEM];
MAT25aggr0__tmp_attr0[mat_idx25] = reg_aggr0__tmp_attr0[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_26_materialize_25[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
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
//Materialize count
uint64_t* d_COUNT15;
cudaMalloc(&d_COUNT15, sizeof(uint64_t));
cudaMemset(d_COUNT15, 0, sizeof(uint64_t));
count_1<<<std::ceil((float)customer_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT15, d_customer__c_city, customer_size);
uint64_t COUNT15;
cudaMemcpy(&COUNT15, d_COUNT15, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_1_join_build_15;
auto main_1_join_build_15_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_build_15, sizeof(int64_t) * main_1_join_build_15_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_build_15, -1, sizeof(int64_t) * main_1_join_build_15_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_15;
cudaMalloc(&d_BUF_IDX_15, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_15, 0, sizeof(uint64_t));
uint64_t* d_BUF_15;
cudaMalloc(&d_BUF_15, sizeof(uint64_t) * COUNT15 * 1);
auto d_HT_15 = cuco::static_map{ (int)COUNT15*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)customer_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_15, d_BUF_IDX_15, d_HT_15.ref(cuco::insert), d_customer__c_city, d_customer__c_custkey, customer_size, d_cycles_per_warp_main_1_join_build_15, d_cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_2, d_cycles_per_warp_main_1_selection_3);
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
int64_t* cycles_per_warp_main_1_join_build_15 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_build_15_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_build_15, d_cycles_per_warp_main_1_join_build_15, sizeof(int64_t) * main_1_join_build_15_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_build_15 ";
for (auto i=0ull; i < main_1_join_build_15_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_build_15[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_12_selection_11;
auto main_12_selection_11_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_12_selection_11, sizeof(int64_t) * main_12_selection_11_cpw_size);
cudaMemset(d_cycles_per_warp_main_12_selection_11, -1, sizeof(int64_t) * main_12_selection_11_cpw_size);
int64_t* d_cycles_per_warp_main_12_selection_13;
auto main_12_selection_13_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_12_selection_13, sizeof(int64_t) * main_12_selection_13_cpw_size);
cudaMemset(d_cycles_per_warp_main_12_selection_13, -1, sizeof(int64_t) * main_12_selection_13_cpw_size);
int64_t* d_cycles_per_warp_main_12_selection_14;
auto main_12_selection_14_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_12_selection_14, sizeof(int64_t) * main_12_selection_14_cpw_size);
cudaMemset(d_cycles_per_warp_main_12_selection_14, -1, sizeof(int64_t) * main_12_selection_14_cpw_size);
//Materialize count
uint64_t* d_COUNT22;
cudaMalloc(&d_COUNT22, sizeof(uint64_t));
cudaMemset(d_COUNT22, 0, sizeof(uint64_t));
count_12<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT22, d_supplier__s_city, supplier_size);
uint64_t COUNT22;
cudaMemcpy(&COUNT22, d_COUNT22, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_12_join_build_22;
auto main_12_join_build_22_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_12_join_build_22, sizeof(int64_t) * main_12_join_build_22_cpw_size);
cudaMemset(d_cycles_per_warp_main_12_join_build_22, -1, sizeof(int64_t) * main_12_join_build_22_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_22;
cudaMalloc(&d_BUF_IDX_22, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_22, 0, sizeof(uint64_t));
uint64_t* d_BUF_22;
cudaMalloc(&d_BUF_22, sizeof(uint64_t) * COUNT22 * 1);
auto d_HT_22 = cuco::static_map{ (int)COUNT22*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_12<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_22, d_BUF_IDX_22, d_HT_22.ref(cuco::insert), d_cycles_per_warp_main_12_join_build_22, d_cycles_per_warp_main_12_selection_11, d_cycles_per_warp_main_12_selection_13, d_cycles_per_warp_main_12_selection_14, d_supplier__s_city, d_supplier__s_suppkey, supplier_size);
int64_t* cycles_per_warp_main_12_selection_11 = (int64_t*)malloc(sizeof(int64_t) * main_12_selection_11_cpw_size);
cudaMemcpy(cycles_per_warp_main_12_selection_11, d_cycles_per_warp_main_12_selection_11, sizeof(int64_t) * main_12_selection_11_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_12_selection_11 ";
for (auto i=0ull; i < main_12_selection_11_cpw_size; i++) std::cout << cycles_per_warp_main_12_selection_11[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_12_selection_13 = (int64_t*)malloc(sizeof(int64_t) * main_12_selection_13_cpw_size);
cudaMemcpy(cycles_per_warp_main_12_selection_13, d_cycles_per_warp_main_12_selection_13, sizeof(int64_t) * main_12_selection_13_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_12_selection_13 ";
for (auto i=0ull; i < main_12_selection_13_cpw_size; i++) std::cout << cycles_per_warp_main_12_selection_13[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_12_selection_14 = (int64_t*)malloc(sizeof(int64_t) * main_12_selection_14_cpw_size);
cudaMemcpy(cycles_per_warp_main_12_selection_14, d_cycles_per_warp_main_12_selection_14, sizeof(int64_t) * main_12_selection_14_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_12_selection_14 ";
for (auto i=0ull; i < main_12_selection_14_cpw_size; i++) std::cout << cycles_per_warp_main_12_selection_14[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_12_join_build_22 = (int64_t*)malloc(sizeof(int64_t) * main_12_join_build_22_cpw_size);
cudaMemcpy(cycles_per_warp_main_12_join_build_22, d_cycles_per_warp_main_12_join_build_22, sizeof(int64_t) * main_12_join_build_22_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_12_join_build_22 ";
for (auto i=0ull; i < main_12_join_build_22_cpw_size; i++) std::cout << cycles_per_warp_main_12_join_build_22[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_17_selection_16;
auto main_17_selection_16_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_selection_16, sizeof(int64_t) * main_17_selection_16_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_selection_16, -1, sizeof(int64_t) * main_17_selection_16_cpw_size);
int64_t* d_cycles_per_warp_main_17_selection_18;
auto main_17_selection_18_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_selection_18, sizeof(int64_t) * main_17_selection_18_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_selection_18, -1, sizeof(int64_t) * main_17_selection_18_cpw_size);
int64_t* d_cycles_per_warp_main_17_selection_19;
auto main_17_selection_19_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_selection_19, sizeof(int64_t) * main_17_selection_19_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_selection_19, -1, sizeof(int64_t) * main_17_selection_19_cpw_size);
int64_t* d_cycles_per_warp_main_17_selection_20;
auto main_17_selection_20_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_selection_20, sizeof(int64_t) * main_17_selection_20_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_selection_20, -1, sizeof(int64_t) * main_17_selection_20_cpw_size);
int64_t* d_cycles_per_warp_main_17_selection_21;
auto main_17_selection_21_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_selection_21, sizeof(int64_t) * main_17_selection_21_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_selection_21, -1, sizeof(int64_t) * main_17_selection_21_cpw_size);
//Materialize count
uint64_t* d_COUNT23;
cudaMalloc(&d_COUNT23, sizeof(uint64_t));
cudaMemset(d_COUNT23, 0, sizeof(uint64_t));
count_17<<<std::ceil((float)date_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT23, d_date__d_yearmonth, date_size);
uint64_t COUNT23;
cudaMemcpy(&COUNT23, d_COUNT23, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_17_join_build_23;
auto main_17_join_build_23_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_17_join_build_23, sizeof(int64_t) * main_17_join_build_23_cpw_size);
cudaMemset(d_cycles_per_warp_main_17_join_build_23, -1, sizeof(int64_t) * main_17_join_build_23_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_23;
cudaMalloc(&d_BUF_IDX_23, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_23, 0, sizeof(uint64_t));
uint64_t* d_BUF_23;
cudaMalloc(&d_BUF_23, sizeof(uint64_t) * COUNT23 * 1);
auto d_HT_23 = cuco::static_map{ (int)COUNT23*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_17<<<std::ceil((float)date_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_23, d_BUF_IDX_23, d_HT_23.ref(cuco::insert), d_cycles_per_warp_main_17_join_build_23, d_cycles_per_warp_main_17_selection_16, d_cycles_per_warp_main_17_selection_18, d_cycles_per_warp_main_17_selection_19, d_cycles_per_warp_main_17_selection_20, d_cycles_per_warp_main_17_selection_21, d_date__d_datekey, d_date__d_yearmonth, date_size);
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
int64_t* d_cycles_per_warp_main_5_selection_4;
auto main_5_selection_4_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_4, sizeof(int64_t) * main_5_selection_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_4, -1, sizeof(int64_t) * main_5_selection_4_cpw_size);
int64_t* d_cycles_per_warp_main_5_selection_6;
auto main_5_selection_6_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_6, sizeof(int64_t) * main_5_selection_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_6, -1, sizeof(int64_t) * main_5_selection_6_cpw_size);
int64_t* d_cycles_per_warp_main_5_selection_7;
auto main_5_selection_7_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_7, sizeof(int64_t) * main_5_selection_7_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_7, -1, sizeof(int64_t) * main_5_selection_7_cpw_size);
int64_t* d_cycles_per_warp_main_5_selection_8;
auto main_5_selection_8_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_8, sizeof(int64_t) * main_5_selection_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_8, -1, sizeof(int64_t) * main_5_selection_8_cpw_size);
int64_t* d_cycles_per_warp_main_5_selection_9;
auto main_5_selection_9_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_9, sizeof(int64_t) * main_5_selection_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_9, -1, sizeof(int64_t) * main_5_selection_9_cpw_size);
int64_t* d_cycles_per_warp_main_5_selection_10;
auto main_5_selection_10_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_10, sizeof(int64_t) * main_5_selection_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_10, -1, sizeof(int64_t) * main_5_selection_10_cpw_size);
int64_t* d_cycles_per_warp_main_5_join_probe_15;
auto main_5_join_probe_15_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_join_probe_15, sizeof(int64_t) * main_5_join_probe_15_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_join_probe_15, -1, sizeof(int64_t) * main_5_join_probe_15_cpw_size);
int64_t* d_cycles_per_warp_main_5_join_probe_22;
auto main_5_join_probe_22_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_join_probe_22, sizeof(int64_t) * main_5_join_probe_22_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_join_probe_22, -1, sizeof(int64_t) * main_5_join_probe_22_cpw_size);
int64_t* d_cycles_per_warp_main_5_join_probe_23;
auto main_5_join_probe_23_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_join_probe_23, sizeof(int64_t) * main_5_join_probe_23_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_join_probe_23, -1, sizeof(int64_t) * main_5_join_probe_23_cpw_size);
//Create aggregation hash table
auto d_HT_24 = cuco::static_map{ (int)3*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5<<<std::ceil((float)lineorder_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_15, d_BUF_22, d_BUF_23, d_HT_15.ref(cuco::find), d_HT_22.ref(cuco::find), d_HT_23.ref(cuco::find), d_HT_24.ref(cuco::insert), d_customer__c_city_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_city_encoded);
size_t COUNT24 = d_HT_24.size();
thrust::device_vector<int64_t> keys_24(COUNT24), vals_24(COUNT24);
d_HT_24.retrieve_all(keys_24.begin(), vals_24.begin());
d_HT_24.clear();
int64_t* raw_keys24 = thrust::raw_pointer_cast(keys_24.data());
insertKeys<<<std::ceil((float)COUNT24/128.), 128>>>(raw_keys24, d_HT_24.ref(cuco::insert), COUNT24);
int64_t* d_cycles_per_warp_main_5_aggregation_24;
auto main_5_aggregation_24_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_aggregation_24, sizeof(int64_t) * main_5_aggregation_24_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_aggregation_24, -1, sizeof(int64_t) * main_5_aggregation_24_cpw_size);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT24);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT24);
DBI16Type* d_KEY_24customer__c_city_encoded;
cudaMalloc(&d_KEY_24customer__c_city_encoded, sizeof(DBI16Type) * COUNT24);
cudaMemset(d_KEY_24customer__c_city_encoded, 0, sizeof(DBI16Type) * COUNT24);
DBI16Type* d_KEY_24supplier__s_city_encoded;
cudaMalloc(&d_KEY_24supplier__s_city_encoded, sizeof(DBI16Type) * COUNT24);
cudaMemset(d_KEY_24supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT24);
DBI32Type* d_KEY_24date__d_year;
cudaMalloc(&d_KEY_24date__d_year, sizeof(DBI32Type) * COUNT24);
cudaMemset(d_KEY_24date__d_year, 0, sizeof(DBI32Type) * COUNT24);
main_5<<<std::ceil((float)lineorder_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_15, d_BUF_22, d_BUF_23, d_HT_15.ref(cuco::find), d_HT_22.ref(cuco::find), d_HT_23.ref(cuco::find), d_HT_24.ref(cuco::find), d_KEY_24customer__c_city_encoded, d_KEY_24date__d_year, d_KEY_24supplier__s_city_encoded, d_aggr0__tmp_attr0, d_customer__c_city_encoded, d_cycles_per_warp_main_5_aggregation_24, d_cycles_per_warp_main_5_join_probe_15, d_cycles_per_warp_main_5_join_probe_22, d_cycles_per_warp_main_5_join_probe_23, d_cycles_per_warp_main_5_selection_10, d_cycles_per_warp_main_5_selection_4, d_cycles_per_warp_main_5_selection_6, d_cycles_per_warp_main_5_selection_7, d_cycles_per_warp_main_5_selection_8, d_cycles_per_warp_main_5_selection_9, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_city_encoded);
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
int64_t* cycles_per_warp_main_5_selection_10 = (int64_t*)malloc(sizeof(int64_t) * main_5_selection_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_selection_10, d_cycles_per_warp_main_5_selection_10, sizeof(int64_t) * main_5_selection_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_selection_10 ";
for (auto i=0ull; i < main_5_selection_10_cpw_size; i++) std::cout << cycles_per_warp_main_5_selection_10[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_join_probe_15 = (int64_t*)malloc(sizeof(int64_t) * main_5_join_probe_15_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_join_probe_15, d_cycles_per_warp_main_5_join_probe_15, sizeof(int64_t) * main_5_join_probe_15_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_join_probe_15 ";
for (auto i=0ull; i < main_5_join_probe_15_cpw_size; i++) std::cout << cycles_per_warp_main_5_join_probe_15[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_join_probe_22 = (int64_t*)malloc(sizeof(int64_t) * main_5_join_probe_22_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_join_probe_22, d_cycles_per_warp_main_5_join_probe_22, sizeof(int64_t) * main_5_join_probe_22_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_join_probe_22 ";
for (auto i=0ull; i < main_5_join_probe_22_cpw_size; i++) std::cout << cycles_per_warp_main_5_join_probe_22[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_join_probe_23 = (int64_t*)malloc(sizeof(int64_t) * main_5_join_probe_23_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_join_probe_23, d_cycles_per_warp_main_5_join_probe_23, sizeof(int64_t) * main_5_join_probe_23_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_join_probe_23 ";
for (auto i=0ull; i < main_5_join_probe_23_cpw_size; i++) std::cout << cycles_per_warp_main_5_join_probe_23[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_aggregation_24 = (int64_t*)malloc(sizeof(int64_t) * main_5_aggregation_24_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_aggregation_24, d_cycles_per_warp_main_5_aggregation_24, sizeof(int64_t) * main_5_aggregation_24_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_aggregation_24 ";
for (auto i=0ull; i < main_5_aggregation_24_cpw_size; i++) std::cout << cycles_per_warp_main_5_aggregation_24[i] << " ";
std::cout << std::endl;
//Materialize count
uint64_t* d_COUNT25;
cudaMalloc(&d_COUNT25, sizeof(uint64_t));
cudaMemset(d_COUNT25, 0, sizeof(uint64_t));
count_26<<<std::ceil((float)COUNT24/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT24, d_COUNT25);
uint64_t COUNT25;
cudaMemcpy(&COUNT25, d_COUNT25, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_26_materialize_25;
auto main_26_materialize_25_cpw_size = std::ceil((float)COUNT24/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_26_materialize_25, sizeof(int64_t) * main_26_materialize_25_cpw_size);
cudaMemset(d_cycles_per_warp_main_26_materialize_25, -1, sizeof(int64_t) * main_26_materialize_25_cpw_size);
//Materialize buffers
uint64_t* d_MAT_IDX25;
cudaMalloc(&d_MAT_IDX25, sizeof(uint64_t));
cudaMemset(d_MAT_IDX25, 0, sizeof(uint64_t));
auto MAT25customer__c_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT25);
DBI16Type* d_MAT25customer__c_city_encoded;
cudaMalloc(&d_MAT25customer__c_city_encoded, sizeof(DBI16Type) * COUNT25);
auto MAT25supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT25);
DBI16Type* d_MAT25supplier__s_city_encoded;
cudaMalloc(&d_MAT25supplier__s_city_encoded, sizeof(DBI16Type) * COUNT25);
auto MAT25date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT25);
DBI32Type* d_MAT25date__d_year;
cudaMalloc(&d_MAT25date__d_year, sizeof(DBI32Type) * COUNT25);
auto MAT25aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT25);
DBDecimalType* d_MAT25aggr0__tmp_attr0;
cudaMalloc(&d_MAT25aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT25);
main_26<<<std::ceil((float)COUNT24/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT24, d_MAT25aggr0__tmp_attr0, d_MAT25customer__c_city_encoded, d_MAT25date__d_year, d_MAT25supplier__s_city_encoded, d_MAT_IDX25, d_aggr0__tmp_attr0, d_KEY_24customer__c_city_encoded, d_cycles_per_warp_main_26_materialize_25, d_KEY_24date__d_year, d_KEY_24supplier__s_city_encoded);
cudaMemcpy(MAT25customer__c_city_encoded, d_MAT25customer__c_city_encoded, sizeof(DBI16Type) * COUNT25, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT25supplier__s_city_encoded, d_MAT25supplier__s_city_encoded, sizeof(DBI16Type) * COUNT25, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT25date__d_year, d_MAT25date__d_year, sizeof(DBI32Type) * COUNT25, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT25aggr0__tmp_attr0, d_MAT25aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT25, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_26_materialize_25 = (int64_t*)malloc(sizeof(int64_t) * main_26_materialize_25_cpw_size);
cudaMemcpy(cycles_per_warp_main_26_materialize_25, d_cycles_per_warp_main_26_materialize_25, sizeof(int64_t) * main_26_materialize_25_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_26_materialize_25 ";
for (auto i=0ull; i < main_26_materialize_25_cpw_size; i++) std::cout << cycles_per_warp_main_26_materialize_25[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
      size_t aux_mem = usedGpuMem() - used_mem;
      std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_15);
cudaFree(d_BUF_IDX_15);
cudaFree(d_COUNT15);
cudaFree(d_BUF_22);
cudaFree(d_BUF_IDX_22);
cudaFree(d_COUNT22);
cudaFree(d_BUF_23);
cudaFree(d_BUF_IDX_23);
cudaFree(d_COUNT23);
cudaFree(d_KEY_24customer__c_city_encoded);
cudaFree(d_KEY_24date__d_year);
cudaFree(d_KEY_24supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT25);
cudaFree(d_MAT25aggr0__tmp_attr0);
cudaFree(d_MAT25customer__c_city_encoded);
cudaFree(d_MAT25date__d_year);
cudaFree(d_MAT25supplier__s_city_encoded);
cudaFree(d_MAT_IDX25);
free(MAT25aggr0__tmp_attr0);
free(MAT25customer__c_city_encoded);
free(MAT25date__d_year);
free(MAT25supplier__s_city_encoded);
}