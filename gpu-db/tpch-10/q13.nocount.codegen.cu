#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
#include <chrono>
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT HT_0, DBI32Type* customer__c_custkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_0 = atomicAdd((int*)BUF_IDX_0, 1);
HT_0.insert(cuco::pair{KEY_0, buf_idx_0});
BUF_0[buf_idx_0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE_PK, typename HASHTABLE_FIND>
__global__ void main_3(uint64_t* BUF_0, HASHTABLE_PROBE_PK HT_0, HASHTABLE_FIND HT_2, DBI32Type* KEY_2customer__c_custkey, int* SLOT_COUNT_2, DBI64Type* aggr0__tmp_attr0, DBI32Type* customer__c_custkey, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_0 |= reg_orders__o_custkey;
//Probe Hash table
auto SLOT_0 = HT_0.find(KEY_0);
if (SLOT_0 == HT_0.end()) return;
if (!(true)) return;
uint64_t KEY_2 = 0;
auto reg_customer__c_custkey = customer__c_custkey[BUF_0[SLOT_0->second * 1 + 0]];

KEY_2 |= reg_customer__c_custkey;
//Aggregate in hashtable
auto buf_idx_2 = get_aggregation_slot(KEY_2, HT_2, SLOT_COUNT_2);
auto reg_orders__o_orderkey = orders__o_orderkey[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_2], 1);
KEY_2customer__c_custkey[buf_idx_2] = reg_customer__c_custkey;
}
template<typename HASHTABLE_FIND>
__global__ void main_5(size_t COUNT2, HASHTABLE_FIND HT_4, DBI64Type* KEY_4aggr0__tmp_attr0, int* SLOT_COUNT_4, DBI64Type* aggr0__tmp_attr0, DBI64Type* aggr1__tmp_attr1) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT2) return;
uint64_t KEY_4 = 0;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];

KEY_4 |= (DBI32Type)reg_aggr0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_4 = get_aggregation_slot(KEY_4, HT_4, SLOT_COUNT_4);
aggregate_sum(&aggr1__tmp_attr1[buf_idx_4], 1);
KEY_4aggr0__tmp_attr0[buf_idx_4] = reg_aggr0__tmp_attr0;
}
__global__ void main_7(size_t COUNT4, DBI64Type* MAT6aggr0__tmp_attr0, DBI64Type* MAT6aggr1__tmp_attr1, uint64_t* MAT_IDX6, DBI64Type* aggr0__tmp_attr0, DBI64Type* aggr1__tmp_attr1) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT4) return;
//Materialize buffers
auto mat_idx6 = atomicAdd((int*)MAT_IDX6, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT6aggr0__tmp_attr0[mat_idx6] = reg_aggr0__tmp_attr0;
auto reg_aggr1__tmp_attr1 = aggr1__tmp_attr1[tid];
MAT6aggr1__tmp_attr1[mat_idx6] = reg_aggr1__tmp_attr1;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
size_t COUNT0 = customer_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_0;
cudaMalloc(&d_BUF_IDX_0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_0, 0, sizeof(uint64_t));
uint64_t* d_BUF_0;
cudaMalloc(&d_BUF_0, sizeof(uint64_t) * COUNT0 * 1);
auto d_HT_0 = cuco::static_map{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_customer__c_custkey, customer_size);
cudaFree(d_BUF_IDX_0);
size_t COUNT2 = 15000000;
auto d_HT_2 = cuco::static_map{ (int)15000000*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_2;
cudaMalloc(&d_SLOT_COUNT_2, sizeof(int));
cudaMemset(d_SLOT_COUNT_2, 0, sizeof(int));
//Aggregate in hashtable
DBI64Type* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT2);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT2);
DBI32Type* d_KEY_2customer__c_custkey;
cudaMalloc(&d_KEY_2customer__c_custkey, sizeof(DBI32Type) * COUNT2);
cudaMemset(d_KEY_2customer__c_custkey, 0, sizeof(DBI32Type) * COUNT2);
main_3<<<std::ceil((float)orders_size/128.), 128>>>(d_BUF_0, d_HT_0.ref(cuco::find), d_HT_2.ref(cuco::insert_and_find), d_KEY_2customer__c_custkey, d_SLOT_COUNT_2, d_aggr0__tmp_attr0, d_customer__c_custkey, d_orders__o_custkey, d_orders__o_orderkey, orders_size);
COUNT2 = d_HT_2.size();
size_t COUNT4 = 15000000;
auto d_HT_4 = cuco::static_map{ (int)15000000*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_4;
cudaMalloc(&d_SLOT_COUNT_4, sizeof(int));
cudaMemset(d_SLOT_COUNT_4, 0, sizeof(int));
//Aggregate in hashtable
DBI64Type* d_aggr1__tmp_attr1;
cudaMalloc(&d_aggr1__tmp_attr1, sizeof(DBI64Type) * COUNT4);
cudaMemset(d_aggr1__tmp_attr1, 0, sizeof(DBI64Type) * COUNT4);
DBI64Type* d_KEY_4aggr0__tmp_attr0;
cudaMalloc(&d_KEY_4aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT4);
cudaMemset(d_KEY_4aggr0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT4);
main_5<<<std::ceil((float)COUNT2/128.), 128>>>(COUNT2, d_HT_4.ref(cuco::insert_and_find), d_KEY_4aggr0__tmp_attr0, d_SLOT_COUNT_4, d_aggr0__tmp_attr0, d_aggr1__tmp_attr1);
COUNT4 = d_HT_4.size();
size_t COUNT6 = COUNT4;
//Materialize buffers
uint64_t* d_MAT_IDX6;
cudaMalloc(&d_MAT_IDX6, sizeof(uint64_t));
cudaMemset(d_MAT_IDX6, 0, sizeof(uint64_t));
auto MAT6aggr0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT6);
DBI64Type* d_MAT6aggr0__tmp_attr0;
cudaMalloc(&d_MAT6aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT6);
auto MAT6aggr1__tmp_attr1 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT6);
DBI64Type* d_MAT6aggr1__tmp_attr1;
cudaMalloc(&d_MAT6aggr1__tmp_attr1, sizeof(DBI64Type) * COUNT6);
main_7<<<std::ceil((float)COUNT4/128.), 128>>>(COUNT4, d_MAT6aggr0__tmp_attr0, d_MAT6aggr1__tmp_attr1, d_MAT_IDX6, d_KEY_4aggr0__tmp_attr0, d_aggr1__tmp_attr1);
uint64_t MATCOUNT_6 = 0;
cudaMemcpy(&MATCOUNT_6, d_MAT_IDX6, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT6aggr0__tmp_attr0, d_MAT6aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT6, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT6aggr1__tmp_attr1, d_MAT6aggr1__tmp_attr1, sizeof(DBI64Type) * COUNT6, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
std::clog << "Query execution time: " << duration.count() / 1000. << " milliseconds." << std::endl;

for (auto i=0ull; i < MATCOUNT_6; i++) { std::cout << "" << MAT6aggr0__tmp_attr0[i];
std::cout << "|" << MAT6aggr1__tmp_attr1[i];
std::cout << std::endl; }
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_0);
cudaFree(d_BUF_IDX_0);
cudaFree(d_KEY_2customer__c_custkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_KEY_4aggr0__tmp_attr0);
cudaFree(d_aggr1__tmp_attr1);
cudaFree(d_MAT6aggr0__tmp_attr0);
cudaFree(d_MAT6aggr1__tmp_attr1);
cudaFree(d_MAT_IDX6);
free(MAT6aggr0__tmp_attr0);
free(MAT6aggr1__tmp_attr1);
}