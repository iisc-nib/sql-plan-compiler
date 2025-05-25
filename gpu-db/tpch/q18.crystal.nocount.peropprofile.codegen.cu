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
template<typename HASHTABLE_FIND>
__global__ void main_1(HASHTABLE_FIND HT_0, DBI32Type* KEY_0lineitem_u_1__l_orderkey, int* SLOT_COUNT_0, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_1_aggregation_0, size_t lineitem_size, DBI32Type* lineitem_u_1__l_orderkey, DBDecimalType* lineitem_u_1__l_quantity) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_0[ITEMS_PER_THREAD];
DBI32Type reg_lineitem_u_1__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem_u_1__l_orderkey[ITEM] = lineitem_u_1__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_0[ITEM] = 0;
KEY_0[ITEM] |= reg_lineitem_u_1__l_orderkey[ITEM];
}
//Aggregate in hashtable
DBDecimalType reg_lineitem_u_1__l_quantity[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem_u_1__l_quantity[ITEM] = lineitem_u_1__l_quantity[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_0 = get_aggregation_slot(KEY_0[ITEM], HT_0, SLOT_COUNT_0);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_0], reg_lineitem_u_1__l_quantity[ITEM]);
KEY_0lineitem_u_1__l_orderkey[buf_idx_0] = reg_lineitem_u_1__l_orderkey[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_aggregation_0[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT_SJ>
__global__ void main_3(size_t COUNT0, HASHTABLE_INSERT_SJ HT_4, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_3_selection_2, int64_t* cycles_per_warp_main_3_semi_join_build_4, DBI32Type* lineitem_u_1__l_orderkey) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_aggr0__tmp_attr0[ITEM], 300.0, Predicate::gt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_lineitem_u_1__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_lineitem_u_1__l_orderkey[ITEM] = lineitem_u_1__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_lineitem_u_1__l_orderkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_4.insert(cuco::pair{KEY_4[ITEM], 1});
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_semi_join_build_4[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT>
__global__ void main_7(uint64_t* BUF_6, uint64_t* BUF_IDX_6, HASHTABLE_INSERT HT_6, DBI32Type* customer__c_custkey, size_t customer_size, int64_t* cycles_per_warp_main_7_join_build_6) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_customer__c_custkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_6.insert(cuco::pair{KEY_6[ITEM], ITEM*TB + tid});
BUF_6[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_build_6[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE_SJ, typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5(uint64_t* BUF_6, uint64_t* BUF_8, uint64_t* BUF_IDX_8, HASHTABLE_PROBE_SJ HT_4, HASHTABLE_PROBE HT_6, HASHTABLE_INSERT HT_8, int64_t* cycles_per_warp_main_5_join_build_8, int64_t* cycles_per_warp_main_5_join_probe_6, int64_t* cycles_per_warp_main_5_semi_join_probe_4, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
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
//Probe Hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_4 = HT_4.find(KEY_4[ITEM]);
if (SLOT_4 == HT_4.end()) {selection_flags[ITEM] = 0;}
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_semi_join_probe_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_custkey[ITEM] = orders__o_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_orders__o_custkey[ITEM];
}
//Probe Hash table
int64_t slot_second6[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_6 = HT_6.find(KEY_6[ITEM]);
if (SLOT_6 == HT_6.end()) {selection_flags[ITEM] = 0; continue;}
slot_second6[ITEM] = SLOT_6->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_join_probe_6[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_8[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_orders__o_orderkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_8.insert(cuco::pair{KEY_8[ITEM], ITEM*TB + tid});
BUF_8[(ITEM*TB + tid) * 2 + 0] = BUF_6[slot_second6[ITEM] * 1 + 0];
BUF_8[(ITEM*TB + tid) * 2 + 1] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_join_build_8[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_9(uint64_t* BUF_8, HASHTABLE_FIND HT_10, HASHTABLE_PROBE HT_8, DBI32Type* KEY_10orders__o_orderkey, int* SLOT_COUNT_10, DBDecimalType* aggr1__tmp_attr1, DBI32Type* aggr__c_custkey, DBDateType* aggr__o_orderdate, DBDecimalType* aggr__o_totalprice, DBI32Type* customer__c_custkey, int64_t* cycles_per_warp_main_9_aggregation_10, int64_t* cycles_per_warp_main_9_join_probe_8, DBI32Type* lineitem__l_orderkey, DBDecimalType* lineitem__l_quantity, size_t lineitem_size, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, DBDecimalType* orders__o_totalprice) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_8[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_lineitem__l_orderkey[ITEM];
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_9_join_probe_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_10[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[BUF_8[slot_second8[ITEM] * 2 + 1]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_10[ITEM] = 0;
KEY_10[ITEM] |= reg_orders__o_orderkey[ITEM];
}
//Aggregate in hashtable
DBDecimalType reg_lineitem__l_quantity[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_quantity[ITEM] = lineitem__l_quantity[ITEM*TB + tid];
}
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_custkey[ITEM] = customer__c_custkey[BUF_8[slot_second8[ITEM] * 2 + 0]];
}
DBDecimalType reg_orders__o_totalprice[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_totalprice[ITEM] = orders__o_totalprice[BUF_8[slot_second8[ITEM] * 2 + 1]];
}
DBDateType reg_orders__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_orderdate[ITEM] = orders__o_orderdate[BUF_8[slot_second8[ITEM] * 2 + 1]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_10 = get_aggregation_slot(KEY_10[ITEM], HT_10, SLOT_COUNT_10);
aggregate_sum(&aggr1__tmp_attr1[buf_idx_10], reg_lineitem__l_quantity[ITEM]);
aggregate_any(&aggr__c_custkey[buf_idx_10], reg_customer__c_custkey[ITEM]);
aggregate_any(&aggr__o_totalprice[buf_idx_10], reg_orders__o_totalprice[ITEM]);
aggregate_any(&aggr__o_orderdate[buf_idx_10], reg_orders__o_orderdate[ITEM]);
KEY_10orders__o_orderkey[buf_idx_10] = reg_orders__o_orderkey[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_9_aggregation_10[blockIdx.x] = cycles_per_warp;}
}
__global__ void main_12(size_t COUNT10, DBDecimalType* MAT11aggr1__tmp_attr1, DBI32Type* MAT11aggr__c_custkey, DBDateType* MAT11aggr__o_orderdate, DBDecimalType* MAT11aggr__o_totalprice, DBI32Type* MAT11orders__o_orderkey, uint64_t* MAT_IDX11, DBDecimalType* aggr1__tmp_attr1, DBI32Type* aggr__c_custkey, DBDateType* aggr__o_orderdate, DBDecimalType* aggr__o_totalprice, int64_t* cycles_per_warp_main_12_materialize_11, DBI32Type* orders__o_orderkey) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI32Type reg_aggr__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT10); ++ITEM) {
reg_aggr__c_custkey[ITEM] = aggr__c_custkey[ITEM*TB + tid];
}
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT10); ++ITEM) {
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[ITEM*TB + tid];
}
DBDateType reg_aggr__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT10); ++ITEM) {
reg_aggr__o_orderdate[ITEM] = aggr__o_orderdate[ITEM*TB + tid];
}
DBDecimalType reg_aggr__o_totalprice[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT10); ++ITEM) {
reg_aggr__o_totalprice[ITEM] = aggr__o_totalprice[ITEM*TB + tid];
}
DBDecimalType reg_aggr1__tmp_attr1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT10); ++ITEM) {
reg_aggr1__tmp_attr1[ITEM] = aggr1__tmp_attr1[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT10); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx11 = atomicAdd((int*)MAT_IDX11, 1);
MAT11aggr__c_custkey[mat_idx11] = reg_aggr__c_custkey[ITEM];
MAT11orders__o_orderkey[mat_idx11] = reg_orders__o_orderkey[ITEM];
MAT11aggr__o_orderdate[mat_idx11] = reg_aggr__o_orderdate[ITEM];
MAT11aggr__o_totalprice[mat_idx11] = reg_aggr__o_totalprice[ITEM];
MAT11aggr1__tmp_attr1[mat_idx11] = reg_aggr1__tmp_attr1[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_12_materialize_11[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_1_aggregation_0;
auto main_1_aggregation_0_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_aggregation_0, sizeof(int64_t) * main_1_aggregation_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_aggregation_0, -1, sizeof(int64_t) * main_1_aggregation_0_cpw_size);
size_t COUNT0 = 6001215;
auto d_HT_0 = cuco::static_map{ (int)6001215*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_0;
cudaMalloc(&d_SLOT_COUNT_0, sizeof(int));
cudaMemset(d_SLOT_COUNT_0, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT0);
DBI32Type* d_KEY_0lineitem_u_1__l_orderkey;
cudaMalloc(&d_KEY_0lineitem_u_1__l_orderkey, sizeof(DBI32Type) * COUNT0);
cudaMemset(d_KEY_0lineitem_u_1__l_orderkey, 0, sizeof(DBI32Type) * COUNT0);
main_1<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TB>>>(d_HT_0.ref(cuco::insert_and_find), d_KEY_0lineitem_u_1__l_orderkey, d_SLOT_COUNT_0, d_aggr0__tmp_attr0, d_cycles_per_warp_main_1_aggregation_0, lineitem_size, d_lineitem__l_orderkey, d_lineitem__l_quantity);
int64_t* cycles_per_warp_main_1_aggregation_0 = (int64_t*)malloc(sizeof(int64_t) * main_1_aggregation_0_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_aggregation_0, d_cycles_per_warp_main_1_aggregation_0, sizeof(int64_t) * main_1_aggregation_0_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_aggregation_0 ";
for (auto i=0ull; i < main_1_aggregation_0_cpw_size; i++) std::cout << cycles_per_warp_main_1_aggregation_0[i] << " ";
std::cout << std::endl;
COUNT0 = d_HT_0.size();
int64_t* d_cycles_per_warp_main_3_selection_2;
auto main_3_selection_2_cpw_size = std::ceil((float)COUNT0/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_selection_2, sizeof(int64_t) * main_3_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_selection_2, -1, sizeof(int64_t) * main_3_selection_2_cpw_size);
int64_t* d_cycles_per_warp_main_3_semi_join_build_4;
auto main_3_semi_join_build_4_cpw_size = std::ceil((float)COUNT0/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_semi_join_build_4, sizeof(int64_t) * main_3_semi_join_build_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_semi_join_build_4, -1, sizeof(int64_t) * main_3_semi_join_build_4_cpw_size);
size_t COUNT4 = COUNT0;
// Insert hash table control;
auto d_HT_4 = cuco::static_map{ (int)COUNT4*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)COUNT0/(float)TILE_SIZE), TB>>>(COUNT0, d_HT_4.ref(cuco::insert), d_aggr0__tmp_attr0, d_cycles_per_warp_main_3_selection_2, d_cycles_per_warp_main_3_semi_join_build_4, d_KEY_0lineitem_u_1__l_orderkey);
int64_t* d_cycles_per_warp_main_7_join_build_6;
auto main_7_join_build_6_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_build_6, sizeof(int64_t) * main_7_join_build_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_build_6, -1, sizeof(int64_t) * main_7_join_build_6_cpw_size);
size_t COUNT6 = customer_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_6;
cudaMalloc(&d_BUF_IDX_6, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6, 0, sizeof(uint64_t));
uint64_t* d_BUF_6;
cudaMalloc(&d_BUF_6, sizeof(uint64_t) * COUNT6 * 1);
auto d_HT_6 = cuco::static_map{ (int)COUNT6*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_7<<<std::ceil((float)customer_size/(float)TILE_SIZE), TB>>>(d_BUF_6, d_BUF_IDX_6, d_HT_6.ref(cuco::insert), d_customer__c_custkey, customer_size, d_cycles_per_warp_main_7_join_build_6);
int64_t* cycles_per_warp_main_7_join_build_6 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_build_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_build_6, d_cycles_per_warp_main_7_join_build_6, sizeof(int64_t) * main_7_join_build_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_build_6 ";
for (auto i=0ull; i < main_7_join_build_6_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_build_6[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_5_semi_join_probe_4;
auto main_5_semi_join_probe_4_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_semi_join_probe_4, sizeof(int64_t) * main_5_semi_join_probe_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_semi_join_probe_4, -1, sizeof(int64_t) * main_5_semi_join_probe_4_cpw_size);
int64_t* d_cycles_per_warp_main_5_join_probe_6;
auto main_5_join_probe_6_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_join_probe_6, sizeof(int64_t) * main_5_join_probe_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_join_probe_6, -1, sizeof(int64_t) * main_5_join_probe_6_cpw_size);
int64_t* d_cycles_per_warp_main_5_join_build_8;
auto main_5_join_build_8_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_join_build_8, sizeof(int64_t) * main_5_join_build_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_join_build_8, -1, sizeof(int64_t) * main_5_join_build_8_cpw_size);
size_t COUNT8 = orders_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_8;
cudaMalloc(&d_BUF_IDX_8, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_8, 0, sizeof(uint64_t));
uint64_t* d_BUF_8;
cudaMalloc(&d_BUF_8, sizeof(uint64_t) * COUNT8 * 2);
auto d_HT_8 = cuco::static_map{ (int)COUNT8*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)orders_size/(float)TILE_SIZE), TB>>>(d_BUF_6, d_BUF_8, d_BUF_IDX_8, d_HT_4.ref(cuco::find), d_HT_6.ref(cuco::find), d_HT_8.ref(cuco::insert), d_cycles_per_warp_main_5_join_build_8, d_cycles_per_warp_main_5_join_probe_6, d_cycles_per_warp_main_5_semi_join_probe_4, d_orders__o_custkey, d_orders__o_orderkey, orders_size);
int64_t* cycles_per_warp_main_5_semi_join_probe_4 = (int64_t*)malloc(sizeof(int64_t) * main_5_semi_join_probe_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_semi_join_probe_4, d_cycles_per_warp_main_5_semi_join_probe_4, sizeof(int64_t) * main_5_semi_join_probe_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_semi_join_probe_4 ";
for (auto i=0ull; i < main_5_semi_join_probe_4_cpw_size; i++) std::cout << cycles_per_warp_main_5_semi_join_probe_4[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_join_probe_6 = (int64_t*)malloc(sizeof(int64_t) * main_5_join_probe_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_join_probe_6, d_cycles_per_warp_main_5_join_probe_6, sizeof(int64_t) * main_5_join_probe_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_join_probe_6 ";
for (auto i=0ull; i < main_5_join_probe_6_cpw_size; i++) std::cout << cycles_per_warp_main_5_join_probe_6[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_5_join_build_8 = (int64_t*)malloc(sizeof(int64_t) * main_5_join_build_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_5_join_build_8, d_cycles_per_warp_main_5_join_build_8, sizeof(int64_t) * main_5_join_build_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_5_join_build_8 ";
for (auto i=0ull; i < main_5_join_build_8_cpw_size; i++) std::cout << cycles_per_warp_main_5_join_build_8[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_9_join_probe_8;
auto main_9_join_probe_8_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_9_join_probe_8, sizeof(int64_t) * main_9_join_probe_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_9_join_probe_8, -1, sizeof(int64_t) * main_9_join_probe_8_cpw_size);
int64_t* d_cycles_per_warp_main_9_aggregation_10;
auto main_9_aggregation_10_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_9_aggregation_10, sizeof(int64_t) * main_9_aggregation_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_9_aggregation_10, -1, sizeof(int64_t) * main_9_aggregation_10_cpw_size);
size_t COUNT10 = 6001215;
auto d_HT_10 = cuco::static_map{ (int)6001215*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_10;
cudaMalloc(&d_SLOT_COUNT_10, sizeof(int));
cudaMemset(d_SLOT_COUNT_10, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr1__tmp_attr1;
cudaMalloc(&d_aggr1__tmp_attr1, sizeof(DBDecimalType) * COUNT10);
cudaMemset(d_aggr1__tmp_attr1, 0, sizeof(DBDecimalType) * COUNT10);
DBI32Type* d_aggr__c_custkey;
cudaMalloc(&d_aggr__c_custkey, sizeof(DBI32Type) * COUNT10);
cudaMemset(d_aggr__c_custkey, 0, sizeof(DBI32Type) * COUNT10);
DBDecimalType* d_aggr__o_totalprice;
cudaMalloc(&d_aggr__o_totalprice, sizeof(DBDecimalType) * COUNT10);
cudaMemset(d_aggr__o_totalprice, 0, sizeof(DBDecimalType) * COUNT10);
DBDateType* d_aggr__o_orderdate;
cudaMalloc(&d_aggr__o_orderdate, sizeof(DBDateType) * COUNT10);
cudaMemset(d_aggr__o_orderdate, 0, sizeof(DBDateType) * COUNT10);
DBI32Type* d_KEY_10orders__o_orderkey;
cudaMalloc(&d_KEY_10orders__o_orderkey, sizeof(DBI32Type) * COUNT10);
cudaMemset(d_KEY_10orders__o_orderkey, 0, sizeof(DBI32Type) * COUNT10);
main_9<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TB>>>(d_BUF_8, d_HT_10.ref(cuco::insert_and_find), d_HT_8.ref(cuco::find), d_KEY_10orders__o_orderkey, d_SLOT_COUNT_10, d_aggr1__tmp_attr1, d_aggr__c_custkey, d_aggr__o_orderdate, d_aggr__o_totalprice, d_customer__c_custkey, d_cycles_per_warp_main_9_aggregation_10, d_cycles_per_warp_main_9_join_probe_8, d_lineitem__l_orderkey, d_lineitem__l_quantity, lineitem_size, d_orders__o_orderdate, d_orders__o_orderkey, d_orders__o_totalprice);
int64_t* cycles_per_warp_main_9_join_probe_8 = (int64_t*)malloc(sizeof(int64_t) * main_9_join_probe_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_9_join_probe_8, d_cycles_per_warp_main_9_join_probe_8, sizeof(int64_t) * main_9_join_probe_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_9_join_probe_8 ";
for (auto i=0ull; i < main_9_join_probe_8_cpw_size; i++) std::cout << cycles_per_warp_main_9_join_probe_8[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_9_aggregation_10 = (int64_t*)malloc(sizeof(int64_t) * main_9_aggregation_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_9_aggregation_10, d_cycles_per_warp_main_9_aggregation_10, sizeof(int64_t) * main_9_aggregation_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_9_aggregation_10 ";
for (auto i=0ull; i < main_9_aggregation_10_cpw_size; i++) std::cout << cycles_per_warp_main_9_aggregation_10[i] << " ";
std::cout << std::endl;
COUNT10 = d_HT_10.size();
int64_t* d_cycles_per_warp_main_12_materialize_11;
auto main_12_materialize_11_cpw_size = std::ceil((float)COUNT10/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_12_materialize_11, sizeof(int64_t) * main_12_materialize_11_cpw_size);
cudaMemset(d_cycles_per_warp_main_12_materialize_11, -1, sizeof(int64_t) * main_12_materialize_11_cpw_size);
size_t COUNT11 = COUNT10;
//Materialize buffers
uint64_t* d_MAT_IDX11;
cudaMalloc(&d_MAT_IDX11, sizeof(uint64_t));
cudaMemset(d_MAT_IDX11, 0, sizeof(uint64_t));
auto MAT11aggr__c_custkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT11);
DBI32Type* d_MAT11aggr__c_custkey;
cudaMalloc(&d_MAT11aggr__c_custkey, sizeof(DBI32Type) * COUNT11);
auto MAT11orders__o_orderkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT11);
DBI32Type* d_MAT11orders__o_orderkey;
cudaMalloc(&d_MAT11orders__o_orderkey, sizeof(DBI32Type) * COUNT11);
auto MAT11aggr__o_orderdate = (DBDateType*)malloc(sizeof(DBDateType) * COUNT11);
DBDateType* d_MAT11aggr__o_orderdate;
cudaMalloc(&d_MAT11aggr__o_orderdate, sizeof(DBDateType) * COUNT11);
auto MAT11aggr__o_totalprice = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT11);
DBDecimalType* d_MAT11aggr__o_totalprice;
cudaMalloc(&d_MAT11aggr__o_totalprice, sizeof(DBDecimalType) * COUNT11);
auto MAT11aggr1__tmp_attr1 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT11);
DBDecimalType* d_MAT11aggr1__tmp_attr1;
cudaMalloc(&d_MAT11aggr1__tmp_attr1, sizeof(DBDecimalType) * COUNT11);
main_12<<<std::ceil((float)COUNT10/(float)TILE_SIZE), TB>>>(COUNT10, d_MAT11aggr1__tmp_attr1, d_MAT11aggr__c_custkey, d_MAT11aggr__o_orderdate, d_MAT11aggr__o_totalprice, d_MAT11orders__o_orderkey, d_MAT_IDX11, d_aggr1__tmp_attr1, d_aggr__c_custkey, d_aggr__o_orderdate, d_aggr__o_totalprice, d_cycles_per_warp_main_12_materialize_11, d_KEY_10orders__o_orderkey);
uint64_t MATCOUNT_11 = 0;
cudaMemcpy(&MATCOUNT_11, d_MAT_IDX11, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT11aggr__c_custkey, d_MAT11aggr__c_custkey, sizeof(DBI32Type) * COUNT11, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT11orders__o_orderkey, d_MAT11orders__o_orderkey, sizeof(DBI32Type) * COUNT11, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT11aggr__o_orderdate, d_MAT11aggr__o_orderdate, sizeof(DBDateType) * COUNT11, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT11aggr__o_totalprice, d_MAT11aggr__o_totalprice, sizeof(DBDecimalType) * COUNT11, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT11aggr1__tmp_attr1, d_MAT11aggr1__tmp_attr1, sizeof(DBDecimalType) * COUNT11, cudaMemcpyDeviceToHost);
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
cudaFree(d_KEY_0lineitem_u_1__l_orderkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_BUF_6);
cudaFree(d_BUF_IDX_6);
cudaFree(d_BUF_8);
cudaFree(d_BUF_IDX_8);
cudaFree(d_KEY_10orders__o_orderkey);
cudaFree(d_aggr1__tmp_attr1);
cudaFree(d_aggr__c_custkey);
cudaFree(d_aggr__o_orderdate);
cudaFree(d_aggr__o_totalprice);
cudaFree(d_MAT11aggr1__tmp_attr1);
cudaFree(d_MAT11aggr__c_custkey);
cudaFree(d_MAT11aggr__o_orderdate);
cudaFree(d_MAT11aggr__o_totalprice);
cudaFree(d_MAT11orders__o_orderkey);
cudaFree(d_MAT_IDX11);
free(MAT11aggr1__tmp_attr1);
free(MAT11aggr__c_custkey);
free(MAT11aggr__o_orderdate);
free(MAT11aggr__o_totalprice);
free(MAT11orders__o_orderkey);
}