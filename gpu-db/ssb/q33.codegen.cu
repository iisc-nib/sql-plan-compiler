#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_60b3603c3310(uint64_t* COUNT60b3603d9800, DBStringType* customer__c_city, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_city = customer__c_city[tid];
if (!((evaluatePredicate(reg_customer__c_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_customer__c_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT60b3603d9800, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_60b3603c3310(uint64_t* BUF_60b3603d9800, uint64_t* BUF_IDX_60b3603d9800, HASHTABLE_INSERT HT_60b3603d9800, DBStringType* customer__c_city, DBI32Type* customer__c_custkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_city = customer__c_city[tid];
if (!((evaluatePredicate(reg_customer__c_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_customer__c_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_60b3603d9800 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_60b3603d9800 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_60b3603d9800 = atomicAdd((int*)BUF_IDX_60b3603d9800, 1);
HT_60b3603d9800.insert(cuco::pair{KEY_60b3603d9800, buf_idx_60b3603d9800});
BUF_60b3603d9800[buf_idx_60b3603d9800 * 1 + 0] = tid;
}
__global__ void count_60b3603de700(uint64_t* COUNT60b3603d9b70, DBStringType* supplier__s_city, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_city = supplier__s_city[tid];
if (!((evaluatePredicate(reg_supplier__s_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_supplier__s_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT60b3603d9b70, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_60b3603de700(uint64_t* BUF_60b3603d9b70, uint64_t* BUF_IDX_60b3603d9b70, HASHTABLE_INSERT HT_60b3603d9b70, DBStringType* supplier__s_city, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_city = supplier__s_city[tid];
if (!((evaluatePredicate(reg_supplier__s_city, "UNITED KI1", Predicate::eq)) || (evaluatePredicate(reg_supplier__s_city, "UNITED KI5", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_60b3603d9b70 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_60b3603d9b70 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_60b3603d9b70 = atomicAdd((int*)BUF_IDX_60b3603d9b70, 1);
HT_60b3603d9b70.insert(cuco::pair{KEY_60b3603d9b70, buf_idx_60b3603d9b70});
BUF_60b3603d9b70[buf_idx_60b3603d9b70 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_60b3603e0ac0(uint64_t* BUF_60b3603d9800, uint64_t* BUF_60b3603d9b70, uint64_t* COUNT60b3603e2730, HASHTABLE_PROBE HT_60b3603d9800, HASHTABLE_PROBE HT_60b3603d9b70, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_60b3603d9800 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_60b3603d9800 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_60b3603d9800.for_each(KEY_60b3603d9800, [&] __device__ (auto const SLOT_60b3603d9800) {

auto const [slot_first60b3603d9800, slot_second60b3603d9800] = SLOT_60b3603d9800;
if (!(true)) return;
uint64_t KEY_60b3603d9b70 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_60b3603d9b70 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_60b3603d9b70.for_each(KEY_60b3603d9b70, [&] __device__ (auto const SLOT_60b3603d9b70) {

auto const [slot_first60b3603d9b70, slot_second60b3603d9b70] = SLOT_60b3603d9b70;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT60b3603e2730, 1);
});
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_60b3603e0ac0(uint64_t* BUF_60b3603d9800, uint64_t* BUF_60b3603d9b70, uint64_t* BUF_60b3603e2730, uint64_t* BUF_IDX_60b3603e2730, HASHTABLE_PROBE HT_60b3603d9800, HASHTABLE_PROBE HT_60b3603d9b70, HASHTABLE_INSERT HT_60b3603e2730, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_60b3603d9800 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_60b3603d9800 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_60b3603d9800.for_each(KEY_60b3603d9800, [&] __device__ (auto const SLOT_60b3603d9800) {
auto const [slot_first60b3603d9800, slot_second60b3603d9800] = SLOT_60b3603d9800;
if (!(true)) return;
uint64_t KEY_60b3603d9b70 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_60b3603d9b70 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_60b3603d9b70.for_each(KEY_60b3603d9b70, [&] __device__ (auto const SLOT_60b3603d9b70) {
auto const [slot_first60b3603d9b70, slot_second60b3603d9b70] = SLOT_60b3603d9b70;
if (!(true)) return;
uint64_t KEY_60b3603e2730 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_60b3603e2730 |= reg_lineorder__lo_orderdate;
// Insert hash table kernel;
auto buf_idx_60b3603e2730 = atomicAdd((int*)BUF_IDX_60b3603e2730, 1);
HT_60b3603e2730.insert(cuco::pair{KEY_60b3603e2730, buf_idx_60b3603e2730});
BUF_60b3603e2730[buf_idx_60b3603e2730 * 3 + 0] = BUF_60b3603d9800[slot_second60b3603d9800 * 1 + 0];
BUF_60b3603e2730[buf_idx_60b3603e2730 * 3 + 1] = tid;
BUF_60b3603e2730[buf_idx_60b3603e2730 * 3 + 2] = BUF_60b3603d9b70[slot_second60b3603d9b70 * 1 + 0];
});
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_60b3603c38b0(uint64_t* BUF_60b3603e2730, HASHTABLE_INSERT HT_60b360393b20, HASHTABLE_PROBE HT_60b3603e2730, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_60b3603e2730 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_60b3603e2730 |= reg_date__d_datekey;
//Probe Hash table
HT_60b3603e2730.for_each(KEY_60b3603e2730, [&] __device__ (auto const SLOT_60b3603e2730) {

auto const [slot_first60b3603e2730, slot_second60b3603e2730] = SLOT_60b3603e2730;
if (!(true)) return;
uint64_t KEY_60b360393b20 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_60b3603e2730[slot_second60b3603e2730 * 3 + 0]];

KEY_60b360393b20 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_60b3603e2730[slot_second60b3603e2730 * 3 + 2]];
KEY_60b360393b20 <<= 16;
KEY_60b360393b20 |= reg_supplier__s_city_encoded;
KEY_60b360393b20 <<= 32;
KEY_60b360393b20 |= reg_date__d_year;
//Create aggregation hash table
HT_60b360393b20.insert(cuco::pair{KEY_60b360393b20, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_60b3603c38b0(uint64_t* BUF_60b3603e2730, HASHTABLE_FIND HT_60b360393b20, HASHTABLE_PROBE HT_60b3603e2730, DBI16Type* KEY_60b360393b20customer__c_city_encoded, DBI32Type* KEY_60b360393b20date__d_year, DBI16Type* KEY_60b360393b20supplier__s_city_encoded, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size, DBDecimalType* lineorder__lo_revenue, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_60b3603e2730 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_60b3603e2730 |= reg_date__d_datekey;
//Probe Hash table
HT_60b3603e2730.for_each(KEY_60b3603e2730, [&] __device__ (auto const SLOT_60b3603e2730) {
auto const [slot_first60b3603e2730, slot_second60b3603e2730] = SLOT_60b3603e2730;
if (!(true)) return;
uint64_t KEY_60b360393b20 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_60b3603e2730[slot_second60b3603e2730 * 3 + 0]];

KEY_60b360393b20 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_60b3603e2730[slot_second60b3603e2730 * 3 + 2]];
KEY_60b360393b20 <<= 16;
KEY_60b360393b20 |= reg_supplier__s_city_encoded;
KEY_60b360393b20 <<= 32;
KEY_60b360393b20 |= reg_date__d_year;
//Aggregate in hashtable
auto buf_idx_60b360393b20 = HT_60b360393b20.find(KEY_60b360393b20)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[BUF_60b3603e2730[slot_second60b3603e2730 * 3 + 1]];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_60b360393b20], reg_lineorder__lo_revenue);
KEY_60b360393b20customer__c_city_encoded[buf_idx_60b360393b20] = reg_customer__c_city_encoded;
KEY_60b360393b20supplier__s_city_encoded[buf_idx_60b360393b20] = reg_supplier__s_city_encoded;
KEY_60b360393b20date__d_year[buf_idx_60b360393b20] = reg_date__d_year;
});
}
__global__ void count_60b3603fd780(size_t COUNT60b360393b20, uint64_t* COUNT60b3603a67a0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT60b360393b20) return;
//Materialize count
atomicAdd((int*)COUNT60b3603a67a0, 1);
}
__global__ void main_60b3603fd780(size_t COUNT60b360393b20, DBDecimalType* MAT60b3603a67a0aggr0__tmp_attr0, DBI16Type* MAT60b3603a67a0customer__c_city_encoded, DBI32Type* MAT60b3603a67a0date__d_year, DBI16Type* MAT60b3603a67a0supplier__s_city_encoded, uint64_t* MAT_IDX60b3603a67a0, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT60b360393b20) return;
//Materialize buffers
auto mat_idx60b3603a67a0 = atomicAdd((int*)MAT_IDX60b3603a67a0, 1);
auto reg_customer__c_city_encoded = customer__c_city_encoded[tid];
MAT60b3603a67a0customer__c_city_encoded[mat_idx60b3603a67a0] = reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[tid];
MAT60b3603a67a0supplier__s_city_encoded[mat_idx60b3603a67a0] = reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[tid];
MAT60b3603a67a0date__d_year[mat_idx60b3603a67a0] = reg_date__d_year;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT60b3603a67a0aggr0__tmp_attr0[mat_idx60b3603a67a0] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map) {
//Materialize count
uint64_t* d_COUNT60b3603d9800;
cudaMalloc(&d_COUNT60b3603d9800, sizeof(uint64_t));
cudaMemset(d_COUNT60b3603d9800, 0, sizeof(uint64_t));
count_60b3603c3310<<<std::ceil((float)customer_size/32.), 32>>>(d_COUNT60b3603d9800, d_customer__c_city, customer_size);
uint64_t COUNT60b3603d9800;
cudaMemcpy(&COUNT60b3603d9800, d_COUNT60b3603d9800, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_60b3603d9800;
cudaMalloc(&d_BUF_IDX_60b3603d9800, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_60b3603d9800, 0, sizeof(uint64_t));
uint64_t* d_BUF_60b3603d9800;
cudaMalloc(&d_BUF_60b3603d9800, sizeof(uint64_t) * COUNT60b3603d9800 * 1);
auto d_HT_60b3603d9800 = cuco::experimental::static_multimap{ (int)COUNT60b3603d9800*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_60b3603c3310<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_60b3603d9800, d_BUF_IDX_60b3603d9800, d_HT_60b3603d9800.ref(cuco::insert), d_customer__c_city, d_customer__c_custkey, customer_size);
//Materialize count
uint64_t* d_COUNT60b3603d9b70;
cudaMalloc(&d_COUNT60b3603d9b70, sizeof(uint64_t));
cudaMemset(d_COUNT60b3603d9b70, 0, sizeof(uint64_t));
count_60b3603de700<<<std::ceil((float)supplier_size/32.), 32>>>(d_COUNT60b3603d9b70, d_supplier__s_city, supplier_size);
uint64_t COUNT60b3603d9b70;
cudaMemcpy(&COUNT60b3603d9b70, d_COUNT60b3603d9b70, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_60b3603d9b70;
cudaMalloc(&d_BUF_IDX_60b3603d9b70, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_60b3603d9b70, 0, sizeof(uint64_t));
uint64_t* d_BUF_60b3603d9b70;
cudaMalloc(&d_BUF_60b3603d9b70, sizeof(uint64_t) * COUNT60b3603d9b70 * 1);
auto d_HT_60b3603d9b70 = cuco::experimental::static_multimap{ (int)COUNT60b3603d9b70*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_60b3603de700<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_60b3603d9b70, d_BUF_IDX_60b3603d9b70, d_HT_60b3603d9b70.ref(cuco::insert), d_supplier__s_city, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT60b3603e2730;
cudaMalloc(&d_COUNT60b3603e2730, sizeof(uint64_t));
cudaMemset(d_COUNT60b3603e2730, 0, sizeof(uint64_t));
count_60b3603e0ac0<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_60b3603d9800, d_BUF_60b3603d9b70, d_COUNT60b3603e2730, d_HT_60b3603d9800.ref(cuco::for_each), d_HT_60b3603d9b70.ref(cuco::for_each), d_lineorder__lo_custkey, d_lineorder__lo_suppkey, lineorder_size);
uint64_t COUNT60b3603e2730;
cudaMemcpy(&COUNT60b3603e2730, d_COUNT60b3603e2730, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_60b3603e2730;
cudaMalloc(&d_BUF_IDX_60b3603e2730, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_60b3603e2730, 0, sizeof(uint64_t));
uint64_t* d_BUF_60b3603e2730;
cudaMalloc(&d_BUF_60b3603e2730, sizeof(uint64_t) * COUNT60b3603e2730 * 3);
auto d_HT_60b3603e2730 = cuco::experimental::static_multimap{ (int)COUNT60b3603e2730*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_60b3603e0ac0<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_60b3603d9800, d_BUF_60b3603d9b70, d_BUF_60b3603e2730, d_BUF_IDX_60b3603e2730, d_HT_60b3603d9800.ref(cuco::for_each), d_HT_60b3603d9b70.ref(cuco::for_each), d_HT_60b3603e2730.ref(cuco::insert), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size);
//Create aggregation hash table
auto d_HT_60b360393b20 = cuco::static_map{ (int)132*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_60b3603c38b0<<<std::ceil((float)date_size/32.), 32>>>(d_BUF_60b3603e2730, d_HT_60b360393b20.ref(cuco::insert), d_HT_60b3603e2730.ref(cuco::for_each), d_customer__c_city_encoded, d_date__d_datekey, d_date__d_year, date_size, d_supplier__s_city_encoded);
size_t COUNT60b360393b20 = d_HT_60b360393b20.size();
thrust::device_vector<int64_t> keys_60b360393b20(COUNT60b360393b20), vals_60b360393b20(COUNT60b360393b20);
d_HT_60b360393b20.retrieve_all(keys_60b360393b20.begin(), vals_60b360393b20.begin());
d_HT_60b360393b20.clear();
int64_t* raw_keys60b360393b20 = thrust::raw_pointer_cast(keys_60b360393b20.data());
insertKeys<<<std::ceil((float)COUNT60b360393b20/32.), 32>>>(raw_keys60b360393b20, d_HT_60b360393b20.ref(cuco::insert), COUNT60b360393b20);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT60b360393b20);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT60b360393b20);
DBI16Type* d_KEY_60b360393b20customer__c_city_encoded;
cudaMalloc(&d_KEY_60b360393b20customer__c_city_encoded, sizeof(DBI16Type) * COUNT60b360393b20);
cudaMemset(d_KEY_60b360393b20customer__c_city_encoded, 0, sizeof(DBI16Type) * COUNT60b360393b20);
DBI16Type* d_KEY_60b360393b20supplier__s_city_encoded;
cudaMalloc(&d_KEY_60b360393b20supplier__s_city_encoded, sizeof(DBI16Type) * COUNT60b360393b20);
cudaMemset(d_KEY_60b360393b20supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT60b360393b20);
DBI32Type* d_KEY_60b360393b20date__d_year;
cudaMalloc(&d_KEY_60b360393b20date__d_year, sizeof(DBI32Type) * COUNT60b360393b20);
cudaMemset(d_KEY_60b360393b20date__d_year, 0, sizeof(DBI32Type) * COUNT60b360393b20);
main_60b3603c38b0<<<std::ceil((float)date_size/32.), 32>>>(d_BUF_60b3603e2730, d_HT_60b360393b20.ref(cuco::find), d_HT_60b3603e2730.ref(cuco::for_each), d_KEY_60b360393b20customer__c_city_encoded, d_KEY_60b360393b20date__d_year, d_KEY_60b360393b20supplier__s_city_encoded, d_aggr0__tmp_attr0, d_customer__c_city_encoded, d_date__d_datekey, d_date__d_year, date_size, d_lineorder__lo_revenue, d_supplier__s_city_encoded);
//Materialize count
uint64_t* d_COUNT60b3603a67a0;
cudaMalloc(&d_COUNT60b3603a67a0, sizeof(uint64_t));
cudaMemset(d_COUNT60b3603a67a0, 0, sizeof(uint64_t));
count_60b3603fd780<<<std::ceil((float)COUNT60b360393b20/32.), 32>>>(COUNT60b360393b20, d_COUNT60b3603a67a0);
uint64_t COUNT60b3603a67a0;
cudaMemcpy(&COUNT60b3603a67a0, d_COUNT60b3603a67a0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX60b3603a67a0;
cudaMalloc(&d_MAT_IDX60b3603a67a0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX60b3603a67a0, 0, sizeof(uint64_t));
auto MAT60b3603a67a0customer__c_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT60b3603a67a0);
DBI16Type* d_MAT60b3603a67a0customer__c_city_encoded;
cudaMalloc(&d_MAT60b3603a67a0customer__c_city_encoded, sizeof(DBI16Type) * COUNT60b3603a67a0);
auto MAT60b3603a67a0supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT60b3603a67a0);
DBI16Type* d_MAT60b3603a67a0supplier__s_city_encoded;
cudaMalloc(&d_MAT60b3603a67a0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT60b3603a67a0);
auto MAT60b3603a67a0date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT60b3603a67a0);
DBI32Type* d_MAT60b3603a67a0date__d_year;
cudaMalloc(&d_MAT60b3603a67a0date__d_year, sizeof(DBI32Type) * COUNT60b3603a67a0);
auto MAT60b3603a67a0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT60b3603a67a0);
DBDecimalType* d_MAT60b3603a67a0aggr0__tmp_attr0;
cudaMalloc(&d_MAT60b3603a67a0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT60b3603a67a0);
main_60b3603fd780<<<std::ceil((float)COUNT60b360393b20/32.), 32>>>(COUNT60b360393b20, d_MAT60b3603a67a0aggr0__tmp_attr0, d_MAT60b3603a67a0customer__c_city_encoded, d_MAT60b3603a67a0date__d_year, d_MAT60b3603a67a0supplier__s_city_encoded, d_MAT_IDX60b3603a67a0, d_aggr0__tmp_attr0, d_KEY_60b360393b20customer__c_city_encoded, d_KEY_60b360393b20date__d_year, d_KEY_60b360393b20supplier__s_city_encoded);
cudaMemcpy(MAT60b3603a67a0customer__c_city_encoded, d_MAT60b3603a67a0customer__c_city_encoded, sizeof(DBI16Type) * COUNT60b3603a67a0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT60b3603a67a0supplier__s_city_encoded, d_MAT60b3603a67a0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT60b3603a67a0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT60b3603a67a0date__d_year, d_MAT60b3603a67a0date__d_year, sizeof(DBI32Type) * COUNT60b3603a67a0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT60b3603a67a0aggr0__tmp_attr0, d_MAT60b3603a67a0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT60b3603a67a0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT60b3603a67a0; i++) { std::cout << customer__c_city_map[MAT60b3603a67a0customer__c_city_encoded[i]] << "\t";
std::cout << supplier__s_city_map[MAT60b3603a67a0supplier__s_city_encoded[i]] << "\t";
std::cout << MAT60b3603a67a0date__d_year[i] << "\t";
std::cout << MAT60b3603a67a0aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_60b3603d9800);
cudaFree(d_BUF_IDX_60b3603d9800);
cudaFree(d_COUNT60b3603d9800);
cudaFree(d_BUF_60b3603d9b70);
cudaFree(d_BUF_IDX_60b3603d9b70);
cudaFree(d_COUNT60b3603d9b70);
cudaFree(d_BUF_60b3603e2730);
cudaFree(d_BUF_IDX_60b3603e2730);
cudaFree(d_COUNT60b3603e2730);
cudaFree(d_KEY_60b360393b20customer__c_city_encoded);
cudaFree(d_KEY_60b360393b20date__d_year);
cudaFree(d_KEY_60b360393b20supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT60b3603a67a0);
cudaFree(d_MAT60b3603a67a0aggr0__tmp_attr0);
cudaFree(d_MAT60b3603a67a0customer__c_city_encoded);
cudaFree(d_MAT60b3603a67a0date__d_year);
cudaFree(d_MAT60b3603a67a0supplier__s_city_encoded);
cudaFree(d_MAT_IDX60b3603a67a0);
free(MAT60b3603a67a0aggr0__tmp_attr0);
free(MAT60b3603a67a0customer__c_city_encoded);
free(MAT60b3603a67a0date__d_year);
free(MAT60b3603a67a0supplier__s_city_encoded);
}