#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_633d2e1a4e10(uint64_t* COUNT633d2e196490, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT633d2e196490, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_633d2e1a4e10(uint64_t* BUF_633d2e196490, uint64_t* BUF_IDX_633d2e196490, HASHTABLE_INSERT HT_633d2e196490, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_633d2e196490 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_633d2e196490 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_633d2e196490 = atomicAdd((int*)BUF_IDX_633d2e196490, 1);
HT_633d2e196490.insert(cuco::pair{KEY_633d2e196490, buf_idx_633d2e196490});
BUF_633d2e196490[buf_idx_633d2e196490 * 1 + 0] = tid;
}
__global__ void count_633d2e13f450(uint64_t* COUNT633d2e178960, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT633d2e178960, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_633d2e13f450(uint64_t* BUF_633d2e178960, uint64_t* BUF_IDX_633d2e178960, HASHTABLE_INSERT HT_633d2e178960, DBI32Type* customer__c_custkey, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_633d2e178960 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_633d2e178960 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_633d2e178960 = atomicAdd((int*)BUF_IDX_633d2e178960, 1);
HT_633d2e178960.insert(cuco::pair{KEY_633d2e178960, buf_idx_633d2e178960});
BUF_633d2e178960[buf_idx_633d2e178960 * 1 + 0] = tid;
}
__global__ void count_633d2e1a7630(uint64_t* COUNT633d2e19b8a0, DBStringType* part__p_mfgr, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT633d2e19b8a0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_633d2e1a7630(uint64_t* BUF_633d2e19b8a0, uint64_t* BUF_IDX_633d2e19b8a0, HASHTABLE_INSERT HT_633d2e19b8a0, DBStringType* part__p_mfgr, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_633d2e19b8a0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_633d2e19b8a0 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_633d2e19b8a0 = atomicAdd((int*)BUF_IDX_633d2e19b8a0, 1);
HT_633d2e19b8a0.insert(cuco::pair{KEY_633d2e19b8a0, buf_idx_633d2e19b8a0});
BUF_633d2e19b8a0[buf_idx_633d2e19b8a0 * 1 + 0] = tid;
}
__global__ void count_633d2e13f690(uint64_t* COUNT633d2e19b0b0, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT633d2e19b0b0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_633d2e13f690(uint64_t* BUF_633d2e19b0b0, uint64_t* BUF_IDX_633d2e19b0b0, HASHTABLE_INSERT HT_633d2e19b0b0, DBI32Type* date__d_datekey, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_633d2e19b0b0 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_633d2e19b0b0 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_633d2e19b0b0 = atomicAdd((int*)BUF_IDX_633d2e19b0b0, 1);
HT_633d2e19b0b0.insert(cuco::pair{KEY_633d2e19b0b0, buf_idx_633d2e19b0b0});
BUF_633d2e19b0b0[buf_idx_633d2e19b0b0 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_633d2e1a9e90(uint64_t* BUF_633d2e178960, uint64_t* BUF_633d2e196490, uint64_t* BUF_633d2e19b0b0, uint64_t* BUF_633d2e19b8a0, HASHTABLE_INSERT HT_633d2e14e9b0, HASHTABLE_PROBE HT_633d2e178960, HASHTABLE_PROBE HT_633d2e196490, HASHTABLE_PROBE HT_633d2e19b0b0, HASHTABLE_PROBE HT_633d2e19b8a0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_633d2e196490 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_633d2e196490 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_633d2e196490.for_each(KEY_633d2e196490, [&] __device__ (auto const SLOT_633d2e196490) {

auto const [slot_first633d2e196490, slot_second633d2e196490] = SLOT_633d2e196490;
if (!(true)) return;
uint64_t KEY_633d2e178960 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_633d2e178960 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_633d2e178960.for_each(KEY_633d2e178960, [&] __device__ (auto const SLOT_633d2e178960) {

auto const [slot_first633d2e178960, slot_second633d2e178960] = SLOT_633d2e178960;
if (!(true)) return;
uint64_t KEY_633d2e19b8a0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_633d2e19b8a0 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_633d2e19b8a0.for_each(KEY_633d2e19b8a0, [&] __device__ (auto const SLOT_633d2e19b8a0) {

auto const [slot_first633d2e19b8a0, slot_second633d2e19b8a0] = SLOT_633d2e19b8a0;
if (!(true)) return;
uint64_t KEY_633d2e19b0b0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_633d2e19b0b0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_633d2e19b0b0.for_each(KEY_633d2e19b0b0, [&] __device__ (auto const SLOT_633d2e19b0b0) {

auto const [slot_first633d2e19b0b0, slot_second633d2e19b0b0] = SLOT_633d2e19b0b0;
if (!(true)) return;
uint64_t KEY_633d2e14e9b0 = 0;
auto reg_date__d_year = date__d_year[BUF_633d2e19b0b0[slot_second633d2e19b0b0 * 1 + 0]];

KEY_633d2e14e9b0 |= reg_date__d_year;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_633d2e178960[slot_second633d2e178960 * 1 + 0]];
KEY_633d2e14e9b0 <<= 16;
KEY_633d2e14e9b0 |= reg_customer__c_nation_encoded;
//Create aggregation hash table
HT_633d2e14e9b0.insert(cuco::pair{KEY_633d2e14e9b0, 1});
});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_633d2e1a9e90(uint64_t* BUF_633d2e178960, uint64_t* BUF_633d2e196490, uint64_t* BUF_633d2e19b0b0, uint64_t* BUF_633d2e19b8a0, HASHTABLE_FIND HT_633d2e14e9b0, HASHTABLE_PROBE HT_633d2e178960, HASHTABLE_PROBE HT_633d2e196490, HASHTABLE_PROBE HT_633d2e19b0b0, HASHTABLE_PROBE HT_633d2e19b8a0, DBI16Type* KEY_633d2e14e9b0customer__c_nation_encoded, DBI32Type* KEY_633d2e14e9b0date__d_year, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, DBDecimalType* lineorder__lo_supplycost, size_t lineorder_size) {
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
uint64_t KEY_633d2e196490 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_633d2e196490 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_633d2e196490.for_each(KEY_633d2e196490, [&] __device__ (auto const SLOT_633d2e196490) {
auto const [slot_first633d2e196490, slot_second633d2e196490] = SLOT_633d2e196490;
if (!(true)) return;
uint64_t KEY_633d2e178960 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_633d2e178960 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_633d2e178960.for_each(KEY_633d2e178960, [&] __device__ (auto const SLOT_633d2e178960) {
auto const [slot_first633d2e178960, slot_second633d2e178960] = SLOT_633d2e178960;
if (!(true)) return;
uint64_t KEY_633d2e19b8a0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_633d2e19b8a0 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_633d2e19b8a0.for_each(KEY_633d2e19b8a0, [&] __device__ (auto const SLOT_633d2e19b8a0) {
auto const [slot_first633d2e19b8a0, slot_second633d2e19b8a0] = SLOT_633d2e19b8a0;
if (!(true)) return;
uint64_t KEY_633d2e19b0b0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_633d2e19b0b0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_633d2e19b0b0.for_each(KEY_633d2e19b0b0, [&] __device__ (auto const SLOT_633d2e19b0b0) {
auto const [slot_first633d2e19b0b0, slot_second633d2e19b0b0] = SLOT_633d2e19b0b0;
if (!(true)) return;
uint64_t KEY_633d2e14e9b0 = 0;
auto reg_date__d_year = date__d_year[BUF_633d2e19b0b0[slot_second633d2e19b0b0 * 1 + 0]];

KEY_633d2e14e9b0 |= reg_date__d_year;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_633d2e178960[slot_second633d2e178960 * 1 + 0]];
KEY_633d2e14e9b0 <<= 16;
KEY_633d2e14e9b0 |= reg_customer__c_nation_encoded;
//Aggregate in hashtable
auto buf_idx_633d2e14e9b0 = HT_633d2e14e9b0.find(KEY_633d2e14e9b0)->second;
auto reg_lineorder__lo_supplycost = lineorder__lo_supplycost[tid];
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_revenue) - (reg_lineorder__lo_supplycost);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_633d2e14e9b0], reg_map0__tmp_attr1);
KEY_633d2e14e9b0date__d_year[buf_idx_633d2e14e9b0] = reg_date__d_year;
KEY_633d2e14e9b0customer__c_nation_encoded[buf_idx_633d2e14e9b0] = reg_customer__c_nation_encoded;
});
});
});
});
}
__global__ void count_633d2e1bd580(uint64_t* COUNT633d2e12db50, size_t COUNT633d2e14e9b0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT633d2e14e9b0) return;
//Materialize count
atomicAdd((int*)COUNT633d2e12db50, 1);
}
__global__ void main_633d2e1bd580(size_t COUNT633d2e14e9b0, DBDecimalType* MAT633d2e12db50aggr0__tmp_attr0, DBI16Type* MAT633d2e12db50customer__c_nation_encoded, DBI32Type* MAT633d2e12db50date__d_year, uint64_t* MAT_IDX633d2e12db50, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT633d2e14e9b0) return;
//Materialize buffers
auto mat_idx633d2e12db50 = atomicAdd((int*)MAT_IDX633d2e12db50, 1);
auto reg_date__d_year = date__d_year[tid];
MAT633d2e12db50date__d_year[mat_idx633d2e12db50] = reg_date__d_year;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[tid];
MAT633d2e12db50customer__c_nation_encoded[mat_idx633d2e12db50] = reg_customer__c_nation_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT633d2e12db50aggr0__tmp_attr0[mat_idx633d2e12db50] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT633d2e196490;
cudaMalloc(&d_COUNT633d2e196490, sizeof(uint64_t));
cudaMemset(d_COUNT633d2e196490, 0, sizeof(uint64_t));
count_633d2e1a4e10<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT633d2e196490, d_supplier__s_region, supplier_size);
uint64_t COUNT633d2e196490;
cudaMemcpy(&COUNT633d2e196490, d_COUNT633d2e196490, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_633d2e196490;
cudaMalloc(&d_BUF_IDX_633d2e196490, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_633d2e196490, 0, sizeof(uint64_t));
uint64_t* d_BUF_633d2e196490;
cudaMalloc(&d_BUF_633d2e196490, sizeof(uint64_t) * COUNT633d2e196490 * 1);
auto d_HT_633d2e196490 = cuco::experimental::static_multimap{ (int)COUNT633d2e196490*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_633d2e1a4e10<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_633d2e196490, d_BUF_IDX_633d2e196490, d_HT_633d2e196490.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT633d2e178960;
cudaMalloc(&d_COUNT633d2e178960, sizeof(uint64_t));
cudaMemset(d_COUNT633d2e178960, 0, sizeof(uint64_t));
count_633d2e13f450<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT633d2e178960, d_customer__c_region, customer_size);
uint64_t COUNT633d2e178960;
cudaMemcpy(&COUNT633d2e178960, d_COUNT633d2e178960, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_633d2e178960;
cudaMalloc(&d_BUF_IDX_633d2e178960, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_633d2e178960, 0, sizeof(uint64_t));
uint64_t* d_BUF_633d2e178960;
cudaMalloc(&d_BUF_633d2e178960, sizeof(uint64_t) * COUNT633d2e178960 * 1);
auto d_HT_633d2e178960 = cuco::experimental::static_multimap{ (int)COUNT633d2e178960*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_633d2e13f450<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_633d2e178960, d_BUF_IDX_633d2e178960, d_HT_633d2e178960.ref(cuco::insert), d_customer__c_custkey, d_customer__c_region, customer_size);
//Materialize count
uint64_t* d_COUNT633d2e19b8a0;
cudaMalloc(&d_COUNT633d2e19b8a0, sizeof(uint64_t));
cudaMemset(d_COUNT633d2e19b8a0, 0, sizeof(uint64_t));
count_633d2e1a7630<<<std::ceil((float)part_size/128.), 128>>>(d_COUNT633d2e19b8a0, d_part__p_mfgr, part_size);
uint64_t COUNT633d2e19b8a0;
cudaMemcpy(&COUNT633d2e19b8a0, d_COUNT633d2e19b8a0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_633d2e19b8a0;
cudaMalloc(&d_BUF_IDX_633d2e19b8a0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_633d2e19b8a0, 0, sizeof(uint64_t));
uint64_t* d_BUF_633d2e19b8a0;
cudaMalloc(&d_BUF_633d2e19b8a0, sizeof(uint64_t) * COUNT633d2e19b8a0 * 1);
auto d_HT_633d2e19b8a0 = cuco::experimental::static_multimap{ (int)COUNT633d2e19b8a0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_633d2e1a7630<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_633d2e19b8a0, d_BUF_IDX_633d2e19b8a0, d_HT_633d2e19b8a0.ref(cuco::insert), d_part__p_mfgr, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT633d2e19b0b0;
cudaMalloc(&d_COUNT633d2e19b0b0, sizeof(uint64_t));
cudaMemset(d_COUNT633d2e19b0b0, 0, sizeof(uint64_t));
count_633d2e13f690<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT633d2e19b0b0, date_size);
uint64_t COUNT633d2e19b0b0;
cudaMemcpy(&COUNT633d2e19b0b0, d_COUNT633d2e19b0b0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_633d2e19b0b0;
cudaMalloc(&d_BUF_IDX_633d2e19b0b0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_633d2e19b0b0, 0, sizeof(uint64_t));
uint64_t* d_BUF_633d2e19b0b0;
cudaMalloc(&d_BUF_633d2e19b0b0, sizeof(uint64_t) * COUNT633d2e19b0b0 * 1);
auto d_HT_633d2e19b0b0 = cuco::experimental::static_multimap{ (int)COUNT633d2e19b0b0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_633d2e13f690<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_633d2e19b0b0, d_BUF_IDX_633d2e19b0b0, d_HT_633d2e19b0b0.ref(cuco::insert), d_date__d_datekey, date_size);
//Create aggregation hash table
auto d_HT_633d2e14e9b0 = cuco::static_map{ (int)87950*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_633d2e1a9e90<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_633d2e178960, d_BUF_633d2e196490, d_BUF_633d2e19b0b0, d_BUF_633d2e19b8a0, d_HT_633d2e14e9b0.ref(cuco::insert), d_HT_633d2e178960.ref(cuco::for_each), d_HT_633d2e196490.ref(cuco::for_each), d_HT_633d2e19b0b0.ref(cuco::for_each), d_HT_633d2e19b8a0.ref(cuco::for_each), d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
size_t COUNT633d2e14e9b0 = d_HT_633d2e14e9b0.size();
thrust::device_vector<int64_t> keys_633d2e14e9b0(COUNT633d2e14e9b0), vals_633d2e14e9b0(COUNT633d2e14e9b0);
d_HT_633d2e14e9b0.retrieve_all(keys_633d2e14e9b0.begin(), vals_633d2e14e9b0.begin());
d_HT_633d2e14e9b0.clear();
int64_t* raw_keys633d2e14e9b0 = thrust::raw_pointer_cast(keys_633d2e14e9b0.data());
insertKeys<<<std::ceil((float)COUNT633d2e14e9b0/128.), 128>>>(raw_keys633d2e14e9b0, d_HT_633d2e14e9b0.ref(cuco::insert), COUNT633d2e14e9b0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT633d2e14e9b0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT633d2e14e9b0);
DBI32Type* d_KEY_633d2e14e9b0date__d_year;
cudaMalloc(&d_KEY_633d2e14e9b0date__d_year, sizeof(DBI32Type) * COUNT633d2e14e9b0);
cudaMemset(d_KEY_633d2e14e9b0date__d_year, 0, sizeof(DBI32Type) * COUNT633d2e14e9b0);
DBI16Type* d_KEY_633d2e14e9b0customer__c_nation_encoded;
cudaMalloc(&d_KEY_633d2e14e9b0customer__c_nation_encoded, sizeof(DBI16Type) * COUNT633d2e14e9b0);
cudaMemset(d_KEY_633d2e14e9b0customer__c_nation_encoded, 0, sizeof(DBI16Type) * COUNT633d2e14e9b0);
main_633d2e1a9e90<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_633d2e178960, d_BUF_633d2e196490, d_BUF_633d2e19b0b0, d_BUF_633d2e19b8a0, d_HT_633d2e14e9b0.ref(cuco::find), d_HT_633d2e178960.ref(cuco::for_each), d_HT_633d2e196490.ref(cuco::for_each), d_HT_633d2e19b0b0.ref(cuco::for_each), d_HT_633d2e19b8a0.ref(cuco::for_each), d_KEY_633d2e14e9b0customer__c_nation_encoded, d_KEY_633d2e14e9b0date__d_year, d_aggr0__tmp_attr0, d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, d_lineorder__lo_supplycost, lineorder_size);
//Materialize count
uint64_t* d_COUNT633d2e12db50;
cudaMalloc(&d_COUNT633d2e12db50, sizeof(uint64_t));
cudaMemset(d_COUNT633d2e12db50, 0, sizeof(uint64_t));
count_633d2e1bd580<<<std::ceil((float)COUNT633d2e14e9b0/128.), 128>>>(d_COUNT633d2e12db50, COUNT633d2e14e9b0);
uint64_t COUNT633d2e12db50;
cudaMemcpy(&COUNT633d2e12db50, d_COUNT633d2e12db50, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX633d2e12db50;
cudaMalloc(&d_MAT_IDX633d2e12db50, sizeof(uint64_t));
cudaMemset(d_MAT_IDX633d2e12db50, 0, sizeof(uint64_t));
auto MAT633d2e12db50date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT633d2e12db50);
DBI32Type* d_MAT633d2e12db50date__d_year;
cudaMalloc(&d_MAT633d2e12db50date__d_year, sizeof(DBI32Type) * COUNT633d2e12db50);
auto MAT633d2e12db50customer__c_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT633d2e12db50);
DBI16Type* d_MAT633d2e12db50customer__c_nation_encoded;
cudaMalloc(&d_MAT633d2e12db50customer__c_nation_encoded, sizeof(DBI16Type) * COUNT633d2e12db50);
auto MAT633d2e12db50aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT633d2e12db50);
DBDecimalType* d_MAT633d2e12db50aggr0__tmp_attr0;
cudaMalloc(&d_MAT633d2e12db50aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT633d2e12db50);
main_633d2e1bd580<<<std::ceil((float)COUNT633d2e14e9b0/128.), 128>>>(COUNT633d2e14e9b0, d_MAT633d2e12db50aggr0__tmp_attr0, d_MAT633d2e12db50customer__c_nation_encoded, d_MAT633d2e12db50date__d_year, d_MAT_IDX633d2e12db50, d_aggr0__tmp_attr0, d_KEY_633d2e14e9b0customer__c_nation_encoded, d_KEY_633d2e14e9b0date__d_year);
cudaMemcpy(MAT633d2e12db50date__d_year, d_MAT633d2e12db50date__d_year, sizeof(DBI32Type) * COUNT633d2e12db50, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT633d2e12db50customer__c_nation_encoded, d_MAT633d2e12db50customer__c_nation_encoded, sizeof(DBI16Type) * COUNT633d2e12db50, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT633d2e12db50aggr0__tmp_attr0, d_MAT633d2e12db50aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT633d2e12db50, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT633d2e12db50; i++) { std::cout << "" << MAT633d2e12db50date__d_year[i];
std::cout << "," << customer__c_nation_map[MAT633d2e12db50customer__c_nation_encoded[i]];
std::cout << "," << MAT633d2e12db50aggr0__tmp_attr0[i];
std::cout << std::endl; }
cudaFree(d_BUF_633d2e196490);
cudaFree(d_BUF_IDX_633d2e196490);
cudaFree(d_COUNT633d2e196490);
cudaFree(d_BUF_633d2e178960);
cudaFree(d_BUF_IDX_633d2e178960);
cudaFree(d_COUNT633d2e178960);
cudaFree(d_BUF_633d2e19b8a0);
cudaFree(d_BUF_IDX_633d2e19b8a0);
cudaFree(d_COUNT633d2e19b8a0);
cudaFree(d_BUF_633d2e19b0b0);
cudaFree(d_BUF_IDX_633d2e19b0b0);
cudaFree(d_COUNT633d2e19b0b0);
cudaFree(d_KEY_633d2e14e9b0customer__c_nation_encoded);
cudaFree(d_KEY_633d2e14e9b0date__d_year);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT633d2e12db50);
cudaFree(d_MAT633d2e12db50aggr0__tmp_attr0);
cudaFree(d_MAT633d2e12db50customer__c_nation_encoded);
cudaFree(d_MAT633d2e12db50date__d_year);
cudaFree(d_MAT_IDX633d2e12db50);
free(MAT633d2e12db50aggr0__tmp_attr0);
free(MAT633d2e12db50customer__c_nation_encoded);
free(MAT633d2e12db50date__d_year);
}