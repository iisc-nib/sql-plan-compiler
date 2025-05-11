#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_1(uint64_t* COUNT0, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT HT_0, DBI32Type* customer__c_custkey, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
auto reg_customer__c_custkey = customer__c_custkey[tid];
if (!(evaluatePredicate(reg_customer__c_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_0 = 0;

KEY_0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_0 = atomicAdd((int*)BUF_IDX_0, 1);
HT_0.insert(cuco::pair{KEY_0, buf_idx_0});
BUF_0[buf_idx_0 * 1 + 0] = tid;
}
__global__ void count_3(uint64_t* COUNT2, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT2, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_3(uint64_t* BUF_2, uint64_t* BUF_IDX_2, HASHTABLE_INSERT HT_2, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_2 = 0;

KEY_2 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_2 = atomicAdd((int*)BUF_IDX_2, 1);
HT_2.insert(cuco::pair{KEY_2, buf_idx_2});
BUF_2[buf_idx_2 * 1 + 0] = tid;
}
__global__ void count_5(uint64_t* COUNT4, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT4, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5(uint64_t* BUF_4, uint64_t* BUF_IDX_4, HASHTABLE_INSERT HT_4, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
auto reg_date__d_datekey = date__d_datekey[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_4 = 0;

KEY_4 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_4 = atomicAdd((int*)BUF_IDX_4, 1);
HT_4.insert(cuco::pair{KEY_4, buf_idx_4});
BUF_4[buf_idx_4 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void count_7(uint64_t* BUF_0, uint64_t* BUF_2, uint64_t* BUF_4, HASHTABLE_PROBE HT_0, HASHTABLE_PROBE HT_2, HASHTABLE_PROBE HT_4, HASHTABLE_INSERT HT_6, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_0 = 0;

KEY_0 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_0.for_each(KEY_0, [&] __device__ (auto const SLOT_0) {

auto const [slot_first0, slot_second0] = SLOT_0;
if (!(true)) return;
uint64_t KEY_2 = 0;

KEY_2 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_2.for_each(KEY_2, [&] __device__ (auto const SLOT_2) {

auto const [slot_first2, slot_second2] = SLOT_2;
if (!(true)) return;
uint64_t KEY_4 = 0;

KEY_4 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_4.for_each(KEY_4, [&] __device__ (auto const SLOT_4) {

auto const [slot_first4, slot_second4] = SLOT_4;
if (!(true)) return;
uint64_t KEY_6 = 0;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_0[slot_second0 * 1 + 0]];

KEY_6 |= reg_customer__c_nation_encoded;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_2[slot_second2 * 1 + 0]];
KEY_6 <<= 16;
KEY_6 |= reg_supplier__s_nation_encoded;
auto reg_date__d_year = date__d_year[BUF_4[slot_second4 * 1 + 0]];
KEY_6 <<= 32;
KEY_6 |= reg_date__d_year;
//Create aggregation hash table
HT_6.insert(cuco::pair{KEY_6, 1});
});
});
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_7(uint64_t* BUF_0, uint64_t* BUF_2, uint64_t* BUF_4, HASHTABLE_PROBE HT_0, HASHTABLE_PROBE HT_2, HASHTABLE_PROBE HT_4, HASHTABLE_FIND HT_6, DBI16Type* KEY_6customer__c_nation_encoded, DBI32Type* KEY_6date__d_year, DBI16Type* KEY_6supplier__s_nation_encoded, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_0 = 0;

KEY_0 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_0.for_each(KEY_0, [&] __device__ (auto const SLOT_0) {
auto const [slot_first0, slot_second0] = SLOT_0;
if (!(true)) return;
uint64_t KEY_2 = 0;

KEY_2 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_2.for_each(KEY_2, [&] __device__ (auto const SLOT_2) {
auto const [slot_first2, slot_second2] = SLOT_2;
if (!(true)) return;
uint64_t KEY_4 = 0;

KEY_4 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_4.for_each(KEY_4, [&] __device__ (auto const SLOT_4) {
auto const [slot_first4, slot_second4] = SLOT_4;
if (!(true)) return;
uint64_t KEY_6 = 0;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_0[slot_second0 * 1 + 0]];

KEY_6 |= reg_customer__c_nation_encoded;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_2[slot_second2 * 1 + 0]];
KEY_6 <<= 16;
KEY_6 |= reg_supplier__s_nation_encoded;
auto reg_date__d_year = date__d_year[BUF_4[slot_second4 * 1 + 0]];
KEY_6 <<= 32;
KEY_6 |= reg_date__d_year;
//Aggregate in hashtable
auto buf_idx_6 = HT_6.find(KEY_6)->second;
aggregate_sum(&aggr0__tmp_attr0[buf_idx_6], reg_lineorder__lo_revenue);
KEY_6customer__c_nation_encoded[buf_idx_6] = reg_customer__c_nation_encoded;
KEY_6supplier__s_nation_encoded[buf_idx_6] = reg_supplier__s_nation_encoded;
KEY_6date__d_year[buf_idx_6] = reg_date__d_year;
});
});
});
}
__global__ void count_9(size_t COUNT6, uint64_t* COUNT8) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT6) return;
//Materialize count
atomicAdd((int*)COUNT8, 1);
}
__global__ void main_9(size_t COUNT6, DBDecimalType* MAT8aggr0__tmp_attr0, DBI16Type* MAT8customer__c_nation_encoded, DBI32Type* MAT8date__d_year, DBI16Type* MAT8supplier__s_nation_encoded, uint64_t* MAT_IDX8, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT6) return;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[tid];
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[tid];
auto reg_date__d_year = date__d_year[tid];
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
//Materialize buffers
auto mat_idx8 = atomicAdd((int*)MAT_IDX8, 1);
MAT8customer__c_nation_encoded[mat_idx8] = reg_customer__c_nation_encoded;
MAT8supplier__s_nation_encoded[mat_idx8] = reg_supplier__s_nation_encoded;
MAT8date__d_year[mat_idx8] = reg_date__d_year;
MAT8aggr0__tmp_attr0[mat_idx8] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT0;
cudaMalloc(&d_COUNT0, sizeof(uint64_t));
cudaMemset(d_COUNT0, 0, sizeof(uint64_t));
count_1<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT0, d_customer__c_region, customer_size);
uint64_t COUNT0;
cudaMemcpy(&COUNT0, d_COUNT0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_0;
cudaMalloc(&d_BUF_IDX_0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_0, 0, sizeof(uint64_t));
uint64_t* d_BUF_0;
cudaMalloc(&d_BUF_0, sizeof(uint64_t) * COUNT0 * 1);
auto d_HT_0 = cuco::experimental::static_multimap{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_customer__c_custkey, d_customer__c_region, customer_size);
//Materialize count
uint64_t* d_COUNT2;
cudaMalloc(&d_COUNT2, sizeof(uint64_t));
cudaMemset(d_COUNT2, 0, sizeof(uint64_t));
count_3<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT2, d_supplier__s_region, supplier_size);
uint64_t COUNT2;
cudaMemcpy(&COUNT2, d_COUNT2, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_2;
cudaMalloc(&d_BUF_IDX_2, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_2, 0, sizeof(uint64_t));
uint64_t* d_BUF_2;
cudaMalloc(&d_BUF_2, sizeof(uint64_t) * COUNT2 * 1);
auto d_HT_2 = cuco::experimental::static_multimap{ (int)COUNT2*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_2, d_BUF_IDX_2, d_HT_2.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT4;
cudaMalloc(&d_COUNT4, sizeof(uint64_t));
cudaMemset(d_COUNT4, 0, sizeof(uint64_t));
count_5<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT4, d_date__d_year, date_size);
uint64_t COUNT4;
cudaMemcpy(&COUNT4, d_COUNT4, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_4;
cudaMalloc(&d_BUF_IDX_4, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_4, 0, sizeof(uint64_t));
uint64_t* d_BUF_4;
cudaMalloc(&d_BUF_4, sizeof(uint64_t) * COUNT4 * 1);
auto d_HT_4 = cuco::experimental::static_multimap{ (int)COUNT4*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_4, d_BUF_IDX_4, d_HT_4.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Create aggregation hash table
auto d_HT_6 = cuco::static_map{ (int)149182*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_7<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_0, d_BUF_2, d_BUF_4, d_HT_0.ref(cuco::for_each), d_HT_2.ref(cuco::for_each), d_HT_4.ref(cuco::for_each), d_HT_6.ref(cuco::insert), d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_nation_encoded);
size_t COUNT6 = d_HT_6.size();
thrust::device_vector<int64_t> keys_6(COUNT6), vals_6(COUNT6);
d_HT_6.retrieve_all(keys_6.begin(), vals_6.begin());
d_HT_6.clear();
int64_t* raw_keys6 = thrust::raw_pointer_cast(keys_6.data());
insertKeys<<<std::ceil((float)COUNT6/128.), 128>>>(raw_keys6, d_HT_6.ref(cuco::insert), COUNT6);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT6);
DBI16Type* d_KEY_6customer__c_nation_encoded;
cudaMalloc(&d_KEY_6customer__c_nation_encoded, sizeof(DBI16Type) * COUNT6);
cudaMemset(d_KEY_6customer__c_nation_encoded, 0, sizeof(DBI16Type) * COUNT6);
DBI16Type* d_KEY_6supplier__s_nation_encoded;
cudaMalloc(&d_KEY_6supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT6);
cudaMemset(d_KEY_6supplier__s_nation_encoded, 0, sizeof(DBI16Type) * COUNT6);
DBI32Type* d_KEY_6date__d_year;
cudaMalloc(&d_KEY_6date__d_year, sizeof(DBI32Type) * COUNT6);
cudaMemset(d_KEY_6date__d_year, 0, sizeof(DBI32Type) * COUNT6);
main_7<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_0, d_BUF_2, d_BUF_4, d_HT_0.ref(cuco::for_each), d_HT_2.ref(cuco::for_each), d_HT_4.ref(cuco::for_each), d_HT_6.ref(cuco::find), d_KEY_6customer__c_nation_encoded, d_KEY_6date__d_year, d_KEY_6supplier__s_nation_encoded, d_aggr0__tmp_attr0, d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_nation_encoded);
//Materialize count
uint64_t* d_COUNT8;
cudaMalloc(&d_COUNT8, sizeof(uint64_t));
cudaMemset(d_COUNT8, 0, sizeof(uint64_t));
count_9<<<std::ceil((float)COUNT6/128.), 128>>>(COUNT6, d_COUNT8);
uint64_t COUNT8;
cudaMemcpy(&COUNT8, d_COUNT8, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX8;
cudaMalloc(&d_MAT_IDX8, sizeof(uint64_t));
cudaMemset(d_MAT_IDX8, 0, sizeof(uint64_t));
auto MAT8customer__c_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT8);
DBI16Type* d_MAT8customer__c_nation_encoded;
cudaMalloc(&d_MAT8customer__c_nation_encoded, sizeof(DBI16Type) * COUNT8);
auto MAT8supplier__s_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT8);
DBI16Type* d_MAT8supplier__s_nation_encoded;
cudaMalloc(&d_MAT8supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT8);
auto MAT8date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT8);
DBI32Type* d_MAT8date__d_year;
cudaMalloc(&d_MAT8date__d_year, sizeof(DBI32Type) * COUNT8);
auto MAT8aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT8);
DBDecimalType* d_MAT8aggr0__tmp_attr0;
cudaMalloc(&d_MAT8aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT8);
main_9<<<std::ceil((float)COUNT6/128.), 128>>>(COUNT6, d_MAT8aggr0__tmp_attr0, d_MAT8customer__c_nation_encoded, d_MAT8date__d_year, d_MAT8supplier__s_nation_encoded, d_MAT_IDX8, d_aggr0__tmp_attr0, d_KEY_6customer__c_nation_encoded, d_KEY_6date__d_year, d_KEY_6supplier__s_nation_encoded);
cudaMemcpy(MAT8customer__c_nation_encoded, d_MAT8customer__c_nation_encoded, sizeof(DBI16Type) * COUNT8, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT8supplier__s_nation_encoded, d_MAT8supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT8, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT8date__d_year, d_MAT8date__d_year, sizeof(DBI32Type) * COUNT8, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT8aggr0__tmp_attr0, d_MAT8aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT8, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT8; i++) { std::cout << "" << customer__c_nation_map[MAT8customer__c_nation_encoded[i]];
std::cout << "," << supplier__s_nation_map[MAT8supplier__s_nation_encoded[i]];
std::cout << "," << MAT8date__d_year[i];
std::cout << "," << MAT8aggr0__tmp_attr0[i];
std::cout << std::endl; }
cudaFree(d_BUF_0);
cudaFree(d_BUF_IDX_0);
cudaFree(d_COUNT0);
cudaFree(d_BUF_2);
cudaFree(d_BUF_IDX_2);
cudaFree(d_COUNT2);
cudaFree(d_BUF_4);
cudaFree(d_BUF_IDX_4);
cudaFree(d_COUNT4);
cudaFree(d_KEY_6customer__c_nation_encoded);
cudaFree(d_KEY_6date__d_year);
cudaFree(d_KEY_6supplier__s_nation_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT8);
cudaFree(d_MAT8aggr0__tmp_attr0);
cudaFree(d_MAT8customer__c_nation_encoded);
cudaFree(d_MAT8date__d_year);
cudaFree(d_MAT8supplier__s_nation_encoded);
cudaFree(d_MAT_IDX8);
free(MAT8aggr0__tmp_attr0);
free(MAT8customer__c_nation_encoded);
free(MAT8date__d_year);
free(MAT8supplier__s_nation_encoded);
}