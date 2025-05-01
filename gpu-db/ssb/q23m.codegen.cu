#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_57a6dbe5ad00(uint64_t* COUNT57a6dbe4cf70, DBStringType* part__p_brand1, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_brand1 = part__p_brand1[tid];
if (!(evaluatePredicate(reg_part__p_brand1, "MFGR#2239", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT57a6dbe4cf70, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_57a6dbe5ad00(uint64_t* BUF_57a6dbe4cf70, uint64_t* BUF_IDX_57a6dbe4cf70, HASHTABLE_INSERT HT_57a6dbe4cf70, DBStringType* part__p_brand1, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_brand1 = part__p_brand1[tid];
if (!(evaluatePredicate(reg_part__p_brand1, "MFGR#2239", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_57a6dbe4cf70 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_57a6dbe4cf70 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_57a6dbe4cf70 = atomicAdd((int*)BUF_IDX_57a6dbe4cf70, 1);
HT_57a6dbe4cf70.insert(cuco::pair{KEY_57a6dbe4cf70, buf_idx_57a6dbe4cf70});
BUF_57a6dbe4cf70[buf_idx_57a6dbe4cf70 * 1 + 0] = tid;
}
__global__ void count_57a6dbe5d720(uint64_t* COUNT57a6dbe49bc0, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "EUROPE", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT57a6dbe49bc0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_57a6dbe5d720(uint64_t* BUF_57a6dbe49bc0, uint64_t* BUF_IDX_57a6dbe49bc0, HASHTABLE_INSERT HT_57a6dbe49bc0, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "EUROPE", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_57a6dbe49bc0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_57a6dbe49bc0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_57a6dbe49bc0 = atomicAdd((int*)BUF_IDX_57a6dbe49bc0, 1);
HT_57a6dbe49bc0.insert(cuco::pair{KEY_57a6dbe49bc0, buf_idx_57a6dbe49bc0});
BUF_57a6dbe49bc0[buf_idx_57a6dbe49bc0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_57a6dbe32d80(uint64_t* BUF_57a6dbe49bc0, uint64_t* BUF_57a6dbe4cf70, uint64_t* COUNT57a6dbe4fb00, HASHTABLE_PROBE HT_57a6dbe49bc0, HASHTABLE_PROBE HT_57a6dbe4cf70, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_57a6dbe4cf70 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_57a6dbe4cf70 |= reg_lineorder__lo_partkey;
//Probe Hash table
auto SLOT_57a6dbe4cf70 = HT_57a6dbe4cf70.find(KEY_57a6dbe4cf70);
if (SLOT_57a6dbe4cf70 == HT_57a6dbe4cf70.end()) return;
if (!(true)) return;
uint64_t KEY_57a6dbe49bc0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_57a6dbe49bc0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_57a6dbe49bc0 = HT_57a6dbe49bc0.find(KEY_57a6dbe49bc0);
if (SLOT_57a6dbe49bc0 == HT_57a6dbe49bc0.end()) return;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT57a6dbe4fb00, 1);
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_57a6dbe32d80(uint64_t* BUF_57a6dbe49bc0, uint64_t* BUF_57a6dbe4cf70, uint64_t* BUF_57a6dbe4fb00, uint64_t* BUF_IDX_57a6dbe4fb00, HASHTABLE_PROBE HT_57a6dbe49bc0, HASHTABLE_PROBE HT_57a6dbe4cf70, HASHTABLE_INSERT HT_57a6dbe4fb00, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_57a6dbe4cf70 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_57a6dbe4cf70 |= reg_lineorder__lo_partkey;
//Probe Hash table
auto SLOT_57a6dbe4cf70 = HT_57a6dbe4cf70.find(KEY_57a6dbe4cf70);
if (SLOT_57a6dbe4cf70 == HT_57a6dbe4cf70.end()) return;
if (!(true)) return;
uint64_t KEY_57a6dbe49bc0 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_57a6dbe49bc0 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_57a6dbe49bc0 = HT_57a6dbe49bc0.find(KEY_57a6dbe49bc0);
if (SLOT_57a6dbe49bc0 == HT_57a6dbe49bc0.end()) return;
if (!(true)) return;
uint64_t KEY_57a6dbe4fb00 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_57a6dbe4fb00 |= reg_lineorder__lo_orderdate;
// Insert hash table kernel;
auto buf_idx_57a6dbe4fb00 = atomicAdd((int*)BUF_IDX_57a6dbe4fb00, 1);
HT_57a6dbe4fb00.insert(cuco::pair{KEY_57a6dbe4fb00, buf_idx_57a6dbe4fb00});
BUF_57a6dbe4fb00[buf_idx_57a6dbe4fb00 * 3 + 0] = tid;
BUF_57a6dbe4fb00[buf_idx_57a6dbe4fb00 * 3 + 1] = BUF_57a6dbe4cf70[SLOT_57a6dbe4cf70->second * 1 + 0];
BUF_57a6dbe4fb00[buf_idx_57a6dbe4fb00 * 3 + 2] = BUF_57a6dbe49bc0[SLOT_57a6dbe49bc0->second * 1 + 0];
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_57a6dbe33350(uint64_t* BUF_57a6dbe4fb00, HASHTABLE_INSERT HT_57a6dbe03310, HASHTABLE_PROBE HT_57a6dbe4fb00, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_57a6dbe4fb00 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_57a6dbe4fb00 |= reg_date__d_datekey;
//Probe Hash table
auto SLOT_57a6dbe4fb00 = HT_57a6dbe4fb00.find(KEY_57a6dbe4fb00);
if (SLOT_57a6dbe4fb00 == HT_57a6dbe4fb00.end()) return;
if (!(true)) return;
uint64_t KEY_57a6dbe03310 = 0;
auto reg_date__d_year = date__d_year[tid];

KEY_57a6dbe03310 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_57a6dbe4fb00[SLOT_57a6dbe4fb00->second * 3 + 1]];
KEY_57a6dbe03310 <<= 16;
KEY_57a6dbe03310 |= reg_part__p_brand1_encoded;
//Create aggregation hash table
HT_57a6dbe03310.insert(cuco::pair{KEY_57a6dbe03310, 1});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_57a6dbe33350(uint64_t* BUF_57a6dbe4fb00, HASHTABLE_FIND HT_57a6dbe03310, HASHTABLE_PROBE HT_57a6dbe4fb00, DBI32Type* KEY_57a6dbe03310date__d_year, DBI16Type* KEY_57a6dbe03310part__p_brand1_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size, DBDecimalType* lineorder__lo_revenue, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_57a6dbe4fb00 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_57a6dbe4fb00 |= reg_date__d_datekey;
//Probe Hash table
auto SLOT_57a6dbe4fb00 = HT_57a6dbe4fb00.find(KEY_57a6dbe4fb00);
if (SLOT_57a6dbe4fb00 == HT_57a6dbe4fb00.end()) return;
if (!(true)) return;
uint64_t KEY_57a6dbe03310 = 0;
auto reg_date__d_year = date__d_year[tid];

KEY_57a6dbe03310 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_57a6dbe4fb00[SLOT_57a6dbe4fb00->second * 3 + 1]];
KEY_57a6dbe03310 <<= 16;
KEY_57a6dbe03310 |= reg_part__p_brand1_encoded;
//Aggregate in hashtable
auto buf_idx_57a6dbe03310 = HT_57a6dbe03310.find(KEY_57a6dbe03310)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[BUF_57a6dbe4fb00[SLOT_57a6dbe4fb00->second * 3 + 0]];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_57a6dbe03310], reg_lineorder__lo_revenue);
KEY_57a6dbe03310date__d_year[buf_idx_57a6dbe03310] = reg_date__d_year;
KEY_57a6dbe03310part__p_brand1_encoded[buf_idx_57a6dbe03310] = reg_part__p_brand1_encoded;
}
__global__ void count_57a6dbe6e4d0(size_t COUNT57a6dbe03310, uint64_t* COUNT57a6dbe168b0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT57a6dbe03310) return;
//Materialize count
atomicAdd((int*)COUNT57a6dbe168b0, 1);
}
__global__ void main_57a6dbe6e4d0(size_t COUNT57a6dbe03310, DBDecimalType* MAT57a6dbe168b0aggr0__tmp_attr0, DBI32Type* MAT57a6dbe168b0date__d_year, DBI16Type* MAT57a6dbe168b0part__p_brand1_encoded, uint64_t* MAT_IDX57a6dbe168b0, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT57a6dbe03310) return;
//Materialize buffers
auto mat_idx57a6dbe168b0 = atomicAdd((int*)MAT_IDX57a6dbe168b0, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT57a6dbe168b0aggr0__tmp_attr0[mat_idx57a6dbe168b0] = reg_aggr0__tmp_attr0;
auto reg_date__d_year = date__d_year[tid];
MAT57a6dbe168b0date__d_year[mat_idx57a6dbe168b0] = reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[tid];
MAT57a6dbe168b0part__p_brand1_encoded[mat_idx57a6dbe168b0] = reg_part__p_brand1_encoded;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT57a6dbe4cf70;
cudaMalloc(&d_COUNT57a6dbe4cf70, sizeof(uint64_t));
cudaMemset(d_COUNT57a6dbe4cf70, 0, sizeof(uint64_t));
count_57a6dbe5ad00<<<std::ceil((float)part_size/128.), 128>>>(d_COUNT57a6dbe4cf70, d_part__p_brand1, part_size);
uint64_t COUNT57a6dbe4cf70;
cudaMemcpy(&COUNT57a6dbe4cf70, d_COUNT57a6dbe4cf70, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_57a6dbe4cf70;
cudaMalloc(&d_BUF_IDX_57a6dbe4cf70, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_57a6dbe4cf70, 0, sizeof(uint64_t));
uint64_t* d_BUF_57a6dbe4cf70;
cudaMalloc(&d_BUF_57a6dbe4cf70, sizeof(uint64_t) * COUNT57a6dbe4cf70 * 1);
auto d_HT_57a6dbe4cf70 = cuco::static_map{ (int)COUNT57a6dbe4cf70*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_57a6dbe5ad00<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_57a6dbe4cf70, d_BUF_IDX_57a6dbe4cf70, d_HT_57a6dbe4cf70.ref(cuco::insert), d_part__p_brand1, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT57a6dbe49bc0;
cudaMalloc(&d_COUNT57a6dbe49bc0, sizeof(uint64_t));
cudaMemset(d_COUNT57a6dbe49bc0, 0, sizeof(uint64_t));
count_57a6dbe5d720<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT57a6dbe49bc0, d_supplier__s_region, supplier_size);
uint64_t COUNT57a6dbe49bc0;
cudaMemcpy(&COUNT57a6dbe49bc0, d_COUNT57a6dbe49bc0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_57a6dbe49bc0;
cudaMalloc(&d_BUF_IDX_57a6dbe49bc0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_57a6dbe49bc0, 0, sizeof(uint64_t));
uint64_t* d_BUF_57a6dbe49bc0;
cudaMalloc(&d_BUF_57a6dbe49bc0, sizeof(uint64_t) * COUNT57a6dbe49bc0 * 1);
auto d_HT_57a6dbe49bc0 = cuco::static_map{ (int)COUNT57a6dbe49bc0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_57a6dbe5d720<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_57a6dbe49bc0, d_BUF_IDX_57a6dbe49bc0, d_HT_57a6dbe49bc0.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT57a6dbe4fb00;
cudaMalloc(&d_COUNT57a6dbe4fb00, sizeof(uint64_t));
cudaMemset(d_COUNT57a6dbe4fb00, 0, sizeof(uint64_t));
count_57a6dbe32d80<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_57a6dbe49bc0, d_BUF_57a6dbe4cf70, d_COUNT57a6dbe4fb00, d_HT_57a6dbe49bc0.ref(cuco::find), d_HT_57a6dbe4cf70.ref(cuco::find), d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
uint64_t COUNT57a6dbe4fb00;
cudaMemcpy(&COUNT57a6dbe4fb00, d_COUNT57a6dbe4fb00, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_57a6dbe4fb00;
cudaMalloc(&d_BUF_IDX_57a6dbe4fb00, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_57a6dbe4fb00, 0, sizeof(uint64_t));
uint64_t* d_BUF_57a6dbe4fb00;
cudaMalloc(&d_BUF_57a6dbe4fb00, sizeof(uint64_t) * COUNT57a6dbe4fb00 * 3);
auto d_HT_57a6dbe4fb00 = cuco::static_map{ (int)COUNT57a6dbe4fb00*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_57a6dbe32d80<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_57a6dbe49bc0, d_BUF_57a6dbe4cf70, d_BUF_57a6dbe4fb00, d_BUF_IDX_57a6dbe4fb00, d_HT_57a6dbe49bc0.ref(cuco::find), d_HT_57a6dbe4cf70.ref(cuco::find), d_HT_57a6dbe4fb00.ref(cuco::insert), d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size);
//Create aggregation hash table
auto d_HT_57a6dbe03310 = cuco::static_map{ (int)1208*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_57a6dbe33350<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_57a6dbe4fb00, d_HT_57a6dbe03310.ref(cuco::insert), d_HT_57a6dbe4fb00.ref(cuco::find), d_date__d_datekey, d_date__d_year, date_size, d_part__p_brand1_encoded);
size_t COUNT57a6dbe03310 = d_HT_57a6dbe03310.size();
thrust::device_vector<int64_t> keys_57a6dbe03310(COUNT57a6dbe03310), vals_57a6dbe03310(COUNT57a6dbe03310);
d_HT_57a6dbe03310.retrieve_all(keys_57a6dbe03310.begin(), vals_57a6dbe03310.begin());
d_HT_57a6dbe03310.clear();
int64_t* raw_keys57a6dbe03310 = thrust::raw_pointer_cast(keys_57a6dbe03310.data());
insertKeys<<<std::ceil((float)COUNT57a6dbe03310/128.), 128>>>(raw_keys57a6dbe03310, d_HT_57a6dbe03310.ref(cuco::insert), COUNT57a6dbe03310);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT57a6dbe03310);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT57a6dbe03310);
DBI32Type* d_KEY_57a6dbe03310date__d_year;
cudaMalloc(&d_KEY_57a6dbe03310date__d_year, sizeof(DBI32Type) * COUNT57a6dbe03310);
cudaMemset(d_KEY_57a6dbe03310date__d_year, 0, sizeof(DBI32Type) * COUNT57a6dbe03310);
DBI16Type* d_KEY_57a6dbe03310part__p_brand1_encoded;
cudaMalloc(&d_KEY_57a6dbe03310part__p_brand1_encoded, sizeof(DBI16Type) * COUNT57a6dbe03310);
cudaMemset(d_KEY_57a6dbe03310part__p_brand1_encoded, 0, sizeof(DBI16Type) * COUNT57a6dbe03310);
main_57a6dbe33350<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_57a6dbe4fb00, d_HT_57a6dbe03310.ref(cuco::find), d_HT_57a6dbe4fb00.ref(cuco::find), d_KEY_57a6dbe03310date__d_year, d_KEY_57a6dbe03310part__p_brand1_encoded, d_aggr0__tmp_attr0, d_date__d_datekey, d_date__d_year, date_size, d_lineorder__lo_revenue, d_part__p_brand1_encoded);
//Materialize count
uint64_t* d_COUNT57a6dbe168b0;
cudaMalloc(&d_COUNT57a6dbe168b0, sizeof(uint64_t));
cudaMemset(d_COUNT57a6dbe168b0, 0, sizeof(uint64_t));
count_57a6dbe6e4d0<<<std::ceil((float)COUNT57a6dbe03310/128.), 128>>>(COUNT57a6dbe03310, d_COUNT57a6dbe168b0);
uint64_t COUNT57a6dbe168b0;
cudaMemcpy(&COUNT57a6dbe168b0, d_COUNT57a6dbe168b0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX57a6dbe168b0;
cudaMalloc(&d_MAT_IDX57a6dbe168b0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX57a6dbe168b0, 0, sizeof(uint64_t));
auto MAT57a6dbe168b0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT57a6dbe168b0);
DBDecimalType* d_MAT57a6dbe168b0aggr0__tmp_attr0;
cudaMalloc(&d_MAT57a6dbe168b0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT57a6dbe168b0);
auto MAT57a6dbe168b0date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT57a6dbe168b0);
DBI32Type* d_MAT57a6dbe168b0date__d_year;
cudaMalloc(&d_MAT57a6dbe168b0date__d_year, sizeof(DBI32Type) * COUNT57a6dbe168b0);
auto MAT57a6dbe168b0part__p_brand1_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT57a6dbe168b0);
DBI16Type* d_MAT57a6dbe168b0part__p_brand1_encoded;
cudaMalloc(&d_MAT57a6dbe168b0part__p_brand1_encoded, sizeof(DBI16Type) * COUNT57a6dbe168b0);
main_57a6dbe6e4d0<<<std::ceil((float)COUNT57a6dbe03310/128.), 128>>>(COUNT57a6dbe03310, d_MAT57a6dbe168b0aggr0__tmp_attr0, d_MAT57a6dbe168b0date__d_year, d_MAT57a6dbe168b0part__p_brand1_encoded, d_MAT_IDX57a6dbe168b0, d_aggr0__tmp_attr0, d_KEY_57a6dbe03310date__d_year, d_KEY_57a6dbe03310part__p_brand1_encoded);
cudaMemcpy(MAT57a6dbe168b0aggr0__tmp_attr0, d_MAT57a6dbe168b0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT57a6dbe168b0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT57a6dbe168b0date__d_year, d_MAT57a6dbe168b0date__d_year, sizeof(DBI32Type) * COUNT57a6dbe168b0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT57a6dbe168b0part__p_brand1_encoded, d_MAT57a6dbe168b0part__p_brand1_encoded, sizeof(DBI16Type) * COUNT57a6dbe168b0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT57a6dbe168b0; i++) { std::cout << "" << MAT57a6dbe168b0aggr0__tmp_attr0[i];
std::cout << "," << MAT57a6dbe168b0date__d_year[i];
std::cout << "," << part__p_brand1_map[MAT57a6dbe168b0part__p_brand1_encoded[i]];
std::cout << std::endl; }
cudaFree(d_BUF_57a6dbe4cf70);
cudaFree(d_BUF_IDX_57a6dbe4cf70);
cudaFree(d_COUNT57a6dbe4cf70);
cudaFree(d_BUF_57a6dbe49bc0);
cudaFree(d_BUF_IDX_57a6dbe49bc0);
cudaFree(d_COUNT57a6dbe49bc0);
cudaFree(d_BUF_57a6dbe4fb00);
cudaFree(d_BUF_IDX_57a6dbe4fb00);
cudaFree(d_COUNT57a6dbe4fb00);
cudaFree(d_KEY_57a6dbe03310date__d_year);
cudaFree(d_KEY_57a6dbe03310part__p_brand1_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT57a6dbe168b0);
cudaFree(d_MAT57a6dbe168b0aggr0__tmp_attr0);
cudaFree(d_MAT57a6dbe168b0date__d_year);
cudaFree(d_MAT57a6dbe168b0part__p_brand1_encoded);
cudaFree(d_MAT_IDX57a6dbe168b0);
free(MAT57a6dbe168b0aggr0__tmp_attr0);
free(MAT57a6dbe168b0date__d_year);
free(MAT57a6dbe168b0part__p_brand1_encoded);
}