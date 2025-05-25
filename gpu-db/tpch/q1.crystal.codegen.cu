#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
#include <chrono>
#define ITEMS_PER_THREAD 4
#define TILE_SIZE 512
#define TB TILE_SIZE/ITEMS_PER_THREAD
template<typename HASHTABLE_INSERT>
__global__ void count_1(HASHTABLE_INSERT HT_0, DBCharType* lineitem__l_linestatus, DBCharType* lineitem__l_returnflag, DBDateType* lineitem__l_shipdate, size_t lineitem_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBDateType reg_lineitem__l_shipdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_shipdate[ITEM] = lineitem__l_shipdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_shipdate[ITEM], 10471, Predicate::lte);
}
uint64_t KEY_0[ITEMS_PER_THREAD];
DBCharType reg_lineitem__l_returnflag[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_returnflag[ITEM] = lineitem__l_returnflag[ITEM*TB + tid];
}
DBCharType reg_lineitem__l_linestatus[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_linestatus[ITEM] = lineitem__l_linestatus[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_0[ITEM] = 0;
KEY_0[ITEM] |= reg_lineitem__l_returnflag[ITEM];
KEY_0[ITEM] <<= 8;
KEY_0[ITEM] |= reg_lineitem__l_linestatus[ITEM];
}
//Create aggregation hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_0.insert(cuco::pair{KEY_0[ITEM], 1});
}
}
template<typename HASHTABLE_FIND>
__global__ void main_1(HASHTABLE_FIND HT_0, DBCharType* KEY_0lineitem__l_linestatus, DBCharType* KEY_0lineitem__l_returnflag, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr0__tmp_attr1, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* aggr0__tmp_attr4, DBI64Type* aggr0__tmp_attr9, DBDecimalType* aggr_rw__rw0, DBI64Type* aggr_rw__rw1, DBDecimalType* aggr_rw__rw2, DBI64Type* aggr_rw__rw3, DBDecimalType* aggr_rw__rw4, DBI64Type* aggr_rw__rw5, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBCharType* lineitem__l_linestatus, DBDecimalType* lineitem__l_quantity, DBCharType* lineitem__l_returnflag, DBDateType* lineitem__l_shipdate, DBDecimalType* lineitem__l_tax, size_t lineitem_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBDateType reg_lineitem__l_shipdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_shipdate[ITEM] = lineitem__l_shipdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_shipdate[ITEM], 10471, Predicate::lte);
}
uint64_t KEY_0[ITEMS_PER_THREAD];
DBCharType reg_lineitem__l_returnflag[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_returnflag[ITEM] = lineitem__l_returnflag[ITEM*TB + tid];
}
DBCharType reg_lineitem__l_linestatus[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_linestatus[ITEM] = lineitem__l_linestatus[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_0[ITEM] = 0;
KEY_0[ITEM] |= reg_lineitem__l_returnflag[ITEM];
KEY_0[ITEM] <<= 8;
KEY_0[ITEM] |= reg_lineitem__l_linestatus[ITEM];
}
//Aggregate in hashtable
DBDecimalType reg_lineitem__l_tax[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_tax[ITEM] = lineitem__l_tax[ITEM*TB + tid];
}
DBDecimalType reg_lineitem__l_discount[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_discount[ITEM] = lineitem__l_discount[ITEM*TB + tid];
}
DBDecimalType reg_lineitem__l_extendedprice[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_extendedprice[ITEM] = lineitem__l_extendedprice[ITEM*TB + tid];
}
DBDecimalType reg_map0__tmp_attr5[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr5[ITEM] = ((reg_lineitem__l_extendedprice[ITEM]) * ((1.0) - (reg_lineitem__l_discount[ITEM]))) * ((1.0) + (reg_lineitem__l_tax[ITEM]));
}
DBDecimalType reg_map0__tmp_attr3[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr3[ITEM] = (reg_lineitem__l_extendedprice[ITEM]) * ((1.0) - (reg_lineitem__l_discount[ITEM]));
}
DBDecimalType reg_lineitem__l_quantity[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_quantity[ITEM] = lineitem__l_quantity[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_0 = HT_0.find(KEY_0[ITEM])->second;
aggregate_sum(&aggr0__tmp_attr9[buf_idx_0], 1);
aggregate_sum(&aggr0__tmp_attr4[buf_idx_0], reg_map0__tmp_attr5[ITEM]);
aggregate_sum(&aggr0__tmp_attr2[buf_idx_0], reg_map0__tmp_attr3[ITEM]);
aggregate_sum(&aggr0__tmp_attr1[buf_idx_0], reg_lineitem__l_extendedprice[ITEM]);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_0], reg_lineitem__l_quantity[ITEM]);
aggregate_sum(&aggr_rw__rw0[buf_idx_0], reg_lineitem__l_discount[ITEM]);
aggregate_sum(&aggr_rw__rw1[buf_idx_0], 1);
aggregate_sum(&aggr_rw__rw2[buf_idx_0], reg_lineitem__l_extendedprice[ITEM]);
aggregate_sum(&aggr_rw__rw3[buf_idx_0], 1);
aggregate_sum(&aggr_rw__rw4[buf_idx_0], reg_lineitem__l_quantity[ITEM]);
aggregate_sum(&aggr_rw__rw5[buf_idx_0], 1);
KEY_0lineitem__l_returnflag[buf_idx_0] = reg_lineitem__l_returnflag[ITEM];
KEY_0lineitem__l_linestatus[buf_idx_0] = reg_lineitem__l_linestatus[ITEM];
}
}
__global__ void count_3(size_t COUNT0, uint64_t* COUNT2) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT2, 1);
}
}
__global__ void main_3(size_t COUNT0, DBDecimalType* MAT2aggr0__tmp_attr0, DBDecimalType* MAT2aggr0__tmp_attr1, DBDecimalType* MAT2aggr0__tmp_attr2, DBDecimalType* MAT2aggr0__tmp_attr4, DBDecimalType* MAT2aggr0__tmp_attr6, DBDecimalType* MAT2aggr0__tmp_attr7, DBDecimalType* MAT2aggr0__tmp_attr8, DBI64Type* MAT2aggr0__tmp_attr9, DBCharType* MAT2lineitem__l_linestatus, DBCharType* MAT2lineitem__l_returnflag, uint64_t* MAT_IDX2, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr0__tmp_attr1, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* aggr0__tmp_attr4, DBI64Type* aggr0__tmp_attr9, DBDecimalType* aggr_rw__rw0, DBI64Type* aggr_rw__rw1, DBDecimalType* aggr_rw__rw2, DBI64Type* aggr_rw__rw3, DBDecimalType* aggr_rw__rw4, DBI64Type* aggr_rw__rw5, DBCharType* lineitem__l_linestatus, DBCharType* lineitem__l_returnflag) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize buffers
DBCharType reg_lineitem__l_returnflag[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_lineitem__l_returnflag[ITEM] = lineitem__l_returnflag[ITEM*TB + tid];
}
DBCharType reg_lineitem__l_linestatus[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_lineitem__l_linestatus[ITEM] = lineitem__l_linestatus[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_aggr0__tmp_attr1[ITEM] = aggr0__tmp_attr1[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_aggr0__tmp_attr2[ITEM] = aggr0__tmp_attr2[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr4[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_aggr0__tmp_attr4[ITEM] = aggr0__tmp_attr4[ITEM*TB + tid];
}
DBI64Type reg_aggr_rw__rw5[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_aggr_rw__rw5[ITEM] = aggr_rw__rw5[ITEM*TB + tid];
}
DBDecimalType reg_aggr_rw__rw4[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_aggr_rw__rw4[ITEM] = aggr_rw__rw4[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr6[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_aggr0__tmp_attr6[ITEM] = (reg_aggr_rw__rw4[ITEM]) / ((DBDecimalType)(reg_aggr_rw__rw5[ITEM]));
}
DBI64Type reg_aggr_rw__rw3[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_aggr_rw__rw3[ITEM] = aggr_rw__rw3[ITEM*TB + tid];
}
DBDecimalType reg_aggr_rw__rw2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_aggr_rw__rw2[ITEM] = aggr_rw__rw2[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr7[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_aggr0__tmp_attr7[ITEM] = (reg_aggr_rw__rw2[ITEM]) / ((DBDecimalType)(reg_aggr_rw__rw3[ITEM]));
}
DBI64Type reg_aggr_rw__rw1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_aggr_rw__rw1[ITEM] = aggr_rw__rw1[ITEM*TB + tid];
}
DBDecimalType reg_aggr_rw__rw0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_aggr_rw__rw0[ITEM] = aggr_rw__rw0[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr8[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_aggr0__tmp_attr8[ITEM] = (reg_aggr_rw__rw0[ITEM]) / ((DBDecimalType)(reg_aggr_rw__rw1[ITEM]));
}
DBI64Type reg_aggr0__tmp_attr9[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
reg_aggr0__tmp_attr9[ITEM] = aggr0__tmp_attr9[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT0); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx2 = atomicAdd((int*)MAT_IDX2, 1);
MAT2lineitem__l_returnflag[mat_idx2] = reg_lineitem__l_returnflag[ITEM];
MAT2lineitem__l_linestatus[mat_idx2] = reg_lineitem__l_linestatus[ITEM];
MAT2aggr0__tmp_attr0[mat_idx2] = reg_aggr0__tmp_attr0[ITEM];
MAT2aggr0__tmp_attr1[mat_idx2] = reg_aggr0__tmp_attr1[ITEM];
MAT2aggr0__tmp_attr2[mat_idx2] = reg_aggr0__tmp_attr2[ITEM];
MAT2aggr0__tmp_attr4[mat_idx2] = reg_aggr0__tmp_attr4[ITEM];
MAT2aggr0__tmp_attr6[mat_idx2] = reg_aggr0__tmp_attr6[ITEM];
MAT2aggr0__tmp_attr7[mat_idx2] = reg_aggr0__tmp_attr7[ITEM];
MAT2aggr0__tmp_attr8[mat_idx2] = reg_aggr0__tmp_attr8[ITEM];
MAT2aggr0__tmp_attr9[mat_idx2] = reg_aggr0__tmp_attr9[ITEM];
}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto start = std::chrono::high_resolution_clock::now();
//Create aggregation hash table
auto d_HT_0 = cuco::static_map{ (int)5930889*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_1<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_HT_0.ref(cuco::insert), d_lineitem__l_linestatus, d_lineitem__l_returnflag, d_lineitem__l_shipdate, lineitem_size);
size_t COUNT0 = d_HT_0.size();
thrust::device_vector<int64_t> keys_0(COUNT0), vals_0(COUNT0);
d_HT_0.retrieve_all(keys_0.begin(), vals_0.begin());
d_HT_0.clear();
int64_t* raw_keys0 = thrust::raw_pointer_cast(keys_0.data());
insertKeys<<<std::ceil((float)COUNT0/128.), 128>>>(raw_keys0, d_HT_0.ref(cuco::insert), COUNT0);
//Aggregate in hashtable
DBI64Type* d_aggr0__tmp_attr9;
cudaMalloc(&d_aggr0__tmp_attr9, sizeof(DBI64Type) * COUNT0);
cudaMemset(d_aggr0__tmp_attr9, 0, sizeof(DBI64Type) * COUNT0);
DBDecimalType* d_aggr0__tmp_attr4;
cudaMalloc(&d_aggr0__tmp_attr4, sizeof(DBDecimalType) * COUNT0);
cudaMemset(d_aggr0__tmp_attr4, 0, sizeof(DBDecimalType) * COUNT0);
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT0);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT0);
DBDecimalType* d_aggr0__tmp_attr1;
cudaMalloc(&d_aggr0__tmp_attr1, sizeof(DBDecimalType) * COUNT0);
cudaMemset(d_aggr0__tmp_attr1, 0, sizeof(DBDecimalType) * COUNT0);
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT0);
DBDecimalType* d_aggr_rw__rw0;
cudaMalloc(&d_aggr_rw__rw0, sizeof(DBDecimalType) * COUNT0);
cudaMemset(d_aggr_rw__rw0, 0, sizeof(DBDecimalType) * COUNT0);
DBI64Type* d_aggr_rw__rw1;
cudaMalloc(&d_aggr_rw__rw1, sizeof(DBI64Type) * COUNT0);
cudaMemset(d_aggr_rw__rw1, 0, sizeof(DBI64Type) * COUNT0);
DBDecimalType* d_aggr_rw__rw2;
cudaMalloc(&d_aggr_rw__rw2, sizeof(DBDecimalType) * COUNT0);
cudaMemset(d_aggr_rw__rw2, 0, sizeof(DBDecimalType) * COUNT0);
DBI64Type* d_aggr_rw__rw3;
cudaMalloc(&d_aggr_rw__rw3, sizeof(DBI64Type) * COUNT0);
cudaMemset(d_aggr_rw__rw3, 0, sizeof(DBI64Type) * COUNT0);
DBDecimalType* d_aggr_rw__rw4;
cudaMalloc(&d_aggr_rw__rw4, sizeof(DBDecimalType) * COUNT0);
cudaMemset(d_aggr_rw__rw4, 0, sizeof(DBDecimalType) * COUNT0);
DBI64Type* d_aggr_rw__rw5;
cudaMalloc(&d_aggr_rw__rw5, sizeof(DBI64Type) * COUNT0);
cudaMemset(d_aggr_rw__rw5, 0, sizeof(DBI64Type) * COUNT0);
DBCharType* d_KEY_0lineitem__l_returnflag;
cudaMalloc(&d_KEY_0lineitem__l_returnflag, sizeof(DBCharType) * COUNT0);
cudaMemset(d_KEY_0lineitem__l_returnflag, 0, sizeof(DBCharType) * COUNT0);
DBCharType* d_KEY_0lineitem__l_linestatus;
cudaMalloc(&d_KEY_0lineitem__l_linestatus, sizeof(DBCharType) * COUNT0);
cudaMemset(d_KEY_0lineitem__l_linestatus, 0, sizeof(DBCharType) * COUNT0);
main_1<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_HT_0.ref(cuco::find), d_KEY_0lineitem__l_linestatus, d_KEY_0lineitem__l_returnflag, d_aggr0__tmp_attr0, d_aggr0__tmp_attr1, d_aggr0__tmp_attr2, d_aggr0__tmp_attr4, d_aggr0__tmp_attr9, d_aggr_rw__rw0, d_aggr_rw__rw1, d_aggr_rw__rw2, d_aggr_rw__rw3, d_aggr_rw__rw4, d_aggr_rw__rw5, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_linestatus, d_lineitem__l_quantity, d_lineitem__l_returnflag, d_lineitem__l_shipdate, d_lineitem__l_tax, lineitem_size);
//Materialize count
uint64_t* d_COUNT2;
cudaMalloc(&d_COUNT2, sizeof(uint64_t));
cudaMemset(d_COUNT2, 0, sizeof(uint64_t));
count_3<<<std::ceil((float)COUNT0/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT0, d_COUNT2);
uint64_t COUNT2;
cudaMemcpy(&COUNT2, d_COUNT2, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX2;
cudaMalloc(&d_MAT_IDX2, sizeof(uint64_t));
cudaMemset(d_MAT_IDX2, 0, sizeof(uint64_t));
auto MAT2lineitem__l_returnflag = (DBCharType*)malloc(sizeof(DBCharType) * COUNT2);
DBCharType* d_MAT2lineitem__l_returnflag;
cudaMalloc(&d_MAT2lineitem__l_returnflag, sizeof(DBCharType) * COUNT2);
auto MAT2lineitem__l_linestatus = (DBCharType*)malloc(sizeof(DBCharType) * COUNT2);
DBCharType* d_MAT2lineitem__l_linestatus;
cudaMalloc(&d_MAT2lineitem__l_linestatus, sizeof(DBCharType) * COUNT2);
auto MAT2aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT2);
DBDecimalType* d_MAT2aggr0__tmp_attr0;
cudaMalloc(&d_MAT2aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT2);
auto MAT2aggr0__tmp_attr1 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT2);
DBDecimalType* d_MAT2aggr0__tmp_attr1;
cudaMalloc(&d_MAT2aggr0__tmp_attr1, sizeof(DBDecimalType) * COUNT2);
auto MAT2aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT2);
DBDecimalType* d_MAT2aggr0__tmp_attr2;
cudaMalloc(&d_MAT2aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT2);
auto MAT2aggr0__tmp_attr4 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT2);
DBDecimalType* d_MAT2aggr0__tmp_attr4;
cudaMalloc(&d_MAT2aggr0__tmp_attr4, sizeof(DBDecimalType) * COUNT2);
auto MAT2aggr0__tmp_attr6 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT2);
DBDecimalType* d_MAT2aggr0__tmp_attr6;
cudaMalloc(&d_MAT2aggr0__tmp_attr6, sizeof(DBDecimalType) * COUNT2);
auto MAT2aggr0__tmp_attr7 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT2);
DBDecimalType* d_MAT2aggr0__tmp_attr7;
cudaMalloc(&d_MAT2aggr0__tmp_attr7, sizeof(DBDecimalType) * COUNT2);
auto MAT2aggr0__tmp_attr8 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT2);
DBDecimalType* d_MAT2aggr0__tmp_attr8;
cudaMalloc(&d_MAT2aggr0__tmp_attr8, sizeof(DBDecimalType) * COUNT2);
auto MAT2aggr0__tmp_attr9 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT2);
DBI64Type* d_MAT2aggr0__tmp_attr9;
cudaMalloc(&d_MAT2aggr0__tmp_attr9, sizeof(DBI64Type) * COUNT2);
main_3<<<std::ceil((float)COUNT0/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT0, d_MAT2aggr0__tmp_attr0, d_MAT2aggr0__tmp_attr1, d_MAT2aggr0__tmp_attr2, d_MAT2aggr0__tmp_attr4, d_MAT2aggr0__tmp_attr6, d_MAT2aggr0__tmp_attr7, d_MAT2aggr0__tmp_attr8, d_MAT2aggr0__tmp_attr9, d_MAT2lineitem__l_linestatus, d_MAT2lineitem__l_returnflag, d_MAT_IDX2, d_aggr0__tmp_attr0, d_aggr0__tmp_attr1, d_aggr0__tmp_attr2, d_aggr0__tmp_attr4, d_aggr0__tmp_attr9, d_aggr_rw__rw0, d_aggr_rw__rw1, d_aggr_rw__rw2, d_aggr_rw__rw3, d_aggr_rw__rw4, d_aggr_rw__rw5, d_KEY_0lineitem__l_linestatus, d_KEY_0lineitem__l_returnflag);
cudaMemcpy(MAT2lineitem__l_returnflag, d_MAT2lineitem__l_returnflag, sizeof(DBCharType) * COUNT2, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT2lineitem__l_linestatus, d_MAT2lineitem__l_linestatus, sizeof(DBCharType) * COUNT2, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT2aggr0__tmp_attr0, d_MAT2aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT2, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT2aggr0__tmp_attr1, d_MAT2aggr0__tmp_attr1, sizeof(DBDecimalType) * COUNT2, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT2aggr0__tmp_attr2, d_MAT2aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT2, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT2aggr0__tmp_attr4, d_MAT2aggr0__tmp_attr4, sizeof(DBDecimalType) * COUNT2, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT2aggr0__tmp_attr6, d_MAT2aggr0__tmp_attr6, sizeof(DBDecimalType) * COUNT2, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT2aggr0__tmp_attr7, d_MAT2aggr0__tmp_attr7, sizeof(DBDecimalType) * COUNT2, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT2aggr0__tmp_attr8, d_MAT2aggr0__tmp_attr8, sizeof(DBDecimalType) * COUNT2, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT2aggr0__tmp_attr9, d_MAT2aggr0__tmp_attr9, sizeof(DBI64Type) * COUNT2, cudaMemcpyDeviceToHost);
auto end = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
std::clog << "Query execution time: " << duration.count() / 1000. << " milliseconds." << std::endl;

for (auto i=0ull; i < COUNT2; i++) { std::cout << "" << MAT2lineitem__l_returnflag[i];
std::cout << "|" << MAT2lineitem__l_linestatus[i];
std::cout << "|" << MAT2aggr0__tmp_attr0[i];
std::cout << "|" << MAT2aggr0__tmp_attr1[i];
std::cout << "|" << MAT2aggr0__tmp_attr2[i];
std::cout << "|" << MAT2aggr0__tmp_attr4[i];
std::cout << "|" << MAT2aggr0__tmp_attr6[i];
std::cout << "|" << MAT2aggr0__tmp_attr7[i];
std::cout << "|" << MAT2aggr0__tmp_attr8[i];
std::cout << "|" << MAT2aggr0__tmp_attr9[i];
std::cout << std::endl; }
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
      size_t aux_mem = usedGpuMem() - used_mem;
      std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_KEY_0lineitem__l_linestatus);
cudaFree(d_KEY_0lineitem__l_returnflag);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_aggr0__tmp_attr1);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_aggr0__tmp_attr4);
cudaFree(d_aggr0__tmp_attr9);
cudaFree(d_aggr_rw__rw0);
cudaFree(d_aggr_rw__rw1);
cudaFree(d_aggr_rw__rw2);
cudaFree(d_aggr_rw__rw3);
cudaFree(d_aggr_rw__rw4);
cudaFree(d_aggr_rw__rw5);
cudaFree(d_COUNT2);
cudaFree(d_MAT2aggr0__tmp_attr0);
cudaFree(d_MAT2aggr0__tmp_attr1);
cudaFree(d_MAT2aggr0__tmp_attr2);
cudaFree(d_MAT2aggr0__tmp_attr4);
cudaFree(d_MAT2aggr0__tmp_attr6);
cudaFree(d_MAT2aggr0__tmp_attr7);
cudaFree(d_MAT2aggr0__tmp_attr8);
cudaFree(d_MAT2aggr0__tmp_attr9);
cudaFree(d_MAT2lineitem__l_linestatus);
cudaFree(d_MAT2lineitem__l_returnflag);
cudaFree(d_MAT_IDX2);
free(MAT2aggr0__tmp_attr0);
free(MAT2aggr0__tmp_attr1);
free(MAT2aggr0__tmp_attr2);
free(MAT2aggr0__tmp_attr4);
free(MAT2aggr0__tmp_attr6);
free(MAT2aggr0__tmp_attr7);
free(MAT2aggr0__tmp_attr8);
free(MAT2aggr0__tmp_attr9);
free(MAT2lineitem__l_linestatus);
free(MAT2lineitem__l_returnflag);
}