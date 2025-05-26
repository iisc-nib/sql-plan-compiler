#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
#include <chrono>
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT HT_0, DBI32Type* customer__c_custkey, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_0 = atomicAdd((int*)BUF_IDX_0, 1);
HT_0.insert(cuco::pair{KEY_0, buf_idx_0});
BUF_0[buf_idx_0 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT>
__global__ void main_3(uint64_t* BUF_2, uint64_t* BUF_IDX_2, HASHTABLE_INSERT HT_2, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_2 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_2 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_2 = atomicAdd((int*)BUF_IDX_2, 1);
HT_2.insert(cuco::pair{KEY_2, buf_idx_2});
BUF_2[buf_idx_2 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT>
__global__ void main_5(uint64_t* BUF_4, uint64_t* BUF_IDX_4, HASHTABLE_INSERT HT_4, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_4 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_4 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_4 = atomicAdd((int*)BUF_IDX_4, 1);
HT_4.insert(cuco::pair{KEY_4, buf_idx_4});
BUF_4[buf_idx_4 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT>
__global__ void main_7(uint64_t* BUF_6, uint64_t* BUF_IDX_6, HASHTABLE_INSERT HT_6, DBStringType* part__p_mfgr, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_6 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_6 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_6 = atomicAdd((int*)BUF_IDX_6, 1);
HT_6.insert(cuco::pair{KEY_6, buf_idx_6});
BUF_6[buf_idx_6 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE_PK, typename HASHTABLE_FIND>
__global__ void main_9(uint64_t* BUF_0, uint64_t* BUF_2, uint64_t* BUF_4, uint64_t* BUF_6, HASHTABLE_PROBE_PK HT_0, HASHTABLE_PROBE_PK HT_2, HASHTABLE_PROBE_PK HT_4, HASHTABLE_PROBE_PK HT_6, HASHTABLE_FIND HT_8, DBI32Type* KEY_8date__d_year, DBI16Type* KEY_8part__p_category_encoded, DBI16Type* KEY_8supplier__s_nation_encoded, int* SLOT_COUNT_8, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, DBDecimalType* lineorder__lo_supplycost, size_t lineorder_size, DBI16Type* part__p_category_encoded, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_0 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_0 |= reg_lineorder__lo_custkey;
//Probe Hash table
auto SLOT_0 = HT_0.find(KEY_0);
if (SLOT_0 == HT_0.end()) return;
if (!(true)) return;
uint64_t KEY_2 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_2 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_2 = HT_2.find(KEY_2);
if (SLOT_2 == HT_2.end()) return;
if (!(true)) return;
uint64_t KEY_4 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_4 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_4 = HT_4.find(KEY_4);
if (SLOT_4 == HT_4.end()) return;
if (!(true)) return;
uint64_t KEY_6 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_6 |= reg_lineorder__lo_partkey;
//Probe Hash table
auto SLOT_6 = HT_6.find(KEY_6);
if (SLOT_6 == HT_6.end()) return;
if (!(true)) return;
uint64_t KEY_8 = 0;
auto reg_date__d_year = date__d_year[BUF_4[SLOT_4->second * 1 + 0]];

KEY_8 |= reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_2[SLOT_2->second * 1 + 0]];
KEY_8 <<= 16;
KEY_8 |= reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[BUF_6[SLOT_6->second * 1 + 0]];
KEY_8 <<= 16;
KEY_8 |= reg_part__p_category_encoded;
//Aggregate in hashtable
auto buf_idx_8 = get_aggregation_slot(KEY_8, HT_8, SLOT_COUNT_8);
auto reg_lineorder__lo_supplycost = lineorder__lo_supplycost[tid];
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_revenue) - (reg_lineorder__lo_supplycost);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_8], reg_map0__tmp_attr1);
KEY_8date__d_year[buf_idx_8] = reg_date__d_year;
KEY_8supplier__s_nation_encoded[buf_idx_8] = reg_supplier__s_nation_encoded;
KEY_8part__p_category_encoded[buf_idx_8] = reg_part__p_category_encoded;
}
__global__ void main_11(size_t COUNT8, DBDecimalType* MAT10aggr0__tmp_attr0, DBI32Type* MAT10date__d_year, DBI16Type* MAT10part__p_category_encoded, DBI16Type* MAT10supplier__s_nation_encoded, uint64_t* MAT_IDX10, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_category_encoded, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT8) return;
//Materialize buffers
auto mat_idx10 = atomicAdd((int*)MAT_IDX10, 1);
auto reg_date__d_year = date__d_year[tid];
MAT10date__d_year[mat_idx10] = reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[tid];
MAT10supplier__s_nation_encoded[mat_idx10] = reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[tid];
MAT10part__p_category_encoded[mat_idx10] = reg_part__p_category_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT10aggr0__tmp_attr0[mat_idx10] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
size_t COUNT0 = customer_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_0;
cudaMalloc(&d_BUF_IDX_0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_0, 0, sizeof(uint64_t));
uint64_t* d_BUF_0;
cudaMalloc(&d_BUF_0, sizeof(uint64_t) * COUNT0 * 1);
auto d_HT_0 = cuco::static_map{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_customer__c_custkey, d_customer__c_region, customer_size);
cudaFree(d_BUF_IDX_0);
size_t COUNT2 = supplier_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_2;
cudaMalloc(&d_BUF_IDX_2, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_2, 0, sizeof(uint64_t));
uint64_t* d_BUF_2;
cudaMalloc(&d_BUF_2, sizeof(uint64_t) * COUNT2 * 1);
auto d_HT_2 = cuco::static_map{ (int)COUNT2*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_2, d_BUF_IDX_2, d_HT_2.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
cudaFree(d_BUF_IDX_2);
size_t COUNT4 = date_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_4;
cudaMalloc(&d_BUF_IDX_4, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_4, 0, sizeof(uint64_t));
uint64_t* d_BUF_4;
cudaMalloc(&d_BUF_4, sizeof(uint64_t) * COUNT4 * 1);
auto d_HT_4 = cuco::static_map{ (int)COUNT4*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_4, d_BUF_IDX_4, d_HT_4.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
cudaFree(d_BUF_IDX_4);
size_t COUNT6 = part_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_6;
cudaMalloc(&d_BUF_IDX_6, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6, 0, sizeof(uint64_t));
uint64_t* d_BUF_6;
cudaMalloc(&d_BUF_6, sizeof(uint64_t) * COUNT6 * 1);
auto d_HT_6 = cuco::static_map{ (int)COUNT6*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_7<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_6, d_BUF_IDX_6, d_HT_6.ref(cuco::insert), d_part__p_mfgr, d_part__p_partkey, part_size);
cudaFree(d_BUF_IDX_6);
size_t COUNT8 = 257987;
auto d_HT_8 = cuco::static_map{ (int)257987*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_8;
cudaMalloc(&d_SLOT_COUNT_8, sizeof(int));
cudaMemset(d_SLOT_COUNT_8, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT8);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT8);
DBI32Type* d_KEY_8date__d_year;
cudaMalloc(&d_KEY_8date__d_year, sizeof(DBI32Type) * COUNT8);
cudaMemset(d_KEY_8date__d_year, 0, sizeof(DBI32Type) * COUNT8);
DBI16Type* d_KEY_8supplier__s_nation_encoded;
cudaMalloc(&d_KEY_8supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT8);
cudaMemset(d_KEY_8supplier__s_nation_encoded, 0, sizeof(DBI16Type) * COUNT8);
DBI16Type* d_KEY_8part__p_category_encoded;
cudaMalloc(&d_KEY_8part__p_category_encoded, sizeof(DBI16Type) * COUNT8);
cudaMemset(d_KEY_8part__p_category_encoded, 0, sizeof(DBI16Type) * COUNT8);
main_9<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_0, d_BUF_2, d_BUF_4, d_BUF_6, d_HT_0.ref(cuco::find), d_HT_2.ref(cuco::find), d_HT_4.ref(cuco::find), d_HT_6.ref(cuco::find), d_HT_8.ref(cuco::insert_and_find), d_KEY_8date__d_year, d_KEY_8part__p_category_encoded, d_KEY_8supplier__s_nation_encoded, d_SLOT_COUNT_8, d_aggr0__tmp_attr0, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, d_lineorder__lo_supplycost, lineorder_size, d_part__p_category_encoded, d_supplier__s_nation_encoded);
COUNT8 = d_HT_8.size();
size_t COUNT10 = COUNT8;
//Materialize buffers
uint64_t* d_MAT_IDX10;
cudaMalloc(&d_MAT_IDX10, sizeof(uint64_t));
cudaMemset(d_MAT_IDX10, 0, sizeof(uint64_t));
auto MAT10date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT10);
DBI32Type* d_MAT10date__d_year;
cudaMalloc(&d_MAT10date__d_year, sizeof(DBI32Type) * COUNT10);
auto MAT10supplier__s_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT10);
DBI16Type* d_MAT10supplier__s_nation_encoded;
cudaMalloc(&d_MAT10supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT10);
auto MAT10part__p_category_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT10);
DBI16Type* d_MAT10part__p_category_encoded;
cudaMalloc(&d_MAT10part__p_category_encoded, sizeof(DBI16Type) * COUNT10);
auto MAT10aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT10);
DBDecimalType* d_MAT10aggr0__tmp_attr0;
cudaMalloc(&d_MAT10aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT10);
main_11<<<std::ceil((float)COUNT8/128.), 128>>>(COUNT8, d_MAT10aggr0__tmp_attr0, d_MAT10date__d_year, d_MAT10part__p_category_encoded, d_MAT10supplier__s_nation_encoded, d_MAT_IDX10, d_aggr0__tmp_attr0, d_KEY_8date__d_year, d_KEY_8part__p_category_encoded, d_KEY_8supplier__s_nation_encoded);
uint64_t MATCOUNT_10 = 0;
cudaMemcpy(&MATCOUNT_10, d_MAT_IDX10, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10date__d_year, d_MAT10date__d_year, sizeof(DBI32Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10supplier__s_nation_encoded, d_MAT10supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10part__p_category_encoded, d_MAT10part__p_category_encoded, sizeof(DBI16Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr0__tmp_attr0, d_MAT10aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT10, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
std::clog << "Query execution time: " << duration.count() / 1000. << " milliseconds." << std::endl;

for (auto i=0ull; i < MATCOUNT_10; i++) { std::cout << "" << MAT10date__d_year[i];
std::cout << "|" << supplier__s_nation_map[MAT10supplier__s_nation_encoded[i]];
std::cout << "|" << part__p_category_map[MAT10part__p_category_encoded[i]];
std::cout << "|" << MAT10aggr0__tmp_attr0[i];
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
cudaFree(d_BUF_6);
cudaFree(d_BUF_IDX_6);
cudaFree(d_KEY_8date__d_year);
cudaFree(d_KEY_8part__p_category_encoded);
cudaFree(d_KEY_8supplier__s_nation_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_MAT10aggr0__tmp_attr0);
cudaFree(d_MAT10date__d_year);
cudaFree(d_MAT10part__p_category_encoded);
cudaFree(d_MAT10supplier__s_nation_encoded);
cudaFree(d_MAT_IDX10);
free(MAT10aggr0__tmp_attr0);
free(MAT10date__d_year);
free(MAT10part__p_category_encoded);
free(MAT10supplier__s_nation_encoded);
}