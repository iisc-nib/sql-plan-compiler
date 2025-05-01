#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_59c0b9dd83d0(uint64_t* COUNT59c0b9dea900, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8674, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::lt))) return;
//Materialize count
atomicAdd((int*)COUNT59c0b9dea900, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_59c0b9dd83d0(uint64_t* BUF_59c0b9dea900, uint64_t* BUF_IDX_59c0b9dea900, HASHTABLE_INSERT HT_59c0b9dea900, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8674, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::lt))) return;
uint64_t KEY_59c0b9dea900 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_59c0b9dea900 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_59c0b9dea900 = atomicAdd((int*)BUF_IDX_59c0b9dea900, 1);
HT_59c0b9dea900.insert(cuco::pair{KEY_59c0b9dea900, buf_idx_59c0b9dea900});
BUF_59c0b9dea900[buf_idx_59c0b9dea900 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_59c0b9df6db0(uint64_t* BUF_59c0b9dea900, uint64_t* COUNT59c0b9dea7b0, HASHTABLE_PROBE HT_59c0b9dea900, DBI32Type* lineitem__l_orderkey, DBCharType* lineitem__l_returnflag, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_returnflag = lineitem__l_returnflag[tid];
if (!(evaluatePredicate(reg_lineitem__l_returnflag, 'R', Predicate::eq))) return;
uint64_t KEY_59c0b9dea900 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_59c0b9dea900 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_59c0b9dea900.for_each(KEY_59c0b9dea900, [&] __device__ (auto const SLOT_59c0b9dea900) {

auto const [slot_first59c0b9dea900, slot_second59c0b9dea900] = SLOT_59c0b9dea900;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT59c0b9dea7b0, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_59c0b9df6db0(uint64_t* BUF_59c0b9dea7b0, uint64_t* BUF_59c0b9dea900, uint64_t* BUF_IDX_59c0b9dea7b0, HASHTABLE_INSERT HT_59c0b9dea7b0, HASHTABLE_PROBE HT_59c0b9dea900, DBI32Type* lineitem__l_orderkey, DBCharType* lineitem__l_returnflag, size_t lineitem_size, DBI32Type* orders__o_custkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_returnflag = lineitem__l_returnflag[tid];
if (!(evaluatePredicate(reg_lineitem__l_returnflag, 'R', Predicate::eq))) return;
uint64_t KEY_59c0b9dea900 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_59c0b9dea900 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_59c0b9dea900.for_each(KEY_59c0b9dea900, [&] __device__ (auto const SLOT_59c0b9dea900) {
auto const [slot_first59c0b9dea900, slot_second59c0b9dea900] = SLOT_59c0b9dea900;
if (!(true)) return;
uint64_t KEY_59c0b9dea7b0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[BUF_59c0b9dea900[slot_second59c0b9dea900 * 1 + 0]];

KEY_59c0b9dea7b0 |= reg_orders__o_custkey;
// Insert hash table kernel;
auto buf_idx_59c0b9dea7b0 = atomicAdd((int*)BUF_IDX_59c0b9dea7b0, 1);
HT_59c0b9dea7b0.insert(cuco::pair{KEY_59c0b9dea7b0, buf_idx_59c0b9dea7b0});
BUF_59c0b9dea7b0[buf_idx_59c0b9dea7b0 * 2 + 0] = BUF_59c0b9dea900[slot_second59c0b9dea900 * 1 + 0];
BUF_59c0b9dea7b0[buf_idx_59c0b9dea7b0 * 2 + 1] = tid;
});
}
__global__ void count_59c0b9e01e90(uint64_t* COUNT59c0b9dec1b0, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
//Materialize count
atomicAdd((int*)COUNT59c0b9dec1b0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_59c0b9e01e90(uint64_t* BUF_59c0b9dec1b0, uint64_t* BUF_IDX_59c0b9dec1b0, HASHTABLE_INSERT HT_59c0b9dec1b0, DBI32Type* nation__n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_59c0b9dec1b0 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_59c0b9dec1b0 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_59c0b9dec1b0 = atomicAdd((int*)BUF_IDX_59c0b9dec1b0, 1);
HT_59c0b9dec1b0.insert(cuco::pair{KEY_59c0b9dec1b0, buf_idx_59c0b9dec1b0});
BUF_59c0b9dec1b0[buf_idx_59c0b9dec1b0 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_59c0b9dd8040(uint64_t* BUF_59c0b9dea7b0, uint64_t* BUF_59c0b9dec1b0, HASHTABLE_INSERT HT_59c0b9da7b00, HASHTABLE_PROBE HT_59c0b9dea7b0, HASHTABLE_PROBE HT_59c0b9dec1b0, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_59c0b9dea7b0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_59c0b9dea7b0 |= reg_customer__c_custkey;
//Probe Hash table
HT_59c0b9dea7b0.for_each(KEY_59c0b9dea7b0, [&] __device__ (auto const SLOT_59c0b9dea7b0) {

auto const [slot_first59c0b9dea7b0, slot_second59c0b9dea7b0] = SLOT_59c0b9dea7b0;
if (!(true)) return;
uint64_t KEY_59c0b9dec1b0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_59c0b9dec1b0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_59c0b9dec1b0.for_each(KEY_59c0b9dec1b0, [&] __device__ (auto const SLOT_59c0b9dec1b0) {

auto const [slot_first59c0b9dec1b0, slot_second59c0b9dec1b0] = SLOT_59c0b9dec1b0;
if (!(true)) return;
uint64_t KEY_59c0b9da7b00 = 0;

KEY_59c0b9da7b00 |= reg_customer__c_custkey;
//Create aggregation hash table
HT_59c0b9da7b00.insert(cuco::pair{KEY_59c0b9da7b00, 1});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_59c0b9dd8040(uint64_t* BUF_59c0b9dea7b0, uint64_t* BUF_59c0b9dec1b0, HASHTABLE_FIND HT_59c0b9da7b00, HASHTABLE_PROBE HT_59c0b9dea7b0, HASHTABLE_PROBE HT_59c0b9dec1b0, DBI32Type* KEY_59c0b9da7b00customer__c_custkey, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr__c_acctbal, DBDecimalType* customer__c_acctbal, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_59c0b9dea7b0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_59c0b9dea7b0 |= reg_customer__c_custkey;
//Probe Hash table
HT_59c0b9dea7b0.for_each(KEY_59c0b9dea7b0, [&] __device__ (auto const SLOT_59c0b9dea7b0) {
auto const [slot_first59c0b9dea7b0, slot_second59c0b9dea7b0] = SLOT_59c0b9dea7b0;
if (!(true)) return;
uint64_t KEY_59c0b9dec1b0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_59c0b9dec1b0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_59c0b9dec1b0.for_each(KEY_59c0b9dec1b0, [&] __device__ (auto const SLOT_59c0b9dec1b0) {
auto const [slot_first59c0b9dec1b0, slot_second59c0b9dec1b0] = SLOT_59c0b9dec1b0;
if (!(true)) return;
uint64_t KEY_59c0b9da7b00 = 0;

KEY_59c0b9da7b00 |= reg_customer__c_custkey;
//Aggregate in hashtable
auto buf_idx_59c0b9da7b00 = HT_59c0b9da7b00.find(KEY_59c0b9da7b00)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[BUF_59c0b9dea7b0[slot_second59c0b9dea7b0 * 2 + 1]];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[BUF_59c0b9dea7b0[slot_second59c0b9dea7b0 * 2 + 1]];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_59c0b9da7b00], reg_map0__tmp_attr1);
auto reg_customer__c_acctbal = customer__c_acctbal[tid];
aggregate_any(&aggr__c_acctbal[buf_idx_59c0b9da7b00], reg_customer__c_acctbal);
KEY_59c0b9da7b00customer__c_custkey[buf_idx_59c0b9da7b00] = reg_customer__c_custkey;
});
});
}
__global__ void count_59c0b9e06620(uint64_t* COUNT59c0b9d85c70, size_t COUNT59c0b9da7b00) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT59c0b9da7b00) return;
//Materialize count
atomicAdd((int*)COUNT59c0b9d85c70, 1);
}
__global__ void main_59c0b9e06620(size_t COUNT59c0b9da7b00, DBDecimalType* MAT59c0b9d85c70aggr0__tmp_attr0, DBDecimalType* MAT59c0b9d85c70aggr__c_acctbal, DBI32Type* MAT59c0b9d85c70customer__c_custkey, uint64_t* MAT_IDX59c0b9d85c70, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr__c_acctbal, DBI32Type* customer__c_custkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT59c0b9da7b00) return;
//Materialize buffers
auto mat_idx59c0b9d85c70 = atomicAdd((int*)MAT_IDX59c0b9d85c70, 1);
auto reg_customer__c_custkey = customer__c_custkey[tid];
MAT59c0b9d85c70customer__c_custkey[mat_idx59c0b9d85c70] = reg_customer__c_custkey;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT59c0b9d85c70aggr0__tmp_attr0[mat_idx59c0b9d85c70] = reg_aggr0__tmp_attr0;
auto reg_aggr__c_acctbal = aggr__c_acctbal[tid];
MAT59c0b9d85c70aggr__c_acctbal[mat_idx59c0b9d85c70] = reg_aggr__c_acctbal;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map) {
//Materialize count
uint64_t* d_COUNT59c0b9dea900;
cudaMalloc(&d_COUNT59c0b9dea900, sizeof(uint64_t));
cudaMemset(d_COUNT59c0b9dea900, 0, sizeof(uint64_t));
count_59c0b9dd83d0<<<std::ceil((float)orders_size/32.), 32>>>(d_COUNT59c0b9dea900, d_orders__o_orderdate, orders_size);
uint64_t COUNT59c0b9dea900;
cudaMemcpy(&COUNT59c0b9dea900, d_COUNT59c0b9dea900, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_59c0b9dea900;
cudaMalloc(&d_BUF_IDX_59c0b9dea900, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59c0b9dea900, 0, sizeof(uint64_t));
uint64_t* d_BUF_59c0b9dea900;
cudaMalloc(&d_BUF_59c0b9dea900, sizeof(uint64_t) * COUNT59c0b9dea900 * 1);
auto d_HT_59c0b9dea900 = cuco::experimental::static_multimap{ (int)COUNT59c0b9dea900*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59c0b9dd83d0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_59c0b9dea900, d_BUF_IDX_59c0b9dea900, d_HT_59c0b9dea900.ref(cuco::insert), d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
//Materialize count
uint64_t* d_COUNT59c0b9dea7b0;
cudaMalloc(&d_COUNT59c0b9dea7b0, sizeof(uint64_t));
cudaMemset(d_COUNT59c0b9dea7b0, 0, sizeof(uint64_t));
count_59c0b9df6db0<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_59c0b9dea900, d_COUNT59c0b9dea7b0, d_HT_59c0b9dea900.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_returnflag, lineitem_size);
uint64_t COUNT59c0b9dea7b0;
cudaMemcpy(&COUNT59c0b9dea7b0, d_COUNT59c0b9dea7b0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_59c0b9dea7b0;
cudaMalloc(&d_BUF_IDX_59c0b9dea7b0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59c0b9dea7b0, 0, sizeof(uint64_t));
uint64_t* d_BUF_59c0b9dea7b0;
cudaMalloc(&d_BUF_59c0b9dea7b0, sizeof(uint64_t) * COUNT59c0b9dea7b0 * 2);
auto d_HT_59c0b9dea7b0 = cuco::experimental::static_multimap{ (int)COUNT59c0b9dea7b0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59c0b9df6db0<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_59c0b9dea7b0, d_BUF_59c0b9dea900, d_BUF_IDX_59c0b9dea7b0, d_HT_59c0b9dea7b0.ref(cuco::insert), d_HT_59c0b9dea900.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_returnflag, lineitem_size, d_orders__o_custkey);
//Materialize count
uint64_t* d_COUNT59c0b9dec1b0;
cudaMalloc(&d_COUNT59c0b9dec1b0, sizeof(uint64_t));
cudaMemset(d_COUNT59c0b9dec1b0, 0, sizeof(uint64_t));
count_59c0b9e01e90<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT59c0b9dec1b0, nation_size);
uint64_t COUNT59c0b9dec1b0;
cudaMemcpy(&COUNT59c0b9dec1b0, d_COUNT59c0b9dec1b0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_59c0b9dec1b0;
cudaMalloc(&d_BUF_IDX_59c0b9dec1b0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59c0b9dec1b0, 0, sizeof(uint64_t));
uint64_t* d_BUF_59c0b9dec1b0;
cudaMalloc(&d_BUF_59c0b9dec1b0, sizeof(uint64_t) * COUNT59c0b9dec1b0 * 1);
auto d_HT_59c0b9dec1b0 = cuco::experimental::static_multimap{ (int)COUNT59c0b9dec1b0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59c0b9e01e90<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_59c0b9dec1b0, d_BUF_IDX_59c0b9dec1b0, d_HT_59c0b9dec1b0.ref(cuco::insert), d_nation__n_nationkey, nation_size);
//Create aggregation hash table
auto d_HT_59c0b9da7b00 = cuco::static_map{ (int)45145*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_59c0b9dd8040<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_59c0b9dea7b0, d_BUF_59c0b9dec1b0, d_HT_59c0b9da7b00.ref(cuco::insert), d_HT_59c0b9dea7b0.ref(cuco::for_each), d_HT_59c0b9dec1b0.ref(cuco::for_each), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
size_t COUNT59c0b9da7b00 = d_HT_59c0b9da7b00.size();
thrust::device_vector<int64_t> keys_59c0b9da7b00(COUNT59c0b9da7b00), vals_59c0b9da7b00(COUNT59c0b9da7b00);
d_HT_59c0b9da7b00.retrieve_all(keys_59c0b9da7b00.begin(), vals_59c0b9da7b00.begin());
d_HT_59c0b9da7b00.clear();
int64_t* raw_keys59c0b9da7b00 = thrust::raw_pointer_cast(keys_59c0b9da7b00.data());
insertKeys<<<std::ceil((float)COUNT59c0b9da7b00/32.), 32>>>(raw_keys59c0b9da7b00, d_HT_59c0b9da7b00.ref(cuco::insert), COUNT59c0b9da7b00);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT59c0b9da7b00);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT59c0b9da7b00);
DBDecimalType* d_aggr__c_acctbal;
cudaMalloc(&d_aggr__c_acctbal, sizeof(DBDecimalType) * COUNT59c0b9da7b00);
cudaMemset(d_aggr__c_acctbal, 0, sizeof(DBDecimalType) * COUNT59c0b9da7b00);
DBI32Type* d_KEY_59c0b9da7b00customer__c_custkey;
cudaMalloc(&d_KEY_59c0b9da7b00customer__c_custkey, sizeof(DBI32Type) * COUNT59c0b9da7b00);
cudaMemset(d_KEY_59c0b9da7b00customer__c_custkey, 0, sizeof(DBI32Type) * COUNT59c0b9da7b00);
main_59c0b9dd8040<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_59c0b9dea7b0, d_BUF_59c0b9dec1b0, d_HT_59c0b9da7b00.ref(cuco::find), d_HT_59c0b9dea7b0.ref(cuco::for_each), d_HT_59c0b9dec1b0.ref(cuco::for_each), d_KEY_59c0b9da7b00customer__c_custkey, d_aggr0__tmp_attr0, d_aggr__c_acctbal, d_customer__c_acctbal, d_customer__c_custkey, d_customer__c_nationkey, customer_size, d_lineitem__l_discount, d_lineitem__l_extendedprice);
//Materialize count
uint64_t* d_COUNT59c0b9d85c70;
cudaMalloc(&d_COUNT59c0b9d85c70, sizeof(uint64_t));
cudaMemset(d_COUNT59c0b9d85c70, 0, sizeof(uint64_t));
count_59c0b9e06620<<<std::ceil((float)COUNT59c0b9da7b00/32.), 32>>>(d_COUNT59c0b9d85c70, COUNT59c0b9da7b00);
uint64_t COUNT59c0b9d85c70;
cudaMemcpy(&COUNT59c0b9d85c70, d_COUNT59c0b9d85c70, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX59c0b9d85c70;
cudaMalloc(&d_MAT_IDX59c0b9d85c70, sizeof(uint64_t));
cudaMemset(d_MAT_IDX59c0b9d85c70, 0, sizeof(uint64_t));
auto MAT59c0b9d85c70customer__c_custkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT59c0b9d85c70);
DBI32Type* d_MAT59c0b9d85c70customer__c_custkey;
cudaMalloc(&d_MAT59c0b9d85c70customer__c_custkey, sizeof(DBI32Type) * COUNT59c0b9d85c70);
auto MAT59c0b9d85c70aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT59c0b9d85c70);
DBDecimalType* d_MAT59c0b9d85c70aggr0__tmp_attr0;
cudaMalloc(&d_MAT59c0b9d85c70aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT59c0b9d85c70);
auto MAT59c0b9d85c70aggr__c_acctbal = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT59c0b9d85c70);
DBDecimalType* d_MAT59c0b9d85c70aggr__c_acctbal;
cudaMalloc(&d_MAT59c0b9d85c70aggr__c_acctbal, sizeof(DBDecimalType) * COUNT59c0b9d85c70);
main_59c0b9e06620<<<std::ceil((float)COUNT59c0b9da7b00/32.), 32>>>(COUNT59c0b9da7b00, d_MAT59c0b9d85c70aggr0__tmp_attr0, d_MAT59c0b9d85c70aggr__c_acctbal, d_MAT59c0b9d85c70customer__c_custkey, d_MAT_IDX59c0b9d85c70, d_aggr0__tmp_attr0, d_aggr__c_acctbal, d_KEY_59c0b9da7b00customer__c_custkey);
cudaMemcpy(MAT59c0b9d85c70customer__c_custkey, d_MAT59c0b9d85c70customer__c_custkey, sizeof(DBI32Type) * COUNT59c0b9d85c70, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59c0b9d85c70aggr0__tmp_attr0, d_MAT59c0b9d85c70aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT59c0b9d85c70, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59c0b9d85c70aggr__c_acctbal, d_MAT59c0b9d85c70aggr__c_acctbal, sizeof(DBDecimalType) * COUNT59c0b9d85c70, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT59c0b9d85c70; i++) { std::cout << MAT59c0b9d85c70customer__c_custkey[i] << "\t";
std::cout << MAT59c0b9d85c70aggr0__tmp_attr0[i] << "\t";
std::cout << MAT59c0b9d85c70aggr__c_acctbal[i] << "\t";
std::cout << std::endl; }
std::cout << COUNT59c0b9d85c70 << std::endl;
cudaFree(d_BUF_59c0b9dea900);
cudaFree(d_BUF_IDX_59c0b9dea900);
cudaFree(d_COUNT59c0b9dea900);
cudaFree(d_BUF_59c0b9dea7b0);
cudaFree(d_BUF_IDX_59c0b9dea7b0);
cudaFree(d_COUNT59c0b9dea7b0);
cudaFree(d_BUF_59c0b9dec1b0);
cudaFree(d_BUF_IDX_59c0b9dec1b0);
cudaFree(d_COUNT59c0b9dec1b0);
cudaFree(d_KEY_59c0b9da7b00customer__c_custkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_aggr__c_acctbal);
cudaFree(d_COUNT59c0b9d85c70);
cudaFree(d_MAT59c0b9d85c70aggr0__tmp_attr0);
cudaFree(d_MAT59c0b9d85c70aggr__c_acctbal);
cudaFree(d_MAT59c0b9d85c70customer__c_custkey);
cudaFree(d_MAT_IDX59c0b9d85c70);
free(MAT59c0b9d85c70aggr0__tmp_attr0);
free(MAT59c0b9d85c70aggr__c_acctbal);
free(MAT59c0b9d85c70customer__c_custkey);
}