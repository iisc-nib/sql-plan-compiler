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
template<typename HASHTABLE_FIND>
__global__ void main_1(HASHTABLE_FIND HT_5, int* SLOT_COUNT_5, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_1_aggregation_5, int64_t* cycles_per_warp_main_1_map_4, int64_t* cycles_per_warp_main_1_selection_0, int64_t* cycles_per_warp_main_1_selection_2, int64_t* cycles_per_warp_main_1_selection_3, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBDecimalType* lineitem__l_quantity, DBDateType* lineitem__l_shipdate, size_t lineitem_size) {
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
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_shipdate[ITEM], 8766, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate[ITEM], 9131, Predicate::lt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
DBDecimalType reg_lineitem__l_discount[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_discount[ITEM] = lineitem__l_discount[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_discount[ITEM], 0.05, Predicate::gte) && evaluatePredicate(reg_lineitem__l_discount[ITEM], 0.07, Predicate::lte);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
DBDecimalType reg_lineitem__l_quantity[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_quantity[ITEM] = lineitem__l_quantity[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_lineitem__l_quantity[ITEM], 24.0, Predicate::lt);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_3[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_map_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_5[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_5[ITEM] = 0;
}
//Aggregate in hashtable
DBDecimalType reg_lineitem__l_extendedprice[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
reg_lineitem__l_extendedprice[ITEM] = lineitem__l_extendedprice[ITEM*TB + tid];
}
DBDecimalType reg_map0__tmp_attr1[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_map0__tmp_attr1[ITEM] = (reg_lineitem__l_extendedprice[ITEM]) * (reg_lineitem__l_discount[ITEM]);
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < lineitem_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_5 = get_aggregation_slot(KEY_5[ITEM], HT_5, SLOT_COUNT_5);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5], reg_map0__tmp_attr1[ITEM]);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_aggregation_5[blockIdx.x] = cycles_per_warp;}
}
__global__ void main_7(size_t COUNT5, DBDecimalType* MAT6aggr0__tmp_attr0, uint64_t* MAT_IDX6, DBDecimalType* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_7_materialize_6) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBDecimalType reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT5); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT5); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx6 = atomicAdd((int*)MAT_IDX6, 1);
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
int64_t* d_cycles_per_warp_main_1_selection_2;
auto main_1_selection_2_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_2, sizeof(int64_t) * main_1_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_2, -1, sizeof(int64_t) * main_1_selection_2_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_3;
auto main_1_selection_3_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_3, sizeof(int64_t) * main_1_selection_3_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_3, -1, sizeof(int64_t) * main_1_selection_3_cpw_size);
int64_t* d_cycles_per_warp_main_1_map_4;
auto main_1_map_4_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_map_4, sizeof(int64_t) * main_1_map_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_map_4, -1, sizeof(int64_t) * main_1_map_4_cpw_size);
int64_t* d_cycles_per_warp_main_1_aggregation_5;
auto main_1_aggregation_5_cpw_size = std::ceil((float)lineitem_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_aggregation_5, sizeof(int64_t) * main_1_aggregation_5_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_aggregation_5, -1, sizeof(int64_t) * main_1_aggregation_5_cpw_size);
size_t COUNT5 = 1;
auto d_HT_5 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_5;
cudaMalloc(&d_SLOT_COUNT_5, sizeof(int));
cudaMemset(d_SLOT_COUNT_5, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5);
main_1<<<std::ceil((float)lineitem_size/(float)TILE_SIZE), TB>>>(d_HT_5.ref(cuco::insert_and_find), d_SLOT_COUNT_5, d_aggr0__tmp_attr0, d_cycles_per_warp_main_1_aggregation_5, d_cycles_per_warp_main_1_map_4, d_cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_2, d_cycles_per_warp_main_1_selection_3, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_quantity, d_lineitem__l_shipdate, lineitem_size);
int64_t* cycles_per_warp_main_1_selection_0 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_0 ";
for (auto i=0ull; i < main_1_selection_0_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_0[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_selection_2 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_2_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_2, d_cycles_per_warp_main_1_selection_2, sizeof(int64_t) * main_1_selection_2_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_2 ";
for (auto i=0ull; i < main_1_selection_2_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_2[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_selection_3 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_3_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_3, d_cycles_per_warp_main_1_selection_3, sizeof(int64_t) * main_1_selection_3_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_3 ";
for (auto i=0ull; i < main_1_selection_3_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_3[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_map_4 = (int64_t*)malloc(sizeof(int64_t) * main_1_map_4_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_map_4, d_cycles_per_warp_main_1_map_4, sizeof(int64_t) * main_1_map_4_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_map_4 ";
for (auto i=0ull; i < main_1_map_4_cpw_size; i++) std::cout << cycles_per_warp_main_1_map_4[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_aggregation_5 = (int64_t*)malloc(sizeof(int64_t) * main_1_aggregation_5_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_aggregation_5, d_cycles_per_warp_main_1_aggregation_5, sizeof(int64_t) * main_1_aggregation_5_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_aggregation_5 ";
for (auto i=0ull; i < main_1_aggregation_5_cpw_size; i++) std::cout << cycles_per_warp_main_1_aggregation_5[i] << " ";
std::cout << std::endl;
COUNT5 = d_HT_5.size();
int64_t* d_cycles_per_warp_main_7_materialize_6;
auto main_7_materialize_6_cpw_size = std::ceil((float)COUNT5/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_materialize_6, sizeof(int64_t) * main_7_materialize_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_materialize_6, -1, sizeof(int64_t) * main_7_materialize_6_cpw_size);
size_t COUNT6 = COUNT5;
//Materialize buffers
uint64_t* d_MAT_IDX6;
cudaMalloc(&d_MAT_IDX6, sizeof(uint64_t));
cudaMemset(d_MAT_IDX6, 0, sizeof(uint64_t));
auto MAT6aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT6);
DBDecimalType* d_MAT6aggr0__tmp_attr0;
cudaMalloc(&d_MAT6aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6);
main_7<<<std::ceil((float)COUNT5/(float)TILE_SIZE), TB>>>(COUNT5, d_MAT6aggr0__tmp_attr0, d_MAT_IDX6, d_aggr0__tmp_attr0, d_cycles_per_warp_main_7_materialize_6);
uint64_t MATCOUNT_6 = 0;
cudaMemcpy(&MATCOUNT_6, d_MAT_IDX6, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT6aggr0__tmp_attr0, d_MAT6aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6, cudaMemcpyDeviceToHost);
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
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_MAT6aggr0__tmp_attr0);
cudaFree(d_MAT_IDX6);
free(MAT6aggr0__tmp_attr0);
}