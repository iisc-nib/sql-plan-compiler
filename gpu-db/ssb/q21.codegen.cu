#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5cdcaba87b60(uint64_t* COUNT5cdcabaa5db0, DBStringType* part__p_category, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_category = part__p_category[tid];
if (!(evaluatePredicate(reg_part__p_category, "MFGR#12", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5cdcabaa5db0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5cdcaba87b60(uint64_t* BUF_5cdcabaa5db0, uint64_t* BUF_IDX_5cdcabaa5db0, HASHTABLE_INSERT HT_5cdcabaa5db0, DBStringType* part__p_category, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_category = part__p_category[tid];
if (!(evaluatePredicate(reg_part__p_category, "MFGR#12", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5cdcabaa5db0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_5cdcabaa5db0 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_5cdcabaa5db0 = atomicAdd((int*)BUF_IDX_5cdcabaa5db0, 1);
HT_5cdcabaa5db0.insert(cuco::pair{KEY_5cdcabaa5db0, buf_idx_5cdcabaa5db0});
BUF_5cdcabaa5db0[buf_idx_5cdcabaa5db0 * 1 + 0] = tid;
}
__global__ void count_5cdcabab15c0(uint64_t* COUNT5cdcabaa0080, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5cdcabaa0080, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5cdcabab15c0(uint64_t* BUF_5cdcabaa0080, uint64_t* BUF_IDX_5cdcabaa0080, HASHTABLE_INSERT HT_5cdcabaa0080, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5cdcabaa0080 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5cdcabaa0080 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5cdcabaa0080 = atomicAdd((int*)BUF_IDX_5cdcabaa0080, 1);
HT_5cdcabaa0080.insert(cuco::pair{KEY_5cdcabaa0080, buf_idx_5cdcabaa0080});
BUF_5cdcabaa0080[buf_idx_5cdcabaa0080 * 1 + 0] = tid;
}
__global__ void count_5cdcaba87590(uint64_t* COUNT5cdcabaa3680, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5cdcabaa3680, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5cdcaba87590(uint64_t* BUF_5cdcabaa3680, uint64_t* BUF_IDX_5cdcabaa3680, HASHTABLE_INSERT HT_5cdcabaa3680, DBI32Type* date__d_datekey, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5cdcabaa3680 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5cdcabaa3680 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_5cdcabaa3680 = atomicAdd((int*)BUF_IDX_5cdcabaa3680, 1);
HT_5cdcabaa3680.insert(cuco::pair{KEY_5cdcabaa3680, buf_idx_5cdcabaa3680});
BUF_5cdcabaa3680[buf_idx_5cdcabaa3680 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5cdcaba9dfe0(uint64_t* BUF_5cdcabaa0080, uint64_t* BUF_5cdcabaa3680, uint64_t* BUF_5cdcabaa5db0, HASHTABLE_INSERT HT_5cdcaba58400, HASHTABLE_PROBE HT_5cdcabaa0080, HASHTABLE_PROBE HT_5cdcabaa3680, HASHTABLE_PROBE HT_5cdcabaa5db0, DBI32Type* date__d_year, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5cdcabaa5db0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5cdcabaa5db0 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_5cdcabaa5db0.for_each(KEY_5cdcabaa5db0, [&] __device__ (auto const SLOT_5cdcabaa5db0) {

auto const [slot_first5cdcabaa5db0, slot_second5cdcabaa5db0] = SLOT_5cdcabaa5db0;
if (!(true)) return;
uint64_t KEY_5cdcabaa0080 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5cdcabaa0080 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5cdcabaa0080.for_each(KEY_5cdcabaa0080, [&] __device__ (auto const SLOT_5cdcabaa0080) {

auto const [slot_first5cdcabaa0080, slot_second5cdcabaa0080] = SLOT_5cdcabaa0080;
if (!(true)) return;
uint64_t KEY_5cdcabaa3680 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5cdcabaa3680 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5cdcabaa3680.for_each(KEY_5cdcabaa3680, [&] __device__ (auto const SLOT_5cdcabaa3680) {

auto const [slot_first5cdcabaa3680, slot_second5cdcabaa3680] = SLOT_5cdcabaa3680;
if (!(true)) return;
uint64_t KEY_5cdcaba58400 = 0;
auto reg_date__d_year = date__d_year[BUF_5cdcabaa3680[slot_second5cdcabaa3680 * 1 + 0]];

KEY_5cdcaba58400 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_5cdcabaa5db0[slot_second5cdcabaa5db0 * 1 + 0]];
KEY_5cdcaba58400 <<= 16;
KEY_5cdcaba58400 |= reg_part__p_brand1_encoded;
//Create aggregation hash table
HT_5cdcaba58400.insert(cuco::pair{KEY_5cdcaba58400, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5cdcaba9dfe0(uint64_t* BUF_5cdcabaa0080, uint64_t* BUF_5cdcabaa3680, uint64_t* BUF_5cdcabaa5db0, HASHTABLE_FIND HT_5cdcaba58400, HASHTABLE_PROBE HT_5cdcabaa0080, HASHTABLE_PROBE HT_5cdcabaa3680, HASHTABLE_PROBE HT_5cdcabaa5db0, DBI32Type* KEY_5cdcaba58400date__d_year, DBI16Type* KEY_5cdcaba58400part__p_brand1_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5cdcabaa5db0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5cdcabaa5db0 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_5cdcabaa5db0.for_each(KEY_5cdcabaa5db0, [&] __device__ (auto const SLOT_5cdcabaa5db0) {
auto const [slot_first5cdcabaa5db0, slot_second5cdcabaa5db0] = SLOT_5cdcabaa5db0;
if (!(true)) return;
uint64_t KEY_5cdcabaa0080 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5cdcabaa0080 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_5cdcabaa0080.for_each(KEY_5cdcabaa0080, [&] __device__ (auto const SLOT_5cdcabaa0080) {
auto const [slot_first5cdcabaa0080, slot_second5cdcabaa0080] = SLOT_5cdcabaa0080;
if (!(true)) return;
uint64_t KEY_5cdcabaa3680 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5cdcabaa3680 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5cdcabaa3680.for_each(KEY_5cdcabaa3680, [&] __device__ (auto const SLOT_5cdcabaa3680) {
auto const [slot_first5cdcabaa3680, slot_second5cdcabaa3680] = SLOT_5cdcabaa3680;
if (!(true)) return;
uint64_t KEY_5cdcaba58400 = 0;
auto reg_date__d_year = date__d_year[BUF_5cdcabaa3680[slot_second5cdcabaa3680 * 1 + 0]];

KEY_5cdcaba58400 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_5cdcabaa5db0[slot_second5cdcabaa5db0 * 1 + 0]];
KEY_5cdcaba58400 <<= 16;
KEY_5cdcaba58400 |= reg_part__p_brand1_encoded;
//Aggregate in hashtable
auto buf_idx_5cdcaba58400 = HT_5cdcaba58400.find(KEY_5cdcaba58400)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5cdcaba58400], reg_lineorder__lo_revenue);
KEY_5cdcaba58400date__d_year[buf_idx_5cdcaba58400] = reg_date__d_year;
KEY_5cdcaba58400part__p_brand1_encoded[buf_idx_5cdcaba58400] = reg_part__p_brand1_encoded;
});
});
});
}
__global__ void count_5cdcabac08a0(size_t COUNT5cdcaba58400, uint64_t* COUNT5cdcaba6b580) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5cdcaba58400) return;
//Materialize count
atomicAdd((int*)COUNT5cdcaba6b580, 1);
}
__global__ void main_5cdcabac08a0(size_t COUNT5cdcaba58400, DBDecimalType* MAT5cdcaba6b580aggr0__tmp_attr0, DBI32Type* MAT5cdcaba6b580date__d_year, DBI16Type* MAT5cdcaba6b580part__p_brand1_encoded, uint64_t* MAT_IDX5cdcaba6b580, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5cdcaba58400) return;
//Materialize buffers
auto mat_idx5cdcaba6b580 = atomicAdd((int*)MAT_IDX5cdcaba6b580, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5cdcaba6b580aggr0__tmp_attr0[mat_idx5cdcaba6b580] = reg_aggr0__tmp_attr0;
auto reg_date__d_year = date__d_year[tid];
MAT5cdcaba6b580date__d_year[mat_idx5cdcaba6b580] = reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[tid];
MAT5cdcaba6b580part__p_brand1_encoded[mat_idx5cdcaba6b580] = reg_part__p_brand1_encoded;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT5cdcabaa5db0;
cudaMalloc(&d_COUNT5cdcabaa5db0, sizeof(uint64_t));
cudaMemset(d_COUNT5cdcabaa5db0, 0, sizeof(uint64_t));
count_5cdcaba87b60<<<std::ceil((float)part_size/128.), 128>>>(d_COUNT5cdcabaa5db0, d_part__p_category, part_size);
uint64_t COUNT5cdcabaa5db0;
cudaMemcpy(&COUNT5cdcabaa5db0, d_COUNT5cdcabaa5db0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5cdcabaa5db0;
cudaMalloc(&d_BUF_IDX_5cdcabaa5db0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5cdcabaa5db0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5cdcabaa5db0;
cudaMalloc(&d_BUF_5cdcabaa5db0, sizeof(uint64_t) * COUNT5cdcabaa5db0 * 1);
auto d_HT_5cdcabaa5db0 = cuco::experimental::static_multimap{ (int)COUNT5cdcabaa5db0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5cdcaba87b60<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_5cdcabaa5db0, d_BUF_IDX_5cdcabaa5db0, d_HT_5cdcabaa5db0.ref(cuco::insert), d_part__p_category, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT5cdcabaa0080;
cudaMalloc(&d_COUNT5cdcabaa0080, sizeof(uint64_t));
cudaMemset(d_COUNT5cdcabaa0080, 0, sizeof(uint64_t));
count_5cdcabab15c0<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT5cdcabaa0080, d_supplier__s_region, supplier_size);
uint64_t COUNT5cdcabaa0080;
cudaMemcpy(&COUNT5cdcabaa0080, d_COUNT5cdcabaa0080, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5cdcabaa0080;
cudaMalloc(&d_BUF_IDX_5cdcabaa0080, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5cdcabaa0080, 0, sizeof(uint64_t));
uint64_t* d_BUF_5cdcabaa0080;
cudaMalloc(&d_BUF_5cdcabaa0080, sizeof(uint64_t) * COUNT5cdcabaa0080 * 1);
auto d_HT_5cdcabaa0080 = cuco::experimental::static_multimap{ (int)COUNT5cdcabaa0080*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5cdcabab15c0<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_5cdcabaa0080, d_BUF_IDX_5cdcabaa0080, d_HT_5cdcabaa0080.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT5cdcabaa3680;
cudaMalloc(&d_COUNT5cdcabaa3680, sizeof(uint64_t));
cudaMemset(d_COUNT5cdcabaa3680, 0, sizeof(uint64_t));
count_5cdcaba87590<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT5cdcabaa3680, date_size);
uint64_t COUNT5cdcabaa3680;
cudaMemcpy(&COUNT5cdcabaa3680, d_COUNT5cdcabaa3680, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5cdcabaa3680;
cudaMalloc(&d_BUF_IDX_5cdcabaa3680, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5cdcabaa3680, 0, sizeof(uint64_t));
uint64_t* d_BUF_5cdcabaa3680;
cudaMalloc(&d_BUF_5cdcabaa3680, sizeof(uint64_t) * COUNT5cdcabaa3680 * 1);
auto d_HT_5cdcabaa3680 = cuco::experimental::static_multimap{ (int)COUNT5cdcabaa3680*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5cdcaba87590<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_5cdcabaa3680, d_BUF_IDX_5cdcabaa3680, d_HT_5cdcabaa3680.ref(cuco::insert), d_date__d_datekey, date_size);
//Create aggregation hash table
auto d_HT_5cdcaba58400 = cuco::static_map{ (int)52974*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5cdcaba9dfe0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5cdcabaa0080, d_BUF_5cdcabaa3680, d_BUF_5cdcabaa5db0, d_HT_5cdcaba58400.ref(cuco::insert), d_HT_5cdcabaa0080.ref(cuco::for_each), d_HT_5cdcabaa3680.ref(cuco::for_each), d_HT_5cdcabaa5db0.ref(cuco::for_each), d_date__d_year, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size, d_part__p_brand1_encoded);
size_t COUNT5cdcaba58400 = d_HT_5cdcaba58400.size();
thrust::device_vector<int64_t> keys_5cdcaba58400(COUNT5cdcaba58400), vals_5cdcaba58400(COUNT5cdcaba58400);
d_HT_5cdcaba58400.retrieve_all(keys_5cdcaba58400.begin(), vals_5cdcaba58400.begin());
d_HT_5cdcaba58400.clear();
int64_t* raw_keys5cdcaba58400 = thrust::raw_pointer_cast(keys_5cdcaba58400.data());
insertKeys<<<std::ceil((float)COUNT5cdcaba58400/128.), 128>>>(raw_keys5cdcaba58400, d_HT_5cdcaba58400.ref(cuco::insert), COUNT5cdcaba58400);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5cdcaba58400);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5cdcaba58400);
DBI32Type* d_KEY_5cdcaba58400date__d_year;
cudaMalloc(&d_KEY_5cdcaba58400date__d_year, sizeof(DBI32Type) * COUNT5cdcaba58400);
cudaMemset(d_KEY_5cdcaba58400date__d_year, 0, sizeof(DBI32Type) * COUNT5cdcaba58400);
DBI16Type* d_KEY_5cdcaba58400part__p_brand1_encoded;
cudaMalloc(&d_KEY_5cdcaba58400part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5cdcaba58400);
cudaMemset(d_KEY_5cdcaba58400part__p_brand1_encoded, 0, sizeof(DBI16Type) * COUNT5cdcaba58400);
main_5cdcaba9dfe0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5cdcabaa0080, d_BUF_5cdcabaa3680, d_BUF_5cdcabaa5db0, d_HT_5cdcaba58400.ref(cuco::find), d_HT_5cdcabaa0080.ref(cuco::for_each), d_HT_5cdcabaa3680.ref(cuco::for_each), d_HT_5cdcabaa5db0.ref(cuco::for_each), d_KEY_5cdcaba58400date__d_year, d_KEY_5cdcaba58400part__p_brand1_encoded, d_aggr0__tmp_attr0, d_date__d_year, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_part__p_brand1_encoded);
//Materialize count
uint64_t* d_COUNT5cdcaba6b580;
cudaMalloc(&d_COUNT5cdcaba6b580, sizeof(uint64_t));
cudaMemset(d_COUNT5cdcaba6b580, 0, sizeof(uint64_t));
count_5cdcabac08a0<<<std::ceil((float)COUNT5cdcaba58400/128.), 128>>>(COUNT5cdcaba58400, d_COUNT5cdcaba6b580);
uint64_t COUNT5cdcaba6b580;
cudaMemcpy(&COUNT5cdcaba6b580, d_COUNT5cdcaba6b580, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5cdcaba6b580;
cudaMalloc(&d_MAT_IDX5cdcaba6b580, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5cdcaba6b580, 0, sizeof(uint64_t));
auto MAT5cdcaba6b580aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5cdcaba6b580);
DBDecimalType* d_MAT5cdcaba6b580aggr0__tmp_attr0;
cudaMalloc(&d_MAT5cdcaba6b580aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5cdcaba6b580);
auto MAT5cdcaba6b580date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5cdcaba6b580);
DBI32Type* d_MAT5cdcaba6b580date__d_year;
cudaMalloc(&d_MAT5cdcaba6b580date__d_year, sizeof(DBI32Type) * COUNT5cdcaba6b580);
auto MAT5cdcaba6b580part__p_brand1_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5cdcaba6b580);
DBI16Type* d_MAT5cdcaba6b580part__p_brand1_encoded;
cudaMalloc(&d_MAT5cdcaba6b580part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5cdcaba6b580);
main_5cdcabac08a0<<<std::ceil((float)COUNT5cdcaba58400/128.), 128>>>(COUNT5cdcaba58400, d_MAT5cdcaba6b580aggr0__tmp_attr0, d_MAT5cdcaba6b580date__d_year, d_MAT5cdcaba6b580part__p_brand1_encoded, d_MAT_IDX5cdcaba6b580, d_aggr0__tmp_attr0, d_KEY_5cdcaba58400date__d_year, d_KEY_5cdcaba58400part__p_brand1_encoded);
cudaMemcpy(MAT5cdcaba6b580aggr0__tmp_attr0, d_MAT5cdcaba6b580aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5cdcaba6b580, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5cdcaba6b580date__d_year, d_MAT5cdcaba6b580date__d_year, sizeof(DBI32Type) * COUNT5cdcaba6b580, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5cdcaba6b580part__p_brand1_encoded, d_MAT5cdcaba6b580part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5cdcaba6b580, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5cdcaba6b580; i++) { std::cout << "" << MAT5cdcaba6b580aggr0__tmp_attr0[i];
std::cout << "," << MAT5cdcaba6b580date__d_year[i];
std::cout << "," << part__p_brand1_map[MAT5cdcaba6b580part__p_brand1_encoded[i]];
std::cout << std::endl; }
cudaFree(d_BUF_5cdcabaa5db0);
cudaFree(d_BUF_IDX_5cdcabaa5db0);
cudaFree(d_COUNT5cdcabaa5db0);
cudaFree(d_BUF_5cdcabaa0080);
cudaFree(d_BUF_IDX_5cdcabaa0080);
cudaFree(d_COUNT5cdcabaa0080);
cudaFree(d_BUF_5cdcabaa3680);
cudaFree(d_BUF_IDX_5cdcabaa3680);
cudaFree(d_COUNT5cdcabaa3680);
cudaFree(d_KEY_5cdcaba58400date__d_year);
cudaFree(d_KEY_5cdcaba58400part__p_brand1_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5cdcaba6b580);
cudaFree(d_MAT5cdcaba6b580aggr0__tmp_attr0);
cudaFree(d_MAT5cdcaba6b580date__d_year);
cudaFree(d_MAT5cdcaba6b580part__p_brand1_encoded);
cudaFree(d_MAT_IDX5cdcaba6b580);
free(MAT5cdcaba6b580aggr0__tmp_attr0);
free(MAT5cdcaba6b580date__d_year);
free(MAT5cdcaba6b580part__p_brand1_encoded);
}