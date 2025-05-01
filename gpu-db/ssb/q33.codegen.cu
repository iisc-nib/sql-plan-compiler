#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5c44b26532e0(uint64_t* COUNT5c44b266cdd0, DBStringType* customer__c_city, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_city = customer__c_city[tid];
if (!((evaluatePredicate(reg_customer__c_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_customer__c_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5c44b266cdd0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5c44b26532e0(uint64_t* BUF_5c44b266cdd0, uint64_t* BUF_IDX_5c44b266cdd0, HASHTABLE_INSERT HT_5c44b266cdd0, DBStringType* customer__c_city, DBI32Type* customer__c_custkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_city = customer__c_city[tid];
if (!((evaluatePredicate(reg_customer__c_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_customer__c_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5c44b266cdd0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5c44b266cdd0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_5c44b266cdd0 = atomicAdd((int*)BUF_IDX_5c44b266cdd0, 1);
HT_5c44b266cdd0.insert(cuco::pair{KEY_5c44b266cdd0, buf_idx_5c44b266cdd0});
BUF_5c44b266cdd0[buf_idx_5c44b266cdd0 * 1 + 0] = tid;
}
__global__ void count_5c44b2653880(uint64_t* COUNT5c44b266cf80, DBStringType* supplier__s_city, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_city = supplier__s_city[tid];
if (!((evaluatePredicate(reg_supplier__s_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_supplier__s_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5c44b266cf80, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5c44b2653880(uint64_t* BUF_5c44b266cf80, uint64_t* BUF_IDX_5c44b266cf80, HASHTABLE_INSERT HT_5c44b266cf80, DBStringType* supplier__s_city, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_city = supplier__s_city[tid];
if (!((evaluatePredicate(reg_supplier__s_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_supplier__s_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5c44b266cf80 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5c44b266cf80 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5c44b266cf80 = atomicAdd((int*)BUF_IDX_5c44b266cf80, 1);
HT_5c44b266cf80.insert(cuco::pair{KEY_5c44b266cf80, buf_idx_5c44b266cf80});
BUF_5c44b266cf80[buf_idx_5c44b266cf80 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5c44b266f740(uint64_t* BUF_5c44b266cdd0, uint64_t* BUF_5c44b266cf80, uint64_t* COUNT5c44b266f130, HASHTABLE_PROBE HT_5c44b266cdd0, HASHTABLE_PROBE HT_5c44b266cf80, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5c44b266cdd0 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5c44b266cdd0 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_5c44b266cdd0.for_each(KEY_5c44b266cdd0, [&] __device__ (auto const SLOT_5c44b266cdd0) {

auto const [slot_first5c44b266cdd0, slot_second5c44b266cdd0] = SLOT_5c44b266cdd0;
if (!(true)) return;
uint64_t KEY_5c44b266cf80 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5c44b266cf80 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5c44b266cf80.for_each(KEY_5c44b266cf80, [&] __device__ (auto const SLOT_5c44b266cf80) {

auto const [slot_first5c44b266cf80, slot_second5c44b266cf80] = SLOT_5c44b266cf80;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5c44b266f130, 1);
});
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5c44b266f740(uint64_t* BUF_5c44b266cdd0, uint64_t* BUF_5c44b266cf80, uint64_t* BUF_5c44b266f130, uint64_t* BUF_IDX_5c44b266f130, HASHTABLE_PROBE HT_5c44b266cdd0, HASHTABLE_PROBE HT_5c44b266cf80, HASHTABLE_INSERT HT_5c44b266f130, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5c44b266cdd0 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5c44b266cdd0 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_5c44b266cdd0.for_each(KEY_5c44b266cdd0, [&] __device__ (auto const SLOT_5c44b266cdd0) {
auto const [slot_first5c44b266cdd0, slot_second5c44b266cdd0] = SLOT_5c44b266cdd0;
if (!(true)) return;
uint64_t KEY_5c44b266cf80 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5c44b266cf80 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5c44b266cf80.for_each(KEY_5c44b266cf80, [&] __device__ (auto const SLOT_5c44b266cf80) {
auto const [slot_first5c44b266cf80, slot_second5c44b266cf80] = SLOT_5c44b266cf80;
if (!(true)) return;
uint64_t KEY_5c44b266f130 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5c44b266f130 |= reg_lineorder__lo_orderdate;
// Insert hash table kernel;
auto buf_idx_5c44b266f130 = atomicAdd((int*)BUF_IDX_5c44b266f130, 1);
HT_5c44b266f130.insert(cuco::pair{KEY_5c44b266f130, buf_idx_5c44b266f130});
BUF_5c44b266f130[buf_idx_5c44b266f130 * 3 + 0] = BUF_5c44b266cdd0[slot_second5c44b266cdd0 * 1 + 0];
BUF_5c44b266f130[buf_idx_5c44b266f130 * 3 + 1] = tid;
BUF_5c44b266f130[buf_idx_5c44b266f130 * 3 + 2] = BUF_5c44b266cf80[slot_second5c44b266cf80 * 1 + 0];
});
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5c44b267ee90(uint64_t* BUF_5c44b266f130, HASHTABLE_INSERT HT_5c44b26236a0, HASHTABLE_PROBE HT_5c44b266f130, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5c44b266f130 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5c44b266f130 |= reg_date__d_datekey;
//Probe Hash table
HT_5c44b266f130.for_each(KEY_5c44b266f130, [&] __device__ (auto const SLOT_5c44b266f130) {

auto const [slot_first5c44b266f130, slot_second5c44b266f130] = SLOT_5c44b266f130;
if (!(true)) return;
uint64_t KEY_5c44b26236a0 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_5c44b266f130[slot_second5c44b266f130 * 3 + 0]];

KEY_5c44b26236a0 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_5c44b266f130[slot_second5c44b266f130 * 3 + 2]];
KEY_5c44b26236a0 <<= 16;
KEY_5c44b26236a0 |= reg_supplier__s_city_encoded;
KEY_5c44b26236a0 <<= 32;
KEY_5c44b26236a0 |= reg_date__d_year;
//Create aggregation hash table
HT_5c44b26236a0.insert(cuco::pair{KEY_5c44b26236a0, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5c44b267ee90(uint64_t* BUF_5c44b266f130, HASHTABLE_FIND HT_5c44b26236a0, HASHTABLE_PROBE HT_5c44b266f130, DBI16Type* KEY_5c44b26236a0customer__c_city_encoded, DBI32Type* KEY_5c44b26236a0date__d_year, DBI16Type* KEY_5c44b26236a0supplier__s_city_encoded, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size, DBDecimalType* lineorder__lo_revenue, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5c44b266f130 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5c44b266f130 |= reg_date__d_datekey;
//Probe Hash table
HT_5c44b266f130.for_each(KEY_5c44b266f130, [&] __device__ (auto const SLOT_5c44b266f130) {
auto const [slot_first5c44b266f130, slot_second5c44b266f130] = SLOT_5c44b266f130;
if (!(true)) return;
uint64_t KEY_5c44b26236a0 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_5c44b266f130[slot_second5c44b266f130 * 3 + 0]];

KEY_5c44b26236a0 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_5c44b266f130[slot_second5c44b266f130 * 3 + 2]];
KEY_5c44b26236a0 <<= 16;
KEY_5c44b26236a0 |= reg_supplier__s_city_encoded;
KEY_5c44b26236a0 <<= 32;
KEY_5c44b26236a0 |= reg_date__d_year;
//Aggregate in hashtable
auto buf_idx_5c44b26236a0 = HT_5c44b26236a0.find(KEY_5c44b26236a0)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[BUF_5c44b266f130[slot_second5c44b266f130 * 3 + 1]];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5c44b26236a0], reg_lineorder__lo_revenue);
KEY_5c44b26236a0customer__c_city_encoded[buf_idx_5c44b26236a0] = reg_customer__c_city_encoded;
KEY_5c44b26236a0supplier__s_city_encoded[buf_idx_5c44b26236a0] = reg_supplier__s_city_encoded;
KEY_5c44b26236a0date__d_year[buf_idx_5c44b26236a0] = reg_date__d_year;
});
}
__global__ void count_5c44b268dc50(size_t COUNT5c44b26236a0, uint64_t* COUNT5c44b2636790) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5c44b26236a0) return;
//Materialize count
atomicAdd((int*)COUNT5c44b2636790, 1);
}
__global__ void main_5c44b268dc50(size_t COUNT5c44b26236a0, DBDecimalType* MAT5c44b2636790aggr0__tmp_attr0, DBI16Type* MAT5c44b2636790customer__c_city_encoded, DBI32Type* MAT5c44b2636790date__d_year, DBI16Type* MAT5c44b2636790supplier__s_city_encoded, uint64_t* MAT_IDX5c44b2636790, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5c44b26236a0) return;
//Materialize buffers
auto mat_idx5c44b2636790 = atomicAdd((int*)MAT_IDX5c44b2636790, 1);
auto reg_customer__c_city_encoded = customer__c_city_encoded[tid];
MAT5c44b2636790customer__c_city_encoded[mat_idx5c44b2636790] = reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[tid];
MAT5c44b2636790supplier__s_city_encoded[mat_idx5c44b2636790] = reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[tid];
MAT5c44b2636790date__d_year[mat_idx5c44b2636790] = reg_date__d_year;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5c44b2636790aggr0__tmp_attr0[mat_idx5c44b2636790] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT5c44b266cdd0;
cudaMalloc(&d_COUNT5c44b266cdd0, sizeof(uint64_t));
cudaMemset(d_COUNT5c44b266cdd0, 0, sizeof(uint64_t));
count_5c44b26532e0<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT5c44b266cdd0, d_customer__c_city, customer_size);
uint64_t COUNT5c44b266cdd0;
cudaMemcpy(&COUNT5c44b266cdd0, d_COUNT5c44b266cdd0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5c44b266cdd0;
cudaMalloc(&d_BUF_IDX_5c44b266cdd0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5c44b266cdd0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5c44b266cdd0;
cudaMalloc(&d_BUF_5c44b266cdd0, sizeof(uint64_t) * COUNT5c44b266cdd0 * 1);
auto d_HT_5c44b266cdd0 = cuco::experimental::static_multimap{ (int)COUNT5c44b266cdd0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5c44b26532e0<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_5c44b266cdd0, d_BUF_IDX_5c44b266cdd0, d_HT_5c44b266cdd0.ref(cuco::insert), d_customer__c_city, d_customer__c_custkey, customer_size);
//Materialize count
uint64_t* d_COUNT5c44b266cf80;
cudaMalloc(&d_COUNT5c44b266cf80, sizeof(uint64_t));
cudaMemset(d_COUNT5c44b266cf80, 0, sizeof(uint64_t));
count_5c44b2653880<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT5c44b266cf80, d_supplier__s_city, supplier_size);
uint64_t COUNT5c44b266cf80;
cudaMemcpy(&COUNT5c44b266cf80, d_COUNT5c44b266cf80, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5c44b266cf80;
cudaMalloc(&d_BUF_IDX_5c44b266cf80, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5c44b266cf80, 0, sizeof(uint64_t));
uint64_t* d_BUF_5c44b266cf80;
cudaMalloc(&d_BUF_5c44b266cf80, sizeof(uint64_t) * COUNT5c44b266cf80 * 1);
auto d_HT_5c44b266cf80 = cuco::experimental::static_multimap{ (int)COUNT5c44b266cf80*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5c44b2653880<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_5c44b266cf80, d_BUF_IDX_5c44b266cf80, d_HT_5c44b266cf80.ref(cuco::insert), d_supplier__s_city, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT5c44b266f130;
cudaMalloc(&d_COUNT5c44b266f130, sizeof(uint64_t));
cudaMemset(d_COUNT5c44b266f130, 0, sizeof(uint64_t));
count_5c44b266f740<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5c44b266cdd0, d_BUF_5c44b266cf80, d_COUNT5c44b266f130, d_HT_5c44b266cdd0.ref(cuco::for_each), d_HT_5c44b266cf80.ref(cuco::for_each), d_lineorder__lo_custkey, d_lineorder__lo_suppkey, lineorder_size);
uint64_t COUNT5c44b266f130;
cudaMemcpy(&COUNT5c44b266f130, d_COUNT5c44b266f130, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5c44b266f130;
cudaMalloc(&d_BUF_IDX_5c44b266f130, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5c44b266f130, 0, sizeof(uint64_t));
uint64_t* d_BUF_5c44b266f130;
cudaMalloc(&d_BUF_5c44b266f130, sizeof(uint64_t) * COUNT5c44b266f130 * 3);
auto d_HT_5c44b266f130 = cuco::experimental::static_multimap{ (int)COUNT5c44b266f130*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5c44b266f740<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5c44b266cdd0, d_BUF_5c44b266cf80, d_BUF_5c44b266f130, d_BUF_IDX_5c44b266f130, d_HT_5c44b266cdd0.ref(cuco::for_each), d_HT_5c44b266cf80.ref(cuco::for_each), d_HT_5c44b266f130.ref(cuco::insert), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size);
//Create aggregation hash table
auto d_HT_5c44b26236a0 = cuco::static_map{ (int)132*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5c44b267ee90<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_5c44b266f130, d_HT_5c44b26236a0.ref(cuco::insert), d_HT_5c44b266f130.ref(cuco::for_each), d_customer__c_city_encoded, d_date__d_datekey, d_date__d_year, date_size, d_supplier__s_city_encoded);
size_t COUNT5c44b26236a0 = d_HT_5c44b26236a0.size();
thrust::device_vector<int64_t> keys_5c44b26236a0(COUNT5c44b26236a0), vals_5c44b26236a0(COUNT5c44b26236a0);
d_HT_5c44b26236a0.retrieve_all(keys_5c44b26236a0.begin(), vals_5c44b26236a0.begin());
d_HT_5c44b26236a0.clear();
int64_t* raw_keys5c44b26236a0 = thrust::raw_pointer_cast(keys_5c44b26236a0.data());
insertKeys<<<std::ceil((float)COUNT5c44b26236a0/128.), 128>>>(raw_keys5c44b26236a0, d_HT_5c44b26236a0.ref(cuco::insert), COUNT5c44b26236a0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5c44b26236a0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5c44b26236a0);
DBI16Type* d_KEY_5c44b26236a0customer__c_city_encoded;
cudaMalloc(&d_KEY_5c44b26236a0customer__c_city_encoded, sizeof(DBI16Type) * COUNT5c44b26236a0);
cudaMemset(d_KEY_5c44b26236a0customer__c_city_encoded, 0, sizeof(DBI16Type) * COUNT5c44b26236a0);
DBI16Type* d_KEY_5c44b26236a0supplier__s_city_encoded;
cudaMalloc(&d_KEY_5c44b26236a0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5c44b26236a0);
cudaMemset(d_KEY_5c44b26236a0supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT5c44b26236a0);
DBI32Type* d_KEY_5c44b26236a0date__d_year;
cudaMalloc(&d_KEY_5c44b26236a0date__d_year, sizeof(DBI32Type) * COUNT5c44b26236a0);
cudaMemset(d_KEY_5c44b26236a0date__d_year, 0, sizeof(DBI32Type) * COUNT5c44b26236a0);
main_5c44b267ee90<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_5c44b266f130, d_HT_5c44b26236a0.ref(cuco::find), d_HT_5c44b266f130.ref(cuco::for_each), d_KEY_5c44b26236a0customer__c_city_encoded, d_KEY_5c44b26236a0date__d_year, d_KEY_5c44b26236a0supplier__s_city_encoded, d_aggr0__tmp_attr0, d_customer__c_city_encoded, d_date__d_datekey, d_date__d_year, date_size, d_lineorder__lo_revenue, d_supplier__s_city_encoded);
//Materialize count
uint64_t* d_COUNT5c44b2636790;
cudaMalloc(&d_COUNT5c44b2636790, sizeof(uint64_t));
cudaMemset(d_COUNT5c44b2636790, 0, sizeof(uint64_t));
count_5c44b268dc50<<<std::ceil((float)COUNT5c44b26236a0/128.), 128>>>(COUNT5c44b26236a0, d_COUNT5c44b2636790);
uint64_t COUNT5c44b2636790;
cudaMemcpy(&COUNT5c44b2636790, d_COUNT5c44b2636790, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5c44b2636790;
cudaMalloc(&d_MAT_IDX5c44b2636790, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5c44b2636790, 0, sizeof(uint64_t));
auto MAT5c44b2636790customer__c_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5c44b2636790);
DBI16Type* d_MAT5c44b2636790customer__c_city_encoded;
cudaMalloc(&d_MAT5c44b2636790customer__c_city_encoded, sizeof(DBI16Type) * COUNT5c44b2636790);
auto MAT5c44b2636790supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5c44b2636790);
DBI16Type* d_MAT5c44b2636790supplier__s_city_encoded;
cudaMalloc(&d_MAT5c44b2636790supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5c44b2636790);
auto MAT5c44b2636790date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5c44b2636790);
DBI32Type* d_MAT5c44b2636790date__d_year;
cudaMalloc(&d_MAT5c44b2636790date__d_year, sizeof(DBI32Type) * COUNT5c44b2636790);
auto MAT5c44b2636790aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5c44b2636790);
DBDecimalType* d_MAT5c44b2636790aggr0__tmp_attr0;
cudaMalloc(&d_MAT5c44b2636790aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5c44b2636790);
main_5c44b268dc50<<<std::ceil((float)COUNT5c44b26236a0/128.), 128>>>(COUNT5c44b26236a0, d_MAT5c44b2636790aggr0__tmp_attr0, d_MAT5c44b2636790customer__c_city_encoded, d_MAT5c44b2636790date__d_year, d_MAT5c44b2636790supplier__s_city_encoded, d_MAT_IDX5c44b2636790, d_aggr0__tmp_attr0, d_KEY_5c44b26236a0customer__c_city_encoded, d_KEY_5c44b26236a0date__d_year, d_KEY_5c44b26236a0supplier__s_city_encoded);
cudaMemcpy(MAT5c44b2636790customer__c_city_encoded, d_MAT5c44b2636790customer__c_city_encoded, sizeof(DBI16Type) * COUNT5c44b2636790, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5c44b2636790supplier__s_city_encoded, d_MAT5c44b2636790supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5c44b2636790, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5c44b2636790date__d_year, d_MAT5c44b2636790date__d_year, sizeof(DBI32Type) * COUNT5c44b2636790, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5c44b2636790aggr0__tmp_attr0, d_MAT5c44b2636790aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5c44b2636790, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5c44b2636790; i++) { std::cout << "" << customer__c_city_map[MAT5c44b2636790customer__c_city_encoded[i]];
std::cout << "," << supplier__s_city_map[MAT5c44b2636790supplier__s_city_encoded[i]];
std::cout << "," << MAT5c44b2636790date__d_year[i];
std::cout << "," << MAT5c44b2636790aggr0__tmp_attr0[i];
std::cout << std::endl; }
cudaFree(d_BUF_5c44b266cdd0);
cudaFree(d_BUF_IDX_5c44b266cdd0);
cudaFree(d_COUNT5c44b266cdd0);
cudaFree(d_BUF_5c44b266cf80);
cudaFree(d_BUF_IDX_5c44b266cf80);
cudaFree(d_COUNT5c44b266cf80);
cudaFree(d_BUF_5c44b266f130);
cudaFree(d_BUF_IDX_5c44b266f130);
cudaFree(d_COUNT5c44b266f130);
cudaFree(d_KEY_5c44b26236a0customer__c_city_encoded);
cudaFree(d_KEY_5c44b26236a0date__d_year);
cudaFree(d_KEY_5c44b26236a0supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5c44b2636790);
cudaFree(d_MAT5c44b2636790aggr0__tmp_attr0);
cudaFree(d_MAT5c44b2636790customer__c_city_encoded);
cudaFree(d_MAT5c44b2636790date__d_year);
cudaFree(d_MAT5c44b2636790supplier__s_city_encoded);
cudaFree(d_MAT_IDX5c44b2636790);
free(MAT5c44b2636790aggr0__tmp_attr0);
free(MAT5c44b2636790customer__c_city_encoded);
free(MAT5c44b2636790date__d_year);
free(MAT5c44b2636790supplier__s_city_encoded);
}