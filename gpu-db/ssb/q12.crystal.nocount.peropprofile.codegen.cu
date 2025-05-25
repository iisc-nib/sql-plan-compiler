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
__global__ void main_10(uint64_t* BUF_15, uint64_t* BUF_IDX_15, HASHTABLE_INSERT HT_15, int64_t* cycles_per_warp_main_10_join_build_15, int64_t* cycles_per_warp_main_10_selection_11, int64_t* cycles_per_warp_main_10_selection_12, int64_t* cycles_per_warp_main_10_selection_13, int64_t* cycles_per_warp_main_10_selection_14, int64_t* cycles_per_warp_main_10_selection_9, DBI32Type* date__d_datekey, DBI32Type* date__d_yearmonthnum, size_t date_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBI32Type reg_date__d_yearmonthnum[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
reg_date__d_yearmonthnum[ITEM] = date__d_yearmonthnum[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_date__d_yearmonthnum[ITEM], 199401, Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_10_selection_9[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_10_selection_11[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_10_selection_12[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_10_selection_13[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_10_selection_14[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_15[ITEMS_PER_THREAD];
DBI32Type reg_date__d_datekey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
reg_date__d_datekey[ITEM] = date__d_datekey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_15[ITEM] = 0;
KEY_15[ITEM] |= reg_date__d_datekey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < date_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_15.insert(cuco::pair{KEY_15[ITEM], ITEM*TB + tid});
BUF_15[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_10_join_build_15[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_1(uint64_t* BUF_15, HASHTABLE_PROBE HT_15, HASHTABLE_FIND HT_17, int* SLOT_COUNT_17, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_1_aggregation_17, int64_t* cycles_per_warp_main_1_join_probe_15, int64_t* cycles_per_warp_main_1_map_16, int64_t* cycles_per_warp_main_1_selection_0, int64_t* cycles_per_warp_main_1_selection_2, int64_t* cycles_per_warp_main_1_selection_3, int64_t* cycles_per_warp_main_1_selection_4, int64_t* cycles_per_warp_main_1_selection_5, int64_t* cycles_per_warp_main_1_selection_6, int64_t* cycles_per_warp_main_1_selection_7, int64_t* cycles_per_warp_main_1_selection_8, DBI32Type* lineorder__lo_discount, DBDecimalType* lineorder__lo_extendedprice, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_quantity, size_t lineorder_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBI32Type reg_lineorder__lo_discount[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_discount[ITEM] = lineorder__lo_discount[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineorder__lo_discount[ITEM], 4, Predicate::gte) && evaluatePredicate(reg_lineorder__lo_discount[ITEM], 6, Predicate::lte);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_3[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_5[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_6[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_7[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(false);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_15[ITEMS_PER_THREAD];
DBI32Type reg_lineorder__lo_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
reg_lineorder__lo_orderdate[ITEM] = lineorder__lo_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_15[ITEM] = 0;
KEY_15[ITEM] |= reg_lineorder__lo_orderdate[ITEM];
}
//Probe Hash table
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
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_probe_15[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_map_16[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_17[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineorder_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_17[ITEM] = 0;
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
auto buf_idx_17 = get_aggregation_slot(KEY_17[ITEM], HT_17, SLOT_COUNT_17);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_17], reg_map0__tmp_attr1[ITEM]);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_aggregation_17[blockIdx.x] = cycles_per_warp;}
}
__global__ void main_19(size_t COUNT17, DBDecimalType* MAT18aggr0__tmp_attr0, uint64_t* MAT_IDX18, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_19_materialize_18) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT17); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT17); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx18 = atomicAdd((int*)MAT_IDX18, 1);
MAT18aggr0__tmp_attr0[mat_idx18] = reg_aggr0__tmp_attr0[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_19_materialize_18[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_10_selection_9;
auto main_10_selection_9_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_10_selection_9, sizeof(int64_t) * main_10_selection_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_10_selection_9, -1, sizeof(int64_t) * main_10_selection_9_cpw_size);
int64_t* d_cycles_per_warp_main_10_selection_11;
auto main_10_selection_11_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_10_selection_11, sizeof(int64_t) * main_10_selection_11_cpw_size);
cudaMemset(d_cycles_per_warp_main_10_selection_11, -1, sizeof(int64_t) * main_10_selection_11_cpw_size);
int64_t* d_cycles_per_warp_main_10_selection_12;
auto main_10_selection_12_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_10_selection_12, sizeof(int64_t) * main_10_selection_12_cpw_size);
cudaMemset(d_cycles_per_warp_main_10_selection_12, -1, sizeof(int64_t) * main_10_selection_12_cpw_size);
int64_t* d_cycles_per_warp_main_10_selection_13;
auto main_10_selection_13_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_10_selection_13, sizeof(int64_t) * main_10_selection_13_cpw_size);
cudaMemset(d_cycles_per_warp_main_10_selection_13, -1, sizeof(int64_t) * main_10_selection_13_cpw_size);
int64_t* d_cycles_per_warp_main_10_selection_14;
auto main_10_selection_14_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_10_selection_14, sizeof(int64_t) * main_10_selection_14_cpw_size);
cudaMemset(d_cycles_per_warp_main_10_selection_14, -1, sizeof(int64_t) * main_10_selection_14_cpw_size);
int64_t* d_cycles_per_warp_main_10_join_build_15;
auto main_10_join_build_15_cpw_size = std::ceil((float)date_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_10_join_build_15, sizeof(int64_t) * main_10_join_build_15_cpw_size);
cudaMemset(d_cycles_per_warp_main_10_join_build_15, -1, sizeof(int64_t) * main_10_join_build_15_cpw_size);
size_t COUNT15 = date_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_15;
cudaMalloc(&d_BUF_IDX_15, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_15, 0, sizeof(uint64_t));
uint64_t* d_BUF_15;
cudaMalloc(&d_BUF_15, sizeof(uint64_t) * COUNT15 * 1);
auto d_HT_15 = cuco::static_map{ (int)COUNT15*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_10<<<std::ceil((float)date_size/(float)TILE_SIZE), TB>>>(d_BUF_15, d_BUF_IDX_15, d_HT_15.ref(cuco::insert), d_cycles_per_warp_main_10_join_build_15, d_cycles_per_warp_main_10_selection_11, d_cycles_per_warp_main_10_selection_12, d_cycles_per_warp_main_10_selection_13, d_cycles_per_warp_main_10_selection_14, d_cycles_per_warp_main_10_selection_9, d_date__d_datekey, d_date__d_yearmonthnum, date_size);
int64_t* cycles_per_warp_main_10_selection_9 = (int64_t*)malloc(sizeof(int64_t) * main_10_selection_9_cpw_size);
cudaMemcpy(cycles_per_warp_main_10_selection_9, d_cycles_per_warp_main_10_selection_9, sizeof(int64_t) * main_10_selection_9_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_10_selection_9 ";
for (auto i=0ull; i < main_10_selection_9_cpw_size; i++) std::cout << cycles_per_warp_main_10_selection_9[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_10_selection_11 = (int64_t*)malloc(sizeof(int64_t) * main_10_selection_11_cpw_size);
cudaMemcpy(cycles_per_warp_main_10_selection_11, d_cycles_per_warp_main_10_selection_11, sizeof(int64_t) * main_10_selection_11_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_10_selection_11 ";
for (auto i=0ull; i < main_10_selection_11_cpw_size; i++) std::cout << cycles_per_warp_main_10_selection_11[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_10_selection_12 = (int64_t*)malloc(sizeof(int64_t) * main_10_selection_12_cpw_size);
cudaMemcpy(cycles_per_warp_main_10_selection_12, d_cycles_per_warp_main_10_selection_12, sizeof(int64_t) * main_10_selection_12_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_10_selection_12 ";
for (auto i=0ull; i < main_10_selection_12_cpw_size; i++) std::cout << cycles_per_warp_main_10_selection_12[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_10_selection_13 = (int64_t*)malloc(sizeof(int64_t) * main_10_selection_13_cpw_size);
cudaMemcpy(cycles_per_warp_main_10_selection_13, d_cycles_per_warp_main_10_selection_13, sizeof(int64_t) * main_10_selection_13_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_10_selection_13 ";
for (auto i=0ull; i < main_10_selection_13_cpw_size; i++) std::cout << cycles_per_warp_main_10_selection_13[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_10_selection_14 = (int64_t*)malloc(sizeof(int64_t) * main_10_selection_14_cpw_size);
cudaMemcpy(cycles_per_warp_main_10_selection_14, d_cycles_per_warp_main_10_selection_14, sizeof(int64_t) * main_10_selection_14_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_10_selection_14 ";
for (auto i=0ull; i < main_10_selection_14_cpw_size; i++) std::cout << cycles_per_warp_main_10_selection_14[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_10_join_build_15 = (int64_t*)malloc(sizeof(int64_t) * main_10_join_build_15_cpw_size);
cudaMemcpy(cycles_per_warp_main_10_join_build_15, d_cycles_per_warp_main_10_join_build_15, sizeof(int64_t) * main_10_join_build_15_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_10_join_build_15 ";
for (auto i=0ull; i < main_10_join_build_15_cpw_size; i++) std::cout << cycles_per_warp_main_10_join_build_15[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_2;
auto main_1_selection_2_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_2, sizeof(int64_t) * main_1_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_2, -1, sizeof(int64_t) * main_1_selection_2_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_3;
auto main_1_selection_3_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_3, sizeof(int64_t) * main_1_selection_3_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_3, -1, sizeof(int64_t) * main_1_selection_3_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_4;
auto main_1_selection_4_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_4, sizeof(int64_t) * main_1_selection_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_4, -1, sizeof(int64_t) * main_1_selection_4_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_5;
auto main_1_selection_5_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_5, sizeof(int64_t) * main_1_selection_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_5, -1, sizeof(int64_t) * main_1_selection_5_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_6;
auto main_1_selection_6_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_6, sizeof(int64_t) * main_1_selection_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_6, -1, sizeof(int64_t) * main_1_selection_6_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_7;
auto main_1_selection_7_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_7, sizeof(int64_t) * main_1_selection_7_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_7, -1, sizeof(int64_t) * main_1_selection_7_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_8;
auto main_1_selection_8_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_8, sizeof(int64_t) * main_1_selection_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_8, -1, sizeof(int64_t) * main_1_selection_8_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_probe_15;
auto main_1_join_probe_15_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_probe_15, sizeof(int64_t) * main_1_join_probe_15_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_probe_15, -1, sizeof(int64_t) * main_1_join_probe_15_cpw_size);
int64_t* d_cycles_per_warp_main_1_map_16;
auto main_1_map_16_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_map_16, sizeof(int64_t) * main_1_map_16_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_map_16, -1, sizeof(int64_t) * main_1_map_16_cpw_size);
int64_t* d_cycles_per_warp_main_1_aggregation_17;
auto main_1_aggregation_17_cpw_size = std::ceil((float)lineorder_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_aggregation_17, sizeof(int64_t) * main_1_aggregation_17_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_aggregation_17, -1, sizeof(int64_t) * main_1_aggregation_17_cpw_size);
size_t COUNT17 = 1;
auto d_HT_17 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_17;
cudaMalloc(&d_SLOT_COUNT_17, sizeof(int));
cudaMemset(d_SLOT_COUNT_17, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT17);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT17);
main_1<<<std::ceil((float)lineorder_size/(float)TILE_SIZE), TB>>>(d_BUF_15, d_HT_15.ref(cuco::find), d_HT_17.ref(cuco::insert_and_find), d_SLOT_COUNT_17, d_aggr0__tmp_attr0, d_cycles_per_warp_main_1_aggregation_17, d_cycles_per_warp_main_1_join_probe_15, d_cycles_per_warp_main_1_map_16, d_cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_2, d_cycles_per_warp_main_1_selection_3, d_cycles_per_warp_main_1_selection_4, d_cycles_per_warp_main_1_selection_5, d_cycles_per_warp_main_1_selection_6, d_cycles_per_warp_main_1_selection_7, d_cycles_per_warp_main_1_selection_8, d_lineorder__lo_discount, d_lineorder__lo_extendedprice, d_lineorder__lo_orderdate, d_lineorder__lo_quantity, lineorder_size);
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
int64_t* cycles_per_warp_main_1_selection_6 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_6, d_cycles_per_warp_main_1_selection_6, sizeof(int64_t) * main_1_selection_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_6 ";
for (auto i=0ull; i < main_1_selection_6_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_6[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_selection_7 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_7_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_7, d_cycles_per_warp_main_1_selection_7, sizeof(int64_t) * main_1_selection_7_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_7 ";
for (auto i=0ull; i < main_1_selection_7_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_7[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_selection_8 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_8, d_cycles_per_warp_main_1_selection_8, sizeof(int64_t) * main_1_selection_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_8 ";
for (auto i=0ull; i < main_1_selection_8_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_8[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_probe_15 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_probe_15_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_probe_15, d_cycles_per_warp_main_1_join_probe_15, sizeof(int64_t) * main_1_join_probe_15_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_probe_15 ";
for (auto i=0ull; i < main_1_join_probe_15_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_probe_15[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_map_16 = (int64_t*)malloc(sizeof(int64_t) * main_1_map_16_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_map_16, d_cycles_per_warp_main_1_map_16, sizeof(int64_t) * main_1_map_16_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_map_16 ";
for (auto i=0ull; i < main_1_map_16_cpw_size; i++) std::cout << cycles_per_warp_main_1_map_16[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_aggregation_17 = (int64_t*)malloc(sizeof(int64_t) * main_1_aggregation_17_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_aggregation_17, d_cycles_per_warp_main_1_aggregation_17, sizeof(int64_t) * main_1_aggregation_17_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_aggregation_17 ";
for (auto i=0ull; i < main_1_aggregation_17_cpw_size; i++) std::cout << cycles_per_warp_main_1_aggregation_17[i] << " ";
std::cout << std::endl;
COUNT17 = d_HT_17.size();
int64_t* d_cycles_per_warp_main_19_materialize_18;
auto main_19_materialize_18_cpw_size = std::ceil((float)COUNT17/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_19_materialize_18, sizeof(int64_t) * main_19_materialize_18_cpw_size);
cudaMemset(d_cycles_per_warp_main_19_materialize_18, -1, sizeof(int64_t) * main_19_materialize_18_cpw_size);
size_t COUNT18 = COUNT17;
//Materialize buffers
uint64_t* d_MAT_IDX18;
cudaMalloc(&d_MAT_IDX18, sizeof(uint64_t));
cudaMemset(d_MAT_IDX18, 0, sizeof(uint64_t));
auto MAT18aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT18);
DBDecimalType* d_MAT18aggr0__tmp_attr0;
cudaMalloc(&d_MAT18aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT18);
main_19<<<std::ceil((float)COUNT17/(float)TILE_SIZE), TB>>>(COUNT17, d_MAT18aggr0__tmp_attr0, d_MAT_IDX18, d_aggr0__tmp_attr0, d_cycles_per_warp_main_19_materialize_18);
uint64_t MATCOUNT_18 = 0;
cudaMemcpy(&MATCOUNT_18, d_MAT_IDX18, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT18aggr0__tmp_attr0, d_MAT18aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT18, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_19_materialize_18 = (int64_t*)malloc(sizeof(int64_t) * main_19_materialize_18_cpw_size);
cudaMemcpy(cycles_per_warp_main_19_materialize_18, d_cycles_per_warp_main_19_materialize_18, sizeof(int64_t) * main_19_materialize_18_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_19_materialize_18 ";
for (auto i=0ull; i < main_19_materialize_18_cpw_size; i++) std::cout << cycles_per_warp_main_19_materialize_18[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_15);
cudaFree(d_BUF_IDX_15);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_MAT18aggr0__tmp_attr0);
cudaFree(d_MAT_IDX18);
free(MAT18aggr0__tmp_attr0);
}