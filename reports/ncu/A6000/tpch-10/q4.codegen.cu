#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
#include <chrono>
__global__ void count_1(uint64_t* COUNT0, DBDateType* lineitem__l_commitdate, DBDateType* lineitem__l_receiptdate, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_commitdate = lineitem__l_commitdate[tid];
auto reg_lineitem__l_receiptdate = lineitem__l_receiptdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_commitdate, reg_lineitem__l_receiptdate, Predicate::lt))) return;
//Materialize count
atomicAdd((int*)COUNT0, 1);
}
template<typename HASHTABLE_INSERT_SJ>
__global__ void main_1(HASHTABLE_INSERT_SJ HT_0, DBDateType* lineitem__l_commitdate, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_receiptdate, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_commitdate = lineitem__l_commitdate[tid];
auto reg_lineitem__l_receiptdate = lineitem__l_receiptdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_commitdate, reg_lineitem__l_receiptdate, Predicate::lt))) return;
uint64_t KEY_0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_0 |= reg_lineitem__l_orderkey;
// Insert hash table kernel;
HT_0.insert(cuco::pair{KEY_0, 1});
}
template<typename HASHTABLE_PROBE_SJ, typename HASHTABLE_INSERT>
__global__ void count_3(HASHTABLE_PROBE_SJ HT_0, HASHTABLE_INSERT HT_2, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, DBI16Type* orders__o_orderpriority_encoded, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8582, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 8674, Predicate::lt))) return;
uint64_t KEY_0 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_0 |= reg_orders__o_orderkey;
//Probe Hash table
auto SLOT_0 = HT_0.find(KEY_0);
if (SLOT_0 == HT_0.end()) return;
if (!(true)) return;
uint64_t KEY_2 = 0;
auto reg_orders__o_orderpriority_encoded = orders__o_orderpriority_encoded[tid];

KEY_2 |= reg_orders__o_orderpriority_encoded;
//Create aggregation hash table
HT_2.insert(cuco::pair{KEY_2, 1});
}
template<typename HASHTABLE_PROBE_SJ, typename HASHTABLE_FIND>
__global__ void main_3(HASHTABLE_PROBE_SJ HT_0, HASHTABLE_FIND HT_2, DBI16Type* KEY_2orders__o_orderpriority_encoded, DBI64Type* aggr0__tmp_attr0, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, DBI16Type* orders__o_orderpriority_encoded, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8582, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 8674, Predicate::lt))) return;
uint64_t KEY_0 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_0 |= reg_orders__o_orderkey;
//Probe Hash table
auto SLOT_0 = HT_0.find(KEY_0);
if (SLOT_0 == HT_0.end()) return;
if (!(true)) return;
uint64_t KEY_2 = 0;
auto reg_orders__o_orderpriority_encoded = orders__o_orderpriority_encoded[tid];

KEY_2 |= reg_orders__o_orderpriority_encoded;
//Aggregate in hashtable
auto buf_idx_2 = HT_2.find(KEY_2)->second;
aggregate_sum(&aggr0__tmp_attr0[buf_idx_2], 1);
KEY_2orders__o_orderpriority_encoded[buf_idx_2] = reg_orders__o_orderpriority_encoded;
}
__global__ void count_5(size_t COUNT2, uint64_t* COUNT4) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT2) return;
//Materialize count
atomicAdd((int*)COUNT4, 1);
}
__global__ void main_5(size_t COUNT2, DBI64Type* MAT4aggr0__tmp_attr0, DBI16Type* MAT4orders__o_orderpriority_encoded, uint64_t* MAT_IDX4, DBI64Type* aggr0__tmp_attr0, DBI16Type* orders__o_orderpriority_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT2) return;
//Materialize buffers
auto mat_idx4 = atomicAdd((int*)MAT_IDX4, 1);
auto reg_orders__o_orderpriority_encoded = orders__o_orderpriority_encoded[tid];
MAT4orders__o_orderpriority_encoded[mat_idx4] = reg_orders__o_orderpriority_encoded;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT4aggr0__tmp_attr0[mat_idx4] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
//Materialize count
uint64_t* d_COUNT0;
cudaMalloc(&d_COUNT0, sizeof(uint64_t));
cudaMemset(d_COUNT0, 0, sizeof(uint64_t));
count_1<<<std::ceil((float)lineitem_size/128.), 128>>>(d_COUNT0, d_lineitem__l_commitdate, d_lineitem__l_receiptdate, lineitem_size);
uint64_t COUNT0;
cudaMemcpy(&COUNT0, d_COUNT0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
auto d_HT_0 = cuco::static_map{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)lineitem_size/128.), 128>>>(d_HT_0.ref(cuco::insert), d_lineitem__l_commitdate, d_lineitem__l_orderkey, d_lineitem__l_receiptdate, lineitem_size);
//Create aggregation hash table
auto d_HT_2 = cuco::static_map{ (int)644532*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_3<<<std::ceil((float)orders_size/128.), 128>>>(d_HT_0.ref(cuco::find), d_HT_2.ref(cuco::insert), d_orders__o_orderdate, d_orders__o_orderkey, d_orders__o_orderpriority_encoded, orders_size);
size_t COUNT2 = d_HT_2.size();
thrust::device_vector<int64_t> keys_2(COUNT2), vals_2(COUNT2);
d_HT_2.retrieve_all(keys_2.begin(), vals_2.begin());
d_HT_2.clear();
int64_t* raw_keys2 = thrust::raw_pointer_cast(keys_2.data());
insertKeys<<<std::ceil((float)COUNT2/128.), 128>>>(raw_keys2, d_HT_2.ref(cuco::insert), COUNT2);
//Aggregate in hashtable
DBI64Type* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT2);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT2);
DBI16Type* d_KEY_2orders__o_orderpriority_encoded;
cudaMalloc(&d_KEY_2orders__o_orderpriority_encoded, sizeof(DBI16Type) * COUNT2);
cudaMemset(d_KEY_2orders__o_orderpriority_encoded, 0, sizeof(DBI16Type) * COUNT2);
main_3<<<std::ceil((float)orders_size/128.), 128>>>(d_HT_0.ref(cuco::find), d_HT_2.ref(cuco::find), d_KEY_2orders__o_orderpriority_encoded, d_aggr0__tmp_attr0, d_orders__o_orderdate, d_orders__o_orderkey, d_orders__o_orderpriority_encoded, orders_size);
//Materialize count
uint64_t* d_COUNT4;
cudaMalloc(&d_COUNT4, sizeof(uint64_t));
cudaMemset(d_COUNT4, 0, sizeof(uint64_t));
count_5<<<std::ceil((float)COUNT2/128.), 128>>>(COUNT2, d_COUNT4);
uint64_t COUNT4;
cudaMemcpy(&COUNT4, d_COUNT4, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX4;
cudaMalloc(&d_MAT_IDX4, sizeof(uint64_t));
cudaMemset(d_MAT_IDX4, 0, sizeof(uint64_t));
auto MAT4orders__o_orderpriority_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT4);
DBI16Type* d_MAT4orders__o_orderpriority_encoded;
cudaMalloc(&d_MAT4orders__o_orderpriority_encoded, sizeof(DBI16Type) * COUNT4);
auto MAT4aggr0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT4);
DBI64Type* d_MAT4aggr0__tmp_attr0;
cudaMalloc(&d_MAT4aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT4);
main_5<<<std::ceil((float)COUNT2/128.), 128>>>(COUNT2, d_MAT4aggr0__tmp_attr0, d_MAT4orders__o_orderpriority_encoded, d_MAT_IDX4, d_aggr0__tmp_attr0, d_KEY_2orders__o_orderpriority_encoded);
cudaMemcpy(MAT4orders__o_orderpriority_encoded, d_MAT4orders__o_orderpriority_encoded, sizeof(DBI16Type) * COUNT4, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT4aggr0__tmp_attr0, d_MAT4aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT4, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
std::clog << "Query execution time: " << duration.count() / 1000. << " milliseconds." << std::endl;

for (auto i=0ull; i < COUNT4; i++) { std::cout << "" << orders__o_orderpriority_map[MAT4orders__o_orderpriority_encoded[i]];
std::cout << "|" << MAT4aggr0__tmp_attr0[i];
std::cout << std::endl; }
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_COUNT0);
cudaFree(d_KEY_2orders__o_orderpriority_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT4);
cudaFree(d_MAT4aggr0__tmp_attr0);
cudaFree(d_MAT4orders__o_orderpriority_encoded);
cudaFree(d_MAT_IDX4);
free(MAT4aggr0__tmp_attr0);
free(MAT4orders__o_orderpriority_encoded);
}