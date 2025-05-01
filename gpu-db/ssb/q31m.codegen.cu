#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5eaa86934600(uint64_t* COUNT5eaa86950e20, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5eaa86950e20, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5eaa86934600(uint64_t* BUF_5eaa86950e20, uint64_t* BUF_IDX_5eaa86950e20, HASHTABLE_INSERT HT_5eaa86950e20, DBI32Type* customer__c_custkey, DBStringType* customer__c_region, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_region = customer__c_region[tid];
if (!(evaluatePredicate(reg_customer__c_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5eaa86950e20 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5eaa86950e20 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_5eaa86950e20 = atomicAdd((int*)BUF_IDX_5eaa86950e20, 1);
HT_5eaa86950e20.insert(cuco::pair{KEY_5eaa86950e20, buf_idx_5eaa86950e20});
BUF_5eaa86950e20[buf_idx_5eaa86950e20 * 1 + 0] = tid;
}
__global__ void count_5eaa8695c8f0(uint64_t* COUNT5eaa869522e0, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5eaa869522e0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5eaa8695c8f0(uint64_t* BUF_5eaa869522e0, uint64_t* BUF_IDX_5eaa869522e0, HASHTABLE_INSERT HT_5eaa869522e0, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5eaa869522e0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5eaa869522e0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5eaa869522e0 = atomicAdd((int*)BUF_IDX_5eaa869522e0, 1);
HT_5eaa869522e0.insert(cuco::pair{KEY_5eaa869522e0, buf_idx_5eaa869522e0});
BUF_5eaa869522e0[buf_idx_5eaa869522e0 * 1 + 0] = tid;
}
__global__ void count_5eaa869626e0(uint64_t* COUNT5eaa8694fa30, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5eaa8694fa30, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5eaa869626e0(uint64_t* BUF_5eaa8694fa30, uint64_t* BUF_IDX_5eaa8694fa30, HASHTABLE_INSERT HT_5eaa8694fa30, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1992, Predicate::gte) && evaluatePredicate(reg_date__d_year, 1997, Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5eaa8694fa30 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5eaa8694fa30 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_5eaa8694fa30 = atomicAdd((int*)BUF_IDX_5eaa8694fa30, 1);
HT_5eaa8694fa30.insert(cuco::pair{KEY_5eaa8694fa30, buf_idx_5eaa8694fa30});
BUF_5eaa8694fa30[buf_idx_5eaa8694fa30 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5eaa86934ba0(uint64_t* BUF_5eaa8694fa30, uint64_t* BUF_5eaa86950e20, uint64_t* BUF_5eaa869522e0, HASHTABLE_INSERT HT_5eaa86904b70, HASHTABLE_PROBE HT_5eaa8694fa30, HASHTABLE_PROBE HT_5eaa86950e20, HASHTABLE_PROBE HT_5eaa869522e0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5eaa86950e20 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5eaa86950e20 |= reg_lineorder__lo_custkey;
//Probe Hash table
auto SLOT_5eaa86950e20 = HT_5eaa86950e20.find(KEY_5eaa86950e20);
if (SLOT_5eaa86950e20 == HT_5eaa86950e20.end()) return;
if (!(true)) return;
uint64_t KEY_5eaa869522e0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5eaa869522e0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_5eaa869522e0 = HT_5eaa869522e0.find(KEY_5eaa869522e0);
if (SLOT_5eaa869522e0 == HT_5eaa869522e0.end()) return;
if (!(true)) return;
uint64_t KEY_5eaa8694fa30 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5eaa8694fa30 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_5eaa8694fa30 = HT_5eaa8694fa30.find(KEY_5eaa8694fa30);
if (SLOT_5eaa8694fa30 == HT_5eaa8694fa30.end()) return;
if (!(true)) return;
uint64_t KEY_5eaa86904b70 = 0;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_5eaa86950e20[SLOT_5eaa86950e20->second * 1 + 0]];

KEY_5eaa86904b70 |= reg_customer__c_nation_encoded;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_5eaa869522e0[SLOT_5eaa869522e0->second * 1 + 0]];
KEY_5eaa86904b70 <<= 16;
KEY_5eaa86904b70 |= reg_supplier__s_nation_encoded;
auto reg_date__d_year = date__d_year[BUF_5eaa8694fa30[SLOT_5eaa8694fa30->second * 1 + 0]];
KEY_5eaa86904b70 <<= 32;
KEY_5eaa86904b70 |= reg_date__d_year;
//Create aggregation hash table
HT_5eaa86904b70.insert(cuco::pair{KEY_5eaa86904b70, 1});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5eaa86934ba0(uint64_t* BUF_5eaa8694fa30, uint64_t* BUF_5eaa86950e20, uint64_t* BUF_5eaa869522e0, HASHTABLE_FIND HT_5eaa86904b70, HASHTABLE_PROBE HT_5eaa8694fa30, HASHTABLE_PROBE HT_5eaa86950e20, HASHTABLE_PROBE HT_5eaa869522e0, DBI16Type* KEY_5eaa86904b70customer__c_nation_encoded, DBI32Type* KEY_5eaa86904b70date__d_year, DBI16Type* KEY_5eaa86904b70supplier__s_nation_encoded, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI32Type* lineorder__lo_custkey, DBI32Type* lineorder__lo_orderdate, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5eaa86950e20 = 0;
auto reg_lineorder__lo_custkey = lineorder__lo_custkey[tid];

KEY_5eaa86950e20 |= reg_lineorder__lo_custkey;
//Probe Hash table
auto SLOT_5eaa86950e20 = HT_5eaa86950e20.find(KEY_5eaa86950e20);
if (SLOT_5eaa86950e20 == HT_5eaa86950e20.end()) return;
if (!(true)) return;
uint64_t KEY_5eaa869522e0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5eaa869522e0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_5eaa869522e0 = HT_5eaa869522e0.find(KEY_5eaa869522e0);
if (SLOT_5eaa869522e0 == HT_5eaa869522e0.end()) return;
if (!(true)) return;
uint64_t KEY_5eaa8694fa30 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5eaa8694fa30 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_5eaa8694fa30 = HT_5eaa8694fa30.find(KEY_5eaa8694fa30);
if (SLOT_5eaa8694fa30 == HT_5eaa8694fa30.end()) return;
if (!(true)) return;
uint64_t KEY_5eaa86904b70 = 0;
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[BUF_5eaa86950e20[SLOT_5eaa86950e20->second * 1 + 0]];

KEY_5eaa86904b70 |= reg_customer__c_nation_encoded;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[BUF_5eaa869522e0[SLOT_5eaa869522e0->second * 1 + 0]];
KEY_5eaa86904b70 <<= 16;
KEY_5eaa86904b70 |= reg_supplier__s_nation_encoded;
auto reg_date__d_year = date__d_year[BUF_5eaa8694fa30[SLOT_5eaa8694fa30->second * 1 + 0]];
KEY_5eaa86904b70 <<= 32;
KEY_5eaa86904b70 |= reg_date__d_year;
//Aggregate in hashtable
auto buf_idx_5eaa86904b70 = HT_5eaa86904b70.find(KEY_5eaa86904b70)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5eaa86904b70], reg_lineorder__lo_revenue);
KEY_5eaa86904b70customer__c_nation_encoded[buf_idx_5eaa86904b70] = reg_customer__c_nation_encoded;
KEY_5eaa86904b70supplier__s_nation_encoded[buf_idx_5eaa86904b70] = reg_supplier__s_nation_encoded;
KEY_5eaa86904b70date__d_year[buf_idx_5eaa86904b70] = reg_date__d_year;
}
__global__ void count_5eaa8696f950(uint64_t* COUNT5eaa868e00c0, size_t COUNT5eaa86904b70) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5eaa86904b70) return;
//Materialize count
atomicAdd((int*)COUNT5eaa868e00c0, 1);
}
__global__ void main_5eaa8696f950(size_t COUNT5eaa86904b70, DBDecimalType* MAT5eaa868e00c0aggr0__tmp_attr0, DBI16Type* MAT5eaa868e00c0customer__c_nation_encoded, DBI32Type* MAT5eaa868e00c0date__d_year, DBI16Type* MAT5eaa868e00c0supplier__s_nation_encoded, uint64_t* MAT_IDX5eaa868e00c0, DBDecimalType* aggr0__tmp_attr0, DBI16Type* customer__c_nation_encoded, DBI32Type* date__d_year, DBI16Type* supplier__s_nation_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5eaa86904b70) return;
//Materialize buffers
auto mat_idx5eaa868e00c0 = atomicAdd((int*)MAT_IDX5eaa868e00c0, 1);
auto reg_customer__c_nation_encoded = customer__c_nation_encoded[tid];
MAT5eaa868e00c0customer__c_nation_encoded[mat_idx5eaa868e00c0] = reg_customer__c_nation_encoded;
auto reg_supplier__s_nation_encoded = supplier__s_nation_encoded[tid];
MAT5eaa868e00c0supplier__s_nation_encoded[mat_idx5eaa868e00c0] = reg_supplier__s_nation_encoded;
auto reg_date__d_year = date__d_year[tid];
MAT5eaa868e00c0date__d_year[mat_idx5eaa868e00c0] = reg_date__d_year;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5eaa868e00c0aggr0__tmp_attr0[mat_idx5eaa868e00c0] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT5eaa86950e20;
cudaMalloc(&d_COUNT5eaa86950e20, sizeof(uint64_t));
cudaMemset(d_COUNT5eaa86950e20, 0, sizeof(uint64_t));
count_5eaa86934600<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT5eaa86950e20, d_customer__c_region, customer_size);
uint64_t COUNT5eaa86950e20;
cudaMemcpy(&COUNT5eaa86950e20, d_COUNT5eaa86950e20, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5eaa86950e20;
cudaMalloc(&d_BUF_IDX_5eaa86950e20, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5eaa86950e20, 0, sizeof(uint64_t));
uint64_t* d_BUF_5eaa86950e20;
cudaMalloc(&d_BUF_5eaa86950e20, sizeof(uint64_t) * COUNT5eaa86950e20 * 1);
auto d_HT_5eaa86950e20 = cuco::static_map{ (int)COUNT5eaa86950e20*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5eaa86934600<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_5eaa86950e20, d_BUF_IDX_5eaa86950e20, d_HT_5eaa86950e20.ref(cuco::insert), d_customer__c_custkey, d_customer__c_region, customer_size);
//Materialize count
uint64_t* d_COUNT5eaa869522e0;
cudaMalloc(&d_COUNT5eaa869522e0, sizeof(uint64_t));
cudaMemset(d_COUNT5eaa869522e0, 0, sizeof(uint64_t));
count_5eaa8695c8f0<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT5eaa869522e0, d_supplier__s_region, supplier_size);
uint64_t COUNT5eaa869522e0;
cudaMemcpy(&COUNT5eaa869522e0, d_COUNT5eaa869522e0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5eaa869522e0;
cudaMalloc(&d_BUF_IDX_5eaa869522e0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5eaa869522e0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5eaa869522e0;
cudaMalloc(&d_BUF_5eaa869522e0, sizeof(uint64_t) * COUNT5eaa869522e0 * 1);
auto d_HT_5eaa869522e0 = cuco::static_map{ (int)COUNT5eaa869522e0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5eaa8695c8f0<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_5eaa869522e0, d_BUF_IDX_5eaa869522e0, d_HT_5eaa869522e0.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT5eaa8694fa30;
cudaMalloc(&d_COUNT5eaa8694fa30, sizeof(uint64_t));
cudaMemset(d_COUNT5eaa8694fa30, 0, sizeof(uint64_t));
count_5eaa869626e0<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT5eaa8694fa30, d_date__d_year, date_size);
uint64_t COUNT5eaa8694fa30;
cudaMemcpy(&COUNT5eaa8694fa30, d_COUNT5eaa8694fa30, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5eaa8694fa30;
cudaMalloc(&d_BUF_IDX_5eaa8694fa30, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5eaa8694fa30, 0, sizeof(uint64_t));
uint64_t* d_BUF_5eaa8694fa30;
cudaMalloc(&d_BUF_5eaa8694fa30, sizeof(uint64_t) * COUNT5eaa8694fa30 * 1);
auto d_HT_5eaa8694fa30 = cuco::static_map{ (int)COUNT5eaa8694fa30*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5eaa869626e0<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_5eaa8694fa30, d_BUF_IDX_5eaa8694fa30, d_HT_5eaa8694fa30.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Create aggregation hash table
auto d_HT_5eaa86904b70 = cuco::static_map{ (int)144285*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5eaa86934ba0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5eaa8694fa30, d_BUF_5eaa86950e20, d_BUF_5eaa869522e0, d_HT_5eaa86904b70.ref(cuco::insert), d_HT_5eaa8694fa30.ref(cuco::find), d_HT_5eaa86950e20.ref(cuco::find), d_HT_5eaa869522e0.ref(cuco::find), d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_nation_encoded);
size_t COUNT5eaa86904b70 = d_HT_5eaa86904b70.size();
thrust::device_vector<int64_t> keys_5eaa86904b70(COUNT5eaa86904b70), vals_5eaa86904b70(COUNT5eaa86904b70);
d_HT_5eaa86904b70.retrieve_all(keys_5eaa86904b70.begin(), vals_5eaa86904b70.begin());
d_HT_5eaa86904b70.clear();
int64_t* raw_keys5eaa86904b70 = thrust::raw_pointer_cast(keys_5eaa86904b70.data());
insertKeys<<<std::ceil((float)COUNT5eaa86904b70/128.), 128>>>(raw_keys5eaa86904b70, d_HT_5eaa86904b70.ref(cuco::insert), COUNT5eaa86904b70);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5eaa86904b70);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5eaa86904b70);
DBI16Type* d_KEY_5eaa86904b70customer__c_nation_encoded;
cudaMalloc(&d_KEY_5eaa86904b70customer__c_nation_encoded, sizeof(DBI16Type) * COUNT5eaa86904b70);
cudaMemset(d_KEY_5eaa86904b70customer__c_nation_encoded, 0, sizeof(DBI16Type) * COUNT5eaa86904b70);
DBI16Type* d_KEY_5eaa86904b70supplier__s_nation_encoded;
cudaMalloc(&d_KEY_5eaa86904b70supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT5eaa86904b70);
cudaMemset(d_KEY_5eaa86904b70supplier__s_nation_encoded, 0, sizeof(DBI16Type) * COUNT5eaa86904b70);
DBI32Type* d_KEY_5eaa86904b70date__d_year;
cudaMalloc(&d_KEY_5eaa86904b70date__d_year, sizeof(DBI32Type) * COUNT5eaa86904b70);
cudaMemset(d_KEY_5eaa86904b70date__d_year, 0, sizeof(DBI32Type) * COUNT5eaa86904b70);
main_5eaa86934ba0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5eaa8694fa30, d_BUF_5eaa86950e20, d_BUF_5eaa869522e0, d_HT_5eaa86904b70.ref(cuco::find), d_HT_5eaa8694fa30.ref(cuco::find), d_HT_5eaa86950e20.ref(cuco::find), d_HT_5eaa869522e0.ref(cuco::find), d_KEY_5eaa86904b70customer__c_nation_encoded, d_KEY_5eaa86904b70date__d_year, d_KEY_5eaa86904b70supplier__s_nation_encoded, d_aggr0__tmp_attr0, d_customer__c_nation_encoded, d_date__d_year, d_lineorder__lo_custkey, d_lineorder__lo_orderdate, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_supplier__s_nation_encoded);
//Materialize count
uint64_t* d_COUNT5eaa868e00c0;
cudaMalloc(&d_COUNT5eaa868e00c0, sizeof(uint64_t));
cudaMemset(d_COUNT5eaa868e00c0, 0, sizeof(uint64_t));
count_5eaa8696f950<<<std::ceil((float)COUNT5eaa86904b70/128.), 128>>>(d_COUNT5eaa868e00c0, COUNT5eaa86904b70);
uint64_t COUNT5eaa868e00c0;
cudaMemcpy(&COUNT5eaa868e00c0, d_COUNT5eaa868e00c0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5eaa868e00c0;
cudaMalloc(&d_MAT_IDX5eaa868e00c0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5eaa868e00c0, 0, sizeof(uint64_t));
auto MAT5eaa868e00c0customer__c_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5eaa868e00c0);
DBI16Type* d_MAT5eaa868e00c0customer__c_nation_encoded;
cudaMalloc(&d_MAT5eaa868e00c0customer__c_nation_encoded, sizeof(DBI16Type) * COUNT5eaa868e00c0);
auto MAT5eaa868e00c0supplier__s_nation_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5eaa868e00c0);
DBI16Type* d_MAT5eaa868e00c0supplier__s_nation_encoded;
cudaMalloc(&d_MAT5eaa868e00c0supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT5eaa868e00c0);
auto MAT5eaa868e00c0date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5eaa868e00c0);
DBI32Type* d_MAT5eaa868e00c0date__d_year;
cudaMalloc(&d_MAT5eaa868e00c0date__d_year, sizeof(DBI32Type) * COUNT5eaa868e00c0);
auto MAT5eaa868e00c0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5eaa868e00c0);
DBDecimalType* d_MAT5eaa868e00c0aggr0__tmp_attr0;
cudaMalloc(&d_MAT5eaa868e00c0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5eaa868e00c0);
main_5eaa8696f950<<<std::ceil((float)COUNT5eaa86904b70/128.), 128>>>(COUNT5eaa86904b70, d_MAT5eaa868e00c0aggr0__tmp_attr0, d_MAT5eaa868e00c0customer__c_nation_encoded, d_MAT5eaa868e00c0date__d_year, d_MAT5eaa868e00c0supplier__s_nation_encoded, d_MAT_IDX5eaa868e00c0, d_aggr0__tmp_attr0, d_KEY_5eaa86904b70customer__c_nation_encoded, d_KEY_5eaa86904b70date__d_year, d_KEY_5eaa86904b70supplier__s_nation_encoded);
cudaMemcpy(MAT5eaa868e00c0customer__c_nation_encoded, d_MAT5eaa868e00c0customer__c_nation_encoded, sizeof(DBI16Type) * COUNT5eaa868e00c0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5eaa868e00c0supplier__s_nation_encoded, d_MAT5eaa868e00c0supplier__s_nation_encoded, sizeof(DBI16Type) * COUNT5eaa868e00c0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5eaa868e00c0date__d_year, d_MAT5eaa868e00c0date__d_year, sizeof(DBI32Type) * COUNT5eaa868e00c0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5eaa868e00c0aggr0__tmp_attr0, d_MAT5eaa868e00c0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5eaa868e00c0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5eaa868e00c0; i++) { std::cout << "" << customer__c_nation_map[MAT5eaa868e00c0customer__c_nation_encoded[i]];
std::cout << "," << supplier__s_nation_map[MAT5eaa868e00c0supplier__s_nation_encoded[i]];
std::cout << "," << MAT5eaa868e00c0date__d_year[i];
std::cout << "," << MAT5eaa868e00c0aggr0__tmp_attr0[i];
std::cout << std::endl; }
cudaFree(d_BUF_5eaa86950e20);
cudaFree(d_BUF_IDX_5eaa86950e20);
cudaFree(d_COUNT5eaa86950e20);
cudaFree(d_BUF_5eaa869522e0);
cudaFree(d_BUF_IDX_5eaa869522e0);
cudaFree(d_COUNT5eaa869522e0);
cudaFree(d_BUF_5eaa8694fa30);
cudaFree(d_BUF_IDX_5eaa8694fa30);
cudaFree(d_COUNT5eaa8694fa30);
cudaFree(d_KEY_5eaa86904b70customer__c_nation_encoded);
cudaFree(d_KEY_5eaa86904b70date__d_year);
cudaFree(d_KEY_5eaa86904b70supplier__s_nation_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5eaa868e00c0);
cudaFree(d_MAT5eaa868e00c0aggr0__tmp_attr0);
cudaFree(d_MAT5eaa868e00c0customer__c_nation_encoded);
cudaFree(d_MAT5eaa868e00c0date__d_year);
cudaFree(d_MAT5eaa868e00c0supplier__s_nation_encoded);
cudaFree(d_MAT_IDX5eaa868e00c0);
free(MAT5eaa868e00c0aggr0__tmp_attr0);
free(MAT5eaa868e00c0customer__c_nation_encoded);
free(MAT5eaa868e00c0date__d_year);
free(MAT5eaa868e00c0supplier__s_nation_encoded);
}