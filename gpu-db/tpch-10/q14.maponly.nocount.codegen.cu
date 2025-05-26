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
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT HT_0, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
uint64_t KEY_0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_0 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_0 = atomicAdd((int*)BUF_IDX_0, 1);
HT_0.insert(cuco::pair{KEY_0, buf_idx_0});
BUF_0[buf_idx_0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE_PK, typename HASHTABLE_FIND>
__global__ void main_3(uint64_t* BUF_0, HASHTABLE_PROBE_PK HT_0, HASHTABLE_FIND HT_2, int* SLOT_COUNT_2, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_partkey, DBDateType* lineitem__l_shipdate, size_t lineitem_size, DBStringType* part__p_type) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9374, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9404, Predicate::lt))) return;
uint64_t KEY_0 = 0;
auto reg_lineitem__l_partkey = lineitem__l_partkey[tid];

KEY_0 |= reg_lineitem__l_partkey;
//Probe Hash table
auto SLOT_0 = HT_0.find(KEY_0);
if (SLOT_0 == HT_0.end()) return;
if (!(true)) return;
auto reg_part__p_type = part__p_type[BUF_0[SLOT_0->second * 1 + 0]];
uint64_t KEY_2 = 0;
//Aggregate in hashtable
auto buf_idx_2 = get_aggregation_slot(KEY_2, HT_2, SLOT_COUNT_2);
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr3 = (reg_lineitem__l_extendedprice) * ((1.0) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_2], reg_map0__tmp_attr3);
auto reg_map0__tmp_attr1 = ((Like(reg_part__p_type, "PROMO", "", nullptr, nullptr, 0))) ? ((reg_lineitem__l_extendedprice) * ((1.0) - (reg_lineitem__l_discount))) : (0.0);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_2], reg_map0__tmp_attr1);
}
__global__ void main_5(size_t COUNT2, DBDecimalType* MAT4map1__tmp_attr4, uint64_t* MAT_IDX4, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr0__tmp_attr2) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT2) return;
//Materialize buffers
auto mat_idx4 = atomicAdd((int*)MAT_IDX4, 1);
auto reg_aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
auto reg_map1__tmp_attr4 = ((100.00) * (reg_aggr0__tmp_attr0)) / (reg_aggr0__tmp_attr2);
MAT4map1__tmp_attr4[mat_idx4] = reg_map1__tmp_attr4;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
size_t COUNT0 = part_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_0;
cudaMalloc(&d_BUF_IDX_0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_0, 0, sizeof(uint64_t));
uint64_t* d_BUF_0;
cudaMalloc(&d_BUF_0, sizeof(uint64_t) * COUNT0 * 1);
auto d_HT_0 = cuco::static_map{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)part_size/128.), 128>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_part__p_partkey, part_size);
cudaFree(d_BUF_IDX_0);
size_t COUNT2 = 1;
auto d_HT_2 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_2;
cudaMalloc(&d_SLOT_COUNT_2, sizeof(int));
cudaMemset(d_SLOT_COUNT_2, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT2);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT2);
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT2);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT2);
main_3<<<std::ceil((float)lineitem_size/128.), 128>>>(d_BUF_0, d_HT_0.ref(cuco::find), d_HT_2.ref(cuco::insert_and_find), d_SLOT_COUNT_2, d_aggr0__tmp_attr0, d_aggr0__tmp_attr2, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_partkey, d_lineitem__l_shipdate, lineitem_size, d_part__p_type);
COUNT2 = d_HT_2.size();
size_t COUNT4 = COUNT2;
//Materialize buffers
uint64_t* d_MAT_IDX4;
cudaMalloc(&d_MAT_IDX4, sizeof(uint64_t));
cudaMemset(d_MAT_IDX4, 0, sizeof(uint64_t));
auto MAT4map1__tmp_attr4 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT4);
DBDecimalType* d_MAT4map1__tmp_attr4;
cudaMalloc(&d_MAT4map1__tmp_attr4, sizeof(DBDecimalType) * COUNT4);
main_5<<<std::ceil((float)COUNT2/128.), 128>>>(COUNT2, d_MAT4map1__tmp_attr4, d_MAT_IDX4, d_aggr0__tmp_attr0, d_aggr0__tmp_attr2);
uint64_t MATCOUNT_4 = 0;
cudaMemcpy(&MATCOUNT_4, d_MAT_IDX4, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT4map1__tmp_attr4, d_MAT4map1__tmp_attr4, sizeof(DBDecimalType) * COUNT4, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
std::clog << "Query execution time: " << duration.count() / 1000. << " milliseconds." << std::endl;

for (auto i=0ull; i < MATCOUNT_4; i++) { std::cout << "" << MAT4map1__tmp_attr4[i];
std::cout << std::endl; }
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_0);
cudaFree(d_BUF_IDX_0);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_MAT4map1__tmp_attr4);
cudaFree(d_MAT_IDX4);
free(MAT4map1__tmp_attr4);
}