#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5efabf2f9580(uint64_t* COUNT5efabf332630, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5efabf332630, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5efabf2f9580(uint64_t* BUF_5efabf332630, uint64_t* BUF_IDX_5efabf332630, HASHTABLE_INSERT HT_5efabf332630, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5efabf332630 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5efabf332630 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5efabf332630 = atomicAdd((int*)BUF_IDX_5efabf332630, 1);
HT_5efabf332630.insert(cuco::pair{KEY_5efabf332630, buf_idx_5efabf332630});
BUF_5efabf332630[buf_idx_5efabf332630 * 1 + 0] = tid;
}
__global__ void count_5efabf2f97c0(uint64_t* COUNT5efabf350440, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5efabf350440, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5efabf2f97c0(uint64_t* BUF_5efabf350440, uint64_t* BUF_IDX_5efabf350440, HASHTABLE_INSERT HT_5efabf350440, DBI32Type* customer__c_custkey, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5efabf350440 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5efabf350440 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_5efabf350440 = atomicAdd((int*)BUF_IDX_5efabf350440, 1);
HT_5efabf350440.insert(cuco::pair{KEY_5efabf350440, buf_idx_5efabf350440});
BUF_5efabf350440[buf_idx_5efabf350440 * 1 + 0] = tid;
}
__global__ void count_5efabf362f80(uint64_t* COUNT5efabf354720, DBStringType* part__p_mfgr, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5efabf354720, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5efabf362f80(uint64_t* BUF_5efabf354720, uint64_t* BUF_IDX_5efabf354720, HASHTABLE_INSERT HT_5efabf354720, DBStringType* part__p_mfgr, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5efabf354720 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_5efabf354720 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_5efabf354720 = atomicAdd((int*)BUF_IDX_5efabf354720, 1);
HT_5efabf354720.insert(cuco::pair{KEY_5efabf354720, buf_idx_5efabf354720});
BUF_5efabf354720[buf_idx_5efabf354720 * 1 + 0] = tid;
}
__global__ void count_5efabf352b40(uint64_t* COUNT5efabf3547e0, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5efabf3547e0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5efabf352b40(uint64_t* BUF_5efabf3547e0, uint64_t* BUF_IDX_5efabf3547e0, HASHTABLE_INSERT HT_5efabf3547e0, DBI32Type* date__d_datekey, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5efabf3547e0 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5efabf3547e0 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_5efabf3547e0 = atomicAdd((int*)BUF_IDX_5efabf3547e0, 1);
HT_5efabf3547e0.insert(cuco::pair{KEY_5efabf3547e0, buf_idx_5efabf3547e0});
BUF_5efabf3547e0[buf_idx_5efabf3547e0 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5efabf3657e0(uint64_t* BUF_5efabf332630, uint64_t* BUF_5efabf350440, uint64_t* BUF_5efabf354720, uint64_t* BUF_5efabf3547e0, HASHTABLE_INSERT HT_5efabf307cb0, HASHTABLE_PROBE HT_5efabf332630, HASHTABLE_PROBE HT_5efabf350440, HASHTABLE_PROBE HT_5efabf354720, HASHTABLE_PROBE HT_5efabf3547e0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_5efabf332630 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5efabf332630 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5efabf332630.for_each(KEY_5efabf332630, [&] __device__ (auto const SLOT_5efabf332630) {

auto const [slot_first5efabf332630, slot_second5efabf332630] = SLOT_5efabf332630;
if (!(true)) return;
uint64_t KEY_5efabf350440 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5efabf350440 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_5efabf350440.for_each(KEY_5efabf350440, [&] __device__ (auto const SLOT_5efabf350440) {

auto const [slot_first5efabf350440, slot_second5efabf350440] = SLOT_5efabf350440;
if (!(true)) return;
uint64_t KEY_5efabf354720 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5efabf354720 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_5efabf354720.for_each(KEY_5efabf354720, [&] __device__ (auto const SLOT_5efabf354720) {

auto const [slot_first5efabf354720, slot_second5efabf354720] = SLOT_5efabf354720;
if (!(true)) return;
uint64_t KEY_5efabf3547e0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5efabf3547e0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5efabf3547e0.for_each(KEY_5efabf3547e0, [&] __device__ (auto const SLOT_5efabf3547e0) {

auto const [slot_first5efabf3547e0, slot_second5efabf3547e0] = SLOT_5efabf3547e0;
if (!(true)) return;
uint64_t KEY_5efabf307cb0 = 0;
auto reg_date__d_year = date__d_year[BUF_5efabf3547e0[slot_second5efabf3547e0 * 1 + 0]];

KEY_5efabf307cb0 |= reg_date__d_year;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_5efabf350440[slot_second5efabf350440 * 1 + 0]];
KEY_5efabf307cb0 <<= 16;
KEY_5efabf307cb0 |= reg_customer__c_nation_encoded;
//Create aggregation hash table
HT_5efabf307cb0.insert(cuco::pair{KEY_5efabf307cb0, 1});
});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5efabf3657e0(uint64_t* BUF_5efabf332630, uint64_t* BUF_5efabf350440, uint64_t* BUF_5efabf354720, uint64_t* BUF_5efabf3547e0, HASHTABLE_FIND HT_5efabf307cb0, HASHTABLE_PROBE HT_5efabf332630, HASHTABLE_PROBE HT_5efabf350440, HASHTABLE_PROBE HT_5efabf354720, HASHTABLE_PROBE HT_5efabf3547e0, DBI16Type* KEY_5efabf307cb0customer__c_nation_encoded, DBI32Type* KEY_5efabf307cb0date__d_year, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, DBDecimalType* lineorder__lo_supplycost, size_t lineorder_size) {
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
uint64_t KEY_5efabf332630 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5efabf332630 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5efabf332630.for_each(KEY_5efabf332630, [&] __device__ (auto const SLOT_5efabf332630) {
auto const [slot_first5efabf332630, slot_second5efabf332630] = SLOT_5efabf332630;
if (!(true)) return;
uint64_t KEY_5efabf350440 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5efabf350440 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_5efabf350440.for_each(KEY_5efabf350440, [&] __device__ (auto const SLOT_5efabf350440) {
auto const [slot_first5efabf350440, slot_second5efabf350440] = SLOT_5efabf350440;
if (!(true)) return;
uint64_t KEY_5efabf354720 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5efabf354720 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_5efabf354720.for_each(KEY_5efabf354720, [&] __device__ (auto const SLOT_5efabf354720) {
auto const [slot_first5efabf354720, slot_second5efabf354720] = SLOT_5efabf354720;
if (!(true)) return;
uint64_t KEY_5efabf3547e0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5efabf3547e0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5efabf3547e0.for_each(KEY_5efabf3547e0, [&] __device__ (auto const SLOT_5efabf3547e0) {
auto const [slot_first5efabf3547e0, slot_second5efabf3547e0] = SLOT_5efabf3547e0;
if (!(true)) return;
uint64_t KEY_5efabf307cb0 = 0;
auto reg_date__d_year = date__d_year[BUF_5efabf3547e0[slot_second5efabf3547e0 * 1 + 0]];

KEY_5efabf307cb0 |= reg_date__d_year;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_5efabf350440[slot_second5efabf350440 * 1 + 0]];
KEY_5efabf307cb0 <<= 16;
KEY_5efabf307cb0 |= reg_customer__c_nation_encoded;
//Aggregate in hashtable
auto buf_idx_5efabf307cb0 = HT_5efabf307cb0.find(KEY_5efabf307cb0)->second;
auto reg_lineorder__lo_supplycost = lineorder__lo_supplycost[tid];
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_revenue) - (reg_lineorder__lo_supplycost);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5efabf307cb0], reg_map0__tmp_attr1);
KEY_5efabf307cb0date__d_year[buf_idx_5efabf307cb0] = reg_date__d_year;
KEY_5efabf307cb0customer__c_nation_encoded[buf_idx_5efabf307cb0] = reg_customer__c_nation_encoded;
});
});
});
});
}
__global__ void count_5efabf378b50(uint64_t* COUNT5efabf2e7da0, size_t COUNT5efabf307cb0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5efabf307cb0) return;
//Materialize count
atomicAdd((int*)COUNT5efabf2e7da0, 1);
}
__global__ void main_5efabf378b50(size_t COUNT5efabf307cb0, DBDecimalType* MAT5efabf2e7da0aggr0__tmp_attr0, DBI16Type* MAT5efabf2e7da0customer__c_nation_encoded, DBI32Type* MAT5efabf2e7da0date__d_year, uint64_t* MAT_IDX5efabf2e7da0, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5efabf307cb0) return;
//Materialize buffers
auto mat_idx5efabf2e7da0 = atomicAdd((int*)MAT_IDX5efabf2e7da0, 1);
auto reg_date__d_year = date__d_year[tid];
MAT5efabf2e7da0date__d_year[mat_idx5efabf2e7da0] = reg_date__d_year;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[tid];
MAT5efabf2e7da0customer__c_nation_encoded[mat_idx5efabf2e7da0] = reg_customer__c_nation_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5efabf2e7da0aggr0__tmp_attr0[mat_idx5efabf2e7da0] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT5efabf332630;
cudaMalloc(&d_COUNT5efabf332630, sizeof(uint64_t));
cudaMemset(d_COUNT5efabf332630, 0, sizeof(uint64_t));
count_5efabf2f9580<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT5efabf332630, d_supplier__s_region, supplier_size);
uint64_t COUNT5efabf332630;
cudaMemcpy(&COUNT5efabf332630, d_COUNT5efabf332630, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5efabf332630;
cudaMalloc(&d_BUF_IDX_5efabf332630, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5efabf332630, 0, sizeof(uint64_t));
uint64_t* d_BUF_5efabf332630;
cudaMalloc(&d_BUF_5efabf332630, sizeof(uint64_t) * COUNT5efabf332630 * 1);
auto d_HT_5efabf332630 = cuco::experimental::static_multimap{ (int)COUNT5efabf332630*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5efabf2f9580<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_5efabf332630, d_BUF_IDX_5efabf332630, d_HT_5efabf332630.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT5efabf350440;
cudaMalloc(&d_COUNT5efabf350440, sizeof(uint64_t));
cudaMemset(d_COUNT5efabf350440, 0, sizeof(uint64_t));
count_5efabf2f97c0<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT5efabf350440, d_customer__c_region, customer_size);
uint64_t COUNT5efabf350440;
cudaMemcpy(&COUNT5efabf350440, d_COUNT5efabf350440, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5efabf350440;
cudaMalloc(&d_BUF_IDX_5efabf350440, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5efabf350440, 0, sizeof(uint64_t));
uint64_t* d_BUF_5efabf350440;
cudaMalloc(&d_BUF_5efabf350440, sizeof(uint64_t) * COUNT5efabf350440 * 1);
auto d_HT_5efabf350440 = cuco::experimental::static_multimap{ (int)COUNT5efabf350440*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5efabf2f97c0<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_5efabf350440, d_BUF_IDX_5efabf350440, d_HT_5efabf350440.ref(cuco::insert), d_customer__c_custkey, d_customer__c_region, customer_size);
//Materialize count
uint64_t* d_COUNT5efabf354720;
cudaMalloc(&d_COUNT5efabf354720, sizeof(uint64_t));
cudaMemset(d_COUNT5efabf354720, 0, sizeof(uint64_t));
count_5efabf362f80<<<std::ceil((float)part_size/128.), 128>>>(d_COUNT5efabf354720, d_part__p_mfgr, part_size);
uint64_t COUNT5efabf354720;
cudaMemcpy(&COUNT5efabf354720, d_COUNT5efabf354720, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5efabf354720;
cudaMalloc(&d_BUF_IDX_5efabf354720, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5efabf354720, 0, sizeof(uint64_t));
uint64_t* d_BUF_5efabf354720;
cudaMalloc(&d_BUF_5efabf354720, sizeof(uint64_t) * COUNT5efabf354720 * 1);
auto d_HT_5efabf354720 = cuco::experimental::static_multimap{ (int)COUNT5efabf354720*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5efabf362f80<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_5efabf354720, d_BUF_IDX_5efabf354720, d_HT_5efabf354720.ref(cuco::insert), d_part__p_mfgr, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT5efabf3547e0;
cudaMalloc(&d_COUNT5efabf3547e0, sizeof(uint64_t));
cudaMemset(d_COUNT5efabf3547e0, 0, sizeof(uint64_t));
count_5efabf352b40<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT5efabf3547e0, date_size);
uint64_t COUNT5efabf3547e0;
cudaMemcpy(&COUNT5efabf3547e0, d_COUNT5efabf3547e0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5efabf3547e0;
cudaMalloc(&d_BUF_IDX_5efabf3547e0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5efabf3547e0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5efabf3547e0;
cudaMalloc(&d_BUF_5efabf3547e0, sizeof(uint64_t) * COUNT5efabf3547e0 * 1);
auto d_HT_5efabf3547e0 = cuco::experimental::static_multimap{ (int)COUNT5efabf3547e0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5efabf352b40<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_5efabf3547e0, d_BUF_IDX_5efabf3547e0, d_HT_5efabf3547e0.ref(cuco::insert), d_date__d_datekey, date_size);
//Create aggregation hash table
auto d_HT_5efabf307cb0 = cuco::static_map{ (int)87950*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5efabf3657e0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5efabf332630, d_BUF_5efabf350440, d_BUF_5efabf354720, d_BUF_5efabf3547e0, d_HT_5efabf307cb0.ref(cuco::insert), d_HT_5efabf332630.ref(cuco::for_each), d_HT_5efabf350440.ref(cuco::for_each), d_HT_5efabf354720.ref(cuco::for_each), d_HT_5efabf3547e0.ref(cuco::for_each), d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
size_t COUNT5efabf307cb0 = d_HT_5efabf307cb0.size();
thrust::device_vector<int64_t> keys_5efabf307cb0(COUNT5efabf307cb0), vals_5efabf307cb0(COUNT5efabf307cb0);
d_HT_5efabf307cb0.retrieve_all(keys_5efabf307cb0.begin(), vals_5efabf307cb0.begin());
d_HT_5efabf307cb0.clear();
int64_t* raw_keys5efabf307cb0 = thrust::raw_pointer_cast(keys_5efabf307cb0.data());
insertKeys<<<std::ceil((float)COUNT5efabf307cb0/128.), 128>>>(raw_keys5efabf307cb0, d_HT_5efabf307cb0.ref(cuco::insert), COUNT5efabf307cb0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5efabf307cb0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5efabf307cb0);
DBI32Type* d_KEY_5efabf307cb0date__d_year;
cudaMalloc(&d_KEY_5efabf307cb0date__d_year, sizeof(DBI32Type) * COUNT5efabf307cb0);
cudaMemset(d_KEY_5efabf307cb0date__d_year, 0, sizeof(DBI32Type) * COUNT5efabf307cb0);
DBI16Type* d_KEY_5efabf307cb0customer__c_nation_encoded;
cudaMalloc(&d_KEY_5efabf307cb0customer__c_nation_encoded, sizeof(DBI16Type) * COUNT5efabf307cb0);
cudaMemset(d_KEY_5efabf307cb0customer__c_nation_encoded, 0, sizeof(DBI16Type) * COUNT5efabf307cb0);
main_5efabf3657e0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5efabf332630, d_BUF_5efabf350440, d_BUF_5efabf354720, d_BUF_5efabf3547e0, d_HT_5efabf307cb0.ref(cuco::find), d_HT_5efabf332630.ref(cuco::for_each), d_HT_5efabf350440.ref(cuco::for_each), d_HT_5efabf354720.ref(cuco::for_each), d_HT_5efabf3547e0.ref(cuco::for_each), d_KEY_5efabf307cb0customer__c_nation_encoded, d_KEY_5efabf307cb0date__d_year, d_aggr0__tmp_attr0, d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, d_lineorder__lo_supplycost, lineorder_size);
//Materialize count
uint64_t* d_COUNT5efabf2e7da0;
cudaMalloc(&d_COUNT5efabf2e7da0, sizeof(uint64_t));
cudaMemset(d_COUNT5efabf2e7da0, 0, sizeof(uint64_t));
count_5efabf378b50<<<std::ceil((float)COUNT5efabf307cb0/128.), 128>>>(d_COUNT5efabf2e7da0, COUNT5efabf307cb0);
uint64_t COUNT5efabf2e7da0;
cudaMemcpy(&COUNT5efabf2e7da0, d_COUNT5efabf2e7da0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5efabf2e7da0;
cudaMalloc(&d_MAT_IDX5efabf2e7da0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5efabf2e7da0, 0, sizeof(uint64_t));
auto MAT5efabf2e7da0date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5efabf2e7da0);
DBI32Type* d_MAT5efabf2e7da0date__d_year;
cudaMalloc(&d_MAT5efabf2e7da0date__d_year, sizeof(DBI32Type) * COUNT5efabf2e7da0);
auto MAT5efabf2e7da0customer__c_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5efabf2e7da0);
DBI16Type* d_MAT5efabf2e7da0customer__c_nation_encoded;
cudaMalloc(&d_MAT5efabf2e7da0customer__c_nation_encoded, sizeof(DBI16Type) * COUNT5efabf2e7da0);
auto MAT5efabf2e7da0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5efabf2e7da0);
DBDecimalType* d_MAT5efabf2e7da0aggr0__tmp_attr0;
cudaMalloc(&d_MAT5efabf2e7da0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5efabf2e7da0);
main_5efabf378b50<<<std::ceil((float)COUNT5efabf307cb0/128.), 128>>>(COUNT5efabf307cb0, d_MAT5efabf2e7da0aggr0__tmp_attr0, d_MAT5efabf2e7da0customer__c_nation_encoded, d_MAT5efabf2e7da0date__d_year, d_MAT_IDX5efabf2e7da0, d_aggr0__tmp_attr0, d_KEY_5efabf307cb0customer__c_nation_encoded, d_KEY_5efabf307cb0date__d_year);
cudaMemcpy(MAT5efabf2e7da0date__d_year, d_MAT5efabf2e7da0date__d_year, sizeof(DBI32Type) * COUNT5efabf2e7da0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5efabf2e7da0customer__c_nation_encoded, d_MAT5efabf2e7da0customer__c_nation_encoded, sizeof(DBI16Type) * COUNT5efabf2e7da0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5efabf2e7da0aggr0__tmp_attr0, d_MAT5efabf2e7da0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5efabf2e7da0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5efabf2e7da0; i++) { std::cout << MAT5efabf2e7da0date__d_year[i] << "\t";
std::cout << customer__c_nation_map[MAT5efabf2e7da0customer__c_nation_encoded[i]] << "\t";
std::cout << MAT5efabf2e7da0aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_5efabf332630);
cudaFree(d_BUF_IDX_5efabf332630);
cudaFree(d_COUNT5efabf332630);
cudaFree(d_BUF_5efabf350440);
cudaFree(d_BUF_IDX_5efabf350440);
cudaFree(d_COUNT5efabf350440);
cudaFree(d_BUF_5efabf354720);
cudaFree(d_BUF_IDX_5efabf354720);
cudaFree(d_COUNT5efabf354720);
cudaFree(d_BUF_5efabf3547e0);
cudaFree(d_BUF_IDX_5efabf3547e0);
cudaFree(d_COUNT5efabf3547e0);
cudaFree(d_KEY_5efabf307cb0customer__c_nation_encoded);
cudaFree(d_KEY_5efabf307cb0date__d_year);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5efabf2e7da0);
cudaFree(d_MAT5efabf2e7da0aggr0__tmp_attr0);
cudaFree(d_MAT5efabf2e7da0customer__c_nation_encoded);
cudaFree(d_MAT5efabf2e7da0date__d_year);
cudaFree(d_MAT_IDX5efabf2e7da0);
free(MAT5efabf2e7da0aggr0__tmp_attr0);
free(MAT5efabf2e7da0customer__c_nation_encoded);
free(MAT5efabf2e7da0date__d_year);
}