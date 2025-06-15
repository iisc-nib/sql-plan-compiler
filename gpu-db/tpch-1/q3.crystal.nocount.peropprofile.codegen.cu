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
__global__ void main_1(uint64_t* BUF_4, uint64_t* BUF_IDX_4, HASHTABLE_INSERT HT_4, DBI32Type* customer__c_custkey, DBStringType* customer__c_mktsegment, size_t customer_size, int64_t* cycles_per_warp_main_1_join_build_4, int64_t* cycles_per_warp_main_1_selection_0) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_customer__c_mktsegment[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_mktsegment[ITEM] = customer__c_mktsegment[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_customer__c_mktsegment[ITEM], "BUILDING", Predicate::eq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_customer__c_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
reg_customer__c_custkey[ITEM] = customer__c_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_customer__c_custkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < customer_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_4.insert(cuco::pair{KEY_4[ITEM], ITEM*TB + tid});
BUF_4[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_build_4[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_3(uint64_t* BUF_4, uint64_t* BUF_7, uint64_t* BUF_IDX_7, HASHTABLE_PROBE HT_4, HASHTABLE_INSERT HT_7, int64_t* cycles_per_warp_main_3_join_build_7, int64_t* cycles_per_warp_main_3_join_probe_4, int64_t* cycles_per_warp_main_3_selection_2, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
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
selection_flags[ITEM] &= evaluatePredicate(reg_orders__o_orderdate[ITEM], 9204, Predicate::lt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_4[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_custkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_custkey[ITEM] = orders__o_custkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_4[ITEM] = 0;
KEY_4[ITEM] |= reg_orders__o_custkey[ITEM];
}
//Probe Hash table
int64_t slot_second4[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_4 = HT_4.find(KEY_4[ITEM]);
if (SLOT_4 == HT_4.end()) {selection_flags[ITEM] = 0; continue;}
slot_second4[ITEM] = SLOT_4->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_probe_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_7[ITEMS_PER_THREAD];
DBI32Type reg_orders__o_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
reg_orders__o_orderkey[ITEM] = orders__o_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_7[ITEM] = 0;
KEY_7[ITEM] |= reg_orders__o_orderkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < orders_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_7.insert(cuco::pair{KEY_7[ITEM], ITEM*TB + tid});
BUF_7[(ITEM*TB + tid) * 2 + 0] = BUF_4[slot_second4[ITEM] * 1 + 0];
BUF_7[(ITEM*TB + tid) * 2 + 1] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_build_7[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_6(uint64_t* BUF_7, HASHTABLE_PROBE HT_7, HASHTABLE_FIND HT_9, DBI32Type* KEY_9lineitem__l_orderkey, int* SLOT_COUNT_9, DBDecimalType* aggr0__tmp_attr0, DBDateType* aggr__o_orderdate, DBI32Type* aggr__o_shippriority, int64_t* cycles_per_warp_main_6_aggregation_9, int64_t* cycles_per_warp_main_6_join_probe_7, int64_t* cycles_per_warp_main_6_map_8, int64_t* cycles_per_warp_main_6_selection_5, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, size_t lineitem_size, DBDateType* orders__o_orderdate, DBI32Type* orders__o_shippriority) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBDateType reg_lineitem__l_shipdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_shipdate[ITEM] = lineitem__l_shipdate[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_shipdate[ITEM], 9204, Predicate::gt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_6_selection_5[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_7[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_7[ITEM] = 0;
KEY_7[ITEM] |= reg_lineitem__l_orderkey[ITEM];
}
//Probe Hash table
int64_t slot_second7[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_7 = HT_7.find(KEY_7[ITEM]);
if (SLOT_7 == HT_7.end()) {selection_flags[ITEM] = 0; continue;}
slot_second7[ITEM] = SLOT_7->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_6_join_probe_7[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_6_map_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_9[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_9[ITEM] = 0;
KEY_9[ITEM] |= reg_lineitem__l_orderkey[ITEM];
}
//Aggregate in hashtable
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
DBDecimalType reg_map0__tmp_attr1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr1[ITEM] = (reg_lineitem__l_extendedprice[ITEM]) * ((1.0) - (reg_lineitem__l_discount[ITEM]));
}
DBI32Type reg_orders__o_shippriority[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_shippriority[ITEM] = orders__o_shippriority[BUF_7[slot_second7[ITEM] * 2 + 1]];
}
DBDateType reg_orders__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_orders__o_orderdate[ITEM] = orders__o_orderdate[BUF_7[slot_second7[ITEM] * 2 + 1]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_9 = get_aggregation_slot(KEY_9[ITEM], HT_9, SLOT_COUNT_9);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_9], reg_map0__tmp_attr1[ITEM]);
aggregate_any(&aggr__o_shippriority[buf_idx_9], reg_orders__o_shippriority[ITEM]);
aggregate_any(&aggr__o_orderdate[buf_idx_9], reg_orders__o_orderdate[ITEM]);
KEY_9lineitem__l_orderkey[buf_idx_9] = reg_lineitem__l_orderkey[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_6_aggregation_9[blockIdx.x] = cycles_per_warp;}
}
__global__ void main_11(size_t COUNT9, DBDecimalType* MAT10aggr0__tmp_attr0, DBDateType* MAT10aggr__o_orderdate, DBI32Type* MAT10aggr__o_shippriority, DBI32Type* MAT10lineitem__l_orderkey, uint64_t* MAT_IDX10, DBDecimalType* aggr0__tmp_attr0, DBDateType* aggr__o_orderdate, DBI32Type* aggr__o_shippriority, int64_t* cycles_per_warp_main_11_materialize_10, DBI32Type* lineitem__l_orderkey) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI32Type reg_lineitem__l_orderkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_lineitem__l_orderkey[ITEM] = lineitem__l_orderkey[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
DBDateType reg_aggr__o_orderdate[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_aggr__o_orderdate[ITEM] = aggr__o_orderdate[ITEM*TB + tid];
}
DBI32Type reg_aggr__o_shippriority[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_aggr__o_shippriority[ITEM] = aggr__o_shippriority[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx10 = atomicAdd((int*)MAT_IDX10, 1);
MAT10lineitem__l_orderkey[mat_idx10] = reg_lineitem__l_orderkey[ITEM];
MAT10aggr0__tmp_attr0[mat_idx10] = reg_aggr0__tmp_attr0[ITEM];
MAT10aggr__o_orderdate[mat_idx10] = reg_aggr__o_orderdate[ITEM];
MAT10aggr__o_shippriority[mat_idx10] = reg_aggr__o_shippriority[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_materialize_10[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_build_4;
auto main_1_join_build_4_cpw_size = std::ceil((float)customer_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_build_4, sizeof(int64_t) * main_1_join_build_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_build_4, -1, sizeof(int64_t) * main_1_join_build_4_cpw_size);
size_t COUNT4 = customer_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_4;
cudaMalloc(&d_BUF_IDX_4, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_4, 0, sizeof(uint64_t));
uint64_t* d_BUF_4;
cudaMalloc(&d_BUF_4, sizeof(uint64_t) * COUNT4 * 1);
auto d_HT_4 = cuco::static_map{ (int)COUNT4*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)customer_size/(float)TILE_SIZE), TB>>>(d_BUF_4, d_BUF_IDX_4, d_HT_4.ref(cuco::insert), d_customer__c_custkey, d_customer__c_mktsegment, customer_size, d_cycles_per_warp_main_1_join_build_4, d_cycles_per_warp_main_1_selection_0);
int64_t* cycles_per_warp_main_1_selection_0 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_0 ";
for (auto i=0ull; i < main_1_selection_0_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_0[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_build_4 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_build_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_build_4, d_cycles_per_warp_main_1_join_build_4, sizeof(int64_t) * main_1_join_build_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_build_4 ";
for (auto i=0ull; i < main_1_join_build_4_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_build_4[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_3_selection_2;
auto main_3_selection_2_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_selection_2, sizeof(int64_t) * main_3_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_selection_2, -1, sizeof(int64_t) * main_3_selection_2_cpw_size);
int64_t* d_cycles_per_warp_main_3_join_probe_4;
auto main_3_join_probe_4_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_probe_4, sizeof(int64_t) * main_3_join_probe_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_probe_4, -1, sizeof(int64_t) * main_3_join_probe_4_cpw_size);
int64_t* d_cycles_per_warp_main_3_join_build_7;
auto main_3_join_build_7_cpw_size = std::ceil((float)orders_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_build_7, sizeof(int64_t) * main_3_join_build_7_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_build_7, -1, sizeof(int64_t) * main_3_join_build_7_cpw_size);
size_t COUNT7 = orders_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_7;
cudaMalloc(&d_BUF_IDX_7, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_7, 0, sizeof(uint64_t));
uint64_t* d_BUF_7;
cudaMalloc(&d_BUF_7, sizeof(uint64_t) * COUNT7 * 2);
auto d_HT_7 = cuco::static_map{ (int)COUNT7*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)orders_size/(float)TILE_SIZE), TB>>>(d_BUF_4, d_BUF_7, d_BUF_IDX_7, d_HT_4.ref(cuco::find), d_HT_7.ref(cuco::insert), d_cycles_per_warp_main_3_join_build_7, d_cycles_per_warp_main_3_join_probe_4, d_cycles_per_warp_main_3_selection_2, d_orders__o_custkey, d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
int64_t* cycles_per_warp_main_3_selection_2 = (int64_t*)malloc(sizeof(int64_t) * main_3_selection_2_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_selection_2, d_cycles_per_warp_main_3_selection_2, sizeof(int64_t) * main_3_selection_2_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_selection_2 ";
for (auto i=0ull; i < main_3_selection_2_cpw_size; i++) std::cout << cycles_per_warp_main_3_selection_2[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_join_probe_4 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_probe_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_probe_4, d_cycles_per_warp_main_3_join_probe_4, sizeof(int64_t) * main_3_join_probe_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_probe_4 ";
for (auto i=0ull; i < main_3_join_probe_4_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_probe_4[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_3_join_build_7 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_build_7_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_build_7, d_cycles_per_warp_main_3_join_build_7, sizeof(int64_t) * main_3_join_build_7_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_build_7 ";
for (auto i=0ull; i < main_3_join_build_7_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_build_7[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_6_selection_5;
auto main_6_selection_5_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_6_selection_5, sizeof(int64_t) * main_6_selection_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_6_selection_5, -1, sizeof(int64_t) * main_6_selection_5_cpw_size);
int64_t* d_cycles_per_warp_main_6_join_probe_7;
auto main_6_join_probe_7_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_6_join_probe_7, sizeof(int64_t) * main_6_join_probe_7_cpw_size);
cudaMemset(d_cycles_per_warp_main_6_join_probe_7, -1, sizeof(int64_t) * main_6_join_probe_7_cpw_size);
int64_t* d_cycles_per_warp_main_6_map_8;
auto main_6_map_8_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_6_map_8, sizeof(int64_t) * main_6_map_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_6_map_8, -1, sizeof(int64_t) * main_6_map_8_cpw_size);
int64_t* d_cycles_per_warp_main_6_aggregation_9;
auto main_6_aggregation_9_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_6_aggregation_9, sizeof(int64_t) * main_6_aggregation_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_6_aggregation_9, -1, sizeof(int64_t) * main_6_aggregation_9_cpw_size);
size_t COUNT9 = 355555;
auto d_HT_9 = cuco::static_map{ (int)355555*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_9;
cudaMalloc(&d_SLOT_COUNT_9, sizeof(int));
cudaMemset(d_SLOT_COUNT_9, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT9);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT9);
DBI32Type* d_aggr__o_shippriority;
cudaMalloc(&d_aggr__o_shippriority, sizeof(DBI32Type) * COUNT9);
cudaMemset(d_aggr__o_shippriority, 0, sizeof(DBI32Type) * COUNT9);
DBDateType* d_aggr__o_orderdate;
cudaMalloc(&d_aggr__o_orderdate, sizeof(DBDateType) * COUNT9);
cudaMemset(d_aggr__o_orderdate, 0, sizeof(DBDateType) * COUNT9);
DBI32Type* d_KEY_9lineitem__l_orderkey;
cudaMalloc(&d_KEY_9lineitem__l_orderkey, sizeof(DBI32Type) * COUNT9);
cudaMemset(d_KEY_9lineitem__l_orderkey, 0, sizeof(DBI32Type) * COUNT9);
main_6<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TB>>>(d_BUF_7, d_HT_7.ref(cuco::find), d_HT_9.ref(cuco::insert_and_find), d_KEY_9lineitem__l_orderkey, d_SLOT_COUNT_9, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_cycles_per_warp_main_6_aggregation_9, d_cycles_per_warp_main_6_join_probe_7, d_cycles_per_warp_main_6_map_8, d_cycles_per_warp_main_6_selection_5, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, lineitem_size, d_orders__o_orderdate, d_orders__o_shippriority);
int64_t* cycles_per_warp_main_6_selection_5 = (int64_t*)malloc(sizeof(int64_t) * main_6_selection_5_cpw_size);
cudaMemcpy(cycles_per_warp_main_6_selection_5, d_cycles_per_warp_main_6_selection_5, sizeof(int64_t) * main_6_selection_5_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_6_selection_5 ";
for (auto i=0ull; i < main_6_selection_5_cpw_size; i++) std::cout << cycles_per_warp_main_6_selection_5[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_6_join_probe_7 = (int64_t*)malloc(sizeof(int64_t) * main_6_join_probe_7_cpw_size);
cudaMemcpy(cycles_per_warp_main_6_join_probe_7, d_cycles_per_warp_main_6_join_probe_7, sizeof(int64_t) * main_6_join_probe_7_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_6_join_probe_7 ";
for (auto i=0ull; i < main_6_join_probe_7_cpw_size; i++) std::cout << cycles_per_warp_main_6_join_probe_7[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_6_map_8 = (int64_t*)malloc(sizeof(int64_t) * main_6_map_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_6_map_8, d_cycles_per_warp_main_6_map_8, sizeof(int64_t) * main_6_map_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_6_map_8 ";
for (auto i=0ull; i < main_6_map_8_cpw_size; i++) std::cout << cycles_per_warp_main_6_map_8[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_6_aggregation_9 = (int64_t*)malloc(sizeof(int64_t) * main_6_aggregation_9_cpw_size);
cudaMemcpy(cycles_per_warp_main_6_aggregation_9, d_cycles_per_warp_main_6_aggregation_9, sizeof(int64_t) * main_6_aggregation_9_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_6_aggregation_9 ";
for (auto i=0ull; i < main_6_aggregation_9_cpw_size; i++) std::cout << cycles_per_warp_main_6_aggregation_9[i] << " ";
std::cout << std::endl;
COUNT9 = d_HT_9.size();
int64_t* d_cycles_per_warp_main_11_materialize_10;
auto main_11_materialize_10_cpw_size = std::ceil((float)COUNT9/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_materialize_10, sizeof(int64_t) * main_11_materialize_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_materialize_10, -1, sizeof(int64_t) * main_11_materialize_10_cpw_size);
size_t COUNT10 = COUNT9;
//Materialize buffers
uint64_t* d_MAT_IDX10;
cudaMalloc(&d_MAT_IDX10, sizeof(uint64_t));
cudaMemset(d_MAT_IDX10, 0, sizeof(uint64_t));
auto MAT10lineitem__l_orderkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT10);
DBI32Type* d_MAT10lineitem__l_orderkey;
cudaMalloc(&d_MAT10lineitem__l_orderkey, sizeof(DBI32Type) * COUNT10);
auto MAT10aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT10);
DBDecimalType* d_MAT10aggr0__tmp_attr0;
cudaMalloc(&d_MAT10aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT10);
auto MAT10aggr__o_orderdate = (DBDateType*)malloc(sizeof(DBDateType) * COUNT10);
DBDateType* d_MAT10aggr__o_orderdate;
cudaMalloc(&d_MAT10aggr__o_orderdate, sizeof(DBDateType) * COUNT10);
auto MAT10aggr__o_shippriority = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT10);
DBI32Type* d_MAT10aggr__o_shippriority;
cudaMalloc(&d_MAT10aggr__o_shippriority, sizeof(DBI32Type) * COUNT10);
main_11<<<std::ceil((float)COUNT9/(float)TILE_SIZE), TB>>>(COUNT9, d_MAT10aggr0__tmp_attr0, d_MAT10aggr__o_orderdate, d_MAT10aggr__o_shippriority, d_MAT10lineitem__l_orderkey, d_MAT_IDX10, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_cycles_per_warp_main_11_materialize_10, d_KEY_9lineitem__l_orderkey);
uint64_t MATCOUNT_10 = 0;
cudaMemcpy(&MATCOUNT_10, d_MAT_IDX10, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10lineitem__l_orderkey, d_MAT10lineitem__l_orderkey, sizeof(DBI32Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr0__tmp_attr0, d_MAT10aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr__o_orderdate, d_MAT10aggr__o_orderdate, sizeof(DBDateType) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr__o_shippriority, d_MAT10aggr__o_shippriority, sizeof(DBI32Type) * COUNT10, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_11_materialize_10 = (int64_t*)malloc(sizeof(int64_t) * main_11_materialize_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_materialize_10, d_cycles_per_warp_main_11_materialize_10, sizeof(int64_t) * main_11_materialize_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_materialize_10 ";
for (auto i=0ull; i < main_11_materialize_10_cpw_size; i++) std::cout << cycles_per_warp_main_11_materialize_10[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_4);
cudaFree(d_BUF_IDX_4);
cudaFree(d_BUF_7);
cudaFree(d_BUF_IDX_7);
cudaFree(d_KEY_9lineitem__l_orderkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_aggr__o_orderdate);
cudaFree(d_aggr__o_shippriority);
cudaFree(d_MAT10aggr0__tmp_attr0);
cudaFree(d_MAT10aggr__o_orderdate);
cudaFree(d_MAT10aggr__o_shippriority);
cudaFree(d_MAT10lineitem__l_orderkey);
cudaFree(d_MAT_IDX10);
free(MAT10aggr0__tmp_attr0);
free(MAT10aggr__o_orderdate);
free(MAT10aggr__o_shippriority);
free(MAT10lineitem__l_orderkey);
}