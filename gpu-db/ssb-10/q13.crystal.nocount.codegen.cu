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
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT HT_0, DBI32Type* date__d_datekey, DBI32Type* date__d_weeknuminyear, DBI32Type* date__d_year, size_t date_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBI32Type reg_date__d_weeknuminyear[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
reg_date__d_weeknuminyear[ITEM] = date__d_weeknuminyear[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_date__d_weeknuminyear[ITEM], 6, Predicate::eq);
}
DBI32Type reg_date__d_year[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
reg_date__d_year[ITEM] = date__d_year[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_date__d_year[ITEM], 1994, Predicate::eq);
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
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_3(uint64_t* BUF_0, HASHTABLE_PROBE HT_0, HASHTABLE_FIND HT_2, int* SLOT_COUNT_2, DBDecimalType* aggr0__tmp_attr0, DBI32Type* lineorder__lo_discount, DBDecimalType* lineorder__lo_extendedprice, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_quantity, size_t lineorder_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBI32Type reg_lineorder__lo_discount[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_discount[ITEM] = lineorder__lo_discount[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineorder__lo_discount[ITEM], 5, Predicate::gte) && evaluatePredicate(reg_lineorder__lo_discount[ITEM], 7, Predicate::lte);
}
DBI32Type reg_lineorder__lo_quantity[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_quantity[ITEM] = lineorder__lo_quantity[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineorder__lo_quantity[ITEM], 26, Predicate::gte) && evaluatePredicate(reg_lineorder__lo_quantity[ITEM], 35, Predicate::lte);
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
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_2[ITEM] = 0;
}
//Aggregate in hashtable
DBDecimalType reg_lineorder__lo_extendedprice[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_extendedprice[ITEM] = lineorder__lo_extendedprice[ITEM*TB + tid];
}
DBDecimalType reg_map0__tmp_attr1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr1[ITEM] = (reg_lineorder__lo_extendedprice[ITEM]) * ((DBDecimalType)(reg_lineorder__lo_discount[ITEM]));
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_2 = get_aggregation_slot(KEY_2[ITEM], HT_2, SLOT_COUNT_2);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_2], reg_map0__tmp_attr1[ITEM]);
}
}
__global__ void main_5(size_t COUNT2, DBDecimalType* MAT4aggr0__tmp_attr0, uint64_t* MAT_IDX4, DBDecimalType* aggr0__tmp_attr0) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize buffers
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT2); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT2); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx4 = atomicAdd((int*)MAT_IDX4, 1);
MAT4aggr0__tmp_attr0[mat_idx4] = reg_aggr0__tmp_attr0[ITEM];
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
main_1<<<std::ceil((float)date_size/(float)TILE_SIZE), TB>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_date__d_datekey, d_date__d_weeknuminyear, d_date__d_year, date_size);
size_t COUNT2 = 1;
auto d_HT_2 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_2;
cudaMalloc(&d_SLOT_COUNT_2, sizeof(int));
cudaMemset(d_SLOT_COUNT_2, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT2);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT2);
main_3<<<std::ceil((float)lineorder_size/(float)TILE_SIZE), TB>>>(d_BUF_0, d_HT_0.ref(cuco::find), d_HT_2.ref(cuco::insert_and_find), d_SLOT_COUNT_2, d_aggr0__tmp_attr0, d_lineorder__lo_discount, d_lineorder__lo_extendedprice, d_lineorder__lo_orderdate, d_lineorder__lo_quantity, lineorder_size);
COUNT2 = d_HT_2.size();
size_t COUNT4 = COUNT2;
//Materialize buffers
uint64_t* d_MAT_IDX4;
cudaMalloc(&d_MAT_IDX4, sizeof(uint64_t));
cudaMemset(d_MAT_IDX4, 0, sizeof(uint64_t));
auto MAT4aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT4);
DBDecimalType* d_MAT4aggr0__tmp_attr0;
cudaMalloc(&d_MAT4aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT4);
main_5<<<std::ceil((float)COUNT2/(float)TILE_SIZE), TB>>>(COUNT2, d_MAT4aggr0__tmp_attr0, d_MAT_IDX4, d_aggr0__tmp_attr0);
uint64_t MATCOUNT_4 = 0;
cudaMemcpy(&MATCOUNT_4, d_MAT_IDX4, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT4aggr0__tmp_attr0, d_MAT4aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT4, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
std::clog << "Query execution time: " << duration.count() / 1000. << " milliseconds." << std::endl;

for (auto i=0ull; i < MATCOUNT_4; i++) { std::cout << "" << MAT4aggr0__tmp_attr0[i];
std::cout << std::endl; }
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_0);
cudaFree(d_BUF_IDX_0);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_MAT4aggr0__tmp_attr0);
cudaFree(d_MAT_IDX4);
free(MAT4aggr0__tmp_attr0);
}