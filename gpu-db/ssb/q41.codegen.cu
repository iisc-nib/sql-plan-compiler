#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5bf4ac2e2c80(uint64_t* COUNT5bf4ac2d6980, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5bf4ac2d6980, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5bf4ac2e2c80(uint64_t* BUF_5bf4ac2d6980, uint64_t* BUF_IDX_5bf4ac2d6980, HASHTABLE_INSERT HT_5bf4ac2d6980, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5bf4ac2d6980 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5bf4ac2d6980 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5bf4ac2d6980 = atomicAdd((int*)BUF_IDX_5bf4ac2d6980, 1);
HT_5bf4ac2d6980.insert(cuco::pair{KEY_5bf4ac2d6980, buf_idx_5bf4ac2d6980});
BUF_5bf4ac2d6980[buf_idx_5bf4ac2d6980 * 1 + 0] = tid;
}
__global__ void count_5bf4ac27c9a0(uint64_t* COUNT5bf4ac2d5a20, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5bf4ac2d5a20, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5bf4ac27c9a0(uint64_t* BUF_5bf4ac2d5a20, uint64_t* BUF_IDX_5bf4ac2d5a20, HASHTABLE_INSERT HT_5bf4ac2d5a20, DBI32Type* customer__c_custkey, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5bf4ac2d5a20 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5bf4ac2d5a20 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_5bf4ac2d5a20 = atomicAdd((int*)BUF_IDX_5bf4ac2d5a20, 1);
HT_5bf4ac2d5a20.insert(cuco::pair{KEY_5bf4ac2d5a20, buf_idx_5bf4ac2d5a20});
BUF_5bf4ac2d5a20[buf_idx_5bf4ac2d5a20 * 1 + 0] = tid;
}
__global__ void count_5bf4ac2e4f90(uint64_t* COUNT5bf4ac2d73e0, DBStringType* part__p_mfgr, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5bf4ac2d73e0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5bf4ac2e4f90(uint64_t* BUF_5bf4ac2d73e0, uint64_t* BUF_IDX_5bf4ac2d73e0, HASHTABLE_INSERT HT_5bf4ac2d73e0, DBStringType* part__p_mfgr, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5bf4ac2d73e0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_5bf4ac2d73e0 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_5bf4ac2d73e0 = atomicAdd((int*)BUF_IDX_5bf4ac2d73e0, 1);
HT_5bf4ac2d73e0.insert(cuco::pair{KEY_5bf4ac2d73e0, buf_idx_5bf4ac2d73e0});
BUF_5bf4ac2d73e0[buf_idx_5bf4ac2d73e0 * 1 + 0] = tid;
}
__global__ void count_5bf4ac27cbe0(uint64_t* COUNT5bf4ac2b6330, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5bf4ac2b6330, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5bf4ac27cbe0(uint64_t* BUF_5bf4ac2b6330, uint64_t* BUF_IDX_5bf4ac2b6330, HASHTABLE_INSERT HT_5bf4ac2b6330, DBI32Type* date__d_datekey, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5bf4ac2b6330 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5bf4ac2b6330 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_5bf4ac2b6330 = atomicAdd((int*)BUF_IDX_5bf4ac2b6330, 1);
HT_5bf4ac2b6330.insert(cuco::pair{KEY_5bf4ac2b6330, buf_idx_5bf4ac2b6330});
BUF_5bf4ac2b6330[buf_idx_5bf4ac2b6330 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5bf4ac2e71d0(uint64_t* BUF_5bf4ac2b6330, uint64_t* BUF_5bf4ac2d5a20, uint64_t* BUF_5bf4ac2d6980, uint64_t* BUF_5bf4ac2d73e0, HASHTABLE_INSERT HT_5bf4ac28be20, HASHTABLE_PROBE HT_5bf4ac2b6330, HASHTABLE_PROBE HT_5bf4ac2d5a20, HASHTABLE_PROBE HT_5bf4ac2d6980, HASHTABLE_PROBE HT_5bf4ac2d73e0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_5bf4ac2d6980 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5bf4ac2d6980 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5bf4ac2d6980.for_each(KEY_5bf4ac2d6980, [&] __device__ (auto const SLOT_5bf4ac2d6980) {

auto const [slot_first5bf4ac2d6980, slot_second5bf4ac2d6980] = SLOT_5bf4ac2d6980;
if (!(true)) return;
uint64_t KEY_5bf4ac2d5a20 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5bf4ac2d5a20 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_5bf4ac2d5a20.for_each(KEY_5bf4ac2d5a20, [&] __device__ (auto const SLOT_5bf4ac2d5a20) {

auto const [slot_first5bf4ac2d5a20, slot_second5bf4ac2d5a20] = SLOT_5bf4ac2d5a20;
if (!(true)) return;
uint64_t KEY_5bf4ac2d73e0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5bf4ac2d73e0 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_5bf4ac2d73e0.for_each(KEY_5bf4ac2d73e0, [&] __device__ (auto const SLOT_5bf4ac2d73e0) {

auto const [slot_first5bf4ac2d73e0, slot_second5bf4ac2d73e0] = SLOT_5bf4ac2d73e0;
if (!(true)) return;
uint64_t KEY_5bf4ac2b6330 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5bf4ac2b6330 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5bf4ac2b6330.for_each(KEY_5bf4ac2b6330, [&] __device__ (auto const SLOT_5bf4ac2b6330) {

auto const [slot_first5bf4ac2b6330, slot_second5bf4ac2b6330] = SLOT_5bf4ac2b6330;
if (!(true)) return;
uint64_t KEY_5bf4ac28be20 = 0;
auto reg_date__d_year = date__d_year[BUF_5bf4ac2b6330[slot_second5bf4ac2b6330 * 1 + 0]];

KEY_5bf4ac28be20 |= reg_date__d_year;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_5bf4ac2d5a20[slot_second5bf4ac2d5a20 * 1 + 0]];
KEY_5bf4ac28be20 <<= 16;
KEY_5bf4ac28be20 |= reg_customer__c_nation_encoded;
//Create aggregation hash table
HT_5bf4ac28be20.insert(cuco::pair{KEY_5bf4ac28be20, 1});
});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5bf4ac2e71d0(uint64_t* BUF_5bf4ac2b6330, uint64_t* BUF_5bf4ac2d5a20, uint64_t* BUF_5bf4ac2d6980, uint64_t* BUF_5bf4ac2d73e0, HASHTABLE_FIND HT_5bf4ac28be20, HASHTABLE_PROBE HT_5bf4ac2b6330, HASHTABLE_PROBE HT_5bf4ac2d5a20, HASHTABLE_PROBE HT_5bf4ac2d6980, HASHTABLE_PROBE HT_5bf4ac2d73e0, DBI16Type* KEY_5bf4ac28be20customer__c_nation_encoded, DBI32Type* KEY_5bf4ac28be20date__d_year, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, DBDecimalType* lineorder__lo_supplycost, size_t lineorder_size) {
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
uint64_t KEY_5bf4ac2d6980 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5bf4ac2d6980 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5bf4ac2d6980.for_each(KEY_5bf4ac2d6980, [&] __device__ (auto const SLOT_5bf4ac2d6980) {
auto const [slot_first5bf4ac2d6980, slot_second5bf4ac2d6980] = SLOT_5bf4ac2d6980;
if (!(true)) return;
uint64_t KEY_5bf4ac2d5a20 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5bf4ac2d5a20 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_5bf4ac2d5a20.for_each(KEY_5bf4ac2d5a20, [&] __device__ (auto const SLOT_5bf4ac2d5a20) {
auto const [slot_first5bf4ac2d5a20, slot_second5bf4ac2d5a20] = SLOT_5bf4ac2d5a20;
if (!(true)) return;
uint64_t KEY_5bf4ac2d73e0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5bf4ac2d73e0 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_5bf4ac2d73e0.for_each(KEY_5bf4ac2d73e0, [&] __device__ (auto const SLOT_5bf4ac2d73e0) {
auto const [slot_first5bf4ac2d73e0, slot_second5bf4ac2d73e0] = SLOT_5bf4ac2d73e0;
if (!(true)) return;
uint64_t KEY_5bf4ac2b6330 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5bf4ac2b6330 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5bf4ac2b6330.for_each(KEY_5bf4ac2b6330, [&] __device__ (auto const SLOT_5bf4ac2b6330) {
auto const [slot_first5bf4ac2b6330, slot_second5bf4ac2b6330] = SLOT_5bf4ac2b6330;
if (!(true)) return;
uint64_t KEY_5bf4ac28be20 = 0;
auto reg_date__d_year = date__d_year[BUF_5bf4ac2b6330[slot_second5bf4ac2b6330 * 1 + 0]];

KEY_5bf4ac28be20 |= reg_date__d_year;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_5bf4ac2d5a20[slot_second5bf4ac2d5a20 * 1 + 0]];
KEY_5bf4ac28be20 <<= 16;
KEY_5bf4ac28be20 |= reg_customer__c_nation_encoded;
//Aggregate in hashtable
auto buf_idx_5bf4ac28be20 = HT_5bf4ac28be20.find(KEY_5bf4ac28be20)->second;
auto reg_lineorder__lo_supplycost = lineorder__lo_supplycost[tid];
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_revenue) - (reg_lineorder__lo_supplycost);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5bf4ac28be20], reg_map0__tmp_attr1);
KEY_5bf4ac28be20date__d_year[buf_idx_5bf4ac28be20] = reg_date__d_year;
KEY_5bf4ac28be20customer__c_nation_encoded[buf_idx_5bf4ac28be20] = reg_customer__c_nation_encoded;
});
});
});
});
}
__global__ void count_5bf4ac2fa5f0(uint64_t* COUNT5bf4ac26b160, size_t COUNT5bf4ac28be20) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5bf4ac28be20) return;
//Materialize count
atomicAdd((int*)COUNT5bf4ac26b160, 1);
}
__global__ void main_5bf4ac2fa5f0(size_t COUNT5bf4ac28be20, DBDecimalType* MAT5bf4ac26b160aggr0__tmp_attr0, DBI16Type* MAT5bf4ac26b160customer__c_nation_encoded, DBI32Type* MAT5bf4ac26b160date__d_year, uint64_t* MAT_IDX5bf4ac26b160, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5bf4ac28be20) return;
//Materialize buffers
auto mat_idx5bf4ac26b160 = atomicAdd((int*)MAT_IDX5bf4ac26b160, 1);
auto reg_date__d_year = date__d_year[tid];
MAT5bf4ac26b160date__d_year[mat_idx5bf4ac26b160] = reg_date__d_year;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[tid];
MAT5bf4ac26b160customer__c_nation_encoded[mat_idx5bf4ac26b160] = reg_customer__c_nation_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5bf4ac26b160aggr0__tmp_attr0[mat_idx5bf4ac26b160] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map) {
//Materialize count
uint64_t* d_COUNT5bf4ac2d6980;
cudaMalloc(&d_COUNT5bf4ac2d6980, sizeof(uint64_t));
cudaMemset(d_COUNT5bf4ac2d6980, 0, sizeof(uint64_t));
count_5bf4ac2e2c80<<<std::ceil((float)supplier_size/32.), 32>>>(d_COUNT5bf4ac2d6980, d_supplier__s_region, supplier_size);
uint64_t COUNT5bf4ac2d6980;
cudaMemcpy(&COUNT5bf4ac2d6980, d_COUNT5bf4ac2d6980, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5bf4ac2d6980;
cudaMalloc(&d_BUF_IDX_5bf4ac2d6980, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5bf4ac2d6980, 0, sizeof(uint64_t));
uint64_t* d_BUF_5bf4ac2d6980;
cudaMalloc(&d_BUF_5bf4ac2d6980, sizeof(uint64_t) * COUNT5bf4ac2d6980 * 1);
auto d_HT_5bf4ac2d6980 = cuco::experimental::static_multimap{ (int)COUNT5bf4ac2d6980*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5bf4ac2e2c80<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_5bf4ac2d6980, d_BUF_IDX_5bf4ac2d6980, d_HT_5bf4ac2d6980.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT5bf4ac2d5a20;
cudaMalloc(&d_COUNT5bf4ac2d5a20, sizeof(uint64_t));
cudaMemset(d_COUNT5bf4ac2d5a20, 0, sizeof(uint64_t));
count_5bf4ac27c9a0<<<std::ceil((float)customer_size/32.), 32>>>(d_COUNT5bf4ac2d5a20, d_customer__c_region, customer_size);
uint64_t COUNT5bf4ac2d5a20;
cudaMemcpy(&COUNT5bf4ac2d5a20, d_COUNT5bf4ac2d5a20, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5bf4ac2d5a20;
cudaMalloc(&d_BUF_IDX_5bf4ac2d5a20, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5bf4ac2d5a20, 0, sizeof(uint64_t));
uint64_t* d_BUF_5bf4ac2d5a20;
cudaMalloc(&d_BUF_5bf4ac2d5a20, sizeof(uint64_t) * COUNT5bf4ac2d5a20 * 1);
auto d_HT_5bf4ac2d5a20 = cuco::experimental::static_multimap{ (int)COUNT5bf4ac2d5a20*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5bf4ac27c9a0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5bf4ac2d5a20, d_BUF_IDX_5bf4ac2d5a20, d_HT_5bf4ac2d5a20.ref(cuco::insert), d_customer__c_custkey, d_customer__c_region, customer_size);
//Materialize count
uint64_t* d_COUNT5bf4ac2d73e0;
cudaMalloc(&d_COUNT5bf4ac2d73e0, sizeof(uint64_t));
cudaMemset(d_COUNT5bf4ac2d73e0, 0, sizeof(uint64_t));
count_5bf4ac2e4f90<<<std::ceil((float)part_size/32.), 32>>>(d_COUNT5bf4ac2d73e0, d_part__p_mfgr, part_size);
uint64_t COUNT5bf4ac2d73e0;
cudaMemcpy(&COUNT5bf4ac2d73e0, d_COUNT5bf4ac2d73e0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5bf4ac2d73e0;
cudaMalloc(&d_BUF_IDX_5bf4ac2d73e0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5bf4ac2d73e0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5bf4ac2d73e0;
cudaMalloc(&d_BUF_5bf4ac2d73e0, sizeof(uint64_t) * COUNT5bf4ac2d73e0 * 1);
auto d_HT_5bf4ac2d73e0 = cuco::experimental::static_multimap{ (int)COUNT5bf4ac2d73e0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5bf4ac2e4f90<<<std::ceil((float)part_size/32.), 32>>>(d_BUF_5bf4ac2d73e0, d_BUF_IDX_5bf4ac2d73e0, d_HT_5bf4ac2d73e0.ref(cuco::insert), d_part__p_mfgr, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT5bf4ac2b6330;
cudaMalloc(&d_COUNT5bf4ac2b6330, sizeof(uint64_t));
cudaMemset(d_COUNT5bf4ac2b6330, 0, sizeof(uint64_t));
count_5bf4ac27cbe0<<<std::ceil((float)date_size/32.), 32>>>(d_COUNT5bf4ac2b6330, date_size);
uint64_t COUNT5bf4ac2b6330;
cudaMemcpy(&COUNT5bf4ac2b6330, d_COUNT5bf4ac2b6330, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5bf4ac2b6330;
cudaMalloc(&d_BUF_IDX_5bf4ac2b6330, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5bf4ac2b6330, 0, sizeof(uint64_t));
uint64_t* d_BUF_5bf4ac2b6330;
cudaMalloc(&d_BUF_5bf4ac2b6330, sizeof(uint64_t) * COUNT5bf4ac2b6330 * 1);
auto d_HT_5bf4ac2b6330 = cuco::experimental::static_multimap{ (int)COUNT5bf4ac2b6330*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5bf4ac27cbe0<<<std::ceil((float)date_size/32.), 32>>>(d_BUF_5bf4ac2b6330, d_BUF_IDX_5bf4ac2b6330, d_HT_5bf4ac2b6330.ref(cuco::insert), d_date__d_datekey, date_size);
//Create aggregation hash table
auto d_HT_5bf4ac28be20 = cuco::static_map{ (int)87950*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5bf4ac2e71d0<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_5bf4ac2b6330, d_BUF_5bf4ac2d5a20, d_BUF_5bf4ac2d6980, d_BUF_5bf4ac2d73e0, d_HT_5bf4ac28be20.ref(cuco::insert), d_HT_5bf4ac2b6330.ref(cuco::for_each), d_HT_5bf4ac2d5a20.ref(cuco::for_each), d_HT_5bf4ac2d6980.ref(cuco::for_each), d_HT_5bf4ac2d73e0.ref(cuco::for_each), d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
size_t COUNT5bf4ac28be20 = d_HT_5bf4ac28be20.size();
std::cout << "COUNT5bf4ac28be20: " << COUNT5bf4ac28be20 << std::endl;
thrust::device_vector<int64_t> keys_5bf4ac28be20(COUNT5bf4ac28be20), vals_5bf4ac28be20(COUNT5bf4ac28be20);
d_HT_5bf4ac28be20.retrieve_all(keys_5bf4ac28be20.begin(), vals_5bf4ac28be20.begin());
d_HT_5bf4ac28be20.clear();
int64_t* raw_keys5bf4ac28be20 = thrust::raw_pointer_cast(keys_5bf4ac28be20.data());
insertKeys<<<std::ceil((float)COUNT5bf4ac28be20/32.), 32>>>(raw_keys5bf4ac28be20, d_HT_5bf4ac28be20.ref(cuco::insert), COUNT5bf4ac28be20);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5bf4ac28be20);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5bf4ac28be20);
DBI32Type* d_KEY_5bf4ac28be20date__d_year;
cudaMalloc(&d_KEY_5bf4ac28be20date__d_year, sizeof(DBI32Type) * COUNT5bf4ac28be20);
cudaMemset(d_KEY_5bf4ac28be20date__d_year, 0, sizeof(DBI32Type) * COUNT5bf4ac28be20);
DBI16Type* d_KEY_5bf4ac28be20customer__c_nation_encoded;
cudaMalloc(&d_KEY_5bf4ac28be20customer__c_nation_encoded, sizeof(DBI16Type) * COUNT5bf4ac28be20);
cudaMemset(d_KEY_5bf4ac28be20customer__c_nation_encoded, 0, sizeof(DBI16Type) * COUNT5bf4ac28be20);
main_5bf4ac2e71d0<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_5bf4ac2b6330, d_BUF_5bf4ac2d5a20, d_BUF_5bf4ac2d6980, d_BUF_5bf4ac2d73e0, d_HT_5bf4ac28be20.ref(cuco::find), d_HT_5bf4ac2b6330.ref(cuco::for_each), d_HT_5bf4ac2d5a20.ref(cuco::for_each), d_HT_5bf4ac2d6980.ref(cuco::for_each), d_HT_5bf4ac2d73e0.ref(cuco::for_each), d_KEY_5bf4ac28be20customer__c_nation_encoded, d_KEY_5bf4ac28be20date__d_year, d_aggr0__tmp_attr0, d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, d_lineorder__lo_supplycost, lineorder_size);
//Materialize count
uint64_t* d_COUNT5bf4ac26b160;
cudaMalloc(&d_COUNT5bf4ac26b160, sizeof(uint64_t));
cudaMemset(d_COUNT5bf4ac26b160, 0, sizeof(uint64_t));
count_5bf4ac2fa5f0<<<std::ceil((float)COUNT5bf4ac28be20/32.), 32>>>(d_COUNT5bf4ac26b160, COUNT5bf4ac28be20);
uint64_t COUNT5bf4ac26b160;
cudaMemcpy(&COUNT5bf4ac26b160, d_COUNT5bf4ac26b160, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5bf4ac26b160;
cudaMalloc(&d_MAT_IDX5bf4ac26b160, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5bf4ac26b160, 0, sizeof(uint64_t));
auto MAT5bf4ac26b160date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5bf4ac26b160);
DBI32Type* d_MAT5bf4ac26b160date__d_year;
cudaMalloc(&d_MAT5bf4ac26b160date__d_year, sizeof(DBI32Type) * COUNT5bf4ac26b160);
auto MAT5bf4ac26b160customer__c_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5bf4ac26b160);
DBI16Type* d_MAT5bf4ac26b160customer__c_nation_encoded;
cudaMalloc(&d_MAT5bf4ac26b160customer__c_nation_encoded, sizeof(DBI16Type) * COUNT5bf4ac26b160);
auto MAT5bf4ac26b160aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5bf4ac26b160);
DBDecimalType* d_MAT5bf4ac26b160aggr0__tmp_attr0;
cudaMalloc(&d_MAT5bf4ac26b160aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5bf4ac26b160);
main_5bf4ac2fa5f0<<<std::ceil((float)COUNT5bf4ac28be20/32.), 32>>>(COUNT5bf4ac28be20, d_MAT5bf4ac26b160aggr0__tmp_attr0, d_MAT5bf4ac26b160customer__c_nation_encoded, d_MAT5bf4ac26b160date__d_year, d_MAT_IDX5bf4ac26b160, d_aggr0__tmp_attr0, d_KEY_5bf4ac28be20customer__c_nation_encoded, d_KEY_5bf4ac28be20date__d_year);
cudaMemcpy(MAT5bf4ac26b160date__d_year, d_MAT5bf4ac26b160date__d_year, sizeof(DBI32Type) * COUNT5bf4ac26b160, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5bf4ac26b160customer__c_nation_encoded, d_MAT5bf4ac26b160customer__c_nation_encoded, sizeof(DBI16Type) * COUNT5bf4ac26b160, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5bf4ac26b160aggr0__tmp_attr0, d_MAT5bf4ac26b160aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5bf4ac26b160, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5bf4ac26b160; i++) { std::cout << MAT5bf4ac26b160date__d_year[i] << "\t";
std::cout << customer__c_nation_map[MAT5bf4ac26b160customer__c_nation_encoded[i]] << "\t";
std::cout << MAT5bf4ac26b160aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_5bf4ac2d6980);
cudaFree(d_BUF_IDX_5bf4ac2d6980);
cudaFree(d_COUNT5bf4ac2d6980);
cudaFree(d_BUF_5bf4ac2d5a20);
cudaFree(d_BUF_IDX_5bf4ac2d5a20);
cudaFree(d_COUNT5bf4ac2d5a20);
cudaFree(d_BUF_5bf4ac2d73e0);
cudaFree(d_BUF_IDX_5bf4ac2d73e0);
cudaFree(d_COUNT5bf4ac2d73e0);
cudaFree(d_BUF_5bf4ac2b6330);
cudaFree(d_BUF_IDX_5bf4ac2b6330);
cudaFree(d_COUNT5bf4ac2b6330);
cudaFree(d_KEY_5bf4ac28be20customer__c_nation_encoded);
cudaFree(d_KEY_5bf4ac28be20date__d_year);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5bf4ac26b160);
cudaFree(d_MAT5bf4ac26b160aggr0__tmp_attr0);
cudaFree(d_MAT5bf4ac26b160customer__c_nation_encoded);
cudaFree(d_MAT5bf4ac26b160date__d_year);
cudaFree(d_MAT_IDX5bf4ac26b160);
free(MAT5bf4ac26b160aggr0__tmp_attr0);
free(MAT5bf4ac26b160customer__c_nation_encoded);
free(MAT5bf4ac26b160date__d_year);
}