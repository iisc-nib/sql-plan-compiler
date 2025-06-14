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
__global__ void count_3(uint64_t* COUNT6, DBStringType* n1___n_name, size_t nation_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBStringType reg_n1___n_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_n1___n_name[ITEM] = n1___n_name[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_n1___n_name[ITEM], "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name[ITEM], "GERMANY", Predicate::eq));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_n1___n_name[ITEM], "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name[ITEM], "GERMANY", Predicate::eq));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_n1___n_name[ITEM], "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name[ITEM], "GERMANY", Predicate::eq));
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT6, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_3(uint64_t* BUF_6, uint64_t* BUF_IDX_6, HASHTABLE_INSERT HT_6, int64_t* cycles_per_warp_main_3_join_build_6, int64_t* cycles_per_warp_main_3_selection_2, int64_t* cycles_per_warp_main_3_selection_4, int64_t* cycles_per_warp_main_3_selection_5, DBStringType* n1___n_name, DBI32Type* n1___n_nationkey, size_t nation_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_n1___n_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_n1___n_name[ITEM] = n1___n_name[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_n1___n_name[ITEM], "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name[ITEM], "GERMANY", Predicate::eq));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_n1___n_name[ITEM], "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name[ITEM], "GERMANY", Predicate::eq));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_selection_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_n1___n_name[ITEM], "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name[ITEM], "GERMANY", Predicate::eq));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_selection_5[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_n1___n_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_n1___n_nationkey[ITEM] = n1___n_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_n1___n_nationkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_6 = atomicAdd((int*)BUF_IDX_6, 1);
HT_6.insert(cuco::pair{KEY_6[ITEM], buf_idx_6});
BUF_6[(buf_idx_6) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_build_6[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_9(uint64_t* COUNT12, DBStringType* n2___n_name, size_t nation_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBStringType reg_n2___n_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_n2___n_name[ITEM] = n2___n_name[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_n2___n_name[ITEM], "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name[ITEM], "FRANCE", Predicate::eq));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_n2___n_name[ITEM], "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name[ITEM], "FRANCE", Predicate::eq));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_n2___n_name[ITEM], "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name[ITEM], "FRANCE", Predicate::eq));
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT12, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_9(uint64_t* BUF_12, uint64_t* BUF_IDX_12, HASHTABLE_INSERT HT_12, int64_t* cycles_per_warp_main_9_join_build_12, int64_t* cycles_per_warp_main_9_selection_10, int64_t* cycles_per_warp_main_9_selection_11, int64_t* cycles_per_warp_main_9_selection_8, DBStringType* n2___n_name, DBI32Type* n2___n_nationkey, size_t nation_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_n2___n_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_n2___n_name[ITEM] = n2___n_name[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_n2___n_name[ITEM], "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name[ITEM], "FRANCE", Predicate::eq));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_9_selection_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_n2___n_name[ITEM], "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name[ITEM], "FRANCE", Predicate::eq));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_9_selection_10[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_n2___n_name[ITEM], "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name[ITEM], "FRANCE", Predicate::eq));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_9_selection_11[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_12[ITEMS_PER_THREAD];
DBI32Type reg_n2___n_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_n2___n_nationkey[ITEM] = n2___n_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_12[ITEM] = 0;
KEY_12[ITEM] |= reg_n2___n_nationkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_12 = atomicAdd((int*)BUF_IDX_12, 1);
HT_12.insert(cuco::pair{KEY_12[ITEM], buf_idx_12});
BUF_12[(buf_idx_12) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_9_join_build_12[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE>
__global__ void count_13(uint64_t* BUF_12, uint64_t* COUNT14, HASHTABLE_PROBE HT_12, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_12[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_nationkey[ITEM] = customer__c_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_12[ITEM] = 0;
KEY_12[ITEM] |= reg_customer__c_nationkey[ITEM];
}
int64_t slot_second12[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_12 = HT_12.find(KEY_12[ITEM]);
if (SLOT_12 == HT_12.end()) {selection_flags[ITEM] = 0; continue;}
slot_second12[ITEM] = SLOT_12->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT14, 1);
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_13(uint64_t* BUF_12, uint64_t* BUF_14, uint64_t* BUF_IDX_14, HASHTABLE_PROBE HT_12, HASHTABLE_INSERT HT_14, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size, int64_t* cycles_per_warp_main_13_join_build_14, int64_t* cycles_per_warp_main_13_join_probe_12) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_12[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_nationkey[ITEM] = customer__c_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_12[ITEM] = 0;
KEY_12[ITEM] |= reg_customer__c_nationkey[ITEM];
}
int64_t slot_second12[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_12 = HT_12.find(KEY_12[ITEM]);
if (SLOT_12 == HT_12.end()) {selection_flags[ITEM] = 0; continue;}
slot_second12[ITEM] = SLOT_12->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_13_join_probe_12[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_14[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_14[ITEM] = 0;
KEY_14[ITEM] |= reg_customer__c_custkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_14 = atomicAdd((int*)BUF_IDX_14, 1);
HT_14.insert(cuco::pair{KEY_14[ITEM], buf_idx_14});
BUF_14[(buf_idx_14) * 2 + 0] = BUF_12[slot_second12[ITEM] * 1 + 0];
BUF_14[(buf_idx_14) * 2 + 1] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_13_join_build_14[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE>
__global__ void count_15(uint64_t* BUF_14, uint64_t* COUNT16, HASHTABLE_PROBE HT_14, DBI32Type* orders__o_custkey, size_t orders_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_14[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_custkey[ITEM] = orders__o_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_14[ITEM] = 0;
KEY_14[ITEM] |= reg_orders__o_custkey[ITEM];
}
int64_t slot_second14[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_14 = HT_14.find(KEY_14[ITEM]);
if (SLOT_14 == HT_14.end()) {selection_flags[ITEM] = 0; continue;}
slot_second14[ITEM] = SLOT_14->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT16, 1);
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_15(uint64_t* BUF_14, uint64_t* BUF_16, uint64_t* BUF_IDX_16, HASHTABLE_PROBE HT_14, HASHTABLE_INSERT HT_16, int64_t* cycles_per_warp_main_15_join_build_16, int64_t* cycles_per_warp_main_15_join_probe_14, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_14[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_custkey[ITEM] = orders__o_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_14[ITEM] = 0;
KEY_14[ITEM] |= reg_orders__o_custkey[ITEM];
}
int64_t slot_second14[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_14 = HT_14.find(KEY_14[ITEM]);
if (SLOT_14 == HT_14.end()) {selection_flags[ITEM] = 0; continue;}
slot_second14[ITEM] = SLOT_14->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_15_join_probe_14[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_16[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_16[ITEM] = 0;
KEY_16[ITEM] |= reg_orders__o_orderkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_16 = atomicAdd((int*)BUF_IDX_16, 1);
HT_16.insert(cuco::pair{KEY_16[ITEM], buf_idx_16});
BUF_16[(buf_idx_16) * 3 + 0] = ITEM*TB + tid;
BUF_16[(buf_idx_16) * 3 + 1] = BUF_14[slot_second14[ITEM] * 2 + 0];
BUF_16[(buf_idx_16) * 3 + 2] = BUF_14[slot_second14[ITEM] * 2 + 1];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_15_join_build_16[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE>
__global__ void count_7(uint64_t* BUF_6, uint64_t* COUNT17, HASHTABLE_PROBE HT_6, DBI32Type* supplier__s_nationkey, size_t supplier_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_nationkey[ITEM] = supplier__s_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_supplier__s_nationkey[ITEM];
}
int64_t slot_second6[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_6 = HT_6.find(KEY_6[ITEM]);
if (SLOT_6 == HT_6.end()) {selection_flags[ITEM] = 0; continue;}
slot_second6[ITEM] = SLOT_6->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT17, 1);
}
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_7(uint64_t* BUF_17, uint64_t* BUF_6, uint64_t* BUF_IDX_17, HASHTABLE_INSERT HT_17, HASHTABLE_PROBE HT_6, int64_t* cycles_per_warp_main_7_join_build_17, int64_t* cycles_per_warp_main_7_join_probe_6, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_nationkey[ITEM] = supplier__s_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_supplier__s_nationkey[ITEM];
}
int64_t slot_second6[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_6 = HT_6.find(KEY_6[ITEM]);
if (SLOT_6 == HT_6.end()) {selection_flags[ITEM] = 0; continue;}
slot_second6[ITEM] = SLOT_6->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_probe_6[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_17[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_17[ITEM] = 0;
KEY_17[ITEM] |= reg_supplier__s_suppkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_17 = atomicAdd((int*)BUF_IDX_17, 1);
HT_17.insert(cuco::pair{KEY_17[ITEM], buf_idx_17});
BUF_17[(buf_idx_17) * 2 + 0] = ITEM*TB + tid;
BUF_17[(buf_idx_17) * 2 + 1] = BUF_6[slot_second6[ITEM] * 1 + 0];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_build_17[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void count_1(uint64_t* BUF_16, uint64_t* BUF_17, HASHTABLE_PROBE HT_16, HASHTABLE_PROBE HT_17, HASHTABLE_INSERT HT_20, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBI16Type* n1___n_name_encoded, DBStringType* n2___n_name, DBI16Type* n2___n_name_encoded) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBDateType reg_lineitem__l_shipdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_shipdate[ITEM] = lineitem__l_shipdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_shipdate[ITEM], 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate[ITEM], 9861, Predicate::lte);
}
uint64_t KEY_16[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_16[ITEM] = 0;
KEY_16[ITEM] |= reg_lineitem__l_orderkey[ITEM];
}
int64_t slot_second16[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_16 = HT_16.find(KEY_16[ITEM]);
if (SLOT_16 == HT_16.end()) {selection_flags[ITEM] = 0; continue;}
slot_second16[ITEM] = SLOT_16->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_17[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_suppkey[ITEM] = lineitem__l_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_17[ITEM] = 0;
KEY_17[ITEM] |= reg_lineitem__l_suppkey[ITEM];
}
int64_t slot_second17[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_17 = HT_17.find(KEY_17[ITEM]);
if (SLOT_17 == HT_17.end()) {selection_flags[ITEM] = 0; continue;}
slot_second17[ITEM] = SLOT_17->second;
}
DBStringType reg_n1___n_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_n1___n_name[ITEM] = n1___n_name[BUF_17[slot_second17[ITEM] * 2 + 1]];
}
DBStringType reg_n2___n_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_n2___n_name[ITEM] = n2___n_name[BUF_16[slot_second16[ITEM] * 3 + 1]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (((evaluatePredicate(reg_n1___n_name[ITEM], "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name[ITEM], "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name[ITEM], "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name[ITEM], "FRANCE", Predicate::eq)))) && (true);
}
uint64_t KEY_20[ITEMS_PER_THREAD];
DBI16Type reg_n1___n_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_n1___n_name_encoded[ITEM] = n1___n_name_encoded[BUF_17[slot_second17[ITEM] * 2 + 1]];
}
DBI16Type reg_n2___n_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_n2___n_name_encoded[ITEM] = n2___n_name_encoded[BUF_16[slot_second16[ITEM] * 3 + 1]];
}
DBI64Type reg_map0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr0[ITEM] = ExtractFromDate("year", reg_lineitem__l_shipdate[ITEM]);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_20[ITEM] = 0;
KEY_20[ITEM] |= reg_n1___n_name_encoded[ITEM];
KEY_20[ITEM] <<= 16;
KEY_20[ITEM] |= reg_n2___n_name_encoded[ITEM];
KEY_20[ITEM] <<= 32;
KEY_20[ITEM] |= (DBI32Type)reg_map0__tmp_attr0[ITEM];
}
//Create aggregation hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_20.insert(cuco::pair{KEY_20[ITEM], 1});
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_1(uint64_t* BUF_16, uint64_t* BUF_17, HASHTABLE_PROBE HT_16, HASHTABLE_PROBE HT_17, HASHTABLE_FIND HT_20, DBI64Type* KEY_20map0__tmp_attr0, DBI16Type* KEY_20n1___n_name_encoded, DBI16Type* KEY_20n2___n_name_encoded, DBDecimalType* aggr0__tmp_attr2, int64_t* cycles_per_warp_main_1_aggregation_20, int64_t* cycles_per_warp_main_1_join_probe_16, int64_t* cycles_per_warp_main_1_join_probe_17, int64_t* cycles_per_warp_main_1_map_18, int64_t* cycles_per_warp_main_1_map_19, int64_t* cycles_per_warp_main_1_selection_0, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBI16Type* n1___n_name_encoded, DBStringType* n2___n_name, DBI16Type* n2___n_name_encoded) {
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
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_shipdate[ITEM], 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate[ITEM], 9861, Predicate::lte);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_16[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_16[ITEM] = 0;
KEY_16[ITEM] |= reg_lineitem__l_orderkey[ITEM];
}
int64_t slot_second16[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_16 = HT_16.find(KEY_16[ITEM]);
if (SLOT_16 == HT_16.end()) {selection_flags[ITEM] = 0; continue;}
slot_second16[ITEM] = SLOT_16->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_probe_16[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_17[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_suppkey[ITEM] = lineitem__l_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_17[ITEM] = 0;
KEY_17[ITEM] |= reg_lineitem__l_suppkey[ITEM];
}
int64_t slot_second17[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_17 = HT_17.find(KEY_17[ITEM]);
if (SLOT_17 == HT_17.end()) {selection_flags[ITEM] = 0; continue;}
slot_second17[ITEM] = SLOT_17->second;
}
DBStringType reg_n1___n_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_n1___n_name[ITEM] = n1___n_name[BUF_17[slot_second17[ITEM] * 2 + 1]];
}
DBStringType reg_n2___n_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_n2___n_name[ITEM] = n2___n_name[BUF_16[slot_second16[ITEM] * 3 + 1]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (((evaluatePredicate(reg_n1___n_name[ITEM], "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name[ITEM], "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name[ITEM], "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name[ITEM], "FRANCE", Predicate::eq)))) && (true);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_probe_17[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_map_18[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_map_19[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_20[ITEMS_PER_THREAD];
DBI16Type reg_n1___n_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_n1___n_name_encoded[ITEM] = n1___n_name_encoded[BUF_17[slot_second17[ITEM] * 2 + 1]];
}
DBI16Type reg_n2___n_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_n2___n_name_encoded[ITEM] = n2___n_name_encoded[BUF_16[slot_second16[ITEM] * 3 + 1]];
}
DBI64Type reg_map0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr0[ITEM] = ExtractFromDate("year", reg_lineitem__l_shipdate[ITEM]);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_20[ITEM] = 0;
KEY_20[ITEM] |= reg_n1___n_name_encoded[ITEM];
KEY_20[ITEM] <<= 16;
KEY_20[ITEM] |= reg_n2___n_name_encoded[ITEM];
KEY_20[ITEM] <<= 32;
KEY_20[ITEM] |= (DBI32Type)reg_map0__tmp_attr0[ITEM];
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
auto buf_idx_20 = HT_20.find(KEY_20[ITEM])->second;
aggregate_sum(&aggr0__tmp_attr2[buf_idx_20], reg_map0__tmp_attr1[ITEM]);
KEY_20n1___n_name_encoded[buf_idx_20] = reg_n1___n_name_encoded[ITEM];
KEY_20n2___n_name_encoded[buf_idx_20] = reg_n2___n_name_encoded[ITEM];
KEY_20map0__tmp_attr0[buf_idx_20] = reg_map0__tmp_attr0[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_aggregation_20[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_22(size_t COUNT20, uint64_t* COUNT21) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT20); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT21, 1);
}
}
__global__ void main_22(size_t COUNT20, DBDecimalType* MAT21aggr0__tmp_attr2, DBI64Type* MAT21map0__tmp_attr0, DBI16Type* MAT21n1___n_name_encoded, DBI16Type* MAT21n2___n_name_encoded, uint64_t* MAT_IDX21, DBDecimalType* aggr0__tmp_attr2, int64_t* cycles_per_warp_main_22_materialize_21, DBI64Type* map0__tmp_attr0, DBI16Type* n1___n_name_encoded, DBI16Type* n2___n_name_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI16Type reg_n1___n_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT20); ++ITEM) {
reg_n1___n_name_encoded[ITEM] = n1___n_name_encoded[ITEM*TB + tid];
}
DBI16Type reg_n2___n_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT20); ++ITEM) {
reg_n2___n_name_encoded[ITEM] = n2___n_name_encoded[ITEM*TB + tid];
}
DBI64Type reg_map0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT20); ++ITEM) {
reg_map0__tmp_attr0[ITEM] = map0__tmp_attr0[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT20); ++ITEM) {
reg_aggr0__tmp_attr2[ITEM] = aggr0__tmp_attr2[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT20); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx21 = atomicAdd((int*)MAT_IDX21, 1);
MAT21n1___n_name_encoded[mat_idx21] = reg_n1___n_name_encoded[ITEM];
MAT21n2___n_name_encoded[mat_idx21] = reg_n2___n_name_encoded[ITEM];
MAT21map0__tmp_attr0[mat_idx21] = reg_map0__tmp_attr0[ITEM];
MAT21aggr0__tmp_attr2[mat_idx21] = reg_aggr0__tmp_attr2[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_22_materialize_21[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_3_selection_2;
auto main_3_selection_2_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_selection_2, sizeof(int64_t) * main_3_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_selection_2, -1, sizeof(int64_t) * main_3_selection_2_cpw_size);
int64_t* d_cycles_per_warp_main_3_selection_4;
auto main_3_selection_4_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_selection_4, sizeof(int64_t) * main_3_selection_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_selection_4, -1, sizeof(int64_t) * main_3_selection_4_cpw_size);
int64_t* d_cycles_per_warp_main_3_selection_5;
auto main_3_selection_5_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_selection_5, sizeof(int64_t) * main_3_selection_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_selection_5, -1, sizeof(int64_t) * main_3_selection_5_cpw_size);
//Materialize count
uint64_t* d_COUNT6;
cudaMalloc(&d_COUNT6, sizeof(uint64_t));
cudaMemset(d_COUNT6, 0, sizeof(uint64_t));
count_3<<<std::ceil((float)nation_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT6, d_nation__n_name, nation_size);
uint64_t COUNT6;
cudaMemcpy(&COUNT6, d_COUNT6, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_3_join_build_6;
auto main_3_join_build_6_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_build_6, sizeof(int64_t) * main_3_join_build_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_build_6, -1, sizeof(int64_t) * main_3_join_build_6_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_6;
cudaMalloc(&d_BUF_IDX_6, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6, 0, sizeof(uint64_t));
uint64_t* d_BUF_6;
cudaMalloc(&d_BUF_6, sizeof(uint64_t) * COUNT6 * 1);
auto d_HT_6 = cuco::static_map{ (int)COUNT6*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)nation_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_6, d_BUF_IDX_6, d_HT_6.ref(cuco::insert), d_cycles_per_warp_main_3_join_build_6, d_cycles_per_warp_main_3_selection_2, d_cycles_per_warp_main_3_selection_4, d_cycles_per_warp_main_3_selection_5, d_nation__n_name, d_nation__n_nationkey, nation_size);
int64_t* cycles_per_warp_main_3_selection_2 = (int64_t*)malloc(sizeof(int64_t) * main_3_selection_2_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_selection_2, d_cycles_per_warp_main_3_selection_2, sizeof(int64_t) * main_3_selection_2_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_selection_2 ";
for (auto i=0ull; i < main_3_selection_2_cpw_size; i++) std::cout << cycles_per_warp_main_3_selection_2[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_selection_4 = (int64_t*)malloc(sizeof(int64_t) * main_3_selection_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_selection_4, d_cycles_per_warp_main_3_selection_4, sizeof(int64_t) * main_3_selection_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_selection_4 ";
for (auto i=0ull; i < main_3_selection_4_cpw_size; i++) std::cout << cycles_per_warp_main_3_selection_4[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_selection_5 = (int64_t*)malloc(sizeof(int64_t) * main_3_selection_5_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_selection_5, d_cycles_per_warp_main_3_selection_5, sizeof(int64_t) * main_3_selection_5_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_selection_5 ";
for (auto i=0ull; i < main_3_selection_5_cpw_size; i++) std::cout << cycles_per_warp_main_3_selection_5[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_join_build_6 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_build_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_build_6, d_cycles_per_warp_main_3_join_build_6, sizeof(int64_t) * main_3_join_build_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_build_6 ";
for (auto i=0ull; i < main_3_join_build_6_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_build_6[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_9_selection_8;
auto main_9_selection_8_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_9_selection_8, sizeof(int64_t) * main_9_selection_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_9_selection_8, -1, sizeof(int64_t) * main_9_selection_8_cpw_size);
int64_t* d_cycles_per_warp_main_9_selection_10;
auto main_9_selection_10_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_9_selection_10, sizeof(int64_t) * main_9_selection_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_9_selection_10, -1, sizeof(int64_t) * main_9_selection_10_cpw_size);
int64_t* d_cycles_per_warp_main_9_selection_11;
auto main_9_selection_11_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_9_selection_11, sizeof(int64_t) * main_9_selection_11_cpw_size);
cudaMemset(d_cycles_per_warp_main_9_selection_11, -1, sizeof(int64_t) * main_9_selection_11_cpw_size);
//Materialize count
uint64_t* d_COUNT12;
cudaMalloc(&d_COUNT12, sizeof(uint64_t));
cudaMemset(d_COUNT12, 0, sizeof(uint64_t));
count_9<<<std::ceil((float)nation_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT12, d_nation__n_name, nation_size);
uint64_t COUNT12;
cudaMemcpy(&COUNT12, d_COUNT12, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_9_join_build_12;
auto main_9_join_build_12_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_9_join_build_12, sizeof(int64_t) * main_9_join_build_12_cpw_size);
cudaMemset(d_cycles_per_warp_main_9_join_build_12, -1, sizeof(int64_t) * main_9_join_build_12_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_12;
cudaMalloc(&d_BUF_IDX_12, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_12, 0, sizeof(uint64_t));
uint64_t* d_BUF_12;
cudaMalloc(&d_BUF_12, sizeof(uint64_t) * COUNT12 * 1);
auto d_HT_12 = cuco::static_map{ (int)COUNT12*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_9<<<std::ceil((float)nation_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_12, d_BUF_IDX_12, d_HT_12.ref(cuco::insert), d_cycles_per_warp_main_9_join_build_12, d_cycles_per_warp_main_9_selection_10, d_cycles_per_warp_main_9_selection_11, d_cycles_per_warp_main_9_selection_8, d_nation__n_name, d_nation__n_nationkey, nation_size);
int64_t* cycles_per_warp_main_9_selection_8 = (int64_t*)malloc(sizeof(int64_t) * main_9_selection_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_9_selection_8, d_cycles_per_warp_main_9_selection_8, sizeof(int64_t) * main_9_selection_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_9_selection_8 ";
for (auto i=0ull; i < main_9_selection_8_cpw_size; i++) std::cout << cycles_per_warp_main_9_selection_8[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_9_selection_10 = (int64_t*)malloc(sizeof(int64_t) * main_9_selection_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_9_selection_10, d_cycles_per_warp_main_9_selection_10, sizeof(int64_t) * main_9_selection_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_9_selection_10 ";
for (auto i=0ull; i < main_9_selection_10_cpw_size; i++) std::cout << cycles_per_warp_main_9_selection_10[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_9_selection_11 = (int64_t*)malloc(sizeof(int64_t) * main_9_selection_11_cpw_size);
cudaMemcpy(cycles_per_warp_main_9_selection_11, d_cycles_per_warp_main_9_selection_11, sizeof(int64_t) * main_9_selection_11_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_9_selection_11 ";
for (auto i=0ull; i < main_9_selection_11_cpw_size; i++) std::cout << cycles_per_warp_main_9_selection_11[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_9_join_build_12 = (int64_t*)malloc(sizeof(int64_t) * main_9_join_build_12_cpw_size);
cudaMemcpy(cycles_per_warp_main_9_join_build_12, d_cycles_per_warp_main_9_join_build_12, sizeof(int64_t) * main_9_join_build_12_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_9_join_build_12 ";
for (auto i=0ull; i < main_9_join_build_12_cpw_size; i++) std::cout << cycles_per_warp_main_9_join_build_12[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_13_join_probe_12;
auto main_13_join_probe_12_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_13_join_probe_12, sizeof(int64_t) * main_13_join_probe_12_cpw_size);
cudaMemset(d_cycles_per_warp_main_13_join_probe_12, -1, sizeof(int64_t) * main_13_join_probe_12_cpw_size);
//Materialize count
uint64_t* d_COUNT14;
cudaMalloc(&d_COUNT14, sizeof(uint64_t));
cudaMemset(d_COUNT14, 0, sizeof(uint64_t));
count_13<<<std::ceil((float)customer_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_12, d_COUNT14, d_HT_12.ref(cuco::find), d_customer__c_nationkey, customer_size);
uint64_t COUNT14;
cudaMemcpy(&COUNT14, d_COUNT14, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_13_join_build_14;
auto main_13_join_build_14_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_13_join_build_14, sizeof(int64_t) * main_13_join_build_14_cpw_size);
cudaMemset(d_cycles_per_warp_main_13_join_build_14, -1, sizeof(int64_t) * main_13_join_build_14_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_14;
cudaMalloc(&d_BUF_IDX_14, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_14, 0, sizeof(uint64_t));
uint64_t* d_BUF_14;
cudaMalloc(&d_BUF_14, sizeof(uint64_t) * COUNT14 * 2);
auto d_HT_14 = cuco::static_map{ (int)COUNT14*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_13<<<std::ceil((float)customer_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_12, d_BUF_14, d_BUF_IDX_14, d_HT_12.ref(cuco::find), d_HT_14.ref(cuco::insert), d_customer__c_custkey, d_customer__c_nationkey, customer_size, d_cycles_per_warp_main_13_join_build_14, d_cycles_per_warp_main_13_join_probe_12);
int64_t* cycles_per_warp_main_13_join_probe_12 = (int64_t*)malloc(sizeof(int64_t) * main_13_join_probe_12_cpw_size);
cudaMemcpy(cycles_per_warp_main_13_join_probe_12, d_cycles_per_warp_main_13_join_probe_12, sizeof(int64_t) * main_13_join_probe_12_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_13_join_probe_12 ";
for (auto i=0ull; i < main_13_join_probe_12_cpw_size; i++) std::cout << cycles_per_warp_main_13_join_probe_12[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_13_join_build_14 = (int64_t*)malloc(sizeof(int64_t) * main_13_join_build_14_cpw_size);
cudaMemcpy(cycles_per_warp_main_13_join_build_14, d_cycles_per_warp_main_13_join_build_14, sizeof(int64_t) * main_13_join_build_14_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_13_join_build_14 ";
for (auto i=0ull; i < main_13_join_build_14_cpw_size; i++) std::cout << cycles_per_warp_main_13_join_build_14[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_15_join_probe_14;
auto main_15_join_probe_14_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_15_join_probe_14, sizeof(int64_t) * main_15_join_probe_14_cpw_size);
cudaMemset(d_cycles_per_warp_main_15_join_probe_14, -1, sizeof(int64_t) * main_15_join_probe_14_cpw_size);
//Materialize count
uint64_t* d_COUNT16;
cudaMalloc(&d_COUNT16, sizeof(uint64_t));
cudaMemset(d_COUNT16, 0, sizeof(uint64_t));
count_15<<<std::ceil((float)orders_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_14, d_COUNT16, d_HT_14.ref(cuco::find), d_orders__o_custkey, orders_size);
uint64_t COUNT16;
cudaMemcpy(&COUNT16, d_COUNT16, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_15_join_build_16;
auto main_15_join_build_16_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_15_join_build_16, sizeof(int64_t) * main_15_join_build_16_cpw_size);
cudaMemset(d_cycles_per_warp_main_15_join_build_16, -1, sizeof(int64_t) * main_15_join_build_16_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_16;
cudaMalloc(&d_BUF_IDX_16, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_16, 0, sizeof(uint64_t));
uint64_t* d_BUF_16;
cudaMalloc(&d_BUF_16, sizeof(uint64_t) * COUNT16 * 3);
auto d_HT_16 = cuco::static_map{ (int)COUNT16*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_15<<<std::ceil((float)orders_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_14, d_BUF_16, d_BUF_IDX_16, d_HT_14.ref(cuco::find), d_HT_16.ref(cuco::insert), d_cycles_per_warp_main_15_join_build_16, d_cycles_per_warp_main_15_join_probe_14, d_orders__o_custkey, d_orders__o_orderkey, orders_size);
int64_t* cycles_per_warp_main_15_join_probe_14 = (int64_t*)malloc(sizeof(int64_t) * main_15_join_probe_14_cpw_size);
cudaMemcpy(cycles_per_warp_main_15_join_probe_14, d_cycles_per_warp_main_15_join_probe_14, sizeof(int64_t) * main_15_join_probe_14_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_15_join_probe_14 ";
for (auto i=0ull; i < main_15_join_probe_14_cpw_size; i++) std::cout << cycles_per_warp_main_15_join_probe_14[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_15_join_build_16 = (int64_t*)malloc(sizeof(int64_t) * main_15_join_build_16_cpw_size);
cudaMemcpy(cycles_per_warp_main_15_join_build_16, d_cycles_per_warp_main_15_join_build_16, sizeof(int64_t) * main_15_join_build_16_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_15_join_build_16 ";
for (auto i=0ull; i < main_15_join_build_16_cpw_size; i++) std::cout << cycles_per_warp_main_15_join_build_16[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_7_join_probe_6;
auto main_7_join_probe_6_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_probe_6, sizeof(int64_t) * main_7_join_probe_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_probe_6, -1, sizeof(int64_t) * main_7_join_probe_6_cpw_size);
//Materialize count
uint64_t* d_COUNT17;
cudaMalloc(&d_COUNT17, sizeof(uint64_t));
cudaMemset(d_COUNT17, 0, sizeof(uint64_t));
count_7<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_6, d_COUNT17, d_HT_6.ref(cuco::find), d_supplier__s_nationkey, supplier_size);
uint64_t COUNT17;
cudaMemcpy(&COUNT17, d_COUNT17, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_7_join_build_17;
auto main_7_join_build_17_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_build_17, sizeof(int64_t) * main_7_join_build_17_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_build_17, -1, sizeof(int64_t) * main_7_join_build_17_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_17;
cudaMalloc(&d_BUF_IDX_17, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_17, 0, sizeof(uint64_t));
uint64_t* d_BUF_17;
cudaMalloc(&d_BUF_17, sizeof(uint64_t) * COUNT17 * 2);
auto d_HT_17 = cuco::static_map{ (int)COUNT17*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_7<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_17, d_BUF_6, d_BUF_IDX_17, d_HT_17.ref(cuco::insert), d_HT_6.ref(cuco::find), d_cycles_per_warp_main_7_join_build_17, d_cycles_per_warp_main_7_join_probe_6, d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
int64_t* cycles_per_warp_main_7_join_probe_6 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_probe_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_probe_6, d_cycles_per_warp_main_7_join_probe_6, sizeof(int64_t) * main_7_join_probe_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_probe_6 ";
for (auto i=0ull; i < main_7_join_probe_6_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_probe_6[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_join_build_17 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_build_17_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_build_17, d_cycles_per_warp_main_7_join_build_17, sizeof(int64_t) * main_7_join_build_17_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_build_17 ";
for (auto i=0ull; i < main_7_join_build_17_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_build_17[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_probe_16;
auto main_1_join_probe_16_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_probe_16, sizeof(int64_t) * main_1_join_probe_16_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_probe_16, -1, sizeof(int64_t) * main_1_join_probe_16_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_probe_17;
auto main_1_join_probe_17_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_probe_17, sizeof(int64_t) * main_1_join_probe_17_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_probe_17, -1, sizeof(int64_t) * main_1_join_probe_17_cpw_size);
int64_t* d_cycles_per_warp_main_1_map_18;
auto main_1_map_18_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_map_18, sizeof(int64_t) * main_1_map_18_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_map_18, -1, sizeof(int64_t) * main_1_map_18_cpw_size);
int64_t* d_cycles_per_warp_main_1_map_19;
auto main_1_map_19_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_map_19, sizeof(int64_t) * main_1_map_19_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_map_19, -1, sizeof(int64_t) * main_1_map_19_cpw_size);
//Create aggregation hash table
auto d_HT_20 = cuco::static_map{ (int)13634*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_1<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_16, d_BUF_17, d_HT_16.ref(cuco::find), d_HT_17.ref(cuco::find), d_HT_20.ref(cuco::insert), d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name_encoded, d_nation__n_name, d_nation__n_name_encoded);
size_t COUNT20 = d_HT_20.size();
thrust::device_vector<int64_t> keys_20(COUNT20), vals_20(COUNT20);
d_HT_20.retrieve_all(keys_20.begin(), vals_20.begin());
d_HT_20.clear();
int64_t* raw_keys20 = thrust::raw_pointer_cast(keys_20.data());
insertKeys<<<std::ceil((float)COUNT20/128.), 128>>>(raw_keys20, d_HT_20.ref(cuco::insert), COUNT20);
int64_t* d_cycles_per_warp_main_1_aggregation_20;
auto main_1_aggregation_20_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_aggregation_20, sizeof(int64_t) * main_1_aggregation_20_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_aggregation_20, -1, sizeof(int64_t) * main_1_aggregation_20_cpw_size);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT20);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT20);
DBI16Type* d_KEY_20n1___n_name_encoded;
cudaMalloc(&d_KEY_20n1___n_name_encoded, sizeof(DBI16Type) * COUNT20);
cudaMemset(d_KEY_20n1___n_name_encoded, 0, sizeof(DBI16Type) * COUNT20);
DBI16Type* d_KEY_20n2___n_name_encoded;
cudaMalloc(&d_KEY_20n2___n_name_encoded, sizeof(DBI16Type) * COUNT20);
cudaMemset(d_KEY_20n2___n_name_encoded, 0, sizeof(DBI16Type) * COUNT20);
DBI64Type* d_KEY_20map0__tmp_attr0;
cudaMalloc(&d_KEY_20map0__tmp_attr0, sizeof(DBI64Type) * COUNT20);
cudaMemset(d_KEY_20map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT20);
main_1<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_16, d_BUF_17, d_HT_16.ref(cuco::find), d_HT_17.ref(cuco::find), d_HT_20.ref(cuco::find), d_KEY_20map0__tmp_attr0, d_KEY_20n1___n_name_encoded, d_KEY_20n2___n_name_encoded, d_aggr0__tmp_attr2, d_cycles_per_warp_main_1_aggregation_20, d_cycles_per_warp_main_1_join_probe_16, d_cycles_per_warp_main_1_join_probe_17, d_cycles_per_warp_main_1_map_18, d_cycles_per_warp_main_1_map_19, d_cycles_per_warp_main_1_selection_0, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name_encoded, d_nation__n_name, d_nation__n_name_encoded);
int64_t* cycles_per_warp_main_1_selection_0 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_0 ";
for (auto i=0ull; i < main_1_selection_0_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_0[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_probe_16 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_probe_16_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_probe_16, d_cycles_per_warp_main_1_join_probe_16, sizeof(int64_t) * main_1_join_probe_16_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_probe_16 ";
for (auto i=0ull; i < main_1_join_probe_16_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_probe_16[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_probe_17 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_probe_17_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_probe_17, d_cycles_per_warp_main_1_join_probe_17, sizeof(int64_t) * main_1_join_probe_17_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_probe_17 ";
for (auto i=0ull; i < main_1_join_probe_17_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_probe_17[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_map_18 = (int64_t*)malloc(sizeof(int64_t) * main_1_map_18_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_map_18, d_cycles_per_warp_main_1_map_18, sizeof(int64_t) * main_1_map_18_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_map_18 ";
for (auto i=0ull; i < main_1_map_18_cpw_size; i++) std::cout << cycles_per_warp_main_1_map_18[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_map_19 = (int64_t*)malloc(sizeof(int64_t) * main_1_map_19_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_map_19, d_cycles_per_warp_main_1_map_19, sizeof(int64_t) * main_1_map_19_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_map_19 ";
for (auto i=0ull; i < main_1_map_19_cpw_size; i++) std::cout << cycles_per_warp_main_1_map_19[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_aggregation_20 = (int64_t*)malloc(sizeof(int64_t) * main_1_aggregation_20_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_aggregation_20, d_cycles_per_warp_main_1_aggregation_20, sizeof(int64_t) * main_1_aggregation_20_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_aggregation_20 ";
for (auto i=0ull; i < main_1_aggregation_20_cpw_size; i++) std::cout << cycles_per_warp_main_1_aggregation_20[i] << " ";
std::cout << std::endl;
//Materialize count
uint64_t* d_COUNT21;
cudaMalloc(&d_COUNT21, sizeof(uint64_t));
cudaMemset(d_COUNT21, 0, sizeof(uint64_t));
count_22<<<std::ceil((float)COUNT20/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT20, d_COUNT21);
uint64_t COUNT21;
cudaMemcpy(&COUNT21, d_COUNT21, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_22_materialize_21;
auto main_22_materialize_21_cpw_size = std::ceil((float)COUNT20/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_22_materialize_21, sizeof(int64_t) * main_22_materialize_21_cpw_size);
cudaMemset(d_cycles_per_warp_main_22_materialize_21, -1, sizeof(int64_t) * main_22_materialize_21_cpw_size);
//Materialize buffers
uint64_t* d_MAT_IDX21;
cudaMalloc(&d_MAT_IDX21, sizeof(uint64_t));
cudaMemset(d_MAT_IDX21, 0, sizeof(uint64_t));
auto MAT21n1___n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT21);
DBI16Type* d_MAT21n1___n_name_encoded;
cudaMalloc(&d_MAT21n1___n_name_encoded, sizeof(DBI16Type) * COUNT21);
auto MAT21n2___n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT21);
DBI16Type* d_MAT21n2___n_name_encoded;
cudaMalloc(&d_MAT21n2___n_name_encoded, sizeof(DBI16Type) * COUNT21);
auto MAT21map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT21);
DBI64Type* d_MAT21map0__tmp_attr0;
cudaMalloc(&d_MAT21map0__tmp_attr0, sizeof(DBI64Type) * COUNT21);
auto MAT21aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT21);
DBDecimalType* d_MAT21aggr0__tmp_attr2;
cudaMalloc(&d_MAT21aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT21);
main_22<<<std::ceil((float)COUNT20/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT20, d_MAT21aggr0__tmp_attr2, d_MAT21map0__tmp_attr0, d_MAT21n1___n_name_encoded, d_MAT21n2___n_name_encoded, d_MAT_IDX21, d_aggr0__tmp_attr2, d_cycles_per_warp_main_22_materialize_21, d_KEY_20map0__tmp_attr0, d_KEY_20n1___n_name_encoded, d_KEY_20n2___n_name_encoded);
cudaMemcpy(MAT21n1___n_name_encoded, d_MAT21n1___n_name_encoded, sizeof(DBI16Type) * COUNT21, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT21n2___n_name_encoded, d_MAT21n2___n_name_encoded, sizeof(DBI16Type) * COUNT21, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT21map0__tmp_attr0, d_MAT21map0__tmp_attr0, sizeof(DBI64Type) * COUNT21, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT21aggr0__tmp_attr2, d_MAT21aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT21, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_22_materialize_21 = (int64_t*)malloc(sizeof(int64_t) * main_22_materialize_21_cpw_size);
cudaMemcpy(cycles_per_warp_main_22_materialize_21, d_cycles_per_warp_main_22_materialize_21, sizeof(int64_t) * main_22_materialize_21_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_22_materialize_21 ";
for (auto i=0ull; i < main_22_materialize_21_cpw_size; i++) std::cout << cycles_per_warp_main_22_materialize_21[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
      size_t aux_mem = usedGpuMem() - used_mem;
      std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_6);
cudaFree(d_BUF_IDX_6);
cudaFree(d_COUNT6);
cudaFree(d_BUF_12);
cudaFree(d_BUF_IDX_12);
cudaFree(d_COUNT12);
cudaFree(d_BUF_14);
cudaFree(d_BUF_IDX_14);
cudaFree(d_COUNT14);
cudaFree(d_BUF_16);
cudaFree(d_BUF_IDX_16);
cudaFree(d_COUNT16);
cudaFree(d_BUF_17);
cudaFree(d_BUF_IDX_17);
cudaFree(d_COUNT17);
cudaFree(d_KEY_20map0__tmp_attr0);
cudaFree(d_KEY_20n1___n_name_encoded);
cudaFree(d_KEY_20n2___n_name_encoded);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_COUNT21);
cudaFree(d_MAT21aggr0__tmp_attr2);
cudaFree(d_MAT21map0__tmp_attr0);
cudaFree(d_MAT21n1___n_name_encoded);
cudaFree(d_MAT21n2___n_name_encoded);
cudaFree(d_MAT_IDX21);
free(MAT21aggr0__tmp_attr2);
free(MAT21map0__tmp_attr0);
free(MAT21n1___n_name_encoded);
free(MAT21n2___n_name_encoded);
}