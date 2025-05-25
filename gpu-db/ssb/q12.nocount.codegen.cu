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
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT HT_0, DBI32Type* date__d_datekey, DBI32Type* date__d_yearmonthnum, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_yearmonthnum = date__d_yearmonthnum[tid];
if (!(evaluatePredicate(reg_date__d_yearmonthnum, 199401, Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_0 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_0 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_0 = atomicAdd((int*)BUF_IDX_0, 1);
HT_0.insert(cuco::pair{KEY_0, buf_idx_0});
BUF_0[buf_idx_0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE_PK, typename HASHTABLE_FIND>
__global__ void main_3(uint64_t* BUF_0, HASHTABLE_PROBE_PK HT_0, HASHTABLE_FIND HT_2, int* SLOT_COUNT_2, DBDecimalType* aggr0__tmp_attr0, DBI32Type* lineorder__lo_discount, DBDecimalType* lineorder__lo_extendedprice, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_quantity, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
auto reg_lineorder__lo_discount = lineorder__lo_discount[tid];
if (!(evaluatePredicate(reg_lineorder__lo_discount, 4, Predicate::gte) && evaluatePredicate(reg_lineorder__lo_discount, 6, Predicate::lte))) return;
auto reg_lineorder__lo_quantity = lineorder__lo_quantity[tid];
if (!(evaluatePredicate(reg_lineorder__lo_quantity, 26, Predicate::gte) && evaluatePredicate(reg_lineorder__lo_quantity, 35, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_0 = HT_0.find(KEY_0);
if (SLOT_0 == HT_0.end()) return;
if (!(true)) return;
uint64_t KEY_2 = 0;
//Aggregate in hashtable
auto buf_idx_2 = get_aggregation_slot(KEY_2, HT_2, SLOT_COUNT_2);
auto reg_lineorder__lo_extendedprice = lineorder__lo_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_extendedprice) * ((DBDecimalType)(reg_lineorder__lo_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_2], reg_map0__tmp_attr1);
}
__global__ void main_5(size_t COUNT2, DBDecimalType* MAT4aggr0__tmp_attr0, uint64_t* MAT_IDX4, DBDecimalType* aggr0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT2) return;
//Materialize buffers
auto mat_idx4 = atomicAdd((int*)MAT_IDX4, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT4aggr0__tmp_attr0[mat_idx4] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
size_t used_mem = usedGpuMem();
auto start = std::chrono::high_resolution_clock::now();
size_t COUNT0 = date_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_0;
cudaMalloc(&d_BUF_IDX_0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_0, 0, sizeof(uint64_t));
uint64_t* d_BUF_0;
cudaMalloc(&d_BUF_0, sizeof(uint64_t) * COUNT0 * 1);
auto d_HT_0 = cuco::static_map{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_date__d_datekey, d_date__d_yearmonthnum, date_size);
cudaFree(d_BUF_IDX_0);
size_t COUNT2 = 1;
auto d_HT_2 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_2;
cudaMalloc(&d_SLOT_COUNT_2, sizeof(int));
cudaMemset(d_SLOT_COUNT_2, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT2);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT2);
main_3<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_0, d_HT_0.ref(cuco::find), d_HT_2.ref(cuco::insert_and_find), d_SLOT_COUNT_2, d_aggr0__tmp_attr0, d_lineorder__lo_discount, d_lineorder__lo_extendedprice, d_lineorder__lo_orderdate, d_lineorder__lo_quantity, lineorder_size);
COUNT2 = d_HT_2.size();
size_t COUNT4 = COUNT2;
//Materialize buffers
uint64_t* d_MAT_IDX4;
cudaMalloc(&d_MAT_IDX4, sizeof(uint64_t));
cudaMemset(d_MAT_IDX4, 0, sizeof(uint64_t));
auto MAT4aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT4);
DBDecimalType* d_MAT4aggr0__tmp_attr0;
cudaMalloc(&d_MAT4aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT4);
main_5<<<std::ceil((float)COUNT2/128.), 128>>>(COUNT2, d_MAT4aggr0__tmp_attr0, d_MAT_IDX4, d_aggr0__tmp_attr0);
uint64_t MATCOUNT_4 = 0;
cudaMemcpy(&MATCOUNT_4, d_MAT_IDX4, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT4aggr0__tmp_attr0, d_MAT4aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT4, cudaMemcpyDeviceToHost);
auto end = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
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