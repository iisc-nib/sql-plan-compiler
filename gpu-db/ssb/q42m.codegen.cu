#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5e2bc5559940(uint64_t* COUNT5e2bc554a030, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5e2bc554a030, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5e2bc5559940(uint64_t* BUF_5e2bc554a030, uint64_t* BUF_IDX_5e2bc554a030, HASHTABLE_INSERT HT_5e2bc554a030, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5e2bc554a030 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5e2bc554a030 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5e2bc554a030 = atomicAdd((int*)BUF_IDX_5e2bc554a030, 1);
HT_5e2bc554a030.insert(cuco::pair{KEY_5e2bc554a030, buf_idx_5e2bc554a030});
BUF_5e2bc554a030[buf_idx_5e2bc554a030 * 1 + 0] = tid;
}
__global__ void count_5e2bc54efbf0(uint64_t* COUNT5e2bc5549b00, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5e2bc5549b00, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5e2bc54efbf0(uint64_t* BUF_5e2bc5549b00, uint64_t* BUF_IDX_5e2bc5549b00, HASHTABLE_INSERT HT_5e2bc5549b00, DBI32Type* customer__c_custkey, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5e2bc5549b00 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5e2bc5549b00 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_5e2bc5549b00 = atomicAdd((int*)BUF_IDX_5e2bc5549b00, 1);
HT_5e2bc5549b00.insert(cuco::pair{KEY_5e2bc5549b00, buf_idx_5e2bc5549b00});
BUF_5e2bc5549b00[buf_idx_5e2bc5549b00 * 1 + 0] = tid;
}
__global__ void count_5e2bc54efe30(uint64_t* COUNT5e2bc552ab60, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5e2bc552ab60, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5e2bc54efe30(uint64_t* BUF_5e2bc552ab60, uint64_t* BUF_IDX_5e2bc552ab60, HASHTABLE_INSERT HT_5e2bc552ab60, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5e2bc552ab60 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5e2bc552ab60 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_5e2bc552ab60 = atomicAdd((int*)BUF_IDX_5e2bc552ab60, 1);
HT_5e2bc552ab60.insert(cuco::pair{KEY_5e2bc552ab60, buf_idx_5e2bc552ab60});
BUF_5e2bc552ab60[buf_idx_5e2bc552ab60 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5e2bc555e9c0(uint64_t* BUF_5e2bc552ab60, uint64_t* BUF_5e2bc5549b00, uint64_t* BUF_5e2bc554a030, uint64_t* COUNT5e2bc5547ee0, HASHTABLE_PROBE HT_5e2bc552ab60, HASHTABLE_PROBE HT_5e2bc5549b00, HASHTABLE_PROBE HT_5e2bc554a030, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_5e2bc554a030 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5e2bc554a030 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_5e2bc554a030 = HT_5e2bc554a030.find(KEY_5e2bc554a030);
if (SLOT_5e2bc554a030 == HT_5e2bc554a030.end()) return;
if (!(true)) return;
uint64_t KEY_5e2bc5549b00 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5e2bc5549b00 |= reg_lineorder__lo_custkey;
//Probe Hash table
auto SLOT_5e2bc5549b00 = HT_5e2bc5549b00.find(KEY_5e2bc5549b00);
if (SLOT_5e2bc5549b00 == HT_5e2bc5549b00.end()) return;
if (!(true)) return;
uint64_t KEY_5e2bc552ab60 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5e2bc552ab60 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_5e2bc552ab60 = HT_5e2bc552ab60.find(KEY_5e2bc552ab60);
if (SLOT_5e2bc552ab60 == HT_5e2bc552ab60.end()) return;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5e2bc5547ee0, 1);
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5e2bc555e9c0(uint64_t* BUF_5e2bc552ab60, uint64_t* BUF_5e2bc5547ee0, uint64_t* BUF_5e2bc5549b00, uint64_t* BUF_5e2bc554a030, uint64_t* BUF_IDX_5e2bc5547ee0, HASHTABLE_PROBE HT_5e2bc552ab60, HASHTABLE_INSERT HT_5e2bc5547ee0, HASHTABLE_PROBE HT_5e2bc5549b00, HASHTABLE_PROBE HT_5e2bc554a030, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_5e2bc554a030 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5e2bc554a030 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_5e2bc554a030 = HT_5e2bc554a030.find(KEY_5e2bc554a030);
if (SLOT_5e2bc554a030 == HT_5e2bc554a030.end()) return;
if (!(true)) return;
uint64_t KEY_5e2bc5549b00 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5e2bc5549b00 |= reg_lineorder__lo_custkey;
//Probe Hash table
auto SLOT_5e2bc5549b00 = HT_5e2bc5549b00.find(KEY_5e2bc5549b00);
if (SLOT_5e2bc5549b00 == HT_5e2bc5549b00.end()) return;
if (!(true)) return;
uint64_t KEY_5e2bc552ab60 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5e2bc552ab60 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_5e2bc552ab60 = HT_5e2bc552ab60.find(KEY_5e2bc552ab60);
if (SLOT_5e2bc552ab60 == HT_5e2bc552ab60.end()) return;
if (!(true)) return;
uint64_t KEY_5e2bc5547ee0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5e2bc5547ee0 |= reg_lineorder__lo_partkey;
// Insert hash table kernel;
auto buf_idx_5e2bc5547ee0 = atomicAdd((int*)BUF_IDX_5e2bc5547ee0, 1);
HT_5e2bc5547ee0.insert(cuco::pair{KEY_5e2bc5547ee0, buf_idx_5e2bc5547ee0});
BUF_5e2bc5547ee0[buf_idx_5e2bc5547ee0 * 4 + 0] = BUF_5e2bc552ab60[SLOT_5e2bc552ab60->second * 1 + 0];
BUF_5e2bc5547ee0[buf_idx_5e2bc5547ee0 * 4 + 1] = BUF_5e2bc5549b00[SLOT_5e2bc5549b00->second * 1 + 0];
BUF_5e2bc5547ee0[buf_idx_5e2bc5547ee0 * 4 + 2] = BUF_5e2bc554a030[SLOT_5e2bc554a030->second * 1 + 0];
BUF_5e2bc5547ee0[buf_idx_5e2bc5547ee0 * 4 + 3] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5e2bc555c160(uint64_t* BUF_5e2bc5547ee0, HASHTABLE_INSERT HT_5e2bc5500900, HASHTABLE_PROBE HT_5e2bc5547ee0, DBI32Type* date__d_year, DBI16Type* part__p_category_encoded, DBStringType* part__p_mfgr, DBI32Type* part__p_partkey, size_t part_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5e2bc5547ee0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_5e2bc5547ee0 |= reg_part__p_partkey;
//Probe Hash table
auto SLOT_5e2bc5547ee0 = HT_5e2bc5547ee0.find(KEY_5e2bc5547ee0);
if (SLOT_5e2bc5547ee0 == HT_5e2bc5547ee0.end()) return;
if (!(true)) return;
uint64_t KEY_5e2bc5500900 = 0;
auto reg_date__d_year = date__d_year[BUF_5e2bc5547ee0[SLOT_5e2bc5547ee0->second * 4 + 0]];

KEY_5e2bc5500900 |= reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_5e2bc5547ee0[SLOT_5e2bc5547ee0->second * 4 + 2]];
KEY_5e2bc5500900 <<= 16;
KEY_5e2bc5500900 |= reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[tid];
KEY_5e2bc5500900 <<= 16;
KEY_5e2bc5500900 |= reg_part__p_category_encoded;
//Create aggregation hash table
HT_5e2bc5500900.insert(cuco::pair{KEY_5e2bc5500900, 1});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5e2bc555c160(uint64_t* BUF_5e2bc5547ee0, HASHTABLE_FIND HT_5e2bc5500900, HASHTABLE_PROBE HT_5e2bc5547ee0, DBI32Type* KEY_5e2bc5500900date__d_year, DBI16Type* KEY_5e2bc5500900part__p_category_encoded, DBI16Type* KEY_5e2bc5500900supplier__s_nation_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBDecimalType* lineorder__lo_revenue, DBDecimalType* lineorder__lo_supplycost, DBI16Type* part__p_category_encoded, DBStringType* part__p_mfgr, DBI32Type* part__p_partkey, size_t part_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_mfgr = part__p_mfgr[tid];
if (!((evaluatePredicate(reg_part__p_mfgr, "MFGR#1", Predicate::eq)) || (evaluatePredicate(reg_part__p_mfgr, "MFGR#2", Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5e2bc5547ee0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_5e2bc5547ee0 |= reg_part__p_partkey;
//Probe Hash table
auto SLOT_5e2bc5547ee0 = HT_5e2bc5547ee0.find(KEY_5e2bc5547ee0);
if (SLOT_5e2bc5547ee0 == HT_5e2bc5547ee0.end()) return;
if (!(true)) return;
uint64_t KEY_5e2bc5500900 = 0;
auto reg_date__d_year = date__d_year[BUF_5e2bc5547ee0[SLOT_5e2bc5547ee0->second * 4 + 0]];

KEY_5e2bc5500900 |= reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_5e2bc5547ee0[SLOT_5e2bc5547ee0->second * 4 + 2]];
KEY_5e2bc5500900 <<= 16;
KEY_5e2bc5500900 |= reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[tid];
KEY_5e2bc5500900 <<= 16;
KEY_5e2bc5500900 |= reg_part__p_category_encoded;
//Aggregate in hashtable
auto buf_idx_5e2bc5500900 = HT_5e2bc5500900.find(KEY_5e2bc5500900)->second;
auto reg_lineorder__lo_supplycost = lineorder__lo_supplycost[BUF_5e2bc5547ee0[SLOT_5e2bc5547ee0->second * 4 + 3]];
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[BUF_5e2bc5547ee0[SLOT_5e2bc5547ee0->second * 4 + 3]];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_revenue) - (reg_lineorder__lo_supplycost);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5e2bc5500900], reg_map0__tmp_attr1);
KEY_5e2bc5500900date__d_year[buf_idx_5e2bc5500900] = reg_date__d_year;
KEY_5e2bc5500900supplier__s_nation_encoded[buf_idx_5e2bc5500900] = reg_supplier__s_nation_encoded;
KEY_5e2bc5500900part__p_category_encoded[buf_idx_5e2bc5500900] = reg_part__p_category_encoded;
}
__global__ void count_5e2bc556ea00(uint64_t* COUNT5e2bc54decf0, size_t COUNT5e2bc5500900) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5e2bc5500900) return;
//Materialize count
atomicAdd((int*)COUNT5e2bc54decf0, 1);
}
__global__ void main_5e2bc556ea00(size_t COUNT5e2bc5500900, DBDecimalType* MAT5e2bc54decf0aggr0__tmp_attr0, DBI32Type* MAT5e2bc54decf0date__d_year, DBI16Type* MAT5e2bc54decf0part__p_category_encoded, DBI16Type* MAT5e2bc54decf0supplier__s_nation_encoded, uint64_t* MAT_IDX5e2bc54decf0, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_category_encoded, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5e2bc5500900) return;
//Materialize buffers
auto mat_idx5e2bc54decf0 = atomicAdd((int*)MAT_IDX5e2bc54decf0, 1);
auto reg_date__d_year = date__d_year[tid];
MAT5e2bc54decf0date__d_year[mat_idx5e2bc54decf0] = reg_date__d_year;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[tid];
MAT5e2bc54decf0supplier__s_nation_encoded[mat_idx5e2bc54decf0] = reg_supplier__s_nation_encoded;
auto reg_part__p_category_encoded = part__p_category_encoded[tid];
MAT5e2bc54decf0part__p_category_encoded[mat_idx5e2bc54decf0] = reg_part__p_category_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5e2bc54decf0aggr0__tmp_attr0[mat_idx5e2bc54decf0] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT5e2bc554a030;
cudaMalloc(&d_COUNT5e2bc554a030, sizeof(uint64_t));
cudaMemset(d_COUNT5e2bc554a030, 0, sizeof(uint64_t));
count_5e2bc5559940<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT5e2bc554a030, d_supplier__s_region, supplier_size);
uint64_t COUNT5e2bc554a030;
cudaMemcpy(&COUNT5e2bc554a030, d_COUNT5e2bc554a030, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5e2bc554a030;
cudaMalloc(&d_BUF_IDX_5e2bc554a030, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5e2bc554a030, 0, sizeof(uint64_t));
uint64_t* d_BUF_5e2bc554a030;
cudaMalloc(&d_BUF_5e2bc554a030, sizeof(uint64_t) * COUNT5e2bc554a030 * 1);
auto d_HT_5e2bc554a030 = cuco::static_map{ (int)COUNT5e2bc554a030*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5e2bc5559940<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_5e2bc554a030, d_BUF_IDX_5e2bc554a030, d_HT_5e2bc554a030.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT5e2bc5549b00;
cudaMalloc(&d_COUNT5e2bc5549b00, sizeof(uint64_t));
cudaMemset(d_COUNT5e2bc5549b00, 0, sizeof(uint64_t));
count_5e2bc54efbf0<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT5e2bc5549b00, d_customer__c_region, customer_size);
uint64_t COUNT5e2bc5549b00;
cudaMemcpy(&COUNT5e2bc5549b00, d_COUNT5e2bc5549b00, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5e2bc5549b00;
cudaMalloc(&d_BUF_IDX_5e2bc5549b00, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5e2bc5549b00, 0, sizeof(uint64_t));
uint64_t* d_BUF_5e2bc5549b00;
cudaMalloc(&d_BUF_5e2bc5549b00, sizeof(uint64_t) * COUNT5e2bc5549b00 * 1);
auto d_HT_5e2bc5549b00 = cuco::static_map{ (int)COUNT5e2bc5549b00*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5e2bc54efbf0<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_5e2bc5549b00, d_BUF_IDX_5e2bc5549b00, d_HT_5e2bc5549b00.ref(cuco::insert), d_customer__c_custkey, d_customer__c_region, customer_size);
//Materialize count
uint64_t* d_COUNT5e2bc552ab60;
cudaMalloc(&d_COUNT5e2bc552ab60, sizeof(uint64_t));
cudaMemset(d_COUNT5e2bc552ab60, 0, sizeof(uint64_t));
count_5e2bc54efe30<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT5e2bc552ab60, d_date__d_year, date_size);
uint64_t COUNT5e2bc552ab60;
cudaMemcpy(&COUNT5e2bc552ab60, d_COUNT5e2bc552ab60, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5e2bc552ab60;
cudaMalloc(&d_BUF_IDX_5e2bc552ab60, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5e2bc552ab60, 0, sizeof(uint64_t));
uint64_t* d_BUF_5e2bc552ab60;
cudaMalloc(&d_BUF_5e2bc552ab60, sizeof(uint64_t) * COUNT5e2bc552ab60 * 1);
auto d_HT_5e2bc552ab60 = cuco::static_map{ (int)COUNT5e2bc552ab60*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5e2bc54efe30<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_5e2bc552ab60, d_BUF_IDX_5e2bc552ab60, d_HT_5e2bc552ab60.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Materialize count
uint64_t* d_COUNT5e2bc5547ee0;
cudaMalloc(&d_COUNT5e2bc5547ee0, sizeof(uint64_t));
cudaMemset(d_COUNT5e2bc5547ee0, 0, sizeof(uint64_t));
count_5e2bc555e9c0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5e2bc552ab60, d_BUF_5e2bc5549b00, d_BUF_5e2bc554a030, d_COUNT5e2bc5547ee0, d_HT_5e2bc552ab60.ref(cuco::find), d_HT_5e2bc5549b00.ref(cuco::find), d_HT_5e2bc554a030.ref(cuco::find), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size);
uint64_t COUNT5e2bc5547ee0;
cudaMemcpy(&COUNT5e2bc5547ee0, d_COUNT5e2bc5547ee0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5e2bc5547ee0;
cudaMalloc(&d_BUF_IDX_5e2bc5547ee0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5e2bc5547ee0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5e2bc5547ee0;
cudaMalloc(&d_BUF_5e2bc5547ee0, sizeof(uint64_t) * COUNT5e2bc5547ee0 * 4);
auto d_HT_5e2bc5547ee0 = cuco::static_map{ (int)COUNT5e2bc5547ee0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5e2bc555e9c0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5e2bc552ab60, d_BUF_5e2bc5547ee0, d_BUF_5e2bc5549b00, d_BUF_5e2bc554a030, d_BUF_IDX_5e2bc5547ee0, d_HT_5e2bc552ab60.ref(cuco::find), d_HT_5e2bc5547ee0.ref(cuco::insert), d_HT_5e2bc5549b00.ref(cuco::find), d_HT_5e2bc554a030.ref(cuco::find), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
//Create aggregation hash table
auto d_HT_5e2bc5500900 = cuco::static_map{ (int)24650*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5e2bc555c160<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_5e2bc5547ee0, d_HT_5e2bc5500900.ref(cuco::insert), d_HT_5e2bc5547ee0.ref(cuco::find), d_date__d_year, d_part__p_category_encoded, d_part__p_mfgr, d_part__p_partkey, part_size, d_supplier__s_nation_encoded);
size_t COUNT5e2bc5500900 = d_HT_5e2bc5500900.size();
thrust::device_vector<int64_t> keys_5e2bc5500900(COUNT5e2bc5500900), vals_5e2bc5500900(COUNT5e2bc5500900);
d_HT_5e2bc5500900.retrieve_all(keys_5e2bc5500900.begin(), vals_5e2bc5500900.begin());
d_HT_5e2bc5500900.clear();
int64_t* raw_keys5e2bc5500900 = thrust::raw_pointer_cast(keys_5e2bc5500900.data());
insertKeys<<<std::ceil((float)COUNT5e2bc5500900/128.), 128>>>(raw_keys5e2bc5500900, d_HT_5e2bc5500900.ref(cuco::insert), COUNT5e2bc5500900);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5e2bc5500900);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5e2bc5500900);
DBI32Type* d_KEY_5e2bc5500900date__d_year;
cudaMalloc(&d_KEY_5e2bc5500900date__d_year, sizeof(DBI32Type) * COUNT5e2bc5500900);
cudaMemset(d_KEY_5e2bc5500900date__d_year, 0, sizeof(DBI32Type) * COUNT5e2bc5500900);
DBI16Type* d_KEY_5e2bc5500900supplier__s_nation_encoded;
cudaMalloc(&d_KEY_5e2bc5500900supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT5e2bc5500900);
cudaMemset(d_KEY_5e2bc5500900supplier__s_nation_encoded, 0, sizeof(DBI16Type) * COUNT5e2bc5500900);
DBI16Type* d_KEY_5e2bc5500900part__p_category_encoded;
cudaMalloc(&d_KEY_5e2bc5500900part__p_category_encoded, sizeof(DBI16Type) * COUNT5e2bc5500900);
cudaMemset(d_KEY_5e2bc5500900part__p_category_encoded, 0, sizeof(DBI16Type) * COUNT5e2bc5500900);
main_5e2bc555c160<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_5e2bc5547ee0, d_HT_5e2bc5500900.ref(cuco::find), d_HT_5e2bc5547ee0.ref(cuco::find), d_KEY_5e2bc5500900date__d_year, d_KEY_5e2bc5500900part__p_category_encoded, d_KEY_5e2bc5500900supplier__s_nation_encoded, d_aggr0__tmp_attr0, d_date__d_year, d_lineorder__lo_revenue, d_lineorder__lo_supplycost, d_part__p_category_encoded, d_part__p_mfgr, d_part__p_partkey, part_size, d_supplier__s_nation_encoded);
//Materialize count
uint64_t* d_COUNT5e2bc54decf0;
cudaMalloc(&d_COUNT5e2bc54decf0, sizeof(uint64_t));
cudaMemset(d_COUNT5e2bc54decf0, 0, sizeof(uint64_t));
count_5e2bc556ea00<<<std::ceil((float)COUNT5e2bc5500900/128.), 128>>>(d_COUNT5e2bc54decf0, COUNT5e2bc5500900);
uint64_t COUNT5e2bc54decf0;
cudaMemcpy(&COUNT5e2bc54decf0, d_COUNT5e2bc54decf0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5e2bc54decf0;
cudaMalloc(&d_MAT_IDX5e2bc54decf0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5e2bc54decf0, 0, sizeof(uint64_t));
auto MAT5e2bc54decf0date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5e2bc54decf0);
DBI32Type* d_MAT5e2bc54decf0date__d_year;
cudaMalloc(&d_MAT5e2bc54decf0date__d_year, sizeof(DBI32Type) * COUNT5e2bc54decf0);
auto MAT5e2bc54decf0supplier__s_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5e2bc54decf0);
DBI16Type* d_MAT5e2bc54decf0supplier__s_nation_encoded;
cudaMalloc(&d_MAT5e2bc54decf0supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT5e2bc54decf0);
auto MAT5e2bc54decf0part__p_category_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5e2bc54decf0);
DBI16Type* d_MAT5e2bc54decf0part__p_category_encoded;
cudaMalloc(&d_MAT5e2bc54decf0part__p_category_encoded, sizeof(DBI16Type) * COUNT5e2bc54decf0);
auto MAT5e2bc54decf0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5e2bc54decf0);
DBDecimalType* d_MAT5e2bc54decf0aggr0__tmp_attr0;
cudaMalloc(&d_MAT5e2bc54decf0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5e2bc54decf0);
main_5e2bc556ea00<<<std::ceil((float)COUNT5e2bc5500900/128.), 128>>>(COUNT5e2bc5500900, d_MAT5e2bc54decf0aggr0__tmp_attr0, d_MAT5e2bc54decf0date__d_year, d_MAT5e2bc54decf0part__p_category_encoded, d_MAT5e2bc54decf0supplier__s_nation_encoded, d_MAT_IDX5e2bc54decf0, d_aggr0__tmp_attr0, d_KEY_5e2bc5500900date__d_year, d_KEY_5e2bc5500900part__p_category_encoded, d_KEY_5e2bc5500900supplier__s_nation_encoded);
cudaMemcpy(MAT5e2bc54decf0date__d_year, d_MAT5e2bc54decf0date__d_year, sizeof(DBI32Type) * COUNT5e2bc54decf0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5e2bc54decf0supplier__s_nation_encoded, d_MAT5e2bc54decf0supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT5e2bc54decf0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5e2bc54decf0part__p_category_encoded, d_MAT5e2bc54decf0part__p_category_encoded, sizeof(DBI16Type) * COUNT5e2bc54decf0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5e2bc54decf0aggr0__tmp_attr0, d_MAT5e2bc54decf0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5e2bc54decf0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5e2bc54decf0; i++) { std::cout << "" << MAT5e2bc54decf0date__d_year[i];
std::cout << "," << supplier__s_nation_map[MAT5e2bc54decf0supplier__s_nation_encoded[i]];
std::cout << "," << part__p_category_map[MAT5e2bc54decf0part__p_category_encoded[i]];
std::cout << "," << MAT5e2bc54decf0aggr0__tmp_attr0[i];
std::cout << std::endl; }
cudaFree(d_BUF_5e2bc554a030);
cudaFree(d_BUF_IDX_5e2bc554a030);
cudaFree(d_COUNT5e2bc554a030);
cudaFree(d_BUF_5e2bc5549b00);
cudaFree(d_BUF_IDX_5e2bc5549b00);
cudaFree(d_COUNT5e2bc5549b00);
cudaFree(d_BUF_5e2bc552ab60);
cudaFree(d_BUF_IDX_5e2bc552ab60);
cudaFree(d_COUNT5e2bc552ab60);
cudaFree(d_BUF_5e2bc5547ee0);
cudaFree(d_BUF_IDX_5e2bc5547ee0);
cudaFree(d_COUNT5e2bc5547ee0);
cudaFree(d_KEY_5e2bc5500900date__d_year);
cudaFree(d_KEY_5e2bc5500900part__p_category_encoded);
cudaFree(d_KEY_5e2bc5500900supplier__s_nation_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5e2bc54decf0);
cudaFree(d_MAT5e2bc54decf0aggr0__tmp_attr0);
cudaFree(d_MAT5e2bc54decf0date__d_year);
cudaFree(d_MAT5e2bc54decf0part__p_category_encoded);
cudaFree(d_MAT5e2bc54decf0supplier__s_nation_encoded);
cudaFree(d_MAT_IDX5e2bc54decf0);
free(MAT5e2bc54decf0aggr0__tmp_attr0);
free(MAT5e2bc54decf0date__d_year);
free(MAT5e2bc54decf0part__p_category_encoded);
free(MAT5e2bc54decf0supplier__s_nation_encoded);
}