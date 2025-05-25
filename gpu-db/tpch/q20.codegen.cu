#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
#include <chrono>
__global__ void count_1(uint64_t* COUNT0, DBStringType* part__p_name, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_name = part__p_name[tid];
if (!(Like(reg_part__p_name, "forest", "", nullptr, nullptr, 0))) return;
//Materialize count
atomicAdd((int*)COUNT0, 1);
}
template<typename HASHTABLE_INSERT_SJ>
__global__ void main_1(HASHTABLE_INSERT_SJ HT_0, DBStringType* part__p_name, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
auto reg_part__p_name = part__p_name[tid];
if (!(Like(reg_part__p_name, "forest", "", nullptr, nullptr, 0))) return;
uint64_t KEY_0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_0 |= reg_part__p_partkey;
// Insert hash table kernel;
HT_0.insert(cuco::pair{KEY_0, 1});
}
template<typename HASHTABLE_PROBE_SJ>
__global__ void count_3(uint64_t* COUNT2, HASHTABLE_PROBE_SJ HT_0, DBI32Type* partsupp__ps_partkey, size_t partsupp_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= partsupp_size) return;
uint64_t KEY_0 = 0;
auto reg_partsupp__ps_partkey = partsupp__ps_partkey[tid];

KEY_0 |= reg_partsupp__ps_partkey;
//Probe Hash table
auto SLOT_0 = HT_0.find(KEY_0);
if (SLOT_0 == HT_0.end()) return;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT2, 1);
}
template<typename HASHTABLE_PROBE_SJ, typename HASHTABLE_INSERT_PK>
__global__ void main_3(uint64_t* BUF_2, uint64_t* BUF_IDX_2, HASHTABLE_PROBE_SJ HT_0, HASHTABLE_INSERT_PK HT_2, DBI32Type* partsupp__ps_partkey, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= partsupp_size) return;
uint64_t KEY_0 = 0;
auto reg_partsupp__ps_partkey = partsupp__ps_partkey[tid];

KEY_0 |= reg_partsupp__ps_partkey;
//Probe Hash table
auto SLOT_0 = HT_0.find(KEY_0);
if (SLOT_0 == HT_0.end()) return;
if (!(true)) return;
uint64_t KEY_2 = 0;
auto reg_partsupp__ps_suppkey = partsupp__ps_suppkey[tid];

KEY_2 |= reg_partsupp__ps_suppkey;
KEY_2 <<= 32;
KEY_2 |= reg_partsupp__ps_partkey;
// Insert hash table kernel;
auto buf_idx_2 = atomicAdd((int*)BUF_IDX_2, 1);
HT_2.insert(cuco::pair{KEY_2, buf_idx_2});
BUF_2[buf_idx_2 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE_PK, typename HASHTABLE_INSERT>
__global__ void count_5(uint64_t* BUF_2, HASHTABLE_PROBE_PK HT_2, HASHTABLE_INSERT HT_4, DBI32Type* lineitem__l_partkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 8766, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::lt))) return;
uint64_t KEY_2 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_2 |= reg_lineitem__l_suppkey;
auto reg_lineitem__l_partkey = lineitem__l_partkey[tid];
KEY_2 <<= 32;
KEY_2 |= reg_lineitem__l_partkey;
//Probe Hash table
auto SLOT_2 = HT_2.find(KEY_2);
if (SLOT_2 == HT_2.end()) return;
if (!(true)) return;
uint64_t KEY_4 = 0;

KEY_4 |= reg_lineitem__l_suppkey;
KEY_4 <<= 32;
KEY_4 |= reg_lineitem__l_partkey;
//Create aggregation hash table
HT_4.insert(cuco::pair{KEY_4, 1});
}
template<typename HASHTABLE_PROBE_PK, typename HASHTABLE_FIND>
__global__ void main_5(uint64_t* BUF_2, HASHTABLE_PROBE_PK HT_2, HASHTABLE_FIND HT_4, DBI32Type* KEY_4lineitem__l_partkey, DBI32Type* KEY_4lineitem__l_suppkey, DBDecimalType* aggr0__tmp_attr0, DBI32Type* lineitem__l_partkey, DBDecimalType* lineitem__l_quantity, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBI32Type* moved_aggr__ps_suppkey, DBI32Type* moved_aggr_u_1__ps_partkey, DBI32Type* moved_aggr_u_2__ps_availqty, DBI32Type* partsupp__ps_availqty, DBI32Type* partsupp__ps_partkey, DBI32Type* partsupp__ps_suppkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 8766, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::lt))) return;
uint64_t KEY_2 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_2 |= reg_lineitem__l_suppkey;
auto reg_lineitem__l_partkey = lineitem__l_partkey[tid];
KEY_2 <<= 32;
KEY_2 |= reg_lineitem__l_partkey;
//Probe Hash table
auto SLOT_2 = HT_2.find(KEY_2);
if (SLOT_2 == HT_2.end()) return;
if (!(true)) return;
uint64_t KEY_4 = 0;

KEY_4 |= reg_lineitem__l_suppkey;
KEY_4 <<= 32;
KEY_4 |= reg_lineitem__l_partkey;
//Aggregate in hashtable
auto buf_idx_4 = HT_4.find(KEY_4)->second;
auto reg_lineitem__l_quantity = lineitem__l_quantity[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_4], reg_lineitem__l_quantity);
auto reg_partsupp__ps_suppkey = partsupp__ps_suppkey[BUF_2[SLOT_2->second * 1 + 0]];
aggregate_any(&moved_aggr__ps_suppkey[buf_idx_4], reg_partsupp__ps_suppkey);
auto reg_partsupp__ps_partkey = partsupp__ps_partkey[BUF_2[SLOT_2->second * 1 + 0]];
aggregate_any(&moved_aggr_u_1__ps_partkey[buf_idx_4], reg_partsupp__ps_partkey);
auto reg_partsupp__ps_availqty = partsupp__ps_availqty[BUF_2[SLOT_2->second * 1 + 0]];
aggregate_any(&moved_aggr_u_2__ps_availqty[buf_idx_4], reg_partsupp__ps_availqty);
KEY_4lineitem__l_suppkey[buf_idx_4] = reg_lineitem__l_suppkey;
KEY_4lineitem__l_partkey[buf_idx_4] = reg_lineitem__l_partkey;
}
__global__ void count_7(uint64_t* COUNT6, DBStringType* nation__n_name, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_nation__n_name = nation__n_name[tid];
if (!(evaluatePredicate(reg_nation__n_name, "CANADA", Predicate::eq))) return;
//Materialize count
atomicAdd((int*)COUNT6, 1);
}
template<typename HASHTABLE_INSERT_PK>
__global__ void main_7(uint64_t* BUF_6, uint64_t* BUF_IDX_6, HASHTABLE_INSERT_PK HT_6, DBStringType* nation__n_name, DBI32Type* nation__n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_nation__n_name = nation__n_name[tid];
if (!(evaluatePredicate(reg_nation__n_name, "CANADA", Predicate::eq))) return;
uint64_t KEY_6 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_6 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_6 = atomicAdd((int*)BUF_IDX_6, 1);
HT_6.insert(cuco::pair{KEY_6, buf_idx_6});
BUF_6[buf_idx_6 * 1 + 0] = tid;
}
__global__ void count_9(size_t COUNT4, uint64_t* COUNT8, DBDecimalType* aggr0__tmp_attr0, DBI32Type* moved_aggr__ps_suppkey, DBI32Type* moved_aggr_u_1__ps_partkey, DBI32Type* moved_aggr_u_2__ps_availqty) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT4) return;
if (!(!(false))) return;
auto reg_partsupp__ps_availqty = moved_aggr_u_2__ps_availqty[tid];
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
auto reg_map0__tmp_attr1 = (0.5) * (reg_aggr0__tmp_attr0);
if (!(((true) && (evaluatePredicate(((DBDecimalType)reg_partsupp__ps_availqty), reg_map0__tmp_attr1, Predicate::gt))) && (true))) return;
//Materialize count
atomicAdd((int*)COUNT8, 1);
}
template<typename HASHTABLE_INSERT_SJ>
__global__ void main_9(size_t COUNT4, HASHTABLE_INSERT_SJ HT_8, DBDecimalType* aggr0__tmp_attr0, DBI32Type* moved_aggr__ps_suppkey, DBI32Type* moved_aggr_u_1__ps_partkey, DBI32Type* moved_aggr_u_2__ps_availqty) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT4) return;
if (!(!(false))) return;
auto reg_partsupp__ps_availqty = moved_aggr_u_2__ps_availqty[tid];
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
auto reg_map0__tmp_attr1 = (0.5) * (reg_aggr0__tmp_attr0);
if (!(((true) && (evaluatePredicate(((DBDecimalType)reg_partsupp__ps_availqty), reg_map0__tmp_attr1, Predicate::gt))) && (true))) return;
uint64_t KEY_8 = 0;
auto reg_partsupp__ps_suppkey = moved_aggr__ps_suppkey[tid];

KEY_8 |= reg_partsupp__ps_suppkey;
// Insert hash table kernel;
HT_8.insert(cuco::pair{KEY_8, 1});
}
template<typename HASHTABLE_PROBE_PK, typename HASHTABLE_PROBE_SJ>
__global__ void count_11(uint64_t* BUF_6, uint64_t* COUNT10, HASHTABLE_PROBE_PK HT_6, HASHTABLE_PROBE_SJ HT_8, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_6 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_6 |= reg_supplier__s_nationkey;
//Probe Hash table
auto SLOT_6 = HT_6.find(KEY_6);
if (SLOT_6 == HT_6.end()) return;
if (!(true)) return;
uint64_t KEY_8 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_8 |= reg_supplier__s_suppkey;
//Probe Hash table
auto SLOT_8 = HT_8.find(KEY_8);
if (SLOT_8 == HT_8.end()) return;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT10, 1);
}
template<typename HASHTABLE_PROBE_PK, typename HASHTABLE_PROBE_SJ>
__global__ void main_11(uint64_t* BUF_6, HASHTABLE_PROBE_PK HT_6, HASHTABLE_PROBE_SJ HT_8, DBI16Type* MAT10supplier__s_address_encoded, DBI16Type* MAT10supplier__s_name_encoded, uint64_t* MAT_IDX10, DBI16Type* supplier__s_address_encoded, DBI16Type* supplier__s_name_encoded, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_6 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_6 |= reg_supplier__s_nationkey;
//Probe Hash table
auto SLOT_6 = HT_6.find(KEY_6);
if (SLOT_6 == HT_6.end()) return;
if (!(true)) return;
uint64_t KEY_8 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_8 |= reg_supplier__s_suppkey;
//Probe Hash table
auto SLOT_8 = HT_8.find(KEY_8);
if (SLOT_8 == HT_8.end()) return;
if (!(true)) return;
//Materialize buffers
auto mat_idx10 = atomicAdd((int*)MAT_IDX10, 1);
auto reg_supplier__s_name_encoded = supplier__s_name_encoded[tid];
MAT10supplier__s_name_encoded[mat_idx10] = reg_supplier__s_name_encoded;
auto reg_supplier__s_address_encoded = supplier__s_address_encoded[tid];
MAT10supplier__s_address_encoded[mat_idx10] = reg_supplier__s_address_encoded;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto start = std::chrono::high_resolution_clock::now();
//Materialize count
uint64_t* d_COUNT0;
cudaMalloc(&d_COUNT0, sizeof(uint64_t));
cudaMemset(d_COUNT0, 0, sizeof(uint64_t));
count_1<<<std::ceil((float)part_size/128.), 128>>>(d_COUNT0, d_part__p_name, part_size);
uint64_t COUNT0;
cudaMemcpy(&COUNT0, d_COUNT0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
auto d_HT_0 = cuco::static_map{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)part_size/128.), 128>>>(d_HT_0.ref(cuco::insert), d_part__p_name, d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT2;
cudaMalloc(&d_COUNT2, sizeof(uint64_t));
cudaMemset(d_COUNT2, 0, sizeof(uint64_t));
count_3<<<std::ceil((float)partsupp_size/128.), 128>>>(d_COUNT2, d_HT_0.ref(cuco::find), d_partsupp__ps_partkey, partsupp_size);
uint64_t COUNT2;
cudaMemcpy(&COUNT2, d_COUNT2, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_2;
cudaMalloc(&d_BUF_IDX_2, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_2, 0, sizeof(uint64_t));
uint64_t* d_BUF_2;
cudaMalloc(&d_BUF_2, sizeof(uint64_t) * COUNT2 * 1);
auto d_HT_2 = cuco::static_map{ (int)COUNT2*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)partsupp_size/128.), 128>>>(d_BUF_2, d_BUF_IDX_2, d_HT_0.ref(cuco::find), d_HT_2.ref(cuco::insert), d_partsupp__ps_partkey, d_partsupp__ps_suppkey, partsupp_size);
//Create aggregation hash table
auto d_HT_4 = cuco::static_map{ (int)861503*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5<<<std::ceil((float)lineitem_size/128.), 128>>>(d_BUF_2, d_HT_2.ref(cuco::find), d_HT_4.ref(cuco::insert), d_lineitem__l_partkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size);
size_t COUNT4 = d_HT_4.size();
thrust::device_vector<int64_t> keys_4(COUNT4), vals_4(COUNT4);
d_HT_4.retrieve_all(keys_4.begin(), vals_4.begin());
d_HT_4.clear();
int64_t* raw_keys4 = thrust::raw_pointer_cast(keys_4.data());
insertKeys<<<std::ceil((float)COUNT4/128.), 128>>>(raw_keys4, d_HT_4.ref(cuco::insert), COUNT4);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT4);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT4);
DBI32Type* d_moved_aggr__ps_suppkey;
cudaMalloc(&d_moved_aggr__ps_suppkey, sizeof(DBI32Type) * COUNT4);
cudaMemset(d_moved_aggr__ps_suppkey, 0, sizeof(DBI32Type) * COUNT4);
DBI32Type* d_moved_aggr_u_1__ps_partkey;
cudaMalloc(&d_moved_aggr_u_1__ps_partkey, sizeof(DBI32Type) * COUNT4);
cudaMemset(d_moved_aggr_u_1__ps_partkey, 0, sizeof(DBI32Type) * COUNT4);
DBI32Type* d_moved_aggr_u_2__ps_availqty;
cudaMalloc(&d_moved_aggr_u_2__ps_availqty, sizeof(DBI32Type) * COUNT4);
cudaMemset(d_moved_aggr_u_2__ps_availqty, 0, sizeof(DBI32Type) * COUNT4);
DBI32Type* d_KEY_4lineitem__l_suppkey;
cudaMalloc(&d_KEY_4lineitem__l_suppkey, sizeof(DBI32Type) * COUNT4);
cudaMemset(d_KEY_4lineitem__l_suppkey, 0, sizeof(DBI32Type) * COUNT4);
DBI32Type* d_KEY_4lineitem__l_partkey;
cudaMalloc(&d_KEY_4lineitem__l_partkey, sizeof(DBI32Type) * COUNT4);
cudaMemset(d_KEY_4lineitem__l_partkey, 0, sizeof(DBI32Type) * COUNT4);
main_5<<<std::ceil((float)lineitem_size/128.), 128>>>(d_BUF_2, d_HT_2.ref(cuco::find), d_HT_4.ref(cuco::find), d_KEY_4lineitem__l_partkey, d_KEY_4lineitem__l_suppkey, d_aggr0__tmp_attr0, d_lineitem__l_partkey, d_lineitem__l_quantity, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_moved_aggr__ps_suppkey, d_moved_aggr_u_1__ps_partkey, d_moved_aggr_u_2__ps_availqty, d_partsupp__ps_availqty, d_partsupp__ps_partkey, d_partsupp__ps_suppkey);
//Materialize count
uint64_t* d_COUNT6;
cudaMalloc(&d_COUNT6, sizeof(uint64_t));
cudaMemset(d_COUNT6, 0, sizeof(uint64_t));
count_7<<<std::ceil((float)nation_size/128.), 128>>>(d_COUNT6, d_nation__n_name, nation_size);
uint64_t COUNT6;
cudaMemcpy(&COUNT6, d_COUNT6, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_6;
cudaMalloc(&d_BUF_IDX_6, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6, 0, sizeof(uint64_t));
uint64_t* d_BUF_6;
cudaMalloc(&d_BUF_6, sizeof(uint64_t) * COUNT6 * 1);
auto d_HT_6 = cuco::static_map{ (int)COUNT6*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_7<<<std::ceil((float)nation_size/128.), 128>>>(d_BUF_6, d_BUF_IDX_6, d_HT_6.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
//Materialize count
uint64_t* d_COUNT8;
cudaMalloc(&d_COUNT8, sizeof(uint64_t));
cudaMemset(d_COUNT8, 0, sizeof(uint64_t));
count_9<<<std::ceil((float)COUNT4/128.), 128>>>(COUNT4, d_COUNT8, d_aggr0__tmp_attr0, d_moved_aggr__ps_suppkey, d_moved_aggr_u_1__ps_partkey, d_moved_aggr_u_2__ps_availqty);
uint64_t COUNT8;
cudaMemcpy(&COUNT8, d_COUNT8, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
auto d_HT_8 = cuco::static_map{ (int)COUNT8*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_9<<<std::ceil((float)COUNT4/128.), 128>>>(COUNT4, d_HT_8.ref(cuco::insert), d_aggr0__tmp_attr0, d_moved_aggr__ps_suppkey, d_moved_aggr_u_1__ps_partkey, d_moved_aggr_u_2__ps_availqty);
//Materialize count
uint64_t* d_COUNT10;
cudaMalloc(&d_COUNT10, sizeof(uint64_t));
cudaMemset(d_COUNT10, 0, sizeof(uint64_t));
count_11<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_6, d_COUNT10, d_HT_6.ref(cuco::find), d_HT_8.ref(cuco::find), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
uint64_t COUNT10;
cudaMemcpy(&COUNT10, d_COUNT10, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX10;
cudaMalloc(&d_MAT_IDX10, sizeof(uint64_t));
cudaMemset(d_MAT_IDX10, 0, sizeof(uint64_t));
auto MAT10supplier__s_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT10);
DBI16Type* d_MAT10supplier__s_name_encoded;
cudaMalloc(&d_MAT10supplier__s_name_encoded, sizeof(DBI16Type) * COUNT10);
auto MAT10supplier__s_address_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT10);
DBI16Type* d_MAT10supplier__s_address_encoded;
cudaMalloc(&d_MAT10supplier__s_address_encoded, sizeof(DBI16Type) * COUNT10);
main_11<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_6, d_HT_6.ref(cuco::find), d_HT_8.ref(cuco::find), d_MAT10supplier__s_address_encoded, d_MAT10supplier__s_name_encoded, d_MAT_IDX10, d_supplier__s_address_encoded, d_supplier__s_name_encoded, d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
cudaMemcpy(MAT10supplier__s_name_encoded, d_MAT10supplier__s_name_encoded, sizeof(DBI16Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10supplier__s_address_encoded, d_MAT10supplier__s_address_encoded, sizeof(DBI16Type) * COUNT10, cudaMemcpyDeviceToHost);
auto end = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
std::clog << "Query execution time: " << duration.count() / 1000. << " milliseconds." << std::endl;

for (auto i=0ull; i < COUNT10; i++) { std::cout << "" << supplier__s_name_map[MAT10supplier__s_name_encoded[i]];
std::cout << "|" << supplier__s_address_map[MAT10supplier__s_address_encoded[i]];
std::cout << std::endl; }
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_COUNT0);
cudaFree(d_BUF_2);
cudaFree(d_BUF_IDX_2);
cudaFree(d_COUNT2);
cudaFree(d_KEY_4lineitem__l_partkey);
cudaFree(d_KEY_4lineitem__l_suppkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_moved_aggr__ps_suppkey);
cudaFree(d_moved_aggr_u_1__ps_partkey);
cudaFree(d_moved_aggr_u_2__ps_availqty);
cudaFree(d_BUF_6);
cudaFree(d_BUF_IDX_6);
cudaFree(d_COUNT6);
cudaFree(d_COUNT8);
cudaFree(d_COUNT10);
cudaFree(d_MAT10supplier__s_address_encoded);
cudaFree(d_MAT10supplier__s_name_encoded);
cudaFree(d_MAT_IDX10);
free(MAT10supplier__s_address_encoded);
free(MAT10supplier__s_name_encoded);
}