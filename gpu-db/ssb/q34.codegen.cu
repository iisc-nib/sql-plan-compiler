#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_6487e32e9610(uint64_t* COUNT6487e32ffd80, DBStringType* customer__c_city, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_city = customer__c_city[tid];
if (!((evaluatePredicate(reg_customer__c_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_customer__c_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT6487e32ffd80, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_6487e32e9610(uint64_t* BUF_6487e32ffd80, uint64_t* BUF_IDX_6487e32ffd80, HASHTABLE_INSERT HT_6487e32ffd80, DBStringType* customer__c_city, DBI32Type* customer__c_custkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_city = customer__c_city[tid];
if (!((evaluatePredicate(reg_customer__c_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_customer__c_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_6487e32ffd80 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_6487e32ffd80 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_6487e32ffd80 = atomicAdd((int*)BUF_IDX_6487e32ffd80, 1);
HT_6487e32ffd80.insert(cuco::pair{KEY_6487e32ffd80, buf_idx_6487e32ffd80});
BUF_6487e32ffd80[buf_idx_6487e32ffd80 * 1 + 0] = tid;
}
__global__ void count_6487e32e9bb0(uint64_t* COUNT6487e3303f30, DBStringType* supplier__s_city, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_city = supplier__s_city[tid];
if (!((evaluatePredicate(reg_supplier__s_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_supplier__s_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT6487e3303f30, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_6487e32e9bb0(uint64_t* BUF_6487e3303f30, uint64_t* BUF_IDX_6487e3303f30, HASHTABLE_INSERT HT_6487e3303f30, DBStringType* supplier__s_city, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_city = supplier__s_city[tid];
if (!((evaluatePredicate(reg_supplier__s_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_supplier__s_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_6487e3303f30 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_6487e3303f30 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_6487e3303f30 = atomicAdd((int*)BUF_IDX_6487e3303f30, 1);
HT_6487e3303f30.insert(cuco::pair{KEY_6487e3303f30, buf_idx_6487e3303f30});
BUF_6487e3303f30[buf_idx_6487e3303f30 * 1 + 0] = tid;
}
__global__ void count_6487e3315010(uint64_t* COUNT6487e32ffe40, DBStringType* date__d_yearmonth, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_yearmonth = date__d_yearmonth[tid];
if (!(evaluatePredicate(reg_date__d_yearmonth, "Dec1997", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT6487e32ffe40, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_6487e3315010(uint64_t* BUF_6487e32ffe40, uint64_t* BUF_IDX_6487e32ffe40, HASHTABLE_INSERT HT_6487e32ffe40, DBI32Type* date__d_datekey, DBStringType* date__d_yearmonth, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_yearmonth = date__d_yearmonth[tid];
if (!(evaluatePredicate(reg_date__d_yearmonth, "Dec1997", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_6487e32ffe40 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_6487e32ffe40 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_6487e32ffe40 = atomicAdd((int*)BUF_IDX_6487e32ffe40, 1);
HT_6487e32ffe40.insert(cuco::pair{KEY_6487e32ffe40, buf_idx_6487e32ffe40});
BUF_6487e32ffe40[buf_idx_6487e32ffe40 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_6487e33029e0(uint64_t* BUF_6487e32ffd80, uint64_t* BUF_6487e32ffe40, uint64_t* BUF_6487e3303f30, HASHTABLE_INSERT HT_6487e32b9de0, HASHTABLE_PROBE HT_6487e32ffd80, HASHTABLE_PROBE HT_6487e32ffe40, HASHTABLE_PROBE HT_6487e3303f30, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_6487e32ffd80 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_6487e32ffd80 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_6487e32ffd80.for_each(KEY_6487e32ffd80, [&] __device__ (auto const SLOT_6487e32ffd80) {

auto const [slot_first6487e32ffd80, slot_second6487e32ffd80] = SLOT_6487e32ffd80;
if (!(true)) return;
uint64_t KEY_6487e3303f30 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_6487e3303f30 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_6487e3303f30.for_each(KEY_6487e3303f30, [&] __device__ (auto const SLOT_6487e3303f30) {

auto const [slot_first6487e3303f30, slot_second6487e3303f30] = SLOT_6487e3303f30;
if (!(true)) return;
uint64_t KEY_6487e32ffe40 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_6487e32ffe40 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_6487e32ffe40.for_each(KEY_6487e32ffe40, [&] __device__ (auto const SLOT_6487e32ffe40) {

auto const [slot_first6487e32ffe40, slot_second6487e32ffe40] = SLOT_6487e32ffe40;
if (!(true)) return;
uint64_t KEY_6487e32b9de0 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_6487e32ffd80[slot_second6487e32ffd80 * 1 + 0]];

KEY_6487e32b9de0 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_6487e3303f30[slot_second6487e3303f30 * 1 + 0]];
KEY_6487e32b9de0 <<= 16;
KEY_6487e32b9de0 |= reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[BUF_6487e32ffe40[slot_second6487e32ffe40 * 1 + 0]];
KEY_6487e32b9de0 <<= 32;
KEY_6487e32b9de0 |= reg_date__d_year;
//Create aggregation hash table
HT_6487e32b9de0.insert(cuco::pair{KEY_6487e32b9de0, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_6487e33029e0(uint64_t* BUF_6487e32ffd80, uint64_t* BUF_6487e32ffe40, uint64_t* BUF_6487e3303f30, HASHTABLE_FIND HT_6487e32b9de0, HASHTABLE_PROBE HT_6487e32ffd80, HASHTABLE_PROBE HT_6487e32ffe40, HASHTABLE_PROBE HT_6487e3303f30, DBI16Type* KEY_6487e32b9de0customer__c_city_encoded, DBI32Type* KEY_6487e32b9de0date__d_year, DBI16Type* KEY_6487e32b9de0supplier__s_city_encoded, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_6487e32ffd80 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_6487e32ffd80 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_6487e32ffd80.for_each(KEY_6487e32ffd80, [&] __device__ (auto const SLOT_6487e32ffd80) {
auto const [slot_first6487e32ffd80, slot_second6487e32ffd80] = SLOT_6487e32ffd80;
if (!(true)) return;
uint64_t KEY_6487e3303f30 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_6487e3303f30 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_6487e3303f30.for_each(KEY_6487e3303f30, [&] __device__ (auto const SLOT_6487e3303f30) {
auto const [slot_first6487e3303f30, slot_second6487e3303f30] = SLOT_6487e3303f30;
if (!(true)) return;
uint64_t KEY_6487e32ffe40 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_6487e32ffe40 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_6487e32ffe40.for_each(KEY_6487e32ffe40, [&] __device__ (auto const SLOT_6487e32ffe40) {
auto const [slot_first6487e32ffe40, slot_second6487e32ffe40] = SLOT_6487e32ffe40;
if (!(true)) return;
uint64_t KEY_6487e32b9de0 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_6487e32ffd80[slot_second6487e32ffd80 * 1 + 0]];

KEY_6487e32b9de0 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_6487e3303f30[slot_second6487e3303f30 * 1 + 0]];
KEY_6487e32b9de0 <<= 16;
KEY_6487e32b9de0 |= reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[BUF_6487e32ffe40[slot_second6487e32ffe40 * 1 + 0]];
KEY_6487e32b9de0 <<= 32;
KEY_6487e32b9de0 |= reg_date__d_year;
//Aggregate in hashtable
auto buf_idx_6487e32b9de0 = HT_6487e32b9de0.find(KEY_6487e32b9de0)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_6487e32b9de0], reg_lineorder__lo_revenue);
KEY_6487e32b9de0customer__c_city_encoded[buf_idx_6487e32b9de0] = reg_customer__c_city_encoded;
KEY_6487e32b9de0supplier__s_city_encoded[buf_idx_6487e32b9de0] = reg_supplier__s_city_encoded;
KEY_6487e32b9de0date__d_year[buf_idx_6487e32b9de0] = reg_date__d_year;
});
});
});
}
__global__ void count_6487e3322050(size_t COUNT6487e32b9de0, uint64_t* COUNT6487e32ccf90) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT6487e32b9de0) return;
//Materialize count
atomicAdd((int*)COUNT6487e32ccf90, 1);
}
__global__ void main_6487e3322050(size_t COUNT6487e32b9de0, DBDecimalType* MAT6487e32ccf90aggr0__tmp_attr0, DBI16Type* MAT6487e32ccf90customer__c_city_encoded, DBI32Type* MAT6487e32ccf90date__d_year, DBI16Type* MAT6487e32ccf90supplier__s_city_encoded, uint64_t* MAT_IDX6487e32ccf90, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT6487e32b9de0) return;
//Materialize buffers
auto mat_idx6487e32ccf90 = atomicAdd((int*)MAT_IDX6487e32ccf90, 1);
auto reg_customer__c_city_encoded = customer__c_city_encoded[tid];
MAT6487e32ccf90customer__c_city_encoded[mat_idx6487e32ccf90] = reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[tid];
MAT6487e32ccf90supplier__s_city_encoded[mat_idx6487e32ccf90] = reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[tid];
MAT6487e32ccf90date__d_year[mat_idx6487e32ccf90] = reg_date__d_year;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT6487e32ccf90aggr0__tmp_attr0[mat_idx6487e32ccf90] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map) {
//Materialize count
uint64_t* d_COUNT6487e32ffd80;
cudaMalloc(&d_COUNT6487e32ffd80, sizeof(uint64_t));
cudaMemset(d_COUNT6487e32ffd80, 0, sizeof(uint64_t));
count_6487e32e9610<<<std::ceil((float)customer_size/32.), 32>>>(d_COUNT6487e32ffd80, d_customer__c_city, customer_size);
uint64_t COUNT6487e32ffd80;
cudaMemcpy(&COUNT6487e32ffd80, d_COUNT6487e32ffd80, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_6487e32ffd80;
cudaMalloc(&d_BUF_IDX_6487e32ffd80, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6487e32ffd80, 0, sizeof(uint64_t));
uint64_t* d_BUF_6487e32ffd80;
cudaMalloc(&d_BUF_6487e32ffd80, sizeof(uint64_t) * COUNT6487e32ffd80 * 1);
auto d_HT_6487e32ffd80 = cuco::experimental::static_multimap{ (int)COUNT6487e32ffd80*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6487e32e9610<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_6487e32ffd80, d_BUF_IDX_6487e32ffd80, d_HT_6487e32ffd80.ref(cuco::insert), d_customer__c_city, d_customer__c_custkey, customer_size);
//Materialize count
uint64_t* d_COUNT6487e3303f30;
cudaMalloc(&d_COUNT6487e3303f30, sizeof(uint64_t));
cudaMemset(d_COUNT6487e3303f30, 0, sizeof(uint64_t));
count_6487e32e9bb0<<<std::ceil((float)supplier_size/32.), 32>>>(d_COUNT6487e3303f30, d_supplier__s_city, supplier_size);
uint64_t COUNT6487e3303f30;
cudaMemcpy(&COUNT6487e3303f30, d_COUNT6487e3303f30, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_6487e3303f30;
cudaMalloc(&d_BUF_IDX_6487e3303f30, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6487e3303f30, 0, sizeof(uint64_t));
uint64_t* d_BUF_6487e3303f30;
cudaMalloc(&d_BUF_6487e3303f30, sizeof(uint64_t) * COUNT6487e3303f30 * 1);
auto d_HT_6487e3303f30 = cuco::experimental::static_multimap{ (int)COUNT6487e3303f30*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6487e32e9bb0<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_6487e3303f30, d_BUF_IDX_6487e3303f30, d_HT_6487e3303f30.ref(cuco::insert), d_supplier__s_city, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT6487e32ffe40;
cudaMalloc(&d_COUNT6487e32ffe40, sizeof(uint64_t));
cudaMemset(d_COUNT6487e32ffe40, 0, sizeof(uint64_t));
count_6487e3315010<<<std::ceil((float)date_size/32.), 32>>>(d_COUNT6487e32ffe40, d_date__d_yearmonth, date_size);
uint64_t COUNT6487e32ffe40;
cudaMemcpy(&COUNT6487e32ffe40, d_COUNT6487e32ffe40, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_6487e32ffe40;
cudaMalloc(&d_BUF_IDX_6487e32ffe40, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6487e32ffe40, 0, sizeof(uint64_t));
uint64_t* d_BUF_6487e32ffe40;
cudaMalloc(&d_BUF_6487e32ffe40, sizeof(uint64_t) * COUNT6487e32ffe40 * 1);
auto d_HT_6487e32ffe40 = cuco::experimental::static_multimap{ (int)COUNT6487e32ffe40*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_6487e3315010<<<std::ceil((float)date_size/32.), 32>>>(d_BUF_6487e32ffe40, d_BUF_IDX_6487e32ffe40, d_HT_6487e32ffe40.ref(cuco::insert), d_date__d_datekey, d_date__d_yearmonth, date_size);
//Create aggregation hash table
auto d_HT_6487e32b9de0 = cuco::static_map{ (int)3*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_6487e33029e0<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_6487e32ffd80, d_BUF_6487e32ffe40, d_BUF_6487e3303f30, d_HT_6487e32b9de0.ref(cuco::insert), d_HT_6487e32ffd80.ref(cuco::for_each), d_HT_6487e32ffe40.ref(cuco::for_each), d_HT_6487e3303f30.ref(cuco::for_each), d_customer__c_city_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_city_encoded);
size_t COUNT6487e32b9de0 = d_HT_6487e32b9de0.size();
thrust::device_vector<int64_t> keys_6487e32b9de0(COUNT6487e32b9de0), vals_6487e32b9de0(COUNT6487e32b9de0);
d_HT_6487e32b9de0.retrieve_all(keys_6487e32b9de0.begin(), vals_6487e32b9de0.begin());
d_HT_6487e32b9de0.clear();
int64_t* raw_keys6487e32b9de0 = thrust::raw_pointer_cast(keys_6487e32b9de0.data());
insertKeys<<<std::ceil((float)COUNT6487e32b9de0/32.), 32>>>(raw_keys6487e32b9de0, d_HT_6487e32b9de0.ref(cuco::insert), COUNT6487e32b9de0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6487e32b9de0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT6487e32b9de0);
DBI16Type* d_KEY_6487e32b9de0customer__c_city_encoded;
cudaMalloc(&d_KEY_6487e32b9de0customer__c_city_encoded, sizeof(DBI16Type) * COUNT6487e32b9de0);
cudaMemset(d_KEY_6487e32b9de0customer__c_city_encoded, 0, sizeof(DBI16Type) * COUNT6487e32b9de0);
DBI16Type* d_KEY_6487e32b9de0supplier__s_city_encoded;
cudaMalloc(&d_KEY_6487e32b9de0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT6487e32b9de0);
cudaMemset(d_KEY_6487e32b9de0supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT6487e32b9de0);
DBI32Type* d_KEY_6487e32b9de0date__d_year;
cudaMalloc(&d_KEY_6487e32b9de0date__d_year, sizeof(DBI32Type) * COUNT6487e32b9de0);
cudaMemset(d_KEY_6487e32b9de0date__d_year, 0, sizeof(DBI32Type) * COUNT6487e32b9de0);
main_6487e33029e0<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_6487e32ffd80, d_BUF_6487e32ffe40, d_BUF_6487e3303f30, d_HT_6487e32b9de0.ref(cuco::find), d_HT_6487e32ffd80.ref(cuco::for_each), d_HT_6487e32ffe40.ref(cuco::for_each), d_HT_6487e3303f30.ref(cuco::for_each), d_KEY_6487e32b9de0customer__c_city_encoded, d_KEY_6487e32b9de0date__d_year, d_KEY_6487e32b9de0supplier__s_city_encoded, d_aggr0__tmp_attr0, d_customer__c_city_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_city_encoded);
//Materialize count
uint64_t* d_COUNT6487e32ccf90;
cudaMalloc(&d_COUNT6487e32ccf90, sizeof(uint64_t));
cudaMemset(d_COUNT6487e32ccf90, 0, sizeof(uint64_t));
count_6487e3322050<<<std::ceil((float)COUNT6487e32b9de0/32.), 32>>>(COUNT6487e32b9de0, d_COUNT6487e32ccf90);
uint64_t COUNT6487e32ccf90;
cudaMemcpy(&COUNT6487e32ccf90, d_COUNT6487e32ccf90, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX6487e32ccf90;
cudaMalloc(&d_MAT_IDX6487e32ccf90, sizeof(uint64_t));
cudaMemset(d_MAT_IDX6487e32ccf90, 0, sizeof(uint64_t));
auto MAT6487e32ccf90customer__c_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT6487e32ccf90);
DBI16Type* d_MAT6487e32ccf90customer__c_city_encoded;
cudaMalloc(&d_MAT6487e32ccf90customer__c_city_encoded, sizeof(DBI16Type) * COUNT6487e32ccf90);
auto MAT6487e32ccf90supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT6487e32ccf90);
DBI16Type* d_MAT6487e32ccf90supplier__s_city_encoded;
cudaMalloc(&d_MAT6487e32ccf90supplier__s_city_encoded, sizeof(DBI16Type) * COUNT6487e32ccf90);
auto MAT6487e32ccf90date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT6487e32ccf90);
DBI32Type* d_MAT6487e32ccf90date__d_year;
cudaMalloc(&d_MAT6487e32ccf90date__d_year, sizeof(DBI32Type) * COUNT6487e32ccf90);
auto MAT6487e32ccf90aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT6487e32ccf90);
DBDecimalType* d_MAT6487e32ccf90aggr0__tmp_attr0;
cudaMalloc(&d_MAT6487e32ccf90aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6487e32ccf90);
main_6487e3322050<<<std::ceil((float)COUNT6487e32b9de0/32.), 32>>>(COUNT6487e32b9de0, d_MAT6487e32ccf90aggr0__tmp_attr0, d_MAT6487e32ccf90customer__c_city_encoded, d_MAT6487e32ccf90date__d_year, d_MAT6487e32ccf90supplier__s_city_encoded, d_MAT_IDX6487e32ccf90, d_aggr0__tmp_attr0, d_KEY_6487e32b9de0customer__c_city_encoded, d_KEY_6487e32b9de0date__d_year, d_KEY_6487e32b9de0supplier__s_city_encoded);
cudaMemcpy(MAT6487e32ccf90customer__c_city_encoded, d_MAT6487e32ccf90customer__c_city_encoded, sizeof(DBI16Type) * COUNT6487e32ccf90, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT6487e32ccf90supplier__s_city_encoded, d_MAT6487e32ccf90supplier__s_city_encoded, sizeof(DBI16Type) * COUNT6487e32ccf90, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT6487e32ccf90date__d_year, d_MAT6487e32ccf90date__d_year, sizeof(DBI32Type) * COUNT6487e32ccf90, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT6487e32ccf90aggr0__tmp_attr0, d_MAT6487e32ccf90aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6487e32ccf90, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT6487e32ccf90; i++) { std::cout << customer__c_city_map[MAT6487e32ccf90customer__c_city_encoded[i]] << "\t";
std::cout << supplier__s_city_map[MAT6487e32ccf90supplier__s_city_encoded[i]] << "\t";
std::cout << MAT6487e32ccf90date__d_year[i] << "\t";
std::cout << MAT6487e32ccf90aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_6487e32ffd80);
cudaFree(d_BUF_IDX_6487e32ffd80);
cudaFree(d_COUNT6487e32ffd80);
cudaFree(d_BUF_6487e3303f30);
cudaFree(d_BUF_IDX_6487e3303f30);
cudaFree(d_COUNT6487e3303f30);
cudaFree(d_BUF_6487e32ffe40);
cudaFree(d_BUF_IDX_6487e32ffe40);
cudaFree(d_COUNT6487e32ffe40);
cudaFree(d_KEY_6487e32b9de0customer__c_city_encoded);
cudaFree(d_KEY_6487e32b9de0date__d_year);
cudaFree(d_KEY_6487e32b9de0supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT6487e32ccf90);
cudaFree(d_MAT6487e32ccf90aggr0__tmp_attr0);
cudaFree(d_MAT6487e32ccf90customer__c_city_encoded);
cudaFree(d_MAT6487e32ccf90date__d_year);
cudaFree(d_MAT6487e32ccf90supplier__s_city_encoded);
cudaFree(d_MAT_IDX6487e32ccf90);
free(MAT6487e32ccf90aggr0__tmp_attr0);
free(MAT6487e32ccf90customer__c_city_encoded);
free(MAT6487e32ccf90date__d_year);
free(MAT6487e32ccf90supplier__s_city_encoded);
}