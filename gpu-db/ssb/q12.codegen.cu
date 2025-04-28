#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5fc88e7bba30(uint64_t* COUNT5fc88e7d0c10, DBI32Type* date__d_yearmonthnum, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_yearmonthnum = date__d_yearmonthnum[tid];
if (!(evaluatePredicate(reg_date__d_yearmonthnum, 199401, Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5fc88e7d0c10, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5fc88e7bba30(uint64_t* BUF_5fc88e7d0c10, uint64_t* BUF_IDX_5fc88e7d0c10, HASHTABLE_INSERT HT_5fc88e7d0c10, DBI32Type* date__d_datekey, DBI32Type* date__d_yearmonthnum, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_yearmonthnum = date__d_yearmonthnum[tid];
if (!(evaluatePredicate(reg_date__d_yearmonthnum, 199401, Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5fc88e7d0c10 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5fc88e7d0c10 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_5fc88e7d0c10 = atomicAdd((int*)BUF_IDX_5fc88e7d0c10, 1);
HT_5fc88e7d0c10.insert(cuco::pair{KEY_5fc88e7d0c10, buf_idx_5fc88e7d0c10});
BUF_5fc88e7d0c10[buf_idx_5fc88e7d0c10 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5fc88e7bb580(uint64_t* BUF_5fc88e7d0c10, HASHTABLE_INSERT HT_5fc88e78c8e0, HASHTABLE_PROBE HT_5fc88e7d0c10, DBI32Type* lineorder__lo_discount, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_quantity, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
auto reg_lineorder__lo_discount = lineorder__lo_discount[tid];
if (!(evaluatePredicate(reg_lineorder__lo_discount, 4, Predicate::gte) && evaluatePredicate(reg_lineorder__lo_discount, 6, Predicate::lte))) return;
auto reg_lineorder__lo_quantity = lineorder__lo_quantity[tid];
if (!(evaluatePredicate(reg_lineorder__lo_quantity, 26, Predicate::gte) && evaluatePredicate(reg_lineorder__lo_quantity, 35, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5fc88e7d0c10 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5fc88e7d0c10 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5fc88e7d0c10.for_each(KEY_5fc88e7d0c10, [&] __device__ (auto const SLOT_5fc88e7d0c10) {

auto const [slot_first5fc88e7d0c10, slot_second5fc88e7d0c10] = SLOT_5fc88e7d0c10;
if (!(true)) return;
uint64_t KEY_5fc88e78c8e0 = 0;
//Create aggregation hash table
HT_5fc88e78c8e0.insert(cuco::pair{KEY_5fc88e78c8e0, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5fc88e7bb580(uint64_t* BUF_5fc88e7d0c10, HASHTABLE_FIND HT_5fc88e78c8e0, HASHTABLE_PROBE HT_5fc88e7d0c10, DBDecimalType* aggr0__tmp_attr0, DBI32Type* lineorder__lo_discount, DBDecimalType* lineorder__lo_extendedprice, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_quantity, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
auto reg_lineorder__lo_discount = lineorder__lo_discount[tid];
if (!(evaluatePredicate(reg_lineorder__lo_discount, 4, Predicate::gte) && evaluatePredicate(reg_lineorder__lo_discount, 6, Predicate::lte))) return;
auto reg_lineorder__lo_quantity = lineorder__lo_quantity[tid];
if (!(evaluatePredicate(reg_lineorder__lo_quantity, 26, Predicate::gte) && evaluatePredicate(reg_lineorder__lo_quantity, 35, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5fc88e7d0c10 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5fc88e7d0c10 |= reg_lineorder__lo_orderdate;
//Probe Hash table
HT_5fc88e7d0c10.for_each(KEY_5fc88e7d0c10, [&] __device__ (auto const SLOT_5fc88e7d0c10) {
auto const [slot_first5fc88e7d0c10, slot_second5fc88e7d0c10] = SLOT_5fc88e7d0c10;
if (!(true)) return;
uint64_t KEY_5fc88e78c8e0 = 0;
//Aggregate in hashtable
auto buf_idx_5fc88e78c8e0 = HT_5fc88e78c8e0.find(KEY_5fc88e78c8e0)->second;
auto reg_lineorder__lo_extendedprice = lineorder__lo_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineorder__lo_extendedprice) * ((DBDecimalType)(reg_lineorder__lo_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5fc88e78c8e0], reg_map0__tmp_attr1);
});
}
__global__ void count_5fc88e7e3c50(size_t COUNT5fc88e78c8e0, uint64_t* COUNT5fc88e79ec80) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5fc88e78c8e0) return;
//Materialize count
atomicAdd((int*)COUNT5fc88e79ec80, 1);
}
__global__ void main_5fc88e7e3c50(size_t COUNT5fc88e78c8e0, DBDecimalType* MAT5fc88e79ec80aggr0__tmp_attr0, uint64_t* MAT_IDX5fc88e79ec80, DBDecimalType* aggr0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5fc88e78c8e0) return;
//Materialize buffers
auto mat_idx5fc88e79ec80 = atomicAdd((int*)MAT_IDX5fc88e79ec80, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5fc88e79ec80aggr0__tmp_attr0[mat_idx5fc88e79ec80] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map) {
//Materialize count
uint64_t* d_COUNT5fc88e7d0c10;
cudaMalloc(&d_COUNT5fc88e7d0c10, sizeof(uint64_t));
cudaMemset(d_COUNT5fc88e7d0c10, 0, sizeof(uint64_t));
count_5fc88e7bba30<<<std::ceil((float)date_size/32.), 32>>>(d_COUNT5fc88e7d0c10, d_date__d_yearmonthnum, date_size);
uint64_t COUNT5fc88e7d0c10;
cudaMemcpy(&COUNT5fc88e7d0c10, d_COUNT5fc88e7d0c10, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5fc88e7d0c10;
cudaMalloc(&d_BUF_IDX_5fc88e7d0c10, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5fc88e7d0c10, 0, sizeof(uint64_t));
uint64_t* d_BUF_5fc88e7d0c10;
cudaMalloc(&d_BUF_5fc88e7d0c10, sizeof(uint64_t) * COUNT5fc88e7d0c10 * 1);
auto d_HT_5fc88e7d0c10 = cuco::experimental::static_multimap{ (int)COUNT5fc88e7d0c10*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5fc88e7bba30<<<std::ceil((float)date_size/32.), 32>>>(d_BUF_5fc88e7d0c10, d_BUF_IDX_5fc88e7d0c10, d_HT_5fc88e7d0c10.ref(cuco::insert), d_date__d_datekey, d_date__d_yearmonthnum, date_size);
//Create aggregation hash table
auto d_HT_5fc88e78c8e0 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5fc88e7bb580<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_5fc88e7d0c10, d_HT_5fc88e78c8e0.ref(cuco::insert), d_HT_5fc88e7d0c10.ref(cuco::for_each), d_lineorder__lo_discount, d_lineorder__lo_orderdate, d_lineorder__lo_quantity, lineorder_size);
size_t COUNT5fc88e78c8e0 = d_HT_5fc88e78c8e0.size();
thrust::device_vector<int64_t> keys_5fc88e78c8e0(COUNT5fc88e78c8e0), vals_5fc88e78c8e0(COUNT5fc88e78c8e0);
d_HT_5fc88e78c8e0.retrieve_all(keys_5fc88e78c8e0.begin(), vals_5fc88e78c8e0.begin());
d_HT_5fc88e78c8e0.clear();
int64_t* raw_keys5fc88e78c8e0 = thrust::raw_pointer_cast(keys_5fc88e78c8e0.data());
insertKeys<<<std::ceil((float)COUNT5fc88e78c8e0/32.), 32>>>(raw_keys5fc88e78c8e0, d_HT_5fc88e78c8e0.ref(cuco::insert), COUNT5fc88e78c8e0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5fc88e78c8e0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5fc88e78c8e0);
main_5fc88e7bb580<<<std::ceil((float)lineorder_size/32.), 32>>>(d_BUF_5fc88e7d0c10, d_HT_5fc88e78c8e0.ref(cuco::find), d_HT_5fc88e7d0c10.ref(cuco::for_each), d_aggr0__tmp_attr0, d_lineorder__lo_discount, d_lineorder__lo_extendedprice, d_lineorder__lo_orderdate, d_lineorder__lo_quantity, lineorder_size);
//Materialize count
uint64_t* d_COUNT5fc88e79ec80;
cudaMalloc(&d_COUNT5fc88e79ec80, sizeof(uint64_t));
cudaMemset(d_COUNT5fc88e79ec80, 0, sizeof(uint64_t));
count_5fc88e7e3c50<<<std::ceil((float)COUNT5fc88e78c8e0/32.), 32>>>(COUNT5fc88e78c8e0, d_COUNT5fc88e79ec80);
uint64_t COUNT5fc88e79ec80;
cudaMemcpy(&COUNT5fc88e79ec80, d_COUNT5fc88e79ec80, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5fc88e79ec80;
cudaMalloc(&d_MAT_IDX5fc88e79ec80, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5fc88e79ec80, 0, sizeof(uint64_t));
auto MAT5fc88e79ec80aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5fc88e79ec80);
DBDecimalType* d_MAT5fc88e79ec80aggr0__tmp_attr0;
cudaMalloc(&d_MAT5fc88e79ec80aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5fc88e79ec80);
main_5fc88e7e3c50<<<std::ceil((float)COUNT5fc88e78c8e0/32.), 32>>>(COUNT5fc88e78c8e0, d_MAT5fc88e79ec80aggr0__tmp_attr0, d_MAT_IDX5fc88e79ec80, d_aggr0__tmp_attr0);
cudaMemcpy(MAT5fc88e79ec80aggr0__tmp_attr0, d_MAT5fc88e79ec80aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5fc88e79ec80, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5fc88e79ec80; i++) { std::cout << MAT5fc88e79ec80aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_5fc88e7d0c10);
cudaFree(d_BUF_IDX_5fc88e7d0c10);
cudaFree(d_COUNT5fc88e7d0c10);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5fc88e79ec80);
cudaFree(d_MAT5fc88e79ec80aggr0__tmp_attr0);
cudaFree(d_MAT_IDX5fc88e79ec80);
free(MAT5fc88e79ec80aggr0__tmp_attr0);
}