#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_55cb94e8fff0(uint64_t* COUNT55cb94e85850, DBStringType* part__p_brand1, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_brand1 = part__p_brand1[tid];
if (!(evaluatePredicate(reg_part__p_brand1, "MFGR#2221", Predicate::gte) && evaluatePredicate(reg_part__p_brand1, "MFGR#2228", Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT55cb94e85850, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_55cb94e8fff0(uint64_t* BUF_55cb94e85850, uint64_t* BUF_IDX_55cb94e85850, HASHTABLE_INSERT HT_55cb94e85850, DBStringType* part__p_brand1, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_brand1 = part__p_brand1[tid];
if (!(evaluatePredicate(reg_part__p_brand1, "MFGR#2221", Predicate::gte) && evaluatePredicate(reg_part__p_brand1, "MFGR#2228", Predicate::lte))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_55cb94e85850 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_55cb94e85850 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_55cb94e85850 = atomicAdd((int*)BUF_IDX_55cb94e85850, 1);
HT_55cb94e85850.insert(cuco::pair{KEY_55cb94e85850, buf_idx_55cb94e85850});
BUF_55cb94e85850[buf_idx_55cb94e85850 * 1 + 0] = tid;
}
__global__ void count_55cb94e928f0(uint64_t* COUNT55cb94e85910, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT55cb94e85910, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_55cb94e928f0(uint64_t* BUF_55cb94e85910, uint64_t* BUF_IDX_55cb94e85910, HASHTABLE_INSERT HT_55cb94e85910, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "ASIA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_55cb94e85910 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_55cb94e85910 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_55cb94e85910 = atomicAdd((int*)BUF_IDX_55cb94e85910, 1);
HT_55cb94e85910.insert(cuco::pair{KEY_55cb94e85910, buf_idx_55cb94e85910});
BUF_55cb94e85910[buf_idx_55cb94e85910 * 1 + 0] = tid;
}
__global__ void count_55cb94e69db0(uint64_t* COUNT55cb94e80270, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT55cb94e80270, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_55cb94e69db0(uint64_t* BUF_55cb94e80270, uint64_t* BUF_IDX_55cb94e80270, HASHTABLE_INSERT HT_55cb94e80270, DBI32Type* date__d_datekey, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_55cb94e80270 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_55cb94e80270 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_55cb94e80270 = atomicAdd((int*)BUF_IDX_55cb94e80270, 1);
HT_55cb94e80270.insert(cuco::pair{KEY_55cb94e80270, buf_idx_55cb94e80270});
BUF_55cb94e80270[buf_idx_55cb94e80270 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_55cb94e697e0(uint64_t* BUF_55cb94e80270, uint64_t* BUF_55cb94e85850, uint64_t* BUF_55cb94e85910, HASHTABLE_INSERT HT_55cb94e3a380, HASHTABLE_PROBE HT_55cb94e80270, HASHTABLE_PROBE HT_55cb94e85850, HASHTABLE_PROBE HT_55cb94e85910, DBI32Type* date__d_year, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_55cb94e85850 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_55cb94e85850 |= reg_lineorder__lo_partkey;
//Probe Hash table
auto SLOT_55cb94e85850 = HT_55cb94e85850.find(KEY_55cb94e85850);
if (SLOT_55cb94e85850 == HT_55cb94e85850.end()) return;
if (!(true)) return;
uint64_t KEY_55cb94e85910 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_55cb94e85910 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_55cb94e85910 = HT_55cb94e85910.find(KEY_55cb94e85910);
if (SLOT_55cb94e85910 == HT_55cb94e85910.end()) return;
if (!(true)) return;
uint64_t KEY_55cb94e80270 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_55cb94e80270 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_55cb94e80270 = HT_55cb94e80270.find(KEY_55cb94e80270);
if (SLOT_55cb94e80270 == HT_55cb94e80270.end()) return;
if (!(true)) return;
uint64_t KEY_55cb94e3a380 = 0;
auto reg_date__d_year = date__d_year[BUF_55cb94e80270[SLOT_55cb94e80270->second * 1 + 0]];

KEY_55cb94e3a380 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_55cb94e85850[SLOT_55cb94e85850->second * 1 + 0]];
KEY_55cb94e3a380 <<= 16;
KEY_55cb94e3a380 |= reg_part__p_brand1_encoded;
//Create aggregation hash table
HT_55cb94e3a380.insert(cuco::pair{KEY_55cb94e3a380, 1});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_55cb94e697e0(uint64_t* BUF_55cb94e80270, uint64_t* BUF_55cb94e85850, uint64_t* BUF_55cb94e85910, HASHTABLE_FIND HT_55cb94e3a380, HASHTABLE_PROBE HT_55cb94e80270, HASHTABLE_PROBE HT_55cb94e85850, HASHTABLE_PROBE HT_55cb94e85910, DBI32Type* KEY_55cb94e3a380date__d_year, DBI16Type* KEY_55cb94e3a380part__p_brand1_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_55cb94e85850 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_55cb94e85850 |= reg_lineorder__lo_partkey;
//Probe Hash table
auto SLOT_55cb94e85850 = HT_55cb94e85850.find(KEY_55cb94e85850);
if (SLOT_55cb94e85850 == HT_55cb94e85850.end()) return;
if (!(true)) return;
uint64_t KEY_55cb94e85910 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_55cb94e85910 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_55cb94e85910 = HT_55cb94e85910.find(KEY_55cb94e85910);
if (SLOT_55cb94e85910 == HT_55cb94e85910.end()) return;
if (!(true)) return;
uint64_t KEY_55cb94e80270 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_55cb94e80270 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_55cb94e80270 = HT_55cb94e80270.find(KEY_55cb94e80270);
if (SLOT_55cb94e80270 == HT_55cb94e80270.end()) return;
if (!(true)) return;
uint64_t KEY_55cb94e3a380 = 0;
auto reg_date__d_year = date__d_year[BUF_55cb94e80270[SLOT_55cb94e80270->second * 1 + 0]];

KEY_55cb94e3a380 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_55cb94e85850[SLOT_55cb94e85850->second * 1 + 0]];
KEY_55cb94e3a380 <<= 16;
KEY_55cb94e3a380 |= reg_part__p_brand1_encoded;
//Aggregate in hashtable
auto buf_idx_55cb94e3a380 = HT_55cb94e3a380.find(KEY_55cb94e3a380)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_55cb94e3a380], reg_lineorder__lo_revenue);
KEY_55cb94e3a380date__d_year[buf_idx_55cb94e3a380] = reg_date__d_year;
KEY_55cb94e3a380part__p_brand1_encoded[buf_idx_55cb94e3a380] = reg_part__p_brand1_encoded;
}
__global__ void count_55cb94ea1e30(size_t COUNT55cb94e3a380, uint64_t* COUNT55cb94e4d3d0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT55cb94e3a380) return;
//Materialize count
atomicAdd((int*)COUNT55cb94e4d3d0, 1);
}
__global__ void main_55cb94ea1e30(size_t COUNT55cb94e3a380, DBDecimalType* MAT55cb94e4d3d0aggr0__tmp_attr0, DBI32Type* MAT55cb94e4d3d0date__d_year, DBI16Type* MAT55cb94e4d3d0part__p_brand1_encoded, uint64_t* MAT_IDX55cb94e4d3d0, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT55cb94e3a380) return;
//Materialize buffers
auto mat_idx55cb94e4d3d0 = atomicAdd((int*)MAT_IDX55cb94e4d3d0, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT55cb94e4d3d0aggr0__tmp_attr0[mat_idx55cb94e4d3d0] = reg_aggr0__tmp_attr0;
auto reg_date__d_year = date__d_year[tid];
MAT55cb94e4d3d0date__d_year[mat_idx55cb94e4d3d0] = reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[tid];
MAT55cb94e4d3d0part__p_brand1_encoded[mat_idx55cb94e4d3d0] = reg_part__p_brand1_encoded;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT55cb94e85850;
cudaMalloc(&d_COUNT55cb94e85850, sizeof(uint64_t));
cudaMemset(d_COUNT55cb94e85850, 0, sizeof(uint64_t));
count_55cb94e8fff0<<<std::ceil((float)part_size/128.), 128>>>(d_COUNT55cb94e85850, d_part__p_brand1, part_size);
uint64_t COUNT55cb94e85850;
cudaMemcpy(&COUNT55cb94e85850, d_COUNT55cb94e85850, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_55cb94e85850;
cudaMalloc(&d_BUF_IDX_55cb94e85850, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_55cb94e85850, 0, sizeof(uint64_t));
uint64_t* d_BUF_55cb94e85850;
cudaMalloc(&d_BUF_55cb94e85850, sizeof(uint64_t) * COUNT55cb94e85850 * 1);
auto d_HT_55cb94e85850 = cuco::static_map{ (int)COUNT55cb94e85850*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_55cb94e8fff0<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_55cb94e85850, d_BUF_IDX_55cb94e85850, d_HT_55cb94e85850.ref(cuco::insert), d_part__p_brand1, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT55cb94e85910;
cudaMalloc(&d_COUNT55cb94e85910, sizeof(uint64_t));
cudaMemset(d_COUNT55cb94e85910, 0, sizeof(uint64_t));
count_55cb94e928f0<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT55cb94e85910, d_supplier__s_region, supplier_size);
uint64_t COUNT55cb94e85910;
cudaMemcpy(&COUNT55cb94e85910, d_COUNT55cb94e85910, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_55cb94e85910;
cudaMalloc(&d_BUF_IDX_55cb94e85910, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_55cb94e85910, 0, sizeof(uint64_t));
uint64_t* d_BUF_55cb94e85910;
cudaMalloc(&d_BUF_55cb94e85910, sizeof(uint64_t) * COUNT55cb94e85910 * 1);
auto d_HT_55cb94e85910 = cuco::static_map{ (int)COUNT55cb94e85910*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_55cb94e928f0<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_55cb94e85910, d_BUF_IDX_55cb94e85910, d_HT_55cb94e85910.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT55cb94e80270;
cudaMalloc(&d_COUNT55cb94e80270, sizeof(uint64_t));
cudaMemset(d_COUNT55cb94e80270, 0, sizeof(uint64_t));
count_55cb94e69db0<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT55cb94e80270, date_size);
uint64_t COUNT55cb94e80270;
cudaMemcpy(&COUNT55cb94e80270, d_COUNT55cb94e80270, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_55cb94e80270;
cudaMalloc(&d_BUF_IDX_55cb94e80270, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_55cb94e80270, 0, sizeof(uint64_t));
uint64_t* d_BUF_55cb94e80270;
cudaMalloc(&d_BUF_55cb94e80270, sizeof(uint64_t) * COUNT55cb94e80270 * 1);
auto d_HT_55cb94e80270 = cuco::static_map{ (int)COUNT55cb94e80270*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_55cb94e69db0<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_55cb94e80270, d_BUF_IDX_55cb94e80270, d_HT_55cb94e80270.ref(cuco::insert), d_date__d_datekey, date_size);
//Create aggregation hash table
auto d_HT_55cb94e3a380 = cuco::static_map{ (int)3846*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_55cb94e697e0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_55cb94e80270, d_BUF_55cb94e85850, d_BUF_55cb94e85910, d_HT_55cb94e3a380.ref(cuco::insert), d_HT_55cb94e80270.ref(cuco::find), d_HT_55cb94e85850.ref(cuco::find), d_HT_55cb94e85910.ref(cuco::find), d_date__d_year, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size, d_part__p_brand1_encoded);
size_t COUNT55cb94e3a380 = d_HT_55cb94e3a380.size();
thrust::device_vector<int64_t> keys_55cb94e3a380(COUNT55cb94e3a380), vals_55cb94e3a380(COUNT55cb94e3a380);
d_HT_55cb94e3a380.retrieve_all(keys_55cb94e3a380.begin(), vals_55cb94e3a380.begin());
d_HT_55cb94e3a380.clear();
int64_t* raw_keys55cb94e3a380 = thrust::raw_pointer_cast(keys_55cb94e3a380.data());
insertKeys<<<std::ceil((float)COUNT55cb94e3a380/128.), 128>>>(raw_keys55cb94e3a380, d_HT_55cb94e3a380.ref(cuco::insert), COUNT55cb94e3a380);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT55cb94e3a380);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT55cb94e3a380);
DBI32Type* d_KEY_55cb94e3a380date__d_year;
cudaMalloc(&d_KEY_55cb94e3a380date__d_year, sizeof(DBI32Type) * COUNT55cb94e3a380);
cudaMemset(d_KEY_55cb94e3a380date__d_year, 0, sizeof(DBI32Type) * COUNT55cb94e3a380);
DBI16Type* d_KEY_55cb94e3a380part__p_brand1_encoded;
cudaMalloc(&d_KEY_55cb94e3a380part__p_brand1_encoded, sizeof(DBI16Type) * COUNT55cb94e3a380);
cudaMemset(d_KEY_55cb94e3a380part__p_brand1_encoded, 0, sizeof(DBI16Type) * COUNT55cb94e3a380);
main_55cb94e697e0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_55cb94e80270, d_BUF_55cb94e85850, d_BUF_55cb94e85910, d_HT_55cb94e3a380.ref(cuco::find), d_HT_55cb94e80270.ref(cuco::find), d_HT_55cb94e85850.ref(cuco::find), d_HT_55cb94e85910.ref(cuco::find), d_KEY_55cb94e3a380date__d_year, d_KEY_55cb94e3a380part__p_brand1_encoded, d_aggr0__tmp_attr0, d_date__d_year, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_part__p_brand1_encoded);
//Materialize count
uint64_t* d_COUNT55cb94e4d3d0;
cudaMalloc(&d_COUNT55cb94e4d3d0, sizeof(uint64_t));
cudaMemset(d_COUNT55cb94e4d3d0, 0, sizeof(uint64_t));
count_55cb94ea1e30<<<std::ceil((float)COUNT55cb94e3a380/128.), 128>>>(COUNT55cb94e3a380, d_COUNT55cb94e4d3d0);
uint64_t COUNT55cb94e4d3d0;
cudaMemcpy(&COUNT55cb94e4d3d0, d_COUNT55cb94e4d3d0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX55cb94e4d3d0;
cudaMalloc(&d_MAT_IDX55cb94e4d3d0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX55cb94e4d3d0, 0, sizeof(uint64_t));
auto MAT55cb94e4d3d0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT55cb94e4d3d0);
DBDecimalType* d_MAT55cb94e4d3d0aggr0__tmp_attr0;
cudaMalloc(&d_MAT55cb94e4d3d0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT55cb94e4d3d0);
auto MAT55cb94e4d3d0date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT55cb94e4d3d0);
DBI32Type* d_MAT55cb94e4d3d0date__d_year;
cudaMalloc(&d_MAT55cb94e4d3d0date__d_year, sizeof(DBI32Type) * COUNT55cb94e4d3d0);
auto MAT55cb94e4d3d0part__p_brand1_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT55cb94e4d3d0);
DBI16Type* d_MAT55cb94e4d3d0part__p_brand1_encoded;
cudaMalloc(&d_MAT55cb94e4d3d0part__p_brand1_encoded, sizeof(DBI16Type) * COUNT55cb94e4d3d0);
main_55cb94ea1e30<<<std::ceil((float)COUNT55cb94e3a380/128.), 128>>>(COUNT55cb94e3a380, d_MAT55cb94e4d3d0aggr0__tmp_attr0, d_MAT55cb94e4d3d0date__d_year, d_MAT55cb94e4d3d0part__p_brand1_encoded, d_MAT_IDX55cb94e4d3d0, d_aggr0__tmp_attr0, d_KEY_55cb94e3a380date__d_year, d_KEY_55cb94e3a380part__p_brand1_encoded);
cudaMemcpy(MAT55cb94e4d3d0aggr0__tmp_attr0, d_MAT55cb94e4d3d0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT55cb94e4d3d0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT55cb94e4d3d0date__d_year, d_MAT55cb94e4d3d0date__d_year, sizeof(DBI32Type) * COUNT55cb94e4d3d0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT55cb94e4d3d0part__p_brand1_encoded, d_MAT55cb94e4d3d0part__p_brand1_encoded, sizeof(DBI16Type) * COUNT55cb94e4d3d0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT55cb94e4d3d0; i++) { std::cout << "" << MAT55cb94e4d3d0aggr0__tmp_attr0[i];
std::cout << "," << MAT55cb94e4d3d0date__d_year[i];
std::cout << "," << part__p_brand1_map[MAT55cb94e4d3d0part__p_brand1_encoded[i]];
std::cout << std::endl; }
cudaFree(d_BUF_55cb94e85850);
cudaFree(d_BUF_IDX_55cb94e85850);
cudaFree(d_COUNT55cb94e85850);
cudaFree(d_BUF_55cb94e85910);
cudaFree(d_BUF_IDX_55cb94e85910);
cudaFree(d_COUNT55cb94e85910);
cudaFree(d_BUF_55cb94e80270);
cudaFree(d_BUF_IDX_55cb94e80270);
cudaFree(d_COUNT55cb94e80270);
cudaFree(d_KEY_55cb94e3a380date__d_year);
cudaFree(d_KEY_55cb94e3a380part__p_brand1_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT55cb94e4d3d0);
cudaFree(d_MAT55cb94e4d3d0aggr0__tmp_attr0);
cudaFree(d_MAT55cb94e4d3d0date__d_year);
cudaFree(d_MAT55cb94e4d3d0part__p_brand1_encoded);
cudaFree(d_MAT_IDX55cb94e4d3d0);
free(MAT55cb94e4d3d0aggr0__tmp_attr0);
free(MAT55cb94e4d3d0date__d_year);
free(MAT55cb94e4d3d0part__p_brand1_encoded);
}