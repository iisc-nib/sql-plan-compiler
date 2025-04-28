#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5caca179c3c0(uint64_t* COUNT5caca178c9e0, DBStringType* supplier__s_nation, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_nation = supplier__s_nation[tid];
if (!(evaluatePredicate(reg_supplier__s_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5caca178c9e0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5caca179c3c0(uint64_t* BUF_5caca178c9e0, uint64_t* BUF_IDX_5caca178c9e0, HASHTABLE_INSERT HT_5caca178c9e0, DBStringType* supplier__s_nation, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_nation = supplier__s_nation[tid];
if (!(evaluatePredicate(reg_supplier__s_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5caca178c9e0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5caca178c9e0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5caca178c9e0 = atomicAdd((int*)BUF_IDX_5caca178c9e0, 1);
HT_5caca178c9e0.insert(cuco::pair{KEY_5caca178c9e0, buf_idx_5caca178c9e0});
BUF_5caca178c9e0[buf_idx_5caca178c9e0 * 1 + 0] = tid;
}
__global__ void count_5caca179e870(uint64_t* COUNT5caca176e730, DBStringType* part__p_category, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_category = part__p_category[tid];
if (!(evaluatePredicate(reg_part__p_category, "MFGR#14", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5caca176e730, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5caca179e870(uint64_t* BUF_5caca176e730, uint64_t* BUF_IDX_5caca176e730, HASHTABLE_INSERT HT_5caca176e730, DBStringType* part__p_category, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_category = part__p_category[tid];
if (!(evaluatePredicate(reg_part__p_category, "MFGR#14", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5caca176e730 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_5caca176e730 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_5caca176e730 = atomicAdd((int*)BUF_IDX_5caca176e730, 1);
HT_5caca176e730.insert(cuco::pair{KEY_5caca176e730, buf_idx_5caca176e730});
BUF_5caca176e730[buf_idx_5caca176e730 * 1 + 0] = tid;
}
__global__ void count_5caca1734b80(uint64_t* COUNT5caca178f780, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5caca178f780, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5caca1734b80(uint64_t* BUF_5caca178f780, uint64_t* BUF_IDX_5caca178f780, HASHTABLE_INSERT HT_5caca178f780, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!((evaluatePredicate(reg_date__d_year, 1997, Predicate::eq)) || (evaluatePredicate(reg_date__d_year, 1998, Predicate::eq)))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5caca178f780 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5caca178f780 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_5caca178f780 = atomicAdd((int*)BUF_IDX_5caca178f780, 1);
HT_5caca178f780.insert(cuco::pair{KEY_5caca178f780, buf_idx_5caca178f780});
BUF_5caca178f780[buf_idx_5caca178f780 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5caca17a0bc0(uint64_t* BUF_5caca176e730, uint64_t* BUF_5caca178c9e0, uint64_t* BUF_5caca178f780, uint64_t* COUNT5caca1791330, HASHTABLE_PROBE HT_5caca176e730, HASHTABLE_PROBE HT_5caca178c9e0, HASHTABLE_PROBE HT_5caca178f780, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_5caca178c9e0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5caca178c9e0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5caca178c9e0.for_each(KEY_5caca178c9e0, [&] __device__ (auto const SLOT_5caca178c9e0) {

auto const [slot_first5caca178c9e0, slot_second5caca178c9e0] = SLOT_5caca178c9e0;
if (!(true)) return;
uint64_t KEY_5caca176e730 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5caca176e730 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_5caca176e730.for_each(KEY_5caca176e730, [&] __device__ (auto const SLOT_5caca176e730) {

auto const [slot_first5caca176e730, slot_second5caca176e730] = SLOT_5caca176e730;
if (!(true)) return;
uint64_t KEY_5caca178f780 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5caca178f780 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5caca178f780.for_each(KEY_5caca178f780, [&] __device__ (auto const SLOT_5caca178f780) {

auto const [slot_first5caca178f780, slot_second5caca178f780] = SLOT_5caca178f780;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5caca1791330, 1);
});
});
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5caca17a0bc0(uint64_t* BUF_5caca176e730, uint64_t* BUF_5caca178c9e0, uint64_t* BUF_5caca178f780, uint64_t* BUF_5caca1791330, uint64_t* BUF_IDX_5caca1791330, HASHTABLE_PROBE HT_5caca176e730, HASHTABLE_PROBE HT_5caca178c9e0, HASHTABLE_PROBE HT_5caca178f780, HASHTABLE_INSERT HT_5caca1791330, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
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
uint64_t KEY_5caca178c9e0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5caca178c9e0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5caca178c9e0.for_each(KEY_5caca178c9e0, [&] __device__ (auto const SLOT_5caca178c9e0) {
auto const [slot_first5caca178c9e0, slot_second5caca178c9e0] = SLOT_5caca178c9e0;
if (!(true)) return;
uint64_t KEY_5caca176e730 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5caca176e730 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_5caca176e730.for_each(KEY_5caca176e730, [&] __device__ (auto const SLOT_5caca176e730) {
auto const [slot_first5caca176e730, slot_second5caca176e730] = SLOT_5caca176e730;
if (!(true)) return;
uint64_t KEY_5caca178f780 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5caca178f780 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5caca178f780.for_each(KEY_5caca178f780, [&] __device__ (auto const SLOT_5caca178f780) {
auto const [slot_first5caca178f780, slot_second5caca178f780] = SLOT_5caca178f780;
if (!(true)) return;
uint64_t KEY_5caca1791330 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5caca1791330 |= reg_lineorder__lo_custkey;
// Insert hash table kernel;
auto buf_idx_5caca1791330 = atomicAdd((int*)BUF_IDX_5caca1791330, 1);
HT_5caca1791330.insert(cuco::pair{KEY_5caca1791330, buf_idx_5caca1791330});
BUF_5caca1791330[buf_idx_5caca1791330 * 4 + 0] = BUF_5caca178f780[slot_second5caca178f780 * 1 + 0];
BUF_5caca1791330[buf_idx_5caca1791330 * 4 + 1] = BUF_5caca178c9e0[slot_second5caca178c9e0 * 1 + 0];
BUF_5caca1791330[buf_idx_5caca1791330 * 4 + 2] = BUF_5caca176e730[slot_second5caca176e730 * 1 + 0];
BUF_5caca1791330[buf_idx_5caca1791330 * 4 + 3] = tid;
});
});
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5caca1734940(uint64_t* BUF_5caca1791330, HASHTABLE_INSERT HT_5caca17441d0, HASHTABLE_PROBE HT_5caca1791330, DBI32Type* customer__c_custkey, size_t customer_size, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5caca1791330 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5caca1791330 |= reg_customer__c_custkey;
//Probe Hash table
HT_5caca1791330.for_each(KEY_5caca1791330, [&] __device__ (auto const SLOT_5caca1791330) {

auto const [slot_first5caca1791330, slot_second5caca1791330] = SLOT_5caca1791330;
if (!(true)) return;
uint64_t KEY_5caca17441d0 = 0;
auto reg_date__d_year = date__d_year[BUF_5caca1791330[slot_second5caca1791330 * 4 + 0]];

KEY_5caca17441d0 |= reg_date__d_year;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_5caca1791330[slot_second5caca1791330 * 4 + 1]];
KEY_5caca17441d0 <<= 16;
KEY_5caca17441d0 |= reg_supplier__s_city_encoded;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_5caca1791330[slot_second5caca1791330 * 4 + 2]];
KEY_5caca17441d0 <<= 16;
KEY_5caca17441d0 |= reg_part__p_brand1_encoded;
//Create aggregation hash table
HT_5caca17441d0.insert(cuco::pair{KEY_5caca17441d0, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5caca1734940(uint64_t* BUF_5caca1791330, HASHTABLE_FIND HT_5caca17441d0, HASHTABLE_PROBE HT_5caca1791330, DBI32Type* KEY_5caca17441d0date__d_year, DBI16Type* KEY_5caca17441d0part__p_brand1_encoded, DBI16Type* KEY_5caca17441d0supplier__s_city_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* customer__c_custkey, size_t customer_size, DBI32Type* date__d_year, DBDecimalType* lineorder__lo_revenue, DBDecimalType* lineorder__lo_supplycost, DBI16Type* part__p_brand1_encoded, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5caca1791330 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5caca1791330 |= reg_customer__c_custkey;
//Probe Hash table
HT_5caca1791330.for_each(KEY_5caca1791330, [&] __device__ (auto const SLOT_5caca1791330) {
auto const [slot_first5caca1791330, slot_second5caca1791330] = SLOT_5caca1791330;
if (!(true)) return;
uint64_t KEY_5caca17441d0 = 0;
auto reg_date__d_year = date__d_year[BUF_5caca1791330[slot_second5caca1791330 * 4 + 0]];

KEY_5caca17441d0 |= reg_date__d_year;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_5caca1791330[slot_second5caca1791330 * 4 + 1]];
KEY_5caca17441d0 <<= 16;
KEY_5caca17441d0 |= reg_supplier__s_city_encoded;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_5caca1791330[slot_second5caca1791330 * 4 + 2]];
KEY_5caca17441d0 <<= 16;
KEY_5caca17441d0 |= reg_part__p_brand1_encoded;
//Aggregate in hashtable
auto buf_idx_5caca17441d0 = HT_5caca17441d0.find(KEY_5caca17441d0)->second;
auto reg_lineorder__lo_supplycost = lineorder__lo_supplycost[BUF_5caca1791330[slot_second5caca1791330 * 4 + 3]];
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[BUF_5caca1791330[slot_second5caca1791330 * 4 + 3]];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_revenue) - (reg_lineorder__lo_supplycost);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5caca17441d0], reg_map0__tmp_attr1);
KEY_5caca17441d0date__d_year[buf_idx_5caca17441d0] = reg_date__d_year;
KEY_5caca17441d0supplier__s_city_encoded[buf_idx_5caca17441d0] = reg_supplier__s_city_encoded;
KEY_5caca17441d0part__p_brand1_encoded[buf_idx_5caca17441d0] = reg_part__p_brand1_encoded;
});
}
__global__ void count_5caca17b8660(uint64_t* COUNT5caca1723900, size_t COUNT5caca17441d0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5caca17441d0) return;
//Materialize count
atomicAdd((int*)COUNT5caca1723900, 1);
}
__global__ void main_5caca17b8660(size_t COUNT5caca17441d0, DBDecimalType* MAT5caca1723900aggr0__tmp_attr0, DBI32Type* MAT5caca1723900date__d_year, DBI16Type* MAT5caca1723900part__p_brand1_encoded, DBI16Type* MAT5caca1723900supplier__s_city_encoded, uint64_t* MAT_IDX5caca1723900, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5caca17441d0) return;
//Materialize buffers
auto mat_idx5caca1723900 = atomicAdd((int*)MAT_IDX5caca1723900, 1);
auto reg_date__d_year = date__d_year[tid];
MAT5caca1723900date__d_year[mat_idx5caca1723900] = reg_date__d_year;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[tid];
MAT5caca1723900supplier__s_city_encoded[mat_idx5caca1723900] = reg_supplier__s_city_encoded;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[tid];
MAT5caca1723900part__p_brand1_encoded[mat_idx5caca1723900] = reg_part__p_brand1_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5caca1723900aggr0__tmp_attr0[mat_idx5caca1723900] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map) {
//Materialize count
uint64_t* d_COUNT5caca178c9e0;
cudaMalloc(&d_COUNT5caca178c9e0, sizeof(uint64_t));
cudaMemset(d_COUNT5caca178c9e0, 0, sizeof(uint64_t));
count_5caca179c3c0<<<std::ceil((float)supplier_size/32.), 32>>>(d_COUNT5caca178c9e0, d_supplier__s_nation, supplier_size);
uint64_t COUNT5caca178c9e0;
cudaMemcpy(&COUNT5caca178c9e0, d_COUNT5caca178c9e0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5caca178c9e0;
cudaMalloc(&d_BUF_IDX_5caca178c9e0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5caca178c9e0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5caca178c9e0;
cudaMalloc(&d_BUF_5caca178c9e0, sizeof(uint64_t) * COUNT5caca178c9e0 * 1);
auto d_HT_5caca178c9e0 = cuco::experimental::static_multimap{ (int)COUNT5caca178c9e0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5caca179c3c0<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_5caca178c9e0, d_BUF_IDX_5caca178c9e0, d_HT_5caca178c9e0.ref(cuco::insert), d_supplier__s_nation, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT5caca176e730;
cudaMalloc(&d_COUNT5caca176e730, sizeof(uint64_t));
cudaMemset(d_COUNT5caca176e730, 0, sizeof(uint64_t));
count_5caca179e870<<<std::ceil((float)part_size/32.), 32>>>(d_COUNT5caca176e730, d_part__p_category, part_size);
uint64_t COUNT5caca176e730;
cudaMemcpy(&COUNT5caca176e730, d_COUNT5caca176e730, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5caca176e730;
cudaMalloc(&d_BUF_IDX_5caca176e730, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5caca176e730, 0, sizeof(uint64_t));
uint64_t* d_BUF_5caca176e730;
cudaMalloc(&d_BUF_5caca176e730, sizeof(uint64_t) * COUNT5caca176e730 * 1);
auto d_HT_5caca176e730 = cuco::experimental::static_multimap{ (int)COUNT5caca176e730*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5caca179e870<<<std::ceil((float)part_size/32.), 32>>>(d_BUF_5caca176e730, d_BUF_IDX_5caca176e730, d_HT_5caca176e730.ref(cuco::insert), d_part__p_category, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT5caca178f780;
cudaMalloc(&d_COUNT5caca178f780, sizeof(uint64_t));
cudaMemset(d_COUNT5caca178f780, 0, sizeof(uint64_t));
count_5caca1734b80<<<std::ceil((float)date_size/32.), 32>>>(d_COUNT5caca178f780, d_date__d_year, date_size);
uint64_t COUNT5caca178f780;
cudaMemcpy(&COUNT5caca178f780, d_COUNT5caca178f780, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5caca178f780;
cudaMalloc(&d_BUF_IDX_5caca178f780, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5caca178f780, 0, sizeof(uint64_t));
uint64_t* d_BUF_5caca178f780;
cudaMalloc(&d_BUF_5caca178f780, sizeof(uint64_t) * COUNT5caca178f780 * 1);
auto d_HT_5caca178f780 = cuco::experimental::static_multimap{ (int)COUNT5caca178f780*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5caca1734b80<<<std::ceil((float)date_size/32.), 32>>>(d_BUF_5caca178f780, d_BUF_IDX_5caca178f780, d_HT_5caca178f780.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Materialize count
uint64_t* d_COUNT5caca1791330;
cudaMalloc(&d_COUNT5caca1791330, sizeof(uint64_t));
cudaMemset(d_COUNT5caca1791330, 0, sizeof(uint64_t));
count_5caca17a0bc0<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_5caca176e730, d_BUF_5caca178c9e0, d_BUF_5caca178f780, d_COUNT5caca1791330, d_HT_5caca176e730.ref(cuco::for_each), d_HT_5caca178c9e0.ref(cuco::for_each), d_HT_5caca178f780.ref(cuco::for_each), d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
uint64_t COUNT5caca1791330;
cudaMemcpy(&COUNT5caca1791330, d_COUNT5caca1791330, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5caca1791330;
cudaMalloc(&d_BUF_IDX_5caca1791330, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5caca1791330, 0, sizeof(uint64_t));
uint64_t* d_BUF_5caca1791330;
cudaMalloc(&d_BUF_5caca1791330, sizeof(uint64_t) * COUNT5caca1791330 * 4);
auto d_HT_5caca1791330 = cuco::experimental::static_multimap{ (int)COUNT5caca1791330*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5caca17a0bc0<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_5caca176e730, d_BUF_5caca178c9e0, d_BUF_5caca178f780, d_BUF_5caca1791330, d_BUF_IDX_5caca1791330, d_HT_5caca176e730.ref(cuco::for_each), d_HT_5caca178c9e0.ref(cuco::for_each), d_HT_5caca178f780.ref(cuco::for_each), d_HT_5caca1791330.ref(cuco::insert), d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
//Create aggregation hash table
auto d_HT_5caca17441d0 = cuco::static_map{ (int)2259*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5caca1734940<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5caca1791330, d_HT_5caca17441d0.ref(cuco::insert), d_HT_5caca1791330.ref(cuco::for_each), d_customer__c_custkey, customer_size, d_date__d_year, d_part__p_brand1_encoded, d_supplier__s_city_encoded);
size_t COUNT5caca17441d0 = d_HT_5caca17441d0.size();
thrust::device_vector<int64_t> keys_5caca17441d0(COUNT5caca17441d0), vals_5caca17441d0(COUNT5caca17441d0);
d_HT_5caca17441d0.retrieve_all(keys_5caca17441d0.begin(), vals_5caca17441d0.begin());
d_HT_5caca17441d0.clear();
int64_t* raw_keys5caca17441d0 = thrust::raw_pointer_cast(keys_5caca17441d0.data());
insertKeys<<<std::ceil((float)COUNT5caca17441d0/32.), 32>>>(raw_keys5caca17441d0, d_HT_5caca17441d0.ref(cuco::insert), COUNT5caca17441d0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5caca17441d0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5caca17441d0);
DBI32Type* d_KEY_5caca17441d0date__d_year;
cudaMalloc(&d_KEY_5caca17441d0date__d_year, sizeof(DBI32Type) * COUNT5caca17441d0);
cudaMemset(d_KEY_5caca17441d0date__d_year, 0, sizeof(DBI32Type) * COUNT5caca17441d0);
DBI16Type* d_KEY_5caca17441d0supplier__s_city_encoded;
cudaMalloc(&d_KEY_5caca17441d0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5caca17441d0);
cudaMemset(d_KEY_5caca17441d0supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT5caca17441d0);
DBI16Type* d_KEY_5caca17441d0part__p_brand1_encoded;
cudaMalloc(&d_KEY_5caca17441d0part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5caca17441d0);
cudaMemset(d_KEY_5caca17441d0part__p_brand1_encoded, 0, sizeof(DBI16Type) * COUNT5caca17441d0);
main_5caca1734940<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5caca1791330, d_HT_5caca17441d0.ref(cuco::find), d_HT_5caca1791330.ref(cuco::for_each), d_KEY_5caca17441d0date__d_year, d_KEY_5caca17441d0part__p_brand1_encoded, d_KEY_5caca17441d0supplier__s_city_encoded, d_aggr0__tmp_attr0, d_customer__c_custkey, customer_size, d_date__d_year, d_lineorder__lo_revenue, d_lineorder__lo_supplycost, d_part__p_brand1_encoded, d_supplier__s_city_encoded);
//Materialize count
uint64_t* d_COUNT5caca1723900;
cudaMalloc(&d_COUNT5caca1723900, sizeof(uint64_t));
cudaMemset(d_COUNT5caca1723900, 0, sizeof(uint64_t));
count_5caca17b8660<<<std::ceil((float)COUNT5caca17441d0/32.), 32>>>(d_COUNT5caca1723900, COUNT5caca17441d0);
uint64_t COUNT5caca1723900;
cudaMemcpy(&COUNT5caca1723900, d_COUNT5caca1723900, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5caca1723900;
cudaMalloc(&d_MAT_IDX5caca1723900, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5caca1723900, 0, sizeof(uint64_t));
auto MAT5caca1723900date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5caca1723900);
DBI32Type* d_MAT5caca1723900date__d_year;
cudaMalloc(&d_MAT5caca1723900date__d_year, sizeof(DBI32Type) * COUNT5caca1723900);
auto MAT5caca1723900supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5caca1723900);
DBI16Type* d_MAT5caca1723900supplier__s_city_encoded;
cudaMalloc(&d_MAT5caca1723900supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5caca1723900);
auto MAT5caca1723900part__p_brand1_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5caca1723900);
DBI16Type* d_MAT5caca1723900part__p_brand1_encoded;
cudaMalloc(&d_MAT5caca1723900part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5caca1723900);
auto MAT5caca1723900aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5caca1723900);
DBDecimalType* d_MAT5caca1723900aggr0__tmp_attr0;
cudaMalloc(&d_MAT5caca1723900aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5caca1723900);
main_5caca17b8660<<<std::ceil((float)COUNT5caca17441d0/32.), 32>>>(COUNT5caca17441d0, d_MAT5caca1723900aggr0__tmp_attr0, d_MAT5caca1723900date__d_year, d_MAT5caca1723900part__p_brand1_encoded, d_MAT5caca1723900supplier__s_city_encoded, d_MAT_IDX5caca1723900, d_aggr0__tmp_attr0, d_KEY_5caca17441d0date__d_year, d_KEY_5caca17441d0part__p_brand1_encoded, d_KEY_5caca17441d0supplier__s_city_encoded);
cudaMemcpy(MAT5caca1723900date__d_year, d_MAT5caca1723900date__d_year, sizeof(DBI32Type) * COUNT5caca1723900, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5caca1723900supplier__s_city_encoded, d_MAT5caca1723900supplier__s_city_encoded, sizeof(DBI16Type) * COUNT5caca1723900, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5caca1723900part__p_brand1_encoded, d_MAT5caca1723900part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5caca1723900, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5caca1723900aggr0__tmp_attr0, d_MAT5caca1723900aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5caca1723900, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5caca1723900; i++) { std::cout << MAT5caca1723900date__d_year[i] << "\t";
std::cout << supplier__s_city_map[MAT5caca1723900supplier__s_city_encoded[i]] << "\t";
std::cout << part__p_brand1_map[MAT5caca1723900part__p_brand1_encoded[i]] << "\t";
std::cout << MAT5caca1723900aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_5caca178c9e0);
cudaFree(d_BUF_IDX_5caca178c9e0);
cudaFree(d_COUNT5caca178c9e0);
cudaFree(d_BUF_5caca176e730);
cudaFree(d_BUF_IDX_5caca176e730);
cudaFree(d_COUNT5caca176e730);
cudaFree(d_BUF_5caca178f780);
cudaFree(d_BUF_IDX_5caca178f780);
cudaFree(d_COUNT5caca178f780);
cudaFree(d_BUF_5caca1791330);
cudaFree(d_BUF_IDX_5caca1791330);
cudaFree(d_COUNT5caca1791330);
cudaFree(d_KEY_5caca17441d0date__d_year);
cudaFree(d_KEY_5caca17441d0part__p_brand1_encoded);
cudaFree(d_KEY_5caca17441d0supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5caca1723900);
cudaFree(d_MAT5caca1723900aggr0__tmp_attr0);
cudaFree(d_MAT5caca1723900date__d_year);
cudaFree(d_MAT5caca1723900part__p_brand1_encoded);
cudaFree(d_MAT5caca1723900supplier__s_city_encoded);
cudaFree(d_MAT_IDX5caca1723900);
free(MAT5caca1723900aggr0__tmp_attr0);
free(MAT5caca1723900date__d_year);
free(MAT5caca1723900part__p_brand1_encoded);
free(MAT5caca1723900supplier__s_city_encoded);
}