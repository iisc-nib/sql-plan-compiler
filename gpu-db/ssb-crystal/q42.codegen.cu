#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_64352c889080(uint64_t* COUNT64352c878750, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT64352c878750, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_64352c889080(uint64_t* BUF_64352c878750, uint64_t* BUF_IDX_64352c878750, HASHTABLE_INSERT HT_64352c878750, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_64352c878750 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_64352c878750 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_64352c878750 = atomicAdd((int*)BUF_IDX_64352c878750, 1);
HT_64352c878750.insert(cuco::pair{KEY_64352c878750, buf_idx_64352c878750});
BUF_64352c878750[buf_idx_64352c878750 * 1 + 0] = tid;
}
__global__ void count_64352c8210e0(uint64_t* COUNT64352c87c300, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT64352c87c300, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_64352c8210e0(uint64_t* BUF_64352c87c300, uint64_t* BUF_IDX_64352c87c300, HASHTABLE_INSERT HT_64352c87c300, DBI32Type* customer__c_custkey, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_64352c87c300 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_64352c87c300 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_64352c87c300 = atomicAdd((int*)BUF_IDX_64352c87c300, 1);
HT_64352c87c300.insert(cuco::pair{KEY_64352c87c300, buf_idx_64352c87c300});
BUF_64352c87c300[buf_idx_64352c87c300 * 1 + 0] = tid;
}
__global__ void count_64352c821320(uint64_t* COUNT64352c859860, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT64352c859860, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_64352c821320(uint64_t* BUF_64352c859860, uint64_t* BUF_IDX_64352c859860, HASHTABLE_INSERT HT_64352c859860, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_64352c859860 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_64352c859860 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_64352c859860 = atomicAdd((int*)BUF_IDX_64352c859860, 1);
HT_64352c859860.insert(cuco::pair{KEY_64352c859860, buf_idx_64352c859860});
BUF_64352c859860[buf_idx_64352c859860 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_64352c88e100(uint64_t* BUF_64352c859860, uint64_t* BUF_64352c878750, uint64_t* BUF_64352c87c300, uint64_t* COUNT64352c876900, HASHTABLE_PROBE HT_64352c859860, HASHTABLE_PROBE HT_64352c878750, HASHTABLE_PROBE HT_64352c87c300, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_64352c878750 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_64352c878750 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_64352c878750.for_each(KEY_64352c878750, [&] __device__ (auto const SLOT_64352c878750) {

auto const [slot_first64352c878750, slot_second64352c878750] = SLOT_64352c878750;
if (!(true)) return;
uint64_t KEY_64352c87c300 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_64352c87c300 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_64352c87c300.for_each(KEY_64352c87c300, [&] __device__ (auto const SLOT_64352c87c300) {

auto const [slot_first64352c87c300, slot_second64352c87c300] = SLOT_64352c87c300;
if (!(true)) return;
uint64_t KEY_64352c859860 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_64352c859860 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_64352c859860.for_each(KEY_64352c859860, [&] __device__ (auto const SLOT_64352c859860) {

auto const [slot_first64352c859860, slot_second64352c859860] = SLOT_64352c859860;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT64352c876900, 1);
});
});
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_64352c88e100(uint64_t* BUF_64352c859860, uint64_t* BUF_64352c876900, uint64_t* BUF_64352c878750, uint64_t* BUF_64352c87c300, uint64_t* BUF_IDX_64352c876900, HASHTABLE_PROBE HT_64352c859860, HASHTABLE_INSERT HT_64352c876900, HASHTABLE_PROBE HT_64352c878750, HASHTABLE_PROBE HT_64352c87c300, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_64352c878750 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_64352c878750 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_64352c878750.for_each(KEY_64352c878750, [&] __device__ (auto const SLOT_64352c878750) {
auto const [slot_first64352c878750, slot_second64352c878750] = SLOT_64352c878750;
if (!(true)) return;
uint64_t KEY_64352c87c300 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_64352c87c300 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_64352c87c300.for_each(KEY_64352c87c300, [&] __device__ (auto const SLOT_64352c87c300) {
auto const [slot_first64352c87c300, slot_second64352c87c300] = SLOT_64352c87c300;
if (!(true)) return;
uint64_t KEY_64352c859860 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_64352c859860 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_64352c859860.for_each(KEY_64352c859860, [&] __device__ (auto const SLOT_64352c859860) {
auto const [slot_first64352c859860, slot_second64352c859860] = SLOT_64352c859860;
if (!(true)) return;
uint64_t KEY_64352c876900 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_64352c876900 |= reg_lineorder__lo_partkey;
// Insert hash table kernel;
auto buf_idx_64352c876900 = atomicAdd((int*)BUF_IDX_64352c876900, 1);
HT_64352c876900.insert(cuco::pair{KEY_64352c876900, buf_idx_64352c876900});
BUF_64352c876900[buf_idx_64352c876900 * 4 + 0] = BUF_64352c859860[slot_second64352c859860 * 1 + 0];
BUF_64352c876900[buf_idx_64352c876900 * 4 + 1] = BUF_64352c87c300[slot_second64352c87c300 * 1 + 0];
BUF_64352c876900[buf_idx_64352c876900 * 4 + 2] = BUF_64352c878750[slot_second64352c878750 * 1 + 0];
BUF_64352c876900[buf_idx_64352c876900 * 4 + 3] = tid;
});
});
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_64352c88b8a0(uint64_t* BUF_64352c876900, HASHTABLE_INSERT HT_64352c82ff40, HASHTABLE_PROBE HT_64352c876900, DBI32Type* date__d_year, DBI16Type* part__p_category_encoded, DBStringType* part__p_mfgr, DBI32Type* part__p_partkey, size_t part_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_64352c876900 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_64352c876900 |= reg_part__p_partkey;
//Probe Hash table
HT_64352c876900.for_each(KEY_64352c876900, [&] __device__ (auto const SLOT_64352c876900) {

auto const [slot_first64352c876900, slot_second64352c876900] = SLOT_64352c876900;
if (!(true)) return;
uint64_t KEY_64352c82ff40 = 0;
auto reg_date__d_year = date__d_year[BUF_64352c876900[slot_second64352c876900 * 4 + 0]];

KEY_64352c82ff40 |= reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_64352c876900[slot_second64352c876900 * 4 + 2]];
KEY_64352c82ff40 <<= 16;
KEY_64352c82ff40 |= reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[tid];
KEY_64352c82ff40 <<= 16;
KEY_64352c82ff40 |= reg_part__p_category_encoded;
//Create aggregation hash table
HT_64352c82ff40.insert(cuco::pair{KEY_64352c82ff40, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_64352c88b8a0(uint64_t* BUF_64352c876900, HASHTABLE_FIND HT_64352c82ff40, HASHTABLE_PROBE HT_64352c876900, DBI32Type* KEY_64352c82ff40date__d_year, DBI16Type* KEY_64352c82ff40part__p_category_encoded, DBI16Type* KEY_64352c82ff40supplier__s_nation_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBDecimalType* lineorder__lo_revenue, DBDecimalType* lineorder__lo_supplycost, DBI16Type* part__p_category_encoded, DBStringType* part__p_mfgr, DBI32Type* part__p_partkey, size_t part_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_64352c876900 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_64352c876900 |= reg_part__p_partkey;
//Probe Hash table
HT_64352c876900.for_each(KEY_64352c876900, [&] __device__ (auto const SLOT_64352c876900) {
auto const [slot_first64352c876900, slot_second64352c876900] = SLOT_64352c876900;
if (!(true)) return;
uint64_t KEY_64352c82ff40 = 0;
auto reg_date__d_year = date__d_year[BUF_64352c876900[slot_second64352c876900 * 4 + 0]];

KEY_64352c82ff40 |= reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_64352c876900[slot_second64352c876900 * 4 + 2]];
KEY_64352c82ff40 <<= 16;
KEY_64352c82ff40 |= reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[tid];
KEY_64352c82ff40 <<= 16;
KEY_64352c82ff40 |= reg_part__p_category_encoded;
//Aggregate in hashtable
auto buf_idx_64352c82ff40 = HT_64352c82ff40.find(KEY_64352c82ff40)->second;
auto reg_lineorder__lo_supplycost = lineorder__lo_supplycost[BUF_64352c876900[slot_second64352c876900 * 4 + 3]];
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[BUF_64352c876900[slot_second64352c876900 * 4 + 3]];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_revenue) - (reg_lineorder__lo_supplycost);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_64352c82ff40], reg_map0__tmp_attr1);
KEY_64352c82ff40date__d_year[buf_idx_64352c82ff40] = reg_date__d_year;
KEY_64352c82ff40supplier__s_nation_encoded[buf_idx_64352c82ff40] = reg_supplier__s_nation_encoded;
KEY_64352c82ff40part__p_category_encoded[buf_idx_64352c82ff40] = reg_part__p_category_encoded;
});
}
__global__ void count_64352c89e1d0(uint64_t* COUNT64352c80fc50, size_t COUNT64352c82ff40) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT64352c82ff40) return;
//Materialize count
atomicAdd((int*)COUNT64352c80fc50, 1);
}
__global__ void main_64352c89e1d0(size_t COUNT64352c82ff40, DBDecimalType* MAT64352c80fc50aggr0__tmp_attr0, DBI32Type* MAT64352c80fc50date__d_year, DBI16Type* MAT64352c80fc50part__p_category_encoded, DBI16Type* MAT64352c80fc50supplier__s_nation_encoded, uint64_t* MAT_IDX64352c80fc50, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_category_encoded, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT64352c82ff40) return;
//Materialize buffers
auto mat_idx64352c80fc50 = atomicAdd((int*)MAT_IDX64352c80fc50, 1);
auto reg_date__d_year = date__d_year[tid];
MAT64352c80fc50date__d_year[mat_idx64352c80fc50] = reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[tid];
MAT64352c80fc50supplier__s_nation_encoded[mat_idx64352c80fc50] = reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[tid];
MAT64352c80fc50part__p_category_encoded[mat_idx64352c80fc50] = reg_part__p_category_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT64352c80fc50aggr0__tmp_attr0[mat_idx64352c80fc50] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT64352c878750;
cudaMalloc(&d_COUNT64352c878750, sizeof(uint64_t));
cudaMemset(d_COUNT64352c878750, 0, sizeof(uint64_t));
count_64352c889080<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT64352c878750, d_supplier__s_region, supplier_size);
uint64_t COUNT64352c878750;
cudaMemcpy(&COUNT64352c878750, d_COUNT64352c878750, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_64352c878750;
cudaMalloc(&d_BUF_IDX_64352c878750, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_64352c878750, 0, sizeof(uint64_t));
uint64_t* d_BUF_64352c878750;
cudaMalloc(&d_BUF_64352c878750, sizeof(uint64_t) * COUNT64352c878750 * 1);
auto d_HT_64352c878750 = cuco::experimental::static_multimap{ (int)COUNT64352c878750*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_64352c889080<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_64352c878750, d_BUF_IDX_64352c878750, d_HT_64352c878750.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT64352c87c300;
cudaMalloc(&d_COUNT64352c87c300, sizeof(uint64_t));
cudaMemset(d_COUNT64352c87c300, 0, sizeof(uint64_t));
count_64352c8210e0<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT64352c87c300, d_customer__c_region, customer_size);
uint64_t COUNT64352c87c300;
cudaMemcpy(&COUNT64352c87c300, d_COUNT64352c87c300, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_64352c87c300;
cudaMalloc(&d_BUF_IDX_64352c87c300, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_64352c87c300, 0, sizeof(uint64_t));
uint64_t* d_BUF_64352c87c300;
cudaMalloc(&d_BUF_64352c87c300, sizeof(uint64_t) * COUNT64352c87c300 * 1);
auto d_HT_64352c87c300 = cuco::experimental::static_multimap{ (int)COUNT64352c87c300*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_64352c8210e0<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_64352c87c300, d_BUF_IDX_64352c87c300, d_HT_64352c87c300.ref(cuco::insert), d_customer__c_custkey, d_customer__c_region, customer_size);
//Materialize count
uint64_t* d_COUNT64352c859860;
cudaMalloc(&d_COUNT64352c859860, sizeof(uint64_t));
cudaMemset(d_COUNT64352c859860, 0, sizeof(uint64_t));
count_64352c821320<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT64352c859860, d_date__d_year, date_size);
uint64_t COUNT64352c859860;
cudaMemcpy(&COUNT64352c859860, d_COUNT64352c859860, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_64352c859860;
cudaMalloc(&d_BUF_IDX_64352c859860, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_64352c859860, 0, sizeof(uint64_t));
uint64_t* d_BUF_64352c859860;
cudaMalloc(&d_BUF_64352c859860, sizeof(uint64_t) * COUNT64352c859860 * 1);
auto d_HT_64352c859860 = cuco::experimental::static_multimap{ (int)COUNT64352c859860*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_64352c821320<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_64352c859860, d_BUF_IDX_64352c859860, d_HT_64352c859860.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Materialize count
uint64_t* d_COUNT64352c876900;
cudaMalloc(&d_COUNT64352c876900, sizeof(uint64_t));
cudaMemset(d_COUNT64352c876900, 0, sizeof(uint64_t));
count_64352c88e100<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_64352c859860, d_BUF_64352c878750, d_BUF_64352c87c300, d_COUNT64352c876900, d_HT_64352c859860.ref(cuco::for_each), d_HT_64352c878750.ref(cuco::for_each), d_HT_64352c87c300.ref(cuco::for_each), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size);
uint64_t COUNT64352c876900;
cudaMemcpy(&COUNT64352c876900, d_COUNT64352c876900, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_64352c876900;
cudaMalloc(&d_BUF_IDX_64352c876900, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_64352c876900, 0, sizeof(uint64_t));
uint64_t* d_BUF_64352c876900;
cudaMalloc(&d_BUF_64352c876900, sizeof(uint64_t) * COUNT64352c876900 * 4);
auto d_HT_64352c876900 = cuco::experimental::static_multimap{ (int)COUNT64352c876900*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_64352c88e100<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_64352c859860, d_BUF_64352c876900, d_BUF_64352c878750, d_BUF_64352c87c300, d_BUF_IDX_64352c876900, d_HT_64352c859860.ref(cuco::for_each), d_HT_64352c876900.ref(cuco::insert), d_HT_64352c878750.ref(cuco::for_each), d_HT_64352c87c300.ref(cuco::for_each), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
//Create aggregation hash table
auto d_HT_64352c82ff40 = cuco::static_map{ (int)24650*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_64352c88b8a0<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_64352c876900, d_HT_64352c82ff40.ref(cuco::insert), d_HT_64352c876900.ref(cuco::for_each), d_date__d_year, d_part__p_category_encoded, d_part__p_mfgr, d_part__p_partkey, part_size, d_supplier__s_nation_encoded);
size_t COUNT64352c82ff40 = d_HT_64352c82ff40.size();
thrust::device_vector<int64_t> keys_64352c82ff40(COUNT64352c82ff40), vals_64352c82ff40(COUNT64352c82ff40);
d_HT_64352c82ff40.retrieve_all(keys_64352c82ff40.begin(), vals_64352c82ff40.begin());
d_HT_64352c82ff40.clear();
int64_t* raw_keys64352c82ff40 = thrust::raw_pointer_cast(keys_64352c82ff40.data());
insertKeys<<<std::ceil((float)COUNT64352c82ff40/128.), 128>>>(raw_keys64352c82ff40, d_HT_64352c82ff40.ref(cuco::insert), COUNT64352c82ff40);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT64352c82ff40);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT64352c82ff40);
DBI32Type* d_KEY_64352c82ff40date__d_year;
cudaMalloc(&d_KEY_64352c82ff40date__d_year, sizeof(DBI32Type) * COUNT64352c82ff40);
cudaMemset(d_KEY_64352c82ff40date__d_year, 0, sizeof(DBI32Type) * COUNT64352c82ff40);
DBI16Type* d_KEY_64352c82ff40supplier__s_nation_encoded;
cudaMalloc(&d_KEY_64352c82ff40supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT64352c82ff40);
cudaMemset(d_KEY_64352c82ff40supplier__s_nation_encoded, 0, sizeof(DBI16Type) * COUNT64352c82ff40);
DBI16Type* d_KEY_64352c82ff40part__p_category_encoded;
cudaMalloc(&d_KEY_64352c82ff40part__p_category_encoded, sizeof(DBI16Type) * COUNT64352c82ff40);
cudaMemset(d_KEY_64352c82ff40part__p_category_encoded, 0, sizeof(DBI16Type) * COUNT64352c82ff40);
main_64352c88b8a0<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_64352c876900, d_HT_64352c82ff40.ref(cuco::find), d_HT_64352c876900.ref(cuco::for_each), d_KEY_64352c82ff40date__d_year, d_KEY_64352c82ff40part__p_category_encoded, d_KEY_64352c82ff40supplier__s_nation_encoded, d_aggr0__tmp_attr0, d_date__d_year, d_lineorder__lo_revenue, d_lineorder__lo_supplycost, d_part__p_category_encoded, d_part__p_mfgr, d_part__p_partkey, part_size, d_supplier__s_nation_encoded);
//Materialize count
uint64_t* d_COUNT64352c80fc50;
cudaMalloc(&d_COUNT64352c80fc50, sizeof(uint64_t));
cudaMemset(d_COUNT64352c80fc50, 0, sizeof(uint64_t));
count_64352c89e1d0<<<std::ceil((float)COUNT64352c82ff40/128.), 128>>>(d_COUNT64352c80fc50, COUNT64352c82ff40);
uint64_t COUNT64352c80fc50;
cudaMemcpy(&COUNT64352c80fc50, d_COUNT64352c80fc50, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX64352c80fc50;
cudaMalloc(&d_MAT_IDX64352c80fc50, sizeof(uint64_t));
cudaMemset(d_MAT_IDX64352c80fc50, 0, sizeof(uint64_t));
auto MAT64352c80fc50date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT64352c80fc50);
DBI32Type* d_MAT64352c80fc50date__d_year;
cudaMalloc(&d_MAT64352c80fc50date__d_year, sizeof(DBI32Type) * COUNT64352c80fc50);
auto MAT64352c80fc50supplier__s_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT64352c80fc50);
DBI16Type* d_MAT64352c80fc50supplier__s_nation_encoded;
cudaMalloc(&d_MAT64352c80fc50supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT64352c80fc50);
auto MAT64352c80fc50part__p_category_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT64352c80fc50);
DBI16Type* d_MAT64352c80fc50part__p_category_encoded;
cudaMalloc(&d_MAT64352c80fc50part__p_category_encoded, sizeof(DBI16Type) * COUNT64352c80fc50);
auto MAT64352c80fc50aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT64352c80fc50);
DBDecimalType* d_MAT64352c80fc50aggr0__tmp_attr0;
cudaMalloc(&d_MAT64352c80fc50aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT64352c80fc50);
main_64352c89e1d0<<<std::ceil((float)COUNT64352c82ff40/128.), 128>>>(COUNT64352c82ff40, d_MAT64352c80fc50aggr0__tmp_attr0, d_MAT64352c80fc50date__d_year, d_MAT64352c80fc50part__p_category_encoded, d_MAT64352c80fc50supplier__s_nation_encoded, d_MAT_IDX64352c80fc50, d_aggr0__tmp_attr0, d_KEY_64352c82ff40date__d_year, d_KEY_64352c82ff40part__p_category_encoded, d_KEY_64352c82ff40supplier__s_nation_encoded);
cudaMemcpy(MAT64352c80fc50date__d_year, d_MAT64352c80fc50date__d_year, sizeof(DBI32Type) * COUNT64352c80fc50, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT64352c80fc50supplier__s_nation_encoded, d_MAT64352c80fc50supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT64352c80fc50, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT64352c80fc50part__p_category_encoded, d_MAT64352c80fc50part__p_category_encoded, sizeof(DBI16Type) * COUNT64352c80fc50, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT64352c80fc50aggr0__tmp_attr0, d_MAT64352c80fc50aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT64352c80fc50, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT64352c80fc50; i++) { std::cout << MAT64352c80fc50date__d_year[i] << "\t";
std::cout << supplier__s_nation_map[MAT64352c80fc50supplier__s_nation_encoded[i]] << "\t";
std::cout << part__p_category_map[MAT64352c80fc50part__p_category_encoded[i]] << "\t";
std::cout << MAT64352c80fc50aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_64352c878750);
cudaFree(d_BUF_IDX_64352c878750);
cudaFree(d_COUNT64352c878750);
cudaFree(d_BUF_64352c87c300);
cudaFree(d_BUF_IDX_64352c87c300);
cudaFree(d_COUNT64352c87c300);
cudaFree(d_BUF_64352c859860);
cudaFree(d_BUF_IDX_64352c859860);
cudaFree(d_COUNT64352c859860);
cudaFree(d_BUF_64352c876900);
cudaFree(d_BUF_IDX_64352c876900);
cudaFree(d_COUNT64352c876900);
cudaFree(d_KEY_64352c82ff40date__d_year);
cudaFree(d_KEY_64352c82ff40part__p_category_encoded);
cudaFree(d_KEY_64352c82ff40supplier__s_nation_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT64352c80fc50);
cudaFree(d_MAT64352c80fc50aggr0__tmp_attr0);
cudaFree(d_MAT64352c80fc50date__d_year);
cudaFree(d_MAT64352c80fc50part__p_category_encoded);
cudaFree(d_MAT64352c80fc50supplier__s_nation_encoded);
cudaFree(d_MAT_IDX64352c80fc50);
free(MAT64352c80fc50aggr0__tmp_attr0);
free(MAT64352c80fc50date__d_year);
free(MAT64352c80fc50part__p_category_encoded);
free(MAT64352c80fc50supplier__s_nation_encoded);
}