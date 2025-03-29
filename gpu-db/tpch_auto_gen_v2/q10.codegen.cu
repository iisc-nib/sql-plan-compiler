#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5c784e87bbf0(uint64_t* COUNT5c784e88dc70, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8674, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::lt))) return;
//Materialize count
atomicAdd((int*)COUNT5c784e88dc70, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5c784e87bbf0(uint64_t* BUF_5c784e88dc70, uint64_t* BUF_IDX_5c784e88dc70, HASHTABLE_INSERT HT_5c784e88dc70, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8674, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::lt))) return;
uint64_t KEY_5c784e88dc70 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_5c784e88dc70 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_5c784e88dc70 = atomicAdd((int*)BUF_IDX_5c784e88dc70, 1);
HT_5c784e88dc70.insert(cuco::pair{KEY_5c784e88dc70, buf_idx_5c784e88dc70});
BUF_5c784e88dc70[buf_idx_5c784e88dc70 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5c784e89ab40(uint64_t* BUF_5c784e88dc70, uint64_t* COUNT5c784e88e120, HASHTABLE_PROBE HT_5c784e88dc70, DBI32Type* lineitem__l_orderkey, DBCharType* lineitem__l_returnflag, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_returnflag = lineitem__l_returnflag[tid];
if (!(evaluatePredicate(reg_lineitem__l_returnflag, "R", Predicate::eq))) return;
uint64_t KEY_5c784e88dc70 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5c784e88dc70 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5c784e88dc70.for_each(KEY_5c784e88dc70, [&] __device__ (auto const SLOT_5c784e88dc70) {

auto const [slot_first5c784e88dc70, slot_second5c784e88dc70] = SLOT_5c784e88dc70;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5c784e88e120, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5c784e89ab40(uint64_t* BUF_5c784e88dc70, uint64_t* BUF_5c784e88e120, uint64_t* BUF_IDX_5c784e88e120, HASHTABLE_PROBE HT_5c784e88dc70, HASHTABLE_INSERT HT_5c784e88e120, DBI32Type* lineitem__l_orderkey, DBCharType* lineitem__l_returnflag, size_t lineitem_size, DBI32Type* orders__o_custkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_returnflag = lineitem__l_returnflag[tid];
if (!(evaluatePredicate(reg_lineitem__l_returnflag, "R", Predicate::eq))) return;
uint64_t KEY_5c784e88dc70 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5c784e88dc70 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5c784e88dc70.for_each(KEY_5c784e88dc70, [&] __device__ (auto const SLOT_5c784e88dc70) {
auto const [slot_first5c784e88dc70, slot_second5c784e88dc70] = SLOT_5c784e88dc70;
if (!(true)) return;
uint64_t KEY_5c784e88e120 = 0;
auto reg_orders__o_custkey = orders__o_custkey[BUF_5c784e88dc70[slot_second5c784e88dc70 * 1 + 0]];

KEY_5c784e88e120 |= reg_orders__o_custkey;
// Insert hash table kernel;
auto buf_idx_5c784e88e120 = atomicAdd((int*)BUF_IDX_5c784e88e120, 1);
HT_5c784e88e120.insert(cuco::pair{KEY_5c784e88e120, buf_idx_5c784e88e120});
BUF_5c784e88e120[buf_idx_5c784e88e120 * 2 + 0] = BUF_5c784e88dc70[slot_second5c784e88dc70 * 1 + 0];
BUF_5c784e88e120[buf_idx_5c784e88e120 * 2 + 1] = tid;
});
}
__global__ void count_5c784e8a42d0(uint64_t* COUNT5c784e890710, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
//Materialize count
atomicAdd((int*)COUNT5c784e890710, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5c784e8a42d0(uint64_t* BUF_5c784e890710, uint64_t* BUF_IDX_5c784e890710, HASHTABLE_INSERT HT_5c784e890710, DBI32Type* nation__n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_5c784e890710 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_5c784e890710 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_5c784e890710 = atomicAdd((int*)BUF_IDX_5c784e890710, 1);
HT_5c784e890710.insert(cuco::pair{KEY_5c784e890710, buf_idx_5c784e890710});
BUF_5c784e890710[buf_idx_5c784e890710 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5c784e87b860(uint64_t* BUF_5c784e88e120, uint64_t* BUF_5c784e890710, HASHTABLE_INSERT HT_5c784e84b800, HASHTABLE_PROBE HT_5c784e88e120, HASHTABLE_PROBE HT_5c784e890710, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_5c784e88e120 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5c784e88e120 |= reg_customer__c_custkey;
//Probe Hash table
HT_5c784e88e120.for_each(KEY_5c784e88e120, [&] __device__ (auto const SLOT_5c784e88e120) {

auto const [slot_first5c784e88e120, slot_second5c784e88e120] = SLOT_5c784e88e120;
if (!(true)) return;
uint64_t KEY_5c784e890710 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_5c784e890710 |= reg_customer__c_nationkey;
//Probe Hash table
HT_5c784e890710.for_each(KEY_5c784e890710, [&] __device__ (auto const SLOT_5c784e890710) {

auto const [slot_first5c784e890710, slot_second5c784e890710] = SLOT_5c784e890710;
if (!(true)) return;
uint64_t KEY_5c784e84b800 = 0;

KEY_5c784e84b800 |= reg_customer__c_custkey;
//Create aggregation hash table
HT_5c784e84b800.insert(cuco::pair{KEY_5c784e84b800, 1});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5c784e87b860(uint64_t* BUF_5c784e88e120, uint64_t* BUF_5c784e890710, HASHTABLE_FIND HT_5c784e84b800, HASHTABLE_PROBE HT_5c784e88e120, HASHTABLE_PROBE HT_5c784e890710, DBI32Type* KEY_5c784e84b800customer__c_custkey, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr__c_acctbal, DBStringType* aggr__c_address, DBStringType* aggr__c_comment, DBStringType* aggr__c_name, DBStringType* aggr__c_phone, DBStringType* aggr__n_name, DBDecimalType* customer__c_acctbal, DBStringType* customer__c_address, DBStringType* customer__c_comment, DBI32Type* customer__c_custkey, DBStringType* customer__c_name, DBI32Type* customer__c_nationkey, DBStringType* customer__c_phone, size_t customer_size, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBStringType* nation__n_name) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_5c784e88e120 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5c784e88e120 |= reg_customer__c_custkey;
//Probe Hash table
HT_5c784e88e120.for_each(KEY_5c784e88e120, [&] __device__ (auto const SLOT_5c784e88e120) {
auto const [slot_first5c784e88e120, slot_second5c784e88e120] = SLOT_5c784e88e120;
if (!(true)) return;
uint64_t KEY_5c784e890710 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_5c784e890710 |= reg_customer__c_nationkey;
//Probe Hash table
HT_5c784e890710.for_each(KEY_5c784e890710, [&] __device__ (auto const SLOT_5c784e890710) {
auto const [slot_first5c784e890710, slot_second5c784e890710] = SLOT_5c784e890710;
if (!(true)) return;
uint64_t KEY_5c784e84b800 = 0;

KEY_5c784e84b800 |= reg_customer__c_custkey;
//Aggregate in hashtable
auto buf_idx_5c784e84b800 = HT_5c784e84b800.find(KEY_5c784e84b800)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[BUF_5c784e88e120[slot_second5c784e88e120 * 2 + 1]];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[BUF_5c784e88e120[slot_second5c784e88e120 * 2 + 1]];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5c784e84b800], reg_map0__tmp_attr1);
auto reg_customer__c_comment = customer__c_comment[tid];
aggregate_any(&aggr__c_comment[buf_idx_5c784e84b800], reg_customer__c_comment);
auto reg_customer__c_name = customer__c_name[tid];
aggregate_any(&aggr__c_name[buf_idx_5c784e84b800], reg_customer__c_name);
auto reg_customer__c_acctbal = customer__c_acctbal[tid];
aggregate_any(&aggr__c_acctbal[buf_idx_5c784e84b800], reg_customer__c_acctbal);
auto reg_customer__c_phone = customer__c_phone[tid];
aggregate_any(&aggr__c_phone[buf_idx_5c784e84b800], reg_customer__c_phone);
auto reg_nation__n_name = nation__n_name[BUF_5c784e890710[slot_second5c784e890710 * 1 + 0]];
aggregate_any(&aggr__n_name[buf_idx_5c784e84b800], reg_nation__n_name);
auto reg_customer__c_address = customer__c_address[tid];
aggregate_any(&aggr__c_address[buf_idx_5c784e84b800], reg_customer__c_address);
KEY_5c784e84b800customer__c_custkey[buf_idx_5c784e84b800] = reg_customer__c_custkey;
});
});
}
__global__ void count_5c784e8aa8e0(uint64_t* COUNT5c784e828c60, size_t COUNT5c784e84b800) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5c784e84b800) return;
//Materialize count
atomicAdd((int*)COUNT5c784e828c60, 1);
}
__global__ void main_5c784e8aa8e0(size_t COUNT5c784e84b800, DBDecimalType* MAT5c784e828c60aggr0__tmp_attr0, DBDecimalType* MAT5c784e828c60aggr__c_acctbal, DBStringType* MAT5c784e828c60aggr__c_address, DBStringType* MAT5c784e828c60aggr__c_comment, DBStringType* MAT5c784e828c60aggr__c_name, DBStringType* MAT5c784e828c60aggr__c_phone, DBStringType* MAT5c784e828c60aggr__n_name, DBI32Type* MAT5c784e828c60customer__c_custkey, uint64_t* MAT_IDX5c784e828c60, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr__c_acctbal, DBStringType* aggr__c_address, DBStringType* aggr__c_comment, DBStringType* aggr__c_name, DBStringType* aggr__c_phone, DBStringType* aggr__n_name, DBI32Type* customer__c_custkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5c784e84b800) return;
//Materialize buffers
auto mat_idx5c784e828c60 = atomicAdd((int*)MAT_IDX5c784e828c60, 1);
auto reg_customer__c_custkey = customer__c_custkey[tid];
MAT5c784e828c60customer__c_custkey[mat_idx5c784e828c60] = reg_customer__c_custkey;
auto reg_aggr__c_name = aggr__c_name[tid];
MAT5c784e828c60aggr__c_name[mat_idx5c784e828c60] = reg_aggr__c_name;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5c784e828c60aggr0__tmp_attr0[mat_idx5c784e828c60] = reg_aggr0__tmp_attr0;
auto reg_aggr__c_acctbal = aggr__c_acctbal[tid];
MAT5c784e828c60aggr__c_acctbal[mat_idx5c784e828c60] = reg_aggr__c_acctbal;
auto reg_aggr__n_name = aggr__n_name[tid];
MAT5c784e828c60aggr__n_name[mat_idx5c784e828c60] = reg_aggr__n_name;
auto reg_aggr__c_address = aggr__c_address[tid];
MAT5c784e828c60aggr__c_address[mat_idx5c784e828c60] = reg_aggr__c_address;
auto reg_aggr__c_phone = aggr__c_phone[tid];
MAT5c784e828c60aggr__c_phone[mat_idx5c784e828c60] = reg_aggr__c_phone;
auto reg_aggr__c_comment = aggr__c_comment[tid];
MAT5c784e828c60aggr__c_comment[mat_idx5c784e828c60] = reg_aggr__c_comment;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT5c784e88dc70;
cudaMalloc(&d_COUNT5c784e88dc70, sizeof(uint64_t));
cudaMemset(d_COUNT5c784e88dc70, 0, sizeof(uint64_t));
count_5c784e87bbf0<<<std::ceil((float)orders_size/32.), 32>>>(d_COUNT5c784e88dc70, d_orders__o_orderdate, orders_size);
uint64_t COUNT5c784e88dc70;
cudaMemcpy(&COUNT5c784e88dc70, d_COUNT5c784e88dc70, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5c784e88dc70;
cudaMalloc(&d_BUF_IDX_5c784e88dc70, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5c784e88dc70, 0, sizeof(uint64_t));
uint64_t* d_BUF_5c784e88dc70;
cudaMalloc(&d_BUF_5c784e88dc70, sizeof(uint64_t) * COUNT5c784e88dc70 * 1);
auto d_HT_5c784e88dc70 = cuco::experimental::static_multimap{ (int)COUNT5c784e88dc70*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5c784e87bbf0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5c784e88dc70, d_BUF_IDX_5c784e88dc70, d_HT_5c784e88dc70.ref(cuco::insert), d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
//Materialize count
uint64_t* d_COUNT5c784e88e120;
cudaMalloc(&d_COUNT5c784e88e120, sizeof(uint64_t));
cudaMemset(d_COUNT5c784e88e120, 0, sizeof(uint64_t));
count_5c784e89ab40<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5c784e88dc70, d_COUNT5c784e88e120, d_HT_5c784e88dc70.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_returnflag, lineitem_size);
uint64_t COUNT5c784e88e120;
cudaMemcpy(&COUNT5c784e88e120, d_COUNT5c784e88e120, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5c784e88e120;
cudaMalloc(&d_BUF_IDX_5c784e88e120, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5c784e88e120, 0, sizeof(uint64_t));
uint64_t* d_BUF_5c784e88e120;
cudaMalloc(&d_BUF_5c784e88e120, sizeof(uint64_t) * COUNT5c784e88e120 * 2);
auto d_HT_5c784e88e120 = cuco::experimental::static_multimap{ (int)COUNT5c784e88e120*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5c784e89ab40<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5c784e88dc70, d_BUF_5c784e88e120, d_BUF_IDX_5c784e88e120, d_HT_5c784e88dc70.ref(cuco::for_each), d_HT_5c784e88e120.ref(cuco::insert), d_lineitem__l_orderkey, d_lineitem__l_returnflag, lineitem_size, d_orders__o_custkey);
//Materialize count
uint64_t* d_COUNT5c784e890710;
cudaMalloc(&d_COUNT5c784e890710, sizeof(uint64_t));
cudaMemset(d_COUNT5c784e890710, 0, sizeof(uint64_t));
count_5c784e8a42d0<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT5c784e890710, nation_size);
uint64_t COUNT5c784e890710;
cudaMemcpy(&COUNT5c784e890710, d_COUNT5c784e890710, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5c784e890710;
cudaMalloc(&d_BUF_IDX_5c784e890710, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5c784e890710, 0, sizeof(uint64_t));
uint64_t* d_BUF_5c784e890710;
cudaMalloc(&d_BUF_5c784e890710, sizeof(uint64_t) * COUNT5c784e890710 * 1);
auto d_HT_5c784e890710 = cuco::experimental::static_multimap{ (int)COUNT5c784e890710*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5c784e8a42d0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_5c784e890710, d_BUF_IDX_5c784e890710, d_HT_5c784e890710.ref(cuco::insert), d_nation__n_nationkey, nation_size);
//Create aggregation hash table
auto d_HT_5c784e84b800 = cuco::static_map{ (int)45145*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5c784e87b860<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5c784e88e120, d_BUF_5c784e890710, d_HT_5c784e84b800.ref(cuco::insert), d_HT_5c784e88e120.ref(cuco::for_each), d_HT_5c784e890710.ref(cuco::for_each), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
size_t COUNT5c784e84b800 = d_HT_5c784e84b800.size();
thrust::device_vector<int64_t> keys_5c784e84b800(COUNT5c784e84b800), vals_5c784e84b800(COUNT5c784e84b800);
d_HT_5c784e84b800.retrieve_all(keys_5c784e84b800.begin(), vals_5c784e84b800.begin());
d_HT_5c784e84b800.clear();
int64_t* raw_keys5c784e84b800 = thrust::raw_pointer_cast(keys_5c784e84b800.data());
insertKeys<<<std::ceil((float)COUNT5c784e84b800/32.), 32>>>(raw_keys5c784e84b800, d_HT_5c784e84b800.ref(cuco::insert), COUNT5c784e84b800);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5c784e84b800);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5c784e84b800);
DBStringType* d_aggr__c_comment;
cudaMalloc(&d_aggr__c_comment, sizeof(DBStringType) * COUNT5c784e84b800);
cudaMemset(d_aggr__c_comment, 0, sizeof(DBStringType) * COUNT5c784e84b800);
DBStringType* d_aggr__c_name;
cudaMalloc(&d_aggr__c_name, sizeof(DBStringType) * COUNT5c784e84b800);
cudaMemset(d_aggr__c_name, 0, sizeof(DBStringType) * COUNT5c784e84b800);
DBDecimalType* d_aggr__c_acctbal;
cudaMalloc(&d_aggr__c_acctbal, sizeof(DBDecimalType) * COUNT5c784e84b800);
cudaMemset(d_aggr__c_acctbal, 0, sizeof(DBDecimalType) * COUNT5c784e84b800);
DBStringType* d_aggr__c_phone;
cudaMalloc(&d_aggr__c_phone, sizeof(DBStringType) * COUNT5c784e84b800);
cudaMemset(d_aggr__c_phone, 0, sizeof(DBStringType) * COUNT5c784e84b800);
DBStringType* d_aggr__n_name;
cudaMalloc(&d_aggr__n_name, sizeof(DBStringType) * COUNT5c784e84b800);
cudaMemset(d_aggr__n_name, 0, sizeof(DBStringType) * COUNT5c784e84b800);
DBStringType* d_aggr__c_address;
cudaMalloc(&d_aggr__c_address, sizeof(DBStringType) * COUNT5c784e84b800);
cudaMemset(d_aggr__c_address, 0, sizeof(DBStringType) * COUNT5c784e84b800);
DBI32Type* d_KEY_5c784e84b800customer__c_custkey;
cudaMalloc(&d_KEY_5c784e84b800customer__c_custkey, sizeof(DBI32Type) * COUNT5c784e84b800);
cudaMemset(d_KEY_5c784e84b800customer__c_custkey, 0, sizeof(DBI32Type) * COUNT5c784e84b800);
main_5c784e87b860<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5c784e88e120, d_BUF_5c784e890710, d_HT_5c784e84b800.ref(cuco::find), d_HT_5c784e88e120.ref(cuco::for_each), d_HT_5c784e890710.ref(cuco::for_each), d_KEY_5c784e84b800customer__c_custkey, d_aggr0__tmp_attr0, d_aggr__c_acctbal, d_aggr__c_address, d_aggr__c_comment, d_aggr__c_name, d_aggr__c_phone, d_aggr__n_name, d_customer__c_acctbal, d_customer__c_address, d_customer__c_comment, d_customer__c_custkey, d_customer__c_name, d_customer__c_nationkey, d_customer__c_phone, customer_size, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_nation__n_name);
//Materialize count
uint64_t* d_COUNT5c784e828c60;
cudaMalloc(&d_COUNT5c784e828c60, sizeof(uint64_t));
cudaMemset(d_COUNT5c784e828c60, 0, sizeof(uint64_t));
count_5c784e8aa8e0<<<std::ceil((float)COUNT5c784e84b800/32.), 32>>>(d_COUNT5c784e828c60, COUNT5c784e84b800);
uint64_t COUNT5c784e828c60;
cudaMemcpy(&COUNT5c784e828c60, d_COUNT5c784e828c60, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5c784e828c60;
cudaMalloc(&d_MAT_IDX5c784e828c60, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5c784e828c60, 0, sizeof(uint64_t));
auto MAT5c784e828c60customer__c_custkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5c784e828c60);
DBI32Type* d_MAT5c784e828c60customer__c_custkey;
cudaMalloc(&d_MAT5c784e828c60customer__c_custkey, sizeof(DBI32Type) * COUNT5c784e828c60);
auto MAT5c784e828c60aggr__c_name = (DBStringType*)malloc(sizeof(DBStringType) * COUNT5c784e828c60);
DBStringType* d_MAT5c784e828c60aggr__c_name;
cudaMalloc(&d_MAT5c784e828c60aggr__c_name, sizeof(DBStringType) * COUNT5c784e828c60);
auto MAT5c784e828c60aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5c784e828c60);
DBDecimalType* d_MAT5c784e828c60aggr0__tmp_attr0;
cudaMalloc(&d_MAT5c784e828c60aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5c784e828c60);
auto MAT5c784e828c60aggr__c_acctbal = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5c784e828c60);
DBDecimalType* d_MAT5c784e828c60aggr__c_acctbal;
cudaMalloc(&d_MAT5c784e828c60aggr__c_acctbal, sizeof(DBDecimalType) * COUNT5c784e828c60);
auto MAT5c784e828c60aggr__n_name = (DBStringType*)malloc(sizeof(DBStringType) * COUNT5c784e828c60);
DBStringType* d_MAT5c784e828c60aggr__n_name;
cudaMalloc(&d_MAT5c784e828c60aggr__n_name, sizeof(DBStringType) * COUNT5c784e828c60);
auto MAT5c784e828c60aggr__c_address = (DBStringType*)malloc(sizeof(DBStringType) * COUNT5c784e828c60);
DBStringType* d_MAT5c784e828c60aggr__c_address;
cudaMalloc(&d_MAT5c784e828c60aggr__c_address, sizeof(DBStringType) * COUNT5c784e828c60);
auto MAT5c784e828c60aggr__c_phone = (DBStringType*)malloc(sizeof(DBStringType) * COUNT5c784e828c60);
DBStringType* d_MAT5c784e828c60aggr__c_phone;
cudaMalloc(&d_MAT5c784e828c60aggr__c_phone, sizeof(DBStringType) * COUNT5c784e828c60);
auto MAT5c784e828c60aggr__c_comment = (DBStringType*)malloc(sizeof(DBStringType) * COUNT5c784e828c60);
DBStringType* d_MAT5c784e828c60aggr__c_comment;
cudaMalloc(&d_MAT5c784e828c60aggr__c_comment, sizeof(DBStringType) * COUNT5c784e828c60);
main_5c784e8aa8e0<<<std::ceil((float)COUNT5c784e84b800/32.), 32>>>(COUNT5c784e84b800, d_MAT5c784e828c60aggr0__tmp_attr0, d_MAT5c784e828c60aggr__c_acctbal, d_MAT5c784e828c60aggr__c_address, d_MAT5c784e828c60aggr__c_comment, d_MAT5c784e828c60aggr__c_name, d_MAT5c784e828c60aggr__c_phone, d_MAT5c784e828c60aggr__n_name, d_MAT5c784e828c60customer__c_custkey, d_MAT_IDX5c784e828c60, d_aggr0__tmp_attr0, d_aggr__c_acctbal, d_aggr__c_address, d_aggr__c_comment, d_aggr__c_name, d_aggr__c_phone, d_aggr__n_name, d_KEY_5c784e84b800customer__c_custkey);
cudaMemcpy(MAT5c784e828c60customer__c_custkey, d_MAT5c784e828c60customer__c_custkey, sizeof(DBI32Type) * COUNT5c784e828c60, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5c784e828c60aggr__c_name, d_MAT5c784e828c60aggr__c_name, sizeof(DBStringType) * COUNT5c784e828c60, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5c784e828c60aggr0__tmp_attr0, d_MAT5c784e828c60aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5c784e828c60, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5c784e828c60aggr__c_acctbal, d_MAT5c784e828c60aggr__c_acctbal, sizeof(DBDecimalType) * COUNT5c784e828c60, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5c784e828c60aggr__n_name, d_MAT5c784e828c60aggr__n_name, sizeof(DBStringType) * COUNT5c784e828c60, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5c784e828c60aggr__c_address, d_MAT5c784e828c60aggr__c_address, sizeof(DBStringType) * COUNT5c784e828c60, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5c784e828c60aggr__c_phone, d_MAT5c784e828c60aggr__c_phone, sizeof(DBStringType) * COUNT5c784e828c60, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5c784e828c60aggr__c_comment, d_MAT5c784e828c60aggr__c_comment, sizeof(DBStringType) * COUNT5c784e828c60, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5c784e828c60; i++) { std::cout << MAT5c784e828c60customer__c_custkey[i] << "\t";
std::cout << MAT5c784e828c60aggr__c_name[i] << "\t";
std::cout << MAT5c784e828c60aggr0__tmp_attr0[i] << "\t";
std::cout << MAT5c784e828c60aggr__c_acctbal[i] << "\t";
std::cout << MAT5c784e828c60aggr__n_name[i] << "\t";
std::cout << MAT5c784e828c60aggr__c_address[i] << "\t";
std::cout << MAT5c784e828c60aggr__c_phone[i] << "\t";
std::cout << MAT5c784e828c60aggr__c_comment[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_5c784e88dc70);
cudaFree(d_BUF_IDX_5c784e88dc70);
cudaFree(d_COUNT5c784e88dc70);
cudaFree(d_BUF_5c784e88e120);
cudaFree(d_BUF_IDX_5c784e88e120);
cudaFree(d_COUNT5c784e88e120);
cudaFree(d_BUF_5c784e890710);
cudaFree(d_BUF_IDX_5c784e890710);
cudaFree(d_COUNT5c784e890710);
cudaFree(d_KEY_5c784e84b800customer__c_custkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_aggr__c_acctbal);
cudaFree(d_aggr__c_address);
cudaFree(d_aggr__c_comment);
cudaFree(d_aggr__c_name);
cudaFree(d_aggr__c_phone);
cudaFree(d_aggr__n_name);
cudaFree(d_COUNT5c784e828c60);
cudaFree(d_MAT5c784e828c60aggr0__tmp_attr0);
cudaFree(d_MAT5c784e828c60aggr__c_acctbal);
cudaFree(d_MAT5c784e828c60aggr__c_address);
cudaFree(d_MAT5c784e828c60aggr__c_comment);
cudaFree(d_MAT5c784e828c60aggr__c_name);
cudaFree(d_MAT5c784e828c60aggr__c_phone);
cudaFree(d_MAT5c784e828c60aggr__n_name);
cudaFree(d_MAT5c784e828c60customer__c_custkey);
cudaFree(d_MAT_IDX5c784e828c60);
free(MAT5c784e828c60aggr0__tmp_attr0);
free(MAT5c784e828c60aggr__c_acctbal);
free(MAT5c784e828c60aggr__c_address);
free(MAT5c784e828c60aggr__c_comment);
free(MAT5c784e828c60aggr__c_name);
free(MAT5c784e828c60aggr__c_phone);
free(MAT5c784e828c60aggr__n_name);
free(MAT5c784e828c60customer__c_custkey);
}