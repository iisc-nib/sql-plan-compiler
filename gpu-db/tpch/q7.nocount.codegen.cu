#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT HT_0, DBStringType* n1___n_name, DBI32Type* n1___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n1___n_name = n1___n_name[tid];
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
uint64_t KEY_0 = 0;
auto reg_n1___n_nationkey = n1___n_nationkey[tid];

KEY_0 |= reg_n1___n_nationkey;
// Insert hash table kernel;
auto buf_idx_0 = atomicAdd((int*)BUF_IDX_0, 1);
HT_0.insert(cuco::pair{KEY_0, buf_idx_0});
BUF_0[buf_idx_0 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT>
__global__ void main_3(uint64_t* BUF_2, uint64_t* BUF_IDX_2, HASHTABLE_INSERT HT_2, DBStringType* n2___n_name, DBI32Type* n2___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n2___n_name = n2___n_name[tid];
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
uint64_t KEY_2 = 0;
auto reg_n2___n_nationkey = n2___n_nationkey[tid];

KEY_2 |= reg_n2___n_nationkey;
// Insert hash table kernel;
auto buf_idx_2 = atomicAdd((int*)BUF_IDX_2, 1);
HT_2.insert(cuco::pair{KEY_2, buf_idx_2});
BUF_2[buf_idx_2 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5(uint64_t* BUF_2, uint64_t* BUF_4, uint64_t* BUF_IDX_4, HASHTABLE_PROBE HT_2, HASHTABLE_INSERT HT_4, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_2 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_2 |= reg_customer__c_nationkey;
//Probe Hash table
HT_2.for_each(KEY_2, [&] __device__ (auto const SLOT_2) {
auto const [slot_first2, slot_second2] = SLOT_2;
if (!(true)) return;
uint64_t KEY_4 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_4 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_4 = atomicAdd((int*)BUF_IDX_4, 1);
HT_4.insert(cuco::pair{KEY_4, buf_idx_4});
BUF_4[buf_idx_4 * 2 + 0] = BUF_2[slot_second2 * 1 + 0];
BUF_4[buf_idx_4 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_7(uint64_t* BUF_4, uint64_t* BUF_6, uint64_t* BUF_IDX_6, HASHTABLE_PROBE HT_4, HASHTABLE_INSERT HT_6, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_4 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_4 |= reg_orders__o_custkey;
//Probe Hash table
HT_4.for_each(KEY_4, [&] __device__ (auto const SLOT_4) {
auto const [slot_first4, slot_second4] = SLOT_4;
if (!(true)) return;
uint64_t KEY_6 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_6 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_6 = atomicAdd((int*)BUF_IDX_6, 1);
HT_6.insert(cuco::pair{KEY_6, buf_idx_6});
BUF_6[buf_idx_6 * 3 + 0] = tid;
BUF_6[buf_idx_6 * 3 + 1] = BUF_4[slot_second4 * 2 + 0];
BUF_6[buf_idx_6 * 3 + 2] = BUF_4[slot_second4 * 2 + 1];
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_9(uint64_t* BUF_0, uint64_t* BUF_8, uint64_t* BUF_IDX_8, HASHTABLE_PROBE HT_0, HASHTABLE_INSERT HT_8, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_0 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_0 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_0.for_each(KEY_0, [&] __device__ (auto const SLOT_0) {
auto const [slot_first0, slot_second0] = SLOT_0;
if (!(true)) return;
uint64_t KEY_8 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_8 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_8 = atomicAdd((int*)BUF_IDX_8, 1);
HT_8.insert(cuco::pair{KEY_8, buf_idx_8});
BUF_8[buf_idx_8 * 2 + 0] = tid;
BUF_8[buf_idx_8 * 2 + 1] = BUF_0[slot_second0 * 1 + 0];
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_11(uint64_t* BUF_6, uint64_t* BUF_8, HASHTABLE_FIND HT_10, HASHTABLE_PROBE HT_6, HASHTABLE_PROBE HT_8, DBI64Type* KEY_10map0__tmp_attr0, DBI16Type* KEY_10n1___n_name_encoded, DBI16Type* KEY_10n2___n_name_encoded, int* SLOT_COUNT_10, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBI16Type* n1___n_name_encoded, DBStringType* n2___n_name, DBI16Type* n2___n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9861, Predicate::lte))) return;
uint64_t KEY_6 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_6 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_6.for_each(KEY_6, [&] __device__ (auto const SLOT_6) {
auto const [slot_first6, slot_second6] = SLOT_6;
if (!(true)) return;
uint64_t KEY_8 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_8 |= reg_lineitem__l_suppkey;
//Probe Hash table
HT_8.for_each(KEY_8, [&] __device__ (auto const SLOT_8) {
auto const [slot_first8, slot_second8] = SLOT_8;
auto reg_n1___n_name = n1___n_name[BUF_8[slot_second8 * 2 + 1]];
auto reg_n2___n_name = n2___n_name[BUF_6[slot_second6 * 3 + 1]];
if (!((((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) && (true))) return;
uint64_t KEY_10 = 0;
auto reg_n1___n_name_encoded = n1___n_name_encoded[BUF_8[slot_second8 * 2 + 1]];

KEY_10 |= reg_n1___n_name_encoded;
auto reg_n2___n_name_encoded = n2___n_name_encoded[BUF_6[slot_second6 * 3 + 1]];
KEY_10 <<= 16;
KEY_10 |= reg_n2___n_name_encoded;
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_lineitem__l_shipdate);
KEY_10 <<= 32;
KEY_10 |= (DBI32Type)reg_map0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_10 = get_aggregation_slot(KEY_10, HT_10, SLOT_COUNT_10);
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_10], reg_map0__tmp_attr1);
KEY_10n1___n_name_encoded[buf_idx_10] = reg_n1___n_name_encoded;
KEY_10n2___n_name_encoded[buf_idx_10] = reg_n2___n_name_encoded;
KEY_10map0__tmp_attr0[buf_idx_10] = reg_map0__tmp_attr0;
});
});
}
__global__ void main_13(size_t COUNT10, DBDecimalType* MAT12aggr0__tmp_attr2, DBI64Type* MAT12map0__tmp_attr0, DBI16Type* MAT12n1___n_name_encoded, DBI16Type* MAT12n2___n_name_encoded, uint64_t* MAT_IDX12, DBDecimalType* aggr0__tmp_attr2, DBI64Type* map0__tmp_attr0, DBI16Type* n1___n_name_encoded, DBI16Type* n2___n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT10) return;
//Materialize buffers
auto mat_idx12 = atomicAdd((int*)MAT_IDX12, 1);
auto reg_n1___n_name_encoded = n1___n_name_encoded[tid];
MAT12n1___n_name_encoded[mat_idx12] = reg_n1___n_name_encoded;
auto reg_n2___n_name_encoded = n2___n_name_encoded[tid];
MAT12n2___n_name_encoded[mat_idx12] = reg_n2___n_name_encoded;
auto reg_map0__tmp_attr0 = map0__tmp_attr0[tid];
MAT12map0__tmp_attr0[mat_idx12] = reg_map0__tmp_attr0;
auto reg_aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
MAT12aggr0__tmp_attr2[mat_idx12] = reg_aggr0__tmp_attr2;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map) {
size_t COUNT0 = nation_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_0;
cudaMalloc(&d_BUF_IDX_0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_0, 0, sizeof(uint64_t));
uint64_t* d_BUF_0;
cudaMalloc(&d_BUF_0, sizeof(uint64_t) * COUNT0 * 1);
auto d_HT_0 = cuco::experimental::static_multimap{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)nation_size/128.), 128>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
cudaFree(d_BUF_IDX_0);
size_t COUNT2 = nation_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_2;
cudaMalloc(&d_BUF_IDX_2, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_2, 0, sizeof(uint64_t));
uint64_t* d_BUF_2;
cudaMalloc(&d_BUF_2, sizeof(uint64_t) * COUNT2 * 1);
auto d_HT_2 = cuco::experimental::static_multimap{ (int)COUNT2*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)nation_size/128.), 128>>>(d_BUF_2, d_BUF_IDX_2, d_HT_2.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
cudaFree(d_BUF_IDX_2);
size_t COUNT4 = customer_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_4;
cudaMalloc(&d_BUF_IDX_4, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_4, 0, sizeof(uint64_t));
uint64_t* d_BUF_4;
cudaMalloc(&d_BUF_4, sizeof(uint64_t) * COUNT4 * 2);
auto d_HT_4 = cuco::experimental::static_multimap{ (int)COUNT4*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_2, d_BUF_4, d_BUF_IDX_4, d_HT_2.ref(cuco::for_each), d_HT_4.ref(cuco::insert), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
cudaFree(d_BUF_IDX_4);
size_t COUNT6 = orders_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_6;
cudaMalloc(&d_BUF_IDX_6, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6, 0, sizeof(uint64_t));
uint64_t* d_BUF_6;
cudaMalloc(&d_BUF_6, sizeof(uint64_t) * COUNT6 * 3);
auto d_HT_6 = cuco::experimental::static_multimap{ (int)COUNT6*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_7<<<std::ceil((float)orders_size/128.), 128>>>(d_BUF_4, d_BUF_6, d_BUF_IDX_6, d_HT_4.ref(cuco::for_each), d_HT_6.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderkey, orders_size);
cudaFree(d_BUF_IDX_6);
size_t COUNT8 = supplier_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_8;
cudaMalloc(&d_BUF_IDX_8, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_8, 0, sizeof(uint64_t));
uint64_t* d_BUF_8;
cudaMalloc(&d_BUF_8, sizeof(uint64_t) * COUNT8 * 2);
auto d_HT_8 = cuco::experimental::static_multimap{ (int)COUNT8*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_9<<<std::ceil((float)supplier_size/128.), 128>>>(d_BUF_0, d_BUF_8, d_BUF_IDX_8, d_HT_0.ref(cuco::for_each), d_HT_8.ref(cuco::insert), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
cudaFree(d_BUF_IDX_8);
size_t COUNT10 = 13634;
auto d_HT_10 = cuco::static_map{ (int)13634*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_10;
cudaMalloc(&d_SLOT_COUNT_10, sizeof(int));
cudaMemset(d_SLOT_COUNT_10, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT10);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT10);
DBI16Type* d_KEY_10n1___n_name_encoded;
cudaMalloc(&d_KEY_10n1___n_name_encoded, sizeof(DBI16Type) * COUNT10);
cudaMemset(d_KEY_10n1___n_name_encoded, 0, sizeof(DBI16Type) * COUNT10);
DBI16Type* d_KEY_10n2___n_name_encoded;
cudaMalloc(&d_KEY_10n2___n_name_encoded, sizeof(DBI16Type) * COUNT10);
cudaMemset(d_KEY_10n2___n_name_encoded, 0, sizeof(DBI16Type) * COUNT10);
DBI64Type* d_KEY_10map0__tmp_attr0;
cudaMalloc(&d_KEY_10map0__tmp_attr0, sizeof(DBI64Type) * COUNT10);
cudaMemset(d_KEY_10map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT10);
main_11<<<std::ceil((float)lineitem_size/128.), 128>>>(d_BUF_6, d_BUF_8, d_HT_10.ref(cuco::insert_and_find), d_HT_6.ref(cuco::for_each), d_HT_8.ref(cuco::for_each), d_KEY_10map0__tmp_attr0, d_KEY_10n1___n_name_encoded, d_KEY_10n2___n_name_encoded, d_SLOT_COUNT_10, d_aggr0__tmp_attr2, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name_encoded, d_nation__n_name, d_nation__n_name_encoded);
COUNT10 = d_HT_10.size();
size_t COUNT12 = COUNT10;
//Materialize buffers
uint64_t* d_MAT_IDX12;
cudaMalloc(&d_MAT_IDX12, sizeof(uint64_t));
cudaMemset(d_MAT_IDX12, 0, sizeof(uint64_t));
auto MAT12n1___n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT12);
DBI16Type* d_MAT12n1___n_name_encoded;
cudaMalloc(&d_MAT12n1___n_name_encoded, sizeof(DBI16Type) * COUNT12);
auto MAT12n2___n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT12);
DBI16Type* d_MAT12n2___n_name_encoded;
cudaMalloc(&d_MAT12n2___n_name_encoded, sizeof(DBI16Type) * COUNT12);
auto MAT12map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT12);
DBI64Type* d_MAT12map0__tmp_attr0;
cudaMalloc(&d_MAT12map0__tmp_attr0, sizeof(DBI64Type) * COUNT12);
auto MAT12aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT12);
DBDecimalType* d_MAT12aggr0__tmp_attr2;
cudaMalloc(&d_MAT12aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT12);
main_13<<<std::ceil((float)COUNT10/128.), 128>>>(COUNT10, d_MAT12aggr0__tmp_attr2, d_MAT12map0__tmp_attr0, d_MAT12n1___n_name_encoded, d_MAT12n2___n_name_encoded, d_MAT_IDX12, d_aggr0__tmp_attr2, d_KEY_10map0__tmp_attr0, d_KEY_10n1___n_name_encoded, d_KEY_10n2___n_name_encoded);
cudaMemcpy(MAT12n1___n_name_encoded, d_MAT12n1___n_name_encoded, sizeof(DBI16Type) * COUNT12, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT12n2___n_name_encoded, d_MAT12n2___n_name_encoded, sizeof(DBI16Type) * COUNT12, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT12map0__tmp_attr0, d_MAT12map0__tmp_attr0, sizeof(DBI64Type) * COUNT12, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT12aggr0__tmp_attr2, d_MAT12aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT12, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT12; i++) { std::cout << "" << n1___n_name_map[MAT12n1___n_name_encoded[i]];
std::cout << "," << n2___n_name_map[MAT12n2___n_name_encoded[i]];
std::cout << "," << MAT12map0__tmp_attr0[i];
std::cout << "," << MAT12aggr0__tmp_attr2[i];
std::cout << std::endl; }
cudaFree(d_BUF_0);
cudaFree(d_BUF_IDX_0);
cudaFree(d_BUF_2);
cudaFree(d_BUF_IDX_2);
cudaFree(d_BUF_4);
cudaFree(d_BUF_IDX_4);
cudaFree(d_BUF_6);
cudaFree(d_BUF_IDX_6);
cudaFree(d_BUF_8);
cudaFree(d_BUF_IDX_8);
cudaFree(d_KEY_10map0__tmp_attr0);
cudaFree(d_KEY_10n1___n_name_encoded);
cudaFree(d_KEY_10n2___n_name_encoded);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_MAT12aggr0__tmp_attr2);
cudaFree(d_MAT12map0__tmp_attr0);
cudaFree(d_MAT12n1___n_name_encoded);
cudaFree(d_MAT12n2___n_name_encoded);
cudaFree(d_MAT_IDX12);
free(MAT12aggr0__tmp_attr2);
free(MAT12map0__tmp_attr0);
free(MAT12n1___n_name_encoded);
free(MAT12n2___n_name_encoded);
}