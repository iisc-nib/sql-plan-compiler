#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_61b1de23ce00(uint64_t* COUNT61b1de22db60, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT61b1de22db60, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_61b1de23ce00(uint64_t* BUF_61b1de22db60, uint64_t* BUF_IDX_61b1de22db60, HASHTABLE_INSERT HT_61b1de22db60, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_61b1de22db60 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_61b1de22db60 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_61b1de22db60 = atomicAdd((int*)BUF_IDX_61b1de22db60, 1);
HT_61b1de22db60.insert(cuco::pair{KEY_61b1de22db60, buf_idx_61b1de22db60});
BUF_61b1de22db60[buf_idx_61b1de22db60 * 1 + 0] = tid;
}
__global__ void count_61b1de1d40d0(uint64_t* COUNT61b1de22dc90, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT61b1de22dc90, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_61b1de1d40d0(uint64_t* BUF_61b1de22dc90, uint64_t* BUF_IDX_61b1de22dc90, HASHTABLE_INSERT HT_61b1de22dc90, DBI32Type* customer__c_custkey, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_61b1de22dc90 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_61b1de22dc90 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_61b1de22dc90 = atomicAdd((int*)BUF_IDX_61b1de22dc90, 1);
HT_61b1de22dc90.insert(cuco::pair{KEY_61b1de22dc90, buf_idx_61b1de22dc90});
BUF_61b1de22dc90[buf_idx_61b1de22dc90 * 1 + 0] = tid;
}
__global__ void count_61b1de1d4310(uint64_t* COUNT61b1de231120, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT61b1de231120, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_61b1de1d4310(uint64_t* BUF_61b1de231120, uint64_t* BUF_IDX_61b1de231120, HASHTABLE_INSERT HT_61b1de231120, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_61b1de231120 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_61b1de231120 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_61b1de231120 = atomicAdd((int*)BUF_IDX_61b1de231120, 1);
HT_61b1de231120.insert(cuco::pair{KEY_61b1de231120, buf_idx_61b1de231120});
BUF_61b1de231120[buf_idx_61b1de231120 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_61b1de241e80(uint64_t* BUF_61b1de22db60, uint64_t* BUF_61b1de22dc90, uint64_t* BUF_61b1de231120, uint64_t* COUNT61b1de20e760, HASHTABLE_PROBE HT_61b1de22db60, HASHTABLE_PROBE HT_61b1de22dc90, HASHTABLE_PROBE HT_61b1de231120, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_61b1de22db60 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_61b1de22db60 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_61b1de22db60.for_each(KEY_61b1de22db60, [&] __device__ (auto const SLOT_61b1de22db60) {

auto const [slot_first61b1de22db60, slot_second61b1de22db60] = SLOT_61b1de22db60;
if (!(true)) return;
uint64_t KEY_61b1de22dc90 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_61b1de22dc90 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_61b1de22dc90.for_each(KEY_61b1de22dc90, [&] __device__ (auto const SLOT_61b1de22dc90) {

auto const [slot_first61b1de22dc90, slot_second61b1de22dc90] = SLOT_61b1de22dc90;
if (!(true)) return;
uint64_t KEY_61b1de231120 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_61b1de231120 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_61b1de231120.for_each(KEY_61b1de231120, [&] __device__ (auto const SLOT_61b1de231120) {

auto const [slot_first61b1de231120, slot_second61b1de231120] = SLOT_61b1de231120;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT61b1de20e760, 1);
});
});
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_61b1de241e80(uint64_t* BUF_61b1de20e760, uint64_t* BUF_61b1de22db60, uint64_t* BUF_61b1de22dc90, uint64_t* BUF_61b1de231120, uint64_t* BUF_IDX_61b1de20e760, HASHTABLE_INSERT HT_61b1de20e760, HASHTABLE_PROBE HT_61b1de22db60, HASHTABLE_PROBE HT_61b1de22dc90, HASHTABLE_PROBE HT_61b1de231120, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_61b1de22db60 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_61b1de22db60 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_61b1de22db60.for_each(KEY_61b1de22db60, [&] __device__ (auto const SLOT_61b1de22db60) {
auto const [slot_first61b1de22db60, slot_second61b1de22db60] = SLOT_61b1de22db60;
if (!(true)) return;
uint64_t KEY_61b1de22dc90 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_61b1de22dc90 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_61b1de22dc90.for_each(KEY_61b1de22dc90, [&] __device__ (auto const SLOT_61b1de22dc90) {
auto const [slot_first61b1de22dc90, slot_second61b1de22dc90] = SLOT_61b1de22dc90;
if (!(true)) return;
uint64_t KEY_61b1de231120 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_61b1de231120 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_61b1de231120.for_each(KEY_61b1de231120, [&] __device__ (auto const SLOT_61b1de231120) {
auto const [slot_first61b1de231120, slot_second61b1de231120] = SLOT_61b1de231120;
if (!(true)) return;
uint64_t KEY_61b1de20e760 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_61b1de20e760 |= reg_lineorder__lo_partkey;
// Insert hash table kernel;
auto buf_idx_61b1de20e760 = atomicAdd((int*)BUF_IDX_61b1de20e760, 1);
HT_61b1de20e760.insert(cuco::pair{KEY_61b1de20e760, buf_idx_61b1de20e760});
BUF_61b1de20e760[buf_idx_61b1de20e760 * 4 + 0] = BUF_61b1de231120[slot_second61b1de231120 * 1 + 0];
BUF_61b1de20e760[buf_idx_61b1de20e760 * 4 + 1] = BUF_61b1de22dc90[slot_second61b1de22dc90 * 1 + 0];
BUF_61b1de20e760[buf_idx_61b1de20e760 * 4 + 2] = BUF_61b1de22db60[slot_second61b1de22db60 * 1 + 0];
BUF_61b1de20e760[buf_idx_61b1de20e760 * 4 + 3] = tid;
});
});
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_61b1de23f620(uint64_t* BUF_61b1de20e760, HASHTABLE_INSERT HT_61b1de1e4150, HASHTABLE_PROBE HT_61b1de20e760, DBI32Type* date__d_year, DBI16Type* part__p_category_encoded, DBStringType* part__p_mfgr, DBI32Type* part__p_partkey, size_t part_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_61b1de20e760 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_61b1de20e760 |= reg_part__p_partkey;
//Probe Hash table
HT_61b1de20e760.for_each(KEY_61b1de20e760, [&] __device__ (auto const SLOT_61b1de20e760) {

auto const [slot_first61b1de20e760, slot_second61b1de20e760] = SLOT_61b1de20e760;
if (!(true)) return;
uint64_t KEY_61b1de1e4150 = 0;
auto reg_date__d_year = date__d_year[BUF_61b1de20e760[slot_second61b1de20e760 * 4 + 0]];

KEY_61b1de1e4150 |= reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_61b1de20e760[slot_second61b1de20e760 * 4 + 2]];
KEY_61b1de1e4150 <<= 16;
KEY_61b1de1e4150 |= reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[tid];
KEY_61b1de1e4150 <<= 16;
KEY_61b1de1e4150 |= reg_part__p_category_encoded;
//Create aggregation hash table
HT_61b1de1e4150.insert(cuco::pair{KEY_61b1de1e4150, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_61b1de23f620(uint64_t* BUF_61b1de20e760, HASHTABLE_FIND HT_61b1de1e4150, HASHTABLE_PROBE HT_61b1de20e760, DBI32Type* KEY_61b1de1e4150date__d_year, DBI16Type* KEY_61b1de1e4150part__p_category_encoded, DBI16Type* KEY_61b1de1e4150supplier__s_nation_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBDecimalType* lineorder__lo_revenue, DBDecimalType* lineorder__lo_supplycost, DBI16Type* part__p_category_encoded, DBStringType* part__p_mfgr, DBI32Type* part__p_partkey, size_t part_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_61b1de20e760 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_61b1de20e760 |= reg_part__p_partkey;
//Probe Hash table
HT_61b1de20e760.for_each(KEY_61b1de20e760, [&] __device__ (auto const SLOT_61b1de20e760) {
auto const [slot_first61b1de20e760, slot_second61b1de20e760] = SLOT_61b1de20e760;
if (!(true)) return;
uint64_t KEY_61b1de1e4150 = 0;
auto reg_date__d_year = date__d_year[BUF_61b1de20e760[slot_second61b1de20e760 * 4 + 0]];

KEY_61b1de1e4150 |= reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_61b1de20e760[slot_second61b1de20e760 * 4 + 2]];
KEY_61b1de1e4150 <<= 16;
KEY_61b1de1e4150 |= reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[tid];
KEY_61b1de1e4150 <<= 16;
KEY_61b1de1e4150 |= reg_part__p_category_encoded;
//Aggregate in hashtable
auto buf_idx_61b1de1e4150 = HT_61b1de1e4150.find(KEY_61b1de1e4150)->second;
auto reg_lineorder__lo_supplycost = lineorder__lo_supplycost[BUF_61b1de20e760[slot_second61b1de20e760 * 4 + 3]];
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[BUF_61b1de20e760[slot_second61b1de20e760 * 4 + 3]];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_revenue) - (reg_lineorder__lo_supplycost);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_61b1de1e4150], reg_map0__tmp_attr1);
KEY_61b1de1e4150date__d_year[buf_idx_61b1de1e4150] = reg_date__d_year;
KEY_61b1de1e4150supplier__s_nation_encoded[buf_idx_61b1de1e4150] = reg_supplier__s_nation_encoded;
KEY_61b1de1e4150part__p_category_encoded[buf_idx_61b1de1e4150] = reg_part__p_category_encoded;
});
}
__global__ void count_61b1de2520c0(uint64_t* COUNT61b1de1c3110, size_t COUNT61b1de1e4150) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT61b1de1e4150) return;
//Materialize count
atomicAdd((int*)COUNT61b1de1c3110, 1);
}
__global__ void main_61b1de2520c0(size_t COUNT61b1de1e4150, DBDecimalType* MAT61b1de1c3110aggr0__tmp_attr0, DBI32Type* MAT61b1de1c3110date__d_year, DBI16Type* MAT61b1de1c3110part__p_category_encoded, DBI16Type* MAT61b1de1c3110supplier__s_nation_encoded, uint64_t* MAT_IDX61b1de1c3110, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_category_encoded, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT61b1de1e4150) return;
//Materialize buffers
auto mat_idx61b1de1c3110 = atomicAdd((int*)MAT_IDX61b1de1c3110, 1);
auto reg_date__d_year = date__d_year[tid];
MAT61b1de1c3110date__d_year[mat_idx61b1de1c3110] = reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[tid];
MAT61b1de1c3110supplier__s_nation_encoded[mat_idx61b1de1c3110] = reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[tid];
MAT61b1de1c3110part__p_category_encoded[mat_idx61b1de1c3110] = reg_part__p_category_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT61b1de1c3110aggr0__tmp_attr0[mat_idx61b1de1c3110] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT61b1de22db60;
cudaMalloc(&d_COUNT61b1de22db60, sizeof(uint64_t));
cudaMemset(d_COUNT61b1de22db60, 0, sizeof(uint64_t));
count_61b1de23ce00<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT61b1de22db60, d_supplier__s_region, supplier_size);
uint64_t COUNT61b1de22db60;
cudaMemcpy(&COUNT61b1de22db60, d_COUNT61b1de22db60, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_61b1de22db60;
cudaMalloc(&d_BUF_IDX_61b1de22db60, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_61b1de22db60, 0, sizeof(uint64_t));
uint64_t* d_BUF_61b1de22db60;
cudaMalloc(&d_BUF_61b1de22db60, sizeof(uint64_t) * COUNT61b1de22db60 * 1);
auto d_HT_61b1de22db60 = cuco::experimental::static_multimap{ (int)COUNT61b1de22db60*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_61b1de23ce00<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_61b1de22db60, d_BUF_IDX_61b1de22db60, d_HT_61b1de22db60.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT61b1de22dc90;
cudaMalloc(&d_COUNT61b1de22dc90, sizeof(uint64_t));
cudaMemset(d_COUNT61b1de22dc90, 0, sizeof(uint64_t));
count_61b1de1d40d0<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT61b1de22dc90, d_customer__c_region, customer_size);
uint64_t COUNT61b1de22dc90;
cudaMemcpy(&COUNT61b1de22dc90, d_COUNT61b1de22dc90, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_61b1de22dc90;
cudaMalloc(&d_BUF_IDX_61b1de22dc90, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_61b1de22dc90, 0, sizeof(uint64_t));
uint64_t* d_BUF_61b1de22dc90;
cudaMalloc(&d_BUF_61b1de22dc90, sizeof(uint64_t) * COUNT61b1de22dc90 * 1);
auto d_HT_61b1de22dc90 = cuco::experimental::static_multimap{ (int)COUNT61b1de22dc90*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_61b1de1d40d0<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_61b1de22dc90, d_BUF_IDX_61b1de22dc90, d_HT_61b1de22dc90.ref(cuco::insert), d_customer__c_custkey, d_customer__c_region, customer_size);
//Materialize count
uint64_t* d_COUNT61b1de231120;
cudaMalloc(&d_COUNT61b1de231120, sizeof(uint64_t));
cudaMemset(d_COUNT61b1de231120, 0, sizeof(uint64_t));
count_61b1de1d4310<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT61b1de231120, d_date__d_year, date_size);
uint64_t COUNT61b1de231120;
cudaMemcpy(&COUNT61b1de231120, d_COUNT61b1de231120, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_61b1de231120;
cudaMalloc(&d_BUF_IDX_61b1de231120, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_61b1de231120, 0, sizeof(uint64_t));
uint64_t* d_BUF_61b1de231120;
cudaMalloc(&d_BUF_61b1de231120, sizeof(uint64_t) * COUNT61b1de231120 * 1);
auto d_HT_61b1de231120 = cuco::experimental::static_multimap{ (int)COUNT61b1de231120*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_61b1de1d4310<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_61b1de231120, d_BUF_IDX_61b1de231120, d_HT_61b1de231120.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Materialize count
uint64_t* d_COUNT61b1de20e760;
cudaMalloc(&d_COUNT61b1de20e760, sizeof(uint64_t));
cudaMemset(d_COUNT61b1de20e760, 0, sizeof(uint64_t));
count_61b1de241e80<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_61b1de22db60, d_BUF_61b1de22dc90, d_BUF_61b1de231120, d_COUNT61b1de20e760, d_HT_61b1de22db60.ref(cuco::for_each), d_HT_61b1de22dc90.ref(cuco::for_each), d_HT_61b1de231120.ref(cuco::for_each), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size);
uint64_t COUNT61b1de20e760;
cudaMemcpy(&COUNT61b1de20e760, d_COUNT61b1de20e760, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_61b1de20e760;
cudaMalloc(&d_BUF_IDX_61b1de20e760, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_61b1de20e760, 0, sizeof(uint64_t));
uint64_t* d_BUF_61b1de20e760;
cudaMalloc(&d_BUF_61b1de20e760, sizeof(uint64_t) * COUNT61b1de20e760 * 4);
auto d_HT_61b1de20e760 = cuco::experimental::static_multimap{ (int)COUNT61b1de20e760*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_61b1de241e80<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_61b1de20e760, d_BUF_61b1de22db60, d_BUF_61b1de22dc90, d_BUF_61b1de231120, d_BUF_IDX_61b1de20e760, d_HT_61b1de20e760.ref(cuco::insert), d_HT_61b1de22db60.ref(cuco::for_each), d_HT_61b1de22dc90.ref(cuco::for_each), d_HT_61b1de231120.ref(cuco::for_each), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
//Create aggregation hash table
auto d_HT_61b1de1e4150 = cuco::static_map{ (int)24650*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_61b1de23f620<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_61b1de20e760, d_HT_61b1de1e4150.ref(cuco::insert), d_HT_61b1de20e760.ref(cuco::for_each), d_date__d_year, d_part__p_category_encoded, d_part__p_mfgr, d_part__p_partkey, part_size, d_supplier__s_nation_encoded);
size_t COUNT61b1de1e4150 = d_HT_61b1de1e4150.size();
thrust::device_vector<int64_t> keys_61b1de1e4150(COUNT61b1de1e4150), vals_61b1de1e4150(COUNT61b1de1e4150);
d_HT_61b1de1e4150.retrieve_all(keys_61b1de1e4150.begin(), vals_61b1de1e4150.begin());
d_HT_61b1de1e4150.clear();
int64_t* raw_keys61b1de1e4150 = thrust::raw_pointer_cast(keys_61b1de1e4150.data());
insertKeys<<<std::ceil((float)COUNT61b1de1e4150/128.), 128>>>(raw_keys61b1de1e4150, d_HT_61b1de1e4150.ref(cuco::insert), COUNT61b1de1e4150);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT61b1de1e4150);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT61b1de1e4150);
DBI32Type* d_KEY_61b1de1e4150date__d_year;
cudaMalloc(&d_KEY_61b1de1e4150date__d_year, sizeof(DBI32Type) * COUNT61b1de1e4150);
cudaMemset(d_KEY_61b1de1e4150date__d_year, 0, sizeof(DBI32Type) * COUNT61b1de1e4150);
DBI16Type* d_KEY_61b1de1e4150supplier__s_nation_encoded;
cudaMalloc(&d_KEY_61b1de1e4150supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT61b1de1e4150);
cudaMemset(d_KEY_61b1de1e4150supplier__s_nation_encoded, 0, sizeof(DBI16Type) * COUNT61b1de1e4150);
DBI16Type* d_KEY_61b1de1e4150part__p_category_encoded;
cudaMalloc(&d_KEY_61b1de1e4150part__p_category_encoded, sizeof(DBI16Type) * COUNT61b1de1e4150);
cudaMemset(d_KEY_61b1de1e4150part__p_category_encoded, 0, sizeof(DBI16Type) * COUNT61b1de1e4150);
main_61b1de23f620<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_61b1de20e760, d_HT_61b1de1e4150.ref(cuco::find), d_HT_61b1de20e760.ref(cuco::for_each), d_KEY_61b1de1e4150date__d_year, d_KEY_61b1de1e4150part__p_category_encoded, d_KEY_61b1de1e4150supplier__s_nation_encoded, d_aggr0__tmp_attr0, d_date__d_year, d_lineorder__lo_revenue, d_lineorder__lo_supplycost, d_part__p_category_encoded, d_part__p_mfgr, d_part__p_partkey, part_size, d_supplier__s_nation_encoded);
//Materialize count
uint64_t* d_COUNT61b1de1c3110;
cudaMalloc(&d_COUNT61b1de1c3110, sizeof(uint64_t));
cudaMemset(d_COUNT61b1de1c3110, 0, sizeof(uint64_t));
count_61b1de2520c0<<<std::ceil((float)COUNT61b1de1e4150/128.), 128>>>(d_COUNT61b1de1c3110, COUNT61b1de1e4150);
uint64_t COUNT61b1de1c3110;
cudaMemcpy(&COUNT61b1de1c3110, d_COUNT61b1de1c3110, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX61b1de1c3110;
cudaMalloc(&d_MAT_IDX61b1de1c3110, sizeof(uint64_t));
cudaMemset(d_MAT_IDX61b1de1c3110, 0, sizeof(uint64_t));
auto MAT61b1de1c3110date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT61b1de1c3110);
DBI32Type* d_MAT61b1de1c3110date__d_year;
cudaMalloc(&d_MAT61b1de1c3110date__d_year, sizeof(DBI32Type) * COUNT61b1de1c3110);
auto MAT61b1de1c3110supplier__s_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT61b1de1c3110);
DBI16Type* d_MAT61b1de1c3110supplier__s_nation_encoded;
cudaMalloc(&d_MAT61b1de1c3110supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT61b1de1c3110);
auto MAT61b1de1c3110part__p_category_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT61b1de1c3110);
DBI16Type* d_MAT61b1de1c3110part__p_category_encoded;
cudaMalloc(&d_MAT61b1de1c3110part__p_category_encoded, sizeof(DBI16Type) * COUNT61b1de1c3110);
auto MAT61b1de1c3110aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT61b1de1c3110);
DBDecimalType* d_MAT61b1de1c3110aggr0__tmp_attr0;
cudaMalloc(&d_MAT61b1de1c3110aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT61b1de1c3110);
main_61b1de2520c0<<<std::ceil((float)COUNT61b1de1e4150/128.), 128>>>(COUNT61b1de1e4150, d_MAT61b1de1c3110aggr0__tmp_attr0, d_MAT61b1de1c3110date__d_year, d_MAT61b1de1c3110part__p_category_encoded, d_MAT61b1de1c3110supplier__s_nation_encoded, d_MAT_IDX61b1de1c3110, d_aggr0__tmp_attr0, d_KEY_61b1de1e4150date__d_year, d_KEY_61b1de1e4150part__p_category_encoded, d_KEY_61b1de1e4150supplier__s_nation_encoded);
cudaMemcpy(MAT61b1de1c3110date__d_year, d_MAT61b1de1c3110date__d_year, sizeof(DBI32Type) * COUNT61b1de1c3110, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT61b1de1c3110supplier__s_nation_encoded, d_MAT61b1de1c3110supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT61b1de1c3110, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT61b1de1c3110part__p_category_encoded, d_MAT61b1de1c3110part__p_category_encoded, sizeof(DBI16Type) * COUNT61b1de1c3110, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT61b1de1c3110aggr0__tmp_attr0, d_MAT61b1de1c3110aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT61b1de1c3110, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT61b1de1c3110; i++) { std::cout << "" << MAT61b1de1c3110date__d_year[i];
std::cout << "," << supplier__s_nation_map[MAT61b1de1c3110supplier__s_nation_encoded[i]];
std::cout << "," << part__p_category_map[MAT61b1de1c3110part__p_category_encoded[i]];
std::cout << "," << MAT61b1de1c3110aggr0__tmp_attr0[i];
std::cout << std::endl; }
cudaFree(d_BUF_61b1de22db60);
cudaFree(d_BUF_IDX_61b1de22db60);
cudaFree(d_COUNT61b1de22db60);
cudaFree(d_BUF_61b1de22dc90);
cudaFree(d_BUF_IDX_61b1de22dc90);
cudaFree(d_COUNT61b1de22dc90);
cudaFree(d_BUF_61b1de231120);
cudaFree(d_BUF_IDX_61b1de231120);
cudaFree(d_COUNT61b1de231120);
cudaFree(d_BUF_61b1de20e760);
cudaFree(d_BUF_IDX_61b1de20e760);
cudaFree(d_COUNT61b1de20e760);
cudaFree(d_KEY_61b1de1e4150date__d_year);
cudaFree(d_KEY_61b1de1e4150part__p_category_encoded);
cudaFree(d_KEY_61b1de1e4150supplier__s_nation_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT61b1de1c3110);
cudaFree(d_MAT61b1de1c3110aggr0__tmp_attr0);
cudaFree(d_MAT61b1de1c3110date__d_year);
cudaFree(d_MAT61b1de1c3110part__p_category_encoded);
cudaFree(d_MAT61b1de1c3110supplier__s_nation_encoded);
cudaFree(d_MAT_IDX61b1de1c3110);
free(MAT61b1de1c3110aggr0__tmp_attr0);
free(MAT61b1de1c3110date__d_year);
free(MAT61b1de1c3110part__p_category_encoded);
free(MAT61b1de1c3110supplier__s_nation_encoded);
}