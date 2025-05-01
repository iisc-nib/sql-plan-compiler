#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_601cc56dc0f0(uint64_t* COUNT601cc56f72a0, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT601cc56f72a0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_601cc56dc0f0(uint64_t* BUF_601cc56f72a0, uint64_t* BUF_IDX_601cc56f72a0, HASHTABLE_INSERT HT_601cc56f72a0, DBI32Type* customer__c_custkey, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_601cc56f72a0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_601cc56f72a0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_601cc56f72a0 = atomicAdd((int*)BUF_IDX_601cc56f72a0, 1);
HT_601cc56f72a0.insert(cuco::pair{KEY_601cc56f72a0, buf_idx_601cc56f72a0});
BUF_601cc56f72a0[buf_idx_601cc56f72a0 * 1 + 0] = tid;
}
__global__ void count_601cc5702b80(uint64_t* COUNT601cc56f9a90, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT601cc56f9a90, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_601cc5702b80(uint64_t* BUF_601cc56f9a90, uint64_t* BUF_IDX_601cc56f9a90, HASHTABLE_INSERT HT_601cc56f9a90, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_601cc56f9a90 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_601cc56f9a90 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_601cc56f9a90 = atomicAdd((int*)BUF_IDX_601cc56f9a90, 1);
HT_601cc56f9a90.insert(cuco::pair{KEY_601cc56f9a90, buf_idx_601cc56f9a90});
BUF_601cc56f9a90[buf_idx_601cc56f9a90 * 1 + 0] = tid;
}
__global__ void count_601cc57089f0(uint64_t* COUNT601cc56dd2e0, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT601cc56dd2e0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_601cc57089f0(uint64_t* BUF_601cc56dd2e0, uint64_t* BUF_IDX_601cc56dd2e0, HASHTABLE_INSERT HT_601cc56dd2e0, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_601cc56dd2e0 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_601cc56dd2e0 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_601cc56dd2e0 = atomicAdd((int*)BUF_IDX_601cc56dd2e0, 1);
HT_601cc56dd2e0.insert(cuco::pair{KEY_601cc56dd2e0, buf_idx_601cc56dd2e0});
BUF_601cc56dd2e0[buf_idx_601cc56dd2e0 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_601cc56dc690(uint64_t* BUF_601cc56dd2e0, uint64_t* BUF_601cc56f72a0, uint64_t* BUF_601cc56f9a90, HASHTABLE_INSERT HT_601cc56abd30, HASHTABLE_PROBE HT_601cc56dd2e0, HASHTABLE_PROBE HT_601cc56f72a0, HASHTABLE_PROBE HT_601cc56f9a90, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_601cc56f72a0 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_601cc56f72a0 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_601cc56f72a0.for_each(KEY_601cc56f72a0, [&] __device__ (auto const SLOT_601cc56f72a0) {

auto const [slot_first601cc56f72a0, slot_second601cc56f72a0] = SLOT_601cc56f72a0;
if (!(true)) return;
uint64_t KEY_601cc56f9a90 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_601cc56f9a90 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_601cc56f9a90.for_each(KEY_601cc56f9a90, [&] __device__ (auto const SLOT_601cc56f9a90) {

auto const [slot_first601cc56f9a90, slot_second601cc56f9a90] = SLOT_601cc56f9a90;
if (!(true)) return;
uint64_t KEY_601cc56dd2e0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_601cc56dd2e0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_601cc56dd2e0.for_each(KEY_601cc56dd2e0, [&] __device__ (auto const SLOT_601cc56dd2e0) {

auto const [slot_first601cc56dd2e0, slot_second601cc56dd2e0] = SLOT_601cc56dd2e0;
if (!(true)) return;
uint64_t KEY_601cc56abd30 = 0;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_601cc56f72a0[slot_second601cc56f72a0 * 1 + 0]];

KEY_601cc56abd30 |= reg_customer__c_nation_encoded;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_601cc56f9a90[slot_second601cc56f9a90 * 1 + 0]];
KEY_601cc56abd30 <<= 16;
KEY_601cc56abd30 |= reg_supplier__s_nation_encoded;
auto reg_date__d_year = date__d_year[BUF_601cc56dd2e0[slot_second601cc56dd2e0 * 1 + 0]];
KEY_601cc56abd30 <<= 32;
KEY_601cc56abd30 |= reg_date__d_year;
//Create aggregation hash table
HT_601cc56abd30.insert(cuco::pair{KEY_601cc56abd30, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_601cc56dc690(uint64_t* BUF_601cc56dd2e0, uint64_t* BUF_601cc56f72a0, uint64_t* BUF_601cc56f9a90, HASHTABLE_FIND HT_601cc56abd30, HASHTABLE_PROBE HT_601cc56dd2e0, HASHTABLE_PROBE HT_601cc56f72a0, HASHTABLE_PROBE HT_601cc56f9a90, DBI16Type* KEY_601cc56abd30customer__c_nation_encoded, DBI32Type* KEY_601cc56abd30date__d_year, DBI16Type* KEY_601cc56abd30supplier__s_nation_encoded, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_601cc56f72a0 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_601cc56f72a0 |= reg_lineorder__lo_custkey;
//Probe Hash table
HT_601cc56f72a0.for_each(KEY_601cc56f72a0, [&] __device__ (auto const SLOT_601cc56f72a0) {
auto const [slot_first601cc56f72a0, slot_second601cc56f72a0] = SLOT_601cc56f72a0;
if (!(true)) return;
uint64_t KEY_601cc56f9a90 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_601cc56f9a90 |= reg_lineorder__lo_suppkey;
//Probe Hash table
HT_601cc56f9a90.for_each(KEY_601cc56f9a90, [&] __device__ (auto const SLOT_601cc56f9a90) {
auto const [slot_first601cc56f9a90, slot_second601cc56f9a90] = SLOT_601cc56f9a90;
if (!(true)) return;
uint64_t KEY_601cc56dd2e0 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_601cc56dd2e0 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_601cc56dd2e0.for_each(KEY_601cc56dd2e0, [&] __device__ (auto const SLOT_601cc56dd2e0) {
auto const [slot_first601cc56dd2e0, slot_second601cc56dd2e0] = SLOT_601cc56dd2e0;
if (!(true)) return;
uint64_t KEY_601cc56abd30 = 0;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_601cc56f72a0[slot_second601cc56f72a0 * 1 + 0]];

KEY_601cc56abd30 |= reg_customer__c_nation_encoded;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_601cc56f9a90[slot_second601cc56f9a90 * 1 + 0]];
KEY_601cc56abd30 <<= 16;
KEY_601cc56abd30 |= reg_supplier__s_nation_encoded;
auto reg_date__d_year = date__d_year[BUF_601cc56dd2e0[slot_second601cc56dd2e0 * 1 + 0]];
KEY_601cc56abd30 <<= 32;
KEY_601cc56abd30 |= reg_date__d_year;
//Aggregate in hashtable
auto buf_idx_601cc56abd30 = HT_601cc56abd30.find(KEY_601cc56abd30)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_601cc56abd30], reg_lineorder__lo_revenue);
KEY_601cc56abd30customer__c_nation_encoded[buf_idx_601cc56abd30] = reg_customer__c_nation_encoded;
KEY_601cc56abd30supplier__s_nation_encoded[buf_idx_601cc56abd30] = reg_supplier__s_nation_encoded;
KEY_601cc56abd30date__d_year[buf_idx_601cc56abd30] = reg_date__d_year;
});
});
});
}
__global__ void count_601cc57160c0(uint64_t* COUNT601cc5687360, size_t COUNT601cc56abd30) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT601cc56abd30) return;
//Materialize count
atomicAdd((int*)COUNT601cc5687360, 1);
}
__global__ void main_601cc57160c0(size_t COUNT601cc56abd30, DBDecimalType* MAT601cc5687360aggr0__tmp_attr0, DBI16Type* MAT601cc5687360customer__c_nation_encoded, DBI32Type* MAT601cc5687360date__d_year, DBI16Type* MAT601cc5687360supplier__s_nation_encoded, uint64_t* MAT_IDX601cc5687360, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT601cc56abd30) return;
//Materialize buffers
auto mat_idx601cc5687360 = atomicAdd((int*)MAT_IDX601cc5687360, 1);
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[tid];
MAT601cc5687360customer__c_nation_encoded[mat_idx601cc5687360] = reg_customer__c_nation_encoded;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[tid];
MAT601cc5687360supplier__s_nation_encoded[mat_idx601cc5687360] = reg_supplier__s_nation_encoded;
auto reg_date__d_year = date__d_year[tid];
MAT601cc5687360date__d_year[mat_idx601cc5687360] = reg_date__d_year;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT601cc5687360aggr0__tmp_attr0[mat_idx601cc5687360] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT601cc56f72a0;
cudaMalloc(&d_COUNT601cc56f72a0, sizeof(uint64_t));
cudaMemset(d_COUNT601cc56f72a0, 0, sizeof(uint64_t));
count_601cc56dc0f0<<<std::ceil((float)customer_size/32.), 32>>>(d_COUNT601cc56f72a0, d_customer__c_region, customer_size);
uint64_t COUNT601cc56f72a0;
cudaMemcpy(&COUNT601cc56f72a0, d_COUNT601cc56f72a0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_601cc56f72a0;
cudaMalloc(&d_BUF_IDX_601cc56f72a0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_601cc56f72a0, 0, sizeof(uint64_t));
uint64_t* d_BUF_601cc56f72a0;
cudaMalloc(&d_BUF_601cc56f72a0, sizeof(uint64_t) * COUNT601cc56f72a0 * 1);
auto d_HT_601cc56f72a0 = cuco::experimental::static_multimap{ (int)COUNT601cc56f72a0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_601cc56dc0f0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_601cc56f72a0, d_BUF_IDX_601cc56f72a0, d_HT_601cc56f72a0.ref(cuco::insert), d_customer__c_custkey, d_customer__c_region, customer_size);
//Materialize count
uint64_t* d_COUNT601cc56f9a90;
cudaMalloc(&d_COUNT601cc56f9a90, sizeof(uint64_t));
cudaMemset(d_COUNT601cc56f9a90, 0, sizeof(uint64_t));
count_601cc5702b80<<<std::ceil((float)supplier_size/32.), 32>>>(d_COUNT601cc56f9a90, d_supplier__s_region, supplier_size);
uint64_t COUNT601cc56f9a90;
cudaMemcpy(&COUNT601cc56f9a90, d_COUNT601cc56f9a90, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_601cc56f9a90;
cudaMalloc(&d_BUF_IDX_601cc56f9a90, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_601cc56f9a90, 0, sizeof(uint64_t));
uint64_t* d_BUF_601cc56f9a90;
cudaMalloc(&d_BUF_601cc56f9a90, sizeof(uint64_t) * COUNT601cc56f9a90 * 1);
auto d_HT_601cc56f9a90 = cuco::experimental::static_multimap{ (int)COUNT601cc56f9a90*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_601cc5702b80<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_601cc56f9a90, d_BUF_IDX_601cc56f9a90, d_HT_601cc56f9a90.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT601cc56dd2e0;
cudaMalloc(&d_COUNT601cc56dd2e0, sizeof(uint64_t));
cudaMemset(d_COUNT601cc56dd2e0, 0, sizeof(uint64_t));
count_601cc57089f0<<<std::ceil((float)date_size/32.), 32>>>(d_COUNT601cc56dd2e0, d_date__d_year, date_size);
uint64_t COUNT601cc56dd2e0;
cudaMemcpy(&COUNT601cc56dd2e0, d_COUNT601cc56dd2e0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_601cc56dd2e0;
cudaMalloc(&d_BUF_IDX_601cc56dd2e0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_601cc56dd2e0, 0, sizeof(uint64_t));
uint64_t* d_BUF_601cc56dd2e0;
cudaMalloc(&d_BUF_601cc56dd2e0, sizeof(uint64_t) * COUNT601cc56dd2e0 * 1);
auto d_HT_601cc56dd2e0 = cuco::experimental::static_multimap{ (int)COUNT601cc56dd2e0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_601cc57089f0<<<std::ceil((float)date_size/32.), 32>>>(d_BUF_601cc56dd2e0, d_BUF_IDX_601cc56dd2e0, d_HT_601cc56dd2e0.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Create aggregation hash table
auto d_HT_601cc56abd30 = cuco::static_map{ (int)144285*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_601cc56dc690<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_601cc56dd2e0, d_BUF_601cc56f72a0, d_BUF_601cc56f9a90, d_HT_601cc56abd30.ref(cuco::insert), d_HT_601cc56dd2e0.ref(cuco::for_each), d_HT_601cc56f72a0.ref(cuco::for_each), d_HT_601cc56f9a90.ref(cuco::for_each), d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_nation_encoded);
size_t COUNT601cc56abd30 = d_HT_601cc56abd30.size();
thrust::device_vector<int64_t> keys_601cc56abd30(COUNT601cc56abd30), vals_601cc56abd30(COUNT601cc56abd30);
d_HT_601cc56abd30.retrieve_all(keys_601cc56abd30.begin(), vals_601cc56abd30.begin());
d_HT_601cc56abd30.clear();
int64_t* raw_keys601cc56abd30 = thrust::raw_pointer_cast(keys_601cc56abd30.data());
insertKeys<<<std::ceil((float)COUNT601cc56abd30/32.), 32>>>(raw_keys601cc56abd30, d_HT_601cc56abd30.ref(cuco::insert), COUNT601cc56abd30);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT601cc56abd30);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT601cc56abd30);
DBI16Type* d_KEY_601cc56abd30customer__c_nation_encoded;
cudaMalloc(&d_KEY_601cc56abd30customer__c_nation_encoded, sizeof(DBI16Type) * COUNT601cc56abd30);
cudaMemset(d_KEY_601cc56abd30customer__c_nation_encoded, 0, sizeof(DBI16Type) * COUNT601cc56abd30);
DBI16Type* d_KEY_601cc56abd30supplier__s_nation_encoded;
cudaMalloc(&d_KEY_601cc56abd30supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT601cc56abd30);
cudaMemset(d_KEY_601cc56abd30supplier__s_nation_encoded, 0, sizeof(DBI16Type) * COUNT601cc56abd30);
DBI32Type* d_KEY_601cc56abd30date__d_year;
cudaMalloc(&d_KEY_601cc56abd30date__d_year, sizeof(DBI32Type) * COUNT601cc56abd30);
cudaMemset(d_KEY_601cc56abd30date__d_year, 0, sizeof(DBI32Type) * COUNT601cc56abd30);
main_601cc56dc690<<<std::ceil((float)lineorder_size/256.), 256>>>(d_BUF_601cc56dd2e0, d_BUF_601cc56f72a0, d_BUF_601cc56f9a90, d_HT_601cc56abd30.ref(cuco::find), d_HT_601cc56dd2e0.ref(cuco::for_each), d_HT_601cc56f72a0.ref(cuco::for_each), d_HT_601cc56f9a90.ref(cuco::for_each), d_KEY_601cc56abd30customer__c_nation_encoded, d_KEY_601cc56abd30date__d_year, d_KEY_601cc56abd30supplier__s_nation_encoded, d_aggr0__tmp_attr0, d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_nation_encoded);
//Materialize count
uint64_t* d_COUNT601cc5687360;
cudaMalloc(&d_COUNT601cc5687360, sizeof(uint64_t));
cudaMemset(d_COUNT601cc5687360, 0, sizeof(uint64_t));
count_601cc57160c0<<<std::ceil((float)COUNT601cc56abd30/32.), 32>>>(d_COUNT601cc5687360, COUNT601cc56abd30);
uint64_t COUNT601cc5687360;
cudaMemcpy(&COUNT601cc5687360, d_COUNT601cc5687360, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX601cc5687360;
cudaMalloc(&d_MAT_IDX601cc5687360, sizeof(uint64_t));
cudaMemset(d_MAT_IDX601cc5687360, 0, sizeof(uint64_t));
auto MAT601cc5687360customer__c_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT601cc5687360);
DBI16Type* d_MAT601cc5687360customer__c_nation_encoded;
cudaMalloc(&d_MAT601cc5687360customer__c_nation_encoded, sizeof(DBI16Type) * COUNT601cc5687360);
auto MAT601cc5687360supplier__s_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT601cc5687360);
DBI16Type* d_MAT601cc5687360supplier__s_nation_encoded;
cudaMalloc(&d_MAT601cc5687360supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT601cc5687360);
auto MAT601cc5687360date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT601cc5687360);
DBI32Type* d_MAT601cc5687360date__d_year;
cudaMalloc(&d_MAT601cc5687360date__d_year, sizeof(DBI32Type) * COUNT601cc5687360);
auto MAT601cc5687360aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT601cc5687360);
DBDecimalType* d_MAT601cc5687360aggr0__tmp_attr0;
cudaMalloc(&d_MAT601cc5687360aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT601cc5687360);
main_601cc57160c0<<<std::ceil((float)COUNT601cc56abd30/32.), 32>>>(COUNT601cc56abd30, d_MAT601cc5687360aggr0__tmp_attr0, d_MAT601cc5687360customer__c_nation_encoded, d_MAT601cc5687360date__d_year, d_MAT601cc5687360supplier__s_nation_encoded, d_MAT_IDX601cc5687360, d_aggr0__tmp_attr0, d_KEY_601cc56abd30customer__c_nation_encoded, d_KEY_601cc56abd30date__d_year, d_KEY_601cc56abd30supplier__s_nation_encoded);
cudaMemcpy(MAT601cc5687360customer__c_nation_encoded, d_MAT601cc5687360customer__c_nation_encoded, sizeof(DBI16Type) * COUNT601cc5687360, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT601cc5687360supplier__s_nation_encoded, d_MAT601cc5687360supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT601cc5687360, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT601cc5687360date__d_year, d_MAT601cc5687360date__d_year, sizeof(DBI32Type) * COUNT601cc5687360, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT601cc5687360aggr0__tmp_attr0, d_MAT601cc5687360aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT601cc5687360, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT601cc5687360; i++) { std::cout << customer__c_nation_map[MAT601cc5687360customer__c_nation_encoded[i]] << "\t";
std::cout << supplier__s_nation_map[MAT601cc5687360supplier__s_nation_encoded[i]] << "\t";
std::cout << MAT601cc5687360date__d_year[i] << "\t";
std::cout << MAT601cc5687360aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_601cc56f72a0);
cudaFree(d_BUF_IDX_601cc56f72a0);
cudaFree(d_COUNT601cc56f72a0);
cudaFree(d_BUF_601cc56f9a90);
cudaFree(d_BUF_IDX_601cc56f9a90);
cudaFree(d_COUNT601cc56f9a90);
cudaFree(d_BUF_601cc56dd2e0);
cudaFree(d_BUF_IDX_601cc56dd2e0);
cudaFree(d_COUNT601cc56dd2e0);
cudaFree(d_KEY_601cc56abd30customer__c_nation_encoded);
cudaFree(d_KEY_601cc56abd30date__d_year);
cudaFree(d_KEY_601cc56abd30supplier__s_nation_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT601cc5687360);
cudaFree(d_MAT601cc5687360aggr0__tmp_attr0);
cudaFree(d_MAT601cc5687360customer__c_nation_encoded);
cudaFree(d_MAT601cc5687360date__d_year);
cudaFree(d_MAT601cc5687360supplier__s_nation_encoded);
cudaFree(d_MAT_IDX601cc5687360);
free(MAT601cc5687360aggr0__tmp_attr0);
free(MAT601cc5687360customer__c_nation_encoded);
free(MAT601cc5687360date__d_year);
free(MAT601cc5687360supplier__s_nation_encoded);
}