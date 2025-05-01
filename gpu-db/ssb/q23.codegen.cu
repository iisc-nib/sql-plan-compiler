#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_556962363290(uint64_t* COUNT5569623580d0, DBStringType* part__p_brand1, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_brand1 = part__p_brand1[tid];
if (!(evaluatePredicate(reg_part__p_brand1, "MFGR#2239", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5569623580d0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_556962363290(uint64_t* BUF_5569623580d0, uint64_t* BUF_IDX_5569623580d0, HASHTABLE_INSERT HT_5569623580d0, DBStringType* part__p_brand1, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_brand1 = part__p_brand1[tid];
if (!(evaluatePredicate(reg_part__p_brand1, "MFGR#2239", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5569623580d0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_5569623580d0 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_5569623580d0 = atomicAdd((int*)BUF_IDX_5569623580d0, 1);
HT_5569623580d0.insert(cuco::pair{KEY_5569623580d0, buf_idx_5569623580d0});
BUF_5569623580d0[buf_idx_5569623580d0 * 1 + 0] = tid;
}
__global__ void count_556962365cb0(uint64_t* COUNT556962357e00, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "EUROPE", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT556962357e00, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_556962365cb0(uint64_t* BUF_556962357e00, uint64_t* BUF_IDX_556962357e00, HASHTABLE_INSERT HT_556962357e00, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "EUROPE", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_556962357e00 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_556962357e00 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_556962357e00 = atomicAdd((int*)BUF_IDX_556962357e00, 1);
HT_556962357e00.insert(cuco::pair{KEY_556962357e00, buf_idx_556962357e00});
BUF_556962357e00[buf_idx_556962357e00 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_55696233c0e0(uint64_t* BUF_556962357e00, uint64_t* BUF_5569623580d0, uint64_t* COUNT55696233a9b0, HASHTABLE_PROBE HT_556962357e00, HASHTABLE_PROBE HT_5569623580d0, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5569623580d0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5569623580d0 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_5569623580d0.for_each(KEY_5569623580d0, [&] __device__ (auto const SLOT_5569623580d0) {

auto const [slot_first5569623580d0, slot_second5569623580d0] = SLOT_5569623580d0;
if (!(true)) return;
uint64_t KEY_556962357e00 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_556962357e00 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_556962357e00.for_each(KEY_556962357e00, [&] __device__ (auto const SLOT_556962357e00) {

auto const [slot_first556962357e00, slot_second556962357e00] = SLOT_556962357e00;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT55696233a9b0, 1);
});
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_55696233c0e0(uint64_t* BUF_55696233a9b0, uint64_t* BUF_556962357e00, uint64_t* BUF_5569623580d0, uint64_t* BUF_IDX_55696233a9b0, HASHTABLE_INSERT HT_55696233a9b0, HASHTABLE_PROBE HT_556962357e00, HASHTABLE_PROBE HT_5569623580d0, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5569623580d0 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5569623580d0 |= reg_lineorder__lo_partkey;
//Probe Hash table
HT_5569623580d0.for_each(KEY_5569623580d0, [&] __device__ (auto const SLOT_5569623580d0) {
auto const [slot_first5569623580d0, slot_second5569623580d0] = SLOT_5569623580d0;
if (!(true)) return;
uint64_t KEY_556962357e00 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_556962357e00 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_556962357e00.for_each(KEY_556962357e00, [&] __device__ (auto const SLOT_556962357e00) {
auto const [slot_first556962357e00, slot_second556962357e00] = SLOT_556962357e00;
if (!(true)) return;
uint64_t KEY_55696233a9b0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_55696233a9b0 |= reg_lineorder__lo_orderdate;
// Insert hash table kernel;
auto buf_idx_55696233a9b0 = atomicAdd((int*)BUF_IDX_55696233a9b0, 1);
HT_55696233a9b0.insert(cuco::pair{KEY_55696233a9b0, buf_idx_55696233a9b0});
BUF_55696233a9b0[buf_idx_55696233a9b0 * 3 + 0] = tid;
BUF_55696233a9b0[buf_idx_55696233a9b0 * 3 + 1] = BUF_5569623580d0[slot_second5569623580d0 * 1 + 0];
BUF_55696233a9b0[buf_idx_55696233a9b0 * 3 + 2] = BUF_556962357e00[slot_second556962357e00 * 1 + 0];
});
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_55696233c6b0(uint64_t* BUF_55696233a9b0, HASHTABLE_INSERT HT_55696230c620, HASHTABLE_PROBE HT_55696233a9b0, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_55696233a9b0 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_55696233a9b0 |= reg_date__d_datekey;
//Probe Hash table
HT_55696233a9b0.for_each(KEY_55696233a9b0, [&] __device__ (auto const SLOT_55696233a9b0) {

auto const [slot_first55696233a9b0, slot_second55696233a9b0] = SLOT_55696233a9b0;
if (!(true)) return;
uint64_t KEY_55696230c620 = 0;
auto reg_date__d_year = date__d_year[tid];

KEY_55696230c620 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_55696233a9b0[slot_second55696233a9b0 * 3 + 1]];
KEY_55696230c620 <<= 16;
KEY_55696230c620 |= reg_part__p_brand1_encoded;
//Create aggregation hash table
HT_55696230c620.insert(cuco::pair{KEY_55696230c620, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_55696233c6b0(uint64_t* BUF_55696233a9b0, HASHTABLE_FIND HT_55696230c620, HASHTABLE_PROBE HT_55696233a9b0, DBI32Type* KEY_55696230c620date__d_year, DBI16Type* KEY_55696230c620part__p_brand1_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size, DBDecimalType* lineorder__lo_revenue, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_55696233a9b0 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_55696233a9b0 |= reg_date__d_datekey;
//Probe Hash table
HT_55696233a9b0.for_each(KEY_55696233a9b0, [&] __device__ (auto const SLOT_55696233a9b0) {
auto const [slot_first55696233a9b0, slot_second55696233a9b0] = SLOT_55696233a9b0;
if (!(true)) return;
uint64_t KEY_55696230c620 = 0;
auto reg_date__d_year = date__d_year[tid];

KEY_55696230c620 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_55696233a9b0[slot_second55696233a9b0 * 3 + 1]];
KEY_55696230c620 <<= 16;
KEY_55696230c620 |= reg_part__p_brand1_encoded;
//Aggregate in hashtable
auto buf_idx_55696230c620 = HT_55696230c620.find(KEY_55696230c620)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[BUF_55696233a9b0[slot_second55696233a9b0 * 3 + 0]];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_55696230c620], reg_lineorder__lo_revenue);
KEY_55696230c620date__d_year[buf_idx_55696230c620] = reg_date__d_year;
KEY_55696230c620part__p_brand1_encoded[buf_idx_55696230c620] = reg_part__p_brand1_encoded;
});
}
__global__ void count_556962376d60(size_t COUNT55696230c620, uint64_t* COUNT55696231f740) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT55696230c620) return;
//Materialize count
atomicAdd((int*)COUNT55696231f740, 1);
}
__global__ void main_556962376d60(size_t COUNT55696230c620, DBDecimalType* MAT55696231f740aggr0__tmp_attr0, DBI32Type* MAT55696231f740date__d_year, DBI16Type* MAT55696231f740part__p_brand1_encoded, uint64_t* MAT_IDX55696231f740, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT55696230c620) return;
//Materialize buffers
auto mat_idx55696231f740 = atomicAdd((int*)MAT_IDX55696231f740, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT55696231f740aggr0__tmp_attr0[mat_idx55696231f740] = reg_aggr0__tmp_attr0;
auto reg_date__d_year = date__d_year[tid];
MAT55696231f740date__d_year[mat_idx55696231f740] = reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[tid];
MAT55696231f740part__p_brand1_encoded[mat_idx55696231f740] = reg_part__p_brand1_encoded;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT5569623580d0;
cudaMalloc(&d_COUNT5569623580d0, sizeof(uint64_t));
cudaMemset(d_COUNT5569623580d0, 0, sizeof(uint64_t));
count_556962363290<<<std::ceil((float)part_size/128.), 128>>>(d_COUNT5569623580d0, d_part__p_brand1, part_size);
uint64_t COUNT5569623580d0;
cudaMemcpy(&COUNT5569623580d0, d_COUNT5569623580d0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5569623580d0;
cudaMalloc(&d_BUF_IDX_5569623580d0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5569623580d0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5569623580d0;
cudaMalloc(&d_BUF_5569623580d0, sizeof(uint64_t) * COUNT5569623580d0 * 1);
auto d_HT_5569623580d0 = cuco::experimental::static_multimap{ (int)COUNT5569623580d0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_556962363290<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_5569623580d0, d_BUF_IDX_5569623580d0, d_HT_5569623580d0.ref(cuco::insert), d_part__p_brand1, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT556962357e00;
cudaMalloc(&d_COUNT556962357e00, sizeof(uint64_t));
cudaMemset(d_COUNT556962357e00, 0, sizeof(uint64_t));
count_556962365cb0<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT556962357e00, d_supplier__s_region, supplier_size);
uint64_t COUNT556962357e00;
cudaMemcpy(&COUNT556962357e00, d_COUNT556962357e00, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_556962357e00;
cudaMalloc(&d_BUF_IDX_556962357e00, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_556962357e00, 0, sizeof(uint64_t));
uint64_t* d_BUF_556962357e00;
cudaMalloc(&d_BUF_556962357e00, sizeof(uint64_t) * COUNT556962357e00 * 1);
auto d_HT_556962357e00 = cuco::experimental::static_multimap{ (int)COUNT556962357e00*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_556962365cb0<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_556962357e00, d_BUF_IDX_556962357e00, d_HT_556962357e00.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT55696233a9b0;
cudaMalloc(&d_COUNT55696233a9b0, sizeof(uint64_t));
cudaMemset(d_COUNT55696233a9b0, 0, sizeof(uint64_t));
count_55696233c0e0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_556962357e00, d_BUF_5569623580d0, d_COUNT55696233a9b0, d_HT_556962357e00.ref(cuco::for_each), d_HT_5569623580d0.ref(cuco::for_each), d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
uint64_t COUNT55696233a9b0;
cudaMemcpy(&COUNT55696233a9b0, d_COUNT55696233a9b0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_55696233a9b0;
cudaMalloc(&d_BUF_IDX_55696233a9b0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_55696233a9b0, 0, sizeof(uint64_t));
uint64_t* d_BUF_55696233a9b0;
cudaMalloc(&d_BUF_55696233a9b0, sizeof(uint64_t) * COUNT55696233a9b0 * 3);
auto d_HT_55696233a9b0 = cuco::experimental::static_multimap{ (int)COUNT55696233a9b0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_55696233c0e0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_55696233a9b0, d_BUF_556962357e00, d_BUF_5569623580d0, d_BUF_IDX_55696233a9b0, d_HT_55696233a9b0.ref(cuco::insert), d_HT_556962357e00.ref(cuco::for_each), d_HT_5569623580d0.ref(cuco::for_each), d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
//Create aggregation hash table
auto d_HT_55696230c620 = cuco::static_map{ (int)1208*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_55696233c6b0<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_55696233a9b0, d_HT_55696230c620.ref(cuco::insert), d_HT_55696233a9b0.ref(cuco::for_each), d_date__d_datekey, d_date__d_year, date_size, d_part__p_brand1_encoded);
size_t COUNT55696230c620 = d_HT_55696230c620.size();
thrust::device_vector<int64_t> keys_55696230c620(COUNT55696230c620), vals_55696230c620(COUNT55696230c620);
d_HT_55696230c620.retrieve_all(keys_55696230c620.begin(), vals_55696230c620.begin());
d_HT_55696230c620.clear();
int64_t* raw_keys55696230c620 = thrust::raw_pointer_cast(keys_55696230c620.data());
insertKeys<<<std::ceil((float)COUNT55696230c620/128.), 128>>>(raw_keys55696230c620, d_HT_55696230c620.ref(cuco::insert), COUNT55696230c620);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT55696230c620);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT55696230c620);
DBI32Type* d_KEY_55696230c620date__d_year;
cudaMalloc(&d_KEY_55696230c620date__d_year, sizeof(DBI32Type) * COUNT55696230c620);
cudaMemset(d_KEY_55696230c620date__d_year, 0, sizeof(DBI32Type) * COUNT55696230c620);
DBI16Type* d_KEY_55696230c620part__p_brand1_encoded;
cudaMalloc(&d_KEY_55696230c620part__p_brand1_encoded, sizeof(DBI16Type) * COUNT55696230c620);
cudaMemset(d_KEY_55696230c620part__p_brand1_encoded, 0, sizeof(DBI16Type) * COUNT55696230c620);
main_55696233c6b0<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_55696233a9b0, d_HT_55696230c620.ref(cuco::find), d_HT_55696233a9b0.ref(cuco::for_each), d_KEY_55696230c620date__d_year, d_KEY_55696230c620part__p_brand1_encoded, d_aggr0__tmp_attr0, d_date__d_datekey, d_date__d_year, date_size, d_lineorder__lo_revenue, d_part__p_brand1_encoded);
//Materialize count
uint64_t* d_COUNT55696231f740;
cudaMalloc(&d_COUNT55696231f740, sizeof(uint64_t));
cudaMemset(d_COUNT55696231f740, 0, sizeof(uint64_t));
count_556962376d60<<<std::ceil((float)COUNT55696230c620/128.), 128>>>(COUNT55696230c620, d_COUNT55696231f740);
uint64_t COUNT55696231f740;
cudaMemcpy(&COUNT55696231f740, d_COUNT55696231f740, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX55696231f740;
cudaMalloc(&d_MAT_IDX55696231f740, sizeof(uint64_t));
cudaMemset(d_MAT_IDX55696231f740, 0, sizeof(uint64_t));
auto MAT55696231f740aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT55696231f740);
DBDecimalType* d_MAT55696231f740aggr0__tmp_attr0;
cudaMalloc(&d_MAT55696231f740aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT55696231f740);
auto MAT55696231f740date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT55696231f740);
DBI32Type* d_MAT55696231f740date__d_year;
cudaMalloc(&d_MAT55696231f740date__d_year, sizeof(DBI32Type) * COUNT55696231f740);
auto MAT55696231f740part__p_brand1_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT55696231f740);
DBI16Type* d_MAT55696231f740part__p_brand1_encoded;
cudaMalloc(&d_MAT55696231f740part__p_brand1_encoded, sizeof(DBI16Type) * COUNT55696231f740);
main_556962376d60<<<std::ceil((float)COUNT55696230c620/128.), 128>>>(COUNT55696230c620, d_MAT55696231f740aggr0__tmp_attr0, d_MAT55696231f740date__d_year, d_MAT55696231f740part__p_brand1_encoded, d_MAT_IDX55696231f740, d_aggr0__tmp_attr0, d_KEY_55696230c620date__d_year, d_KEY_55696230c620part__p_brand1_encoded);
cudaMemcpy(MAT55696231f740aggr0__tmp_attr0, d_MAT55696231f740aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT55696231f740, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT55696231f740date__d_year, d_MAT55696231f740date__d_year, sizeof(DBI32Type) * COUNT55696231f740, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT55696231f740part__p_brand1_encoded, d_MAT55696231f740part__p_brand1_encoded, sizeof(DBI16Type) * COUNT55696231f740, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT55696231f740; i++) { std::cout << "" << MAT55696231f740aggr0__tmp_attr0[i];
std::cout << "," << MAT55696231f740date__d_year[i];
std::cout << "," << part__p_brand1_map[MAT55696231f740part__p_brand1_encoded[i]];
std::cout << std::endl; }
cudaFree(d_BUF_5569623580d0);
cudaFree(d_BUF_IDX_5569623580d0);
cudaFree(d_COUNT5569623580d0);
cudaFree(d_BUF_556962357e00);
cudaFree(d_BUF_IDX_556962357e00);
cudaFree(d_COUNT556962357e00);
cudaFree(d_BUF_55696233a9b0);
cudaFree(d_BUF_IDX_55696233a9b0);
cudaFree(d_COUNT55696233a9b0);
cudaFree(d_KEY_55696230c620date__d_year);
cudaFree(d_KEY_55696230c620part__p_brand1_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT55696231f740);
cudaFree(d_MAT55696231f740aggr0__tmp_attr0);
cudaFree(d_MAT55696231f740date__d_year);
cudaFree(d_MAT55696231f740part__p_brand1_encoded);
cudaFree(d_MAT_IDX55696231f740);
free(MAT55696231f740aggr0__tmp_attr0);
free(MAT55696231f740date__d_year);
free(MAT55696231f740part__p_brand1_encoded);
}