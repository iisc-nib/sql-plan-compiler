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
__global__ void count_3(uint64_t* COUNT4, DBStringType* region__r_name, size_t region_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBStringType reg_region__r_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
reg_region__r_name[ITEM] = region__r_name[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_region__r_name[ITEM], "ASIA", Predicate::eq);
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT4, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_3(uint64_t* BUF_4, uint64_t* BUF_IDX_4, HASHTABLE_INSERT HT_4, int64_t* cycles_per_warp_main_3_join_build_4, int64_t* cycles_per_warp_main_3_selection_2, DBStringType* region__r_name, DBI32Type* region__r_regionkey, size_t region_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_region__r_name[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
reg_region__r_name[ITEM] = region__r_name[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_region__r_name[ITEM], "ASIA", Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_region__r_regionkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
reg_region__r_regionkey[ITEM] = region__r_regionkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_region__r_regionkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < region_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_4 = atomicAdd((int*)BUF_IDX_4, 1);
HT_4.insert(cuco::pair{KEY_4[ITEM], buf_idx_4});
BUF_4[(buf_idx_4) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_build_4[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE>
__global__ void count_5(uint64_t* BUF_4, uint64_t* COUNT6, HASHTABLE_PROBE HT_4, DBI32Type* nation__n_regionkey, size_t nation_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_nation__n_regionkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_nation__n_regionkey[ITEM] = nation__n_regionkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_nation__n_regionkey[ITEM];
}
int64_t slot_second4[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_4 = HT_4.find(KEY_4[ITEM]);
if (SLOT_4 == HT_4.end()) {selection_flags[ITEM] = 0; continue;}
slot_second4[ITEM] = SLOT_4->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT6, 1);
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5(uint64_t* BUF_4, uint64_t* BUF_6, uint64_t* BUF_IDX_6, HASHTABLE_PROBE HT_4, HASHTABLE_INSERT HT_6, int64_t* cycles_per_warp_main_5_join_build_6, int64_t* cycles_per_warp_main_5_join_probe_4, DBI32Type* nation__n_nationkey, DBI32Type* nation__n_regionkey, size_t nation_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_nation__n_regionkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_nation__n_regionkey[ITEM] = nation__n_regionkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_nation__n_regionkey[ITEM];
}
int64_t slot_second4[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_4 = HT_4.find(KEY_4[ITEM]);
if (SLOT_4 == HT_4.end()) {selection_flags[ITEM] = 0; continue;}
slot_second4[ITEM] = SLOT_4->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_join_probe_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_nation__n_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_nation__n_nationkey[ITEM] = nation__n_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_nation__n_nationkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_6 = atomicAdd((int*)BUF_IDX_6, 1);
HT_6.insert(cuco::pair{KEY_6[ITEM], buf_idx_6});
BUF_6[(buf_idx_6) * 2 + 0] = BUF_4[slot_second4[ITEM] * 1 + 0];
BUF_6[(buf_idx_6) * 2 + 1] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_join_build_6[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE>
__global__ void count_7(uint64_t* BUF_6, uint64_t* COUNT8, HASHTABLE_PROBE HT_6, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_nationkey[ITEM] = customer__c_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_customer__c_nationkey[ITEM];
}
int64_t slot_second6[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_6 = HT_6.find(KEY_6[ITEM]);
if (SLOT_6 == HT_6.end()) {selection_flags[ITEM] = 0; continue;}
slot_second6[ITEM] = SLOT_6->second;
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
atomicAdd((int*)COUNT8, 1);
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_7(uint64_t* BUF_6, uint64_t* BUF_8, uint64_t* BUF_IDX_8, HASHTABLE_PROBE HT_6, HASHTABLE_INSERT HT_8, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size, int64_t* cycles_per_warp_main_7_join_build_8, int64_t* cycles_per_warp_main_7_join_probe_6) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_nationkey[ITEM] = customer__c_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_customer__c_nationkey[ITEM];
}
int64_t slot_second6[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_6 = HT_6.find(KEY_6[ITEM]);
if (SLOT_6 == HT_6.end()) {selection_flags[ITEM] = 0; continue;}
slot_second6[ITEM] = SLOT_6->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_probe_6[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_8[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_customer__c_custkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_8 = atomicAdd((int*)BUF_IDX_8, 1);
HT_8.insert(cuco::pair{KEY_8[ITEM], buf_idx_8});
BUF_8[(buf_idx_8) * 3 + 0] = ITEM*TB + tid;
BUF_8[(buf_idx_8) * 3 + 1] = BUF_6[slot_second6[ITEM] * 2 + 0];
BUF_8[(buf_idx_8) * 3 + 2] = BUF_6[slot_second6[ITEM] * 2 + 1];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_build_8[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE>
__global__ void count_1(uint64_t* BUF_8, uint64_t* COUNT9, HASHTABLE_PROBE HT_8, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBDateType reg_orders__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderdate[ITEM] = orders__o_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_orders__o_orderdate[ITEM], 8766, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate[ITEM], 9131, Predicate::lt);
}
uint64_t KEY_8[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_custkey[ITEM] = orders__o_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_orders__o_custkey[ITEM];
}
int64_t slot_second8[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_8 = HT_8.find(KEY_8[ITEM]);
if (SLOT_8 == HT_8.end()) {selection_flags[ITEM] = 0; continue;}
slot_second8[ITEM] = SLOT_8->second;
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
atomicAdd((int*)COUNT9, 1);
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_8, uint64_t* BUF_9, uint64_t* BUF_IDX_9, HASHTABLE_PROBE HT_8, HASHTABLE_INSERT HT_9, int64_t* cycles_per_warp_main_1_join_build_9, int64_t* cycles_per_warp_main_1_join_probe_8, int64_t* cycles_per_warp_main_1_selection_0, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBDateType reg_orders__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderdate[ITEM] = orders__o_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_orders__o_orderdate[ITEM], 8766, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate[ITEM], 9131, Predicate::lt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_8[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_custkey[ITEM] = orders__o_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_orders__o_custkey[ITEM];
}
int64_t slot_second8[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_8 = HT_8.find(KEY_8[ITEM]);
if (SLOT_8 == HT_8.end()) {selection_flags[ITEM] = 0; continue;}
slot_second8[ITEM] = SLOT_8->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_probe_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_9[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_9[ITEM] = 0;
KEY_9[ITEM] |= reg_orders__o_orderkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_9 = atomicAdd((int*)BUF_IDX_9, 1);
HT_9.insert(cuco::pair{KEY_9[ITEM], buf_idx_9});
BUF_9[(buf_idx_9) * 4 + 0] = BUF_8[slot_second8[ITEM] * 3 + 0];
BUF_9[(buf_idx_9) * 4 + 1] = ITEM*TB + tid;
BUF_9[(buf_idx_9) * 4 + 2] = BUF_8[slot_second8[ITEM] * 3 + 1];
BUF_9[(buf_idx_9) * 4 + 3] = BUF_8[slot_second8[ITEM] * 3 + 2];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_build_9[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_12(uint64_t* COUNT11, size_t supplier_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT11, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_12(uint64_t* BUF_11, uint64_t* BUF_IDX_11, HASHTABLE_INSERT HT_11, int64_t* cycles_per_warp_main_12_join_build_11, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_11[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[ITEM*TB + tid];
}
DBI32Type reg_supplier__s_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_nationkey[ITEM] = supplier__s_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_11[ITEM] = 0;
KEY_11[ITEM] |= reg_supplier__s_suppkey[ITEM];
KEY_11[ITEM] <<= 32;
KEY_11[ITEM] |= reg_supplier__s_nationkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_11 = atomicAdd((int*)BUF_IDX_11, 1);
HT_11.insert(cuco::pair{KEY_11[ITEM], buf_idx_11});
BUF_11[(buf_idx_11) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_12_join_build_11[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void count_10(uint64_t* BUF_11, uint64_t* BUF_9, HASHTABLE_PROBE HT_11, HASHTABLE_INSERT HT_14, HASHTABLE_PROBE HT_9, DBI32Type* customer__c_nationkey, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBI16Type* nation__n_name_encoded) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_9[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_9[ITEM] = 0;
KEY_9[ITEM] |= reg_lineitem__l_orderkey[ITEM];
}
int64_t slot_second9[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_9 = HT_9.find(KEY_9[ITEM]);
if (SLOT_9 == HT_9.end()) {selection_flags[ITEM] = 0; continue;}
slot_second9[ITEM] = SLOT_9->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_11[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_suppkey[ITEM] = lineitem__l_suppkey[ITEM*TB + tid];
}
DBI32Type reg_customer__c_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_nationkey[ITEM] = customer__c_nationkey[BUF_9[slot_second9[ITEM] * 4 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_11[ITEM] = 0;
KEY_11[ITEM] |= reg_lineitem__l_suppkey[ITEM];
KEY_11[ITEM] <<= 32;
KEY_11[ITEM] |= reg_customer__c_nationkey[ITEM];
}
int64_t slot_second11[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_11 = HT_11.find(KEY_11[ITEM]);
if (SLOT_11 == HT_11.end()) {selection_flags[ITEM] = 0; continue;}
slot_second11[ITEM] = SLOT_11->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_14[ITEMS_PER_THREAD];
DBI16Type reg_nation__n_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_nation__n_name_encoded[ITEM] = nation__n_name_encoded[BUF_9[slot_second9[ITEM] * 4 + 3]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_14[ITEM] = 0;
KEY_14[ITEM] |= reg_nation__n_name_encoded[ITEM];
}
//Create aggregation hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_14.insert(cuco::pair{KEY_14[ITEM], 1});
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_10(uint64_t* BUF_11, uint64_t* BUF_9, HASHTABLE_PROBE HT_11, HASHTABLE_FIND HT_14, HASHTABLE_PROBE HT_9, DBI16Type* KEY_14nation__n_name_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* customer__c_nationkey, int64_t* cycles_per_warp_main_10_aggregation_14, int64_t* cycles_per_warp_main_10_join_probe_11, int64_t* cycles_per_warp_main_10_join_probe_9, int64_t* cycles_per_warp_main_10_map_13, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBI16Type* nation__n_name_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_9[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_9[ITEM] = 0;
KEY_9[ITEM] |= reg_lineitem__l_orderkey[ITEM];
}
int64_t slot_second9[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_9 = HT_9.find(KEY_9[ITEM]);
if (SLOT_9 == HT_9.end()) {selection_flags[ITEM] = 0; continue;}
slot_second9[ITEM] = SLOT_9->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_10_join_probe_9[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_11[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_suppkey[ITEM] = lineitem__l_suppkey[ITEM*TB + tid];
}
DBI32Type reg_customer__c_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_nationkey[ITEM] = customer__c_nationkey[BUF_9[slot_second9[ITEM] * 4 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_11[ITEM] = 0;
KEY_11[ITEM] |= reg_lineitem__l_suppkey[ITEM];
KEY_11[ITEM] <<= 32;
KEY_11[ITEM] |= reg_customer__c_nationkey[ITEM];
}
int64_t slot_second11[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_11 = HT_11.find(KEY_11[ITEM]);
if (SLOT_11 == HT_11.end()) {selection_flags[ITEM] = 0; continue;}
slot_second11[ITEM] = SLOT_11->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_10_join_probe_11[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_10_map_13[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_14[ITEMS_PER_THREAD];
DBI16Type reg_nation__n_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_nation__n_name_encoded[ITEM] = nation__n_name_encoded[BUF_9[slot_second9[ITEM] * 4 + 3]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_14[ITEM] = 0;
KEY_14[ITEM] |= reg_nation__n_name_encoded[ITEM];
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
auto buf_idx_14 = HT_14.find(KEY_14[ITEM])->second;
aggregate_sum(&aggr0__tmp_attr0[buf_idx_14], reg_map0__tmp_attr1[ITEM]);
KEY_14nation__n_name_encoded[buf_idx_14] = reg_nation__n_name_encoded[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_10_aggregation_14[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_16(size_t COUNT14, uint64_t* COUNT15) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT14); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT15, 1);
}
}
__global__ void main_16(size_t COUNT14, DBDecimalType* MAT15aggr0__tmp_attr0, DBI16Type* MAT15nation__n_name_encoded, uint64_t* MAT_IDX15, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_16_materialize_15, DBI16Type* nation__n_name_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI16Type reg_nation__n_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT14); ++ITEM) {
reg_nation__n_name_encoded[ITEM] = nation__n_name_encoded[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT14); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT14); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx15 = atomicAdd((int*)MAT_IDX15, 1);
MAT15nation__n_name_encoded[mat_idx15] = reg_nation__n_name_encoded[ITEM];
MAT15aggr0__tmp_attr0[mat_idx15] = reg_aggr0__tmp_attr0[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_16_materialize_15[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_3_selection_2;
auto main_3_selection_2_cpw_size = std::ceil((float)region_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_selection_2, sizeof(int64_t) * main_3_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_selection_2, -1, sizeof(int64_t) * main_3_selection_2_cpw_size);
//Materialize count
uint64_t* d_COUNT4;
cudaMalloc(&d_COUNT4, sizeof(uint64_t));
cudaMemset(d_COUNT4, 0, sizeof(uint64_t));
count_3<<<std::ceil((float)region_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT4, d_region__r_name, region_size);
uint64_t COUNT4;
cudaMemcpy(&COUNT4, d_COUNT4, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_3_join_build_4;
auto main_3_join_build_4_cpw_size = std::ceil((float)region_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_build_4, sizeof(int64_t) * main_3_join_build_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_build_4, -1, sizeof(int64_t) * main_3_join_build_4_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_4;
cudaMalloc(&d_BUF_IDX_4, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_4, 0, sizeof(uint64_t));
uint64_t* d_BUF_4;
cudaMalloc(&d_BUF_4, sizeof(uint64_t) * COUNT4 * 1);
auto d_HT_4 = cuco::static_map{ (int)COUNT4*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)region_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_4, d_BUF_IDX_4, d_HT_4.ref(cuco::insert), d_cycles_per_warp_main_3_join_build_4, d_cycles_per_warp_main_3_selection_2, d_region__r_name, d_region__r_regionkey, region_size);
int64_t* cycles_per_warp_main_3_selection_2 = (int64_t*)malloc(sizeof(int64_t) * main_3_selection_2_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_selection_2, d_cycles_per_warp_main_3_selection_2, sizeof(int64_t) * main_3_selection_2_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_selection_2 ";
for (auto i=0ull; i < main_3_selection_2_cpw_size; i++) std::cout << cycles_per_warp_main_3_selection_2[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_join_build_4 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_build_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_build_4, d_cycles_per_warp_main_3_join_build_4, sizeof(int64_t) * main_3_join_build_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_build_4 ";
for (auto i=0ull; i < main_3_join_build_4_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_build_4[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_5_join_probe_4;
auto main_5_join_probe_4_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_join_probe_4, sizeof(int64_t) * main_5_join_probe_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_join_probe_4, -1, sizeof(int64_t) * main_5_join_probe_4_cpw_size);
//Materialize count
uint64_t* d_COUNT6;
cudaMalloc(&d_COUNT6, sizeof(uint64_t));
cudaMemset(d_COUNT6, 0, sizeof(uint64_t));
count_5<<<std::ceil((float)nation_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_4, d_COUNT6, d_HT_4.ref(cuco::find), d_nation__n_regionkey, nation_size);
uint64_t COUNT6;
cudaMemcpy(&COUNT6, d_COUNT6, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_5_join_build_6;
auto main_5_join_build_6_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_join_build_6, sizeof(int64_t) * main_5_join_build_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_join_build_6, -1, sizeof(int64_t) * main_5_join_build_6_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_6;
cudaMalloc(&d_BUF_IDX_6, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6, 0, sizeof(uint64_t));
uint64_t* d_BUF_6;
cudaMalloc(&d_BUF_6, sizeof(uint64_t) * COUNT6 * 2);
auto d_HT_6 = cuco::static_map{ (int)COUNT6*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)nation_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_4, d_BUF_6, d_BUF_IDX_6, d_HT_4.ref(cuco::find), d_HT_6.ref(cuco::insert), d_cycles_per_warp_main_5_join_build_6, d_cycles_per_warp_main_5_join_probe_4, d_nation__n_nationkey, d_nation__n_regionkey, nation_size);
int64_t* cycles_per_warp_main_5_join_probe_4 = (int64_t*)malloc(sizeof(int64_t) * main_5_join_probe_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_join_probe_4, d_cycles_per_warp_main_5_join_probe_4, sizeof(int64_t) * main_5_join_probe_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_join_probe_4 ";
for (auto i=0ull; i < main_5_join_probe_4_cpw_size; i++) std::cout << cycles_per_warp_main_5_join_probe_4[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_join_build_6 = (int64_t*)malloc(sizeof(int64_t) * main_5_join_build_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_join_build_6, d_cycles_per_warp_main_5_join_build_6, sizeof(int64_t) * main_5_join_build_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_join_build_6 ";
for (auto i=0ull; i < main_5_join_build_6_cpw_size; i++) std::cout << cycles_per_warp_main_5_join_build_6[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_7_join_probe_6;
auto main_7_join_probe_6_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_probe_6, sizeof(int64_t) * main_7_join_probe_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_probe_6, -1, sizeof(int64_t) * main_7_join_probe_6_cpw_size);
//Materialize count
uint64_t* d_COUNT8;
cudaMalloc(&d_COUNT8, sizeof(uint64_t));
cudaMemset(d_COUNT8, 0, sizeof(uint64_t));
count_7<<<std::ceil((float)customer_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_6, d_COUNT8, d_HT_6.ref(cuco::find), d_customer__c_nationkey, customer_size);
uint64_t COUNT8;
cudaMemcpy(&COUNT8, d_COUNT8, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_7_join_build_8;
auto main_7_join_build_8_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_build_8, sizeof(int64_t) * main_7_join_build_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_build_8, -1, sizeof(int64_t) * main_7_join_build_8_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_8;
cudaMalloc(&d_BUF_IDX_8, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_8, 0, sizeof(uint64_t));
uint64_t* d_BUF_8;
cudaMalloc(&d_BUF_8, sizeof(uint64_t) * COUNT8 * 3);
auto d_HT_8 = cuco::static_map{ (int)COUNT8*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_7<<<std::ceil((float)customer_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_6, d_BUF_8, d_BUF_IDX_8, d_HT_6.ref(cuco::find), d_HT_8.ref(cuco::insert), d_customer__c_custkey, d_customer__c_nationkey, customer_size, d_cycles_per_warp_main_7_join_build_8, d_cycles_per_warp_main_7_join_probe_6);
int64_t* cycles_per_warp_main_7_join_probe_6 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_probe_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_probe_6, d_cycles_per_warp_main_7_join_probe_6, sizeof(int64_t) * main_7_join_probe_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_probe_6 ";
for (auto i=0ull; i < main_7_join_probe_6_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_probe_6[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_join_build_8 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_build_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_build_8, d_cycles_per_warp_main_7_join_build_8, sizeof(int64_t) * main_7_join_build_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_build_8 ";
for (auto i=0ull; i < main_7_join_build_8_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_build_8[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_probe_8;
auto main_1_join_probe_8_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_probe_8, sizeof(int64_t) * main_1_join_probe_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_probe_8, -1, sizeof(int64_t) * main_1_join_probe_8_cpw_size);
//Materialize count
uint64_t* d_COUNT9;
cudaMalloc(&d_COUNT9, sizeof(uint64_t));
cudaMemset(d_COUNT9, 0, sizeof(uint64_t));
count_1<<<std::ceil((float)orders_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_8, d_COUNT9, d_HT_8.ref(cuco::find), d_orders__o_custkey, d_orders__o_orderdate, orders_size);
uint64_t COUNT9;
cudaMemcpy(&COUNT9, d_COUNT9, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_1_join_build_9;
auto main_1_join_build_9_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_build_9, sizeof(int64_t) * main_1_join_build_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_build_9, -1, sizeof(int64_t) * main_1_join_build_9_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_9;
cudaMalloc(&d_BUF_IDX_9, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_9, 0, sizeof(uint64_t));
uint64_t* d_BUF_9;
cudaMalloc(&d_BUF_9, sizeof(uint64_t) * COUNT9 * 4);
auto d_HT_9 = cuco::static_map{ (int)COUNT9*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)orders_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_8, d_BUF_9, d_BUF_IDX_9, d_HT_8.ref(cuco::find), d_HT_9.ref(cuco::insert), d_cycles_per_warp_main_1_join_build_9, d_cycles_per_warp_main_1_join_probe_8, d_cycles_per_warp_main_1_selection_0, d_orders__o_custkey, d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
int64_t* cycles_per_warp_main_1_selection_0 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_0 ";
for (auto i=0ull; i < main_1_selection_0_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_0[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_probe_8 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_probe_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_probe_8, d_cycles_per_warp_main_1_join_probe_8, sizeof(int64_t) * main_1_join_probe_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_probe_8 ";
for (auto i=0ull; i < main_1_join_probe_8_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_probe_8[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_build_9 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_build_9_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_build_9, d_cycles_per_warp_main_1_join_build_9, sizeof(int64_t) * main_1_join_build_9_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_build_9 ";
for (auto i=0ull; i < main_1_join_build_9_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_build_9[i] << " ";
std::cout << std::endl;
//Materialize count
uint64_t* d_COUNT11;
cudaMalloc(&d_COUNT11, sizeof(uint64_t));
cudaMemset(d_COUNT11, 0, sizeof(uint64_t));
count_12<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT11, supplier_size);
uint64_t COUNT11;
cudaMemcpy(&COUNT11, d_COUNT11, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_12_join_build_11;
auto main_12_join_build_11_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_12_join_build_11, sizeof(int64_t) * main_12_join_build_11_cpw_size);
cudaMemset(d_cycles_per_warp_main_12_join_build_11, -1, sizeof(int64_t) * main_12_join_build_11_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_11;
cudaMalloc(&d_BUF_IDX_11, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_11, 0, sizeof(uint64_t));
uint64_t* d_BUF_11;
cudaMalloc(&d_BUF_11, sizeof(uint64_t) * COUNT11 * 1);
auto d_HT_11 = cuco::static_map{ (int)COUNT11*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_12<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_11, d_BUF_IDX_11, d_HT_11.ref(cuco::insert), d_cycles_per_warp_main_12_join_build_11, d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
int64_t* cycles_per_warp_main_12_join_build_11 = (int64_t*)malloc(sizeof(int64_t) * main_12_join_build_11_cpw_size);
cudaMemcpy(cycles_per_warp_main_12_join_build_11, d_cycles_per_warp_main_12_join_build_11, sizeof(int64_t) * main_12_join_build_11_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_12_join_build_11 ";
for (auto i=0ull; i < main_12_join_build_11_cpw_size; i++) std::cout << cycles_per_warp_main_12_join_build_11[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_10_join_probe_9;
auto main_10_join_probe_9_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_10_join_probe_9, sizeof(int64_t) * main_10_join_probe_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_10_join_probe_9, -1, sizeof(int64_t) * main_10_join_probe_9_cpw_size);
int64_t* d_cycles_per_warp_main_10_join_probe_11;
auto main_10_join_probe_11_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_10_join_probe_11, sizeof(int64_t) * main_10_join_probe_11_cpw_size);
cudaMemset(d_cycles_per_warp_main_10_join_probe_11, -1, sizeof(int64_t) * main_10_join_probe_11_cpw_size);
int64_t* d_cycles_per_warp_main_10_map_13;
auto main_10_map_13_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_10_map_13, sizeof(int64_t) * main_10_map_13_cpw_size);
cudaMemset(d_cycles_per_warp_main_10_map_13, -1, sizeof(int64_t) * main_10_map_13_cpw_size);
//Create aggregation hash table
auto d_HT_14 = cuco::static_map{ (int)22857*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_10<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_11, d_BUF_9, d_HT_11.ref(cuco::find), d_HT_14.ref(cuco::insert), d_HT_9.ref(cuco::find), d_customer__c_nationkey, d_lineitem__l_orderkey, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name_encoded);
size_t COUNT14 = d_HT_14.size();
thrust::device_vector<int64_t> keys_14(COUNT14), vals_14(COUNT14);
d_HT_14.retrieve_all(keys_14.begin(), vals_14.begin());
d_HT_14.clear();
int64_t* raw_keys14 = thrust::raw_pointer_cast(keys_14.data());
insertKeys<<<std::ceil((float)COUNT14/128.), 128>>>(raw_keys14, d_HT_14.ref(cuco::insert), COUNT14);
int64_t* d_cycles_per_warp_main_10_aggregation_14;
auto main_10_aggregation_14_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_10_aggregation_14, sizeof(int64_t) * main_10_aggregation_14_cpw_size);
cudaMemset(d_cycles_per_warp_main_10_aggregation_14, -1, sizeof(int64_t) * main_10_aggregation_14_cpw_size);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT14);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT14);
DBI16Type* d_KEY_14nation__n_name_encoded;
cudaMalloc(&d_KEY_14nation__n_name_encoded, sizeof(DBI16Type) * COUNT14);
cudaMemset(d_KEY_14nation__n_name_encoded, 0, sizeof(DBI16Type) * COUNT14);
main_10<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_11, d_BUF_9, d_HT_11.ref(cuco::find), d_HT_14.ref(cuco::find), d_HT_9.ref(cuco::find), d_KEY_14nation__n_name_encoded, d_aggr0__tmp_attr0, d_customer__c_nationkey, d_cycles_per_warp_main_10_aggregation_14, d_cycles_per_warp_main_10_join_probe_11, d_cycles_per_warp_main_10_join_probe_9, d_cycles_per_warp_main_10_map_13, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name_encoded);
int64_t* cycles_per_warp_main_10_join_probe_9 = (int64_t*)malloc(sizeof(int64_t) * main_10_join_probe_9_cpw_size);
cudaMemcpy(cycles_per_warp_main_10_join_probe_9, d_cycles_per_warp_main_10_join_probe_9, sizeof(int64_t) * main_10_join_probe_9_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_10_join_probe_9 ";
for (auto i=0ull; i < main_10_join_probe_9_cpw_size; i++) std::cout << cycles_per_warp_main_10_join_probe_9[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_10_join_probe_11 = (int64_t*)malloc(sizeof(int64_t) * main_10_join_probe_11_cpw_size);
cudaMemcpy(cycles_per_warp_main_10_join_probe_11, d_cycles_per_warp_main_10_join_probe_11, sizeof(int64_t) * main_10_join_probe_11_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_10_join_probe_11 ";
for (auto i=0ull; i < main_10_join_probe_11_cpw_size; i++) std::cout << cycles_per_warp_main_10_join_probe_11[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_10_map_13 = (int64_t*)malloc(sizeof(int64_t) * main_10_map_13_cpw_size);
cudaMemcpy(cycles_per_warp_main_10_map_13, d_cycles_per_warp_main_10_map_13, sizeof(int64_t) * main_10_map_13_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_10_map_13 ";
for (auto i=0ull; i < main_10_map_13_cpw_size; i++) std::cout << cycles_per_warp_main_10_map_13[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_10_aggregation_14 = (int64_t*)malloc(sizeof(int64_t) * main_10_aggregation_14_cpw_size);
cudaMemcpy(cycles_per_warp_main_10_aggregation_14, d_cycles_per_warp_main_10_aggregation_14, sizeof(int64_t) * main_10_aggregation_14_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_10_aggregation_14 ";
for (auto i=0ull; i < main_10_aggregation_14_cpw_size; i++) std::cout << cycles_per_warp_main_10_aggregation_14[i] << " ";
std::cout << std::endl;
//Materialize count
uint64_t* d_COUNT15;
cudaMalloc(&d_COUNT15, sizeof(uint64_t));
cudaMemset(d_COUNT15, 0, sizeof(uint64_t));
count_16<<<std::ceil((float)COUNT14/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT14, d_COUNT15);
uint64_t COUNT15;
cudaMemcpy(&COUNT15, d_COUNT15, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_16_materialize_15;
auto main_16_materialize_15_cpw_size = std::ceil((float)COUNT14/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_16_materialize_15, sizeof(int64_t) * main_16_materialize_15_cpw_size);
cudaMemset(d_cycles_per_warp_main_16_materialize_15, -1, sizeof(int64_t) * main_16_materialize_15_cpw_size);
//Materialize buffers
uint64_t* d_MAT_IDX15;
cudaMalloc(&d_MAT_IDX15, sizeof(uint64_t));
cudaMemset(d_MAT_IDX15, 0, sizeof(uint64_t));
auto MAT15nation__n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT15);
DBI16Type* d_MAT15nation__n_name_encoded;
cudaMalloc(&d_MAT15nation__n_name_encoded, sizeof(DBI16Type) * COUNT15);
auto MAT15aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT15);
DBDecimalType* d_MAT15aggr0__tmp_attr0;
cudaMalloc(&d_MAT15aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT15);
main_16<<<std::ceil((float)COUNT14/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT14, d_MAT15aggr0__tmp_attr0, d_MAT15nation__n_name_encoded, d_MAT_IDX15, d_aggr0__tmp_attr0, d_cycles_per_warp_main_16_materialize_15, d_KEY_14nation__n_name_encoded);
cudaMemcpy(MAT15nation__n_name_encoded, d_MAT15nation__n_name_encoded, sizeof(DBI16Type) * COUNT15, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT15aggr0__tmp_attr0, d_MAT15aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT15, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_16_materialize_15 = (int64_t*)malloc(sizeof(int64_t) * main_16_materialize_15_cpw_size);
cudaMemcpy(cycles_per_warp_main_16_materialize_15, d_cycles_per_warp_main_16_materialize_15, sizeof(int64_t) * main_16_materialize_15_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_16_materialize_15 ";
for (auto i=0ull; i < main_16_materialize_15_cpw_size; i++) std::cout << cycles_per_warp_main_16_materialize_15[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
      size_t aux_mem = usedGpuMem() - used_mem;
      std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_4);
cudaFree(d_BUF_IDX_4);
cudaFree(d_COUNT4);
cudaFree(d_BUF_6);
cudaFree(d_BUF_IDX_6);
cudaFree(d_COUNT6);
cudaFree(d_BUF_8);
cudaFree(d_BUF_IDX_8);
cudaFree(d_COUNT8);
cudaFree(d_BUF_9);
cudaFree(d_BUF_IDX_9);
cudaFree(d_COUNT9);
cudaFree(d_BUF_11);
cudaFree(d_BUF_IDX_11);
cudaFree(d_COUNT11);
cudaFree(d_KEY_14nation__n_name_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT15);
cudaFree(d_MAT15aggr0__tmp_attr0);
cudaFree(d_MAT15nation__n_name_encoded);
cudaFree(d_MAT_IDX15);
free(MAT15aggr0__tmp_attr0);
free(MAT15nation__n_name_encoded);
}