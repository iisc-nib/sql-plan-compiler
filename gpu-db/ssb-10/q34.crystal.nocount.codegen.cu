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
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT HT_0, DBI32Type* date__d_datekey, DBStringType* date__d_yearmonth, size_t date_size) {
int64_t start, stop, cycles_per_warp;
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
uint64_t KEY_0[ITEMS_PER_THREAD];
DBI32Type reg_date__d_datekey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
reg_date__d_datekey[ITEM] = date__d_datekey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_0[ITEM] = 0;
KEY_0[ITEM] |= reg_date__d_datekey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_0.insert(cuco::pair{KEY_0[ITEM], ITEM*TB + tid});
BUF_0[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_3(uint64_t* BUF_2, uint64_t* BUF_IDX_2, HASHTABLE_INSERT HT_2, DBStringType* customer__c_city, DBI32Type* customer__c_custkey, size_t customer_size) {
int64_t start, stop, cycles_per_warp;
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
uint64_t KEY_2[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_2[ITEM] = 0;
KEY_2[ITEM] |= reg_customer__c_custkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_2.insert(cuco::pair{KEY_2[ITEM], ITEM*TB + tid});
BUF_2[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
}
template<typename HASHTABLE_INSERT>
__global__ void main_5(uint64_t* BUF_4, uint64_t* BUF_IDX_4, HASHTABLE_INSERT HT_4, DBStringType* supplier__s_city, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
int64_t start, stop, cycles_per_warp;
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
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_supplier__s_suppkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_4.insert(cuco::pair{KEY_4[ITEM], ITEM*TB + tid});
BUF_4[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_7(uint64_t* BUF_0, uint64_t* BUF_2, uint64_t* BUF_4, HASHTABLE_PROBE HT_0, HASHTABLE_PROBE HT_2, HASHTABLE_PROBE HT_4, HASHTABLE_FIND HT_6, DBI16Type* KEY_6customer__c_city_encoded, DBI32Type* KEY_6date__d_year, DBI16Type* KEY_6supplier__s_city_encoded, int* SLOT_COUNT_6, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_city_encoded) {
int64_t start, stop, cycles_per_warp;
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
uint64_t KEY_0[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_orderdate[ITEM] = lineorder__lo_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_0[ITEM] = 0;
KEY_0[ITEM] |= reg_lineorder__lo_orderdate[ITEM];
}
//Probe Hash table
int64_t slot_second0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_0 = HT_0.find(KEY_0[ITEM]);
if (SLOT_0 == HT_0.end()) {selection_flags[ITEM] = 0; continue;}
slot_second0[ITEM] = SLOT_0->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_2[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_custkey[ITEM] = lineorder__lo_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_2[ITEM] = 0;
KEY_2[ITEM] |= reg_lineorder__lo_custkey[ITEM];
}
//Probe Hash table
int64_t slot_second2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_2 = HT_2.find(KEY_2[ITEM]);
if (SLOT_2 == HT_2.end()) {selection_flags[ITEM] = 0; continue;}
slot_second2[ITEM] = SLOT_2->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_suppkey[ITEM] = lineorder__lo_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_lineorder__lo_suppkey[ITEM];
}
//Probe Hash table
int64_t slot_second4[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_4 = HT_4.find(KEY_4[ITEM]);
if (SLOT_4 == HT_4.end()) {selection_flags[ITEM] = 0; continue;}
slot_second4[ITEM] = SLOT_4->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI16Type reg_customer__c_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_customer__c_city_encoded[ITEM] = customer__c_city_encoded[BUF_2[slot_second2[ITEM] * 1 + 0]];
}
DBI16Type reg_supplier__s_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_supplier__s_city_encoded[ITEM] = supplier__s_city_encoded[BUF_4[slot_second4[ITEM] * 1 + 0]];
}
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_date__d_year[ITEM] = date__d_year[BUF_0[slot_second0[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_customer__c_city_encoded[ITEM];
KEY_6[ITEM] <<= 16;
KEY_6[ITEM] |= reg_supplier__s_city_encoded[ITEM];
KEY_6[ITEM] <<= 32;
KEY_6[ITEM] |= reg_date__d_year[ITEM];
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
auto buf_idx_6 = get_aggregation_slot(KEY_6[ITEM], HT_6, SLOT_COUNT_6);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_6], reg_lineorder__lo_revenue[ITEM]);
KEY_6customer__c_city_encoded[buf_idx_6] = reg_customer__c_city_encoded[ITEM];
KEY_6supplier__s_city_encoded[buf_idx_6] = reg_supplier__s_city_encoded[ITEM];
KEY_6date__d_year[buf_idx_6] = reg_date__d_year[ITEM];
}
}
__global__ void main_9(size_t COUNT6, DBDecimalType* MAT8aggr0__tmp_attr0, DBI16Type* MAT8customer__c_city_encoded, DBI32Type* MAT8date__d_year, DBI16Type* MAT8supplier__s_city_encoded, uint64_t* MAT_IDX8, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI16Type* supplier__s_city_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize buffers
DBI16Type reg_customer__c_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT6); ++ITEM) {
reg_customer__c_city_encoded[ITEM] = customer__c_city_encoded[ITEM*TB + tid];
}
DBI16Type reg_supplier__s_city_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT6); ++ITEM) {
reg_supplier__s_city_encoded[ITEM] = supplier__s_city_encoded[ITEM*TB + tid];
}
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT6); ++ITEM) {
reg_date__d_year[ITEM] = date__d_year[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT6); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT6); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx8 = atomicAdd((int*)MAT_IDX8, 1);
MAT8customer__c_city_encoded[mat_idx8] = reg_customer__c_city_encoded[ITEM];
MAT8supplier__s_city_encoded[mat_idx8] = reg_supplier__s_city_encoded[ITEM];
MAT8date__d_year[mat_idx8] = reg_date__d_year[ITEM];
MAT8aggr0__tmp_attr0[mat_idx8] = reg_aggr0__tmp_attr0[ITEM];
}
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
size_t COUNT0 = date_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_0;
cudaMalloc(&d_BUF_IDX_0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_0, 0, sizeof(uint64_t));
uint64_t* d_BUF_0;
cudaMalloc(&d_BUF_0, sizeof(uint64_t) * COUNT0 * 1);
auto d_HT_0 = cuco::static_map{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)date_size/(float)TILE_SIZE), TB>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_date__d_datekey, d_date__d_yearmonth, date_size);
size_t COUNT2 = customer_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_2;
cudaMalloc(&d_BUF_IDX_2, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_2, 0, sizeof(uint64_t));
uint64_t* d_BUF_2;
cudaMalloc(&d_BUF_2, sizeof(uint64_t) * COUNT2 * 1);
auto d_HT_2 = cuco::static_map{ (int)COUNT2*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)customer_size/(float)TILE_SIZE), TB>>>(d_BUF_2, d_BUF_IDX_2, d_HT_2.ref(cuco::insert), d_customer__c_city, d_customer__c_custkey, customer_size);
size_t COUNT4 = supplier_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_4;
cudaMalloc(&d_BUF_IDX_4, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_4, 0, sizeof(uint64_t));
uint64_t* d_BUF_4;
cudaMalloc(&d_BUF_4, sizeof(uint64_t) * COUNT4 * 1);
auto d_HT_4 = cuco::static_map{ (int)COUNT4*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TB>>>(d_BUF_4, d_BUF_IDX_4, d_HT_4.ref(cuco::insert), d_supplier__s_city, d_supplier__s_suppkey, supplier_size);
size_t COUNT6 = 41;
auto d_HT_6 = cuco::static_map{ (int)41*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_6;
cudaMalloc(&d_SLOT_COUNT_6, sizeof(int));
cudaMemset(d_SLOT_COUNT_6, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT6);
DBI16Type* d_KEY_6customer__c_city_encoded;
cudaMalloc(&d_KEY_6customer__c_city_encoded, sizeof(DBI16Type) * COUNT6);
cudaMemset(d_KEY_6customer__c_city_encoded, 0, sizeof(DBI16Type) * COUNT6);
DBI16Type* d_KEY_6supplier__s_city_encoded;
cudaMalloc(&d_KEY_6supplier__s_city_encoded, sizeof(DBI16Type) * COUNT6);
cudaMemset(d_KEY_6supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT6);
DBI32Type* d_KEY_6date__d_year;
cudaMalloc(&d_KEY_6date__d_year, sizeof(DBI32Type) * COUNT6);
cudaMemset(d_KEY_6date__d_year, 0, sizeof(DBI32Type) * COUNT6);
main_7<<<std::ceil((float)lineorder_size/(float)TILE_SIZE), TB>>>(d_BUF_0, d_BUF_2, d_BUF_4, d_HT_0.ref(cuco::find), d_HT_2.ref(cuco::find), d_HT_4.ref(cuco::find), d_HT_6.ref(cuco::insert_and_find), d_KEY_6customer__c_city_encoded, d_KEY_6date__d_year, d_KEY_6supplier__s_city_encoded, d_SLOT_COUNT_6, d_aggr0__tmp_attr0, d_customer__c_city_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_city_encoded);
COUNT6 = d_HT_6.size();
size_t COUNT8 = COUNT6;
//Materialize buffers
uint64_t* d_MAT_IDX8;
cudaMalloc(&d_MAT_IDX8, sizeof(uint64_t));
cudaMemset(d_MAT_IDX8, 0, sizeof(uint64_t));
auto MAT8customer__c_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT8);
DBI16Type* d_MAT8customer__c_city_encoded;
cudaMalloc(&d_MAT8customer__c_city_encoded, sizeof(DBI16Type) * COUNT8);
auto MAT8supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT8);
DBI16Type* d_MAT8supplier__s_city_encoded;
cudaMalloc(&d_MAT8supplier__s_city_encoded, sizeof(DBI16Type) * COUNT8);
auto MAT8date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT8);
DBI32Type* d_MAT8date__d_year;
cudaMalloc(&d_MAT8date__d_year, sizeof(DBI32Type) * COUNT8);
auto MAT8aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT8);
DBDecimalType* d_MAT8aggr0__tmp_attr0;
cudaMalloc(&d_MAT8aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT8);
main_9<<<std::ceil((float)COUNT6/(float)TILE_SIZE), TB>>>(COUNT6, d_MAT8aggr0__tmp_attr0, d_MAT8customer__c_city_encoded, d_MAT8date__d_year, d_MAT8supplier__s_city_encoded, d_MAT_IDX8, d_aggr0__tmp_attr0, d_KEY_6customer__c_city_encoded, d_KEY_6date__d_year, d_KEY_6supplier__s_city_encoded);
uint64_t MATCOUNT_8 = 0;
cudaMemcpy(&MATCOUNT_8, d_MAT_IDX8, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT8customer__c_city_encoded, d_MAT8customer__c_city_encoded, sizeof(DBI16Type) * COUNT8, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT8supplier__s_city_encoded, d_MAT8supplier__s_city_encoded, sizeof(DBI16Type) * COUNT8, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT8date__d_year, d_MAT8date__d_year, sizeof(DBI32Type) * COUNT8, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT8aggr0__tmp_attr0, d_MAT8aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT8, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
std::clog << "Query execution time: " << duration.count() / 1000. << " milliseconds." << std::endl;

for (auto i=0ull; i < MATCOUNT_8; i++) { std::cout << "" << customer__c_city_map[MAT8customer__c_city_encoded[i]];
std::cout << "|" << supplier__s_city_map[MAT8supplier__s_city_encoded[i]];
std::cout << "|" << MAT8date__d_year[i];
std::cout << "|" << MAT8aggr0__tmp_attr0[i];
std::cout << std::endl; }
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_0);
cudaFree(d_BUF_IDX_0);
cudaFree(d_BUF_2);
cudaFree(d_BUF_IDX_2);
cudaFree(d_BUF_4);
cudaFree(d_BUF_IDX_4);
cudaFree(d_KEY_6customer__c_city_encoded);
cudaFree(d_KEY_6date__d_year);
cudaFree(d_KEY_6supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_MAT8aggr0__tmp_attr0);
cudaFree(d_MAT8customer__c_city_encoded);
cudaFree(d_MAT8date__d_year);
cudaFree(d_MAT8supplier__s_city_encoded);
cudaFree(d_MAT_IDX8);
free(MAT8aggr0__tmp_attr0);
free(MAT8customer__c_city_encoded);
free(MAT8date__d_year);
free(MAT8supplier__s_city_encoded);
}