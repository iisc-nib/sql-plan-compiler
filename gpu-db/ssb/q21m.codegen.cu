#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5e61cd9a89e0(uint64_t* COUNT5e61cd998030, DBStringType* part__p_category, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_category = part__p_category[tid];
if (!(evaluatePredicate(reg_part__p_category, "MFGR#12", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5e61cd998030, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5e61cd9a89e0(uint64_t* BUF_5e61cd998030, uint64_t* BUF_IDX_5e61cd998030, HASHTABLE_INSERT HT_5e61cd998030, DBStringType* part__p_category, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_category = part__p_category[tid];
if (!(evaluatePredicate(reg_part__p_category, "MFGR#12", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5e61cd998030 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_5e61cd998030 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_5e61cd998030 = atomicAdd((int*)BUF_IDX_5e61cd998030, 1);
HT_5e61cd998030.insert(cuco::pair{KEY_5e61cd998030, buf_idx_5e61cd998030});
BUF_5e61cd998030[buf_idx_5e61cd998030 * 1 + 0] = tid;
}
__global__ void count_5e61cd9ab480(uint64_t* COUNT5e61cd99dc00, DBStringType* supplier__s_region, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5e61cd99dc00, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5e61cd9ab480(uint64_t* BUF_5e61cd99dc00, uint64_t* BUF_IDX_5e61cd99dc00, HASHTABLE_INSERT HT_5e61cd99dc00, DBStringType* supplier__s_region, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
auto reg_supplier__s_region = supplier__s_region[tid];
if (!(evaluatePredicate(reg_supplier__s_region, "AMERICA", Predicate::eq))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5e61cd99dc00 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5e61cd99dc00 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5e61cd99dc00 = atomicAdd((int*)BUF_IDX_5e61cd99dc00, 1);
HT_5e61cd99dc00.insert(cuco::pair{KEY_5e61cd99dc00, buf_idx_5e61cd99dc00});
BUF_5e61cd99dc00[buf_idx_5e61cd99dc00 * 1 + 0] = tid;
}
__global__ void count_5e61cd981b70(uint64_t* COUNT5e61cd998400, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
//Materialize count
atomicAdd((int*)COUNT5e61cd998400, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5e61cd981b70(uint64_t* BUF_5e61cd998400, uint64_t* BUF_IDX_5e61cd998400, HASHTABLE_INSERT HT_5e61cd998400, DBI32Type* date__d_datekey, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5e61cd998400 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5e61cd998400 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_5e61cd998400 = atomicAdd((int*)BUF_IDX_5e61cd998400, 1);
HT_5e61cd998400.insert(cuco::pair{KEY_5e61cd998400, buf_idx_5e61cd998400});
BUF_5e61cd998400[buf_idx_5e61cd998400 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5e61cd9815a0(uint64_t* BUF_5e61cd998030, uint64_t* BUF_5e61cd998400, uint64_t* BUF_5e61cd99dc00, HASHTABLE_INSERT HT_5e61cd951f30, HASHTABLE_PROBE HT_5e61cd998030, HASHTABLE_PROBE HT_5e61cd998400, HASHTABLE_PROBE HT_5e61cd99dc00, DBI32Type* date__d_year, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5e61cd998030 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5e61cd998030 |= reg_lineorder__lo_partkey;
//Probe Hash table
auto SLOT_5e61cd998030 = HT_5e61cd998030.find(KEY_5e61cd998030);
if (SLOT_5e61cd998030 == HT_5e61cd998030.end()) return;
if (!(true)) return;
uint64_t KEY_5e61cd99dc00 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5e61cd99dc00 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_5e61cd99dc00 = HT_5e61cd99dc00.find(KEY_5e61cd99dc00);
if (SLOT_5e61cd99dc00 == HT_5e61cd99dc00.end()) return;
if (!(true)) return;
uint64_t KEY_5e61cd998400 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5e61cd998400 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_5e61cd998400 = HT_5e61cd998400.find(KEY_5e61cd998400);
if (SLOT_5e61cd998400 == HT_5e61cd998400.end()) return;
if (!(true)) return;
uint64_t KEY_5e61cd951f30 = 0;
auto reg_date__d_year = date__d_year[BUF_5e61cd998400[SLOT_5e61cd998400->second * 1 + 0]];

KEY_5e61cd951f30 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_5e61cd998030[SLOT_5e61cd998030->second * 1 + 0]];
KEY_5e61cd951f30 <<= 16;
KEY_5e61cd951f30 |= reg_part__p_brand1_encoded;
//Create aggregation hash table
HT_5e61cd951f30.insert(cuco::pair{KEY_5e61cd951f30, 1});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5e61cd9815a0(uint64_t* BUF_5e61cd998030, uint64_t* BUF_5e61cd998400, uint64_t* BUF_5e61cd99dc00, HASHTABLE_FIND HT_5e61cd951f30, HASHTABLE_PROBE HT_5e61cd998030, HASHTABLE_PROBE HT_5e61cd998400, HASHTABLE_PROBE HT_5e61cd99dc00, DBI32Type* KEY_5e61cd951f30date__d_year, DBI16Type* KEY_5e61cd951f30part__p_brand1_encoded, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_partkey, DBDecimalType* lineorder__lo_revenue, DBI32Type* lineorder__lo_suppkey, size_t lineorder_size, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
if (!(!(false))) return;
uint64_t KEY_5e61cd998030 = 0;
auto reg_lineorder__lo_partkey = lineorder__lo_partkey[tid];

KEY_5e61cd998030 |= reg_lineorder__lo_partkey;
//Probe Hash table
auto SLOT_5e61cd998030 = HT_5e61cd998030.find(KEY_5e61cd998030);
if (SLOT_5e61cd998030 == HT_5e61cd998030.end()) return;
if (!(true)) return;
uint64_t KEY_5e61cd99dc00 = 0;
auto reg_lineorder__lo_suppkey = lineorder__lo_suppkey[tid];

KEY_5e61cd99dc00 |= reg_lineorder__lo_suppkey;
//Probe Hash table
auto SLOT_5e61cd99dc00 = HT_5e61cd99dc00.find(KEY_5e61cd99dc00);
if (SLOT_5e61cd99dc00 == HT_5e61cd99dc00.end()) return;
if (!(true)) return;
uint64_t KEY_5e61cd998400 = 0;
auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];

KEY_5e61cd998400 |= reg_lineorder__lo_orderdate;
//Probe Hash table
auto SLOT_5e61cd998400 = HT_5e61cd998400.find(KEY_5e61cd998400);
if (SLOT_5e61cd998400 == HT_5e61cd998400.end()) return;
if (!(true)) return;
uint64_t KEY_5e61cd951f30 = 0;
auto reg_date__d_year = date__d_year[BUF_5e61cd998400[SLOT_5e61cd998400->second * 1 + 0]];

KEY_5e61cd951f30 |= reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[BUF_5e61cd998030[SLOT_5e61cd998030->second * 1 + 0]];
KEY_5e61cd951f30 <<= 16;
KEY_5e61cd951f30 |= reg_part__p_brand1_encoded;
//Aggregate in hashtable
auto buf_idx_5e61cd951f30 = HT_5e61cd951f30.find(KEY_5e61cd951f30)->second;
auto reg_lineorder__lo_revenue = lineorder__lo_revenue[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5e61cd951f30], reg_lineorder__lo_revenue);
KEY_5e61cd951f30date__d_year[buf_idx_5e61cd951f30] = reg_date__d_year;
KEY_5e61cd951f30part__p_brand1_encoded[buf_idx_5e61cd951f30] = reg_part__p_brand1_encoded;
}
__global__ void count_5e61cd9ba960(size_t COUNT5e61cd951f30, uint64_t* COUNT5e61cd965460) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5e61cd951f30) return;
//Materialize count
atomicAdd((int*)COUNT5e61cd965460, 1);
}
__global__ void main_5e61cd9ba960(size_t COUNT5e61cd951f30, DBDecimalType* MAT5e61cd965460aggr0__tmp_attr0, DBI32Type* MAT5e61cd965460date__d_year, DBI16Type* MAT5e61cd965460part__p_brand1_encoded, uint64_t* MAT_IDX5e61cd965460, DBDecimalType* aggr0__tmp_attr0, DBI32Type* date__d_year, DBI16Type* part__p_brand1_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5e61cd951f30) return;
//Materialize buffers
auto mat_idx5e61cd965460 = atomicAdd((int*)MAT_IDX5e61cd965460, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5e61cd965460aggr0__tmp_attr0[mat_idx5e61cd965460] = reg_aggr0__tmp_attr0;
auto reg_date__d_year = date__d_year[tid];
MAT5e61cd965460date__d_year[mat_idx5e61cd965460] = reg_date__d_year;
auto reg_part__p_brand1_encoded = part__p_brand1_encoded[tid];
MAT5e61cd965460part__p_brand1_encoded[mat_idx5e61cd965460] = reg_part__p_brand1_encoded;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size, DBI16Type* d_part__p_brand1_encoded, DBI16Type* d_supplier__s_nation_encoded, DBI16Type* d_customer__c_city_encoded, DBI16Type* d_supplier__s_city_encoded, DBI16Type* d_customer__c_nation_encoded, DBI16Type* d_part__p_category_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand1_map, std::unordered_map<DBI16Type, std::string>& supplier__s_nation_map, std::unordered_map<DBI16Type, std::string>& customer__c_city_map, std::unordered_map<DBI16Type, std::string>& supplier__s_city_map, std::unordered_map<DBI16Type, std::string>& customer__c_nation_map, std::unordered_map<DBI16Type, std::string>& part__p_category_map) {
//Materialize count
uint64_t* d_COUNT5e61cd998030;
cudaMalloc(&d_COUNT5e61cd998030, sizeof(uint64_t));
cudaMemset(d_COUNT5e61cd998030, 0, sizeof(uint64_t));
count_5e61cd9a89e0<<<std::ceil((float)part_size/128.), 128>>>(d_COUNT5e61cd998030, d_part__p_category, part_size);
uint64_t COUNT5e61cd998030;
cudaMemcpy(&COUNT5e61cd998030, d_COUNT5e61cd998030, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5e61cd998030;
cudaMalloc(&d_BUF_IDX_5e61cd998030, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5e61cd998030, 0, sizeof(uint64_t));
uint64_t* d_BUF_5e61cd998030;
cudaMalloc(&d_BUF_5e61cd998030, sizeof(uint64_t) * COUNT5e61cd998030 * 1);
auto d_HT_5e61cd998030 = cuco::static_map{ (int)COUNT5e61cd998030*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5e61cd9a89e0<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_5e61cd998030, d_BUF_IDX_5e61cd998030, d_HT_5e61cd998030.ref(cuco::insert), d_part__p_category, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT5e61cd99dc00;
cudaMalloc(&d_COUNT5e61cd99dc00, sizeof(uint64_t));
cudaMemset(d_COUNT5e61cd99dc00, 0, sizeof(uint64_t));
count_5e61cd9ab480<<<std::ceil((float)supplier_size/128.), 128>>>(d_COUNT5e61cd99dc00, d_supplier__s_region, supplier_size);
uint64_t COUNT5e61cd99dc00;
cudaMemcpy(&COUNT5e61cd99dc00, d_COUNT5e61cd99dc00, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5e61cd99dc00;
cudaMalloc(&d_BUF_IDX_5e61cd99dc00, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5e61cd99dc00, 0, sizeof(uint64_t));
uint64_t* d_BUF_5e61cd99dc00;
cudaMalloc(&d_BUF_5e61cd99dc00, sizeof(uint64_t) * COUNT5e61cd99dc00 * 1);
auto d_HT_5e61cd99dc00 = cuco::static_map{ (int)COUNT5e61cd99dc00*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5e61cd9ab480<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_5e61cd99dc00, d_BUF_IDX_5e61cd99dc00, d_HT_5e61cd99dc00.ref(cuco::insert), d_supplier__s_region, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT5e61cd998400;
cudaMalloc(&d_COUNT5e61cd998400, sizeof(uint64_t));
cudaMemset(d_COUNT5e61cd998400, 0, sizeof(uint64_t));
count_5e61cd981b70<<<std::ceil((float)date_size/128.), 128>>>(d_COUNT5e61cd998400, date_size);
uint64_t COUNT5e61cd998400;
cudaMemcpy(&COUNT5e61cd998400, d_COUNT5e61cd998400, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5e61cd998400;
cudaMalloc(&d_BUF_IDX_5e61cd998400, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5e61cd998400, 0, sizeof(uint64_t));
uint64_t* d_BUF_5e61cd998400;
cudaMalloc(&d_BUF_5e61cd998400, sizeof(uint64_t) * COUNT5e61cd998400 * 1);
auto d_HT_5e61cd998400 = cuco::static_map{ (int)COUNT5e61cd998400*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5e61cd981b70<<<std::ceil((float)date_size/128.), 128>>>(d_BUF_5e61cd998400, d_BUF_IDX_5e61cd998400, d_HT_5e61cd998400.ref(cuco::insert), d_date__d_datekey, date_size);
//Create aggregation hash table
auto d_HT_5e61cd951f30 = cuco::static_map{ (int)52974*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5e61cd9815a0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5e61cd998030, d_BUF_5e61cd998400, d_BUF_5e61cd99dc00, d_HT_5e61cd951f30.ref(cuco::insert), d_HT_5e61cd998030.ref(cuco::find), d_HT_5e61cd998400.ref(cuco::find), d_HT_5e61cd99dc00.ref(cuco::find), d_date__d_year, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_suppkey, lineorder_size, d_part__p_brand1_encoded);
size_t COUNT5e61cd951f30 = d_HT_5e61cd951f30.size();
thrust::device_vector<int64_t> keys_5e61cd951f30(COUNT5e61cd951f30), vals_5e61cd951f30(COUNT5e61cd951f30);
d_HT_5e61cd951f30.retrieve_all(keys_5e61cd951f30.begin(), vals_5e61cd951f30.begin());
d_HT_5e61cd951f30.clear();
int64_t* raw_keys5e61cd951f30 = thrust::raw_pointer_cast(keys_5e61cd951f30.data());
insertKeys<<<std::ceil((float)COUNT5e61cd951f30/128.), 128>>>(raw_keys5e61cd951f30, d_HT_5e61cd951f30.ref(cuco::insert), COUNT5e61cd951f30);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5e61cd951f30);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5e61cd951f30);
DBI32Type* d_KEY_5e61cd951f30date__d_year;
cudaMalloc(&d_KEY_5e61cd951f30date__d_year, sizeof(DBI32Type) * COUNT5e61cd951f30);
cudaMemset(d_KEY_5e61cd951f30date__d_year, 0, sizeof(DBI32Type) * COUNT5e61cd951f30);
DBI16Type* d_KEY_5e61cd951f30part__p_brand1_encoded;
cudaMalloc(&d_KEY_5e61cd951f30part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5e61cd951f30);
cudaMemset(d_KEY_5e61cd951f30part__p_brand1_encoded, 0, sizeof(DBI16Type) * COUNT5e61cd951f30);
main_5e61cd9815a0<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5e61cd998030, d_BUF_5e61cd998400, d_BUF_5e61cd99dc00, d_HT_5e61cd951f30.ref(cuco::find), d_HT_5e61cd998030.ref(cuco::find), d_HT_5e61cd998400.ref(cuco::find), d_HT_5e61cd99dc00.ref(cuco::find), d_KEY_5e61cd951f30date__d_year, d_KEY_5e61cd951f30part__p_brand1_encoded, d_aggr0__tmp_attr0, d_date__d_year, d_lineorder__lo_orderdate, d_lineorder__lo_partkey, d_lineorder__lo_revenue, d_lineorder__lo_suppkey, lineorder_size, d_part__p_brand1_encoded);
//Materialize count
uint64_t* d_COUNT5e61cd965460;
cudaMalloc(&d_COUNT5e61cd965460, sizeof(uint64_t));
cudaMemset(d_COUNT5e61cd965460, 0, sizeof(uint64_t));
count_5e61cd9ba960<<<std::ceil((float)COUNT5e61cd951f30/128.), 128>>>(COUNT5e61cd951f30, d_COUNT5e61cd965460);
uint64_t COUNT5e61cd965460;
cudaMemcpy(&COUNT5e61cd965460, d_COUNT5e61cd965460, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5e61cd965460;
cudaMalloc(&d_MAT_IDX5e61cd965460, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5e61cd965460, 0, sizeof(uint64_t));
auto MAT5e61cd965460aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5e61cd965460);
DBDecimalType* d_MAT5e61cd965460aggr0__tmp_attr0;
cudaMalloc(&d_MAT5e61cd965460aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5e61cd965460);
auto MAT5e61cd965460date__d_year = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5e61cd965460);
DBI32Type* d_MAT5e61cd965460date__d_year;
cudaMalloc(&d_MAT5e61cd965460date__d_year, sizeof(DBI32Type) * COUNT5e61cd965460);
auto MAT5e61cd965460part__p_brand1_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5e61cd965460);
DBI16Type* d_MAT5e61cd965460part__p_brand1_encoded;
cudaMalloc(&d_MAT5e61cd965460part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5e61cd965460);
main_5e61cd9ba960<<<std::ceil((float)COUNT5e61cd951f30/128.), 128>>>(COUNT5e61cd951f30, d_MAT5e61cd965460aggr0__tmp_attr0, d_MAT5e61cd965460date__d_year, d_MAT5e61cd965460part__p_brand1_encoded, d_MAT_IDX5e61cd965460, d_aggr0__tmp_attr0, d_KEY_5e61cd951f30date__d_year, d_KEY_5e61cd951f30part__p_brand1_encoded);
cudaMemcpy(MAT5e61cd965460aggr0__tmp_attr0, d_MAT5e61cd965460aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5e61cd965460, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5e61cd965460date__d_year, d_MAT5e61cd965460date__d_year, sizeof(DBI32Type) * COUNT5e61cd965460, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5e61cd965460part__p_brand1_encoded, d_MAT5e61cd965460part__p_brand1_encoded, sizeof(DBI16Type) * COUNT5e61cd965460, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5e61cd965460; i++) { std::cout << "" << MAT5e61cd965460aggr0__tmp_attr0[i];
std::cout << "," << MAT5e61cd965460date__d_year[i];
std::cout << "," << part__p_brand1_map[MAT5e61cd965460part__p_brand1_encoded[i]];
std::cout << std::endl; }
cudaFree(d_BUF_5e61cd998030);
cudaFree(d_BUF_IDX_5e61cd998030);
cudaFree(d_COUNT5e61cd998030);
cudaFree(d_BUF_5e61cd99dc00);
cudaFree(d_BUF_IDX_5e61cd99dc00);
cudaFree(d_COUNT5e61cd99dc00);
cudaFree(d_BUF_5e61cd998400);
cudaFree(d_BUF_IDX_5e61cd998400);
cudaFree(d_COUNT5e61cd998400);
cudaFree(d_KEY_5e61cd951f30date__d_year);
cudaFree(d_KEY_5e61cd951f30part__p_brand1_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5e61cd965460);
cudaFree(d_MAT5e61cd965460aggr0__tmp_attr0);
cudaFree(d_MAT5e61cd965460date__d_year);
cudaFree(d_MAT5e61cd965460part__p_brand1_encoded);
cudaFree(d_MAT_IDX5e61cd965460);
free(MAT5e61cd965460aggr0__tmp_attr0);
free(MAT5e61cd965460date__d_year);
free(MAT5e61cd965460part__p_brand1_encoded);
}