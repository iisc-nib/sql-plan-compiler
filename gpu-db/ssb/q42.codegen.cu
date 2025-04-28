#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_599750539bd0(uint64_t* COUNT59975052adf0, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT59975052adf0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_599750539bd0(uint64_t* BUF_59975052adf0, uint64_t* BUF_IDX_59975052adf0, HASHTABLE_INSERT HT_59975052adf0, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_59975052adf0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_59975052adf0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_59975052adf0 = atomicAdd((int*)BUF_IDX_59975052adf0, 1);
HT_59975052adf0.insert(cuco::pair{KEY_59975052adf0, buf_idx_59975052adf0});
BUF_59975052adf0[buf_idx_59975052adf0 * 1 + 0] = tid;
}
__global__ void count_5997504d1a90(uint64_t* COUNT59975052a680, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT59975052a680, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5997504d1a90(uint64_t* BUF_59975052a680, uint64_t* BUF_IDX_59975052a680, HASHTABLE_INSERT HT_59975052a680, DBI32Type* customer__c_custkey, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_59975052a680 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_59975052a680 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_59975052a680 = atomicAdd((int*)BUF_IDX_59975052a680, 1);
HT_59975052a680.insert(cuco::pair{KEY_59975052a680, buf_idx_59975052a680});
BUF_59975052a680[buf_idx_59975052a680 * 1 + 0] = tid;
}
__global__ void count_5997504d1cd0(uint64_t* COUNT59975052aba0, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT59975052aba0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5997504d1cd0(uint64_t* BUF_59975052aba0, uint64_t* BUF_IDX_59975052aba0, HASHTABLE_INSERT HT_59975052aba0, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_59975052aba0 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_59975052aba0 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_59975052aba0 = atomicAdd((int*)BUF_IDX_59975052aba0, 1);
HT_59975052aba0.insert(cuco::pair{KEY_59975052aba0, buf_idx_59975052aba0});
BUF_59975052aba0[buf_idx_59975052aba0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_59975053e190(uint64_t* BUF_59975052a680, uint64_t* BUF_59975052aba0, uint64_t* BUF_59975052adf0, uint64_t* COUNT59975052dda0, HASHTABLE_PROBE HT_59975052a680, HASHTABLE_PROBE HT_59975052aba0, HASHTABLE_PROBE HT_59975052adf0, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_59975052adf0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_59975052adf0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_59975052adf0.for_each(KEY_59975052adf0, [&] __device__ (auto const SLOT_59975052adf0) {

auto const [slot_first59975052adf0, slot_second59975052adf0] = SLOT_59975052adf0;
if (!(true)) return;
uint64_t KEY_59975052a680 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_59975052a680 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_59975052a680.for_each(KEY_59975052a680, [&] __device__ (auto const SLOT_59975052a680) {

auto const [slot_first59975052a680, slot_second59975052a680] = SLOT_59975052a680;
if (!(true)) return;
uint64_t KEY_59975052aba0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_59975052aba0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_59975052aba0.for_each(KEY_59975052aba0, [&] __device__ (auto const SLOT_59975052aba0) {

auto const [slot_first59975052aba0, slot_second59975052aba0] = SLOT_59975052aba0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT59975052dda0, 1);
});
});
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_59975053e190(uint64_t* BUF_59975052a680, uint64_t* BUF_59975052aba0, uint64_t* BUF_59975052adf0, uint64_t* BUF_59975052dda0, uint64_t* BUF_IDX_59975052dda0, HASHTABLE_PROBE HT_59975052a680, HASHTABLE_PROBE HT_59975052aba0, HASHTABLE_PROBE HT_59975052adf0, HASHTABLE_INSERT HT_59975052dda0, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_59975052adf0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_59975052adf0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_59975052adf0.for_each(KEY_59975052adf0, [&] __device__ (auto const SLOT_59975052adf0) {
auto const [slot_first59975052adf0, slot_second59975052adf0] = SLOT_59975052adf0;
if (!(true)) return;
uint64_t KEY_59975052a680 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_59975052a680 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_59975052a680.for_each(KEY_59975052a680, [&] __device__ (auto const SLOT_59975052a680) {
auto const [slot_first59975052a680, slot_second59975052a680] = SLOT_59975052a680;
if (!(true)) return;
uint64_t KEY_59975052aba0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_59975052aba0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_59975052aba0.for_each(KEY_59975052aba0, [&] __device__ (auto const SLOT_59975052aba0) {
auto const [slot_first59975052aba0, slot_second59975052aba0] = SLOT_59975052aba0;
if (!(true)) return;
uint64_t KEY_59975052dda0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_59975052dda0 |= reg_lineorder__lo_partkey;
// Insert hash table kernel;
auto buf_idx_59975052dda0 = atomicAdd((int*)BUF_IDX_59975052dda0, 1);
HT_59975052dda0.insert(cuco::pair{KEY_59975052dda0, buf_idx_59975052dda0});
BUF_59975052dda0[buf_idx_59975052dda0 * 4 + 0] = BUF_59975052aba0[slot_second59975052aba0 * 1 + 0];
BUF_59975052dda0[buf_idx_59975052dda0 * 4 + 1] = BUF_59975052a680[slot_second59975052a680 * 1 + 0];
BUF_59975052dda0[buf_idx_59975052dda0 * 4 + 2] = BUF_59975052adf0[slot_second59975052adf0 * 1 + 0];
BUF_59975052dda0[buf_idx_59975052dda0 * 4 + 3] = tid;
});
});
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_59975053bee0(uint64_t* BUF_59975052dda0, HASHTABLE_INSERT HT_5997504e1a50, HASHTABLE_PROBE HT_59975052dda0, DBI32Type* date__d_year, DBI16Type* part__p_category_encoded, DBStringType* part__p_mfgr, DBI32Type* part__p_partkey, size_t part_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_59975052dda0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_59975052dda0 |= reg_part__p_partkey;
//Probe Hash table
HT_59975052dda0.for_each(KEY_59975052dda0, [&] __device__ (auto const SLOT_59975052dda0) {

auto const [slot_first59975052dda0, slot_second59975052dda0] = SLOT_59975052dda0;
if (!(true)) return;
uint64_t KEY_5997504e1a50 = 0;
auto reg_date__d_year = date__d_year[BUF_59975052dda0[slot_second59975052dda0 * 4 + 0]];

KEY_5997504e1a50 |= reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_59975052dda0[slot_second59975052dda0 * 4 + 2]];
KEY_5997504e1a50 <<= 16;
KEY_5997504e1a50 |= reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[tid];
KEY_5997504e1a50 <<= 16;
KEY_5997504e1a50 |= reg_part__p_category_encoded;
//Create aggregation hash table
HT_5997504e1a50.insert(cuco::pair{KEY_5997504e1a50, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_59975053bee0(uint64_t* BUF_59975052dda0, HASHTABLE_FIND HT_5997504e1a50, HASHTABLE_PROBE HT_59975052dda0, DBI32Type* KEY_5997504e1a50date__d_year, DBI16Type* KEY_5997504e1a50part__p_category_encoded, DBI16Type* KEY_5997504e1a50supplier__s_nation_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBDecimalType* lineorder__lo_revenue, DBDecimalType* lineorder__lo_supplycost, DBI16Type* part__p_category_encoded, DBStringType* part__p_mfgr, DBI32Type* part__p_partkey, size_t part_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_59975052dda0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_59975052dda0 |= reg_part__p_partkey;
//Probe Hash table
HT_59975052dda0.for_each(KEY_59975052dda0, [&] __device__ (auto const SLOT_59975052dda0) {
auto const [slot_first59975052dda0, slot_second59975052dda0] = SLOT_59975052dda0;
if (!(true)) return;
uint64_t KEY_5997504e1a50 = 0;
auto reg_date__d_year = date__d_year[BUF_59975052dda0[slot_second59975052dda0 * 4 + 0]];

KEY_5997504e1a50 |= reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_59975052dda0[slot_second59975052dda0 * 4 + 2]];
KEY_5997504e1a50 <<= 16;
KEY_5997504e1a50 |= reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[tid];
KEY_5997504e1a50 <<= 16;
KEY_5997504e1a50 |= reg_part__p_category_encoded;
//Aggregate in hashtable
auto buf_idx_5997504e1a50 = HT_5997504e1a50.find(KEY_5997504e1a50)->second;
auto reg_lineorder__lo_supplycost = lineorder__lo_supplycost[BUF_59975052dda0[slot_second59975052dda0 * 4 + 3]];
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[BUF_59975052dda0[slot_second59975052dda0 * 4 + 3]];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_revenue) - (reg_lineorder__lo_supplycost);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5997504e1a50], reg_map0__tmp_attr1);
KEY_5997504e1a50date__d_year[buf_idx_5997504e1a50] = reg_date__d_year;
KEY_5997504e1a50supplier__s_nation_encoded[buf_idx_5997504e1a50] = reg_supplier__s_nation_encoded;
KEY_5997504e1a50part__p_category_encoded[buf_idx_5997504e1a50] = reg_part__p_category_encoded;
});
}
__global__ void count_599750556750(uint64_t* COUNT5997504c0ad0, size_t COUNT5997504e1a50) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5997504e1a50) return;
//Materialize count
atomicAdd((int*)COUNT5997504c0ad0, 1);
}
__global__ void main_599750556750(size_t COUNT5997504e1a50, DBDecimalType* MAT5997504c0ad0aggr0__tmp_attr0, DBI32Type* MAT5997504c0ad0date__d_year, DBI16Type* MAT5997504c0ad0part__p_category_encoded, DBI16Type* MAT5997504c0ad0supplier__s_nation_encoded, uint64_t* MAT_IDX5997504c0ad0, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_category_encoded, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5997504e1a50) return;
//Materialize buffers
auto mat_idx5997504c0ad0 = atomicAdd((int*)MAT_IDX5997504c0ad0, 1);
auto reg_date__d_year = date__d_year[tid];
MAT5997504c0ad0date__d_year[mat_idx5997504c0ad0] = reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[tid];
MAT5997504c0ad0supplier__s_nation_encoded[mat_idx5997504c0ad0] = reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[tid];
MAT5997504c0ad0part__p_category_encoded[mat_idx5997504c0ad0] = reg_part__p_category_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5997504c0ad0aggr0__tmp_attr0[mat_idx5997504c0ad0] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map) {
//Materialize count
uint64_t* d_COUNT59975052adf0;
cudaMalloc(&d_COUNT59975052adf0, sizeof(uint64_t));
cudaMemset(d_COUNT59975052adf0, 0, sizeof(uint64_t));
count_599750539bd0<<<std::ceil((float)supplier_size/32.), 32>>>(d_COUNT59975052adf0, d_supplier__s_region, supplier_size);
uint64_t COUNT59975052adf0;
cudaMemcpy(&COUNT59975052adf0, d_COUNT59975052adf0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_59975052adf0;
cudaMalloc(&d_BUF_IDX_59975052adf0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59975052adf0, 0, sizeof(uint64_t));
uint64_t* d_BUF_59975052adf0;
cudaMalloc(&d_BUF_59975052adf0, sizeof(uint64_t) * COUNT59975052adf0 * 1);
auto d_HT_59975052adf0 = cuco::experimental::static_multimap{ (int)COUNT59975052adf0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_599750539bd0<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_59975052adf0, d_BUF_IDX_59975052adf0, d_HT_59975052adf0.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT59975052a680;
cudaMalloc(&d_COUNT59975052a680, sizeof(uint64_t));
cudaMemset(d_COUNT59975052a680, 0, sizeof(uint64_t));
count_5997504d1a90<<<std::ceil((float)customer_size/32.), 32>>>(d_COUNT59975052a680, d_customer__c_region, customer_size);
uint64_t COUNT59975052a680;
cudaMemcpy(&COUNT59975052a680, d_COUNT59975052a680, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_59975052a680;
cudaMalloc(&d_BUF_IDX_59975052a680, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59975052a680, 0, sizeof(uint64_t));
uint64_t* d_BUF_59975052a680;
cudaMalloc(&d_BUF_59975052a680, sizeof(uint64_t) * COUNT59975052a680 * 1);
auto d_HT_59975052a680 = cuco::experimental::static_multimap{ (int)COUNT59975052a680*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5997504d1a90<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_59975052a680, d_BUF_IDX_59975052a680, d_HT_59975052a680.ref(cuco::insert), d_customer__c_custkey, d_customer__c_region, customer_size);
//Materialize count
uint64_t* d_COUNT59975052aba0;
cudaMalloc(&d_COUNT59975052aba0, sizeof(uint64_t));
cudaMemset(d_COUNT59975052aba0, 0, sizeof(uint64_t));
count_5997504d1cd0<<<std::ceil((float)date_size/32.), 32>>>(d_COUNT59975052aba0, d_date__d_year, date_size);
uint64_t COUNT59975052aba0;
cudaMemcpy(&COUNT59975052aba0, d_COUNT59975052aba0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_59975052aba0;
cudaMalloc(&d_BUF_IDX_59975052aba0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59975052aba0, 0, sizeof(uint64_t));
uint64_t* d_BUF_59975052aba0;
cudaMalloc(&d_BUF_59975052aba0, sizeof(uint64_t) * COUNT59975052aba0 * 1);
auto d_HT_59975052aba0 = cuco::experimental::static_multimap{ (int)COUNT59975052aba0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5997504d1cd0<<<std::ceil((float)date_size/32.), 32>>>(d_BUF_59975052aba0, d_BUF_IDX_59975052aba0, d_HT_59975052aba0.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Materialize count
uint64_t* d_COUNT59975052dda0;
cudaMalloc(&d_COUNT59975052dda0, sizeof(uint64_t));
cudaMemset(d_COUNT59975052dda0, 0, sizeof(uint64_t));
count_59975053e190<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_59975052a680, d_BUF_59975052aba0, d_BUF_59975052adf0, d_COUNT59975052dda0, d_HT_59975052a680.ref(cuco::for_each), d_HT_59975052aba0.ref(cuco::for_each), d_HT_59975052adf0.ref(cuco::for_each), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size);
uint64_t COUNT59975052dda0;
cudaMemcpy(&COUNT59975052dda0, d_COUNT59975052dda0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_59975052dda0;
cudaMalloc(&d_BUF_IDX_59975052dda0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59975052dda0, 0, sizeof(uint64_t));
uint64_t* d_BUF_59975052dda0;
cudaMalloc(&d_BUF_59975052dda0, sizeof(uint64_t) * COUNT59975052dda0 * 4);
auto d_HT_59975052dda0 = cuco::experimental::static_multimap{ (int)COUNT59975052dda0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59975053e190<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_59975052a680, d_BUF_59975052aba0, d_BUF_59975052adf0, d_BUF_59975052dda0, d_BUF_IDX_59975052dda0, d_HT_59975052a680.ref(cuco::for_each), d_HT_59975052aba0.ref(cuco::for_each), d_HT_59975052adf0.ref(cuco::for_each), d_HT_59975052dda0.ref(cuco::insert), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
//Create aggregation hash table
auto d_HT_5997504e1a50 = cuco::static_map{ (int)24650*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_59975053bee0<<<std::ceil((float)part_size/32.), 32>>>(d_BUF_59975052dda0, d_HT_5997504e1a50.ref(cuco::insert), d_HT_59975052dda0.ref(cuco::for_each), d_date__d_year, , d_part__p_mfgr, d_part__p_partkey, part_size, d_supplier__s_nation_encoded);
size_t COUNT5997504e1a50 = d_HT_5997504e1a50.size();
thrust::device_vector<int64_t> keys_5997504e1a50(COUNT5997504e1a50), vals_5997504e1a50(COUNT5997504e1a50);
d_HT_5997504e1a50.retrieve_all(keys_5997504e1a50.begin(), vals_5997504e1a50.begin());
d_HT_5997504e1a50.clear();
int64_t* raw_keys5997504e1a50 = thrust::raw_pointer_cast(keys_5997504e1a50.data());
insertKeys<<<std::ceil((float)COUNT5997504e1a50/32.), 32>>>(raw_keys5997504e1a50, d_HT_5997504e1a50.ref(cuco::insert), COUNT5997504e1a50);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5997504e1a50);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5997504e1a50);
DBI32Type* d_KEY_5997504e1a50date__d_year;
cudaMalloc(&d_KEY_5997504e1a50date__d_year, sizeof(DBI32Type) * COUNT5997504e1a50);
cudaMemset(d_KEY_5997504e1a50date__d_year, 0, sizeof(DBI32Type) * COUNT5997504e1a50);
DBI16Type* d_KEY_5997504e1a50supplier__s_nation_encoded;
cudaMalloc(&d_KEY_5997504e1a50supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT5997504e1a50);
cudaMemset(d_KEY_5997504e1a50supplier__s_nation_encoded, 0, sizeof(DBI16Type) * COUNT5997504e1a50);
DBI16Type* d_KEY_5997504e1a50part__p_category_encoded;
cudaMalloc(&d_KEY_5997504e1a50part__p_category_encoded, sizeof(DBI16Type) * COUNT5997504e1a50);
cudaMemset(d_KEY_5997504e1a50part__p_category_encoded, 0, sizeof(DBI16Type) * COUNT5997504e1a50);
main_59975053bee0<<<std::ceil((float)part_size/32.), 32>>>(d_BUF_59975052dda0, d_HT_5997504e1a50.ref(cuco::find), d_HT_59975052dda0.ref(cuco::for_each), d_KEY_5997504e1a50date__d_year, d_KEY_5997504e1a50part__p_category_encoded, d_KEY_5997504e1a50supplier__s_nation_encoded, d_aggr0__tmp_attr0, d_date__d_year, d_lineorder__lo_revenue, d_lineorder__lo_supplycost, , d_part__p_mfgr, d_part__p_partkey, part_size, d_supplier__s_nation_encoded);
//Materialize count
uint64_t* d_COUNT5997504c0ad0;
cudaMalloc(&d_COUNT5997504c0ad0, sizeof(uint64_t));
cudaMemset(d_COUNT5997504c0ad0, 0, sizeof(uint64_t));
count_599750556750<<<std::ceil((float)COUNT5997504e1a50/32.), 32>>>(d_COUNT5997504c0ad0, COUNT5997504e1a50);
uint64_t COUNT5997504c0ad0;
cudaMemcpy(&COUNT5997504c0ad0, d_COUNT5997504c0ad0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5997504c0ad0;
cudaMalloc(&d_MAT_IDX5997504c0ad0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5997504c0ad0, 0, sizeof(uint64_t));
auto MAT5997504c0ad0date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5997504c0ad0);
DBI32Type* d_MAT5997504c0ad0date__d_year;
cudaMalloc(&d_MAT5997504c0ad0date__d_year, sizeof(DBI32Type) * COUNT5997504c0ad0);
auto MAT5997504c0ad0supplier__s_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5997504c0ad0);
DBI16Type* d_MAT5997504c0ad0supplier__s_nation_encoded;
cudaMalloc(&d_MAT5997504c0ad0supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT5997504c0ad0);
auto MAT5997504c0ad0part__p_category_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5997504c0ad0);
DBI16Type* d_MAT5997504c0ad0part__p_category_encoded;
cudaMalloc(&d_MAT5997504c0ad0part__p_category_encoded, sizeof(DBI16Type) * COUNT5997504c0ad0);
auto MAT5997504c0ad0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5997504c0ad0);
DBDecimalType* d_MAT5997504c0ad0aggr0__tmp_attr0;
cudaMalloc(&d_MAT5997504c0ad0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5997504c0ad0);
main_599750556750<<<std::ceil((float)COUNT5997504e1a50/32.), 32>>>(COUNT5997504e1a50, d_MAT5997504c0ad0aggr0__tmp_attr0, d_MAT5997504c0ad0date__d_year, d_MAT5997504c0ad0part__p_category_encoded, d_MAT5997504c0ad0supplier__s_nation_encoded, d_MAT_IDX5997504c0ad0, d_aggr0__tmp_attr0, d_KEY_5997504e1a50date__d_year, d_KEY_5997504e1a50part__p_category_encoded, d_KEY_5997504e1a50supplier__s_nation_encoded);
cudaMemcpy(MAT5997504c0ad0date__d_year, d_MAT5997504c0ad0date__d_year, sizeof(DBI32Type) * COUNT5997504c0ad0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5997504c0ad0supplier__s_nation_encoded, d_MAT5997504c0ad0supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT5997504c0ad0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5997504c0ad0part__p_category_encoded, d_MAT5997504c0ad0part__p_category_encoded, sizeof(DBI16Type) * COUNT5997504c0ad0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5997504c0ad0aggr0__tmp_attr0, d_MAT5997504c0ad0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5997504c0ad0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5997504c0ad0; i++) { std::cout << MAT5997504c0ad0date__d_year[i] << "\t";
std::cout << supplier__s_nation_map[MAT5997504c0ad0supplier__s_nation_encoded[i]] << "\t";
std::cout << part__p_category_map[MAT5997504c0ad0part__p_category_encoded[i]] << "\t";
std::cout << MAT5997504c0ad0aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_59975052adf0);
cudaFree(d_BUF_IDX_59975052adf0);
cudaFree(d_COUNT59975052adf0);
cudaFree(d_BUF_59975052a680);
cudaFree(d_BUF_IDX_59975052a680);
cudaFree(d_COUNT59975052a680);
cudaFree(d_BUF_59975052aba0);
cudaFree(d_BUF_IDX_59975052aba0);
cudaFree(d_COUNT59975052aba0);
cudaFree(d_BUF_59975052dda0);
cudaFree(d_BUF_IDX_59975052dda0);
cudaFree(d_COUNT59975052dda0);
cudaFree(d_KEY_5997504e1a50date__d_year);
cudaFree(d_KEY_5997504e1a50part__p_category_encoded);
cudaFree(d_KEY_5997504e1a50supplier__s_nation_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5997504c0ad0);
cudaFree(d_MAT5997504c0ad0aggr0__tmp_attr0);
cudaFree(d_MAT5997504c0ad0date__d_year);
cudaFree(d_MAT5997504c0ad0part__p_category_encoded);
cudaFree(d_MAT5997504c0ad0supplier__s_nation_encoded);
cudaFree(d_MAT_IDX5997504c0ad0);
free(MAT5997504c0ad0aggr0__tmp_attr0);
free(MAT5997504c0ad0date__d_year);
free(MAT5997504c0ad0part__p_category_encoded);
free(MAT5997504c0ad0supplier__s_nation_encoded);
}