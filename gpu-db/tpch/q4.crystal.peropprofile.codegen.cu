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
__global__ void count_1(uint64_t* COUNT4, DBDateType* lineitem__l_commitdate, DBDateType* lineitem__l_receiptdate, size_t lineitem_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBDateType reg_lineitem__l_commitdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_commitdate[ITEM] = lineitem__l_commitdate[ITEM*TB + tid];
}
DBDateType reg_lineitem__l_receiptdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_receiptdate[ITEM] = lineitem__l_receiptdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_commitdate[ITEM], reg_lineitem__l_receiptdate[ITEM], Predicate::lt);
}
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT4, 1);
}
}
template<typename HASHTABLE_INSERT_SJ>
__global__ void main_1(HASHTABLE_INSERT_SJ HT_4, int64_t* cycles_per_warp_main_1_selection_0, int64_t* cycles_per_warp_main_1_semi_join_build_4, DBDateType* lineitem__l_commitdate, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_receiptdate, size_t lineitem_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBDateType reg_lineitem__l_commitdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_commitdate[ITEM] = lineitem__l_commitdate[ITEM*TB + tid];
}
DBDateType reg_lineitem__l_receiptdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_receiptdate[ITEM] = lineitem__l_receiptdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_commitdate[ITEM], reg_lineitem__l_receiptdate[ITEM], Predicate::lt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_lineitem__l_orderkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_4.insert(cuco::pair{KEY_4[ITEM], 1});
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_semi_join_build_4[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE_SJ, typename HASHTABLE_INSERT>
__global__ void count_3(HASHTABLE_PROBE_SJ HT_4, HASHTABLE_INSERT HT_5, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, DBI16Type* orders__o_orderpriority_encoded, size_t orders_size) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
DBDateType reg_orders__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderdate[ITEM] = orders__o_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_orders__o_orderdate[ITEM], 8582, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate[ITEM], 8674, Predicate::lt);
}
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_orders__o_orderkey[ITEM];
}
//Probe Hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_4 = HT_4.find(KEY_4[ITEM]);
if (SLOT_4 == HT_4.end()) {selection_flags[ITEM] = 0;}
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
uint64_t KEY_5[ITEMS_PER_THREAD];
DBI16Type reg_orders__o_orderpriority_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderpriority_encoded[ITEM] = orders__o_orderpriority_encoded[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_5[ITEM] = 0;
KEY_5[ITEM] |= reg_orders__o_orderpriority_encoded[ITEM];
}
//Create aggregation hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_5.insert(cuco::pair{KEY_5[ITEM], 1});
}
}
template<typename HASHTABLE_PROBE_SJ, typename HASHTABLE_FIND>
__global__ void main_3(HASHTABLE_PROBE_SJ HT_4, HASHTABLE_FIND HT_5, DBI16Type* KEY_5orders__o_orderpriority_encoded, DBI64Type* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_3_aggregation_5, int64_t* cycles_per_warp_main_3_selection_2, int64_t* cycles_per_warp_main_3_semi_join_probe_4, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, DBI16Type* orders__o_orderpriority_encoded, size_t orders_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBDateType reg_orders__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderdate[ITEM] = orders__o_orderdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_orders__o_orderdate[ITEM], 8582, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate[ITEM], 8674, Predicate::lt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_orders__o_orderkey[ITEM];
}
//Probe Hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_4 = HT_4.find(KEY_4[ITEM]);
if (SLOT_4 == HT_4.end()) {selection_flags[ITEM] = 0;}
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_semi_join_probe_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_5[ITEMS_PER_THREAD];
DBI16Type reg_orders__o_orderpriority_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderpriority_encoded[ITEM] = orders__o_orderpriority_encoded[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_5[ITEM] = 0;
KEY_5[ITEM] |= reg_orders__o_orderpriority_encoded[ITEM];
}
//Aggregate in hashtable
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_5 = HT_5.find(KEY_5[ITEM])->second;
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5], 1);
KEY_5orders__o_orderpriority_encoded[buf_idx_5] = reg_orders__o_orderpriority_encoded[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_aggregation_5[blockIdx.x] = cycles_per_warp;}
}
__global__ void count_7(size_t COUNT5, uint64_t* COUNT6) {
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
//Materialize count
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT5); ++ITEM) {
if (!selection_flags[ITEM]) continue;
atomicAdd((int*)COUNT6, 1);
}
}
__global__ void main_7(size_t COUNT5, DBI64Type* MAT6aggr0__tmp_attr0, DBI16Type* MAT6orders__o_orderpriority_encoded, uint64_t* MAT_IDX6, DBI64Type* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_7_materialize_6, DBI16Type* orders__o_orderpriority_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI16Type reg_orders__o_orderpriority_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT5); ++ITEM) {
reg_orders__o_orderpriority_encoded[ITEM] = orders__o_orderpriority_encoded[ITEM*TB + tid];
}
DBI64Type reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT5); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT5); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx6 = atomicAdd((int*)MAT_IDX6, 1);
MAT6orders__o_orderpriority_encoded[mat_idx6] = reg_orders__o_orderpriority_encoded[ITEM];
MAT6aggr0__tmp_attr0[mat_idx6] = reg_aggr0__tmp_attr0[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_materialize_6[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
//Materialize count
uint64_t* d_COUNT4;
cudaMalloc(&d_COUNT4, sizeof(uint64_t));
cudaMemset(d_COUNT4, 0, sizeof(uint64_t));
count_1<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_COUNT4, d_lineitem__l_commitdate, d_lineitem__l_receiptdate, lineitem_size);
uint64_t COUNT4;
cudaMemcpy(&COUNT4, d_COUNT4, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_1_semi_join_build_4;
auto main_1_semi_join_build_4_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_semi_join_build_4, sizeof(int64_t) * main_1_semi_join_build_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_semi_join_build_4, -1, sizeof(int64_t) * main_1_semi_join_build_4_cpw_size);
// Insert hash table control;
auto d_HT_4 = cuco::static_map{ (int)COUNT4*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_HT_4.ref(cuco::insert), d_cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_semi_join_build_4, d_lineitem__l_commitdate, d_lineitem__l_orderkey, d_lineitem__l_receiptdate, lineitem_size);
int64_t* d_cycles_per_warp_main_3_selection_2;
auto main_3_selection_2_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_selection_2, sizeof(int64_t) * main_3_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_selection_2, -1, sizeof(int64_t) * main_3_selection_2_cpw_size);
int64_t* d_cycles_per_warp_main_3_semi_join_probe_4;
auto main_3_semi_join_probe_4_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_semi_join_probe_4, sizeof(int64_t) * main_3_semi_join_probe_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_semi_join_probe_4, -1, sizeof(int64_t) * main_3_semi_join_probe_4_cpw_size);
//Create aggregation hash table
auto d_HT_5 = cuco::static_map{ (int)51270*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_3<<<std::ceil((float)orders_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_HT_4.ref(cuco::find), d_HT_5.ref(cuco::insert), d_orders__o_orderdate, d_orders__o_orderkey, d_orders__o_orderpriority_encoded, orders_size);
size_t COUNT5 = d_HT_5.size();
thrust::device_vector<int64_t> keys_5(COUNT5), vals_5(COUNT5);
d_HT_5.retrieve_all(keys_5.begin(), vals_5.begin());
d_HT_5.clear();
int64_t* raw_keys5 = thrust::raw_pointer_cast(keys_5.data());
insertKeys<<<std::ceil((float)COUNT5/128.), 128>>>(raw_keys5, d_HT_5.ref(cuco::insert), COUNT5);
int64_t* d_cycles_per_warp_main_3_aggregation_5;
auto main_3_aggregation_5_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_aggregation_5, sizeof(int64_t) * main_3_aggregation_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_aggregation_5, -1, sizeof(int64_t) * main_3_aggregation_5_cpw_size);
//Aggregate in hashtable
DBI64Type* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT5);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT5);
DBI16Type* d_KEY_5orders__o_orderpriority_encoded;
cudaMalloc(&d_KEY_5orders__o_orderpriority_encoded, sizeof(DBI16Type) * COUNT5);
cudaMemset(d_KEY_5orders__o_orderpriority_encoded, 0, sizeof(DBI16Type) * COUNT5);
main_3<<<std::ceil((float)orders_size/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(d_HT_4.ref(cuco::find), d_HT_5.ref(cuco::find), d_KEY_5orders__o_orderpriority_encoded, d_aggr0__tmp_attr0, d_cycles_per_warp_main_3_aggregation_5, d_cycles_per_warp_main_3_selection_2, d_cycles_per_warp_main_3_semi_join_probe_4, d_orders__o_orderdate, d_orders__o_orderkey, d_orders__o_orderpriority_encoded, orders_size);
int64_t* cycles_per_warp_main_3_selection_2 = (int64_t*)malloc(sizeof(int64_t) * main_3_selection_2_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_selection_2, d_cycles_per_warp_main_3_selection_2, sizeof(int64_t) * main_3_selection_2_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_selection_2 ";
for (auto i=0ull; i < main_3_selection_2_cpw_size; i++) std::cout << cycles_per_warp_main_3_selection_2[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_semi_join_probe_4 = (int64_t*)malloc(sizeof(int64_t) * main_3_semi_join_probe_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_semi_join_probe_4, d_cycles_per_warp_main_3_semi_join_probe_4, sizeof(int64_t) * main_3_semi_join_probe_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_semi_join_probe_4 ";
for (auto i=0ull; i < main_3_semi_join_probe_4_cpw_size; i++) std::cout << cycles_per_warp_main_3_semi_join_probe_4[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_aggregation_5 = (int64_t*)malloc(sizeof(int64_t) * main_3_aggregation_5_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_aggregation_5, d_cycles_per_warp_main_3_aggregation_5, sizeof(int64_t) * main_3_aggregation_5_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_aggregation_5 ";
for (auto i=0ull; i < main_3_aggregation_5_cpw_size; i++) std::cout << cycles_per_warp_main_3_aggregation_5[i] << " ";
std::cout << std::endl;
//Materialize count
uint64_t* d_COUNT6;
cudaMalloc(&d_COUNT6, sizeof(uint64_t));
cudaMemset(d_COUNT6, 0, sizeof(uint64_t));
count_7<<<std::ceil((float)COUNT5/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT5, d_COUNT6);
uint64_t COUNT6;
cudaMemcpy(&COUNT6, d_COUNT6, sizeof(uint64_t), cudaMemcpyDeviceToHost);
int64_t* d_cycles_per_warp_main_7_materialize_6;
auto main_7_materialize_6_cpw_size = std::ceil((float)COUNT5/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_materialize_6, sizeof(int64_t) * main_7_materialize_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_materialize_6, -1, sizeof(int64_t) * main_7_materialize_6_cpw_size);
//Materialize buffers
uint64_t* d_MAT_IDX6;
cudaMalloc(&d_MAT_IDX6, sizeof(uint64_t));
cudaMemset(d_MAT_IDX6, 0, sizeof(uint64_t));
auto MAT6orders__o_orderpriority_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT6);
DBI16Type* d_MAT6orders__o_orderpriority_encoded;
cudaMalloc(&d_MAT6orders__o_orderpriority_encoded, sizeof(DBI16Type) * COUNT6);
auto MAT6aggr0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT6);
DBI64Type* d_MAT6aggr0__tmp_attr0;
cudaMalloc(&d_MAT6aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT6);
main_7<<<std::ceil((float)COUNT5/(float)TILE_SIZE), TILE_SIZE/ITEMS_PER_THREAD>>>(COUNT5, d_MAT6aggr0__tmp_attr0, d_MAT6orders__o_orderpriority_encoded, d_MAT_IDX6, d_aggr0__tmp_attr0, d_cycles_per_warp_main_7_materialize_6, d_KEY_5orders__o_orderpriority_encoded);
cudaMemcpy(MAT6orders__o_orderpriority_encoded, d_MAT6orders__o_orderpriority_encoded, sizeof(DBI16Type) * COUNT6, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT6aggr0__tmp_attr0, d_MAT6aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT6, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_7_materialize_6 = (int64_t*)malloc(sizeof(int64_t) * main_7_materialize_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_materialize_6, d_cycles_per_warp_main_7_materialize_6, sizeof(int64_t) * main_7_materialize_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_materialize_6 ";
for (auto i=0ull; i < main_7_materialize_6_cpw_size; i++) std::cout << cycles_per_warp_main_7_materialize_6[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
      size_t aux_mem = usedGpuMem() - used_mem;
      std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_COUNT4);
cudaFree(d_KEY_5orders__o_orderpriority_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT6);
cudaFree(d_MAT6aggr0__tmp_attr0);
cudaFree(d_MAT6orders__o_orderpriority_encoded);
cudaFree(d_MAT_IDX6);
free(MAT6aggr0__tmp_attr0);
free(MAT6orders__o_orderpriority_encoded);
}