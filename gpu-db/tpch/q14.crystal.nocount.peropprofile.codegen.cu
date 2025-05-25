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
__global__ void main_3(uint64_t* BUF_2, uint64_t* BUF_IDX_2, HASHTABLE_INSERT HT_2, int64_t* cycles_per_warp_main_3_join_build_2, DBI32Type* part__p_partkey, size_t part_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_2[ITEMS_PER_THREAD];
DBI32Type reg_part__p_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_partkey[ITEM] = part__p_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_2[ITEM] = 0;
KEY_2[ITEM] |= reg_part__p_partkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_2.insert(cuco::pair{KEY_2[ITEM], ITEM*TB + tid});
BUF_2[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_3_join_build_2[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_1(uint64_t* BUF_2, HASHTABLE_PROBE HT_2, HASHTABLE_FIND HT_6, int* SLOT_COUNT_6, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr0__tmp_attr2, int64_t* cycles_per_warp_main_1_aggregation_6, int64_t* cycles_per_warp_main_1_join_probe_2, int64_t* cycles_per_warp_main_1_map_4, int64_t* cycles_per_warp_main_1_map_5, int64_t* cycles_per_warp_main_1_selection_0, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_partkey, DBDateType* lineitem__l_shipdate, size_t lineitem_size, DBStringType* part__p_type) {
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
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_shipdate[ITEM], 9374, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate[ITEM], 9404, Predicate::lt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_2[ITEMS_PER_THREAD];
DBI32Type reg_lineitem__l_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_partkey[ITEM] = lineitem__l_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_2[ITEM] = 0;
KEY_2[ITEM] |= reg_lineitem__l_partkey[ITEM];
}
//Probe Hash table
int64_t slot_second2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_2 = HT_2.find(KEY_2[ITEM]);
if (SLOT_2 == HT_2.end()) {selection_flags[ITEM] = 0; continue;}
slot_second2[ITEM] = SLOT_2->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_probe_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_map_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
DBStringType reg_part__p_type[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_type[ITEM] = part__p_type[BUF_2[slot_second2[ITEM] * 1 + 0]];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_map_5[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_6[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
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
DBDecimalType reg_map0__tmp_attr3[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr3[ITEM] = (reg_lineitem__l_extendedprice[ITEM]) * ((1.0) - (reg_lineitem__l_discount[ITEM]));
}
DBDecimalType reg_map0__tmp_attr1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr1[ITEM] = ((Like(reg_part__p_type[ITEM], "PROMO", "", nullptr, nullptr, 0))) ? ((reg_lineitem__l_extendedprice[ITEM]) * ((1.0) - (reg_lineitem__l_discount[ITEM]))) : (0.0);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_6 = get_aggregation_slot(KEY_6[ITEM], HT_6, SLOT_COUNT_6);
aggregate_sum(&aggr0__tmp_attr2[buf_idx_6], reg_map0__tmp_attr3[ITEM]);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_6], reg_map0__tmp_attr1[ITEM]);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_aggregation_6[blockIdx.x] = cycles_per_warp;}
}
__global__ void main_8(size_t COUNT6, DBDecimalType* MAT9map1__tmp_attr4, uint64_t* MAT_IDX9, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr0__tmp_attr2, int64_t* cycles_per_warp_main_8_map_7, int64_t* cycles_per_warp_main_8_materialize_9) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_8_map_7[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBDecimalType reg_aggr0__tmp_attr2[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT6); ++ITEM) {
reg_aggr0__tmp_attr2[ITEM] = aggr0__tmp_attr2[ITEM*TB + tid];
}
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT6); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
DBDecimalType reg_map1__tmp_attr4[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT6); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map1__tmp_attr4[ITEM] = ((100.00) * (reg_aggr0__tmp_attr0[ITEM])) / (reg_aggr0__tmp_attr2[ITEM]);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT6); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx9 = atomicAdd((int*)MAT_IDX9, 1);
MAT9map1__tmp_attr4[mat_idx9] = reg_map1__tmp_attr4[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_8_materialize_9[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_3_join_build_2;
auto main_3_join_build_2_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_3_join_build_2, sizeof(int64_t) * main_3_join_build_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_3_join_build_2, -1, sizeof(int64_t) * main_3_join_build_2_cpw_size);
size_t COUNT2 = part_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_2;
cudaMalloc(&d_BUF_IDX_2, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_2, 0, sizeof(uint64_t));
uint64_t* d_BUF_2;
cudaMalloc(&d_BUF_2, sizeof(uint64_t) * COUNT2 * 1);
auto d_HT_2 = cuco::static_map{ (int)COUNT2*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)part_size/(float)TILE_SIZE), TB>>>(d_BUF_2, d_BUF_IDX_2, d_HT_2.ref(cuco::insert), d_cycles_per_warp_main_3_join_build_2, d_part__p_partkey, part_size);
int64_t* cycles_per_warp_main_3_join_build_2 = (int64_t*)malloc(sizeof(int64_t) * main_3_join_build_2_cpw_size);
cudaMemcpy(cycles_per_warp_main_3_join_build_2, d_cycles_per_warp_main_3_join_build_2, sizeof(int64_t) * main_3_join_build_2_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_3_join_build_2 ";
for (auto i=0ull; i < main_3_join_build_2_cpw_size; i++) std::cout << cycles_per_warp_main_3_join_build_2[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_probe_2;
auto main_1_join_probe_2_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_probe_2, sizeof(int64_t) * main_1_join_probe_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_probe_2, -1, sizeof(int64_t) * main_1_join_probe_2_cpw_size);
int64_t* d_cycles_per_warp_main_1_map_4;
auto main_1_map_4_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_map_4, sizeof(int64_t) * main_1_map_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_map_4, -1, sizeof(int64_t) * main_1_map_4_cpw_size);
int64_t* d_cycles_per_warp_main_1_map_5;
auto main_1_map_5_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_map_5, sizeof(int64_t) * main_1_map_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_map_5, -1, sizeof(int64_t) * main_1_map_5_cpw_size);
int64_t* d_cycles_per_warp_main_1_aggregation_6;
auto main_1_aggregation_6_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_aggregation_6, sizeof(int64_t) * main_1_aggregation_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_aggregation_6, -1, sizeof(int64_t) * main_1_aggregation_6_cpw_size);
size_t COUNT6 = 1;
auto d_HT_6 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_6;
cudaMalloc(&d_SLOT_COUNT_6, sizeof(int));
cudaMemset(d_SLOT_COUNT_6, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT6);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT6);
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT6);
main_1<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TB>>>(d_BUF_2, d_HT_2.ref(cuco::find), d_HT_6.ref(cuco::insert_and_find), d_SLOT_COUNT_6, d_aggr0__tmp_attr0, d_aggr0__tmp_attr2, d_cycles_per_warp_main_1_aggregation_6, d_cycles_per_warp_main_1_join_probe_2, d_cycles_per_warp_main_1_map_4, d_cycles_per_warp_main_1_map_5, d_cycles_per_warp_main_1_selection_0, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_partkey, d_lineitem__l_shipdate, lineitem_size, d_part__p_type);
int64_t* cycles_per_warp_main_1_selection_0 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_0 ";
for (auto i=0ull; i < main_1_selection_0_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_0[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_probe_2 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_probe_2_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_probe_2, d_cycles_per_warp_main_1_join_probe_2, sizeof(int64_t) * main_1_join_probe_2_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_probe_2 ";
for (auto i=0ull; i < main_1_join_probe_2_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_probe_2[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_map_4 = (int64_t*)malloc(sizeof(int64_t) * main_1_map_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_map_4, d_cycles_per_warp_main_1_map_4, sizeof(int64_t) * main_1_map_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_map_4 ";
for (auto i=0ull; i < main_1_map_4_cpw_size; i++) std::cout << cycles_per_warp_main_1_map_4[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_map_5 = (int64_t*)malloc(sizeof(int64_t) * main_1_map_5_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_map_5, d_cycles_per_warp_main_1_map_5, sizeof(int64_t) * main_1_map_5_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_map_5 ";
for (auto i=0ull; i < main_1_map_5_cpw_size; i++) std::cout << cycles_per_warp_main_1_map_5[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_aggregation_6 = (int64_t*)malloc(sizeof(int64_t) * main_1_aggregation_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_aggregation_6, d_cycles_per_warp_main_1_aggregation_6, sizeof(int64_t) * main_1_aggregation_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_aggregation_6 ";
for (auto i=0ull; i < main_1_aggregation_6_cpw_size; i++) std::cout << cycles_per_warp_main_1_aggregation_6[i] << " ";
std::cout << std::endl;
COUNT6 = d_HT_6.size();
int64_t* d_cycles_per_warp_main_8_map_7;
auto main_8_map_7_cpw_size = std::ceil((float)COUNT6/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_8_map_7, sizeof(int64_t) * main_8_map_7_cpw_size);
cudaMemset(d_cycles_per_warp_main_8_map_7, -1, sizeof(int64_t) * main_8_map_7_cpw_size);
int64_t* d_cycles_per_warp_main_8_materialize_9;
auto main_8_materialize_9_cpw_size = std::ceil((float)COUNT6/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_8_materialize_9, sizeof(int64_t) * main_8_materialize_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_8_materialize_9, -1, sizeof(int64_t) * main_8_materialize_9_cpw_size);
size_t COUNT9 = COUNT6;
//Materialize buffers
uint64_t* d_MAT_IDX9;
cudaMalloc(&d_MAT_IDX9, sizeof(uint64_t));
cudaMemset(d_MAT_IDX9, 0, sizeof(uint64_t));
auto MAT9map1__tmp_attr4 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT9);
DBDecimalType* d_MAT9map1__tmp_attr4;
cudaMalloc(&d_MAT9map1__tmp_attr4, sizeof(DBDecimalType) * COUNT9);
main_8<<<std::ceil((float)COUNT6/(float)TILE_SIZE), TB>>>(COUNT6, d_MAT9map1__tmp_attr4, d_MAT_IDX9, d_aggr0__tmp_attr0, d_aggr0__tmp_attr2, d_cycles_per_warp_main_8_map_7, d_cycles_per_warp_main_8_materialize_9);
uint64_t MATCOUNT_9 = 0;
cudaMemcpy(&MATCOUNT_9, d_MAT_IDX9, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT9map1__tmp_attr4, d_MAT9map1__tmp_attr4, sizeof(DBDecimalType) * COUNT9, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_8_map_7 = (int64_t*)malloc(sizeof(int64_t) * main_8_map_7_cpw_size);
cudaMemcpy(cycles_per_warp_main_8_map_7, d_cycles_per_warp_main_8_map_7, sizeof(int64_t) * main_8_map_7_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_8_map_7 ";
for (auto i=0ull; i < main_8_map_7_cpw_size; i++) std::cout << cycles_per_warp_main_8_map_7[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_8_materialize_9 = (int64_t*)malloc(sizeof(int64_t) * main_8_materialize_9_cpw_size);
cudaMemcpy(cycles_per_warp_main_8_materialize_9, d_cycles_per_warp_main_8_materialize_9, sizeof(int64_t) * main_8_materialize_9_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_8_materialize_9 ";
for (auto i=0ull; i < main_8_materialize_9_cpw_size; i++) std::cout << cycles_per_warp_main_8_materialize_9[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_2);
cudaFree(d_BUF_IDX_2);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_MAT9map1__tmp_attr4);
cudaFree(d_MAT_IDX9);
free(MAT9map1__tmp_attr4);
}