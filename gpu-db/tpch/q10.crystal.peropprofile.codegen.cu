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
__global__ void count_1(uint64_t* COUNT4, DBDateType* orders__o_orderdate, size_t orders_size) {
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
selection_flags[ITEM] &= evaluatePredicate(reg_orders__o_orderdate[ITEM], 8674, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate[ITEM], 8766, Predicate::lt);
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT4, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_4, uint64_t* BUF_IDX_4, HASHTABLE_INSERT HT_4, int64_t* cycles_per_warp_main_1_join_build_4, int64_t* cycles_per_warp_main_1_selection_0, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
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
selection_flags[ITEM] &= evaluatePredicate(reg_orders__o_orderdate[ITEM], 8674, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate[ITEM], 8766, Predicate::lt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_orders__o_orderkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_4 = atomicAdd((int*)BUF_IDX_4, 1);
HT_4.insert(cuco::pair{KEY_4[ITEM], buf_idx_4});
BUF_4[(buf_idx_4) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_build_4[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_6(uint64_t* COUNT5, size_t customer_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT5, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_6(uint64_t* BUF_5, uint64_t* BUF_IDX_5, HASHTABLE_INSERT HT_5, DBI32Type* customer__c_custkey, size_t customer_size, int64_t* cycles_per_warp_main_6_join_build_5) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_5[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_5[ITEM] = 0;
KEY_5[ITEM] |= reg_customer__c_custkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_5 = atomicAdd((int*)BUF_IDX_5, 1);
HT_5.insert(cuco::pair{KEY_5[ITEM], buf_idx_5});
BUF_5[(buf_idx_5) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_6_join_build_5[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_8(uint64_t* COUNT7, size_t nation_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT7, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_8(uint64_t* BUF_7, uint64_t* BUF_IDX_7, HASHTABLE_INSERT HT_7, int64_t* cycles_per_warp_main_8_join_build_7, DBI32Type* nation__n_nationkey, size_t nation_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_7[ITEMS_PER_THREAD];
DBI32Type reg_nation__n_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
reg_nation__n_nationkey[ITEM] = nation__n_nationkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_7[ITEM] = 0;
KEY_7[ITEM] |= reg_nation__n_nationkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < nation_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_7 = atomicAdd((int*)BUF_IDX_7, 1);
HT_7.insert(cuco::pair{KEY_7[ITEM], buf_idx_7});
BUF_7[(buf_idx_7) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_8_join_build_7[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_3(uint64_t* BUF_4, uint64_t* BUF_5, uint64_t* BUF_7, HASHTABLE_INSERT HT_10, HASHTABLE_PROBE HT_4, HASHTABLE_PROBE HT_5, HASHTABLE_PROBE HT_7, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, DBI32Type* lineitem__l_orderkey, DBCharType* lineitem__l_returnflag, size_t lineitem_size, DBI32Type* orders__o_custkey) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBCharType reg_lineitem__l_returnflag[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_returnflag[ITEM] = lineitem__l_returnflag[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_returnflag[ITEM], 'R', Predicate::eq);
}
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_lineitem__l_orderkey[ITEM];
}
int64_t slot_second4[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_4 = HT_4.find(KEY_4[ITEM]);
if (SLOT_4 == HT_4.end()) {selection_flags[ITEM] = 0; continue;}
slot_second4[ITEM] = SLOT_4->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_5[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_custkey[ITEM] = orders__o_custkey[BUF_4[slot_second4[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_5[ITEM] = 0;
KEY_5[ITEM] |= reg_orders__o_custkey[ITEM];
}
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
uint64_t KEY_7[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_nationkey[ITEM] = customer__c_nationkey[BUF_5[slot_second5[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_7[ITEM] = 0;
KEY_7[ITEM] |= reg_customer__c_nationkey[ITEM];
}
int64_t slot_second7[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_7 = HT_7.find(KEY_7[ITEM]);
if (SLOT_7 == HT_7.end()) {selection_flags[ITEM] = 0; continue;}
slot_second7[ITEM] = SLOT_7->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_10[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_custkey[ITEM] = customer__c_custkey[BUF_5[slot_second5[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_10[ITEM] = 0;
KEY_10[ITEM] |= reg_customer__c_custkey[ITEM];
}
//Create aggregation hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_10.insert(cuco::pair{KEY_10[ITEM], 1});
}
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_3(uint64_t* BUF_4, uint64_t* BUF_5, uint64_t* BUF_7, HASHTABLE_FIND HT_10, HASHTABLE_PROBE HT_4, HASHTABLE_PROBE HT_5, HASHTABLE_PROBE HT_7, DBI32Type* KEY_10customer__c_custkey, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr__c_acctbal, DBI16Type* aggr__n_name_encoded, DBDecimalType* customer__c_acctbal, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, int64_t* cycles_per_warp_main_3_aggregation_10, int64_t* cycles_per_warp_main_3_join_probe_4, int64_t* cycles_per_warp_main_3_join_probe_5, int64_t* cycles_per_warp_main_3_join_probe_7, int64_t* cycles_per_warp_main_3_map_9, int64_t* cycles_per_warp_main_3_selection_2, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBCharType* lineitem__l_returnflag, size_t lineitem_size, DBI16Type* nation__n_name_encoded, DBI32Type* orders__o_custkey) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBCharType reg_lineitem__l_returnflag[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_returnflag[ITEM] = lineitem__l_returnflag[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_returnflag[ITEM], 'R', Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_lineitem__l_orderkey[ITEM];
}
int64_t slot_second4[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_4 = HT_4.find(KEY_4[ITEM]);
if (SLOT_4 == HT_4.end()) {selection_flags[ITEM] = 0; continue;}
slot_second4[ITEM] = SLOT_4->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_probe_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_5[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_custkey[ITEM] = orders__o_custkey[BUF_4[slot_second4[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_5[ITEM] = 0;
KEY_5[ITEM] |= reg_orders__o_custkey[ITEM];
}
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_probe_5[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_7[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_nationkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_nationkey[ITEM] = customer__c_nationkey[BUF_5[slot_second5[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_7[ITEM] = 0;
KEY_7[ITEM] |= reg_customer__c_nationkey[ITEM];
}
int64_t slot_second7[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_7 = HT_7.find(KEY_7[ITEM]);
if (SLOT_7 == HT_7.end()) {selection_flags[ITEM] = 0; continue;}
slot_second7[ITEM] = SLOT_7->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_probe_7[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_map_9[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_10[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_custkey[ITEM] = customer__c_custkey[BUF_5[slot_second5[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_10[ITEM] = 0;
KEY_10[ITEM] |= reg_customer__c_custkey[ITEM];
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
DBI16Type reg_nation__n_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_nation__n_name_encoded[ITEM] = nation__n_name_encoded[BUF_7[slot_second7[ITEM] * 1 + 0]];
}
DBDecimalType reg_customer__c_acctbal[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_acctbal[ITEM] = customer__c_acctbal[BUF_5[slot_second5[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_10 = HT_10.find(KEY_10[ITEM])->second;
aggregate_sum(&aggr0__tmp_attr0[buf_idx_10], reg_map0__tmp_attr1[ITEM]);
aggregate_any(&aggr__n_name_encoded[buf_idx_10], reg_nation__n_name_encoded[ITEM]);
aggregate_any(&aggr__c_acctbal[buf_idx_10], reg_customer__c_acctbal[ITEM]);
KEY_10customer__c_custkey[buf_idx_10] = reg_customer__c_custkey[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_aggregation_10[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_12(size_t COUNT10, uint64_t* COUNT11) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT10); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT11, 1);
}
}
__global__ void main_12(size_t COUNT10, DBDecimalType* MAT11aggr0__tmp_attr0, DBDecimalType* MAT11aggr__c_acctbal, DBI16Type* MAT11aggr__n_name_encoded, DBI32Type* MAT11customer__c_custkey, uint64_t* MAT_IDX11, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr__c_acctbal, DBI16Type* aggr__n_name_encoded, DBI32Type* customer__c_custkey, int64_t* cycles_per_warp_main_12_materialize_11) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT10); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT10); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
DBDecimalType reg_aggr__c_acctbal[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT10); ++ITEM) {
reg_aggr__c_acctbal[ITEM] = aggr__c_acctbal[ITEM*TB + tid];
}
DBI16Type reg_aggr__n_name_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT10); ++ITEM) {
reg_aggr__n_name_encoded[ITEM] = aggr__n_name_encoded[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT10); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx11 = atomicAdd((int*)MAT_IDX11, 1);
MAT11customer__c_custkey[mat_idx11] = reg_customer__c_custkey[ITEM];
MAT11aggr0__tmp_attr0[mat_idx11] = reg_aggr0__tmp_attr0[ITEM];
MAT11aggr__c_acctbal[mat_idx11] = reg_aggr__c_acctbal[ITEM];
MAT11aggr__n_name_encoded[mat_idx11] = reg_aggr__n_name_encoded[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_12_materialize_11[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
//Materialize count
uint64_t* d_COUNT4;
cudaMalloc(&d_COUNT4, sizeof(uint64_t));
cudaMemset(d_COUNT4, 0, sizeof(uint64_t));
count_1<<<std::ceil((float)orders_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT4, d_orders__o_orderdate, orders_size);
uint64_t COUNT4;
cudaMemcpy(&COUNT4, d_COUNT4, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_1_join_build_4;
auto main_1_join_build_4_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_build_4, sizeof(int64_t) * main_1_join_build_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_build_4, -1, sizeof(int64_t) * main_1_join_build_4_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_4;
cudaMalloc(&d_BUF_IDX_4, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_4, 0, sizeof(uint64_t));
uint64_t* d_BUF_4;
cudaMalloc(&d_BUF_4, sizeof(uint64_t) * COUNT4 * 1);
auto d_HT_4 = cuco::static_map{ (int)COUNT4*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)orders_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_4, d_BUF_IDX_4, d_HT_4.ref(cuco::insert), d_cycles_per_warp_main_1_join_build_4, d_cycles_per_warp_main_1_selection_0, d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
int64_t* cycles_per_warp_main_1_selection_0 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_0 ";
for (auto i=0ull; i < main_1_selection_0_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_0[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_build_4 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_build_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_build_4, d_cycles_per_warp_main_1_join_build_4, sizeof(int64_t) * main_1_join_build_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_build_4 ";
for (auto i=0ull; i < main_1_join_build_4_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_build_4[i] << " ";
std::cout << std::endl;
//Materialize count
uint64_t* d_COUNT5;
cudaMalloc(&d_COUNT5, sizeof(uint64_t));
cudaMemset(d_COUNT5, 0, sizeof(uint64_t));
count_6<<<std::ceil((float)customer_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT5, customer_size);
uint64_t COUNT5;
cudaMemcpy(&COUNT5, d_COUNT5, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_6_join_build_5;
auto main_6_join_build_5_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_6_join_build_5, sizeof(int64_t) * main_6_join_build_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_6_join_build_5, -1, sizeof(int64_t) * main_6_join_build_5_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_5;
cudaMalloc(&d_BUF_IDX_5, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5, 0, sizeof(uint64_t));
uint64_t* d_BUF_5;
cudaMalloc(&d_BUF_5, sizeof(uint64_t) * COUNT5 * 1);
auto d_HT_5 = cuco::static_map{ (int)COUNT5*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6<<<std::ceil((float)customer_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_5, d_BUF_IDX_5, d_HT_5.ref(cuco::insert), d_customer__c_custkey, customer_size, d_cycles_per_warp_main_6_join_build_5);
int64_t* cycles_per_warp_main_6_join_build_5 = (int64_t*)malloc(sizeof(int64_t) * main_6_join_build_5_cpw_size);
cudaMemcpy(cycles_per_warp_main_6_join_build_5, d_cycles_per_warp_main_6_join_build_5, sizeof(int64_t) * main_6_join_build_5_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_6_join_build_5 ";
for (auto i=0ull; i < main_6_join_build_5_cpw_size; i++) std::cout << cycles_per_warp_main_6_join_build_5[i] << " ";
std::cout << std::endl;
//Materialize count
uint64_t* d_COUNT7;
cudaMalloc(&d_COUNT7, sizeof(uint64_t));
cudaMemset(d_COUNT7, 0, sizeof(uint64_t));
count_8<<<std::ceil((float)nation_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT7, nation_size);
uint64_t COUNT7;
cudaMemcpy(&COUNT7, d_COUNT7, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_8_join_build_7;
auto main_8_join_build_7_cpw_size = std::ceil((float)nation_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_8_join_build_7, sizeof(int64_t) * main_8_join_build_7_cpw_size);
cudaMemset(d_cycles_per_warp_main_8_join_build_7, -1, sizeof(int64_t) * main_8_join_build_7_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_7;
cudaMalloc(&d_BUF_IDX_7, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_7, 0, sizeof(uint64_t));
uint64_t* d_BUF_7;
cudaMalloc(&d_BUF_7, sizeof(uint64_t) * COUNT7 * 1);
auto d_HT_7 = cuco::static_map{ (int)COUNT7*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_8<<<std::ceil((float)nation_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_7, d_BUF_IDX_7, d_HT_7.ref(cuco::insert), d_cycles_per_warp_main_8_join_build_7, d_nation__n_nationkey, nation_size);
int64_t* cycles_per_warp_main_8_join_build_7 = (int64_t*)malloc(sizeof(int64_t) * main_8_join_build_7_cpw_size);
cudaMemcpy(cycles_per_warp_main_8_join_build_7, d_cycles_per_warp_main_8_join_build_7, sizeof(int64_t) * main_8_join_build_7_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_8_join_build_7 ";
for (auto i=0ull; i < main_8_join_build_7_cpw_size; i++) std::cout << cycles_per_warp_main_8_join_build_7[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_3_selection_2;
auto main_3_selection_2_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_selection_2, sizeof(int64_t) * main_3_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_selection_2, -1, sizeof(int64_t) * main_3_selection_2_cpw_size);
int64_t* d_cycles_per_warp_main_3_join_probe_4;
auto main_3_join_probe_4_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_probe_4, sizeof(int64_t) * main_3_join_probe_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_probe_4, -1, sizeof(int64_t) * main_3_join_probe_4_cpw_size);
int64_t* d_cycles_per_warp_main_3_join_probe_5;
auto main_3_join_probe_5_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_probe_5, sizeof(int64_t) * main_3_join_probe_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_probe_5, -1, sizeof(int64_t) * main_3_join_probe_5_cpw_size);
int64_t* d_cycles_per_warp_main_3_join_probe_7;
auto main_3_join_probe_7_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_probe_7, sizeof(int64_t) * main_3_join_probe_7_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_probe_7, -1, sizeof(int64_t) * main_3_join_probe_7_cpw_size);
int64_t* d_cycles_per_warp_main_3_map_9;
auto main_3_map_9_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_map_9, sizeof(int64_t) * main_3_map_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_map_9, -1, sizeof(int64_t) * main_3_map_9_cpw_size);
//Create aggregation hash table
auto d_HT_10 = cuco::static_map{ (int)45145*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_3<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_4, d_BUF_5, d_BUF_7, d_HT_10.ref(cuco::insert), d_HT_4.ref(cuco::find), d_HT_5.ref(cuco::find), d_HT_7.ref(cuco::find), d_customer__c_custkey, d_customer__c_nationkey, d_lineitem__l_orderkey, d_lineitem__l_returnflag, lineitem_size, d_orders__o_custkey);
size_t COUNT10 = d_HT_10.size();
thrust::device_vector<int64_t> keys_10(COUNT10), vals_10(COUNT10);
d_HT_10.retrieve_all(keys_10.begin(), vals_10.begin());
d_HT_10.clear();
int64_t* raw_keys10 = thrust::raw_pointer_cast(keys_10.data());
insertKeys<<<std::ceil((float)COUNT10/128.), 128>>>(raw_keys10, d_HT_10.ref(cuco::insert), COUNT10);
int64_t* d_cycles_per_warp_main_3_aggregation_10;
auto main_3_aggregation_10_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_aggregation_10, sizeof(int64_t) * main_3_aggregation_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_aggregation_10, -1, sizeof(int64_t) * main_3_aggregation_10_cpw_size);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT10);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT10);
DBI16Type* d_aggr__n_name_encoded;
cudaMalloc(&d_aggr__n_name_encoded, sizeof(DBI16Type) * COUNT10);
cudaMemset(d_aggr__n_name_encoded, 0, sizeof(DBI16Type) * COUNT10);
auto aggr__n_name_map = nation__n_name_map;
DBDecimalType* d_aggr__c_acctbal;
cudaMalloc(&d_aggr__c_acctbal, sizeof(DBDecimalType) * COUNT10);
cudaMemset(d_aggr__c_acctbal, 0, sizeof(DBDecimalType) * COUNT10);
DBI32Type* d_KEY_10customer__c_custkey;
cudaMalloc(&d_KEY_10customer__c_custkey, sizeof(DBI32Type) * COUNT10);
cudaMemset(d_KEY_10customer__c_custkey, 0, sizeof(DBI32Type) * COUNT10);
main_3<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_4, d_BUF_5, d_BUF_7, d_HT_10.ref(cuco::find), d_HT_4.ref(cuco::find), d_HT_5.ref(cuco::find), d_HT_7.ref(cuco::find), d_KEY_10customer__c_custkey, d_aggr0__tmp_attr0, d_aggr__c_acctbal, d_aggr__n_name_encoded, d_customer__c_acctbal, d_customer__c_custkey, d_customer__c_nationkey, d_cycles_per_warp_main_3_aggregation_10, d_cycles_per_warp_main_3_join_probe_4, d_cycles_per_warp_main_3_join_probe_5, d_cycles_per_warp_main_3_join_probe_7, d_cycles_per_warp_main_3_map_9, d_cycles_per_warp_main_3_selection_2, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_returnflag, lineitem_size, d_nation__n_name_encoded, d_orders__o_custkey);
int64_t* cycles_per_warp_main_3_selection_2 = (int64_t*)malloc(sizeof(int64_t) * main_3_selection_2_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_selection_2, d_cycles_per_warp_main_3_selection_2, sizeof(int64_t) * main_3_selection_2_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_selection_2 ";
for (auto i=0ull; i < main_3_selection_2_cpw_size; i++) std::cout << cycles_per_warp_main_3_selection_2[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_join_probe_4 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_probe_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_probe_4, d_cycles_per_warp_main_3_join_probe_4, sizeof(int64_t) * main_3_join_probe_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_probe_4 ";
for (auto i=0ull; i < main_3_join_probe_4_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_probe_4[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_join_probe_5 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_probe_5_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_probe_5, d_cycles_per_warp_main_3_join_probe_5, sizeof(int64_t) * main_3_join_probe_5_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_probe_5 ";
for (auto i=0ull; i < main_3_join_probe_5_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_probe_5[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_join_probe_7 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_probe_7_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_probe_7, d_cycles_per_warp_main_3_join_probe_7, sizeof(int64_t) * main_3_join_probe_7_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_probe_7 ";
for (auto i=0ull; i < main_3_join_probe_7_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_probe_7[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_map_9 = (int64_t*)malloc(sizeof(int64_t) * main_3_map_9_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_map_9, d_cycles_per_warp_main_3_map_9, sizeof(int64_t) * main_3_map_9_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_map_9 ";
for (auto i=0ull; i < main_3_map_9_cpw_size; i++) std::cout << cycles_per_warp_main_3_map_9[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_aggregation_10 = (int64_t*)malloc(sizeof(int64_t) * main_3_aggregation_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_aggregation_10, d_cycles_per_warp_main_3_aggregation_10, sizeof(int64_t) * main_3_aggregation_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_aggregation_10 ";
for (auto i=0ull; i < main_3_aggregation_10_cpw_size; i++) std::cout << cycles_per_warp_main_3_aggregation_10[i] << " ";
std::cout << std::endl;
//Materialize count
uint64_t* d_COUNT11;
cudaMalloc(&d_COUNT11, sizeof(uint64_t));
cudaMemset(d_COUNT11, 0, sizeof(uint64_t));
count_12<<<std::ceil((float)COUNT10/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT10, d_COUNT11);
uint64_t COUNT11;
cudaMemcpy(&COUNT11, d_COUNT11, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_12_materialize_11;
auto main_12_materialize_11_cpw_size = std::ceil((float)COUNT10/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_12_materialize_11, sizeof(int64_t) * main_12_materialize_11_cpw_size);
cudaMemset(d_cycles_per_warp_main_12_materialize_11, -1, sizeof(int64_t) * main_12_materialize_11_cpw_size);
//Materialize buffers
uint64_t* d_MAT_IDX11;
cudaMalloc(&d_MAT_IDX11, sizeof(uint64_t));
cudaMemset(d_MAT_IDX11, 0, sizeof(uint64_t));
auto MAT11customer__c_custkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT11);
DBI32Type* d_MAT11customer__c_custkey;
cudaMalloc(&d_MAT11customer__c_custkey, sizeof(DBI32Type) * COUNT11);
auto MAT11aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT11);
DBDecimalType* d_MAT11aggr0__tmp_attr0;
cudaMalloc(&d_MAT11aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT11);
auto MAT11aggr__c_acctbal = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT11);
DBDecimalType* d_MAT11aggr__c_acctbal;
cudaMalloc(&d_MAT11aggr__c_acctbal, sizeof(DBDecimalType) * COUNT11);
auto MAT11aggr__n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT11);
DBI16Type* d_MAT11aggr__n_name_encoded;
cudaMalloc(&d_MAT11aggr__n_name_encoded, sizeof(DBI16Type) * COUNT11);
main_12<<<std::ceil((float)COUNT10/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT10, d_MAT11aggr0__tmp_attr0, d_MAT11aggr__c_acctbal, d_MAT11aggr__n_name_encoded, d_MAT11customer__c_custkey, d_MAT_IDX11, d_aggr0__tmp_attr0, d_aggr__c_acctbal, d_aggr__n_name_encoded, d_KEY_10customer__c_custkey, d_cycles_per_warp_main_12_materialize_11);
cudaMemcpy(MAT11customer__c_custkey, d_MAT11customer__c_custkey, sizeof(DBI32Type) * COUNT11, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT11aggr0__tmp_attr0, d_MAT11aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT11, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT11aggr__c_acctbal, d_MAT11aggr__c_acctbal, sizeof(DBDecimalType) * COUNT11, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT11aggr__n_name_encoded, d_MAT11aggr__n_name_encoded, sizeof(DBI16Type) * COUNT11, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_12_materialize_11 = (int64_t*)malloc(sizeof(int64_t) * main_12_materialize_11_cpw_size);
cudaMemcpy(cycles_per_warp_main_12_materialize_11, d_cycles_per_warp_main_12_materialize_11, sizeof(int64_t) * main_12_materialize_11_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_12_materialize_11 ";
for (auto i=0ull; i < main_12_materialize_11_cpw_size; i++) std::cout << cycles_per_warp_main_12_materialize_11[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
      size_t aux_mem = usedGpuMem() - used_mem;
      std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_4);
cudaFree(d_BUF_IDX_4);
cudaFree(d_COUNT4);
cudaFree(d_BUF_5);
cudaFree(d_BUF_IDX_5);
cudaFree(d_COUNT5);
cudaFree(d_BUF_7);
cudaFree(d_BUF_IDX_7);
cudaFree(d_COUNT7);
cudaFree(d_KEY_10customer__c_custkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_aggr__c_acctbal);
cudaFree(d_aggr__n_name_encoded);
cudaFree(d_COUNT11);
cudaFree(d_MAT11aggr0__tmp_attr0);
cudaFree(d_MAT11aggr__c_acctbal);
cudaFree(d_MAT11aggr__n_name_encoded);
cudaFree(d_MAT11customer__c_custkey);
cudaFree(d_MAT_IDX11);
free(MAT11aggr0__tmp_attr0);
free(MAT11aggr__c_acctbal);
free(MAT11aggr__n_name_encoded);
free(MAT11customer__c_custkey);
}