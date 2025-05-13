#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_1(uint64_t* COUNT0, DBStringType* customer__c_mktsegment, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_mktsegment = customer__c_mktsegment[tid];
if (!(evaluatePredicate(reg_customer__c_mktsegment, "BUILDING", Predicate::eq))) return;
//Materialize count
atomicAdd((int*)COUNT0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_0, uint64_t* BUF_IDX_0, HASHTABLE_INSERT HT_0, DBI32Type* customer__c_custkey, DBStringType* customer__c_mktsegment, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_mktsegment = customer__c_mktsegment[tid];
if (!(evaluatePredicate(reg_customer__c_mktsegment, "BUILDING", Predicate::eq))) return;
uint64_t KEY_0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_0 = atomicAdd((int*)BUF_IDX_0, 1);
HT_0.insert(cuco::pair{KEY_0, buf_idx_0});
BUF_0[buf_idx_0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_3(uint64_t* BUF_0, uint64_t* COUNT2, HASHTABLE_PROBE HT_0, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 9204, Predicate::lt))) return;
uint64_t KEY_0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_0 |= reg_orders__o_custkey;
//Probe Hash table
HT_0.for_each(KEY_0, [&] __device__ (auto const SLOT_0) {

auto const [slot_first0, slot_second0] = SLOT_0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT2, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_3(uint64_t* BUF_0, uint64_t* BUF_2, uint64_t* BUF_IDX_2, HASHTABLE_PROBE HT_0, HASHTABLE_INSERT HT_2, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 9204, Predicate::lt))) return;
uint64_t KEY_0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_0 |= reg_orders__o_custkey;
//Probe Hash table
HT_0.for_each(KEY_0, [&] __device__ (auto const SLOT_0) {
auto const [slot_first0, slot_second0] = SLOT_0;
if (!(true)) return;
uint64_t KEY_2 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_2 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_2 = atomicAdd((int*)BUF_IDX_2, 1);
HT_2.insert(cuco::pair{KEY_2, buf_idx_2});
BUF_2[buf_idx_2 * 2 + 0] = BUF_0[slot_second0 * 1 + 0];
BUF_2[buf_idx_2 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void count_5(uint64_t* BUF_2, HASHTABLE_PROBE HT_2, HASHTABLE_INSERT HT_4, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9204, Predicate::gt))) return;
uint64_t KEY_2 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_2 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_2.for_each(KEY_2, [&] __device__ (auto const SLOT_2) {

auto const [slot_first2, slot_second2] = SLOT_2;
if (!(true)) return;
uint64_t KEY_4 = 0;

KEY_4 |= reg_lineitem__l_orderkey;
//Create aggregation hash table
HT_4.insert(cuco::pair{KEY_4, 1});
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_FIND>
__global__ void main_5(uint64_t* BUF_2, HASHTABLE_PROBE HT_2, HASHTABLE_FIND HT_4, DBI32Type* KEY_4lineitem__l_orderkey, DBDecimalType* aggr0__tmp_attr0, DBDateType* aggr__o_orderdate, DBI32Type* aggr__o_shippriority, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, size_t lineitem_size, DBDateType* orders__o_orderdate, DBI32Type* orders__o_shippriority) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9204, Predicate::gt))) return;
uint64_t KEY_2 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_2 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_2.for_each(KEY_2, [&] __device__ (auto const SLOT_2) {
auto const [slot_first2, slot_second2] = SLOT_2;
if (!(true)) return;
uint64_t KEY_4 = 0;

KEY_4 |= reg_lineitem__l_orderkey;
//Aggregate in hashtable
auto buf_idx_4 = HT_4.find(KEY_4)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1.0) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_4], reg_map0__tmp_attr1);
auto reg_orders__o_shippriority = orders__o_shippriority[BUF_2[slot_second2 * 2 + 1]];
aggregate_any(&aggr__o_shippriority[buf_idx_4], reg_orders__o_shippriority);
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_2[slot_second2 * 2 + 1]];
aggregate_any(&aggr__o_orderdate[buf_idx_4], reg_orders__o_orderdate);
KEY_4lineitem__l_orderkey[buf_idx_4] = reg_lineitem__l_orderkey;
});
}
__global__ void count_7(size_t COUNT4, uint64_t* COUNT6) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT4) return;
//Materialize count
atomicAdd((int*)COUNT6, 1);
}
__global__ void main_7(size_t COUNT4, DBDecimalType* MAT6aggr0__tmp_attr0, DBDateType* MAT6aggr__o_orderdate, DBI32Type* MAT6aggr__o_shippriority, DBI32Type* MAT6lineitem__l_orderkey, uint64_t* MAT_IDX6, DBDecimalType* aggr0__tmp_attr0, DBDateType* aggr__o_orderdate, DBI32Type* aggr__o_shippriority, DBI32Type* lineitem__l_orderkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT4) return;
//Materialize buffers
auto mat_idx6 = atomicAdd((int*)MAT_IDX6, 1);
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];
MAT6lineitem__l_orderkey[mat_idx6] = reg_lineitem__l_orderkey;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT6aggr0__tmp_attr0[mat_idx6] = reg_aggr0__tmp_attr0;
auto reg_aggr__o_orderdate = aggr__o_orderdate[tid];
MAT6aggr__o_orderdate[mat_idx6] = reg_aggr__o_orderdate;
auto reg_aggr__o_shippriority = aggr__o_shippriority[tid];
MAT6aggr__o_shippriority[mat_idx6] = reg_aggr__o_shippriority;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map) {
//Materialize count
uint64_t* d_COUNT0;
cudaMalloc(&d_COUNT0, sizeof(uint64_t));
cudaMemset(d_COUNT0, 0, sizeof(uint64_t));
count_1<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT0, d_customer__c_mktsegment, customer_size);
uint64_t COUNT0;
cudaMemcpy(&COUNT0, d_COUNT0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_0;
cudaMalloc(&d_BUF_IDX_0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_0, 0, sizeof(uint64_t));
uint64_t* d_BUF_0;
cudaMalloc(&d_BUF_0, sizeof(uint64_t) * COUNT0 * 1);
auto d_HT_0 = cuco::experimental::static_multimap{ (int)COUNT0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_0, d_BUF_IDX_0, d_HT_0.ref(cuco::insert), d_customer__c_custkey, d_customer__c_mktsegment, customer_size);
//Materialize count
uint64_t* d_COUNT2;
cudaMalloc(&d_COUNT2, sizeof(uint64_t));
cudaMemset(d_COUNT2, 0, sizeof(uint64_t));
count_3<<<std::ceil((float)orders_size/128.), 128>>>(d_BUF_0, d_COUNT2, d_HT_0.ref(cuco::for_each), d_orders__o_custkey, d_orders__o_orderdate, orders_size);
uint64_t COUNT2;
cudaMemcpy(&COUNT2, d_COUNT2, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_2;
cudaMalloc(&d_BUF_IDX_2, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_2, 0, sizeof(uint64_t));
uint64_t* d_BUF_2;
cudaMalloc(&d_BUF_2, sizeof(uint64_t) * COUNT2 * 2);
auto d_HT_2 = cuco::experimental::static_multimap{ (int)COUNT2*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)orders_size/128.), 128>>>(d_BUF_0, d_BUF_2, d_BUF_IDX_2, d_HT_0.ref(cuco::for_each), d_HT_2.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
//Create aggregation hash table
auto d_HT_4 = cuco::static_map{ (int)355555*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5<<<std::ceil((float)lineitem_size/128.), 128>>>(d_BUF_2, d_HT_2.ref(cuco::for_each), d_HT_4.ref(cuco::insert), d_lineitem__l_orderkey, d_lineitem__l_shipdate, lineitem_size);
size_t COUNT4 = d_HT_4.size();
thrust::device_vector<int64_t> keys_4(COUNT4), vals_4(COUNT4);
d_HT_4.retrieve_all(keys_4.begin(), vals_4.begin());
d_HT_4.clear();
int64_t* raw_keys4 = thrust::raw_pointer_cast(keys_4.data());
insertKeys<<<std::ceil((float)COUNT4/128.), 128>>>(raw_keys4, d_HT_4.ref(cuco::insert), COUNT4);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT4);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT4);
DBI32Type* d_aggr__o_shippriority;
cudaMalloc(&d_aggr__o_shippriority, sizeof(DBI32Type) * COUNT4);
cudaMemset(d_aggr__o_shippriority, 0, sizeof(DBI32Type) * COUNT4);
DBDateType* d_aggr__o_orderdate;
cudaMalloc(&d_aggr__o_orderdate, sizeof(DBDateType) * COUNT4);
cudaMemset(d_aggr__o_orderdate, 0, sizeof(DBDateType) * COUNT4);
DBI32Type* d_KEY_4lineitem__l_orderkey;
cudaMalloc(&d_KEY_4lineitem__l_orderkey, sizeof(DBI32Type) * COUNT4);
cudaMemset(d_KEY_4lineitem__l_orderkey, 0, sizeof(DBI32Type) * COUNT4);
main_5<<<std::ceil((float)lineitem_size/128.), 128>>>(d_BUF_2, d_HT_2.ref(cuco::for_each), d_HT_4.ref(cuco::find), d_KEY_4lineitem__l_orderkey, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, lineitem_size, d_orders__o_orderdate, d_orders__o_shippriority);
//Materialize count
uint64_t* d_COUNT6;
cudaMalloc(&d_COUNT6, sizeof(uint64_t));
cudaMemset(d_COUNT6, 0, sizeof(uint64_t));
count_7<<<std::ceil((float)COUNT4/128.), 128>>>(COUNT4, d_COUNT6);
uint64_t COUNT6;
cudaMemcpy(&COUNT6, d_COUNT6, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX6;
cudaMalloc(&d_MAT_IDX6, sizeof(uint64_t));
cudaMemset(d_MAT_IDX6, 0, sizeof(uint64_t));
auto MAT6lineitem__l_orderkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT6);
DBI32Type* d_MAT6lineitem__l_orderkey;
cudaMalloc(&d_MAT6lineitem__l_orderkey, sizeof(DBI32Type) * COUNT6);
auto MAT6aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT6);
DBDecimalType* d_MAT6aggr0__tmp_attr0;
cudaMalloc(&d_MAT6aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6);
auto MAT6aggr__o_orderdate = (DBDateType*)malloc(sizeof(DBDateType) * COUNT6);
DBDateType* d_MAT6aggr__o_orderdate;
cudaMalloc(&d_MAT6aggr__o_orderdate, sizeof(DBDateType) * COUNT6);
auto MAT6aggr__o_shippriority = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT6);
DBI32Type* d_MAT6aggr__o_shippriority;
cudaMalloc(&d_MAT6aggr__o_shippriority, sizeof(DBI32Type) * COUNT6);
main_7<<<std::ceil((float)COUNT4/128.), 128>>>(COUNT4, d_MAT6aggr0__tmp_attr0, d_MAT6aggr__o_orderdate, d_MAT6aggr__o_shippriority, d_MAT6lineitem__l_orderkey, d_MAT_IDX6, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_KEY_4lineitem__l_orderkey);
cudaMemcpy(MAT6lineitem__l_orderkey, d_MAT6lineitem__l_orderkey, sizeof(DBI32Type) * COUNT6, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT6aggr0__tmp_attr0, d_MAT6aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT6, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT6aggr__o_orderdate, d_MAT6aggr__o_orderdate, sizeof(DBDateType) * COUNT6, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT6aggr__o_shippriority, d_MAT6aggr__o_shippriority, sizeof(DBI32Type) * COUNT6, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT6; i++) { std::cout << "" << MAT6lineitem__l_orderkey[i];
std::cout << "," << MAT6aggr0__tmp_attr0[i];
std::cout << "," << MAT6aggr__o_orderdate[i];
std::cout << "," << MAT6aggr__o_shippriority[i];
std::cout << std::endl; }
cudaFree(d_BUF_0);
cudaFree(d_BUF_IDX_0);
cudaFree(d_COUNT0);
cudaFree(d_BUF_2);
cudaFree(d_BUF_IDX_2);
cudaFree(d_COUNT2);
cudaFree(d_KEY_4lineitem__l_orderkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_aggr__o_orderdate);
cudaFree(d_aggr__o_shippriority);
cudaFree(d_COUNT6);
cudaFree(d_MAT6aggr0__tmp_attr0);
cudaFree(d_MAT6aggr__o_orderdate);
cudaFree(d_MAT6aggr__o_shippriority);
cudaFree(d_MAT6lineitem__l_orderkey);
cudaFree(d_MAT_IDX6);
free(MAT6aggr0__tmp_attr0);
free(MAT6aggr__o_orderdate);
free(MAT6aggr__o_shippriority);
free(MAT6lineitem__l_orderkey);
}