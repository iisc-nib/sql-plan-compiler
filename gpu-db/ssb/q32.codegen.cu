#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_628a78872b00(uint64_t* COUNT628a78867080, DBStringType* supplier__s_nation, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_nation = supplier__s_nation[tid];
if (!(evaluatePredicate(reg_supplier__s_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT628a78867080, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_628a78872b00(uint64_t* BUF_628a78867080, uint64_t* BUF_IDX_628a78867080, HASHTABLE_INSERT HT_628a78867080, DBStringType* supplier__s_nation, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_nation = supplier__s_nation[tid];
if (!(evaluatePredicate(reg_supplier__s_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_628a78867080 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_628a78867080 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_628a78867080 = atomicAdd((int*)BUF_IDX_628a78867080, 1);
HT_628a78867080.insert(cuco::pair{KEY_628a78867080, buf_idx_628a78867080});
BUF_628a78867080[buf_idx_628a78867080 * 1 + 0] = tid;
}
__global__ void count_628a7884a9c0(uint64_t* COUNT628a788691f0, DBStringType* customer__c_nation, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_nation = customer__c_nation[tid];
if (!(evaluatePredicate(reg_customer__c_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT628a788691f0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_628a7884a9c0(uint64_t* BUF_628a788691f0, uint64_t* BUF_IDX_628a788691f0, HASHTABLE_INSERT HT_628a788691f0, DBI32Type* customer__c_custkey, DBStringType* customer__c_nation, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_nation = customer__c_nation[tid];
if (!(evaluatePredicate(reg_customer__c_nation, "UNITED STATES", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_628a788691f0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_628a788691f0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_628a788691f0 = atomicAdd((int*)BUF_IDX_628a788691f0, 1);
HT_628a788691f0.insert(cuco::pair{KEY_628a788691f0, buf_idx_628a788691f0});
BUF_628a788691f0[buf_idx_628a788691f0 * 1 + 0] = tid;
}
__global__ void count_628a7887b9f0(uint64_t* COUNT628a78866990, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT628a78866990, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_628a7887b9f0(uint64_t* BUF_628a78866990, uint64_t* BUF_IDX_628a78866990, HASHTABLE_INSERT HT_628a78866990, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_628a78866990 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_628a78866990 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_628a78866990 = atomicAdd((int*)BUF_IDX_628a78866990, 1);
HT_628a78866990.insert(cuco::pair{KEY_628a78866990, buf_idx_628a78866990});
BUF_628a78866990[buf_idx_628a78866990 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_628a7884af60(uint64_t* BUF_628a78866990, uint64_t* BUF_628a78867080, uint64_t* BUF_628a788691f0, HASHTABLE_INSERT HT_628a7881a2f0, HASHTABLE_PROBE HT_628a78866990, HASHTABLE_PROBE HT_628a78867080, HASHTABLE_PROBE HT_628a788691f0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_628a78867080 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_628a78867080 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_628a78867080.for_each(KEY_628a78867080, [&] __device__ (auto const SLOT_628a78867080) {

auto const [slot_first628a78867080, slot_second628a78867080] = SLOT_628a78867080;
if (!(true)) return;
uint64_t KEY_628a788691f0 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_628a788691f0 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_628a788691f0.for_each(KEY_628a788691f0, [&] __device__ (auto const SLOT_628a788691f0) {

auto const [slot_first628a788691f0, slot_second628a788691f0] = SLOT_628a788691f0;
if (!(true)) return;
uint64_t KEY_628a78866990 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_628a78866990 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_628a78866990.for_each(KEY_628a78866990, [&] __device__ (auto const SLOT_628a78866990) {

auto const [slot_first628a78866990, slot_second628a78866990] = SLOT_628a78866990;
if (!(true)) return;
uint64_t KEY_628a7881a2f0 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_628a788691f0[slot_second628a788691f0 * 1 + 0]];

KEY_628a7881a2f0 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_628a78867080[slot_second628a78867080 * 1 + 0]];
KEY_628a7881a2f0 <<= 16;
KEY_628a7881a2f0 |= reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[BUF_628a78866990[slot_second628a78866990 * 1 + 0]];
KEY_628a7881a2f0 <<= 32;
KEY_628a7881a2f0 |= reg_date__d_year;
//Create aggregation hash table
HT_628a7881a2f0.insert(cuco::pair{KEY_628a7881a2f0, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_628a7884af60(uint64_t* BUF_628a78866990, uint64_t* BUF_628a78867080, uint64_t* BUF_628a788691f0, HASHTABLE_FIND HT_628a7881a2f0, HASHTABLE_PROBE HT_628a78866990, HASHTABLE_PROBE HT_628a78867080, HASHTABLE_PROBE HT_628a788691f0, DBI16Type* KEY_628a7881a2f0customer__c_city_encoded, DBI32Type* KEY_628a7881a2f0date__d_year, DBI16Type* KEY_628a7881a2f0supplier__s_city_encoded, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_628a78867080 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_628a78867080 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_628a78867080.for_each(KEY_628a78867080, [&] __device__ (auto const SLOT_628a78867080) {
auto const [slot_first628a78867080, slot_second628a78867080] = SLOT_628a78867080;
if (!(true)) return;
uint64_t KEY_628a788691f0 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_628a788691f0 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_628a788691f0.for_each(KEY_628a788691f0, [&] __device__ (auto const SLOT_628a788691f0) {
auto const [slot_first628a788691f0, slot_second628a788691f0] = SLOT_628a788691f0;
if (!(true)) return;
uint64_t KEY_628a78866990 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_628a78866990 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_628a78866990.for_each(KEY_628a78866990, [&] __device__ (auto const SLOT_628a78866990) {
auto const [slot_first628a78866990, slot_second628a78866990] = SLOT_628a78866990;
if (!(true)) return;
uint64_t KEY_628a7881a2f0 = 0;
auto reg_customer__c_city_encoded = customer__c_city_encoded[BUF_628a788691f0[slot_second628a788691f0 * 1 + 0]];

KEY_628a7881a2f0 |= reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[BUF_628a78867080[slot_second628a78867080 * 1 + 0]];
KEY_628a7881a2f0 <<= 16;
KEY_628a7881a2f0 |= reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[BUF_628a78866990[slot_second628a78866990 * 1 + 0]];
KEY_628a7881a2f0 <<= 32;
KEY_628a7881a2f0 |= reg_date__d_year;
//Aggregate in hashtable
auto buf_idx_628a7881a2f0 = HT_628a7881a2f0.find(KEY_628a7881a2f0)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_628a7881a2f0], reg_lineorder__lo_revenue);
KEY_628a7881a2f0customer__c_city_encoded[buf_idx_628a7881a2f0] = reg_customer__c_city_encoded;
KEY_628a7881a2f0supplier__s_city_encoded[buf_idx_628a7881a2f0] = reg_supplier__s_city_encoded;
KEY_628a7881a2f0date__d_year[buf_idx_628a7881a2f0] = reg_date__d_year;
});
});
});
}
__global__ void count_628a78885eb0(uint64_t* COUNT628a787f6920, size_t COUNT628a7881a2f0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT628a7881a2f0) return;
//Materialize count
atomicAdd((int*)COUNT628a787f6920, 1);
}
__global__ void main_628a78885eb0(size_t COUNT628a7881a2f0, DBDecimalType* MAT628a787f6920aggr0__tmp_attr0, DBI16Type* MAT628a787f6920customer__c_city_encoded, DBI32Type* MAT628a787f6920date__d_year, DBI16Type* MAT628a787f6920supplier__s_city_encoded, uint64_t* MAT_IDX628a787f6920, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_city_encoded, DBI32Type* date__d_year, DBI16Type* supplier__s_city_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT628a7881a2f0) return;
//Materialize buffers
auto mat_idx628a787f6920 = atomicAdd((int*)MAT_IDX628a787f6920, 1);
auto reg_customer__c_city_encoded = customer__c_city_encoded[tid];
MAT628a787f6920customer__c_city_encoded[mat_idx628a787f6920] = reg_customer__c_city_encoded;
auto reg_supplier__s_city_encoded = supplier__s_city_encoded[tid];
MAT628a787f6920supplier__s_city_encoded[mat_idx628a787f6920] = reg_supplier__s_city_encoded;
auto reg_date__d_year = date__d_year[tid];
MAT628a787f6920date__d_year[mat_idx628a787f6920] = reg_date__d_year;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT628a787f6920aggr0__tmp_attr0[mat_idx628a787f6920] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT628a78867080;
cudaMalloc(&d_COUNT628a78867080, sizeof(uint64_t));
cudaMemset(d_COUNT628a78867080, 0, sizeof(uint64_t));
count_628a78872b00<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT628a78867080, d_supplier__s_nation, supplier_size);
uint64_t COUNT628a78867080;
cudaMemcpy(&COUNT628a78867080, d_COUNT628a78867080, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_628a78867080;
cudaMalloc(&d_BUF_IDX_628a78867080, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_628a78867080, 0, sizeof(uint64_t));
uint64_t* d_BUF_628a78867080;
cudaMalloc(&d_BUF_628a78867080, sizeof(uint64_t) * COUNT628a78867080 * 1);
auto d_HT_628a78867080 = cuco::experimental::static_multimap{ (int)COUNT628a78867080*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_628a78872b00<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_628a78867080, d_BUF_IDX_628a78867080, d_HT_628a78867080.ref(cuco::insert), d_supplier__s_nation, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT628a788691f0;
cudaMalloc(&d_COUNT628a788691f0, sizeof(uint64_t));
cudaMemset(d_COUNT628a788691f0, 0, sizeof(uint64_t));
count_628a7884a9c0<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT628a788691f0, d_customer__c_nation, customer_size);
uint64_t COUNT628a788691f0;
cudaMemcpy(&COUNT628a788691f0, d_COUNT628a788691f0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_628a788691f0;
cudaMalloc(&d_BUF_IDX_628a788691f0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_628a788691f0, 0, sizeof(uint64_t));
uint64_t* d_BUF_628a788691f0;
cudaMalloc(&d_BUF_628a788691f0, sizeof(uint64_t) * COUNT628a788691f0 * 1);
auto d_HT_628a788691f0 = cuco::experimental::static_multimap{ (int)COUNT628a788691f0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_628a7884a9c0<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_628a788691f0, d_BUF_IDX_628a788691f0, d_HT_628a788691f0.ref(cuco::insert), d_customer__c_custkey, d_customer__c_nation, customer_size);
//Materialize count
uint64_t* d_COUNT628a78866990;
cudaMalloc(&d_COUNT628a78866990, sizeof(uint64_t));
cudaMemset(d_COUNT628a78866990, 0, sizeof(uint64_t));
count_628a7887b9f0<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT628a78866990, d_date__d_year, date_size);
uint64_t COUNT628a78866990;
cudaMemcpy(&COUNT628a78866990, d_COUNT628a78866990, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_628a78866990;
cudaMalloc(&d_BUF_IDX_628a78866990, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_628a78866990, 0, sizeof(uint64_t));
uint64_t* d_BUF_628a78866990;
cudaMalloc(&d_BUF_628a78866990, sizeof(uint64_t) * COUNT628a78866990 * 1);
auto d_HT_628a78866990 = cuco::experimental::static_multimap{ (int)COUNT628a78866990*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_628a7887b9f0<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_628a78866990, d_BUF_IDX_628a78866990, d_HT_628a78866990.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Create aggregation hash table
auto d_HT_628a7881a2f0 = cuco::static_map{ (int)5679*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_628a7884af60<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_628a78866990, d_BUF_628a78867080, d_BUF_628a788691f0, d_HT_628a7881a2f0.ref(cuco::insert), d_HT_628a78866990.ref(cuco::for_each), d_HT_628a78867080.ref(cuco::for_each), d_HT_628a788691f0.ref(cuco::for_each), d_customer__c_city_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_city_encoded);
size_t COUNT628a7881a2f0 = d_HT_628a7881a2f0.size();
thrust::device_vector<int64_t> keys_628a7881a2f0(COUNT628a7881a2f0), vals_628a7881a2f0(COUNT628a7881a2f0);
d_HT_628a7881a2f0.retrieve_all(keys_628a7881a2f0.begin(), vals_628a7881a2f0.begin());
d_HT_628a7881a2f0.clear();
int64_t* raw_keys628a7881a2f0 = thrust::raw_pointer_cast(keys_628a7881a2f0.data());
insertKeys<<<std::ceil((float)COUNT628a7881a2f0/128.), 128>>>(raw_keys628a7881a2f0, d_HT_628a7881a2f0.ref(cuco::insert), COUNT628a7881a2f0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT628a7881a2f0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT628a7881a2f0);
DBI16Type* d_KEY_628a7881a2f0customer__c_city_encoded;
cudaMalloc(&d_KEY_628a7881a2f0customer__c_city_encoded, sizeof(DBI16Type) * COUNT628a7881a2f0);
cudaMemset(d_KEY_628a7881a2f0customer__c_city_encoded, 0, sizeof(DBI16Type) * COUNT628a7881a2f0);
DBI16Type* d_KEY_628a7881a2f0supplier__s_city_encoded;
cudaMalloc(&d_KEY_628a7881a2f0supplier__s_city_encoded, sizeof(DBI16Type) * COUNT628a7881a2f0);
cudaMemset(d_KEY_628a7881a2f0supplier__s_city_encoded, 0, sizeof(DBI16Type) * COUNT628a7881a2f0);
DBI32Type* d_KEY_628a7881a2f0date__d_year;
cudaMalloc(&d_KEY_628a7881a2f0date__d_year, sizeof(DBI32Type) * COUNT628a7881a2f0);
cudaMemset(d_KEY_628a7881a2f0date__d_year, 0, sizeof(DBI32Type) * COUNT628a7881a2f0);
main_628a7884af60<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_628a78866990, d_BUF_628a78867080, d_BUF_628a788691f0, d_HT_628a7881a2f0.ref(cuco::find), d_HT_628a78866990.ref(cuco::for_each), d_HT_628a78867080.ref(cuco::for_each), d_HT_628a788691f0.ref(cuco::for_each), d_KEY_628a7881a2f0customer__c_city_encoded, d_KEY_628a7881a2f0date__d_year, d_KEY_628a7881a2f0supplier__s_city_encoded, d_aggr0__tmp_attr0, d_customer__c_city_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_city_encoded);
//Materialize count
uint64_t* d_COUNT628a787f6920;
cudaMalloc(&d_COUNT628a787f6920, sizeof(uint64_t));
cudaMemset(d_COUNT628a787f6920, 0, sizeof(uint64_t));
count_628a78885eb0<<<std::ceil((float)COUNT628a7881a2f0/128.), 128>>>(d_COUNT628a787f6920, COUNT628a7881a2f0);
uint64_t COUNT628a787f6920;
cudaMemcpy(&COUNT628a787f6920, d_COUNT628a787f6920, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX628a787f6920;
cudaMalloc(&d_MAT_IDX628a787f6920, sizeof(uint64_t));
cudaMemset(d_MAT_IDX628a787f6920, 0, sizeof(uint64_t));
auto MAT628a787f6920customer__c_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT628a787f6920);
DBI16Type* d_MAT628a787f6920customer__c_city_encoded;
cudaMalloc(&d_MAT628a787f6920customer__c_city_encoded, sizeof(DBI16Type) * COUNT628a787f6920);
auto MAT628a787f6920supplier__s_city_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT628a787f6920);
DBI16Type* d_MAT628a787f6920supplier__s_city_encoded;
cudaMalloc(&d_MAT628a787f6920supplier__s_city_encoded, sizeof(DBI16Type) * COUNT628a787f6920);
auto MAT628a787f6920date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT628a787f6920);
DBI32Type* d_MAT628a787f6920date__d_year;
cudaMalloc(&d_MAT628a787f6920date__d_year, sizeof(DBI32Type) * COUNT628a787f6920);
auto MAT628a787f6920aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT628a787f6920);
DBDecimalType* d_MAT628a787f6920aggr0__tmp_attr0;
cudaMalloc(&d_MAT628a787f6920aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT628a787f6920);
main_628a78885eb0<<<std::ceil((float)COUNT628a7881a2f0/128.), 128>>>(COUNT628a7881a2f0, d_MAT628a787f6920aggr0__tmp_attr0, d_MAT628a787f6920customer__c_city_encoded, d_MAT628a787f6920date__d_year, d_MAT628a787f6920supplier__s_city_encoded, d_MAT_IDX628a787f6920, d_aggr0__tmp_attr0, d_KEY_628a7881a2f0customer__c_city_encoded, d_KEY_628a7881a2f0date__d_year, d_KEY_628a7881a2f0supplier__s_city_encoded);
cudaMemcpy(MAT628a787f6920customer__c_city_encoded, d_MAT628a787f6920customer__c_city_encoded, sizeof(DBI16Type) * COUNT628a787f6920, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT628a787f6920supplier__s_city_encoded, d_MAT628a787f6920supplier__s_city_encoded, sizeof(DBI16Type) * COUNT628a787f6920, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT628a787f6920date__d_year, d_MAT628a787f6920date__d_year, sizeof(DBI32Type) * COUNT628a787f6920, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT628a787f6920aggr0__tmp_attr0, d_MAT628a787f6920aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT628a787f6920, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT628a787f6920; i++) { std::cout << "" << customer__c_city_map[MAT628a787f6920customer__c_city_encoded[i]];
std::cout << "," << supplier__s_city_map[MAT628a787f6920supplier__s_city_encoded[i]];
std::cout << "," << MAT628a787f6920date__d_year[i];
std::cout << "," << MAT628a787f6920aggr0__tmp_attr0[i];
std::cout << std::endl; }
cudaFree(d_BUF_628a78867080);
cudaFree(d_BUF_IDX_628a78867080);
cudaFree(d_COUNT628a78867080);
cudaFree(d_BUF_628a788691f0);
cudaFree(d_BUF_IDX_628a788691f0);
cudaFree(d_COUNT628a788691f0);
cudaFree(d_BUF_628a78866990);
cudaFree(d_BUF_IDX_628a78866990);
cudaFree(d_COUNT628a78866990);
cudaFree(d_KEY_628a7881a2f0customer__c_city_encoded);
cudaFree(d_KEY_628a7881a2f0date__d_year);
cudaFree(d_KEY_628a7881a2f0supplier__s_city_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT628a787f6920);
cudaFree(d_MAT628a787f6920aggr0__tmp_attr0);
cudaFree(d_MAT628a787f6920customer__c_city_encoded);
cudaFree(d_MAT628a787f6920date__d_year);
cudaFree(d_MAT628a787f6920supplier__s_city_encoded);
cudaFree(d_MAT_IDX628a787f6920);
free(MAT628a787f6920aggr0__tmp_attr0);
free(MAT628a787f6920customer__c_city_encoded);
free(MAT628a787f6920date__d_year);
free(MAT628a787f6920supplier__s_city_encoded);
}