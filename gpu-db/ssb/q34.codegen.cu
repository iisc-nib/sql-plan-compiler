#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5d0dcd849740(uint64_t* COUNT5d0dcd85fc60, DBStringType* customer__c_city, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_city = customer__c_city[tid];
if (!((evaluatePredicate(reg_customer__c_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_customer__c_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5d0dcd85fc60, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5d0dcd849740(uint64_t* BUF_5d0dcd85fc60, uint64_t* BUF_IDX_5d0dcd85fc60, HASHTABLE_INSERT HT_5d0dcd85fc60, DBStringType* customer__c_city, DBI32Type* customer__c_custkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_city = customer__c_city[tid];
if (!((evaluatePredicate(reg_customer__c_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_customer__c_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5d0dcd85fc60 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5d0dcd85fc60 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_5d0dcd85fc60 = atomicAdd((int*)BUF_IDX_5d0dcd85fc60, 1);
HT_5d0dcd85fc60.insert(cuco::pair{KEY_5d0dcd85fc60, buf_idx_5d0dcd85fc60});
BUF_5d0dcd85fc60[buf_idx_5d0dcd85fc60 * 1 + 0] = tid;
}
__global__ void count_5d0dcd849ce0(uint64_t* COUNT5d0dcd8686e0, DBStringType* supplier__s_city, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_city = supplier__s_city[tid];
if (!((evaluatePredicate(reg_supplier__s_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_supplier__s_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5d0dcd8686e0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5d0dcd849ce0(uint64_t* BUF_5d0dcd8686e0, uint64_t* BUF_IDX_5d0dcd8686e0, HASHTABLE_INSERT HT_5d0dcd8686e0, DBStringType* supplier__s_city, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_city = supplier__s_city[tid];
if (!((evaluatePredicate(reg_supplier__s_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_supplier__s_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5d0dcd8686e0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5d0dcd8686e0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5d0dcd8686e0 = atomicAdd((int*)BUF_IDX_5d0dcd8686e0, 1);
HT_5d0dcd8686e0.insert(cuco::pair{KEY_5d0dcd8686e0, buf_idx_5d0dcd8686e0});
BUF_5d0dcd8686e0[buf_idx_5d0dcd8686e0 * 1 + 0] = tid;
}
__global__ void count_5d0dcd875f00(uint64_t* COUNT5d0dcd860aa0, DBStringType* date__d_yearmonth, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_yearmonth = date__d_yearmonth[tid];
if (!(evaluatePredicate(reg_date__d_yearmonth, "Dec1997", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5d0dcd860aa0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5d0dcd875f00(uint64_t* BUF_5d0dcd860aa0, uint64_t* BUF_IDX_5d0dcd860aa0, HASHTABLE_INSERT HT_5d0dcd860aa0, DBI32Type* date__d_datekey, DBStringType* date__d_yearmonth, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_yearmonth = date__d_yearmonth[tid];
if (!(evaluatePredicate(reg_date__d_yearmonth, "Dec1997", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5d0dcd860aa0 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5d0dcd860aa0 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_5d0dcd860aa0 = atomicAdd((int*)BUF_IDX_5d0dcd860aa0, 1);
HT_5d0dcd860aa0.insert(cuco::pair{KEY_5d0dcd860aa0, buf_idx_5d0dcd860aa0});
BUF_5d0dcd860aa0[buf_idx_5d0dcd860aa0 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5d0dcd867db0(uint64_t* BUF_5d0dcd85fc60, uint64_t* BUF_5d0dcd860aa0, uint64_t* BUF_5d0dcd8686e0, HASHTABLE_INSERT HT_5d0dcd819160, HASHTABLE_PROBE HT_5d0dcd85fc60, HASHTABLE_PROBE HT_5d0dcd860aa0, HASHTABLE_PROBE HT_5d0dcd8686e0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5d0dcd85fc60 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5d0dcd85fc60 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_5d0dcd85fc60.for_each(KEY_5d0dcd85fc60, [&] __device__ (auto const SLOT_5d0dcd85fc60) {

auto const [slot_first5d0dcd85fc60, slot_second5d0dcd85fc60] = SLOT_5d0dcd85fc60;
if (!(true)) return;
uint64_t KEY_5d0dcd8686e0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5d0dcd8686e0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5d0dcd8686e0.for_each(KEY_5d0dcd8686e0, [&] __device__ (auto const SLOT_5d0dcd8686e0) {

auto const [slot_first5d0dcd8686e0, slot_second5d0dcd8686e0] = SLOT_5d0dcd8686e0;
if (!(true)) return;
uint64_t KEY_5d0dcd860aa0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5d0dcd860aa0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5d0dcd860aa0.for_each(KEY_5d0dcd860aa0, [&] __device__ (auto const SLOT_5d0dcd860aa0) {

auto const [slot_first5d0dcd860aa0, slot_second5d0dcd860aa0] = SLOT_5d0dcd860aa0;
if (!(true)) return;
uint64_t KEY_5d0dcd819160 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_5d0dcd85fc60[slot_second5d0dcd85fc60 * 1 + 0]];

KEY_5d0dcd819160 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_5d0dcd8686e0[slot_second5d0dcd8686e0 * 1 + 0]];
KEY_5d0dcd819160 <<= 16;
KEY_5d0dcd819160 |= reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[BUF_5d0dcd860aa0[slot_second5d0dcd860aa0 * 1 + 0]];
KEY_5d0dcd819160 <<= 32;
KEY_5d0dcd819160 |= reg_date__d_year;
//Create aggregation hash table
HT_5d0dcd819160.insert(cuco::pair{KEY_5d0dcd819160, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5d0dcd867db0(uint64_t* BUF_5d0dcd85fc60, uint64_t* BUF_5d0dcd860aa0, uint64_t* BUF_5d0dcd8686e0, HASHTABLE_FIND HT_5d0dcd819160, HASHTABLE_PROBE HT_5d0dcd85fc60, HASHTABLE_PROBE HT_5d0dcd860aa0, HASHTABLE_PROBE HT_5d0dcd8686e0, DBI16Type* KEY_5d0dcd819160customer__c_city_encoded, DBI32Type* KEY_5d0dcd819160date__d_year, DBI16Type* KEY_5d0dcd819160supplier__s_city_encoded, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5d0dcd85fc60 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5d0dcd85fc60 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_5d0dcd85fc60.for_each(KEY_5d0dcd85fc60, [&] __device__ (auto const SLOT_5d0dcd85fc60) {
auto const [slot_first5d0dcd85fc60, slot_second5d0dcd85fc60] = SLOT_5d0dcd85fc60;
if (!(true)) return;
uint64_t KEY_5d0dcd8686e0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5d0dcd8686e0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5d0dcd8686e0.for_each(KEY_5d0dcd8686e0, [&] __device__ (auto const SLOT_5d0dcd8686e0) {
auto const [slot_first5d0dcd8686e0, slot_second5d0dcd8686e0] = SLOT_5d0dcd8686e0;
if (!(true)) return;
uint64_t KEY_5d0dcd860aa0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5d0dcd860aa0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5d0dcd860aa0.for_each(KEY_5d0dcd860aa0, [&] __device__ (auto const SLOT_5d0dcd860aa0) {
auto const [slot_first5d0dcd860aa0, slot_second5d0dcd860aa0] = SLOT_5d0dcd860aa0;
if (!(true)) return;
uint64_t KEY_5d0dcd819160 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_5d0dcd85fc60[slot_second5d0dcd85fc60 * 1 + 0]];

KEY_5d0dcd819160 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_5d0dcd8686e0[slot_second5d0dcd8686e0 * 1 + 0]];
KEY_5d0dcd819160 <<= 16;
KEY_5d0dcd819160 |= reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[BUF_5d0dcd860aa0[slot_second5d0dcd860aa0 * 1 + 0]];
KEY_5d0dcd819160 <<= 32;
KEY_5d0dcd819160 |= reg_date__d_year;
//Aggregate in hashtable
auto buf_idx_5d0dcd819160 = HT_5d0dcd819160.find(KEY_5d0dcd819160)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5d0dcd819160], reg_lineorder__lo_revenue);
KEY_5d0dcd819160customer__c_city_encoded[buf_idx_5d0dcd819160] = reg_customer__c_city_encoded;
KEY_5d0dcd819160supplier__s_city_encoded[buf_idx_5d0dcd819160] = reg_supplier__s_city_encoded;
KEY_5d0dcd819160date__d_year[buf_idx_5d0dcd819160] = reg_date__d_year;
});
});
});
}
__global__ void count_5d0dcd883400(size_t COUNT5d0dcd819160, uint64_t* COUNT5d0dcd82c7f0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5d0dcd819160) return;
//Materialize count
atomicAdd((int*)COUNT5d0dcd82c7f0, 1);
}
__global__ void main_5d0dcd883400(size_t COUNT5d0dcd819160, DBDecimalType* MAT5d0dcd82c7f0aggr0__tmp_attr0, DBI16Type* MAT5d0dcd82c7f0customer__c_city_encoded, DBI32Type* MAT5d0dcd82c7f0date__d_year, DBI16Type* MAT5d0dcd82c7f0supplier__s_city_encoded, uint64_t* MAT_IDX5d0dcd82c7f0, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5d0dcd819160) return;
//Materialize buffers
auto mat_idx5d0dcd82c7f0 = atomicAdd((int*)MAT_IDX5d0dcd82c7f0, 1);
auto reg_customer__c_city_encoded = customer__c_city_encoded[tid];
MAT5d0dcd82c7f0customer__c_city_encoded[mat_idx5d0dcd82c7f0] = reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[tid];
MAT5d0dcd82c7f0supplier__s_city_encoded[mat_idx5d0dcd82c7f0] = reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[tid];
MAT5d0dcd82c7f0date__d_year[mat_idx5d0dcd82c7f0] = reg_date__d_year;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5d0dcd82c7f0aggr0__tmp_attr0[mat_idx5d0dcd82c7f0] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT5d0dcd85fc60;
cudaMalloc(&d_COUNT5d0dcd85fc60, sizeof(uint64_t));
cudaMemset(d_COUNT5d0dcd85fc60, 0, sizeof(uint64_t));
count_5d0dcd849740<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT5d0dcd85fc60, d_customer__c_city, customer_size);
uint64_t COUNT5d0dcd85fc60;
cudaMemcpy(&COUNT5d0dcd85fc60, d_COUNT5d0dcd85fc60, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5d0dcd85fc60;
cudaMalloc(&d_BUF_IDX_5d0dcd85fc60, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5d0dcd85fc60, 0, sizeof(uint64_t));
uint64_t* d_BUF_5d0dcd85fc60;
cudaMalloc(&d_BUF_5d0dcd85fc60, sizeof(uint64_t) * COUNT5d0dcd85fc60 * 1);
auto d_HT_5d0dcd85fc60 = cuco::experimental::static_multimap{ (int)COUNT5d0dcd85fc60*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5d0dcd849740<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_5d0dcd85fc60, d_BUF_IDX_5d0dcd85fc60, d_HT_5d0dcd85fc60.ref(cuco::insert), d_customer__c_city, d_customer__c_custkey, customer_size);
//Materialize count
uint64_t* d_COUNT5d0dcd8686e0;
cudaMalloc(&d_COUNT5d0dcd8686e0, sizeof(uint64_t));
cudaMemset(d_COUNT5d0dcd8686e0, 0, sizeof(uint64_t));
count_5d0dcd849ce0<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT5d0dcd8686e0, d_supplier__s_city, supplier_size);
uint64_t COUNT5d0dcd8686e0;
cudaMemcpy(&COUNT5d0dcd8686e0, d_COUNT5d0dcd8686e0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5d0dcd8686e0;
cudaMalloc(&d_BUF_IDX_5d0dcd8686e0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5d0dcd8686e0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5d0dcd8686e0;
cudaMalloc(&d_BUF_5d0dcd8686e0, sizeof(uint64_t) * COUNT5d0dcd8686e0 * 1);
auto d_HT_5d0dcd8686e0 = cuco::experimental::static_multimap{ (int)COUNT5d0dcd8686e0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5d0dcd849ce0<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_5d0dcd8686e0, d_BUF_IDX_5d0dcd8686e0, d_HT_5d0dcd8686e0.ref(cuco::insert), d_supplier__s_city, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT5d0dcd860aa0;
cudaMalloc(&d_COUNT5d0dcd860aa0, sizeof(uint64_t));
cudaMemset(d_COUNT5d0dcd860aa0, 0, sizeof(uint64_t));
count_5d0dcd875f00<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT5d0dcd860aa0, d_date__d_yearmonth, date_size);
uint64_t COUNT5d0dcd860aa0;
cudaMemcpy(&COUNT5d0dcd860aa0, d_COUNT5d0dcd860aa0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5d0dcd860aa0;
cudaMalloc(&d_BUF_IDX_5d0dcd860aa0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5d0dcd860aa0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5d0dcd860aa0;
cudaMalloc(&d_BUF_5d0dcd860aa0, sizeof(uint64_t) * COUNT5d0dcd860aa0 * 1);
auto d_HT_5d0dcd860aa0 = cuco::experimental::static_multimap{ (int)COUNT5d0dcd860aa0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5d0dcd875f00<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_5d0dcd860aa0, d_BUF_IDX_5d0dcd860aa0, d_HT_5d0dcd860aa0.ref(cuco::insert), d_date__d_datekey, d_date__d_yearmonth, date_size);
//Create aggregation hash table
auto d_HT_5d0dcd819160 = cuco::static_map{ (int)3*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5d0dcd867db0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5d0dcd85fc60, d_BUF_5d0dcd860aa0, d_BUF_5d0dcd8686e0, d_HT_5d0dcd819160.ref(cuco::insert), d_HT_5d0dcd85fc60.ref(cuco::for_each), d_HT_5d0dcd860aa0.ref(cuco::for_each), d_HT_5d0dcd8686e0.ref(cuco::for_each), d_customer__c_city_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_city_encoded);
size_t COUNT5d0dcd819160 = d_HT_5d0dcd819160.size();
thrust::device_vector<int64_t> keys_5d0dcd819160(COUNT5d0dcd819160), vals_5d0dcd819160(COUNT5d0dcd819160);
d_HT_5d0dcd819160.retrieve_all(keys_5d0dcd819160.begin(), vals_5d0dcd819160.begin());
d_HT_5d0dcd819160.clear();
int64_t* raw_keys5d0dcd819160 = thrust::raw_pointer_cast(keys_5d0dcd819160.data());
insertKeys<<<std::ceil((float)COUNT5d0dcd819160/128.), 128>>>(raw_keys5d0dcd819160, d_HT_5d0dcd819160.ref(cuco::insert), COUNT5d0dcd819160);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5d0dcd819160);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5d0dcd819160);
DBI16Type* d_KEY_5d0dcd819160customer__c_city_encoded;
cudaMalloc(&d_KEY_5d0dcd819160customer__c_city_encoded, sizeof(DBI16Type) * COUNT5d0dcd819160);
cudaMemset(d_KEY_5d0dcd819160customer__c_city_encoded, 0, sizeof(DBI16Type) * COUNT5d0dcd819160);
DBI16Type* d_KEY_5d0dcd819160supplier__s_city_encoded;
cudaMalloc(&d_KEY_5d0dcd819160supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5d0dcd819160);
cudaMemset(d_KEY_5d0dcd819160supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT5d0dcd819160);
DBI32Type* d_KEY_5d0dcd819160date__d_year;
cudaMalloc(&d_KEY_5d0dcd819160date__d_year, sizeof(DBI32Type) * COUNT5d0dcd819160);
cudaMemset(d_KEY_5d0dcd819160date__d_year, 0, sizeof(DBI32Type) * COUNT5d0dcd819160);
main_5d0dcd867db0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5d0dcd85fc60, d_BUF_5d0dcd860aa0, d_BUF_5d0dcd8686e0, d_HT_5d0dcd819160.ref(cuco::find), d_HT_5d0dcd85fc60.ref(cuco::for_each), d_HT_5d0dcd860aa0.ref(cuco::for_each), d_HT_5d0dcd8686e0.ref(cuco::for_each), d_KEY_5d0dcd819160customer__c_city_encoded, d_KEY_5d0dcd819160date__d_year, d_KEY_5d0dcd819160supplier__s_city_encoded, d_aggr0__tmp_attr0, d_customer__c_city_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_city_encoded);
//Materialize count
uint64_t* d_COUNT5d0dcd82c7f0;
cudaMalloc(&d_COUNT5d0dcd82c7f0, sizeof(uint64_t));
cudaMemset(d_COUNT5d0dcd82c7f0, 0, sizeof(uint64_t));
count_5d0dcd883400<<<std::ceil((float)COUNT5d0dcd819160/128.), 128>>>(COUNT5d0dcd819160, d_COUNT5d0dcd82c7f0);
uint64_t COUNT5d0dcd82c7f0;
cudaMemcpy(&COUNT5d0dcd82c7f0, d_COUNT5d0dcd82c7f0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5d0dcd82c7f0;
cudaMalloc(&d_MAT_IDX5d0dcd82c7f0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5d0dcd82c7f0, 0, sizeof(uint64_t));
auto MAT5d0dcd82c7f0customer__c_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5d0dcd82c7f0);
DBI16Type* d_MAT5d0dcd82c7f0customer__c_city_encoded;
cudaMalloc(&d_MAT5d0dcd82c7f0customer__c_city_encoded, sizeof(DBI16Type) * COUNT5d0dcd82c7f0);
auto MAT5d0dcd82c7f0supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5d0dcd82c7f0);
DBI16Type* d_MAT5d0dcd82c7f0supplier__s_city_encoded;
cudaMalloc(&d_MAT5d0dcd82c7f0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5d0dcd82c7f0);
auto MAT5d0dcd82c7f0date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5d0dcd82c7f0);
DBI32Type* d_MAT5d0dcd82c7f0date__d_year;
cudaMalloc(&d_MAT5d0dcd82c7f0date__d_year, sizeof(DBI32Type) * COUNT5d0dcd82c7f0);
auto MAT5d0dcd82c7f0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5d0dcd82c7f0);
DBDecimalType* d_MAT5d0dcd82c7f0aggr0__tmp_attr0;
cudaMalloc(&d_MAT5d0dcd82c7f0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5d0dcd82c7f0);
main_5d0dcd883400<<<std::ceil((float)COUNT5d0dcd819160/128.), 128>>>(COUNT5d0dcd819160, d_MAT5d0dcd82c7f0aggr0__tmp_attr0, d_MAT5d0dcd82c7f0customer__c_city_encoded, d_MAT5d0dcd82c7f0date__d_year, d_MAT5d0dcd82c7f0supplier__s_city_encoded, d_MAT_IDX5d0dcd82c7f0, d_aggr0__tmp_attr0, d_KEY_5d0dcd819160customer__c_city_encoded, d_KEY_5d0dcd819160date__d_year, d_KEY_5d0dcd819160supplier__s_city_encoded);
cudaMemcpy(MAT5d0dcd82c7f0customer__c_city_encoded, d_MAT5d0dcd82c7f0customer__c_city_encoded, sizeof(DBI16Type) * COUNT5d0dcd82c7f0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5d0dcd82c7f0supplier__s_city_encoded, d_MAT5d0dcd82c7f0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5d0dcd82c7f0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5d0dcd82c7f0date__d_year, d_MAT5d0dcd82c7f0date__d_year, sizeof(DBI32Type) * COUNT5d0dcd82c7f0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5d0dcd82c7f0aggr0__tmp_attr0, d_MAT5d0dcd82c7f0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5d0dcd82c7f0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5d0dcd82c7f0; i++) { std::cout << "" << customer__c_city_map[MAT5d0dcd82c7f0customer__c_city_encoded[i]];
std::cout << "," << supplier__s_city_map[MAT5d0dcd82c7f0supplier__s_city_encoded[i]];
std::cout << "," << MAT5d0dcd82c7f0date__d_year[i];
std::cout << "," << MAT5d0dcd82c7f0aggr0__tmp_attr0[i];
std::cout << std::endl; }
cudaFree(d_BUF_5d0dcd85fc60);
cudaFree(d_BUF_IDX_5d0dcd85fc60);
cudaFree(d_COUNT5d0dcd85fc60);
cudaFree(d_BUF_5d0dcd8686e0);
cudaFree(d_BUF_IDX_5d0dcd8686e0);
cudaFree(d_COUNT5d0dcd8686e0);
cudaFree(d_BUF_5d0dcd860aa0);
cudaFree(d_BUF_IDX_5d0dcd860aa0);
cudaFree(d_COUNT5d0dcd860aa0);
cudaFree(d_KEY_5d0dcd819160customer__c_city_encoded);
cudaFree(d_KEY_5d0dcd819160date__d_year);
cudaFree(d_KEY_5d0dcd819160supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5d0dcd82c7f0);
cudaFree(d_MAT5d0dcd82c7f0aggr0__tmp_attr0);
cudaFree(d_MAT5d0dcd82c7f0customer__c_city_encoded);
cudaFree(d_MAT5d0dcd82c7f0date__d_year);
cudaFree(d_MAT5d0dcd82c7f0supplier__s_city_encoded);
cudaFree(d_MAT_IDX5d0dcd82c7f0);
free(MAT5d0dcd82c7f0aggr0__tmp_attr0);
free(MAT5d0dcd82c7f0customer__c_city_encoded);
free(MAT5d0dcd82c7f0date__d_year);
free(MAT5d0dcd82c7f0supplier__s_city_encoded);
}