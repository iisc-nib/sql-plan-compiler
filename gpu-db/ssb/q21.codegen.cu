#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_57fc10a61860(uint64_t* COUNT57fc10a56d10, DBStringType* part__p_category, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_category = part__p_category[tid];
if (!(evaluatePredicate(reg_part__p_category, "MFGR#12", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT57fc10a56d10, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_57fc10a61860(uint64_t* BUF_57fc10a56d10, uint64_t* BUF_IDX_57fc10a56d10, HASHTABLE_INSERT HT_57fc10a56d10, DBStringType* part__p_category, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_category = part__p_category[tid];
if (!(evaluatePredicate(reg_part__p_category, "MFGR#12", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_57fc10a56d10 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_57fc10a56d10 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_57fc10a56d10 = atomicAdd((int*)BUF_IDX_57fc10a56d10, 1);
HT_57fc10a56d10.insert(cuco::pair{KEY_57fc10a56d10, buf_idx_57fc10a56d10});
BUF_57fc10a56d10[buf_idx_57fc10a56d10 * 1 + 0] = tid;
}
__global__ void count_57fc10a64300(uint64_t* COUNT57fc10a51c00, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT57fc10a51c00, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_57fc10a64300(uint64_t* BUF_57fc10a51c00, uint64_t* BUF_IDX_57fc10a51c00, HASHTABLE_INSERT HT_57fc10a51c00, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_57fc10a51c00 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_57fc10a51c00 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_57fc10a51c00 = atomicAdd((int*)BUF_IDX_57fc10a51c00, 1);
HT_57fc10a51c00.insert(cuco::pair{KEY_57fc10a51c00, buf_idx_57fc10a51c00});
BUF_57fc10a51c00[buf_idx_57fc10a51c00 * 1 + 0] = tid;
}
__global__ void count_57fc10a3a5e0(uint64_t* COUNT57fc10a59000, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT57fc10a59000, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_57fc10a3a5e0(uint64_t* BUF_57fc10a59000, uint64_t* BUF_IDX_57fc10a59000, HASHTABLE_INSERT HT_57fc10a59000, DBI32Type* date__d_datekey, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_57fc10a59000 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_57fc10a59000 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_57fc10a59000 = atomicAdd((int*)BUF_IDX_57fc10a59000, 1);
HT_57fc10a59000.insert(cuco::pair{KEY_57fc10a59000, buf_idx_57fc10a59000});
BUF_57fc10a59000[buf_idx_57fc10a59000 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_57fc10a3a010(uint64_t* BUF_57fc10a51c00, uint64_t* BUF_57fc10a56d10, uint64_t* BUF_57fc10a59000, HASHTABLE_INSERT HT_57fc10a0b2c0, HASHTABLE_PROBE HT_57fc10a51c00, HASHTABLE_PROBE HT_57fc10a56d10, HASHTABLE_PROBE HT_57fc10a59000, DBI32Type* date__d_year, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_57fc10a56d10 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_57fc10a56d10 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_57fc10a56d10.for_each(KEY_57fc10a56d10, [&] __device__ (auto const SLOT_57fc10a56d10) {

auto const [slot_first57fc10a56d10, slot_second57fc10a56d10] = SLOT_57fc10a56d10;
if (!(true)) return;
uint64_t KEY_57fc10a51c00 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_57fc10a51c00 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_57fc10a51c00.for_each(KEY_57fc10a51c00, [&] __device__ (auto const SLOT_57fc10a51c00) {

auto const [slot_first57fc10a51c00, slot_second57fc10a51c00] = SLOT_57fc10a51c00;
if (!(true)) return;
uint64_t KEY_57fc10a59000 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_57fc10a59000 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_57fc10a59000.for_each(KEY_57fc10a59000, [&] __device__ (auto const SLOT_57fc10a59000) {

auto const [slot_first57fc10a59000, slot_second57fc10a59000] = SLOT_57fc10a59000;
if (!(true)) return;
uint64_t KEY_57fc10a0b2c0 = 0;
auto reg_date__d_year = date__d_year[BUF_57fc10a59000[slot_second57fc10a59000 * 1 + 0]];

KEY_57fc10a0b2c0 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_57fc10a56d10[slot_second57fc10a56d10 * 1 + 0]];
KEY_57fc10a0b2c0 <<= 16;
KEY_57fc10a0b2c0 |= reg_part__p_brand1_encoded;
//Create aggregation hash table
HT_57fc10a0b2c0.insert(cuco::pair{KEY_57fc10a0b2c0, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_57fc10a3a010(uint64_t* BUF_57fc10a51c00, uint64_t* BUF_57fc10a56d10, uint64_t* BUF_57fc10a59000, HASHTABLE_FIND HT_57fc10a0b2c0, HASHTABLE_PROBE HT_57fc10a51c00, HASHTABLE_PROBE HT_57fc10a56d10, HASHTABLE_PROBE HT_57fc10a59000, DBI32Type* KEY_57fc10a0b2c0date__d_year, DBI16Type* KEY_57fc10a0b2c0part__p_brand1_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_57fc10a56d10 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_57fc10a56d10 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_57fc10a56d10.for_each(KEY_57fc10a56d10, [&] __device__ (auto const SLOT_57fc10a56d10) {
auto const [slot_first57fc10a56d10, slot_second57fc10a56d10] = SLOT_57fc10a56d10;
if (!(true)) return;
uint64_t KEY_57fc10a51c00 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_57fc10a51c00 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_57fc10a51c00.for_each(KEY_57fc10a51c00, [&] __device__ (auto const SLOT_57fc10a51c00) {
auto const [slot_first57fc10a51c00, slot_second57fc10a51c00] = SLOT_57fc10a51c00;
if (!(true)) return;
uint64_t KEY_57fc10a59000 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_57fc10a59000 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_57fc10a59000.for_each(KEY_57fc10a59000, [&] __device__ (auto const SLOT_57fc10a59000) {
auto const [slot_first57fc10a59000, slot_second57fc10a59000] = SLOT_57fc10a59000;
if (!(true)) return;
uint64_t KEY_57fc10a0b2c0 = 0;
auto reg_date__d_year = date__d_year[BUF_57fc10a59000[slot_second57fc10a59000 * 1 + 0]];

KEY_57fc10a0b2c0 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_57fc10a56d10[slot_second57fc10a56d10 * 1 + 0]];
KEY_57fc10a0b2c0 <<= 16;
KEY_57fc10a0b2c0 |= reg_part__p_brand1_encoded;
//Aggregate in hashtable
auto buf_idx_57fc10a0b2c0 = HT_57fc10a0b2c0.find(KEY_57fc10a0b2c0)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_57fc10a0b2c0], reg_lineorder__lo_revenue);
KEY_57fc10a0b2c0date__d_year[buf_idx_57fc10a0b2c0] = reg_date__d_year;
KEY_57fc10a0b2c0part__p_brand1_encoded[buf_idx_57fc10a0b2c0] = reg_part__p_brand1_encoded;
});
});
});
}
__global__ void count_57fc10a73600(size_t COUNT57fc10a0b2c0, uint64_t* COUNT57fc10a1e470) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT57fc10a0b2c0) return;
//Materialize count
atomicAdd((int*)COUNT57fc10a1e470, 1);
}
__global__ void main_57fc10a73600(size_t COUNT57fc10a0b2c0, DBDecimalType* MAT57fc10a1e470aggr0__tmp_attr0, DBI32Type* MAT57fc10a1e470date__d_year, DBI16Type* MAT57fc10a1e470part__p_brand1_encoded, uint64_t* MAT_IDX57fc10a1e470, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT57fc10a0b2c0) return;
//Materialize buffers
auto mat_idx57fc10a1e470 = atomicAdd((int*)MAT_IDX57fc10a1e470, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT57fc10a1e470aggr0__tmp_attr0[mat_idx57fc10a1e470] = reg_aggr0__tmp_attr0;
auto reg_date__d_year = date__d_year[tid];
MAT57fc10a1e470date__d_year[mat_idx57fc10a1e470] = reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[tid];
MAT57fc10a1e470part__p_brand1_encoded[mat_idx57fc10a1e470] = reg_part__p_brand1_encoded;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT57fc10a56d10;
cudaMalloc(&d_COUNT57fc10a56d10, sizeof(uint64_t));
cudaMemset(d_COUNT57fc10a56d10, 0, sizeof(uint64_t));
count_57fc10a61860<<<std::ceil((float)part_size/32.), 32>>>(d_COUNT57fc10a56d10, d_part__p_category, part_size);
uint64_t COUNT57fc10a56d10;
cudaMemcpy(&COUNT57fc10a56d10, d_COUNT57fc10a56d10, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_57fc10a56d10;
cudaMalloc(&d_BUF_IDX_57fc10a56d10, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_57fc10a56d10, 0, sizeof(uint64_t));
uint64_t* d_BUF_57fc10a56d10;
cudaMalloc(&d_BUF_57fc10a56d10, sizeof(uint64_t) * COUNT57fc10a56d10 * 1);
auto d_HT_57fc10a56d10 = cuco::experimental::static_multimap{ (int)COUNT57fc10a56d10*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_57fc10a61860<<<std::ceil((float)part_size/32.), 32>>>(d_BUF_57fc10a56d10, d_BUF_IDX_57fc10a56d10, d_HT_57fc10a56d10.ref(cuco::insert), d_part__p_category, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT57fc10a51c00;
cudaMalloc(&d_COUNT57fc10a51c00, sizeof(uint64_t));
cudaMemset(d_COUNT57fc10a51c00, 0, sizeof(uint64_t));
count_57fc10a64300<<<std::ceil((float)supplier_size/32.), 32>>>(d_COUNT57fc10a51c00, d_supplier__s_region, supplier_size);
uint64_t COUNT57fc10a51c00;
cudaMemcpy(&COUNT57fc10a51c00, d_COUNT57fc10a51c00, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_57fc10a51c00;
cudaMalloc(&d_BUF_IDX_57fc10a51c00, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_57fc10a51c00, 0, sizeof(uint64_t));
uint64_t* d_BUF_57fc10a51c00;
cudaMalloc(&d_BUF_57fc10a51c00, sizeof(uint64_t) * COUNT57fc10a51c00 * 1);
auto d_HT_57fc10a51c00 = cuco::experimental::static_multimap{ (int)COUNT57fc10a51c00*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_57fc10a64300<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_57fc10a51c00, d_BUF_IDX_57fc10a51c00, d_HT_57fc10a51c00.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT57fc10a59000;
cudaMalloc(&d_COUNT57fc10a59000, sizeof(uint64_t));
cudaMemset(d_COUNT57fc10a59000, 0, sizeof(uint64_t));
count_57fc10a3a5e0<<<std::ceil((float)date_size/32.), 32>>>(d_COUNT57fc10a59000, date_size);
uint64_t COUNT57fc10a59000;
cudaMemcpy(&COUNT57fc10a59000, d_COUNT57fc10a59000, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_57fc10a59000;
cudaMalloc(&d_BUF_IDX_57fc10a59000, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_57fc10a59000, 0, sizeof(uint64_t));
uint64_t* d_BUF_57fc10a59000;
cudaMalloc(&d_BUF_57fc10a59000, sizeof(uint64_t) * COUNT57fc10a59000 * 1);
auto d_HT_57fc10a59000 = cuco::experimental::static_multimap{ (int)COUNT57fc10a59000*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_57fc10a3a5e0<<<std::ceil((float)date_size/32.), 32>>>(d_BUF_57fc10a59000, d_BUF_IDX_57fc10a59000, d_HT_57fc10a59000.ref(cuco::insert), d_date__d_datekey, date_size);
//Create aggregation hash table
auto d_HT_57fc10a0b2c0 = cuco::static_map{ (int)52974*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_57fc10a3a010<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_57fc10a51c00, d_BUF_57fc10a56d10, d_BUF_57fc10a59000, d_HT_57fc10a0b2c0.ref(cuco::insert), d_HT_57fc10a51c00.ref(cuco::for_each), d_HT_57fc10a56d10.ref(cuco::for_each), d_HT_57fc10a59000.ref(cuco::for_each), d_date__d_year, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size, d_part__p_brand1_encoded);
size_t COUNT57fc10a0b2c0 = d_HT_57fc10a0b2c0.size();
thrust::device_vector<int64_t> keys_57fc10a0b2c0(COUNT57fc10a0b2c0), vals_57fc10a0b2c0(COUNT57fc10a0b2c0);
d_HT_57fc10a0b2c0.retrieve_all(keys_57fc10a0b2c0.begin(), vals_57fc10a0b2c0.begin());
d_HT_57fc10a0b2c0.clear();
int64_t* raw_keys57fc10a0b2c0 = thrust::raw_pointer_cast(keys_57fc10a0b2c0.data());
insertKeys<<<std::ceil((float)COUNT57fc10a0b2c0/32.), 32>>>(raw_keys57fc10a0b2c0, d_HT_57fc10a0b2c0.ref(cuco::insert), COUNT57fc10a0b2c0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT57fc10a0b2c0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT57fc10a0b2c0);
DBI32Type* d_KEY_57fc10a0b2c0date__d_year;
cudaMalloc(&d_KEY_57fc10a0b2c0date__d_year, sizeof(DBI32Type) * COUNT57fc10a0b2c0);
cudaMemset(d_KEY_57fc10a0b2c0date__d_year, 0, sizeof(DBI32Type) * COUNT57fc10a0b2c0);
DBI16Type* d_KEY_57fc10a0b2c0part__p_brand1_encoded;
cudaMalloc(&d_KEY_57fc10a0b2c0part__p_brand1_encoded, sizeof(DBI16Type) * COUNT57fc10a0b2c0);
cudaMemset(d_KEY_57fc10a0b2c0part__p_brand1_encoded, 0, sizeof(DBI16Type) * COUNT57fc10a0b2c0);
main_57fc10a3a010<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_57fc10a51c00, d_BUF_57fc10a56d10, d_BUF_57fc10a59000, d_HT_57fc10a0b2c0.ref(cuco::find), d_HT_57fc10a51c00.ref(cuco::for_each), d_HT_57fc10a56d10.ref(cuco::for_each), d_HT_57fc10a59000.ref(cuco::for_each), d_KEY_57fc10a0b2c0date__d_year, d_KEY_57fc10a0b2c0part__p_brand1_encoded, d_aggr0__tmp_attr0, d_date__d_year, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_part__p_brand1_encoded);
//Materialize count
uint64_t* d_COUNT57fc10a1e470;
cudaMalloc(&d_COUNT57fc10a1e470, sizeof(uint64_t));
cudaMemset(d_COUNT57fc10a1e470, 0, sizeof(uint64_t));
count_57fc10a73600<<<std::ceil((float)COUNT57fc10a0b2c0/32.), 32>>>(COUNT57fc10a0b2c0, d_COUNT57fc10a1e470);
uint64_t COUNT57fc10a1e470;
cudaMemcpy(&COUNT57fc10a1e470, d_COUNT57fc10a1e470, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX57fc10a1e470;
cudaMalloc(&d_MAT_IDX57fc10a1e470, sizeof(uint64_t));
cudaMemset(d_MAT_IDX57fc10a1e470, 0, sizeof(uint64_t));
auto MAT57fc10a1e470aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT57fc10a1e470);
DBDecimalType* d_MAT57fc10a1e470aggr0__tmp_attr0;
cudaMalloc(&d_MAT57fc10a1e470aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT57fc10a1e470);
auto MAT57fc10a1e470date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT57fc10a1e470);
DBI32Type* d_MAT57fc10a1e470date__d_year;
cudaMalloc(&d_MAT57fc10a1e470date__d_year, sizeof(DBI32Type) * COUNT57fc10a1e470);
auto MAT57fc10a1e470part__p_brand1_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT57fc10a1e470);
DBI16Type* d_MAT57fc10a1e470part__p_brand1_encoded;
cudaMalloc(&d_MAT57fc10a1e470part__p_brand1_encoded, sizeof(DBI16Type) * COUNT57fc10a1e470);
main_57fc10a73600<<<std::ceil((float)COUNT57fc10a0b2c0/32.), 32>>>(COUNT57fc10a0b2c0, d_MAT57fc10a1e470aggr0__tmp_attr0, d_MAT57fc10a1e470date__d_year, d_MAT57fc10a1e470part__p_brand1_encoded, d_MAT_IDX57fc10a1e470, d_aggr0__tmp_attr0, d_KEY_57fc10a0b2c0date__d_year, d_KEY_57fc10a0b2c0part__p_brand1_encoded);
cudaMemcpy(MAT57fc10a1e470aggr0__tmp_attr0, d_MAT57fc10a1e470aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT57fc10a1e470, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT57fc10a1e470date__d_year, d_MAT57fc10a1e470date__d_year, sizeof(DBI32Type) * COUNT57fc10a1e470, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT57fc10a1e470part__p_brand1_encoded, d_MAT57fc10a1e470part__p_brand1_encoded, sizeof(DBI16Type) * COUNT57fc10a1e470, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT57fc10a1e470; i++) { std::cout << MAT57fc10a1e470aggr0__tmp_attr0[i] << "\t";
std::cout << MAT57fc10a1e470date__d_year[i] << "\t";
std::cout << part__p_brand1_map[MAT57fc10a1e470part__p_brand1_encoded[i]] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_57fc10a56d10);
cudaFree(d_BUF_IDX_57fc10a56d10);
cudaFree(d_COUNT57fc10a56d10);
cudaFree(d_BUF_57fc10a51c00);
cudaFree(d_BUF_IDX_57fc10a51c00);
cudaFree(d_COUNT57fc10a51c00);
cudaFree(d_BUF_57fc10a59000);
cudaFree(d_BUF_IDX_57fc10a59000);
cudaFree(d_COUNT57fc10a59000);
cudaFree(d_KEY_57fc10a0b2c0date__d_year);
cudaFree(d_KEY_57fc10a0b2c0part__p_brand1_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT57fc10a1e470);
cudaFree(d_MAT57fc10a1e470aggr0__tmp_attr0);
cudaFree(d_MAT57fc10a1e470date__d_year);
cudaFree(d_MAT57fc10a1e470part__p_brand1_encoded);
cudaFree(d_MAT_IDX57fc10a1e470);
free(MAT57fc10a1e470aggr0__tmp_attr0);
free(MAT57fc10a1e470date__d_year);
free(MAT57fc10a1e470part__p_brand1_encoded);
}