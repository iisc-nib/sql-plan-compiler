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
__global__ void count_6(uint64_t* COUNT5, size_t orders_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT5, 1);
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_6(uint64_t* BUF_5, uint64_t* BUF_IDX_5, HASHTABLE_INSERT HT_5, int64_t* cycles_per_warp_main_6_join_build_5, DBI32Type* orders__o_orderkey, size_t orders_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_5[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_5[ITEM] = 0;
KEY_5[ITEM] |= reg_orders__o_orderkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_5 = atomicAdd((int*)BUF_IDX_5, 1);
HT_5.insert(cuco::pair{KEY_5[ITEM], buf_idx_5});
BUF_5[(buf_idx_5) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_6_join_build_5[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void count_1(uint64_t* BUF_5, HASHTABLE_PROBE HT_5, HASHTABLE_INSERT HT_9, DBDateType* lineitem__l_commitdate, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_receiptdate, DBDateType* lineitem__l_shipdate, DBStringType* lineitem__l_shipmode, DBI16Type* lineitem__l_shipmode_encoded, size_t lineitem_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBDateType reg_lineitem__l_receiptdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_receiptdate[ITEM] = lineitem__l_receiptdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_receiptdate[ITEM], 8766, Predicate::gte) && evaluatePredicate(reg_lineitem__l_receiptdate[ITEM], 9131, Predicate::lt);
}
DBDateType reg_lineitem__l_shipdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_shipdate[ITEM] = lineitem__l_shipdate[ITEM*TB + tid];
}
DBDateType reg_lineitem__l_commitdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_commitdate[ITEM] = lineitem__l_commitdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_shipdate[ITEM], reg_lineitem__l_commitdate[ITEM], Predicate::lt);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_commitdate[ITEM], reg_lineitem__l_receiptdate[ITEM], Predicate::lt);
}
DBStringType reg_lineitem__l_shipmode[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_shipmode[ITEM] = lineitem__l_shipmode[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_lineitem__l_shipmode[ITEM], "MAIL", Predicate::eq)) || (evaluatePredicate(reg_lineitem__l_shipmode[ITEM], "SHIP", Predicate::eq));
}
uint64_t KEY_5[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_5[ITEM] = 0;
KEY_5[ITEM] |= reg_lineitem__l_orderkey[ITEM];
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
uint64_t KEY_9[ITEMS_PER_THREAD];
DBI16Type reg_lineitem__l_shipmode_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_shipmode_encoded[ITEM] = lineitem__l_shipmode_encoded[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_9[ITEM] = 0;
KEY_9[ITEM] |= reg_lineitem__l_shipmode_encoded[ITEM];
}
//Create aggregation hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_9.insert(cuco::pair{KEY_9[ITEM], 1});
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_1(uint64_t* BUF_5, HASHTABLE_PROBE HT_5, HASHTABLE_FIND HT_9, DBI16Type* KEY_9lineitem__l_shipmode_encoded, DBI32Type* aggr0__tmp_attr0, DBI32Type* aggr0__tmp_attr2, int64_t* cycles_per_warp_main_1_aggregation_9, int64_t* cycles_per_warp_main_1_join_probe_5, int64_t* cycles_per_warp_main_1_map_7, int64_t* cycles_per_warp_main_1_map_8, int64_t* cycles_per_warp_main_1_selection_0, int64_t* cycles_per_warp_main_1_selection_2, int64_t* cycles_per_warp_main_1_selection_3, int64_t* cycles_per_warp_main_1_selection_4, DBDateType* lineitem__l_commitdate, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_receiptdate, DBDateType* lineitem__l_shipdate, DBStringType* lineitem__l_shipmode, DBI16Type* lineitem__l_shipmode_encoded, size_t lineitem_size, DBStringType* orders__o_orderpriority) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBDateType reg_lineitem__l_receiptdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_receiptdate[ITEM] = lineitem__l_receiptdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_receiptdate[ITEM], 8766, Predicate::gte) && evaluatePredicate(reg_lineitem__l_receiptdate[ITEM], 9131, Predicate::lt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
DBDateType reg_lineitem__l_shipdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_shipdate[ITEM] = lineitem__l_shipdate[ITEM*TB + tid];
}
DBDateType reg_lineitem__l_commitdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_commitdate[ITEM] = lineitem__l_commitdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_shipdate[ITEM], reg_lineitem__l_commitdate[ITEM], Predicate::lt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_commitdate[ITEM], reg_lineitem__l_receiptdate[ITEM], Predicate::lt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_3[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
DBStringType reg_lineitem__l_shipmode[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_shipmode[ITEM] = lineitem__l_shipmode[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_lineitem__l_shipmode[ITEM], "MAIL", Predicate::eq)) || (evaluatePredicate(reg_lineitem__l_shipmode[ITEM], "SHIP", Predicate::eq));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_5[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_5[ITEM] = 0;
KEY_5[ITEM] |= reg_lineitem__l_orderkey[ITEM];
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_probe_5[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_map_7[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_map_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_9[ITEMS_PER_THREAD];
DBI16Type reg_lineitem__l_shipmode_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_shipmode_encoded[ITEM] = lineitem__l_shipmode_encoded[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_9[ITEM] = 0;
KEY_9[ITEM] |= reg_lineitem__l_shipmode_encoded[ITEM];
}
//Aggregate in hashtable
DBStringType reg_orders__o_orderpriority[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_orderpriority[ITEM] = orders__o_orderpriority[BUF_5[slot_second5[ITEM] * 1 + 0]];
}
DBI32Type reg_map0__tmp_attr3[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr3[ITEM] = (((evaluatePredicate(reg_orders__o_orderpriority[ITEM], "1-URGENT", Predicate::neq)) && (evaluatePredicate(reg_orders__o_orderpriority[ITEM], "2-HIGH", Predicate::neq))));
}
DBI32Type reg_map0__tmp_attr1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr1[ITEM] = (((evaluatePredicate(reg_orders__o_orderpriority[ITEM], "1-URGENT", Predicate::eq)) || (evaluatePredicate(reg_orders__o_orderpriority[ITEM], "2-HIGH", Predicate::eq))));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_9 = HT_9.find(KEY_9[ITEM])->second;
aggregate_sum(&aggr0__tmp_attr2[buf_idx_9], reg_map0__tmp_attr3[ITEM]);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_9], reg_map0__tmp_attr1[ITEM]);
KEY_9lineitem__l_shipmode_encoded[buf_idx_9] = reg_lineitem__l_shipmode_encoded[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_aggregation_9[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_11(uint64_t* COUNT10, size_t COUNT9) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT10, 1);
}
}
__global__ void main_11(size_t COUNT9, DBI32Type* MAT10aggr0__tmp_attr0, DBI32Type* MAT10aggr0__tmp_attr2, DBI16Type* MAT10lineitem__l_shipmode_encoded, uint64_t* MAT_IDX10, DBI32Type* aggr0__tmp_attr0, DBI32Type* aggr0__tmp_attr2, int64_t* cycles_per_warp_main_11_materialize_10, DBI16Type* lineitem__l_shipmode_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI16Type reg_lineitem__l_shipmode_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_lineitem__l_shipmode_encoded[ITEM] = lineitem__l_shipmode_encoded[ITEM*TB + tid];
}
DBI32Type reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
DBI32Type reg_aggr0__tmp_attr2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_aggr0__tmp_attr2[ITEM] = aggr0__tmp_attr2[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx10 = atomicAdd((int*)MAT_IDX10, 1);
MAT10lineitem__l_shipmode_encoded[mat_idx10] = reg_lineitem__l_shipmode_encoded[ITEM];
MAT10aggr0__tmp_attr0[mat_idx10] = reg_aggr0__tmp_attr0[ITEM];
MAT10aggr0__tmp_attr2[mat_idx10] = reg_aggr0__tmp_attr2[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_materialize_10[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
//Materialize count
uint64_t* d_COUNT5;
cudaMalloc(&d_COUNT5, sizeof(uint64_t));
cudaMemset(d_COUNT5, 0, sizeof(uint64_t));
count_6<<<std::ceil((float)orders_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT5, orders_size);
uint64_t COUNT5;
cudaMemcpy(&COUNT5, d_COUNT5, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_6_join_build_5;
auto main_6_join_build_5_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_6_join_build_5, sizeof(int64_t) * main_6_join_build_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_6_join_build_5, -1, sizeof(int64_t) * main_6_join_build_5_cpw_size);
// Insert hash table control;
uint64_t* d_BUF_IDX_5;
cudaMalloc(&d_BUF_IDX_5, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5, 0, sizeof(uint64_t));
uint64_t* d_BUF_5;
cudaMalloc(&d_BUF_5, sizeof(uint64_t) * COUNT5 * 1);
auto d_HT_5 = cuco::static_map{ (int)COUNT5*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6<<<std::ceil((float)orders_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_5, d_BUF_IDX_5, d_HT_5.ref(cuco::insert), d_cycles_per_warp_main_6_join_build_5, d_orders__o_orderkey, orders_size);
int64_t* cycles_per_warp_main_6_join_build_5 = (int64_t*)malloc(sizeof(int64_t) * main_6_join_build_5_cpw_size);
cudaMemcpy(cycles_per_warp_main_6_join_build_5, d_cycles_per_warp_main_6_join_build_5, sizeof(int64_t) * main_6_join_build_5_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_6_join_build_5 ";
for (auto i=0ull; i < main_6_join_build_5_cpw_size; i++) std::cout << cycles_per_warp_main_6_join_build_5[i] << " ";
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
int64_t* d_cycles_per_warp_main_1_join_probe_5;
auto main_1_join_probe_5_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_probe_5, sizeof(int64_t) * main_1_join_probe_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_probe_5, -1, sizeof(int64_t) * main_1_join_probe_5_cpw_size);
int64_t* d_cycles_per_warp_main_1_map_7;
auto main_1_map_7_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_map_7, sizeof(int64_t) * main_1_map_7_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_map_7, -1, sizeof(int64_t) * main_1_map_7_cpw_size);
int64_t* d_cycles_per_warp_main_1_map_8;
auto main_1_map_8_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_map_8, sizeof(int64_t) * main_1_map_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_map_8, -1, sizeof(int64_t) * main_1_map_8_cpw_size);
//Create aggregation hash table
auto d_HT_9 = cuco::static_map{ (int)17582*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_1<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_5, d_HT_5.ref(cuco::find), d_HT_9.ref(cuco::insert), d_lineitem__l_commitdate, d_lineitem__l_orderkey, d_lineitem__l_receiptdate, d_lineitem__l_shipdate, d_lineitem__l_shipmode, d_lineitem__l_shipmode_encoded, lineitem_size);
size_t COUNT9 = d_HT_9.size();
thrust::device_vector<int64_t> keys_9(COUNT9), vals_9(COUNT9);
d_HT_9.retrieve_all(keys_9.begin(), vals_9.begin());
d_HT_9.clear();
int64_t* raw_keys9 = thrust::raw_pointer_cast(keys_9.data());
insertKeys<<<std::ceil((float)COUNT9/128.), 128>>>(raw_keys9, d_HT_9.ref(cuco::insert), COUNT9);
int64_t* d_cycles_per_warp_main_1_aggregation_9;
auto main_1_aggregation_9_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_aggregation_9, sizeof(int64_t) * main_1_aggregation_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_aggregation_9, -1, sizeof(int64_t) * main_1_aggregation_9_cpw_size);
//Aggregate in hashtable
DBI32Type* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBI32Type) * COUNT9);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBI32Type) * COUNT9);
DBI32Type* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBI32Type) * COUNT9);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBI32Type) * COUNT9);
DBI16Type* d_KEY_9lineitem__l_shipmode_encoded;
cudaMalloc(&d_KEY_9lineitem__l_shipmode_encoded, sizeof(DBI16Type) * COUNT9);
cudaMemset(d_KEY_9lineitem__l_shipmode_encoded, 0, sizeof(DBI16Type) * COUNT9);
main_1<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_5, d_HT_5.ref(cuco::find), d_HT_9.ref(cuco::find), d_KEY_9lineitem__l_shipmode_encoded, d_aggr0__tmp_attr0, d_aggr0__tmp_attr2, d_cycles_per_warp_main_1_aggregation_9, d_cycles_per_warp_main_1_join_probe_5, d_cycles_per_warp_main_1_map_7, d_cycles_per_warp_main_1_map_8, d_cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_2, d_cycles_per_warp_main_1_selection_3, d_cycles_per_warp_main_1_selection_4, d_lineitem__l_commitdate, d_lineitem__l_orderkey, d_lineitem__l_receiptdate, d_lineitem__l_shipdate, d_lineitem__l_shipmode, d_lineitem__l_shipmode_encoded, lineitem_size, d_orders__o_orderpriority);
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
int64_t* cycles_per_warp_main_1_join_probe_5 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_probe_5_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_probe_5, d_cycles_per_warp_main_1_join_probe_5, sizeof(int64_t) * main_1_join_probe_5_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_probe_5 ";
for (auto i=0ull; i < main_1_join_probe_5_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_probe_5[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_map_7 = (int64_t*)malloc(sizeof(int64_t) * main_1_map_7_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_map_7, d_cycles_per_warp_main_1_map_7, sizeof(int64_t) * main_1_map_7_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_map_7 ";
for (auto i=0ull; i < main_1_map_7_cpw_size; i++) std::cout << cycles_per_warp_main_1_map_7[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_map_8 = (int64_t*)malloc(sizeof(int64_t) * main_1_map_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_map_8, d_cycles_per_warp_main_1_map_8, sizeof(int64_t) * main_1_map_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_map_8 ";
for (auto i=0ull; i < main_1_map_8_cpw_size; i++) std::cout << cycles_per_warp_main_1_map_8[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_aggregation_9 = (int64_t*)malloc(sizeof(int64_t) * main_1_aggregation_9_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_aggregation_9, d_cycles_per_warp_main_1_aggregation_9, sizeof(int64_t) * main_1_aggregation_9_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_aggregation_9 ";
for (auto i=0ull; i < main_1_aggregation_9_cpw_size; i++) std::cout << cycles_per_warp_main_1_aggregation_9[i] << " ";
std::cout << std::endl;
//Materialize count
uint64_t* d_COUNT10;
cudaMalloc(&d_COUNT10, sizeof(uint64_t));
cudaMemset(d_COUNT10, 0, sizeof(uint64_t));
count_11<<<std::ceil((float)COUNT9/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT10, COUNT9);
uint64_t COUNT10;
cudaMemcpy(&COUNT10, d_COUNT10, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_11_materialize_10;
auto main_11_materialize_10_cpw_size = std::ceil((float)COUNT9/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_materialize_10, sizeof(int64_t) * main_11_materialize_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_materialize_10, -1, sizeof(int64_t) * main_11_materialize_10_cpw_size);
//Materialize buffers
uint64_t* d_MAT_IDX10;
cudaMalloc(&d_MAT_IDX10, sizeof(uint64_t));
cudaMemset(d_MAT_IDX10, 0, sizeof(uint64_t));
auto MAT10lineitem__l_shipmode_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT10);
DBI16Type* d_MAT10lineitem__l_shipmode_encoded;
cudaMalloc(&d_MAT10lineitem__l_shipmode_encoded, sizeof(DBI16Type) * COUNT10);
auto MAT10aggr0__tmp_attr0 = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT10);
DBI32Type* d_MAT10aggr0__tmp_attr0;
cudaMalloc(&d_MAT10aggr0__tmp_attr0, sizeof(DBI32Type) * COUNT10);
auto MAT10aggr0__tmp_attr2 = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT10);
DBI32Type* d_MAT10aggr0__tmp_attr2;
cudaMalloc(&d_MAT10aggr0__tmp_attr2, sizeof(DBI32Type) * COUNT10);
main_11<<<std::ceil((float)COUNT9/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT9, d_MAT10aggr0__tmp_attr0, d_MAT10aggr0__tmp_attr2, d_MAT10lineitem__l_shipmode_encoded, d_MAT_IDX10, d_aggr0__tmp_attr0, d_aggr0__tmp_attr2, d_cycles_per_warp_main_11_materialize_10, d_KEY_9lineitem__l_shipmode_encoded);
cudaMemcpy(MAT10lineitem__l_shipmode_encoded, d_MAT10lineitem__l_shipmode_encoded, sizeof(DBI16Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr0__tmp_attr0, d_MAT10aggr0__tmp_attr0, sizeof(DBI32Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr0__tmp_attr2, d_MAT10aggr0__tmp_attr2, sizeof(DBI32Type) * COUNT10, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_11_materialize_10 = (int64_t*)malloc(sizeof(int64_t) * main_11_materialize_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_materialize_10, d_cycles_per_warp_main_11_materialize_10, sizeof(int64_t) * main_11_materialize_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_materialize_10 ";
for (auto i=0ull; i < main_11_materialize_10_cpw_size; i++) std::cout << cycles_per_warp_main_11_materialize_10[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
      size_t aux_mem = usedGpuMem() - used_mem;
      std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_5);
cudaFree(d_BUF_IDX_5);
cudaFree(d_COUNT5);
cudaFree(d_KEY_9lineitem__l_shipmode_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_COUNT10);
cudaFree(d_MAT10aggr0__tmp_attr0);
cudaFree(d_MAT10aggr0__tmp_attr2);
cudaFree(d_MAT10lineitem__l_shipmode_encoded);
cudaFree(d_MAT_IDX10);
free(MAT10aggr0__tmp_attr0);
free(MAT10aggr0__tmp_attr2);
free(MAT10lineitem__l_shipmode_encoded);
}