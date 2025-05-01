#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5861716cf1b0(uint64_t* COUNT5861716e1bc0, DBStringType* customer__c_mktsegment, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_mktsegment = customer__c_mktsegment[tid];
if (!(evaluatePredicate(reg_customer__c_mktsegment, "BUILDING", Predicate::eq))) return;
//Materialize count
atomicAdd((int*)COUNT5861716e1bc0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5861716cf1b0(uint64_t* BUF_5861716e1bc0, uint64_t* BUF_IDX_5861716e1bc0, HASHTABLE_INSERT HT_5861716e1bc0, DBI32Type* customer__c_custkey, DBStringType* customer__c_mktsegment, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_mktsegment = customer__c_mktsegment[tid];
if (!(evaluatePredicate(reg_customer__c_mktsegment, "BUILDING", Predicate::eq))) return;
uint64_t KEY_5861716e1bc0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5861716e1bc0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_5861716e1bc0 = atomicAdd((int*)BUF_IDX_5861716e1bc0, 1);
HT_5861716e1bc0.insert(cuco::pair{KEY_5861716e1bc0, buf_idx_5861716e1bc0});
BUF_5861716e1bc0[buf_idx_5861716e1bc0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5861716cf480(uint64_t* BUF_5861716e1bc0, uint64_t* COUNT5861716e1f10, HASHTABLE_PROBE HT_5861716e1bc0, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 9204, Predicate::lt))) return;
uint64_t KEY_5861716e1bc0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_5861716e1bc0 |= reg_orders__o_custkey;
//Probe Hash table
HT_5861716e1bc0.for_each(KEY_5861716e1bc0, [&] __device__ (auto const SLOT_5861716e1bc0) {

auto const [slot_first5861716e1bc0, slot_second5861716e1bc0] = SLOT_5861716e1bc0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5861716e1f10, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5861716cf480(uint64_t* BUF_5861716e1bc0, uint64_t* BUF_5861716e1f10, uint64_t* BUF_IDX_5861716e1f10, HASHTABLE_PROBE HT_5861716e1bc0, HASHTABLE_INSERT HT_5861716e1f10, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 9204, Predicate::lt))) return;
uint64_t KEY_5861716e1bc0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_5861716e1bc0 |= reg_orders__o_custkey;
//Probe Hash table
HT_5861716e1bc0.for_each(KEY_5861716e1bc0, [&] __device__ (auto const SLOT_5861716e1bc0) {
auto const [slot_first5861716e1bc0, slot_second5861716e1bc0] = SLOT_5861716e1bc0;
if (!(true)) return;
uint64_t KEY_5861716e1f10 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_5861716e1f10 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_5861716e1f10 = atomicAdd((int*)BUF_IDX_5861716e1f10, 1);
HT_5861716e1f10.insert(cuco::pair{KEY_5861716e1f10, buf_idx_5861716e1f10});
BUF_5861716e1f10[buf_idx_5861716e1f10 * 2 + 0] = BUF_5861716e1bc0[slot_second5861716e1bc0 * 1 + 0];
BUF_5861716e1f10[buf_idx_5861716e1f10 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5861716eef40(uint64_t* BUF_5861716e1f10, HASHTABLE_INSERT HT_58617169d2b0, HASHTABLE_PROBE HT_5861716e1f10, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9204, Predicate::gt))) return;
uint64_t KEY_5861716e1f10 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5861716e1f10 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5861716e1f10.for_each(KEY_5861716e1f10, [&] __device__ (auto const SLOT_5861716e1f10) {

auto const [slot_first5861716e1f10, slot_second5861716e1f10] = SLOT_5861716e1f10;
if (!(true)) return;
uint64_t KEY_58617169d2b0 = 0;

KEY_58617169d2b0 |= reg_lineitem__l_orderkey;
//Create aggregation hash table
HT_58617169d2b0.insert(cuco::pair{KEY_58617169d2b0, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5861716eef40(uint64_t* BUF_5861716e1f10, HASHTABLE_FIND HT_58617169d2b0, HASHTABLE_PROBE HT_5861716e1f10, DBI32Type* KEY_58617169d2b0lineitem__l_orderkey, DBDecimalType* aggr0__tmp_attr0, DBDateType* aggr__o_orderdate, DBI32Type* aggr__o_shippriority, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, size_t lineitem_size, DBDateType* orders__o_orderdate, DBI32Type* orders__o_shippriority) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9204, Predicate::gt))) return;
uint64_t KEY_5861716e1f10 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5861716e1f10 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5861716e1f10.for_each(KEY_5861716e1f10, [&] __device__ (auto const SLOT_5861716e1f10) {
auto const [slot_first5861716e1f10, slot_second5861716e1f10] = SLOT_5861716e1f10;
if (!(true)) return;
uint64_t KEY_58617169d2b0 = 0;

KEY_58617169d2b0 |= reg_lineitem__l_orderkey;
//Aggregate in hashtable
auto buf_idx_58617169d2b0 = HT_58617169d2b0.find(KEY_58617169d2b0)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_58617169d2b0], reg_map0__tmp_attr1);
auto reg_orders__o_shippriority = orders__o_shippriority[BUF_5861716e1f10[slot_second5861716e1f10 * 2 + 1]];
aggregate_any(&aggr__o_shippriority[buf_idx_58617169d2b0], reg_orders__o_shippriority);
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_5861716e1f10[slot_second5861716e1f10 * 2 + 1]];
aggregate_any(&aggr__o_orderdate[buf_idx_58617169d2b0], reg_orders__o_orderdate);
KEY_58617169d2b0lineitem__l_orderkey[buf_idx_58617169d2b0] = reg_lineitem__l_orderkey;
});
}
__global__ void count_5861716fb300(uint64_t* COUNT58617167be90, size_t COUNT58617169d2b0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT58617169d2b0) return;
//Materialize count
atomicAdd((int*)COUNT58617167be90, 1);
}
__global__ void main_5861716fb300(size_t COUNT58617169d2b0, DBDecimalType* MAT58617167be90aggr0__tmp_attr0, DBDateType* MAT58617167be90aggr__o_orderdate, DBI32Type* MAT58617167be90aggr__o_shippriority, DBI32Type* MAT58617167be90lineitem__l_orderkey, uint64_t* MAT_IDX58617167be90, DBDecimalType* aggr0__tmp_attr0, DBDateType* aggr__o_orderdate, DBI32Type* aggr__o_shippriority, DBI32Type* lineitem__l_orderkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT58617169d2b0) return;
//Materialize buffers
auto mat_idx58617167be90 = atomicAdd((int*)MAT_IDX58617167be90, 1);
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];
MAT58617167be90lineitem__l_orderkey[mat_idx58617167be90] = reg_lineitem__l_orderkey;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT58617167be90aggr0__tmp_attr0[mat_idx58617167be90] = reg_aggr0__tmp_attr0;
auto reg_aggr__o_orderdate = aggr__o_orderdate[tid];
MAT58617167be90aggr__o_orderdate[mat_idx58617167be90] = reg_aggr__o_orderdate;
auto reg_aggr__o_shippriority = aggr__o_shippriority[tid];
MAT58617167be90aggr__o_shippriority[mat_idx58617167be90] = reg_aggr__o_shippriority;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map) {
//Materialize count
uint64_t* d_COUNT5861716e1bc0;
cudaMalloc(&d_COUNT5861716e1bc0, sizeof(uint64_t));
cudaMemset(d_COUNT5861716e1bc0, 0, sizeof(uint64_t));
count_5861716cf1b0<<<std::ceil((float)customer_size/32.), 32>>>(d_COUNT5861716e1bc0, d_customer__c_mktsegment, customer_size);
uint64_t COUNT5861716e1bc0;
cudaMemcpy(&COUNT5861716e1bc0, d_COUNT5861716e1bc0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5861716e1bc0;
cudaMalloc(&d_BUF_IDX_5861716e1bc0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5861716e1bc0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5861716e1bc0;
cudaMalloc(&d_BUF_5861716e1bc0, sizeof(uint64_t) * COUNT5861716e1bc0 * 1);
auto d_HT_5861716e1bc0 = cuco::experimental::static_multimap{ (int)COUNT5861716e1bc0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5861716cf1b0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5861716e1bc0, d_BUF_IDX_5861716e1bc0, d_HT_5861716e1bc0.ref(cuco::insert), d_customer__c_custkey, d_customer__c_mktsegment, customer_size);
//Materialize count
uint64_t* d_COUNT5861716e1f10;
cudaMalloc(&d_COUNT5861716e1f10, sizeof(uint64_t));
cudaMemset(d_COUNT5861716e1f10, 0, sizeof(uint64_t));
count_5861716cf480<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5861716e1bc0, d_COUNT5861716e1f10, d_HT_5861716e1bc0.ref(cuco::for_each), d_orders__o_custkey, d_orders__o_orderdate, orders_size);
uint64_t COUNT5861716e1f10;
cudaMemcpy(&COUNT5861716e1f10, d_COUNT5861716e1f10, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5861716e1f10;
cudaMalloc(&d_BUF_IDX_5861716e1f10, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5861716e1f10, 0, sizeof(uint64_t));
uint64_t* d_BUF_5861716e1f10;
cudaMalloc(&d_BUF_5861716e1f10, sizeof(uint64_t) * COUNT5861716e1f10 * 2);
auto d_HT_5861716e1f10 = cuco::experimental::static_multimap{ (int)COUNT5861716e1f10*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5861716cf480<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5861716e1bc0, d_BUF_5861716e1f10, d_BUF_IDX_5861716e1f10, d_HT_5861716e1bc0.ref(cuco::for_each), d_HT_5861716e1f10.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
//Create aggregation hash table
auto d_HT_58617169d2b0 = cuco::static_map{ (int)355555*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5861716eef40<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5861716e1f10, d_HT_58617169d2b0.ref(cuco::insert), d_HT_5861716e1f10.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_shipdate, lineitem_size);
size_t COUNT58617169d2b0 = d_HT_58617169d2b0.size();
thrust::device_vector<int64_t> keys_58617169d2b0(COUNT58617169d2b0), vals_58617169d2b0(COUNT58617169d2b0);
d_HT_58617169d2b0.retrieve_all(keys_58617169d2b0.begin(), vals_58617169d2b0.begin());
d_HT_58617169d2b0.clear();
int64_t* raw_keys58617169d2b0 = thrust::raw_pointer_cast(keys_58617169d2b0.data());
insertKeys<<<std::ceil((float)COUNT58617169d2b0/32.), 32>>>(raw_keys58617169d2b0, d_HT_58617169d2b0.ref(cuco::insert), COUNT58617169d2b0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT58617169d2b0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT58617169d2b0);
DBI32Type* d_aggr__o_shippriority;
cudaMalloc(&d_aggr__o_shippriority, sizeof(DBI32Type) * COUNT58617169d2b0);
cudaMemset(d_aggr__o_shippriority, 0, sizeof(DBI32Type) * COUNT58617169d2b0);
DBDateType* d_aggr__o_orderdate;
cudaMalloc(&d_aggr__o_orderdate, sizeof(DBDateType) * COUNT58617169d2b0);
cudaMemset(d_aggr__o_orderdate, 0, sizeof(DBDateType) * COUNT58617169d2b0);
DBI32Type* d_KEY_58617169d2b0lineitem__l_orderkey;
cudaMalloc(&d_KEY_58617169d2b0lineitem__l_orderkey, sizeof(DBI32Type) * COUNT58617169d2b0);
cudaMemset(d_KEY_58617169d2b0lineitem__l_orderkey, 0, sizeof(DBI32Type) * COUNT58617169d2b0);
main_5861716eef40<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5861716e1f10, d_HT_58617169d2b0.ref(cuco::find), d_HT_5861716e1f10.ref(cuco::for_each), d_KEY_58617169d2b0lineitem__l_orderkey, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, lineitem_size, d_orders__o_orderdate, d_orders__o_shippriority);
//Materialize count
uint64_t* d_COUNT58617167be90;
cudaMalloc(&d_COUNT58617167be90, sizeof(uint64_t));
cudaMemset(d_COUNT58617167be90, 0, sizeof(uint64_t));
count_5861716fb300<<<std::ceil((float)COUNT58617169d2b0/32.), 32>>>(d_COUNT58617167be90, COUNT58617169d2b0);
uint64_t COUNT58617167be90;
cudaMemcpy(&COUNT58617167be90, d_COUNT58617167be90, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX58617167be90;
cudaMalloc(&d_MAT_IDX58617167be90, sizeof(uint64_t));
cudaMemset(d_MAT_IDX58617167be90, 0, sizeof(uint64_t));
auto MAT58617167be90lineitem__l_orderkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT58617167be90);
DBI32Type* d_MAT58617167be90lineitem__l_orderkey;
cudaMalloc(&d_MAT58617167be90lineitem__l_orderkey, sizeof(DBI32Type) * COUNT58617167be90);
auto MAT58617167be90aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT58617167be90);
DBDecimalType* d_MAT58617167be90aggr0__tmp_attr0;
cudaMalloc(&d_MAT58617167be90aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT58617167be90);
auto MAT58617167be90aggr__o_orderdate = (DBDateType*)malloc(sizeof(DBDateType) * COUNT58617167be90);
DBDateType* d_MAT58617167be90aggr__o_orderdate;
cudaMalloc(&d_MAT58617167be90aggr__o_orderdate, sizeof(DBDateType) * COUNT58617167be90);
auto MAT58617167be90aggr__o_shippriority = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT58617167be90);
DBI32Type* d_MAT58617167be90aggr__o_shippriority;
cudaMalloc(&d_MAT58617167be90aggr__o_shippriority, sizeof(DBI32Type) * COUNT58617167be90);
main_5861716fb300<<<std::ceil((float)COUNT58617169d2b0/32.), 32>>>(COUNT58617169d2b0, d_MAT58617167be90aggr0__tmp_attr0, d_MAT58617167be90aggr__o_orderdate, d_MAT58617167be90aggr__o_shippriority, d_MAT58617167be90lineitem__l_orderkey, d_MAT_IDX58617167be90, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_KEY_58617169d2b0lineitem__l_orderkey);
cudaMemcpy(MAT58617167be90lineitem__l_orderkey, d_MAT58617167be90lineitem__l_orderkey, sizeof(DBI32Type) * COUNT58617167be90, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT58617167be90aggr0__tmp_attr0, d_MAT58617167be90aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT58617167be90, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT58617167be90aggr__o_orderdate, d_MAT58617167be90aggr__o_orderdate, sizeof(DBDateType) * COUNT58617167be90, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT58617167be90aggr__o_shippriority, d_MAT58617167be90aggr__o_shippriority, sizeof(DBI32Type) * COUNT58617167be90, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT58617167be90; i++) { std::cout << MAT58617167be90lineitem__l_orderkey[i] << "\t";
std::cout << MAT58617167be90aggr0__tmp_attr0[i] << "\t";
std::cout << MAT58617167be90aggr__o_orderdate[i] << "\t";
std::cout << MAT58617167be90aggr__o_shippriority[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_5861716e1bc0);
cudaFree(d_BUF_IDX_5861716e1bc0);
cudaFree(d_COUNT5861716e1bc0);
cudaFree(d_BUF_5861716e1f10);
cudaFree(d_BUF_IDX_5861716e1f10);
cudaFree(d_COUNT5861716e1f10);
cudaFree(d_KEY_58617169d2b0lineitem__l_orderkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_aggr__o_orderdate);
cudaFree(d_aggr__o_shippriority);
cudaFree(d_COUNT58617167be90);
cudaFree(d_MAT58617167be90aggr0__tmp_attr0);
cudaFree(d_MAT58617167be90aggr__o_orderdate);
cudaFree(d_MAT58617167be90aggr__o_shippriority);
cudaFree(d_MAT58617167be90lineitem__l_orderkey);
cudaFree(d_MAT_IDX58617167be90);
free(MAT58617167be90aggr0__tmp_attr0);
free(MAT58617167be90aggr__o_orderdate);
free(MAT58617167be90aggr__o_shippriority);
free(MAT58617167be90lineitem__l_orderkey);
}