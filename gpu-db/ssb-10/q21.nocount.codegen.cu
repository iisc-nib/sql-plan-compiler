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
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT HT_0, DBStringType* part__p_category, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_category = part__p_category[tid];
if (!(evaluatePredicate(reg_part__p_category, "MFGR#12", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_0 |= reg_part__p_partkey;
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
__global__ void main_5(uint64_t* BUF_4, uint64_t* BUF_IDX_4, HASHTABLE_INSERT HT_4, DBI32Type* date__d_datekey, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
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
template<typename HASHTABLE_PROBE_PK, typename HASHTABLE_FIND>
__global__ void main_7(uint64_t* BUF_0, uint64_t* BUF_2, uint64_t* BUF_4, HASHTABLE_PROBE_PK HT_0, HASHTABLE_PROBE_PK HT_2, HASHTABLE_PROBE_PK HT_4, HASHTABLE_FIND HT_6, DBI32Type* KEY_6date__d_year, DBI16Type* KEY_6part__p_brand1_encoded, int* SLOT_COUNT_6, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_0 |= reg_lineorder__lo_partkey;
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
auto reg_date__d_year = date__d_year[BUF_4[SLOT_4->second * 1 + 0]];

KEY_6 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_0[SLOT_0->second * 1 + 0]];
KEY_6 <<= 16;
KEY_6 |= reg_part__p_brand1_encoded;
//Aggregate in hashtable
auto buf_idx_6 = get_aggregation_slot(KEY_6, HT_6, SLOT_COUNT_6);
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_6], reg_lineorder__lo_revenue);
KEY_6date__d_year[buf_idx_6] = reg_date__d_year;
KEY_6part__p_brand1_encoded[buf_idx_6] = reg_part__p_brand1_encoded;
}
__global__ void main_9(size_t COUNT6, DBDecimalType* MAT8aggr0__tmp_attr0, DBI32Type* MAT8date__d_year, DBI16Type* MAT8part__p_brand1_encoded, uint64_t* MAT_IDX8, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT6) return;
//Materialize buffers
auto mat_idx8 = atomicAdd((int*)MAT_IDX8, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT8aggr0__tmp_attr0[mat_idx8] = reg_aggr0__tmp_attr0;
auto reg_date__d_year = date__d_year[tid];
MAT8date__d_year[mat_idx8] = reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[tid];
MAT8part__p_brand1_encoded[mat_idx8] = reg_part__p_brand1_encoded;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
size_t COUNT0 = part_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_0;
cudaMalloc(&d_BUF_IDX_0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_0, 0, sizeof(uint64_t));
uint64_t* d_BUF_0;
cudaMalloc(&d_BUF_0, sizeof(uint64_t) * COUNT0 * 1);
auto d_HT_0 = cuco::static_map{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_part__p_category, d_part__p_partkey, part_size);
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
main_5<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_4, d_BUF_IDX_4, d_HT_4.ref(cuco::insert), d_date__d_datekey, date_size);
cudaFree(d_BUF_IDX_4);
size_t COUNT6 = 391755;
auto d_HT_6 = cuco::static_map{ (int)391755*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_6;
cudaMalloc(&d_SLOT_COUNT_6, sizeof(int));
cudaMemset(d_SLOT_COUNT_6, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT6);
DBI32Type* d_KEY_6date__d_year;
cudaMalloc(&d_KEY_6date__d_year, sizeof(DBI32Type) * COUNT6);
cudaMemset(d_KEY_6date__d_year, 0, sizeof(DBI32Type) * COUNT6);
DBI16Type* d_KEY_6part__p_brand1_encoded;
cudaMalloc(&d_KEY_6part__p_brand1_encoded, sizeof(DBI16Type) * COUNT6);
cudaMemset(d_KEY_6part__p_brand1_encoded, 0, sizeof(DBI16Type) * COUNT6);
main_7<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_0, d_BUF_2, d_BUF_4, d_HT_0.ref(cuco::find), d_HT_2.ref(cuco::find), d_HT_4.ref(cuco::find), d_HT_6.ref(cuco::insert_and_find), d_KEY_6date__d_year, d_KEY_6part__p_brand1_encoded, d_SLOT_COUNT_6, d_aggr0__tmp_attr0, d_date__d_year, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_part__p_brand1_encoded);
COUNT6 = d_HT_6.size();
size_t COUNT8 = COUNT6;
//Materialize buffers
uint64_t* d_MAT_IDX8;
cudaMalloc(&d_MAT_IDX8, sizeof(uint64_t));
cudaMemset(d_MAT_IDX8, 0, sizeof(uint64_t));
auto MAT8aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT8);
DBDecimalType* d_MAT8aggr0__tmp_attr0;
cudaMalloc(&d_MAT8aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT8);
auto MAT8date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT8);
DBI32Type* d_MAT8date__d_year;
cudaMalloc(&d_MAT8date__d_year, sizeof(DBI32Type) * COUNT8);
auto MAT8part__p_brand1_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT8);
DBI16Type* d_MAT8part__p_brand1_encoded;
cudaMalloc(&d_MAT8part__p_brand1_encoded, sizeof(DBI16Type) * COUNT8);
main_9<<<std::ceil((float)COUNT6/128.), 128>>>(COUNT6, d_MAT8aggr0__tmp_attr0, d_MAT8date__d_year, d_MAT8part__p_brand1_encoded, d_MAT_IDX8, d_aggr0__tmp_attr0, d_KEY_6date__d_year, d_KEY_6part__p_brand1_encoded);
uint64_t MATCOUNT_8 = 0;
cudaMemcpy(&MATCOUNT_8, d_MAT_IDX8, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT8aggr0__tmp_attr0, d_MAT8aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT8, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT8date__d_year, d_MAT8date__d_year, sizeof(DBI32Type) * COUNT8, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT8part__p_brand1_encoded, d_MAT8part__p_brand1_encoded, sizeof(DBI16Type) * COUNT8, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
std::clog << "Query execution time: " << duration.count() / 1000. << " milliseconds." << std::endl;

for (auto i=0ull; i < MATCOUNT_8; i++) { std::cout << "" << MAT8aggr0__tmp_attr0[i];
std::cout << "|" << MAT8date__d_year[i];
std::cout << "|" << part__p_brand1_map[MAT8part__p_brand1_encoded[i]];
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
cudaFree(d_KEY_6date__d_year);
cudaFree(d_KEY_6part__p_brand1_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_MAT8aggr0__tmp_attr0);
cudaFree(d_MAT8date__d_year);
cudaFree(d_MAT8part__p_brand1_encoded);
cudaFree(d_MAT_IDX8);
free(MAT8aggr0__tmp_attr0);
free(MAT8date__d_year);
free(MAT8part__p_brand1_encoded);
}