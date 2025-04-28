#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_616d1c136480(uint64_t* COUNT616d1c12c6b0, DBStringType* supplier__s_nation, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_nation = supplier__s_nation[tid];
if (!(evaluatePredicate(reg_supplier__s_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT616d1c12c6b0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_616d1c136480(uint64_t* BUF_616d1c12c6b0, uint64_t* BUF_IDX_616d1c12c6b0, HASHTABLE_INSERT HT_616d1c12c6b0, DBStringType* supplier__s_nation, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_nation = supplier__s_nation[tid];
if (!(evaluatePredicate(reg_supplier__s_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_616d1c12c6b0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_616d1c12c6b0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_616d1c12c6b0 = atomicAdd((int*)BUF_IDX_616d1c12c6b0, 1);
HT_616d1c12c6b0.insert(cuco::pair{KEY_616d1c12c6b0, buf_idx_616d1c12c6b0});
BUF_616d1c12c6b0[buf_idx_616d1c12c6b0 * 1 + 0] = tid;
}
__global__ void count_616d1c10f1a0(uint64_t* COUNT616d1c12d0d0, DBStringType* customer__c_nation, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_nation = customer__c_nation[tid];
if (!(evaluatePredicate(reg_customer__c_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT616d1c12d0d0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_616d1c10f1a0(uint64_t* BUF_616d1c12d0d0, uint64_t* BUF_IDX_616d1c12d0d0, HASHTABLE_INSERT HT_616d1c12d0d0, DBI32Type* customer__c_custkey, DBStringType* customer__c_nation, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_nation = customer__c_nation[tid];
if (!(evaluatePredicate(reg_customer__c_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_616d1c12d0d0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_616d1c12d0d0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_616d1c12d0d0 = atomicAdd((int*)BUF_IDX_616d1c12d0d0, 1);
HT_616d1c12d0d0.insert(cuco::pair{KEY_616d1c12d0d0, buf_idx_616d1c12d0d0});
BUF_616d1c12d0d0[buf_idx_616d1c12d0d0 * 1 + 0] = tid;
}
__global__ void count_616d1c13f370(uint64_t* COUNT616d1c12d190, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT616d1c12d190, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_616d1c13f370(uint64_t* BUF_616d1c12d190, uint64_t* BUF_IDX_616d1c12d190, HASHTABLE_INSERT HT_616d1c12d190, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_616d1c12d190 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_616d1c12d190 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_616d1c12d190 = atomicAdd((int*)BUF_IDX_616d1c12d190, 1);
HT_616d1c12d190.insert(cuco::pair{KEY_616d1c12d190, buf_idx_616d1c12d190});
BUF_616d1c12d190[buf_idx_616d1c12d190 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_616d1c10f740(uint64_t* BUF_616d1c12c6b0, uint64_t* BUF_616d1c12d0d0, uint64_t* BUF_616d1c12d190, HASHTABLE_INSERT HT_616d1c0df300, HASHTABLE_PROBE HT_616d1c12c6b0, HASHTABLE_PROBE HT_616d1c12d0d0, HASHTABLE_PROBE HT_616d1c12d190, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_616d1c12c6b0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_616d1c12c6b0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_616d1c12c6b0.for_each(KEY_616d1c12c6b0, [&] __device__ (auto const SLOT_616d1c12c6b0) {

auto const [slot_first616d1c12c6b0, slot_second616d1c12c6b0] = SLOT_616d1c12c6b0;
if (!(true)) return;
uint64_t KEY_616d1c12d0d0 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_616d1c12d0d0 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_616d1c12d0d0.for_each(KEY_616d1c12d0d0, [&] __device__ (auto const SLOT_616d1c12d0d0) {

auto const [slot_first616d1c12d0d0, slot_second616d1c12d0d0] = SLOT_616d1c12d0d0;
if (!(true)) return;
uint64_t KEY_616d1c12d190 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_616d1c12d190 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_616d1c12d190.for_each(KEY_616d1c12d190, [&] __device__ (auto const SLOT_616d1c12d190) {

auto const [slot_first616d1c12d190, slot_second616d1c12d190] = SLOT_616d1c12d190;
if (!(true)) return;
uint64_t KEY_616d1c0df300 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_616d1c12d0d0[slot_second616d1c12d0d0 * 1 + 0]];

KEY_616d1c0df300 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_616d1c12c6b0[slot_second616d1c12c6b0 * 1 + 0]];
KEY_616d1c0df300 <<= 16;
KEY_616d1c0df300 |= reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[BUF_616d1c12d190[slot_second616d1c12d190 * 1 + 0]];
KEY_616d1c0df300 <<= 32;
KEY_616d1c0df300 |= reg_date__d_year;
//Create aggregation hash table
HT_616d1c0df300.insert(cuco::pair{KEY_616d1c0df300, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_616d1c10f740(uint64_t* BUF_616d1c12c6b0, uint64_t* BUF_616d1c12d0d0, uint64_t* BUF_616d1c12d190, HASHTABLE_FIND HT_616d1c0df300, HASHTABLE_PROBE HT_616d1c12c6b0, HASHTABLE_PROBE HT_616d1c12d0d0, HASHTABLE_PROBE HT_616d1c12d190, DBI16Type* KEY_616d1c0df300customer__c_city_encoded, DBI32Type* KEY_616d1c0df300date__d_year, DBI16Type* KEY_616d1c0df300supplier__s_city_encoded, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_616d1c12c6b0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_616d1c12c6b0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_616d1c12c6b0.for_each(KEY_616d1c12c6b0, [&] __device__ (auto const SLOT_616d1c12c6b0) {
auto const [slot_first616d1c12c6b0, slot_second616d1c12c6b0] = SLOT_616d1c12c6b0;
if (!(true)) return;
uint64_t KEY_616d1c12d0d0 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_616d1c12d0d0 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_616d1c12d0d0.for_each(KEY_616d1c12d0d0, [&] __device__ (auto const SLOT_616d1c12d0d0) {
auto const [slot_first616d1c12d0d0, slot_second616d1c12d0d0] = SLOT_616d1c12d0d0;
if (!(true)) return;
uint64_t KEY_616d1c12d190 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_616d1c12d190 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_616d1c12d190.for_each(KEY_616d1c12d190, [&] __device__ (auto const SLOT_616d1c12d190) {
auto const [slot_first616d1c12d190, slot_second616d1c12d190] = SLOT_616d1c12d190;
if (!(true)) return;
uint64_t KEY_616d1c0df300 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_616d1c12d0d0[slot_second616d1c12d0d0 * 1 + 0]];

KEY_616d1c0df300 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_616d1c12c6b0[slot_second616d1c12c6b0 * 1 + 0]];
KEY_616d1c0df300 <<= 16;
KEY_616d1c0df300 |= reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[BUF_616d1c12d190[slot_second616d1c12d190 * 1 + 0]];
KEY_616d1c0df300 <<= 32;
KEY_616d1c0df300 |= reg_date__d_year;
//Aggregate in hashtable
auto buf_idx_616d1c0df300 = HT_616d1c0df300.find(KEY_616d1c0df300)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_616d1c0df300], reg_lineorder__lo_revenue);
KEY_616d1c0df300customer__c_city_encoded[buf_idx_616d1c0df300] = reg_customer__c_city_encoded;
KEY_616d1c0df300supplier__s_city_encoded[buf_idx_616d1c0df300] = reg_supplier__s_city_encoded;
KEY_616d1c0df300date__d_year[buf_idx_616d1c0df300] = reg_date__d_year;
});
});
});
}
__global__ void count_616d1c149660(uint64_t* COUNT616d1c0bac60, size_t COUNT616d1c0df300) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT616d1c0df300) return;
//Materialize count
atomicAdd((int*)COUNT616d1c0bac60, 1);
}
__global__ void main_616d1c149660(size_t COUNT616d1c0df300, DBDecimalType* MAT616d1c0bac60aggr0__tmp_attr0, DBI16Type* MAT616d1c0bac60customer__c_city_encoded, DBI32Type* MAT616d1c0bac60date__d_year, DBI16Type* MAT616d1c0bac60supplier__s_city_encoded, uint64_t* MAT_IDX616d1c0bac60, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT616d1c0df300) return;
//Materialize buffers
auto mat_idx616d1c0bac60 = atomicAdd((int*)MAT_IDX616d1c0bac60, 1);
auto reg_customer__c_city_encoded = customer__c_city_encoded[tid];
MAT616d1c0bac60customer__c_city_encoded[mat_idx616d1c0bac60] = reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[tid];
MAT616d1c0bac60supplier__s_city_encoded[mat_idx616d1c0bac60] = reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[tid];
MAT616d1c0bac60date__d_year[mat_idx616d1c0bac60] = reg_date__d_year;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT616d1c0bac60aggr0__tmp_attr0[mat_idx616d1c0bac60] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT616d1c12c6b0;
cudaMalloc(&d_COUNT616d1c12c6b0, sizeof(uint64_t));
cudaMemset(d_COUNT616d1c12c6b0, 0, sizeof(uint64_t));
count_616d1c136480<<<std::ceil((float)supplier_size/32.), 32>>>(d_COUNT616d1c12c6b0, d_supplier__s_nation, supplier_size);
uint64_t COUNT616d1c12c6b0;
cudaMemcpy(&COUNT616d1c12c6b0, d_COUNT616d1c12c6b0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_616d1c12c6b0;
cudaMalloc(&d_BUF_IDX_616d1c12c6b0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_616d1c12c6b0, 0, sizeof(uint64_t));
uint64_t* d_BUF_616d1c12c6b0;
cudaMalloc(&d_BUF_616d1c12c6b0, sizeof(uint64_t) * COUNT616d1c12c6b0 * 1);
auto d_HT_616d1c12c6b0 = cuco::experimental::static_multimap{ (int)COUNT616d1c12c6b0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_616d1c136480<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_616d1c12c6b0, d_BUF_IDX_616d1c12c6b0, d_HT_616d1c12c6b0.ref(cuco::insert), d_supplier__s_nation, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT616d1c12d0d0;
cudaMalloc(&d_COUNT616d1c12d0d0, sizeof(uint64_t));
cudaMemset(d_COUNT616d1c12d0d0, 0, sizeof(uint64_t));
count_616d1c10f1a0<<<std::ceil((float)customer_size/32.), 32>>>(d_COUNT616d1c12d0d0, d_customer__c_nation, customer_size);
uint64_t COUNT616d1c12d0d0;
cudaMemcpy(&COUNT616d1c12d0d0, d_COUNT616d1c12d0d0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_616d1c12d0d0;
cudaMalloc(&d_BUF_IDX_616d1c12d0d0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_616d1c12d0d0, 0, sizeof(uint64_t));
uint64_t* d_BUF_616d1c12d0d0;
cudaMalloc(&d_BUF_616d1c12d0d0, sizeof(uint64_t) * COUNT616d1c12d0d0 * 1);
auto d_HT_616d1c12d0d0 = cuco::experimental::static_multimap{ (int)COUNT616d1c12d0d0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_616d1c10f1a0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_616d1c12d0d0, d_BUF_IDX_616d1c12d0d0, d_HT_616d1c12d0d0.ref(cuco::insert), d_customer__c_custkey, d_customer__c_nation, customer_size);
//Materialize count
uint64_t* d_COUNT616d1c12d190;
cudaMalloc(&d_COUNT616d1c12d190, sizeof(uint64_t));
cudaMemset(d_COUNT616d1c12d190, 0, sizeof(uint64_t));
count_616d1c13f370<<<std::ceil((float)date_size/32.), 32>>>(d_COUNT616d1c12d190, d_date__d_year, date_size);
uint64_t COUNT616d1c12d190;
cudaMemcpy(&COUNT616d1c12d190, d_COUNT616d1c12d190, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_616d1c12d190;
cudaMalloc(&d_BUF_IDX_616d1c12d190, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_616d1c12d190, 0, sizeof(uint64_t));
uint64_t* d_BUF_616d1c12d190;
cudaMalloc(&d_BUF_616d1c12d190, sizeof(uint64_t) * COUNT616d1c12d190 * 1);
auto d_HT_616d1c12d190 = cuco::experimental::static_multimap{ (int)COUNT616d1c12d190*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_616d1c13f370<<<std::ceil((float)date_size/32.), 32>>>(d_BUF_616d1c12d190, d_BUF_IDX_616d1c12d190, d_HT_616d1c12d190.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Create aggregation hash table
auto d_HT_616d1c0df300 = cuco::static_map{ (int)5679*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_616d1c10f740<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_616d1c12c6b0, d_BUF_616d1c12d0d0, d_BUF_616d1c12d190, d_HT_616d1c0df300.ref(cuco::insert), d_HT_616d1c12c6b0.ref(cuco::for_each), d_HT_616d1c12d0d0.ref(cuco::for_each), d_HT_616d1c12d190.ref(cuco::for_each), d_customer__c_city_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_city_encoded);
size_t COUNT616d1c0df300 = d_HT_616d1c0df300.size();
thrust::device_vector<int64_t> keys_616d1c0df300(COUNT616d1c0df300), vals_616d1c0df300(COUNT616d1c0df300);
d_HT_616d1c0df300.retrieve_all(keys_616d1c0df300.begin(), vals_616d1c0df300.begin());
d_HT_616d1c0df300.clear();
int64_t* raw_keys616d1c0df300 = thrust::raw_pointer_cast(keys_616d1c0df300.data());
insertKeys<<<std::ceil((float)COUNT616d1c0df300/32.), 32>>>(raw_keys616d1c0df300, d_HT_616d1c0df300.ref(cuco::insert), COUNT616d1c0df300);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT616d1c0df300);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT616d1c0df300);
DBI16Type* d_KEY_616d1c0df300customer__c_city_encoded;
cudaMalloc(&d_KEY_616d1c0df300customer__c_city_encoded, sizeof(DBI16Type) * COUNT616d1c0df300);
cudaMemset(d_KEY_616d1c0df300customer__c_city_encoded, 0, sizeof(DBI16Type) * COUNT616d1c0df300);
DBI16Type* d_KEY_616d1c0df300supplier__s_city_encoded;
cudaMalloc(&d_KEY_616d1c0df300supplier__s_city_encoded, sizeof(DBI16Type) * COUNT616d1c0df300);
cudaMemset(d_KEY_616d1c0df300supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT616d1c0df300);
DBI32Type* d_KEY_616d1c0df300date__d_year;
cudaMalloc(&d_KEY_616d1c0df300date__d_year, sizeof(DBI32Type) * COUNT616d1c0df300);
cudaMemset(d_KEY_616d1c0df300date__d_year, 0, sizeof(DBI32Type) * COUNT616d1c0df300);
main_616d1c10f740<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_616d1c12c6b0, d_BUF_616d1c12d0d0, d_BUF_616d1c12d190, d_HT_616d1c0df300.ref(cuco::find), d_HT_616d1c12c6b0.ref(cuco::for_each), d_HT_616d1c12d0d0.ref(cuco::for_each), d_HT_616d1c12d190.ref(cuco::for_each), d_KEY_616d1c0df300customer__c_city_encoded, d_KEY_616d1c0df300date__d_year, d_KEY_616d1c0df300supplier__s_city_encoded, d_aggr0__tmp_attr0, d_customer__c_city_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_city_encoded);
//Materialize count
uint64_t* d_COUNT616d1c0bac60;
cudaMalloc(&d_COUNT616d1c0bac60, sizeof(uint64_t));
cudaMemset(d_COUNT616d1c0bac60, 0, sizeof(uint64_t));
count_616d1c149660<<<std::ceil((float)COUNT616d1c0df300/32.), 32>>>(d_COUNT616d1c0bac60, COUNT616d1c0df300);
uint64_t COUNT616d1c0bac60;
cudaMemcpy(&COUNT616d1c0bac60, d_COUNT616d1c0bac60, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX616d1c0bac60;
cudaMalloc(&d_MAT_IDX616d1c0bac60, sizeof(uint64_t));
cudaMemset(d_MAT_IDX616d1c0bac60, 0, sizeof(uint64_t));
auto MAT616d1c0bac60customer__c_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT616d1c0bac60);
DBI16Type* d_MAT616d1c0bac60customer__c_city_encoded;
cudaMalloc(&d_MAT616d1c0bac60customer__c_city_encoded, sizeof(DBI16Type) * COUNT616d1c0bac60);
auto MAT616d1c0bac60supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT616d1c0bac60);
DBI16Type* d_MAT616d1c0bac60supplier__s_city_encoded;
cudaMalloc(&d_MAT616d1c0bac60supplier__s_city_encoded, sizeof(DBI16Type) * COUNT616d1c0bac60);
auto MAT616d1c0bac60date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT616d1c0bac60);
DBI32Type* d_MAT616d1c0bac60date__d_year;
cudaMalloc(&d_MAT616d1c0bac60date__d_year, sizeof(DBI32Type) * COUNT616d1c0bac60);
auto MAT616d1c0bac60aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT616d1c0bac60);
DBDecimalType* d_MAT616d1c0bac60aggr0__tmp_attr0;
cudaMalloc(&d_MAT616d1c0bac60aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT616d1c0bac60);
main_616d1c149660<<<std::ceil((float)COUNT616d1c0df300/32.), 32>>>(COUNT616d1c0df300, d_MAT616d1c0bac60aggr0__tmp_attr0, d_MAT616d1c0bac60customer__c_city_encoded, d_MAT616d1c0bac60date__d_year, d_MAT616d1c0bac60supplier__s_city_encoded, d_MAT_IDX616d1c0bac60, d_aggr0__tmp_attr0, d_KEY_616d1c0df300customer__c_city_encoded, d_KEY_616d1c0df300date__d_year, d_KEY_616d1c0df300supplier__s_city_encoded);
cudaMemcpy(MAT616d1c0bac60customer__c_city_encoded, d_MAT616d1c0bac60customer__c_city_encoded, sizeof(DBI16Type) * COUNT616d1c0bac60, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT616d1c0bac60supplier__s_city_encoded, d_MAT616d1c0bac60supplier__s_city_encoded, sizeof(DBI16Type) * COUNT616d1c0bac60, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT616d1c0bac60date__d_year, d_MAT616d1c0bac60date__d_year, sizeof(DBI32Type) * COUNT616d1c0bac60, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT616d1c0bac60aggr0__tmp_attr0, d_MAT616d1c0bac60aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT616d1c0bac60, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT616d1c0bac60; i++) { std::cout << customer__c_city_map[MAT616d1c0bac60customer__c_city_encoded[i]] << "\t";
std::cout << supplier__s_city_map[MAT616d1c0bac60supplier__s_city_encoded[i]] << "\t";
std::cout << MAT616d1c0bac60date__d_year[i] << "\t";
std::cout << MAT616d1c0bac60aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_616d1c12c6b0);
cudaFree(d_BUF_IDX_616d1c12c6b0);
cudaFree(d_COUNT616d1c12c6b0);
cudaFree(d_BUF_616d1c12d0d0);
cudaFree(d_BUF_IDX_616d1c12d0d0);
cudaFree(d_COUNT616d1c12d0d0);
cudaFree(d_BUF_616d1c12d190);
cudaFree(d_BUF_IDX_616d1c12d190);
cudaFree(d_COUNT616d1c12d190);
cudaFree(d_KEY_616d1c0df300customer__c_city_encoded);
cudaFree(d_KEY_616d1c0df300date__d_year);
cudaFree(d_KEY_616d1c0df300supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT616d1c0bac60);
cudaFree(d_MAT616d1c0bac60aggr0__tmp_attr0);
cudaFree(d_MAT616d1c0bac60customer__c_city_encoded);
cudaFree(d_MAT616d1c0bac60date__d_year);
cudaFree(d_MAT616d1c0bac60supplier__s_city_encoded);
cudaFree(d_MAT_IDX616d1c0bac60);
free(MAT616d1c0bac60aggr0__tmp_attr0);
free(MAT616d1c0bac60customer__c_city_encoded);
free(MAT616d1c0bac60date__d_year);
free(MAT616d1c0bac60supplier__s_city_encoded);
}