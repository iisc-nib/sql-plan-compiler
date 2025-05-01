#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_640cd395fd00(uint64_t* COUNT640cd397dca0, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT640cd397dca0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_640cd395fd00(uint64_t* BUF_640cd397dca0, uint64_t* BUF_IDX_640cd397dca0, HASHTABLE_INSERT HT_640cd397dca0, DBI32Type* customer__c_custkey, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_640cd397dca0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_640cd397dca0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_640cd397dca0 = atomicAdd((int*)BUF_IDX_640cd397dca0, 1);
HT_640cd397dca0.insert(cuco::pair{KEY_640cd397dca0, buf_idx_640cd397dca0});
BUF_640cd397dca0[buf_idx_640cd397dca0 * 1 + 0] = tid;
}
__global__ void count_640cd3987040(uint64_t* COUNT640cd397c040, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT640cd397c040, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_640cd3987040(uint64_t* BUF_640cd397c040, uint64_t* BUF_IDX_640cd397c040, HASHTABLE_INSERT HT_640cd397c040, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_640cd397c040 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_640cd397c040 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_640cd397c040 = atomicAdd((int*)BUF_IDX_640cd397c040, 1);
HT_640cd397c040.insert(cuco::pair{KEY_640cd397c040, buf_idx_640cd397c040});
BUF_640cd397c040[buf_idx_640cd397c040 * 1 + 0] = tid;
}
__global__ void count_640cd398ceb0(uint64_t* COUNT640cd3980060, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT640cd3980060, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_640cd398ceb0(uint64_t* BUF_640cd3980060, uint64_t* BUF_IDX_640cd3980060, HASHTABLE_INSERT HT_640cd3980060, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_640cd3980060 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_640cd3980060 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_640cd3980060 = atomicAdd((int*)BUF_IDX_640cd3980060, 1);
HT_640cd3980060.insert(cuco::pair{KEY_640cd3980060, buf_idx_640cd3980060});
BUF_640cd3980060[buf_idx_640cd3980060 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_640cd39602a0(uint64_t* BUF_640cd397c040, uint64_t* BUF_640cd397dca0, uint64_t* BUF_640cd3980060, HASHTABLE_INSERT HT_640cd392f980, HASHTABLE_PROBE HT_640cd397c040, HASHTABLE_PROBE HT_640cd397dca0, HASHTABLE_PROBE HT_640cd3980060, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_640cd397dca0 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_640cd397dca0 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_640cd397dca0.for_each(KEY_640cd397dca0, [&] __device__ (auto const SLOT_640cd397dca0) {

auto const [slot_first640cd397dca0, slot_second640cd397dca0] = SLOT_640cd397dca0;
if (!(true)) return;
uint64_t KEY_640cd397c040 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_640cd397c040 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_640cd397c040.for_each(KEY_640cd397c040, [&] __device__ (auto const SLOT_640cd397c040) {

auto const [slot_first640cd397c040, slot_second640cd397c040] = SLOT_640cd397c040;
if (!(true)) return;
uint64_t KEY_640cd3980060 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_640cd3980060 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_640cd3980060.for_each(KEY_640cd3980060, [&] __device__ (auto const SLOT_640cd3980060) {

auto const [slot_first640cd3980060, slot_second640cd3980060] = SLOT_640cd3980060;
if (!(true)) return;
uint64_t KEY_640cd392f980 = 0;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_640cd397dca0[slot_second640cd397dca0 * 1 + 0]];

KEY_640cd392f980 |= reg_customer__c_nation_encoded;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_640cd397c040[slot_second640cd397c040 * 1 + 0]];
KEY_640cd392f980 <<= 16;
KEY_640cd392f980 |= reg_supplier__s_nation_encoded;
auto reg_date__d_year = date__d_year[BUF_640cd3980060[slot_second640cd3980060 * 1 + 0]];
KEY_640cd392f980 <<= 32;
KEY_640cd392f980 |= reg_date__d_year;
//Create aggregation hash table
HT_640cd392f980.insert(cuco::pair{KEY_640cd392f980, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_640cd39602a0(uint64_t* BUF_640cd397c040, uint64_t* BUF_640cd397dca0, uint64_t* BUF_640cd3980060, HASHTABLE_FIND HT_640cd392f980, HASHTABLE_PROBE HT_640cd397c040, HASHTABLE_PROBE HT_640cd397dca0, HASHTABLE_PROBE HT_640cd3980060, DBI16Type* KEY_640cd392f980customer__c_nation_encoded, DBI32Type* KEY_640cd392f980date__d_year, DBI16Type* KEY_640cd392f980supplier__s_nation_encoded, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_640cd397dca0 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_640cd397dca0 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_640cd397dca0.for_each(KEY_640cd397dca0, [&] __device__ (auto const SLOT_640cd397dca0) {
auto const [slot_first640cd397dca0, slot_second640cd397dca0] = SLOT_640cd397dca0;
if (!(true)) return;
uint64_t KEY_640cd397c040 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_640cd397c040 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_640cd397c040.for_each(KEY_640cd397c040, [&] __device__ (auto const SLOT_640cd397c040) {
auto const [slot_first640cd397c040, slot_second640cd397c040] = SLOT_640cd397c040;
if (!(true)) return;
uint64_t KEY_640cd3980060 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_640cd3980060 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_640cd3980060.for_each(KEY_640cd3980060, [&] __device__ (auto const SLOT_640cd3980060) {
auto const [slot_first640cd3980060, slot_second640cd3980060] = SLOT_640cd3980060;
if (!(true)) return;
uint64_t KEY_640cd392f980 = 0;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_640cd397dca0[slot_second640cd397dca0 * 1 + 0]];

KEY_640cd392f980 |= reg_customer__c_nation_encoded;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_640cd397c040[slot_second640cd397c040 * 1 + 0]];
KEY_640cd392f980 <<= 16;
KEY_640cd392f980 |= reg_supplier__s_nation_encoded;
auto reg_date__d_year = date__d_year[BUF_640cd3980060[slot_second640cd3980060 * 1 + 0]];
KEY_640cd392f980 <<= 32;
KEY_640cd392f980 |= reg_date__d_year;
//Aggregate in hashtable
auto buf_idx_640cd392f980 = HT_640cd392f980.find(KEY_640cd392f980)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_640cd392f980], reg_lineorder__lo_revenue);
KEY_640cd392f980customer__c_nation_encoded[buf_idx_640cd392f980] = reg_customer__c_nation_encoded;
KEY_640cd392f980supplier__s_nation_encoded[buf_idx_640cd392f980] = reg_supplier__s_nation_encoded;
KEY_640cd392f980date__d_year[buf_idx_640cd392f980] = reg_date__d_year;
});
});
});
}
__global__ void count_640cd399a370(uint64_t* COUNT640cd390b830, size_t COUNT640cd392f980) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT640cd392f980) return;
//Materialize count
atomicAdd((int*)COUNT640cd390b830, 1);
}
__global__ void main_640cd399a370(size_t COUNT640cd392f980, DBDecimalType* MAT640cd390b830aggr0__tmp_attr0, DBI16Type* MAT640cd390b830customer__c_nation_encoded, DBI32Type* MAT640cd390b830date__d_year, DBI16Type* MAT640cd390b830supplier__s_nation_encoded, uint64_t* MAT_IDX640cd390b830, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT640cd392f980) return;
//Materialize buffers
auto mat_idx640cd390b830 = atomicAdd((int*)MAT_IDX640cd390b830, 1);
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[tid];
MAT640cd390b830customer__c_nation_encoded[mat_idx640cd390b830] = reg_customer__c_nation_encoded;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[tid];
MAT640cd390b830supplier__s_nation_encoded[mat_idx640cd390b830] = reg_supplier__s_nation_encoded;
auto reg_date__d_year = date__d_year[tid];
MAT640cd390b830date__d_year[mat_idx640cd390b830] = reg_date__d_year;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT640cd390b830aggr0__tmp_attr0[mat_idx640cd390b830] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT640cd397dca0;
cudaMalloc(&d_COUNT640cd397dca0, sizeof(uint64_t));
cudaMemset(d_COUNT640cd397dca0, 0, sizeof(uint64_t));
count_640cd395fd00<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT640cd397dca0, d_customer__c_region, customer_size);
uint64_t COUNT640cd397dca0;
cudaMemcpy(&COUNT640cd397dca0, d_COUNT640cd397dca0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_640cd397dca0;
cudaMalloc(&d_BUF_IDX_640cd397dca0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_640cd397dca0, 0, sizeof(uint64_t));
uint64_t* d_BUF_640cd397dca0;
cudaMalloc(&d_BUF_640cd397dca0, sizeof(uint64_t) * COUNT640cd397dca0 * 1);
auto d_HT_640cd397dca0 = cuco::experimental::static_multimap{ (int)COUNT640cd397dca0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_640cd395fd00<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_640cd397dca0, d_BUF_IDX_640cd397dca0, d_HT_640cd397dca0.ref(cuco::insert), d_customer__c_custkey, d_customer__c_region, customer_size);
//Materialize count
uint64_t* d_COUNT640cd397c040;
cudaMalloc(&d_COUNT640cd397c040, sizeof(uint64_t));
cudaMemset(d_COUNT640cd397c040, 0, sizeof(uint64_t));
count_640cd3987040<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT640cd397c040, d_supplier__s_region, supplier_size);
uint64_t COUNT640cd397c040;
cudaMemcpy(&COUNT640cd397c040, d_COUNT640cd397c040, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_640cd397c040;
cudaMalloc(&d_BUF_IDX_640cd397c040, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_640cd397c040, 0, sizeof(uint64_t));
uint64_t* d_BUF_640cd397c040;
cudaMalloc(&d_BUF_640cd397c040, sizeof(uint64_t) * COUNT640cd397c040 * 1);
auto d_HT_640cd397c040 = cuco::experimental::static_multimap{ (int)COUNT640cd397c040*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_640cd3987040<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_640cd397c040, d_BUF_IDX_640cd397c040, d_HT_640cd397c040.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT640cd3980060;
cudaMalloc(&d_COUNT640cd3980060, sizeof(uint64_t));
cudaMemset(d_COUNT640cd3980060, 0, sizeof(uint64_t));
count_640cd398ceb0<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT640cd3980060, d_date__d_year, date_size);
uint64_t COUNT640cd3980060;
cudaMemcpy(&COUNT640cd3980060, d_COUNT640cd3980060, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_640cd3980060;
cudaMalloc(&d_BUF_IDX_640cd3980060, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_640cd3980060, 0, sizeof(uint64_t));
uint64_t* d_BUF_640cd3980060;
cudaMalloc(&d_BUF_640cd3980060, sizeof(uint64_t) * COUNT640cd3980060 * 1);
auto d_HT_640cd3980060 = cuco::experimental::static_multimap{ (int)COUNT640cd3980060*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_640cd398ceb0<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_640cd3980060, d_BUF_IDX_640cd3980060, d_HT_640cd3980060.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Create aggregation hash table
auto d_HT_640cd392f980 = cuco::static_map{ (int)144285*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_640cd39602a0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_640cd397c040, d_BUF_640cd397dca0, d_BUF_640cd3980060, d_HT_640cd392f980.ref(cuco::insert), d_HT_640cd397c040.ref(cuco::for_each), d_HT_640cd397dca0.ref(cuco::for_each), d_HT_640cd3980060.ref(cuco::for_each), d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_nation_encoded);
size_t COUNT640cd392f980 = d_HT_640cd392f980.size();
thrust::device_vector<int64_t> keys_640cd392f980(COUNT640cd392f980), vals_640cd392f980(COUNT640cd392f980);
d_HT_640cd392f980.retrieve_all(keys_640cd392f980.begin(), vals_640cd392f980.begin());
d_HT_640cd392f980.clear();
int64_t* raw_keys640cd392f980 = thrust::raw_pointer_cast(keys_640cd392f980.data());
insertKeys<<<std::ceil((float)COUNT640cd392f980/128.), 128>>>(raw_keys640cd392f980, d_HT_640cd392f980.ref(cuco::insert), COUNT640cd392f980);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT640cd392f980);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT640cd392f980);
DBI16Type* d_KEY_640cd392f980customer__c_nation_encoded;
cudaMalloc(&d_KEY_640cd392f980customer__c_nation_encoded, sizeof(DBI16Type) * COUNT640cd392f980);
cudaMemset(d_KEY_640cd392f980customer__c_nation_encoded, 0, sizeof(DBI16Type) * COUNT640cd392f980);
DBI16Type* d_KEY_640cd392f980supplier__s_nation_encoded;
cudaMalloc(&d_KEY_640cd392f980supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT640cd392f980);
cudaMemset(d_KEY_640cd392f980supplier__s_nation_encoded, 0, sizeof(DBI16Type) * COUNT640cd392f980);
DBI32Type* d_KEY_640cd392f980date__d_year;
cudaMalloc(&d_KEY_640cd392f980date__d_year, sizeof(DBI32Type) * COUNT640cd392f980);
cudaMemset(d_KEY_640cd392f980date__d_year, 0, sizeof(DBI32Type) * COUNT640cd392f980);
main_640cd39602a0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_640cd397c040, d_BUF_640cd397dca0, d_BUF_640cd3980060, d_HT_640cd392f980.ref(cuco::find), d_HT_640cd397c040.ref(cuco::for_each), d_HT_640cd397dca0.ref(cuco::for_each), d_HT_640cd3980060.ref(cuco::for_each), d_KEY_640cd392f980customer__c_nation_encoded, d_KEY_640cd392f980date__d_year, d_KEY_640cd392f980supplier__s_nation_encoded, d_aggr0__tmp_attr0, d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_nation_encoded);
//Materialize count
uint64_t* d_COUNT640cd390b830;
cudaMalloc(&d_COUNT640cd390b830, sizeof(uint64_t));
cudaMemset(d_COUNT640cd390b830, 0, sizeof(uint64_t));
count_640cd399a370<<<std::ceil((float)COUNT640cd392f980/128.), 128>>>(d_COUNT640cd390b830, COUNT640cd392f980);
uint64_t COUNT640cd390b830;
cudaMemcpy(&COUNT640cd390b830, d_COUNT640cd390b830, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX640cd390b830;
cudaMalloc(&d_MAT_IDX640cd390b830, sizeof(uint64_t));
cudaMemset(d_MAT_IDX640cd390b830, 0, sizeof(uint64_t));
auto MAT640cd390b830customer__c_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT640cd390b830);
DBI16Type* d_MAT640cd390b830customer__c_nation_encoded;
cudaMalloc(&d_MAT640cd390b830customer__c_nation_encoded, sizeof(DBI16Type) * COUNT640cd390b830);
auto MAT640cd390b830supplier__s_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT640cd390b830);
DBI16Type* d_MAT640cd390b830supplier__s_nation_encoded;
cudaMalloc(&d_MAT640cd390b830supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT640cd390b830);
auto MAT640cd390b830date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT640cd390b830);
DBI32Type* d_MAT640cd390b830date__d_year;
cudaMalloc(&d_MAT640cd390b830date__d_year, sizeof(DBI32Type) * COUNT640cd390b830);
auto MAT640cd390b830aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT640cd390b830);
DBDecimalType* d_MAT640cd390b830aggr0__tmp_attr0;
cudaMalloc(&d_MAT640cd390b830aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT640cd390b830);
main_640cd399a370<<<std::ceil((float)COUNT640cd392f980/128.), 128>>>(COUNT640cd392f980, d_MAT640cd390b830aggr0__tmp_attr0, d_MAT640cd390b830customer__c_nation_encoded, d_MAT640cd390b830date__d_year, d_MAT640cd390b830supplier__s_nation_encoded, d_MAT_IDX640cd390b830, d_aggr0__tmp_attr0, d_KEY_640cd392f980customer__c_nation_encoded, d_KEY_640cd392f980date__d_year, d_KEY_640cd392f980supplier__s_nation_encoded);
cudaMemcpy(MAT640cd390b830customer__c_nation_encoded, d_MAT640cd390b830customer__c_nation_encoded, sizeof(DBI16Type) * COUNT640cd390b830, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT640cd390b830supplier__s_nation_encoded, d_MAT640cd390b830supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT640cd390b830, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT640cd390b830date__d_year, d_MAT640cd390b830date__d_year, sizeof(DBI32Type) * COUNT640cd390b830, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT640cd390b830aggr0__tmp_attr0, d_MAT640cd390b830aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT640cd390b830, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT640cd390b830; i++) { std::cout << "" << customer__c_nation_map[MAT640cd390b830customer__c_nation_encoded[i]];
std::cout << "," << supplier__s_nation_map[MAT640cd390b830supplier__s_nation_encoded[i]];
std::cout << "," << MAT640cd390b830date__d_year[i];
std::cout << "," << MAT640cd390b830aggr0__tmp_attr0[i];
std::cout << std::endl; }
cudaFree(d_BUF_640cd397dca0);
cudaFree(d_BUF_IDX_640cd397dca0);
cudaFree(d_COUNT640cd397dca0);
cudaFree(d_BUF_640cd397c040);
cudaFree(d_BUF_IDX_640cd397c040);
cudaFree(d_COUNT640cd397c040);
cudaFree(d_BUF_640cd3980060);
cudaFree(d_BUF_IDX_640cd3980060);
cudaFree(d_COUNT640cd3980060);
cudaFree(d_KEY_640cd392f980customer__c_nation_encoded);
cudaFree(d_KEY_640cd392f980date__d_year);
cudaFree(d_KEY_640cd392f980supplier__s_nation_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT640cd390b830);
cudaFree(d_MAT640cd390b830aggr0__tmp_attr0);
cudaFree(d_MAT640cd390b830customer__c_nation_encoded);
cudaFree(d_MAT640cd390b830date__d_year);
cudaFree(d_MAT640cd390b830supplier__s_nation_encoded);
cudaFree(d_MAT_IDX640cd390b830);
free(MAT640cd390b830aggr0__tmp_attr0);
free(MAT640cd390b830customer__c_nation_encoded);
free(MAT640cd390b830date__d_year);
free(MAT640cd390b830supplier__s_nation_encoded);
}