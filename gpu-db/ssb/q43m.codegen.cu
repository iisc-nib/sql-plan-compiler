#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5bd044c2c000(uint64_t* COUNT5bd044c23360, DBStringType* supplier__s_nation, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_nation = supplier__s_nation[tid];
if (!(evaluatePredicate(reg_supplier__s_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5bd044c23360, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5bd044c2c000(uint64_t* BUF_5bd044c23360, uint64_t* BUF_IDX_5bd044c23360, HASHTABLE_INSERT HT_5bd044c23360, DBStringType* supplier__s_nation, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_nation = supplier__s_nation[tid];
if (!(evaluatePredicate(reg_supplier__s_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5bd044c23360 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5bd044c23360 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5bd044c23360 = atomicAdd((int*)BUF_IDX_5bd044c23360, 1);
HT_5bd044c23360.insert(cuco::pair{KEY_5bd044c23360, buf_idx_5bd044c23360});
BUF_5bd044c23360[buf_idx_5bd044c23360 * 1 + 0] = tid;
}
__global__ void count_5bd044c2e9c0(uint64_t* COUNT5bd044bfd7c0, DBStringType* part__p_category, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_category = part__p_category[tid];
if (!(evaluatePredicate(reg_part__p_category, "MFGR#14", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5bd044bfd7c0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5bd044c2e9c0(uint64_t* BUF_5bd044bfd7c0, uint64_t* BUF_IDX_5bd044bfd7c0, HASHTABLE_INSERT HT_5bd044bfd7c0, DBStringType* part__p_category, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_category = part__p_category[tid];
if (!(evaluatePredicate(reg_part__p_category, "MFGR#14", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5bd044bfd7c0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_5bd044bfd7c0 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_5bd044bfd7c0 = atomicAdd((int*)BUF_IDX_5bd044bfd7c0, 1);
HT_5bd044bfd7c0.insert(cuco::pair{KEY_5bd044bfd7c0, buf_idx_5bd044bfd7c0});
BUF_5bd044bfd7c0[buf_idx_5bd044bfd7c0 * 1 + 0] = tid;
}
__global__ void count_5bd044bc3c10(uint64_t* COUNT5bd044c1b960, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5bd044c1b960, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5bd044bc3c10(uint64_t* BUF_5bd044c1b960, uint64_t* BUF_IDX_5bd044c1b960, HASHTABLE_INSERT HT_5bd044c1b960, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5bd044c1b960 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5bd044c1b960 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_5bd044c1b960 = atomicAdd((int*)BUF_IDX_5bd044c1b960, 1);
HT_5bd044c1b960.insert(cuco::pair{KEY_5bd044c1b960, buf_idx_5bd044c1b960});
BUF_5bd044c1b960[buf_idx_5bd044c1b960 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5bd044c312c0(uint64_t* BUF_5bd044bfd7c0, uint64_t* BUF_5bd044c1b960, uint64_t* BUF_5bd044c23360, uint64_t* COUNT5bd044c1b0d0, HASHTABLE_PROBE HT_5bd044bfd7c0, HASHTABLE_PROBE HT_5bd044c1b960, HASHTABLE_PROBE HT_5bd044c23360, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_5bd044c23360 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5bd044c23360 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_5bd044c23360 = HT_5bd044c23360.find(KEY_5bd044c23360);
if (SLOT_5bd044c23360 == HT_5bd044c23360.end()) return;
if (!(true)) return;
uint64_t KEY_5bd044bfd7c0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5bd044bfd7c0 |= reg_lineorder__lo_partkey;
//Probe Hash table
auto SLOT_5bd044bfd7c0 = HT_5bd044bfd7c0.find(KEY_5bd044bfd7c0);
if (SLOT_5bd044bfd7c0 == HT_5bd044bfd7c0.end()) return;
if (!(true)) return;
uint64_t KEY_5bd044c1b960 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5bd044c1b960 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_5bd044c1b960 = HT_5bd044c1b960.find(KEY_5bd044c1b960);
if (SLOT_5bd044c1b960 == HT_5bd044c1b960.end()) return;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5bd044c1b0d0, 1);
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5bd044c312c0(uint64_t* BUF_5bd044bfd7c0, uint64_t* BUF_5bd044c1b0d0, uint64_t* BUF_5bd044c1b960, uint64_t* BUF_5bd044c23360, uint64_t* BUF_IDX_5bd044c1b0d0, HASHTABLE_PROBE HT_5bd044bfd7c0, HASHTABLE_INSERT HT_5bd044c1b0d0, HASHTABLE_PROBE HT_5bd044c1b960, HASHTABLE_PROBE HT_5bd044c23360, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_5bd044c23360 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5bd044c23360 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_5bd044c23360 = HT_5bd044c23360.find(KEY_5bd044c23360);
if (SLOT_5bd044c23360 == HT_5bd044c23360.end()) return;
if (!(true)) return;
uint64_t KEY_5bd044bfd7c0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5bd044bfd7c0 |= reg_lineorder__lo_partkey;
//Probe Hash table
auto SLOT_5bd044bfd7c0 = HT_5bd044bfd7c0.find(KEY_5bd044bfd7c0);
if (SLOT_5bd044bfd7c0 == HT_5bd044bfd7c0.end()) return;
if (!(true)) return;
uint64_t KEY_5bd044c1b960 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5bd044c1b960 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_5bd044c1b960 = HT_5bd044c1b960.find(KEY_5bd044c1b960);
if (SLOT_5bd044c1b960 == HT_5bd044c1b960.end()) return;
if (!(true)) return;
uint64_t KEY_5bd044c1b0d0 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5bd044c1b0d0 |= reg_lineorder__lo_custkey;
// Insert hash table kernel;
auto buf_idx_5bd044c1b0d0 = atomicAdd((int*)BUF_IDX_5bd044c1b0d0, 1);
HT_5bd044c1b0d0.insert(cuco::pair{KEY_5bd044c1b0d0, buf_idx_5bd044c1b0d0});
BUF_5bd044c1b0d0[buf_idx_5bd044c1b0d0 * 4 + 0] = BUF_5bd044c1b960[SLOT_5bd044c1b960->second * 1 + 0];
BUF_5bd044c1b0d0[buf_idx_5bd044c1b0d0 * 4 + 1] = BUF_5bd044c23360[SLOT_5bd044c23360->second * 1 + 0];
BUF_5bd044c1b0d0[buf_idx_5bd044c1b0d0 * 4 + 2] = BUF_5bd044bfd7c0[SLOT_5bd044bfd7c0->second * 1 + 0];
BUF_5bd044c1b0d0[buf_idx_5bd044c1b0d0 * 4 + 3] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5bd044bc39d0(uint64_t* BUF_5bd044c1b0d0, HASHTABLE_INSERT HT_5bd044bd25f0, HASHTABLE_PROBE HT_5bd044c1b0d0, DBI32Type* customer__c_custkey, size_t customer_size, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5bd044c1b0d0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5bd044c1b0d0 |= reg_customer__c_custkey;
//Probe Hash table
auto SLOT_5bd044c1b0d0 = HT_5bd044c1b0d0.find(KEY_5bd044c1b0d0);
if (SLOT_5bd044c1b0d0 == HT_5bd044c1b0d0.end()) return;
if (!(true)) return;
uint64_t KEY_5bd044bd25f0 = 0;
auto reg_date__d_year = date__d_year[BUF_5bd044c1b0d0[SLOT_5bd044c1b0d0->second * 4 + 0]];

KEY_5bd044bd25f0 |= reg_date__d_year;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_5bd044c1b0d0[SLOT_5bd044c1b0d0->second * 4 + 1]];
KEY_5bd044bd25f0 <<= 16;
KEY_5bd044bd25f0 |= reg_supplier__s_city_encoded;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_5bd044c1b0d0[SLOT_5bd044c1b0d0->second * 4 + 2]];
KEY_5bd044bd25f0 <<= 16;
KEY_5bd044bd25f0 |= reg_part__p_brand1_encoded;
//Create aggregation hash table
HT_5bd044bd25f0.insert(cuco::pair{KEY_5bd044bd25f0, 1});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5bd044bc39d0(uint64_t* BUF_5bd044c1b0d0, HASHTABLE_FIND HT_5bd044bd25f0, HASHTABLE_PROBE HT_5bd044c1b0d0, DBI32Type* KEY_5bd044bd25f0date__d_year, DBI16Type* KEY_5bd044bd25f0part__p_brand1_encoded, DBI16Type* KEY_5bd044bd25f0supplier__s_city_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* customer__c_custkey, size_t customer_size, DBI32Type* date__d_year, DBDecimalType* lineorder__lo_revenue, DBDecimalType* lineorder__lo_supplycost, DBI16Type* part__p_brand1_encoded, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5bd044c1b0d0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5bd044c1b0d0 |= reg_customer__c_custkey;
//Probe Hash table
auto SLOT_5bd044c1b0d0 = HT_5bd044c1b0d0.find(KEY_5bd044c1b0d0);
if (SLOT_5bd044c1b0d0 == HT_5bd044c1b0d0.end()) return;
if (!(true)) return;
uint64_t KEY_5bd044bd25f0 = 0;
auto reg_date__d_year = date__d_year[BUF_5bd044c1b0d0[SLOT_5bd044c1b0d0->second * 4 + 0]];

KEY_5bd044bd25f0 |= reg_date__d_year;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_5bd044c1b0d0[SLOT_5bd044c1b0d0->second * 4 + 1]];
KEY_5bd044bd25f0 <<= 16;
KEY_5bd044bd25f0 |= reg_supplier__s_city_encoded;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_5bd044c1b0d0[SLOT_5bd044c1b0d0->second * 4 + 2]];
KEY_5bd044bd25f0 <<= 16;
KEY_5bd044bd25f0 |= reg_part__p_brand1_encoded;
//Aggregate in hashtable
auto buf_idx_5bd044bd25f0 = HT_5bd044bd25f0.find(KEY_5bd044bd25f0)->second;
auto reg_lineorder__lo_supplycost = lineorder__lo_supplycost[BUF_5bd044c1b0d0[SLOT_5bd044c1b0d0->second * 4 + 3]];
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[BUF_5bd044c1b0d0[SLOT_5bd044c1b0d0->second * 4 + 3]];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_revenue) - (reg_lineorder__lo_supplycost);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5bd044bd25f0], reg_map0__tmp_attr1);
KEY_5bd044bd25f0date__d_year[buf_idx_5bd044bd25f0] = reg_date__d_year;
KEY_5bd044bd25f0supplier__s_city_encoded[buf_idx_5bd044bd25f0] = reg_supplier__s_city_encoded;
KEY_5bd044bd25f0part__p_brand1_encoded[buf_idx_5bd044bd25f0] = reg_part__p_brand1_encoded;
}
__global__ void count_5bd044c49c60(uint64_t* COUNT5bd044bb29f0, size_t COUNT5bd044bd25f0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5bd044bd25f0) return;
//Materialize count
atomicAdd((int*)COUNT5bd044bb29f0, 1);
}
__global__ void main_5bd044c49c60(size_t COUNT5bd044bd25f0, DBDecimalType* MAT5bd044bb29f0aggr0__tmp_attr0, DBI32Type* MAT5bd044bb29f0date__d_year, DBI16Type* MAT5bd044bb29f0part__p_brand1_encoded, DBI16Type* MAT5bd044bb29f0supplier__s_city_encoded, uint64_t* MAT_IDX5bd044bb29f0, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5bd044bd25f0) return;
//Materialize buffers
auto mat_idx5bd044bb29f0 = atomicAdd((int*)MAT_IDX5bd044bb29f0, 1);
auto reg_date__d_year = date__d_year[tid];
MAT5bd044bb29f0date__d_year[mat_idx5bd044bb29f0] = reg_date__d_year;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[tid];
MAT5bd044bb29f0supplier__s_city_encoded[mat_idx5bd044bb29f0] = reg_supplier__s_city_encoded;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[tid];
MAT5bd044bb29f0part__p_brand1_encoded[mat_idx5bd044bb29f0] = reg_part__p_brand1_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5bd044bb29f0aggr0__tmp_attr0[mat_idx5bd044bb29f0] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT5bd044c23360;
cudaMalloc(&d_COUNT5bd044c23360, sizeof(uint64_t));
cudaMemset(d_COUNT5bd044c23360, 0, sizeof(uint64_t));
count_5bd044c2c000<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT5bd044c23360, d_supplier__s_nation, supplier_size);
uint64_t COUNT5bd044c23360;
cudaMemcpy(&COUNT5bd044c23360, d_COUNT5bd044c23360, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5bd044c23360;
cudaMalloc(&d_BUF_IDX_5bd044c23360, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5bd044c23360, 0, sizeof(uint64_t));
uint64_t* d_BUF_5bd044c23360;
cudaMalloc(&d_BUF_5bd044c23360, sizeof(uint64_t) * COUNT5bd044c23360 * 1);
auto d_HT_5bd044c23360 = cuco::static_map{ (int)COUNT5bd044c23360*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5bd044c2c000<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_5bd044c23360, d_BUF_IDX_5bd044c23360, d_HT_5bd044c23360.ref(cuco::insert), d_supplier__s_nation, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT5bd044bfd7c0;
cudaMalloc(&d_COUNT5bd044bfd7c0, sizeof(uint64_t));
cudaMemset(d_COUNT5bd044bfd7c0, 0, sizeof(uint64_t));
count_5bd044c2e9c0<<<std::ceil((float)part_size/128.), 128>>>(d_COUNT5bd044bfd7c0, d_part__p_category, part_size);
uint64_t COUNT5bd044bfd7c0;
cudaMemcpy(&COUNT5bd044bfd7c0, d_COUNT5bd044bfd7c0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5bd044bfd7c0;
cudaMalloc(&d_BUF_IDX_5bd044bfd7c0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5bd044bfd7c0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5bd044bfd7c0;
cudaMalloc(&d_BUF_5bd044bfd7c0, sizeof(uint64_t) * COUNT5bd044bfd7c0 * 1);
auto d_HT_5bd044bfd7c0 = cuco::static_map{ (int)COUNT5bd044bfd7c0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5bd044c2e9c0<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_5bd044bfd7c0, d_BUF_IDX_5bd044bfd7c0, d_HT_5bd044bfd7c0.ref(cuco::insert), d_part__p_category, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT5bd044c1b960;
cudaMalloc(&d_COUNT5bd044c1b960, sizeof(uint64_t));
cudaMemset(d_COUNT5bd044c1b960, 0, sizeof(uint64_t));
count_5bd044bc3c10<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT5bd044c1b960, d_date__d_year, date_size);
uint64_t COUNT5bd044c1b960;
cudaMemcpy(&COUNT5bd044c1b960, d_COUNT5bd044c1b960, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5bd044c1b960;
cudaMalloc(&d_BUF_IDX_5bd044c1b960, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5bd044c1b960, 0, sizeof(uint64_t));
uint64_t* d_BUF_5bd044c1b960;
cudaMalloc(&d_BUF_5bd044c1b960, sizeof(uint64_t) * COUNT5bd044c1b960 * 1);
auto d_HT_5bd044c1b960 = cuco::static_map{ (int)COUNT5bd044c1b960*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5bd044bc3c10<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_5bd044c1b960, d_BUF_IDX_5bd044c1b960, d_HT_5bd044c1b960.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Materialize count
uint64_t* d_COUNT5bd044c1b0d0;
cudaMalloc(&d_COUNT5bd044c1b0d0, sizeof(uint64_t));
cudaMemset(d_COUNT5bd044c1b0d0, 0, sizeof(uint64_t));
count_5bd044c312c0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5bd044bfd7c0, d_BUF_5bd044c1b960, d_BUF_5bd044c23360, d_COUNT5bd044c1b0d0, d_HT_5bd044bfd7c0.ref(cuco::find), d_HT_5bd044c1b960.ref(cuco::find), d_HT_5bd044c23360.ref(cuco::find), d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
uint64_t COUNT5bd044c1b0d0;
cudaMemcpy(&COUNT5bd044c1b0d0, d_COUNT5bd044c1b0d0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5bd044c1b0d0;
cudaMalloc(&d_BUF_IDX_5bd044c1b0d0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5bd044c1b0d0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5bd044c1b0d0;
cudaMalloc(&d_BUF_5bd044c1b0d0, sizeof(uint64_t) * COUNT5bd044c1b0d0 * 4);
auto d_HT_5bd044c1b0d0 = cuco::static_map{ (int)COUNT5bd044c1b0d0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5bd044c312c0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5bd044bfd7c0, d_BUF_5bd044c1b0d0, d_BUF_5bd044c1b960, d_BUF_5bd044c23360, d_BUF_IDX_5bd044c1b0d0, d_HT_5bd044bfd7c0.ref(cuco::find), d_HT_5bd044c1b0d0.ref(cuco::insert), d_HT_5bd044c1b960.ref(cuco::find), d_HT_5bd044c23360.ref(cuco::find), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
//Create aggregation hash table
auto d_HT_5bd044bd25f0 = cuco::static_map{ (int)2259*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5bd044bc39d0<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_5bd044c1b0d0, d_HT_5bd044bd25f0.ref(cuco::insert), d_HT_5bd044c1b0d0.ref(cuco::find), d_customer__c_custkey, customer_size, d_date__d_year, d_part__p_brand1_encoded, d_supplier__s_city_encoded);
size_t COUNT5bd044bd25f0 = d_HT_5bd044bd25f0.size();
thrust::device_vector<int64_t> keys_5bd044bd25f0(COUNT5bd044bd25f0), vals_5bd044bd25f0(COUNT5bd044bd25f0);
d_HT_5bd044bd25f0.retrieve_all(keys_5bd044bd25f0.begin(), vals_5bd044bd25f0.begin());
d_HT_5bd044bd25f0.clear();
int64_t* raw_keys5bd044bd25f0 = thrust::raw_pointer_cast(keys_5bd044bd25f0.data());
insertKeys<<<std::ceil((float)COUNT5bd044bd25f0/128.), 128>>>(raw_keys5bd044bd25f0, d_HT_5bd044bd25f0.ref(cuco::insert), COUNT5bd044bd25f0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5bd044bd25f0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5bd044bd25f0);
DBI32Type* d_KEY_5bd044bd25f0date__d_year;
cudaMalloc(&d_KEY_5bd044bd25f0date__d_year, sizeof(DBI32Type) * COUNT5bd044bd25f0);
cudaMemset(d_KEY_5bd044bd25f0date__d_year, 0, sizeof(DBI32Type) * COUNT5bd044bd25f0);
DBI16Type* d_KEY_5bd044bd25f0supplier__s_city_encoded;
cudaMalloc(&d_KEY_5bd044bd25f0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5bd044bd25f0);
cudaMemset(d_KEY_5bd044bd25f0supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT5bd044bd25f0);
DBI16Type* d_KEY_5bd044bd25f0part__p_brand1_encoded;
cudaMalloc(&d_KEY_5bd044bd25f0part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5bd044bd25f0);
cudaMemset(d_KEY_5bd044bd25f0part__p_brand1_encoded, 0, sizeof(DBI16Type) * COUNT5bd044bd25f0);
main_5bd044bc39d0<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_5bd044c1b0d0, d_HT_5bd044bd25f0.ref(cuco::find), d_HT_5bd044c1b0d0.ref(cuco::find), d_KEY_5bd044bd25f0date__d_year, d_KEY_5bd044bd25f0part__p_brand1_encoded, d_KEY_5bd044bd25f0supplier__s_city_encoded, d_aggr0__tmp_attr0, d_customer__c_custkey, customer_size, d_date__d_year, d_lineorder__lo_revenue, d_lineorder__lo_supplycost, d_part__p_brand1_encoded, d_supplier__s_city_encoded);
//Materialize count
uint64_t* d_COUNT5bd044bb29f0;
cudaMalloc(&d_COUNT5bd044bb29f0, sizeof(uint64_t));
cudaMemset(d_COUNT5bd044bb29f0, 0, sizeof(uint64_t));
count_5bd044c49c60<<<std::ceil((float)COUNT5bd044bd25f0/128.), 128>>>(d_COUNT5bd044bb29f0, COUNT5bd044bd25f0);
uint64_t COUNT5bd044bb29f0;
cudaMemcpy(&COUNT5bd044bb29f0, d_COUNT5bd044bb29f0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5bd044bb29f0;
cudaMalloc(&d_MAT_IDX5bd044bb29f0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5bd044bb29f0, 0, sizeof(uint64_t));
auto MAT5bd044bb29f0date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5bd044bb29f0);
DBI32Type* d_MAT5bd044bb29f0date__d_year;
cudaMalloc(&d_MAT5bd044bb29f0date__d_year, sizeof(DBI32Type) * COUNT5bd044bb29f0);
auto MAT5bd044bb29f0supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5bd044bb29f0);
DBI16Type* d_MAT5bd044bb29f0supplier__s_city_encoded;
cudaMalloc(&d_MAT5bd044bb29f0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5bd044bb29f0);
auto MAT5bd044bb29f0part__p_brand1_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5bd044bb29f0);
DBI16Type* d_MAT5bd044bb29f0part__p_brand1_encoded;
cudaMalloc(&d_MAT5bd044bb29f0part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5bd044bb29f0);
auto MAT5bd044bb29f0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5bd044bb29f0);
DBDecimalType* d_MAT5bd044bb29f0aggr0__tmp_attr0;
cudaMalloc(&d_MAT5bd044bb29f0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5bd044bb29f0);
main_5bd044c49c60<<<std::ceil((float)COUNT5bd044bd25f0/128.), 128>>>(COUNT5bd044bd25f0, d_MAT5bd044bb29f0aggr0__tmp_attr0, d_MAT5bd044bb29f0date__d_year, d_MAT5bd044bb29f0part__p_brand1_encoded, d_MAT5bd044bb29f0supplier__s_city_encoded, d_MAT_IDX5bd044bb29f0, d_aggr0__tmp_attr0, d_KEY_5bd044bd25f0date__d_year, d_KEY_5bd044bd25f0part__p_brand1_encoded, d_KEY_5bd044bd25f0supplier__s_city_encoded);
cudaMemcpy(MAT5bd044bb29f0date__d_year, d_MAT5bd044bb29f0date__d_year, sizeof(DBI32Type) * COUNT5bd044bb29f0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5bd044bb29f0supplier__s_city_encoded, d_MAT5bd044bb29f0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5bd044bb29f0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5bd044bb29f0part__p_brand1_encoded, d_MAT5bd044bb29f0part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5bd044bb29f0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5bd044bb29f0aggr0__tmp_attr0, d_MAT5bd044bb29f0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5bd044bb29f0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5bd044bb29f0; i++) { std::cout << "" << MAT5bd044bb29f0date__d_year[i];
std::cout << "," << supplier__s_city_map[MAT5bd044bb29f0supplier__s_city_encoded[i]];
std::cout << "," << part__p_brand1_map[MAT5bd044bb29f0part__p_brand1_encoded[i]];
std::cout << "," << MAT5bd044bb29f0aggr0__tmp_attr0[i];
std::cout << std::endl; }
cudaFree(d_BUF_5bd044c23360);
cudaFree(d_BUF_IDX_5bd044c23360);
cudaFree(d_COUNT5bd044c23360);
cudaFree(d_BUF_5bd044bfd7c0);
cudaFree(d_BUF_IDX_5bd044bfd7c0);
cudaFree(d_COUNT5bd044bfd7c0);
cudaFree(d_BUF_5bd044c1b960);
cudaFree(d_BUF_IDX_5bd044c1b960);
cudaFree(d_COUNT5bd044c1b960);
cudaFree(d_BUF_5bd044c1b0d0);
cudaFree(d_BUF_IDX_5bd044c1b0d0);
cudaFree(d_COUNT5bd044c1b0d0);
cudaFree(d_KEY_5bd044bd25f0date__d_year);
cudaFree(d_KEY_5bd044bd25f0part__p_brand1_encoded);
cudaFree(d_KEY_5bd044bd25f0supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5bd044bb29f0);
cudaFree(d_MAT5bd044bb29f0aggr0__tmp_attr0);
cudaFree(d_MAT5bd044bb29f0date__d_year);
cudaFree(d_MAT5bd044bb29f0part__p_brand1_encoded);
cudaFree(d_MAT5bd044bb29f0supplier__s_city_encoded);
cudaFree(d_MAT_IDX5bd044bb29f0);
free(MAT5bd044bb29f0aggr0__tmp_attr0);
free(MAT5bd044bb29f0date__d_year);
free(MAT5bd044bb29f0part__p_brand1_encoded);
free(MAT5bd044bb29f0supplier__s_city_encoded);
}