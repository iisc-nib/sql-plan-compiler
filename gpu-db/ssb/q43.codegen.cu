#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5999e9966490(uint64_t* COUNT5999e9959fb0, DBStringType* supplier__s_nation, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_nation = supplier__s_nation[tid];
if (!(evaluatePredicate(reg_supplier__s_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5999e9959fb0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5999e9966490(uint64_t* BUF_5999e9959fb0, uint64_t* BUF_IDX_5999e9959fb0, HASHTABLE_INSERT HT_5999e9959fb0, DBStringType* supplier__s_nation, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_nation = supplier__s_nation[tid];
if (!(evaluatePredicate(reg_supplier__s_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5999e9959fb0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5999e9959fb0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5999e9959fb0 = atomicAdd((int*)BUF_IDX_5999e9959fb0, 1);
HT_5999e9959fb0.insert(cuco::pair{KEY_5999e9959fb0, buf_idx_5999e9959fb0});
BUF_5999e9959fb0[buf_idx_5999e9959fb0 * 1 + 0] = tid;
}
__global__ void count_5999e9968e50(uint64_t* COUNT5999e995a920, DBStringType* part__p_category, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_category = part__p_category[tid];
if (!(evaluatePredicate(reg_part__p_category, "MFGR#14", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5999e995a920, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5999e9968e50(uint64_t* BUF_5999e995a920, uint64_t* BUF_IDX_5999e995a920, HASHTABLE_INSERT HT_5999e995a920, DBStringType* part__p_category, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_category = part__p_category[tid];
if (!(evaluatePredicate(reg_part__p_category, "MFGR#14", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5999e995a920 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_5999e995a920 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_5999e995a920 = atomicAdd((int*)BUF_IDX_5999e995a920, 1);
HT_5999e995a920.insert(cuco::pair{KEY_5999e995a920, buf_idx_5999e995a920});
BUF_5999e995a920[buf_idx_5999e995a920 * 1 + 0] = tid;
}
__global__ void count_5999e98ff9f0(uint64_t* COUNT5999e9956460, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5999e9956460, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5999e98ff9f0(uint64_t* BUF_5999e9956460, uint64_t* BUF_IDX_5999e9956460, HASHTABLE_INSERT HT_5999e9956460, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5999e9956460 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5999e9956460 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_5999e9956460 = atomicAdd((int*)BUF_IDX_5999e9956460, 1);
HT_5999e9956460.insert(cuco::pair{KEY_5999e9956460, buf_idx_5999e9956460});
BUF_5999e9956460[buf_idx_5999e9956460 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5999e996b750(uint64_t* BUF_5999e9956460, uint64_t* BUF_5999e9959fb0, uint64_t* BUF_5999e995a920, uint64_t* COUNT5999e9938850, HASHTABLE_PROBE HT_5999e9956460, HASHTABLE_PROBE HT_5999e9959fb0, HASHTABLE_PROBE HT_5999e995a920, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_5999e9959fb0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5999e9959fb0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5999e9959fb0.for_each(KEY_5999e9959fb0, [&] __device__ (auto const SLOT_5999e9959fb0) {

auto const [slot_first5999e9959fb0, slot_second5999e9959fb0] = SLOT_5999e9959fb0;
if (!(true)) return;
uint64_t KEY_5999e995a920 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5999e995a920 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_5999e995a920.for_each(KEY_5999e995a920, [&] __device__ (auto const SLOT_5999e995a920) {

auto const [slot_first5999e995a920, slot_second5999e995a920] = SLOT_5999e995a920;
if (!(true)) return;
uint64_t KEY_5999e9956460 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5999e9956460 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5999e9956460.for_each(KEY_5999e9956460, [&] __device__ (auto const SLOT_5999e9956460) {

auto const [slot_first5999e9956460, slot_second5999e9956460] = SLOT_5999e9956460;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5999e9938850, 1);
});
});
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_5999e996b750(uint64_t* BUF_5999e9938850, uint64_t* BUF_5999e9956460, uint64_t* BUF_5999e9959fb0, uint64_t* BUF_5999e995a920, uint64_t* BUF_IDX_5999e9938850, HASHTABLE_INSERT HT_5999e9938850, HASHTABLE_PROBE HT_5999e9956460, HASHTABLE_PROBE HT_5999e9959fb0, HASHTABLE_PROBE HT_5999e995a920, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_5999e9959fb0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5999e9959fb0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5999e9959fb0.for_each(KEY_5999e9959fb0, [&] __device__ (auto const SLOT_5999e9959fb0) {
auto const [slot_first5999e9959fb0, slot_second5999e9959fb0] = SLOT_5999e9959fb0;
if (!(true)) return;
uint64_t KEY_5999e995a920 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5999e995a920 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_5999e995a920.for_each(KEY_5999e995a920, [&] __device__ (auto const SLOT_5999e995a920) {
auto const [slot_first5999e995a920, slot_second5999e995a920] = SLOT_5999e995a920;
if (!(true)) return;
uint64_t KEY_5999e9956460 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5999e9956460 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5999e9956460.for_each(KEY_5999e9956460, [&] __device__ (auto const SLOT_5999e9956460) {
auto const [slot_first5999e9956460, slot_second5999e9956460] = SLOT_5999e9956460;
if (!(true)) return;
uint64_t KEY_5999e9938850 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5999e9938850 |= reg_lineorder__lo_custkey;
// Insert hash table kernel;
auto buf_idx_5999e9938850 = atomicAdd((int*)BUF_IDX_5999e9938850, 1);
HT_5999e9938850.insert(cuco::pair{KEY_5999e9938850, buf_idx_5999e9938850});
BUF_5999e9938850[buf_idx_5999e9938850 * 4 + 0] = BUF_5999e9956460[slot_second5999e9956460 * 1 + 0];
BUF_5999e9938850[buf_idx_5999e9938850 * 4 + 1] = BUF_5999e9959fb0[slot_second5999e9959fb0 * 1 + 0];
BUF_5999e9938850[buf_idx_5999e9938850 * 4 + 2] = BUF_5999e995a920[slot_second5999e995a920 * 1 + 0];
BUF_5999e9938850[buf_idx_5999e9938850 * 4 + 3] = tid;
});
});
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5999e98ff7b0(uint64_t* BUF_5999e9938850, HASHTABLE_INSERT HT_5999e990db50, HASHTABLE_PROBE HT_5999e9938850, DBI32Type* customer__c_custkey, size_t customer_size, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5999e9938850 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5999e9938850 |= reg_customer__c_custkey;
//Probe Hash table
HT_5999e9938850.for_each(KEY_5999e9938850, [&] __device__ (auto const SLOT_5999e9938850) {

auto const [slot_first5999e9938850, slot_second5999e9938850] = SLOT_5999e9938850;
if (!(true)) return;
uint64_t KEY_5999e990db50 = 0;
auto reg_date__d_year = date__d_year[BUF_5999e9938850[slot_second5999e9938850 * 4 + 0]];

KEY_5999e990db50 |= reg_date__d_year;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_5999e9938850[slot_second5999e9938850 * 4 + 1]];
KEY_5999e990db50 <<= 16;
KEY_5999e990db50 |= reg_supplier__s_city_encoded;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_5999e9938850[slot_second5999e9938850 * 4 + 2]];
KEY_5999e990db50 <<= 16;
KEY_5999e990db50 |= reg_part__p_brand1_encoded;
//Create aggregation hash table
HT_5999e990db50.insert(cuco::pair{KEY_5999e990db50, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5999e98ff7b0(uint64_t* BUF_5999e9938850, HASHTABLE_FIND HT_5999e990db50, HASHTABLE_PROBE HT_5999e9938850, DBI32Type* KEY_5999e990db50date__d_year, DBI16Type* KEY_5999e990db50part__p_brand1_encoded, DBI16Type* KEY_5999e990db50supplier__s_city_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* customer__c_custkey, size_t customer_size, DBI32Type* date__d_year, DBDecimalType* lineorder__lo_revenue, DBDecimalType* lineorder__lo_supplycost, DBI16Type* part__p_brand1_encoded, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5999e9938850 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5999e9938850 |= reg_customer__c_custkey;
//Probe Hash table
HT_5999e9938850.for_each(KEY_5999e9938850, [&] __device__ (auto const SLOT_5999e9938850) {
auto const [slot_first5999e9938850, slot_second5999e9938850] = SLOT_5999e9938850;
if (!(true)) return;
uint64_t KEY_5999e990db50 = 0;
auto reg_date__d_year = date__d_year[BUF_5999e9938850[slot_second5999e9938850 * 4 + 0]];

KEY_5999e990db50 |= reg_date__d_year;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_5999e9938850[slot_second5999e9938850 * 4 + 1]];
KEY_5999e990db50 <<= 16;
KEY_5999e990db50 |= reg_supplier__s_city_encoded;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_5999e9938850[slot_second5999e9938850 * 4 + 2]];
KEY_5999e990db50 <<= 16;
KEY_5999e990db50 |= reg_part__p_brand1_encoded;
//Aggregate in hashtable
auto buf_idx_5999e990db50 = HT_5999e990db50.find(KEY_5999e990db50)->second;
auto reg_lineorder__lo_supplycost = lineorder__lo_supplycost[BUF_5999e9938850[slot_second5999e9938850 * 4 + 3]];
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[BUF_5999e9938850[slot_second5999e9938850 * 4 + 3]];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_revenue) - (reg_lineorder__lo_supplycost);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5999e990db50], reg_map0__tmp_attr1);
KEY_5999e990db50date__d_year[buf_idx_5999e990db50] = reg_date__d_year;
KEY_5999e990db50supplier__s_city_encoded[buf_idx_5999e990db50] = reg_supplier__s_city_encoded;
KEY_5999e990db50part__p_brand1_encoded[buf_idx_5999e990db50] = reg_part__p_brand1_encoded;
});
}
__global__ void count_5999e9984120(uint64_t* COUNT5999e98ede30, size_t COUNT5999e990db50) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5999e990db50) return;
//Materialize count
atomicAdd((int*)COUNT5999e98ede30, 1);
}
__global__ void main_5999e9984120(size_t COUNT5999e990db50, DBDecimalType* MAT5999e98ede30aggr0__tmp_attr0, DBI32Type* MAT5999e98ede30date__d_year, DBI16Type* MAT5999e98ede30part__p_brand1_encoded, DBI16Type* MAT5999e98ede30supplier__s_city_encoded, uint64_t* MAT_IDX5999e98ede30, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5999e990db50) return;
//Materialize buffers
auto mat_idx5999e98ede30 = atomicAdd((int*)MAT_IDX5999e98ede30, 1);
auto reg_date__d_year = date__d_year[tid];
MAT5999e98ede30date__d_year[mat_idx5999e98ede30] = reg_date__d_year;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[tid];
MAT5999e98ede30supplier__s_city_encoded[mat_idx5999e98ede30] = reg_supplier__s_city_encoded;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[tid];
MAT5999e98ede30part__p_brand1_encoded[mat_idx5999e98ede30] = reg_part__p_brand1_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5999e98ede30aggr0__tmp_attr0[mat_idx5999e98ede30] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT5999e9959fb0;
cudaMalloc(&d_COUNT5999e9959fb0, sizeof(uint64_t));
cudaMemset(d_COUNT5999e9959fb0, 0, sizeof(uint64_t));
count_5999e9966490<<<std::ceil((float)supplier_size/32.), 32>>>(d_COUNT5999e9959fb0, d_supplier__s_nation, supplier_size);
uint64_t COUNT5999e9959fb0;
cudaMemcpy(&COUNT5999e9959fb0, d_COUNT5999e9959fb0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5999e9959fb0;
cudaMalloc(&d_BUF_IDX_5999e9959fb0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5999e9959fb0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5999e9959fb0;
cudaMalloc(&d_BUF_5999e9959fb0, sizeof(uint64_t) * COUNT5999e9959fb0 * 1);
auto d_HT_5999e9959fb0 = cuco::experimental::static_multimap{ (int)COUNT5999e9959fb0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5999e9966490<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_5999e9959fb0, d_BUF_IDX_5999e9959fb0, d_HT_5999e9959fb0.ref(cuco::insert), d_supplier__s_nation, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT5999e995a920;
cudaMalloc(&d_COUNT5999e995a920, sizeof(uint64_t));
cudaMemset(d_COUNT5999e995a920, 0, sizeof(uint64_t));
count_5999e9968e50<<<std::ceil((float)part_size/32.), 32>>>(d_COUNT5999e995a920, d_part__p_category, part_size);
uint64_t COUNT5999e995a920;
cudaMemcpy(&COUNT5999e995a920, d_COUNT5999e995a920, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5999e995a920;
cudaMalloc(&d_BUF_IDX_5999e995a920, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5999e995a920, 0, sizeof(uint64_t));
uint64_t* d_BUF_5999e995a920;
cudaMalloc(&d_BUF_5999e995a920, sizeof(uint64_t) * COUNT5999e995a920 * 1);
auto d_HT_5999e995a920 = cuco::experimental::static_multimap{ (int)COUNT5999e995a920*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5999e9968e50<<<std::ceil((float)part_size/32.), 32>>>(d_BUF_5999e995a920, d_BUF_IDX_5999e995a920, d_HT_5999e995a920.ref(cuco::insert), d_part__p_category, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT5999e9956460;
cudaMalloc(&d_COUNT5999e9956460, sizeof(uint64_t));
cudaMemset(d_COUNT5999e9956460, 0, sizeof(uint64_t));
count_5999e98ff9f0<<<std::ceil((float)date_size/32.), 32>>>(d_COUNT5999e9956460, d_date__d_year, date_size);
uint64_t COUNT5999e9956460;
cudaMemcpy(&COUNT5999e9956460, d_COUNT5999e9956460, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5999e9956460;
cudaMalloc(&d_BUF_IDX_5999e9956460, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5999e9956460, 0, sizeof(uint64_t));
uint64_t* d_BUF_5999e9956460;
cudaMalloc(&d_BUF_5999e9956460, sizeof(uint64_t) * COUNT5999e9956460 * 1);
auto d_HT_5999e9956460 = cuco::experimental::static_multimap{ (int)COUNT5999e9956460*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5999e98ff9f0<<<std::ceil((float)date_size/32.), 32>>>(d_BUF_5999e9956460, d_BUF_IDX_5999e9956460, d_HT_5999e9956460.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Materialize count
uint64_t* d_COUNT5999e9938850;
cudaMalloc(&d_COUNT5999e9938850, sizeof(uint64_t));
cudaMemset(d_COUNT5999e9938850, 0, sizeof(uint64_t));
count_5999e996b750<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_5999e9956460, d_BUF_5999e9959fb0, d_BUF_5999e995a920, d_COUNT5999e9938850, d_HT_5999e9956460.ref(cuco::for_each), d_HT_5999e9959fb0.ref(cuco::for_each), d_HT_5999e995a920.ref(cuco::for_each), d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
uint64_t COUNT5999e9938850;
cudaMemcpy(&COUNT5999e9938850, d_COUNT5999e9938850, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5999e9938850;
cudaMalloc(&d_BUF_IDX_5999e9938850, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5999e9938850, 0, sizeof(uint64_t));
uint64_t* d_BUF_5999e9938850;
cudaMalloc(&d_BUF_5999e9938850, sizeof(uint64_t) * COUNT5999e9938850 * 4);
auto d_HT_5999e9938850 = cuco::experimental::static_multimap{ (int)COUNT5999e9938850*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5999e996b750<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_5999e9938850, d_BUF_5999e9956460, d_BUF_5999e9959fb0, d_BUF_5999e995a920, d_BUF_IDX_5999e9938850, d_HT_5999e9938850.ref(cuco::insert), d_HT_5999e9956460.ref(cuco::for_each), d_HT_5999e9959fb0.ref(cuco::for_each), d_HT_5999e995a920.ref(cuco::for_each), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
//Create aggregation hash table
auto d_HT_5999e990db50 = cuco::static_map{ (int)2259*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5999e98ff7b0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5999e9938850, d_HT_5999e990db50.ref(cuco::insert), d_HT_5999e9938850.ref(cuco::for_each), d_customer__c_custkey, customer_size, d_date__d_year, d_part__p_brand1_encoded, d_supplier__s_city_encoded);
size_t COUNT5999e990db50 = d_HT_5999e990db50.size();
thrust::device_vector<int64_t> keys_5999e990db50(COUNT5999e990db50), vals_5999e990db50(COUNT5999e990db50);
d_HT_5999e990db50.retrieve_all(keys_5999e990db50.begin(), vals_5999e990db50.begin());
d_HT_5999e990db50.clear();
int64_t* raw_keys5999e990db50 = thrust::raw_pointer_cast(keys_5999e990db50.data());
insertKeys<<<std::ceil((float)COUNT5999e990db50/32.), 32>>>(raw_keys5999e990db50, d_HT_5999e990db50.ref(cuco::insert), COUNT5999e990db50);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5999e990db50);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5999e990db50);
DBI32Type* d_KEY_5999e990db50date__d_year;
cudaMalloc(&d_KEY_5999e990db50date__d_year, sizeof(DBI32Type) * COUNT5999e990db50);
cudaMemset(d_KEY_5999e990db50date__d_year, 0, sizeof(DBI32Type) * COUNT5999e990db50);
DBI16Type* d_KEY_5999e990db50supplier__s_city_encoded;
cudaMalloc(&d_KEY_5999e990db50supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5999e990db50);
cudaMemset(d_KEY_5999e990db50supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT5999e990db50);
DBI16Type* d_KEY_5999e990db50part__p_brand1_encoded;
cudaMalloc(&d_KEY_5999e990db50part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5999e990db50);
cudaMemset(d_KEY_5999e990db50part__p_brand1_encoded, 0, sizeof(DBI16Type) * COUNT5999e990db50);
main_5999e98ff7b0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5999e9938850, d_HT_5999e990db50.ref(cuco::find), d_HT_5999e9938850.ref(cuco::for_each), d_KEY_5999e990db50date__d_year, d_KEY_5999e990db50part__p_brand1_encoded, d_KEY_5999e990db50supplier__s_city_encoded, d_aggr0__tmp_attr0, d_customer__c_custkey, customer_size, d_date__d_year, d_lineorder__lo_revenue, d_lineorder__lo_supplycost, d_part__p_brand1_encoded, d_supplier__s_city_encoded);
//Materialize count
uint64_t* d_COUNT5999e98ede30;
cudaMalloc(&d_COUNT5999e98ede30, sizeof(uint64_t));
cudaMemset(d_COUNT5999e98ede30, 0, sizeof(uint64_t));
count_5999e9984120<<<std::ceil((float)COUNT5999e990db50/32.), 32>>>(d_COUNT5999e98ede30, COUNT5999e990db50);
uint64_t COUNT5999e98ede30;
cudaMemcpy(&COUNT5999e98ede30, d_COUNT5999e98ede30, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5999e98ede30;
cudaMalloc(&d_MAT_IDX5999e98ede30, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5999e98ede30, 0, sizeof(uint64_t));
auto MAT5999e98ede30date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5999e98ede30);
DBI32Type* d_MAT5999e98ede30date__d_year;
cudaMalloc(&d_MAT5999e98ede30date__d_year, sizeof(DBI32Type) * COUNT5999e98ede30);
auto MAT5999e98ede30supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5999e98ede30);
DBI16Type* d_MAT5999e98ede30supplier__s_city_encoded;
cudaMalloc(&d_MAT5999e98ede30supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5999e98ede30);
auto MAT5999e98ede30part__p_brand1_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5999e98ede30);
DBI16Type* d_MAT5999e98ede30part__p_brand1_encoded;
cudaMalloc(&d_MAT5999e98ede30part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5999e98ede30);
auto MAT5999e98ede30aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5999e98ede30);
DBDecimalType* d_MAT5999e98ede30aggr0__tmp_attr0;
cudaMalloc(&d_MAT5999e98ede30aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5999e98ede30);
main_5999e9984120<<<std::ceil((float)COUNT5999e990db50/32.), 32>>>(COUNT5999e990db50, d_MAT5999e98ede30aggr0__tmp_attr0, d_MAT5999e98ede30date__d_year, d_MAT5999e98ede30part__p_brand1_encoded, d_MAT5999e98ede30supplier__s_city_encoded, d_MAT_IDX5999e98ede30, d_aggr0__tmp_attr0, d_KEY_5999e990db50date__d_year, d_KEY_5999e990db50part__p_brand1_encoded, d_KEY_5999e990db50supplier__s_city_encoded);
cudaMemcpy(MAT5999e98ede30date__d_year, d_MAT5999e98ede30date__d_year, sizeof(DBI32Type) * COUNT5999e98ede30, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5999e98ede30supplier__s_city_encoded, d_MAT5999e98ede30supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5999e98ede30, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5999e98ede30part__p_brand1_encoded, d_MAT5999e98ede30part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5999e98ede30, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5999e98ede30aggr0__tmp_attr0, d_MAT5999e98ede30aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5999e98ede30, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5999e98ede30; i++) { std::cout << MAT5999e98ede30date__d_year[i] << "\t";
std::cout << supplier__s_city_map[MAT5999e98ede30supplier__s_city_encoded[i]] << "\t";
std::cout << part__p_brand1_map[MAT5999e98ede30part__p_brand1_encoded[i]] << "\t";
std::cout << MAT5999e98ede30aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_5999e9959fb0);
cudaFree(d_BUF_IDX_5999e9959fb0);
cudaFree(d_COUNT5999e9959fb0);
cudaFree(d_BUF_5999e995a920);
cudaFree(d_BUF_IDX_5999e995a920);
cudaFree(d_COUNT5999e995a920);
cudaFree(d_BUF_5999e9956460);
cudaFree(d_BUF_IDX_5999e9956460);
cudaFree(d_COUNT5999e9956460);
cudaFree(d_BUF_5999e9938850);
cudaFree(d_BUF_IDX_5999e9938850);
cudaFree(d_COUNT5999e9938850);
cudaFree(d_KEY_5999e990db50date__d_year);
cudaFree(d_KEY_5999e990db50part__p_brand1_encoded);
cudaFree(d_KEY_5999e990db50supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5999e98ede30);
cudaFree(d_MAT5999e98ede30aggr0__tmp_attr0);
cudaFree(d_MAT5999e98ede30date__d_year);
cudaFree(d_MAT5999e98ede30part__p_brand1_encoded);
cudaFree(d_MAT5999e98ede30supplier__s_city_encoded);
cudaFree(d_MAT_IDX5999e98ede30);
free(MAT5999e98ede30aggr0__tmp_attr0);
free(MAT5999e98ede30date__d_year);
free(MAT5999e98ede30part__p_brand1_encoded);
free(MAT5999e98ede30supplier__s_city_encoded);
}