#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_595111dcbfd0(uint64_t* COUNT595111dc24f0, DBStringType* part__p_brand1, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_brand1 = part__p_brand1[tid];
if (!(evaluatePredicate(reg_part__p_brand1, "MFGR#2221", Predicate::gte) && evaluatePredicate(reg_part__p_brand1, "MFGR#2228", Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT595111dc24f0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_595111dcbfd0(uint64_t* BUF_595111dc24f0, uint64_t* BUF_IDX_595111dc24f0, HASHTABLE_INSERT HT_595111dc24f0, DBStringType* part__p_brand1, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_brand1 = part__p_brand1[tid];
if (!(evaluatePredicate(reg_part__p_brand1, "MFGR#2221", Predicate::gte) && evaluatePredicate(reg_part__p_brand1, "MFGR#2228", Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_595111dc24f0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_595111dc24f0 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_595111dc24f0 = atomicAdd((int*)BUF_IDX_595111dc24f0, 1);
HT_595111dc24f0.insert(cuco::pair{KEY_595111dc24f0, buf_idx_595111dc24f0});
BUF_595111dc24f0[buf_idx_595111dc24f0 * 1 + 0] = tid;
}
__global__ void count_595111dce8d0(uint64_t* COUNT595111dbed20, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT595111dbed20, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_595111dce8d0(uint64_t* BUF_595111dbed20, uint64_t* BUF_IDX_595111dbed20, HASHTABLE_INSERT HT_595111dbed20, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_595111dbed20 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_595111dbed20 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_595111dbed20 = atomicAdd((int*)BUF_IDX_595111dbed20, 1);
HT_595111dbed20.insert(cuco::pair{KEY_595111dbed20, buf_idx_595111dbed20});
BUF_595111dbed20[buf_idx_595111dbed20 * 1 + 0] = tid;
}
__global__ void count_595111da63b0(uint64_t* COUNT595111dc0ed0, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT595111dc0ed0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_595111da63b0(uint64_t* BUF_595111dc0ed0, uint64_t* BUF_IDX_595111dc0ed0, HASHTABLE_INSERT HT_595111dc0ed0, DBI32Type* date__d_datekey, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_595111dc0ed0 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_595111dc0ed0 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_595111dc0ed0 = atomicAdd((int*)BUF_IDX_595111dc0ed0, 1);
HT_595111dc0ed0.insert(cuco::pair{KEY_595111dc0ed0, buf_idx_595111dc0ed0});
BUF_595111dc0ed0[buf_idx_595111dc0ed0 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_595111da5de0(uint64_t* BUF_595111dbed20, uint64_t* BUF_595111dc0ed0, uint64_t* BUF_595111dc24f0, HASHTABLE_INSERT HT_595111d75620, HASHTABLE_PROBE HT_595111dbed20, HASHTABLE_PROBE HT_595111dc0ed0, HASHTABLE_PROBE HT_595111dc24f0, DBI32Type* date__d_year, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_595111dc24f0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_595111dc24f0 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_595111dc24f0.for_each(KEY_595111dc24f0, [&] __device__ (auto const SLOT_595111dc24f0) {

auto const [slot_first595111dc24f0, slot_second595111dc24f0] = SLOT_595111dc24f0;
if (!(true)) return;
uint64_t KEY_595111dbed20 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_595111dbed20 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_595111dbed20.for_each(KEY_595111dbed20, [&] __device__ (auto const SLOT_595111dbed20) {

auto const [slot_first595111dbed20, slot_second595111dbed20] = SLOT_595111dbed20;
if (!(true)) return;
uint64_t KEY_595111dc0ed0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_595111dc0ed0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_595111dc0ed0.for_each(KEY_595111dc0ed0, [&] __device__ (auto const SLOT_595111dc0ed0) {

auto const [slot_first595111dc0ed0, slot_second595111dc0ed0] = SLOT_595111dc0ed0;
if (!(true)) return;
uint64_t KEY_595111d75620 = 0;
auto reg_date__d_year = date__d_year[BUF_595111dc0ed0[slot_second595111dc0ed0 * 1 + 0]];

KEY_595111d75620 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_595111dc24f0[slot_second595111dc24f0 * 1 + 0]];
KEY_595111d75620 <<= 16;
KEY_595111d75620 |= reg_part__p_brand1_encoded;
//Create aggregation hash table
HT_595111d75620.insert(cuco::pair{KEY_595111d75620, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_595111da5de0(uint64_t* BUF_595111dbed20, uint64_t* BUF_595111dc0ed0, uint64_t* BUF_595111dc24f0, HASHTABLE_FIND HT_595111d75620, HASHTABLE_PROBE HT_595111dbed20, HASHTABLE_PROBE HT_595111dc0ed0, HASHTABLE_PROBE HT_595111dc24f0, DBI32Type* KEY_595111d75620date__d_year, DBI16Type* KEY_595111d75620part__p_brand1_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_595111dc24f0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_595111dc24f0 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_595111dc24f0.for_each(KEY_595111dc24f0, [&] __device__ (auto const SLOT_595111dc24f0) {
auto const [slot_first595111dc24f0, slot_second595111dc24f0] = SLOT_595111dc24f0;
if (!(true)) return;
uint64_t KEY_595111dbed20 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_595111dbed20 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_595111dbed20.for_each(KEY_595111dbed20, [&] __device__ (auto const SLOT_595111dbed20) {
auto const [slot_first595111dbed20, slot_second595111dbed20] = SLOT_595111dbed20;
if (!(true)) return;
uint64_t KEY_595111dc0ed0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_595111dc0ed0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_595111dc0ed0.for_each(KEY_595111dc0ed0, [&] __device__ (auto const SLOT_595111dc0ed0) {
auto const [slot_first595111dc0ed0, slot_second595111dc0ed0] = SLOT_595111dc0ed0;
if (!(true)) return;
uint64_t KEY_595111d75620 = 0;
auto reg_date__d_year = date__d_year[BUF_595111dc0ed0[slot_second595111dc0ed0 * 1 + 0]];

KEY_595111d75620 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_595111dc24f0[slot_second595111dc24f0 * 1 + 0]];
KEY_595111d75620 <<= 16;
KEY_595111d75620 |= reg_part__p_brand1_encoded;
//Aggregate in hashtable
auto buf_idx_595111d75620 = HT_595111d75620.find(KEY_595111d75620)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_595111d75620], reg_lineorder__lo_revenue);
KEY_595111d75620date__d_year[buf_idx_595111d75620] = reg_date__d_year;
KEY_595111d75620part__p_brand1_encoded[buf_idx_595111d75620] = reg_part__p_brand1_encoded;
});
});
});
}
__global__ void count_595111ddde40(size_t COUNT595111d75620, uint64_t* COUNT595111d89400) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT595111d75620) return;
//Materialize count
atomicAdd((int*)COUNT595111d89400, 1);
}
__global__ void main_595111ddde40(size_t COUNT595111d75620, DBDecimalType* MAT595111d89400aggr0__tmp_attr0, DBI32Type* MAT595111d89400date__d_year, DBI16Type* MAT595111d89400part__p_brand1_encoded, uint64_t* MAT_IDX595111d89400, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT595111d75620) return;
//Materialize buffers
auto mat_idx595111d89400 = atomicAdd((int*)MAT_IDX595111d89400, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT595111d89400aggr0__tmp_attr0[mat_idx595111d89400] = reg_aggr0__tmp_attr0;
auto reg_date__d_year = date__d_year[tid];
MAT595111d89400date__d_year[mat_idx595111d89400] = reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[tid];
MAT595111d89400part__p_brand1_encoded[mat_idx595111d89400] = reg_part__p_brand1_encoded;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT595111dc24f0;
cudaMalloc(&d_COUNT595111dc24f0, sizeof(uint64_t));
cudaMemset(d_COUNT595111dc24f0, 0, sizeof(uint64_t));
count_595111dcbfd0<<<std::ceil((float)part_size/128.), 128>>>(d_COUNT595111dc24f0, d_part__p_brand1, part_size);
uint64_t COUNT595111dc24f0;
cudaMemcpy(&COUNT595111dc24f0, d_COUNT595111dc24f0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_595111dc24f0;
cudaMalloc(&d_BUF_IDX_595111dc24f0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_595111dc24f0, 0, sizeof(uint64_t));
uint64_t* d_BUF_595111dc24f0;
cudaMalloc(&d_BUF_595111dc24f0, sizeof(uint64_t) * COUNT595111dc24f0 * 1);
auto d_HT_595111dc24f0 = cuco::experimental::static_multimap{ (int)COUNT595111dc24f0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_595111dcbfd0<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_595111dc24f0, d_BUF_IDX_595111dc24f0, d_HT_595111dc24f0.ref(cuco::insert), d_part__p_brand1, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT595111dbed20;
cudaMalloc(&d_COUNT595111dbed20, sizeof(uint64_t));
cudaMemset(d_COUNT595111dbed20, 0, sizeof(uint64_t));
count_595111dce8d0<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT595111dbed20, d_supplier__s_region, supplier_size);
uint64_t COUNT595111dbed20;
cudaMemcpy(&COUNT595111dbed20, d_COUNT595111dbed20, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_595111dbed20;
cudaMalloc(&d_BUF_IDX_595111dbed20, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_595111dbed20, 0, sizeof(uint64_t));
uint64_t* d_BUF_595111dbed20;
cudaMalloc(&d_BUF_595111dbed20, sizeof(uint64_t) * COUNT595111dbed20 * 1);
auto d_HT_595111dbed20 = cuco::experimental::static_multimap{ (int)COUNT595111dbed20*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_595111dce8d0<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_595111dbed20, d_BUF_IDX_595111dbed20, d_HT_595111dbed20.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT595111dc0ed0;
cudaMalloc(&d_COUNT595111dc0ed0, sizeof(uint64_t));
cudaMemset(d_COUNT595111dc0ed0, 0, sizeof(uint64_t));
count_595111da63b0<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT595111dc0ed0, date_size);
uint64_t COUNT595111dc0ed0;
cudaMemcpy(&COUNT595111dc0ed0, d_COUNT595111dc0ed0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_595111dc0ed0;
cudaMalloc(&d_BUF_IDX_595111dc0ed0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_595111dc0ed0, 0, sizeof(uint64_t));
uint64_t* d_BUF_595111dc0ed0;
cudaMalloc(&d_BUF_595111dc0ed0, sizeof(uint64_t) * COUNT595111dc0ed0 * 1);
auto d_HT_595111dc0ed0 = cuco::experimental::static_multimap{ (int)COUNT595111dc0ed0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_595111da63b0<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_595111dc0ed0, d_BUF_IDX_595111dc0ed0, d_HT_595111dc0ed0.ref(cuco::insert), d_date__d_datekey, date_size);
//Create aggregation hash table
auto d_HT_595111d75620 = cuco::static_map{ (int)3846*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_595111da5de0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_595111dbed20, d_BUF_595111dc0ed0, d_BUF_595111dc24f0, d_HT_595111d75620.ref(cuco::insert), d_HT_595111dbed20.ref(cuco::for_each), d_HT_595111dc0ed0.ref(cuco::for_each), d_HT_595111dc24f0.ref(cuco::for_each), d_date__d_year, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size, d_part__p_brand1_encoded);
size_t COUNT595111d75620 = d_HT_595111d75620.size();
thrust::device_vector<int64_t> keys_595111d75620(COUNT595111d75620), vals_595111d75620(COUNT595111d75620);
d_HT_595111d75620.retrieve_all(keys_595111d75620.begin(), vals_595111d75620.begin());
d_HT_595111d75620.clear();
int64_t* raw_keys595111d75620 = thrust::raw_pointer_cast(keys_595111d75620.data());
insertKeys<<<std::ceil((float)COUNT595111d75620/128.), 128>>>(raw_keys595111d75620, d_HT_595111d75620.ref(cuco::insert), COUNT595111d75620);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT595111d75620);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT595111d75620);
DBI32Type* d_KEY_595111d75620date__d_year;
cudaMalloc(&d_KEY_595111d75620date__d_year, sizeof(DBI32Type) * COUNT595111d75620);
cudaMemset(d_KEY_595111d75620date__d_year, 0, sizeof(DBI32Type) * COUNT595111d75620);
DBI16Type* d_KEY_595111d75620part__p_brand1_encoded;
cudaMalloc(&d_KEY_595111d75620part__p_brand1_encoded, sizeof(DBI16Type) * COUNT595111d75620);
cudaMemset(d_KEY_595111d75620part__p_brand1_encoded, 0, sizeof(DBI16Type) * COUNT595111d75620);
main_595111da5de0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_595111dbed20, d_BUF_595111dc0ed0, d_BUF_595111dc24f0, d_HT_595111d75620.ref(cuco::find), d_HT_595111dbed20.ref(cuco::for_each), d_HT_595111dc0ed0.ref(cuco::for_each), d_HT_595111dc24f0.ref(cuco::for_each), d_KEY_595111d75620date__d_year, d_KEY_595111d75620part__p_brand1_encoded, d_aggr0__tmp_attr0, d_date__d_year, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_part__p_brand1_encoded);
//Materialize count
uint64_t* d_COUNT595111d89400;
cudaMalloc(&d_COUNT595111d89400, sizeof(uint64_t));
cudaMemset(d_COUNT595111d89400, 0, sizeof(uint64_t));
count_595111ddde40<<<std::ceil((float)COUNT595111d75620/128.), 128>>>(COUNT595111d75620, d_COUNT595111d89400);
uint64_t COUNT595111d89400;
cudaMemcpy(&COUNT595111d89400, d_COUNT595111d89400, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX595111d89400;
cudaMalloc(&d_MAT_IDX595111d89400, sizeof(uint64_t));
cudaMemset(d_MAT_IDX595111d89400, 0, sizeof(uint64_t));
auto MAT595111d89400aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT595111d89400);
DBDecimalType* d_MAT595111d89400aggr0__tmp_attr0;
cudaMalloc(&d_MAT595111d89400aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT595111d89400);
auto MAT595111d89400date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT595111d89400);
DBI32Type* d_MAT595111d89400date__d_year;
cudaMalloc(&d_MAT595111d89400date__d_year, sizeof(DBI32Type) * COUNT595111d89400);
auto MAT595111d89400part__p_brand1_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT595111d89400);
DBI16Type* d_MAT595111d89400part__p_brand1_encoded;
cudaMalloc(&d_MAT595111d89400part__p_brand1_encoded, sizeof(DBI16Type) * COUNT595111d89400);
main_595111ddde40<<<std::ceil((float)COUNT595111d75620/128.), 128>>>(COUNT595111d75620, d_MAT595111d89400aggr0__tmp_attr0, d_MAT595111d89400date__d_year, d_MAT595111d89400part__p_brand1_encoded, d_MAT_IDX595111d89400, d_aggr0__tmp_attr0, d_KEY_595111d75620date__d_year, d_KEY_595111d75620part__p_brand1_encoded);
cudaMemcpy(MAT595111d89400aggr0__tmp_attr0, d_MAT595111d89400aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT595111d89400, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT595111d89400date__d_year, d_MAT595111d89400date__d_year, sizeof(DBI32Type) * COUNT595111d89400, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT595111d89400part__p_brand1_encoded, d_MAT595111d89400part__p_brand1_encoded, sizeof(DBI16Type) * COUNT595111d89400, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT595111d89400; i++) { std::cout << "" << MAT595111d89400aggr0__tmp_attr0[i];
std::cout << "," << MAT595111d89400date__d_year[i];
std::cout << "," << part__p_brand1_map[MAT595111d89400part__p_brand1_encoded[i]];
std::cout << std::endl; }
cudaFree(d_BUF_595111dc24f0);
cudaFree(d_BUF_IDX_595111dc24f0);
cudaFree(d_COUNT595111dc24f0);
cudaFree(d_BUF_595111dbed20);
cudaFree(d_BUF_IDX_595111dbed20);
cudaFree(d_COUNT595111dbed20);
cudaFree(d_BUF_595111dc0ed0);
cudaFree(d_BUF_IDX_595111dc0ed0);
cudaFree(d_COUNT595111dc0ed0);
cudaFree(d_KEY_595111d75620date__d_year);
cudaFree(d_KEY_595111d75620part__p_brand1_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT595111d89400);
cudaFree(d_MAT595111d89400aggr0__tmp_attr0);
cudaFree(d_MAT595111d89400date__d_year);
cudaFree(d_MAT595111d89400part__p_brand1_encoded);
cudaFree(d_MAT_IDX595111d89400);
free(MAT595111d89400aggr0__tmp_attr0);
free(MAT595111d89400date__d_year);
free(MAT595111d89400part__p_brand1_encoded);
}