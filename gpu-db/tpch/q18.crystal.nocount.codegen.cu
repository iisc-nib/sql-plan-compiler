#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
#define ITEMS_PER_THREAD 4
#define TILE_SIZE 512
#define TB TILE_SIZE/ITEMS_PER_THREAD
template<typename HASHTABLE_FIND>
__global__ void main_1(HASHTABLE_FIND HT_0, DBI32Type* KEY_0lineitem_u_1__l_orderkey, int* SLOT_COUNT_0, DBDecimalType* aggr0__tmp_attr0, size_t lineitem_size, DBI32Type* lineitem_u_1__l_orderkey, DBDecimalType* lineitem_u_1__l_quantity) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
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
}
template<typename HASHTABLE_INSERT_SJ>
__global__ void main_3(size_t COUNT0, HASHTABLE_INSERT_SJ HT_2, DBDecimalType* aggr0__tmp_attr0, DBI32Type* lineitem_u_1__l_orderkey) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
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
uint64_t KEY_2[ITEMS_PER_THREAD];
DBI32Type reg_lineitem_u_1__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_lineitem_u_1__l_orderkey[ITEM] = lineitem_u_1__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_2[ITEM] = 0;
KEY_2[ITEM] |= reg_lineitem_u_1__l_orderkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_2.insert(cuco::pair{KEY_2[ITEM], 1});
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_5(uint64_t* BUF_4, uint64_t* BUF_IDX_4, HASHTABLE_INSERT HT_4, DBI32Type* customer__c_custkey, size_t customer_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_customer__c_custkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_4.insert(cuco::pair{KEY_4[ITEM], ITEM*TB + tid});
BUF_4[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
}
template<typename HASHTABLE_PROBE_SJ, typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_7(uint64_t* BUF_4, uint64_t* BUF_6, uint64_t* BUF_IDX_6, HASHTABLE_PROBE_SJ HT_2, HASHTABLE_PROBE HT_4, HASHTABLE_INSERT HT_6, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_2[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_2[ITEM] = 0;
KEY_2[ITEM] |= reg_orders__o_orderkey[ITEM];
}
//Probe Hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_2 = HT_2.find(KEY_2[ITEM]);
if (SLOT_2 == HT_2.end()) {selection_flags[ITEM] = 0;}
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_custkey[ITEM] = orders__o_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_orders__o_custkey[ITEM];
}
//Probe Hash table
int64_t slot_second4[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_4 = HT_4.find(KEY_4[ITEM]);
if (SLOT_4 == HT_4.end()) {selection_flags[ITEM] = 0; continue;}
slot_second4[ITEM] = SLOT_4->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_6[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_orders__o_orderkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_6.insert(cuco::pair{KEY_6[ITEM], ITEM*TB + tid});
BUF_6[(ITEM*TB + tid) * 2 + 0] = BUF_4[slot_second4[ITEM] * 1 + 0];
BUF_6[(ITEM*TB + tid) * 2 + 1] = ITEM*TB + tid;
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_9(uint64_t* BUF_6, HASHTABLE_PROBE HT_6, HASHTABLE_FIND HT_8, DBI32Type* KEY_8orders__o_orderkey, int* SLOT_COUNT_8, DBDecimalType* aggr1__tmp_attr1, DBI32Type* aggr__c_custkey, DBDateType* aggr__o_orderdate, DBDecimalType* aggr__o_totalprice, DBI32Type* customer__c_custkey, DBI32Type* lineitem__l_orderkey, DBDecimalType* lineitem__l_quantity, size_t lineitem_size, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, DBDecimalType* orders__o_totalprice) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_lineitem__l_orderkey[ITEM];
}
//Probe Hash table
int64_t slot_second6[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_6 = HT_6.find(KEY_6[ITEM]);
if (SLOT_6 == HT_6.end()) {selection_flags[ITEM] = 0; continue;}
slot_second6[ITEM] = SLOT_6->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_8[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[BUF_6[slot_second6[ITEM] * 2 + 1]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_orders__o_orderkey[ITEM];
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
reg_customer__c_custkey[ITEM] = customer__c_custkey[BUF_6[slot_second6[ITEM] * 2 + 0]];
}
DBDecimalType reg_orders__o_totalprice[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_totalprice[ITEM] = orders__o_totalprice[BUF_6[slot_second6[ITEM] * 2 + 1]];
}
DBDateType reg_orders__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_orderdate[ITEM] = orders__o_orderdate[BUF_6[slot_second6[ITEM] * 2 + 1]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_8 = get_aggregation_slot(KEY_8[ITEM], HT_8, SLOT_COUNT_8);
aggregate_sum(&aggr1__tmp_attr1[buf_idx_8], reg_lineitem__l_quantity[ITEM]);
aggregate_any(&aggr__c_custkey[buf_idx_8], reg_customer__c_custkey[ITEM]);
aggregate_any(&aggr__o_totalprice[buf_idx_8], reg_orders__o_totalprice[ITEM]);
aggregate_any(&aggr__o_orderdate[buf_idx_8], reg_orders__o_orderdate[ITEM]);
KEY_8orders__o_orderkey[buf_idx_8] = reg_orders__o_orderkey[ITEM];
}
}
__global__ void main_11(size_t COUNT8, DBDecimalType* MAT10aggr1__tmp_attr1, DBI32Type* MAT10aggr__c_custkey, DBDateType* MAT10aggr__o_orderdate, DBDecimalType* MAT10aggr__o_totalprice, DBI32Type* MAT10orders__o_orderkey, uint64_t* MAT_IDX10, DBDecimalType* aggr1__tmp_attr1, DBI32Type* aggr__c_custkey, DBDateType* aggr__o_orderdate, DBDecimalType* aggr__o_totalprice, DBI32Type* orders__o_orderkey) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize buffers
DBI32Type reg_aggr__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT8); ++ITEM) {
reg_aggr__c_custkey[ITEM] = aggr__c_custkey[ITEM*TB + tid];
}
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT8); ++ITEM) {
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[ITEM*TB + tid];
}
DBDateType reg_aggr__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT8); ++ITEM) {
reg_aggr__o_orderdate[ITEM] = aggr__o_orderdate[ITEM*TB + tid];
}
DBDecimalType reg_aggr__o_totalprice[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT8); ++ITEM) {
reg_aggr__o_totalprice[ITEM] = aggr__o_totalprice[ITEM*TB + tid];
}
DBDecimalType reg_aggr1__tmp_attr1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT8); ++ITEM) {
reg_aggr1__tmp_attr1[ITEM] = aggr1__tmp_attr1[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT8); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx10 = atomicAdd((int*)MAT_IDX10, 1);
MAT10aggr__c_custkey[mat_idx10] = reg_aggr__c_custkey[ITEM];
MAT10orders__o_orderkey[mat_idx10] = reg_orders__o_orderkey[ITEM];
MAT10aggr__o_orderdate[mat_idx10] = reg_aggr__o_orderdate[ITEM];
MAT10aggr__o_totalprice[mat_idx10] = reg_aggr__o_totalprice[ITEM];
MAT10aggr1__tmp_attr1[mat_idx10] = reg_aggr1__tmp_attr1[ITEM];
}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
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
main_1<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_HT_0.ref(cuco::insert_and_find), d_KEY_0lineitem_u_1__l_orderkey, d_SLOT_COUNT_0, d_aggr0__tmp_attr0, lineitem_size, d_lineitem__l_orderkey, d_lineitem__l_quantity);
COUNT0 = d_HT_0.size();
size_t COUNT2 = COUNT0;
// Insert hash table control;
auto d_HT_2 = cuco::static_map{ (int)COUNT2*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)COUNT0/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT0, d_HT_2.ref(cuco::insert), d_aggr0__tmp_attr0, d_KEY_0lineitem_u_1__l_orderkey);
size_t COUNT4 = customer_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_4;
cudaMalloc(&d_BUF_IDX_4, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_4, 0, sizeof(uint64_t));
uint64_t* d_BUF_4;
cudaMalloc(&d_BUF_4, sizeof(uint64_t) * COUNT4 * 1);
auto d_HT_4 = cuco::static_map{ (int)COUNT4*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)customer_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_4, d_BUF_IDX_4, d_HT_4.ref(cuco::insert), d_customer__c_custkey, customer_size);
size_t COUNT6 = orders_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_6;
cudaMalloc(&d_BUF_IDX_6, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6, 0, sizeof(uint64_t));
uint64_t* d_BUF_6;
cudaMalloc(&d_BUF_6, sizeof(uint64_t) * COUNT6 * 2);
auto d_HT_6 = cuco::static_map{ (int)COUNT6*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_7<<<std::ceil((float)orders_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_4, d_BUF_6, d_BUF_IDX_6, d_HT_2.ref(cuco::find), d_HT_4.ref(cuco::find), d_HT_6.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderkey, orders_size);
size_t COUNT8 = 6001215;
auto d_HT_8 = cuco::static_map{ (int)6001215*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_8;
cudaMalloc(&d_SLOT_COUNT_8, sizeof(int));
cudaMemset(d_SLOT_COUNT_8, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr1__tmp_attr1;
cudaMalloc(&d_aggr1__tmp_attr1, sizeof(DBDecimalType) * COUNT8);
cudaMemset(d_aggr1__tmp_attr1, 0, sizeof(DBDecimalType) * COUNT8);
DBI32Type* d_aggr__c_custkey;
cudaMalloc(&d_aggr__c_custkey, sizeof(DBI32Type) * COUNT8);
cudaMemset(d_aggr__c_custkey, 0, sizeof(DBI32Type) * COUNT8);
DBDecimalType* d_aggr__o_totalprice;
cudaMalloc(&d_aggr__o_totalprice, sizeof(DBDecimalType) * COUNT8);
cudaMemset(d_aggr__o_totalprice, 0, sizeof(DBDecimalType) * COUNT8);
DBDateType* d_aggr__o_orderdate;
cudaMalloc(&d_aggr__o_orderdate, sizeof(DBDateType) * COUNT8);
cudaMemset(d_aggr__o_orderdate, 0, sizeof(DBDateType) * COUNT8);
DBI32Type* d_KEY_8orders__o_orderkey;
cudaMalloc(&d_KEY_8orders__o_orderkey, sizeof(DBI32Type) * COUNT8);
cudaMemset(d_KEY_8orders__o_orderkey, 0, sizeof(DBI32Type) * COUNT8);
main_9<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_BUF_6, d_HT_6.ref(cuco::find), d_HT_8.ref(cuco::insert_and_find), d_KEY_8orders__o_orderkey, d_SLOT_COUNT_8, d_aggr1__tmp_attr1, d_aggr__c_custkey, d_aggr__o_orderdate, d_aggr__o_totalprice, d_customer__c_custkey, d_lineitem__l_orderkey, d_lineitem__l_quantity, lineitem_size, d_orders__o_orderdate, d_orders__o_orderkey, d_orders__o_totalprice);
COUNT8 = d_HT_8.size();
size_t COUNT10 = COUNT8;
//Materialize buffers
uint64_t* d_MAT_IDX10;
cudaMalloc(&d_MAT_IDX10, sizeof(uint64_t));
cudaMemset(d_MAT_IDX10, 0, sizeof(uint64_t));
auto MAT10aggr__c_custkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT10);
DBI32Type* d_MAT10aggr__c_custkey;
cudaMalloc(&d_MAT10aggr__c_custkey, sizeof(DBI32Type) * COUNT10);
auto MAT10orders__o_orderkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT10);
DBI32Type* d_MAT10orders__o_orderkey;
cudaMalloc(&d_MAT10orders__o_orderkey, sizeof(DBI32Type) * COUNT10);
auto MAT10aggr__o_orderdate = (DBDateType*)malloc(sizeof(DBDateType) * COUNT10);
DBDateType* d_MAT10aggr__o_orderdate;
cudaMalloc(&d_MAT10aggr__o_orderdate, sizeof(DBDateType) * COUNT10);
auto MAT10aggr__o_totalprice = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT10);
DBDecimalType* d_MAT10aggr__o_totalprice;
cudaMalloc(&d_MAT10aggr__o_totalprice, sizeof(DBDecimalType) * COUNT10);
auto MAT10aggr1__tmp_attr1 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT10);
DBDecimalType* d_MAT10aggr1__tmp_attr1;
cudaMalloc(&d_MAT10aggr1__tmp_attr1, sizeof(DBDecimalType) * COUNT10);
main_11<<<std::ceil((float)COUNT8/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT8, d_MAT10aggr1__tmp_attr1, d_MAT10aggr__c_custkey, d_MAT10aggr__o_orderdate, d_MAT10aggr__o_totalprice, d_MAT10orders__o_orderkey, d_MAT_IDX10, d_aggr1__tmp_attr1, d_aggr__c_custkey, d_aggr__o_orderdate, d_aggr__o_totalprice, d_KEY_8orders__o_orderkey);
uint64_t MATCOUNT_10 = 0;
cudaMemcpy(&MATCOUNT_10, d_MAT_IDX10, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr__c_custkey, d_MAT10aggr__c_custkey, sizeof(DBI32Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10orders__o_orderkey, d_MAT10orders__o_orderkey, sizeof(DBI32Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr__o_orderdate, d_MAT10aggr__o_orderdate, sizeof(DBDateType) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr__o_totalprice, d_MAT10aggr__o_totalprice, sizeof(DBDecimalType) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr1__tmp_attr1, d_MAT10aggr1__tmp_attr1, sizeof(DBDecimalType) * COUNT10, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < MATCOUNT_10; i++) { std::cout << "" << MAT10aggr__c_custkey[i];
std::cout << "|" << MAT10orders__o_orderkey[i];
std::cout << "|" << MAT10aggr__o_orderdate[i];
std::cout << "|" << MAT10aggr__o_totalprice[i];
std::cout << "|" << MAT10aggr1__tmp_attr1[i];
std::cout << std::endl; }
cudaFree(d_KEY_0lineitem_u_1__l_orderkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_BUF_4);
cudaFree(d_BUF_IDX_4);
cudaFree(d_BUF_6);
cudaFree(d_BUF_IDX_6);
cudaFree(d_KEY_8orders__o_orderkey);
cudaFree(d_aggr1__tmp_attr1);
cudaFree(d_aggr__c_custkey);
cudaFree(d_aggr__o_orderdate);
cudaFree(d_aggr__o_totalprice);
cudaFree(d_MAT10aggr1__tmp_attr1);
cudaFree(d_MAT10aggr__c_custkey);
cudaFree(d_MAT10aggr__o_orderdate);
cudaFree(d_MAT10aggr__o_totalprice);
cudaFree(d_MAT10orders__o_orderkey);
cudaFree(d_MAT_IDX10);
free(MAT10aggr1__tmp_attr1);
free(MAT10aggr__c_custkey);
free(MAT10aggr__o_orderdate);
free(MAT10aggr__o_totalprice);
free(MAT10orders__o_orderkey);
}