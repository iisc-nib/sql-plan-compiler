#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_58a5f8f2f1e0(uint64_t* COUNT58a5f8f43da0, DBI32Type* date__d_yearmonthnum, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_yearmonthnum = date__d_yearmonthnum[tid];
if (!(evaluatePredicate(reg_date__d_yearmonthnum, 199401, Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT58a5f8f43da0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_58a5f8f2f1e0(uint64_t* BUF_58a5f8f43da0, uint64_t* BUF_IDX_58a5f8f43da0, HASHTABLE_INSERT HT_58a5f8f43da0, DBI32Type* date__d_datekey, DBI32Type* date__d_yearmonthnum, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_yearmonthnum = date__d_yearmonthnum[tid];
if (!(evaluatePredicate(reg_date__d_yearmonthnum, 199401, Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_58a5f8f43da0 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_58a5f8f43da0 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_58a5f8f43da0 = atomicAdd((int*)BUF_IDX_58a5f8f43da0, 1);
HT_58a5f8f43da0.insert(cuco::pair{KEY_58a5f8f43da0, buf_idx_58a5f8f43da0});
BUF_58a5f8f43da0[buf_idx_58a5f8f43da0 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_58a5f8f2ed30(uint64_t* BUF_58a5f8f43da0, HASHTABLE_INSERT HT_58a5f8f00550, HASHTABLE_PROBE HT_58a5f8f43da0, DBI32Type* lineorder__lo_discount, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_quantity, size_t lineorder_size) {
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
uint64_t KEY_58a5f8f43da0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_58a5f8f43da0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_58a5f8f43da0 = HT_58a5f8f43da0.find(KEY_58a5f8f43da0);
if (SLOT_58a5f8f43da0 == HT_58a5f8f43da0.end()) return;
if (!(true)) return;
uint64_t KEY_58a5f8f00550 = 0;
//Create aggregation hash table
HT_58a5f8f00550.insert(cuco::pair{KEY_58a5f8f00550, 1});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_58a5f8f2ed30(uint64_t* BUF_58a5f8f43da0, HASHTABLE_FIND HT_58a5f8f00550, HASHTABLE_PROBE HT_58a5f8f43da0, DBDecimalType* aggr0__tmp_attr0, DBI32Type* lineorder__lo_discount, DBDecimalType* lineorder__lo_extendedprice, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_quantity, size_t lineorder_size) {
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
uint64_t KEY_58a5f8f43da0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_58a5f8f43da0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_58a5f8f43da0 = HT_58a5f8f43da0.find(KEY_58a5f8f43da0);
if (SLOT_58a5f8f43da0 == HT_58a5f8f43da0.end()) return;
if (!(true)) return;
uint64_t KEY_58a5f8f00550 = 0;
//Aggregate in hashtable
auto buf_idx_58a5f8f00550 = HT_58a5f8f00550.find(KEY_58a5f8f00550)->second;
auto reg_lineorder__lo_extendedprice = lineorder__lo_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_extendedprice) * ((DBDecimalType)(reg_lineorder__lo_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_58a5f8f00550], reg_map0__tmp_attr1);
}
__global__ void count_58a5f8f57ab0(size_t COUNT58a5f8f00550, uint64_t* COUNT58a5f8f12430) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT58a5f8f00550) return;
//Materialize count
atomicAdd((int*)COUNT58a5f8f12430, 1);
}
__global__ void main_58a5f8f57ab0(size_t COUNT58a5f8f00550, DBDecimalType* MAT58a5f8f12430aggr0__tmp_attr0, uint64_t* MAT_IDX58a5f8f12430, DBDecimalType* aggr0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT58a5f8f00550) return;
//Materialize buffers
auto mat_idx58a5f8f12430 = atomicAdd((int*)MAT_IDX58a5f8f12430, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT58a5f8f12430aggr0__tmp_attr0[mat_idx58a5f8f12430] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT58a5f8f43da0;
cudaMalloc(&d_COUNT58a5f8f43da0, sizeof(uint64_t));
cudaMemset(d_COUNT58a5f8f43da0, 0, sizeof(uint64_t));
count_58a5f8f2f1e0<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT58a5f8f43da0, d_date__d_yearmonthnum, date_size);
uint64_t COUNT58a5f8f43da0;
cudaMemcpy(&COUNT58a5f8f43da0, d_COUNT58a5f8f43da0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_58a5f8f43da0;
cudaMalloc(&d_BUF_IDX_58a5f8f43da0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_58a5f8f43da0, 0, sizeof(uint64_t));
uint64_t* d_BUF_58a5f8f43da0;
cudaMalloc(&d_BUF_58a5f8f43da0, sizeof(uint64_t) * COUNT58a5f8f43da0 * 1);
auto d_HT_58a5f8f43da0 = cuco::static_map{ (int)COUNT58a5f8f43da0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_58a5f8f2f1e0<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_58a5f8f43da0, d_BUF_IDX_58a5f8f43da0, d_HT_58a5f8f43da0.ref(cuco::insert), d_date__d_datekey, d_date__d_yearmonthnum, date_size);
//Create aggregation hash table
auto d_HT_58a5f8f00550 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_58a5f8f2ed30<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_58a5f8f43da0, d_HT_58a5f8f00550.ref(cuco::insert), d_HT_58a5f8f43da0.ref(cuco::find), d_lineorder__lo_discount, d_lineorder__lo_orderdate, d_lineorder__lo_quantity, lineorder_size);
size_t COUNT58a5f8f00550 = d_HT_58a5f8f00550.size();
thrust::device_vector<int64_t> keys_58a5f8f00550(COUNT58a5f8f00550), vals_58a5f8f00550(COUNT58a5f8f00550);
d_HT_58a5f8f00550.retrieve_all(keys_58a5f8f00550.begin(), vals_58a5f8f00550.begin());
d_HT_58a5f8f00550.clear();
int64_t* raw_keys58a5f8f00550 = thrust::raw_pointer_cast(keys_58a5f8f00550.data());
insertKeys<<<std::ceil((float)COUNT58a5f8f00550/128.), 128>>>(raw_keys58a5f8f00550, d_HT_58a5f8f00550.ref(cuco::insert), COUNT58a5f8f00550);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT58a5f8f00550);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT58a5f8f00550);
main_58a5f8f2ed30<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_58a5f8f43da0, d_HT_58a5f8f00550.ref(cuco::find), d_HT_58a5f8f43da0.ref(cuco::find), d_aggr0__tmp_attr0, d_lineorder__lo_discount, d_lineorder__lo_extendedprice, d_lineorder__lo_orderdate, d_lineorder__lo_quantity, lineorder_size);
//Materialize count
uint64_t* d_COUNT58a5f8f12430;
cudaMalloc(&d_COUNT58a5f8f12430, sizeof(uint64_t));
cudaMemset(d_COUNT58a5f8f12430, 0, sizeof(uint64_t));
count_58a5f8f57ab0<<<std::ceil((float)COUNT58a5f8f00550/128.), 128>>>(COUNT58a5f8f00550, d_COUNT58a5f8f12430);
uint64_t COUNT58a5f8f12430;
cudaMemcpy(&COUNT58a5f8f12430, d_COUNT58a5f8f12430, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX58a5f8f12430;
cudaMalloc(&d_MAT_IDX58a5f8f12430, sizeof(uint64_t));
cudaMemset(d_MAT_IDX58a5f8f12430, 0, sizeof(uint64_t));
auto MAT58a5f8f12430aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT58a5f8f12430);
DBDecimalType* d_MAT58a5f8f12430aggr0__tmp_attr0;
cudaMalloc(&d_MAT58a5f8f12430aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT58a5f8f12430);
main_58a5f8f57ab0<<<std::ceil((float)COUNT58a5f8f00550/128.), 128>>>(COUNT58a5f8f00550, d_MAT58a5f8f12430aggr0__tmp_attr0, d_MAT_IDX58a5f8f12430, d_aggr0__tmp_attr0);
cudaMemcpy(MAT58a5f8f12430aggr0__tmp_attr0, d_MAT58a5f8f12430aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT58a5f8f12430, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT58a5f8f12430; i++) { std::cout << "" << MAT58a5f8f12430aggr0__tmp_attr0[i];
std::cout << std::endl; }
cudaFree(d_BUF_58a5f8f43da0);
cudaFree(d_BUF_IDX_58a5f8f43da0);
cudaFree(d_COUNT58a5f8f43da0);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT58a5f8f12430);
cudaFree(d_MAT58a5f8f12430aggr0__tmp_attr0);
cudaFree(d_MAT_IDX58a5f8f12430);
free(MAT58a5f8f12430aggr0__tmp_attr0);
}