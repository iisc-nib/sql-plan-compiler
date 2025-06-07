#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
#include <chrono>
__global__ void count_1(uint64_t* COUNT0, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8674, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::lt))) return;
//Materialize count
atomicAdd((int*)COUNT0, 1);
}
template<typename HASHTABLE_INSERT_PK>
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT_PK HT_0, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8674, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::lt))) return;
uint64_t KEY_0 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_0 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_0 = atomicAdd((int*)BUF_IDX_0, 1);
HT_0.insert(cuco::pair{KEY_0, buf_idx_0});
BUF_0[buf_idx_0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE_PK>
__global__ void count_3(uint64_t* BUF_0, uint64_t* COUNT2, HASHTABLE_PROBE_PK HT_0, DBI32Type* lineitem__l_orderkey, DBCharType* lineitem__l_returnflag, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_returnflag = lineitem__l_returnflag[tid];
if (!(evaluatePredicate(reg_lineitem__l_returnflag, 'R', Predicate::eq))) return;
uint64_t KEY_0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_0 |= reg_lineitem__l_orderkey;
//Probe Hash table
auto SLOT_0 = HT_0.find(KEY_0);
if (SLOT_0 == HT_0.end()) return;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT2, 1);
}
template<typename HASHTABLE_PROBE_PK, typename HASHTABLE_INSERT>
__global__ void main_3(uint64_t* BUF_0, uint64_t* BUF_2, uint64_t* BUF_IDX_2, HASHTABLE_PROBE_PK HT_0, HASHTABLE_INSERT HT_2, DBI32Type* lineitem__l_orderkey, DBCharType* lineitem__l_returnflag, size_t lineitem_size, DBI32Type* orders__o_custkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_returnflag = lineitem__l_returnflag[tid];
if (!(evaluatePredicate(reg_lineitem__l_returnflag, 'R', Predicate::eq))) return;
uint64_t KEY_0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_0 |= reg_lineitem__l_orderkey;
//Probe Hash table
auto SLOT_0 = HT_0.find(KEY_0);
if (SLOT_0 == HT_0.end()) return;
if (!(true)) return;
uint64_t KEY_2 = 0;
auto reg_orders__o_custkey = orders__o_custkey[BUF_0[SLOT_0->second * 1 + 0]];

KEY_2 |= reg_orders__o_custkey;
// Insert hash table kernel;
auto buf_idx_2 = atomicAdd((int*)BUF_IDX_2, 1);
HT_2.insert(cuco::pair{KEY_2, buf_idx_2});
BUF_2[buf_idx_2 * 2 + 0] = BUF_0[SLOT_0->second * 1 + 0];
BUF_2[buf_idx_2 * 2 + 1] = tid;
}
__global__ void count_5(uint64_t* COUNT4, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
//Materialize count
atomicAdd((int*)COUNT4, 1);
}
template<typename HASHTABLE_INSERT_PK>
__global__ void main_5(uint64_t* BUF_4, uint64_t* BUF_IDX_4, HASHTABLE_INSERT_PK HT_4, DBI32Type* nation__n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_4 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_4 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_4 = atomicAdd((int*)BUF_IDX_4, 1);
HT_4.insert(cuco::pair{KEY_4, buf_idx_4});
BUF_4[buf_idx_4 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_PROBE_PK, typename HASHTABLE_INSERT>
__global__ void count_7(uint64_t* BUF_2, uint64_t* BUF_4, HASHTABLE_PROBE HT_2, HASHTABLE_PROBE_PK HT_4, HASHTABLE_INSERT HT_6, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_2 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_2 |= reg_customer__c_custkey;
//Probe Hash table
HT_2.for_each(KEY_2, [&] __device__ (auto const SLOT_2) {

auto const [slot_first2, slot_second2] = SLOT_2;
if (!(true)) return;
uint64_t KEY_4 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_4 |= reg_customer__c_nationkey;
//Probe Hash table
auto SLOT_4 = HT_4.find(KEY_4);
if (SLOT_4 == HT_4.end()) return;
if (!(true)) return;
uint64_t KEY_6 = 0;

KEY_6 |= reg_customer__c_custkey;
//Create aggregation hash table
HT_6.insert(cuco::pair{KEY_6, 1});
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_PROBE_PK, typename HASHTABLE_FIND>
__global__ void main_7(uint64_t* BUF_2, uint64_t* BUF_4, HASHTABLE_PROBE HT_2, HASHTABLE_PROBE_PK HT_4, HASHTABLE_FIND HT_6, DBI32Type* KEY_6customer__c_custkey, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr__c_acctbal, DBI16Type* aggr__n_name_encoded, DBDecimalType* customer__c_acctbal, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI16Type* nation__n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_2 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_2 |= reg_customer__c_custkey;
//Probe Hash table
HT_2.for_each(KEY_2, [&] __device__ (auto const SLOT_2) {
auto const [slot_first2, slot_second2] = SLOT_2;
if (!(true)) return;
uint64_t KEY_4 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_4 |= reg_customer__c_nationkey;
//Probe Hash table
auto SLOT_4 = HT_4.find(KEY_4);
if (SLOT_4 == HT_4.end()) return;
if (!(true)) return;
uint64_t KEY_6 = 0;

KEY_6 |= reg_customer__c_custkey;
//Aggregate in hashtable
auto buf_idx_6 = HT_6.find(KEY_6)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[BUF_2[slot_second2 * 2 + 1]];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[BUF_2[slot_second2 * 2 + 1]];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1.0) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_6], reg_map0__tmp_attr1);
auto reg_nation__n_name_encoded = nation__n_name_encoded[BUF_4[SLOT_4->second * 1 + 0]];
aggregate_any(&aggr__n_name_encoded[buf_idx_6], reg_nation__n_name_encoded);
auto reg_customer__c_acctbal = customer__c_acctbal[tid];
aggregate_any(&aggr__c_acctbal[buf_idx_6], reg_customer__c_acctbal);
KEY_6customer__c_custkey[buf_idx_6] = reg_customer__c_custkey;
});
}
__global__ void count_9(size_t COUNT6, uint64_t* COUNT8) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT6) return;
//Materialize count
atomicAdd((int*)COUNT8, 1);
}
__global__ void main_9(size_t COUNT6, DBDecimalType* MAT8aggr0__tmp_attr0, DBDecimalType* MAT8aggr__c_acctbal, DBI16Type* MAT8aggr__n_name_encoded, DBI32Type* MAT8customer__c_custkey, uint64_t* MAT_IDX8, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr__c_acctbal, DBI16Type* aggr__n_name_encoded, DBI32Type* customer__c_custkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT6) return;
//Materialize buffers
auto mat_idx8 = atomicAdd((int*)MAT_IDX8, 1);
auto reg_customer__c_custkey = customer__c_custkey[tid];
MAT8customer__c_custkey[mat_idx8] = reg_customer__c_custkey;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT8aggr0__tmp_attr0[mat_idx8] = reg_aggr0__tmp_attr0;
auto reg_aggr__c_acctbal = aggr__c_acctbal[tid];
MAT8aggr__c_acctbal[mat_idx8] = reg_aggr__c_acctbal;
auto reg_aggr__n_name_encoded = aggr__n_name_encoded[tid];
MAT8aggr__n_name_encoded[mat_idx8] = reg_aggr__n_name_encoded;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
//Materialize count
uint64_t* d_COUNT0;
cudaMalloc(&d_COUNT0, sizeof(uint64_t));
cudaMemset(d_COUNT0, 0, sizeof(uint64_t));
count_1<<<std::ceil((float)orders_size/128.), 128>>>(d_COUNT0, d_orders__o_orderdate, orders_size);
uint64_t COUNT0;
cudaMemcpy(&COUNT0, d_COUNT0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_0;
cudaMalloc(&d_BUF_IDX_0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_0, 0, sizeof(uint64_t));
uint64_t* d_BUF_0;
cudaMalloc(&d_BUF_0, sizeof(uint64_t) * COUNT0 * 1);
auto d_HT_0 = cuco::static_map{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)orders_size/128.), 128>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
//Materialize count
uint64_t* d_COUNT2;
cudaMalloc(&d_COUNT2, sizeof(uint64_t));
cudaMemset(d_COUNT2, 0, sizeof(uint64_t));
count_3<<<std::ceil((float)lineitem_size/128.), 128>>>(d_BUF_0, d_COUNT2, d_HT_0.ref(cuco::find), d_lineitem__l_orderkey, d_lineitem__l_returnflag, lineitem_size);
uint64_t COUNT2;
cudaMemcpy(&COUNT2, d_COUNT2, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_2;
cudaMalloc(&d_BUF_IDX_2, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_2, 0, sizeof(uint64_t));
uint64_t* d_BUF_2;
cudaMalloc(&d_BUF_2, sizeof(uint64_t) * COUNT2 * 2);
auto d_HT_2 = cuco::experimental::static_multimap{ (int)COUNT2*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)lineitem_size/128.), 128>>>(d_BUF_0, d_BUF_2, d_BUF_IDX_2, d_HT_0.ref(cuco::find), d_HT_2.ref(cuco::insert), d_lineitem__l_orderkey, d_lineitem__l_returnflag, lineitem_size, d_orders__o_custkey);
//Materialize count
uint64_t* d_COUNT4;
cudaMalloc(&d_COUNT4, sizeof(uint64_t));
cudaMemset(d_COUNT4, 0, sizeof(uint64_t));
count_5<<<std::ceil((float)nation_size/128.), 128>>>(d_COUNT4, nation_size);
uint64_t COUNT4;
cudaMemcpy(&COUNT4, d_COUNT4, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_4;
cudaMalloc(&d_BUF_IDX_4, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_4, 0, sizeof(uint64_t));
uint64_t* d_BUF_4;
cudaMalloc(&d_BUF_4, sizeof(uint64_t) * COUNT4 * 1);
auto d_HT_4 = cuco::static_map{ (int)COUNT4*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)nation_size/128.), 128>>>(d_BUF_4, d_BUF_IDX_4, d_HT_4.ref(cuco::insert), d_nation__n_nationkey, nation_size);
//Create aggregation hash table
auto d_HT_6 = cuco::static_map{ (int)466296*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_7<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_2, d_BUF_4, d_HT_2.ref(cuco::for_each), d_HT_4.ref(cuco::find), d_HT_6.ref(cuco::insert), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
size_t COUNT6 = d_HT_6.size();
thrust::device_vector<int64_t> keys_6(COUNT6), vals_6(COUNT6);
d_HT_6.retrieve_all(keys_6.begin(), vals_6.begin());
d_HT_6.clear();
int64_t* raw_keys6 = thrust::raw_pointer_cast(keys_6.data());
insertKeys<<<std::ceil((float)COUNT6/128.), 128>>>(raw_keys6, d_HT_6.ref(cuco::insert), COUNT6);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT6);
DBI16Type* d_aggr__n_name_encoded;
cudaMalloc(&d_aggr__n_name_encoded, sizeof(DBI16Type) * COUNT6);
cudaMemset(d_aggr__n_name_encoded, 0, sizeof(DBI16Type) * COUNT6);
auto aggr__n_name_map = nation__n_name_map;
DBDecimalType* d_aggr__c_acctbal;
cudaMalloc(&d_aggr__c_acctbal, sizeof(DBDecimalType) * COUNT6);
cudaMemset(d_aggr__c_acctbal, 0, sizeof(DBDecimalType) * COUNT6);
DBI32Type* d_KEY_6customer__c_custkey;
cudaMalloc(&d_KEY_6customer__c_custkey, sizeof(DBI32Type) * COUNT6);
cudaMemset(d_KEY_6customer__c_custkey, 0, sizeof(DBI32Type) * COUNT6);
main_7<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_2, d_BUF_4, d_HT_2.ref(cuco::for_each), d_HT_4.ref(cuco::find), d_HT_6.ref(cuco::find), d_KEY_6customer__c_custkey, d_aggr0__tmp_attr0, d_aggr__c_acctbal, d_aggr__n_name_encoded, d_customer__c_acctbal, d_customer__c_custkey, d_customer__c_nationkey, customer_size, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_nation__n_name_encoded);
//Materialize count
uint64_t* d_COUNT8;
cudaMalloc(&d_COUNT8, sizeof(uint64_t));
cudaMemset(d_COUNT8, 0, sizeof(uint64_t));
count_9<<<std::ceil((float)COUNT6/128.), 128>>>(COUNT6, d_COUNT8);
uint64_t COUNT8;
cudaMemcpy(&COUNT8, d_COUNT8, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX8;
cudaMalloc(&d_MAT_IDX8, sizeof(uint64_t));
cudaMemset(d_MAT_IDX8, 0, sizeof(uint64_t));
auto MAT8customer__c_custkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT8);
DBI32Type* d_MAT8customer__c_custkey;
cudaMalloc(&d_MAT8customer__c_custkey, sizeof(DBI32Type) * COUNT8);
auto MAT8aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT8);
DBDecimalType* d_MAT8aggr0__tmp_attr0;
cudaMalloc(&d_MAT8aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT8);
auto MAT8aggr__c_acctbal = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT8);
DBDecimalType* d_MAT8aggr__c_acctbal;
cudaMalloc(&d_MAT8aggr__c_acctbal, sizeof(DBDecimalType) * COUNT8);
auto MAT8aggr__n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT8);
DBI16Type* d_MAT8aggr__n_name_encoded;
cudaMalloc(&d_MAT8aggr__n_name_encoded, sizeof(DBI16Type) * COUNT8);
main_9<<<std::ceil((float)COUNT6/128.), 128>>>(COUNT6, d_MAT8aggr0__tmp_attr0, d_MAT8aggr__c_acctbal, d_MAT8aggr__n_name_encoded, d_MAT8customer__c_custkey, d_MAT_IDX8, d_aggr0__tmp_attr0, d_aggr__c_acctbal, d_aggr__n_name_encoded, d_KEY_6customer__c_custkey);
cudaMemcpy(MAT8customer__c_custkey, d_MAT8customer__c_custkey, sizeof(DBI32Type) * COUNT8, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT8aggr0__tmp_attr0, d_MAT8aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT8, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT8aggr__c_acctbal, d_MAT8aggr__c_acctbal, sizeof(DBDecimalType) * COUNT8, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT8aggr__n_name_encoded, d_MAT8aggr__n_name_encoded, sizeof(DBI16Type) * COUNT8, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
std::clog << "Query execution time: " << duration.count() / 1000. << " milliseconds." << std::endl;

for (auto i=0ull; i < COUNT8; i++) { std::cout << "" << MAT8customer__c_custkey[i];
std::cout << "|" << MAT8aggr0__tmp_attr0[i];
std::cout << "|" << MAT8aggr__c_acctbal[i];
std::cout << "|" << aggr__n_name_map[MAT8aggr__n_name_encoded[i]];
std::cout << std::endl; }
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_0);
cudaFree(d_BUF_IDX_0);
cudaFree(d_COUNT0);
cudaFree(d_BUF_2);
cudaFree(d_BUF_IDX_2);
cudaFree(d_COUNT2);
cudaFree(d_BUF_4);
cudaFree(d_BUF_IDX_4);
cudaFree(d_COUNT4);
cudaFree(d_KEY_6customer__c_custkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_aggr__c_acctbal);
cudaFree(d_aggr__n_name_encoded);
cudaFree(d_COUNT8);
cudaFree(d_MAT8aggr0__tmp_attr0);
cudaFree(d_MAT8aggr__c_acctbal);
cudaFree(d_MAT8aggr__n_name_encoded);
cudaFree(d_MAT8customer__c_custkey);
cudaFree(d_MAT_IDX8);
free(MAT8aggr0__tmp_attr0);
free(MAT8aggr__c_acctbal);
free(MAT8aggr__n_name_encoded);
free(MAT8customer__c_custkey);
}