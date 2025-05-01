#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_63fdb23d1120(uint64_t* COUNT63fdb23f0c60, DBStringType* customer__c_city, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_city = customer__c_city[tid];
if (!((evaluatePredicate(reg_customer__c_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_customer__c_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT63fdb23f0c60, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_63fdb23d1120(uint64_t* BUF_63fdb23f0c60, uint64_t* BUF_IDX_63fdb23f0c60, HASHTABLE_INSERT HT_63fdb23f0c60, DBStringType* customer__c_city, DBI32Type* customer__c_custkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_city = customer__c_city[tid];
if (!((evaluatePredicate(reg_customer__c_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_customer__c_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_63fdb23f0c60 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_63fdb23f0c60 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_63fdb23f0c60 = atomicAdd((int*)BUF_IDX_63fdb23f0c60, 1);
HT_63fdb23f0c60.insert(cuco::pair{KEY_63fdb23f0c60, buf_idx_63fdb23f0c60});
BUF_63fdb23f0c60[buf_idx_63fdb23f0c60 * 1 + 0] = tid;
}
__global__ void count_63fdb23d16c0(uint64_t* COUNT63fdb23ee570, DBStringType* supplier__s_city, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_city = supplier__s_city[tid];
if (!((evaluatePredicate(reg_supplier__s_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_supplier__s_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT63fdb23ee570, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_63fdb23d16c0(uint64_t* BUF_63fdb23ee570, uint64_t* BUF_IDX_63fdb23ee570, HASHTABLE_INSERT HT_63fdb23ee570, DBStringType* supplier__s_city, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_city = supplier__s_city[tid];
if (!((evaluatePredicate(reg_supplier__s_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_supplier__s_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_63fdb23ee570 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_63fdb23ee570 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_63fdb23ee570 = atomicAdd((int*)BUF_IDX_63fdb23ee570, 1);
HT_63fdb23ee570.insert(cuco::pair{KEY_63fdb23ee570, buf_idx_63fdb23ee570});
BUF_63fdb23ee570[buf_idx_63fdb23ee570 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_63fdb23eb550(uint64_t* BUF_63fdb23ee570, uint64_t* BUF_63fdb23f0c60, uint64_t* COUNT63fdb23e9790, HASHTABLE_PROBE HT_63fdb23ee570, HASHTABLE_PROBE HT_63fdb23f0c60, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_63fdb23f0c60 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_63fdb23f0c60 |= reg_lineorder__lo_custkey;
//Probe Hash table
auto SLOT_63fdb23f0c60 = HT_63fdb23f0c60.find(KEY_63fdb23f0c60);
if (SLOT_63fdb23f0c60 == HT_63fdb23f0c60.end()) return;
if (!(true)) return;
uint64_t KEY_63fdb23ee570 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_63fdb23ee570 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_63fdb23ee570 = HT_63fdb23ee570.find(KEY_63fdb23ee570);
if (SLOT_63fdb23ee570 == HT_63fdb23ee570.end()) return;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT63fdb23e9790, 1);
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_63fdb23eb550(uint64_t* BUF_63fdb23e9790, uint64_t* BUF_63fdb23ee570, uint64_t* BUF_63fdb23f0c60, uint64_t* BUF_IDX_63fdb23e9790, HASHTABLE_INSERT HT_63fdb23e9790, HASHTABLE_PROBE HT_63fdb23ee570, HASHTABLE_PROBE HT_63fdb23f0c60, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_63fdb23f0c60 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_63fdb23f0c60 |= reg_lineorder__lo_custkey;
//Probe Hash table
auto SLOT_63fdb23f0c60 = HT_63fdb23f0c60.find(KEY_63fdb23f0c60);
if (SLOT_63fdb23f0c60 == HT_63fdb23f0c60.end()) return;
if (!(true)) return;
uint64_t KEY_63fdb23ee570 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_63fdb23ee570 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_63fdb23ee570 = HT_63fdb23ee570.find(KEY_63fdb23ee570);
if (SLOT_63fdb23ee570 == HT_63fdb23ee570.end()) return;
if (!(true)) return;
uint64_t KEY_63fdb23e9790 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_63fdb23e9790 |= reg_lineorder__lo_orderdate;
// Insert hash table kernel;
auto buf_idx_63fdb23e9790 = atomicAdd((int*)BUF_IDX_63fdb23e9790, 1);
HT_63fdb23e9790.insert(cuco::pair{KEY_63fdb23e9790, buf_idx_63fdb23e9790});
BUF_63fdb23e9790[buf_idx_63fdb23e9790 * 3 + 0] = BUF_63fdb23f0c60[SLOT_63fdb23f0c60->second * 1 + 0];
BUF_63fdb23e9790[buf_idx_63fdb23e9790 * 3 + 1] = tid;
BUF_63fdb23e9790[buf_idx_63fdb23e9790 * 3 + 2] = BUF_63fdb23ee570[SLOT_63fdb23ee570->second * 1 + 0];
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_63fdb23fd4f0(uint64_t* BUF_63fdb23e9790, HASHTABLE_INSERT HT_63fdb23a14e0, HASHTABLE_PROBE HT_63fdb23e9790, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_63fdb23e9790 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_63fdb23e9790 |= reg_date__d_datekey;
//Probe Hash table
auto SLOT_63fdb23e9790 = HT_63fdb23e9790.find(KEY_63fdb23e9790);
if (SLOT_63fdb23e9790 == HT_63fdb23e9790.end()) return;
if (!(true)) return;
uint64_t KEY_63fdb23a14e0 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_63fdb23e9790[SLOT_63fdb23e9790->second * 3 + 0]];

KEY_63fdb23a14e0 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_63fdb23e9790[SLOT_63fdb23e9790->second * 3 + 2]];
KEY_63fdb23a14e0 <<= 16;
KEY_63fdb23a14e0 |= reg_supplier__s_city_encoded;
KEY_63fdb23a14e0 <<= 32;
KEY_63fdb23a14e0 |= reg_date__d_year;
//Create aggregation hash table
HT_63fdb23a14e0.insert(cuco::pair{KEY_63fdb23a14e0, 1});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_63fdb23fd4f0(uint64_t* BUF_63fdb23e9790, HASHTABLE_FIND HT_63fdb23a14e0, HASHTABLE_PROBE HT_63fdb23e9790, DBI16Type* KEY_63fdb23a14e0customer__c_city_encoded, DBI32Type* KEY_63fdb23a14e0date__d_year, DBI16Type* KEY_63fdb23a14e0supplier__s_city_encoded, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size, DBDecimalType* lineorder__lo_revenue, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_63fdb23e9790 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_63fdb23e9790 |= reg_date__d_datekey;
//Probe Hash table
auto SLOT_63fdb23e9790 = HT_63fdb23e9790.find(KEY_63fdb23e9790);
if (SLOT_63fdb23e9790 == HT_63fdb23e9790.end()) return;
if (!(true)) return;
uint64_t KEY_63fdb23a14e0 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_63fdb23e9790[SLOT_63fdb23e9790->second * 3 + 0]];

KEY_63fdb23a14e0 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_63fdb23e9790[SLOT_63fdb23e9790->second * 3 + 2]];
KEY_63fdb23a14e0 <<= 16;
KEY_63fdb23a14e0 |= reg_supplier__s_city_encoded;
KEY_63fdb23a14e0 <<= 32;
KEY_63fdb23a14e0 |= reg_date__d_year;
//Aggregate in hashtable
auto buf_idx_63fdb23a14e0 = HT_63fdb23a14e0.find(KEY_63fdb23a14e0)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[BUF_63fdb23e9790[SLOT_63fdb23e9790->second * 3 + 1]];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_63fdb23a14e0], reg_lineorder__lo_revenue);
KEY_63fdb23a14e0customer__c_city_encoded[buf_idx_63fdb23a14e0] = reg_customer__c_city_encoded;
KEY_63fdb23a14e0supplier__s_city_encoded[buf_idx_63fdb23a14e0] = reg_supplier__s_city_encoded;
KEY_63fdb23a14e0date__d_year[buf_idx_63fdb23a14e0] = reg_date__d_year;
}
__global__ void count_63fdb240c7e0(size_t COUNT63fdb23a14e0, uint64_t* COUNT63fdb23b45d0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT63fdb23a14e0) return;
//Materialize count
atomicAdd((int*)COUNT63fdb23b45d0, 1);
}
__global__ void main_63fdb240c7e0(size_t COUNT63fdb23a14e0, DBDecimalType* MAT63fdb23b45d0aggr0__tmp_attr0, DBI16Type* MAT63fdb23b45d0customer__c_city_encoded, DBI32Type* MAT63fdb23b45d0date__d_year, DBI16Type* MAT63fdb23b45d0supplier__s_city_encoded, uint64_t* MAT_IDX63fdb23b45d0, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT63fdb23a14e0) return;
//Materialize buffers
auto mat_idx63fdb23b45d0 = atomicAdd((int*)MAT_IDX63fdb23b45d0, 1);
auto reg_customer__c_city_encoded = customer__c_city_encoded[tid];
MAT63fdb23b45d0customer__c_city_encoded[mat_idx63fdb23b45d0] = reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[tid];
MAT63fdb23b45d0supplier__s_city_encoded[mat_idx63fdb23b45d0] = reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[tid];
MAT63fdb23b45d0date__d_year[mat_idx63fdb23b45d0] = reg_date__d_year;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT63fdb23b45d0aggr0__tmp_attr0[mat_idx63fdb23b45d0] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT63fdb23f0c60;
cudaMalloc(&d_COUNT63fdb23f0c60, sizeof(uint64_t));
cudaMemset(d_COUNT63fdb23f0c60, 0, sizeof(uint64_t));
count_63fdb23d1120<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT63fdb23f0c60, d_customer__c_city, customer_size);
uint64_t COUNT63fdb23f0c60;
cudaMemcpy(&COUNT63fdb23f0c60, d_COUNT63fdb23f0c60, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_63fdb23f0c60;
cudaMalloc(&d_BUF_IDX_63fdb23f0c60, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_63fdb23f0c60, 0, sizeof(uint64_t));
uint64_t* d_BUF_63fdb23f0c60;
cudaMalloc(&d_BUF_63fdb23f0c60, sizeof(uint64_t) * COUNT63fdb23f0c60 * 1);
auto d_HT_63fdb23f0c60 = cuco::static_map{ (int)COUNT63fdb23f0c60*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_63fdb23d1120<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_63fdb23f0c60, d_BUF_IDX_63fdb23f0c60, d_HT_63fdb23f0c60.ref(cuco::insert), d_customer__c_city, d_customer__c_custkey, customer_size);
//Materialize count
uint64_t* d_COUNT63fdb23ee570;
cudaMalloc(&d_COUNT63fdb23ee570, sizeof(uint64_t));
cudaMemset(d_COUNT63fdb23ee570, 0, sizeof(uint64_t));
count_63fdb23d16c0<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT63fdb23ee570, d_supplier__s_city, supplier_size);
uint64_t COUNT63fdb23ee570;
cudaMemcpy(&COUNT63fdb23ee570, d_COUNT63fdb23ee570, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_63fdb23ee570;
cudaMalloc(&d_BUF_IDX_63fdb23ee570, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_63fdb23ee570, 0, sizeof(uint64_t));
uint64_t* d_BUF_63fdb23ee570;
cudaMalloc(&d_BUF_63fdb23ee570, sizeof(uint64_t) * COUNT63fdb23ee570 * 1);
auto d_HT_63fdb23ee570 = cuco::static_map{ (int)COUNT63fdb23ee570*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_63fdb23d16c0<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_63fdb23ee570, d_BUF_IDX_63fdb23ee570, d_HT_63fdb23ee570.ref(cuco::insert), d_supplier__s_city, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT63fdb23e9790;
cudaMalloc(&d_COUNT63fdb23e9790, sizeof(uint64_t));
cudaMemset(d_COUNT63fdb23e9790, 0, sizeof(uint64_t));
count_63fdb23eb550<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_63fdb23ee570, d_BUF_63fdb23f0c60, d_COUNT63fdb23e9790, d_HT_63fdb23ee570.ref(cuco::find), d_HT_63fdb23f0c60.ref(cuco::find), d_lineorder__lo_custkey, d_lineorder__lo_suppkey, lineorder_size);
uint64_t COUNT63fdb23e9790;
cudaMemcpy(&COUNT63fdb23e9790, d_COUNT63fdb23e9790, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_63fdb23e9790;
cudaMalloc(&d_BUF_IDX_63fdb23e9790, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_63fdb23e9790, 0, sizeof(uint64_t));
uint64_t* d_BUF_63fdb23e9790;
cudaMalloc(&d_BUF_63fdb23e9790, sizeof(uint64_t) * COUNT63fdb23e9790 * 3);
auto d_HT_63fdb23e9790 = cuco::static_map{ (int)COUNT63fdb23e9790*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_63fdb23eb550<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_63fdb23e9790, d_BUF_63fdb23ee570, d_BUF_63fdb23f0c60, d_BUF_IDX_63fdb23e9790, d_HT_63fdb23e9790.ref(cuco::insert), d_HT_63fdb23ee570.ref(cuco::find), d_HT_63fdb23f0c60.ref(cuco::find), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size);
//Create aggregation hash table
auto d_HT_63fdb23a14e0 = cuco::static_map{ (int)132*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_63fdb23fd4f0<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_63fdb23e9790, d_HT_63fdb23a14e0.ref(cuco::insert), d_HT_63fdb23e9790.ref(cuco::find), d_customer__c_city_encoded, d_date__d_datekey, d_date__d_year, date_size, d_supplier__s_city_encoded);
size_t COUNT63fdb23a14e0 = d_HT_63fdb23a14e0.size();
thrust::device_vector<int64_t> keys_63fdb23a14e0(COUNT63fdb23a14e0), vals_63fdb23a14e0(COUNT63fdb23a14e0);
d_HT_63fdb23a14e0.retrieve_all(keys_63fdb23a14e0.begin(), vals_63fdb23a14e0.begin());
d_HT_63fdb23a14e0.clear();
int64_t* raw_keys63fdb23a14e0 = thrust::raw_pointer_cast(keys_63fdb23a14e0.data());
insertKeys<<<std::ceil((float)COUNT63fdb23a14e0/128.), 128>>>(raw_keys63fdb23a14e0, d_HT_63fdb23a14e0.ref(cuco::insert), COUNT63fdb23a14e0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT63fdb23a14e0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT63fdb23a14e0);
DBI16Type* d_KEY_63fdb23a14e0customer__c_city_encoded;
cudaMalloc(&d_KEY_63fdb23a14e0customer__c_city_encoded, sizeof(DBI16Type) * COUNT63fdb23a14e0);
cudaMemset(d_KEY_63fdb23a14e0customer__c_city_encoded, 0, sizeof(DBI16Type) * COUNT63fdb23a14e0);
DBI16Type* d_KEY_63fdb23a14e0supplier__s_city_encoded;
cudaMalloc(&d_KEY_63fdb23a14e0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT63fdb23a14e0);
cudaMemset(d_KEY_63fdb23a14e0supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT63fdb23a14e0);
DBI32Type* d_KEY_63fdb23a14e0date__d_year;
cudaMalloc(&d_KEY_63fdb23a14e0date__d_year, sizeof(DBI32Type) * COUNT63fdb23a14e0);
cudaMemset(d_KEY_63fdb23a14e0date__d_year, 0, sizeof(DBI32Type) * COUNT63fdb23a14e0);
main_63fdb23fd4f0<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_63fdb23e9790, d_HT_63fdb23a14e0.ref(cuco::find), d_HT_63fdb23e9790.ref(cuco::find), d_KEY_63fdb23a14e0customer__c_city_encoded, d_KEY_63fdb23a14e0date__d_year, d_KEY_63fdb23a14e0supplier__s_city_encoded, d_aggr0__tmp_attr0, d_customer__c_city_encoded, d_date__d_datekey, d_date__d_year, date_size, d_lineorder__lo_revenue, d_supplier__s_city_encoded);
//Materialize count
uint64_t* d_COUNT63fdb23b45d0;
cudaMalloc(&d_COUNT63fdb23b45d0, sizeof(uint64_t));
cudaMemset(d_COUNT63fdb23b45d0, 0, sizeof(uint64_t));
count_63fdb240c7e0<<<std::ceil((float)COUNT63fdb23a14e0/128.), 128>>>(COUNT63fdb23a14e0, d_COUNT63fdb23b45d0);
uint64_t COUNT63fdb23b45d0;
cudaMemcpy(&COUNT63fdb23b45d0, d_COUNT63fdb23b45d0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX63fdb23b45d0;
cudaMalloc(&d_MAT_IDX63fdb23b45d0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX63fdb23b45d0, 0, sizeof(uint64_t));
auto MAT63fdb23b45d0customer__c_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT63fdb23b45d0);
DBI16Type* d_MAT63fdb23b45d0customer__c_city_encoded;
cudaMalloc(&d_MAT63fdb23b45d0customer__c_city_encoded, sizeof(DBI16Type) * COUNT63fdb23b45d0);
auto MAT63fdb23b45d0supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT63fdb23b45d0);
DBI16Type* d_MAT63fdb23b45d0supplier__s_city_encoded;
cudaMalloc(&d_MAT63fdb23b45d0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT63fdb23b45d0);
auto MAT63fdb23b45d0date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT63fdb23b45d0);
DBI32Type* d_MAT63fdb23b45d0date__d_year;
cudaMalloc(&d_MAT63fdb23b45d0date__d_year, sizeof(DBI32Type) * COUNT63fdb23b45d0);
auto MAT63fdb23b45d0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT63fdb23b45d0);
DBDecimalType* d_MAT63fdb23b45d0aggr0__tmp_attr0;
cudaMalloc(&d_MAT63fdb23b45d0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT63fdb23b45d0);
main_63fdb240c7e0<<<std::ceil((float)COUNT63fdb23a14e0/128.), 128>>>(COUNT63fdb23a14e0, d_MAT63fdb23b45d0aggr0__tmp_attr0, d_MAT63fdb23b45d0customer__c_city_encoded, d_MAT63fdb23b45d0date__d_year, d_MAT63fdb23b45d0supplier__s_city_encoded, d_MAT_IDX63fdb23b45d0, d_aggr0__tmp_attr0, d_KEY_63fdb23a14e0customer__c_city_encoded, d_KEY_63fdb23a14e0date__d_year, d_KEY_63fdb23a14e0supplier__s_city_encoded);
cudaMemcpy(MAT63fdb23b45d0customer__c_city_encoded, d_MAT63fdb23b45d0customer__c_city_encoded, sizeof(DBI16Type) * COUNT63fdb23b45d0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT63fdb23b45d0supplier__s_city_encoded, d_MAT63fdb23b45d0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT63fdb23b45d0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT63fdb23b45d0date__d_year, d_MAT63fdb23b45d0date__d_year, sizeof(DBI32Type) * COUNT63fdb23b45d0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT63fdb23b45d0aggr0__tmp_attr0, d_MAT63fdb23b45d0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT63fdb23b45d0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT63fdb23b45d0; i++) { std::cout << "" << customer__c_city_map[MAT63fdb23b45d0customer__c_city_encoded[i]];
std::cout << "," << supplier__s_city_map[MAT63fdb23b45d0supplier__s_city_encoded[i]];
std::cout << "," << MAT63fdb23b45d0date__d_year[i];
std::cout << "," << MAT63fdb23b45d0aggr0__tmp_attr0[i];
std::cout << std::endl; }
cudaFree(d_BUF_63fdb23f0c60);
cudaFree(d_BUF_IDX_63fdb23f0c60);
cudaFree(d_COUNT63fdb23f0c60);
cudaFree(d_BUF_63fdb23ee570);
cudaFree(d_BUF_IDX_63fdb23ee570);
cudaFree(d_COUNT63fdb23ee570);
cudaFree(d_BUF_63fdb23e9790);
cudaFree(d_BUF_IDX_63fdb23e9790);
cudaFree(d_COUNT63fdb23e9790);
cudaFree(d_KEY_63fdb23a14e0customer__c_city_encoded);
cudaFree(d_KEY_63fdb23a14e0date__d_year);
cudaFree(d_KEY_63fdb23a14e0supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT63fdb23b45d0);
cudaFree(d_MAT63fdb23b45d0aggr0__tmp_attr0);
cudaFree(d_MAT63fdb23b45d0customer__c_city_encoded);
cudaFree(d_MAT63fdb23b45d0date__d_year);
cudaFree(d_MAT63fdb23b45d0supplier__s_city_encoded);
cudaFree(d_MAT_IDX63fdb23b45d0);
free(MAT63fdb23b45d0aggr0__tmp_attr0);
free(MAT63fdb23b45d0customer__c_city_encoded);
free(MAT63fdb23b45d0date__d_year);
free(MAT63fdb23b45d0supplier__s_city_encoded);
}