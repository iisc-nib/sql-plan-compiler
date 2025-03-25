#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_59c1d8837510(uint64_t* COUNT59c1d88a8480, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8674, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::lt))) return;
//Materialize count
atomicAdd((int*)COUNT59c1d88a8480, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_59c1d8837510(uint64_t* BUF_59c1d88a8480, uint64_t* BUF_IDX_59c1d88a8480, HASHTABLE_INSERT HT_59c1d88a8480, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 8674, Predicate::gte) && evaluatePredicate(reg_orders__o_orderdate, 8766, Predicate::lt))) return;
uint64_t KEY_59c1d88a8480 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_59c1d88a8480 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_59c1d88a8480 = atomicAdd((int*)BUF_IDX_59c1d88a8480, 1);
HT_59c1d88a8480.insert(cuco::pair{KEY_59c1d88a8480, buf_idx_59c1d88a8480});
BUF_59c1d88a8480[buf_idx_59c1d88a8480 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_59c1d88b4a80(uint64_t* BUF_59c1d88a8480, uint64_t* COUNT59c1d88a7fa0, HASHTABLE_PROBE HT_59c1d88a8480, DBI32Type* lineitem__l_orderkey, DBCharType* lineitem__l_returnflag, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_returnflag = lineitem__l_returnflag[tid];
if (!(evaluatePredicate(reg_lineitem__l_returnflag, 'R', Predicate::eq))) return;
uint64_t KEY_59c1d88a8480 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_59c1d88a8480 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_59c1d88a8480.for_each(KEY_59c1d88a8480, [&] __device__ (auto const SLOT_59c1d88a8480) {

auto const [slot_first59c1d88a8480, slot_second59c1d88a8480] = SLOT_59c1d88a8480;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT59c1d88a7fa0, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_59c1d88b4a80(uint64_t* BUF_59c1d88a7fa0, uint64_t* BUF_59c1d88a8480, uint64_t* BUF_IDX_59c1d88a7fa0, HASHTABLE_INSERT HT_59c1d88a7fa0, HASHTABLE_PROBE HT_59c1d88a8480, DBI32Type* lineitem__l_orderkey, DBCharType* lineitem__l_returnflag, size_t lineitem_size, DBI32Type* orders__o_custkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_returnflag = lineitem__l_returnflag[tid];
if (!(evaluatePredicate(reg_lineitem__l_returnflag, 'R', Predicate::eq))) return;
uint64_t KEY_59c1d88a8480 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_59c1d88a8480 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_59c1d88a8480.for_each(KEY_59c1d88a8480, [&] __device__ (auto const SLOT_59c1d88a8480) {
auto const [slot_first59c1d88a8480, slot_second59c1d88a8480] = SLOT_59c1d88a8480;
if (!(true)) return;
uint64_t KEY_59c1d88a7fa0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[BUF_59c1d88a8480[slot_second59c1d88a8480 * 1 + 0]];

KEY_59c1d88a7fa0 |= reg_orders__o_custkey;
// Insert hash table kernel;
auto buf_idx_59c1d88a7fa0 = atomicAdd((int*)BUF_IDX_59c1d88a7fa0, 1);
HT_59c1d88a7fa0.insert(cuco::pair{KEY_59c1d88a7fa0, buf_idx_59c1d88a7fa0});
BUF_59c1d88a7fa0[buf_idx_59c1d88a7fa0 * 2 + 0] = BUF_59c1d88a8480[slot_second59c1d88a8480 * 1 + 0];
BUF_59c1d88a7fa0[buf_idx_59c1d88a7fa0 * 2 + 1] = tid;
});
}
__global__ void count_59c1d88bdbd0(uint64_t* COUNT59c1d88aac40, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
//Materialize count
atomicAdd((int*)COUNT59c1d88aac40, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_59c1d88bdbd0(uint64_t* BUF_59c1d88aac40, uint64_t* BUF_IDX_59c1d88aac40, HASHTABLE_INSERT HT_59c1d88aac40, DBI32Type* nation__n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_59c1d88aac40 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_59c1d88aac40 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_59c1d88aac40 = atomicAdd((int*)BUF_IDX_59c1d88aac40, 1);
HT_59c1d88aac40.insert(cuco::pair{KEY_59c1d88aac40, buf_idx_59c1d88aac40});
BUF_59c1d88aac40[buf_idx_59c1d88aac40 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_59c1d87b42c0(uint64_t* BUF_59c1d88a7fa0, uint64_t* BUF_59c1d88aac40, HASHTABLE_INSERT HT_59c1d8865cb0, HASHTABLE_PROBE HT_59c1d88a7fa0, HASHTABLE_PROBE HT_59c1d88aac40, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_59c1d88a7fa0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_59c1d88a7fa0 |= reg_customer__c_custkey;
//Probe Hash table
HT_59c1d88a7fa0.for_each(KEY_59c1d88a7fa0, [&] __device__ (auto const SLOT_59c1d88a7fa0) {

auto const [slot_first59c1d88a7fa0, slot_second59c1d88a7fa0] = SLOT_59c1d88a7fa0;
if (!(true)) return;
uint64_t KEY_59c1d88aac40 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_59c1d88aac40 |= reg_customer__c_nationkey;
//Probe Hash table
HT_59c1d88aac40.for_each(KEY_59c1d88aac40, [&] __device__ (auto const SLOT_59c1d88aac40) {

auto const [slot_first59c1d88aac40, slot_second59c1d88aac40] = SLOT_59c1d88aac40;
if (!(true)) return;
uint64_t KEY_59c1d8865cb0 = 0;

KEY_59c1d8865cb0 |= reg_customer__c_custkey;
//Create aggregation hash table
HT_59c1d8865cb0.insert(cuco::pair{KEY_59c1d8865cb0, 1});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_59c1d87b42c0(uint64_t* BUF_59c1d88a7fa0, uint64_t* BUF_59c1d88aac40, HASHTABLE_FIND HT_59c1d8865cb0, HASHTABLE_PROBE HT_59c1d88a7fa0, HASHTABLE_PROBE HT_59c1d88aac40, DBI32Type* KEY_59c1d8865cb0customer__c_custkey, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr__c_acctbal, DBStringType* aggr__c_address, DBStringType* aggr__c_comment, DBStringType* aggr__c_name, DBStringType* aggr__c_phone, DBStringType* aggr__n_name, DBDecimalType* customer__c_acctbal, DBStringType* customer__c_address, DBStringType* customer__c_comment, DBI32Type* customer__c_custkey, DBStringType* customer__c_name, DBI32Type* customer__c_nationkey, DBStringType* customer__c_phone, size_t customer_size, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBStringType* nation__n_name) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_59c1d88a7fa0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_59c1d88a7fa0 |= reg_customer__c_custkey;
//Probe Hash table
HT_59c1d88a7fa0.for_each(KEY_59c1d88a7fa0, [&] __device__ (auto const SLOT_59c1d88a7fa0) {
auto const [slot_first59c1d88a7fa0, slot_second59c1d88a7fa0] = SLOT_59c1d88a7fa0;
if (!(true)) return;
uint64_t KEY_59c1d88aac40 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_59c1d88aac40 |= reg_customer__c_nationkey;
//Probe Hash table
HT_59c1d88aac40.for_each(KEY_59c1d88aac40, [&] __device__ (auto const SLOT_59c1d88aac40) {
auto const [slot_first59c1d88aac40, slot_second59c1d88aac40] = SLOT_59c1d88aac40;
if (!(true)) return;
uint64_t KEY_59c1d8865cb0 = 0;

KEY_59c1d8865cb0 |= reg_customer__c_custkey;
//Aggregate in hashtable
auto buf_idx_59c1d8865cb0 = HT_59c1d8865cb0.find(KEY_59c1d8865cb0)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[BUF_59c1d88a7fa0[slot_second59c1d88a7fa0 * 2 + 1]];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[BUF_59c1d88a7fa0[slot_second59c1d88a7fa0 * 2 + 1]];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_59c1d8865cb0], reg_map0__tmp_attr1);
auto reg_customer__c_comment = customer__c_comment[tid];
aggregate_any(&aggr__c_comment[buf_idx_59c1d8865cb0], reg_customer__c_comment);
auto reg_customer__c_name = customer__c_name[tid];
aggregate_any(&aggr__c_name[buf_idx_59c1d8865cb0], reg_customer__c_name);
auto reg_customer__c_acctbal = customer__c_acctbal[tid];
aggregate_any(&aggr__c_acctbal[buf_idx_59c1d8865cb0], reg_customer__c_acctbal);
auto reg_customer__c_phone = customer__c_phone[tid];
aggregate_any(&aggr__c_phone[buf_idx_59c1d8865cb0], reg_customer__c_phone);
auto reg_nation__n_name = nation__n_name[BUF_59c1d88aac40[slot_second59c1d88aac40 * 1 + 0]];
aggregate_any(&aggr__n_name[buf_idx_59c1d8865cb0], reg_nation__n_name);
auto reg_customer__c_address = customer__c_address[tid];
aggregate_any(&aggr__c_address[buf_idx_59c1d8865cb0], reg_customer__c_address);
KEY_59c1d8865cb0customer__c_custkey[buf_idx_59c1d8865cb0] = reg_customer__c_custkey;
});
});
}
__global__ void count_59c1d88c4640(size_t COUNT59c1d8865cb0, uint64_t* COUNT59c1d8878190) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT59c1d8865cb0) return;
//Materialize count
atomicAdd((int*)COUNT59c1d8878190, 1);
}
__global__ void main_59c1d88c4640(size_t COUNT59c1d8865cb0, DBDecimalType* MAT59c1d8878190aggr0__tmp_attr0, DBDecimalType* MAT59c1d8878190aggr__c_acctbal, DBStringType* MAT59c1d8878190aggr__c_address, DBStringType* MAT59c1d8878190aggr__c_comment, DBStringType* MAT59c1d8878190aggr__c_name, DBStringType* MAT59c1d8878190aggr__c_phone, DBStringType* MAT59c1d8878190aggr__n_name, DBI32Type* MAT59c1d8878190customer__c_custkey, uint64_t* MAT_IDX59c1d8878190, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr__c_acctbal, DBStringType* aggr__c_address, DBStringType* aggr__c_comment, DBStringType* aggr__c_name, DBStringType* aggr__c_phone, DBStringType* aggr__n_name, DBI32Type* customer__c_custkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT59c1d8865cb0) return;
//Materialize buffers
auto mat_idx59c1d8878190 = atomicAdd((int*)MAT_IDX59c1d8878190, 1);
auto reg_customer__c_custkey = customer__c_custkey[tid];
MAT59c1d8878190customer__c_custkey[mat_idx59c1d8878190] = reg_customer__c_custkey;
auto reg_aggr__c_name = aggr__c_name[tid];
MAT59c1d8878190aggr__c_name[mat_idx59c1d8878190] = reg_aggr__c_name;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT59c1d8878190aggr0__tmp_attr0[mat_idx59c1d8878190] = reg_aggr0__tmp_attr0;
auto reg_aggr__c_acctbal = aggr__c_acctbal[tid];
MAT59c1d8878190aggr__c_acctbal[mat_idx59c1d8878190] = reg_aggr__c_acctbal;
auto reg_aggr__n_name = aggr__n_name[tid];
MAT59c1d8878190aggr__n_name[mat_idx59c1d8878190] = reg_aggr__n_name;
auto reg_aggr__c_address = aggr__c_address[tid];
MAT59c1d8878190aggr__c_address[mat_idx59c1d8878190] = reg_aggr__c_address;
auto reg_aggr__c_phone = aggr__c_phone[tid];
MAT59c1d8878190aggr__c_phone[mat_idx59c1d8878190] = reg_aggr__c_phone;
auto reg_aggr__c_comment = aggr__c_comment[tid];
MAT59c1d8878190aggr__c_comment[mat_idx59c1d8878190] = reg_aggr__c_comment;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT59c1d88a8480;
cudaMalloc(&d_COUNT59c1d88a8480, sizeof(uint64_t));
cudaMemset(d_COUNT59c1d88a8480, 0, sizeof(uint64_t));
count_59c1d8837510<<<std::ceil((float)orders_size/32.), 32>>>(d_COUNT59c1d88a8480, d_orders__o_orderdate, orders_size);
uint64_t COUNT59c1d88a8480;
cudaMemcpy(&COUNT59c1d88a8480, d_COUNT59c1d88a8480, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT59c1d88a8480);
// Insert hash table control;
uint64_t* d_BUF_IDX_59c1d88a8480;
cudaMalloc(&d_BUF_IDX_59c1d88a8480, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59c1d88a8480, 0, sizeof(uint64_t));
uint64_t* d_BUF_59c1d88a8480;
cudaMalloc(&d_BUF_59c1d88a8480, sizeof(uint64_t) * COUNT59c1d88a8480 * 1);
auto d_HT_59c1d88a8480 = cuco::experimental::static_multimap{ (int)COUNT59c1d88a8480*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59c1d8837510<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_59c1d88a8480, d_BUF_IDX_59c1d88a8480, d_HT_59c1d88a8480.ref(cuco::insert), d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
cudaFree(d_BUF_IDX_59c1d88a8480);
//Materialize count
uint64_t* d_COUNT59c1d88a7fa0;
cudaMalloc(&d_COUNT59c1d88a7fa0, sizeof(uint64_t));
cudaMemset(d_COUNT59c1d88a7fa0, 0, sizeof(uint64_t));
count_59c1d88b4a80<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_59c1d88a8480, d_COUNT59c1d88a7fa0, d_HT_59c1d88a8480.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_returnflag, lineitem_size);
uint64_t COUNT59c1d88a7fa0;
cudaMemcpy(&COUNT59c1d88a7fa0, d_COUNT59c1d88a7fa0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT59c1d88a7fa0);
// Insert hash table control;
uint64_t* d_BUF_IDX_59c1d88a7fa0;
cudaMalloc(&d_BUF_IDX_59c1d88a7fa0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59c1d88a7fa0, 0, sizeof(uint64_t));
uint64_t* d_BUF_59c1d88a7fa0;
cudaMalloc(&d_BUF_59c1d88a7fa0, sizeof(uint64_t) * COUNT59c1d88a7fa0 * 2);
auto d_HT_59c1d88a7fa0 = cuco::experimental::static_multimap{ (int)COUNT59c1d88a7fa0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59c1d88b4a80<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_59c1d88a7fa0, d_BUF_59c1d88a8480, d_BUF_IDX_59c1d88a7fa0, d_HT_59c1d88a7fa0.ref(cuco::insert), d_HT_59c1d88a8480.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_returnflag, lineitem_size, d_orders__o_custkey);
cudaFree(d_BUF_IDX_59c1d88a7fa0);
//Materialize count
uint64_t* d_COUNT59c1d88aac40;
cudaMalloc(&d_COUNT59c1d88aac40, sizeof(uint64_t));
cudaMemset(d_COUNT59c1d88aac40, 0, sizeof(uint64_t));
count_59c1d88bdbd0<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT59c1d88aac40, nation_size);
uint64_t COUNT59c1d88aac40;
cudaMemcpy(&COUNT59c1d88aac40, d_COUNT59c1d88aac40, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT59c1d88aac40);
// Insert hash table control;
uint64_t* d_BUF_IDX_59c1d88aac40;
cudaMalloc(&d_BUF_IDX_59c1d88aac40, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59c1d88aac40, 0, sizeof(uint64_t));
uint64_t* d_BUF_59c1d88aac40;
cudaMalloc(&d_BUF_59c1d88aac40, sizeof(uint64_t) * COUNT59c1d88aac40 * 1);
auto d_HT_59c1d88aac40 = cuco::experimental::static_multimap{ (int)COUNT59c1d88aac40*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59c1d88bdbd0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_59c1d88aac40, d_BUF_IDX_59c1d88aac40, d_HT_59c1d88aac40.ref(cuco::insert), d_nation__n_nationkey, nation_size);
cudaFree(d_BUF_IDX_59c1d88aac40);
//Create aggregation hash table
auto d_HT_59c1d8865cb0 = cuco::static_map{ (int)45145*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_59c1d87b42c0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_59c1d88a7fa0, d_BUF_59c1d88aac40, d_HT_59c1d8865cb0.ref(cuco::insert), d_HT_59c1d88a7fa0.ref(cuco::for_each), d_HT_59c1d88aac40.ref(cuco::for_each), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
size_t COUNT59c1d8865cb0 = d_HT_59c1d8865cb0.size();
thrust::device_vector<int64_t> keys_59c1d8865cb0(COUNT59c1d8865cb0), vals_59c1d8865cb0(COUNT59c1d8865cb0);
d_HT_59c1d8865cb0.retrieve_all(keys_59c1d8865cb0.begin(), vals_59c1d8865cb0.begin());
thrust::host_vector<int64_t> h_keys_59c1d8865cb0(COUNT59c1d8865cb0);
thrust::copy(keys_59c1d8865cb0.begin(), keys_59c1d8865cb0.end(), h_keys_59c1d8865cb0.begin());
thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_59c1d8865cb0(COUNT59c1d8865cb0);
for (int i=0; i < COUNT59c1d8865cb0; i++)
{actual_dict_59c1d8865cb0[i] = cuco::make_pair(h_keys_59c1d8865cb0[i], i);}
d_HT_59c1d8865cb0.clear();
d_HT_59c1d8865cb0.insert(actual_dict_59c1d8865cb0.begin(), actual_dict_59c1d8865cb0.end());
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT59c1d8865cb0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT59c1d8865cb0);
DBStringType* d_aggr__c_comment;
cudaMalloc(&d_aggr__c_comment, sizeof(DBStringType) * COUNT59c1d8865cb0);
cudaMemset(d_aggr__c_comment, 0, sizeof(DBStringType) * COUNT59c1d8865cb0);
DBStringType* d_aggr__c_name;
cudaMalloc(&d_aggr__c_name, sizeof(DBStringType) * COUNT59c1d8865cb0);
cudaMemset(d_aggr__c_name, 0, sizeof(DBStringType) * COUNT59c1d8865cb0);
DBDecimalType* d_aggr__c_acctbal;
cudaMalloc(&d_aggr__c_acctbal, sizeof(DBDecimalType) * COUNT59c1d8865cb0);
cudaMemset(d_aggr__c_acctbal, 0, sizeof(DBDecimalType) * COUNT59c1d8865cb0);
DBStringType* d_aggr__c_phone;
cudaMalloc(&d_aggr__c_phone, sizeof(DBStringType) * COUNT59c1d8865cb0);
cudaMemset(d_aggr__c_phone, 0, sizeof(DBStringType) * COUNT59c1d8865cb0);
DBStringType* d_aggr__n_name;
cudaMalloc(&d_aggr__n_name, sizeof(DBStringType) * COUNT59c1d8865cb0);
cudaMemset(d_aggr__n_name, 0, sizeof(DBStringType) * COUNT59c1d8865cb0);
DBStringType* d_aggr__c_address;
cudaMalloc(&d_aggr__c_address, sizeof(DBStringType) * COUNT59c1d8865cb0);
cudaMemset(d_aggr__c_address, 0, sizeof(DBStringType) * COUNT59c1d8865cb0);
DBI32Type* d_KEY_59c1d8865cb0customer__c_custkey;
cudaMalloc(&d_KEY_59c1d8865cb0customer__c_custkey, sizeof(DBI32Type) * COUNT59c1d8865cb0);
cudaMemset(d_KEY_59c1d8865cb0customer__c_custkey, 0, sizeof(DBI32Type) * COUNT59c1d8865cb0);
main_59c1d87b42c0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_59c1d88a7fa0, d_BUF_59c1d88aac40, d_HT_59c1d8865cb0.ref(cuco::find), d_HT_59c1d88a7fa0.ref(cuco::for_each), d_HT_59c1d88aac40.ref(cuco::for_each), d_KEY_59c1d8865cb0customer__c_custkey, d_aggr0__tmp_attr0, d_aggr__c_acctbal, d_aggr__c_address, d_aggr__c_comment, d_aggr__c_name, d_aggr__c_phone, d_aggr__n_name, d_customer__c_acctbal, d_customer__c_address, d_customer__c_comment, d_customer__c_custkey, d_customer__c_name, d_customer__c_nationkey, d_customer__c_phone, customer_size, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_nation__n_name);
//Materialize count
uint64_t* d_COUNT59c1d8878190;
cudaMalloc(&d_COUNT59c1d8878190, sizeof(uint64_t));
cudaMemset(d_COUNT59c1d8878190, 0, sizeof(uint64_t));
count_59c1d88c4640<<<std::ceil((float)COUNT59c1d8865cb0/32.), 32>>>(COUNT59c1d8865cb0, d_COUNT59c1d8878190);
uint64_t COUNT59c1d8878190;
cudaMemcpy(&COUNT59c1d8878190, d_COUNT59c1d8878190, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT59c1d8878190);
//Materialize buffers
uint64_t* d_MAT_IDX59c1d8878190;
cudaMalloc(&d_MAT_IDX59c1d8878190, sizeof(uint64_t));
cudaMemset(d_MAT_IDX59c1d8878190, 0, sizeof(uint64_t));
auto MAT59c1d8878190customer__c_custkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT59c1d8878190);
DBI32Type* d_MAT59c1d8878190customer__c_custkey;
cudaMalloc(&d_MAT59c1d8878190customer__c_custkey, sizeof(DBI32Type) * COUNT59c1d8878190);
auto MAT59c1d8878190aggr__c_name = (DBStringType*)malloc(sizeof(DBStringType) * COUNT59c1d8878190);
DBStringType* d_MAT59c1d8878190aggr__c_name;
cudaMalloc(&d_MAT59c1d8878190aggr__c_name, sizeof(DBStringType) * COUNT59c1d8878190);
auto MAT59c1d8878190aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT59c1d8878190);
DBDecimalType* d_MAT59c1d8878190aggr0__tmp_attr0;
cudaMalloc(&d_MAT59c1d8878190aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT59c1d8878190);
auto MAT59c1d8878190aggr__c_acctbal = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT59c1d8878190);
DBDecimalType* d_MAT59c1d8878190aggr__c_acctbal;
cudaMalloc(&d_MAT59c1d8878190aggr__c_acctbal, sizeof(DBDecimalType) * COUNT59c1d8878190);
auto MAT59c1d8878190aggr__n_name = (DBStringType*)malloc(sizeof(DBStringType) * COUNT59c1d8878190);
DBStringType* d_MAT59c1d8878190aggr__n_name;
cudaMalloc(&d_MAT59c1d8878190aggr__n_name, sizeof(DBStringType) * COUNT59c1d8878190);
auto MAT59c1d8878190aggr__c_address = (DBStringType*)malloc(sizeof(DBStringType) * COUNT59c1d8878190);
DBStringType* d_MAT59c1d8878190aggr__c_address;
cudaMalloc(&d_MAT59c1d8878190aggr__c_address, sizeof(DBStringType) * COUNT59c1d8878190);
auto MAT59c1d8878190aggr__c_phone = (DBStringType*)malloc(sizeof(DBStringType) * COUNT59c1d8878190);
DBStringType* d_MAT59c1d8878190aggr__c_phone;
cudaMalloc(&d_MAT59c1d8878190aggr__c_phone, sizeof(DBStringType) * COUNT59c1d8878190);
auto MAT59c1d8878190aggr__c_comment = (DBStringType*)malloc(sizeof(DBStringType) * COUNT59c1d8878190);
DBStringType* d_MAT59c1d8878190aggr__c_comment;
cudaMalloc(&d_MAT59c1d8878190aggr__c_comment, sizeof(DBStringType) * COUNT59c1d8878190);
main_59c1d88c4640<<<std::ceil((float)COUNT59c1d8865cb0/32.), 32>>>(COUNT59c1d8865cb0, d_MAT59c1d8878190aggr0__tmp_attr0, d_MAT59c1d8878190aggr__c_acctbal, d_MAT59c1d8878190aggr__c_address, d_MAT59c1d8878190aggr__c_comment, d_MAT59c1d8878190aggr__c_name, d_MAT59c1d8878190aggr__c_phone, d_MAT59c1d8878190aggr__n_name, d_MAT59c1d8878190customer__c_custkey, d_MAT_IDX59c1d8878190, d_aggr0__tmp_attr0, d_aggr__c_acctbal, d_aggr__c_address, d_aggr__c_comment, d_aggr__c_name, d_aggr__c_phone, d_aggr__n_name, d_KEY_59c1d8865cb0customer__c_custkey);
cudaFree(d_MAT_IDX59c1d8878190);
cudaMemcpy(MAT59c1d8878190customer__c_custkey, d_MAT59c1d8878190customer__c_custkey, sizeof(DBI32Type) * COUNT59c1d8878190, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59c1d8878190aggr__c_name, d_MAT59c1d8878190aggr__c_name, sizeof(DBStringType) * COUNT59c1d8878190, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59c1d8878190aggr0__tmp_attr0, d_MAT59c1d8878190aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT59c1d8878190, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59c1d8878190aggr__c_acctbal, d_MAT59c1d8878190aggr__c_acctbal, sizeof(DBDecimalType) * COUNT59c1d8878190, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59c1d8878190aggr__n_name, d_MAT59c1d8878190aggr__n_name, sizeof(DBStringType) * COUNT59c1d8878190, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59c1d8878190aggr__c_address, d_MAT59c1d8878190aggr__c_address, sizeof(DBStringType) * COUNT59c1d8878190, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59c1d8878190aggr__c_phone, d_MAT59c1d8878190aggr__c_phone, sizeof(DBStringType) * COUNT59c1d8878190, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59c1d8878190aggr__c_comment, d_MAT59c1d8878190aggr__c_comment, sizeof(DBStringType) * COUNT59c1d8878190, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT59c1d8878190; i++) { std::cout << MAT59c1d8878190customer__c_custkey[i] << "\t";
// std::cout << MAT59c1d8878190aggr__c_name[i] << "\t";
std::cout << MAT59c1d8878190aggr0__tmp_attr0[i] << "\t";
std::cout << MAT59c1d8878190aggr__c_acctbal[i] << "\t";
// std::cout << MAT59c1d8878190aggr__n_name[i] << "\t";
// std::cout << MAT59c1d8878190aggr__c_address[i] << "\t";
// std::cout << MAT59c1d8878190aggr__c_phone[i] << "\t";
// std::cout << MAT59c1d8878190aggr__c_comment[i] << "\t";
std::cout << std::endl; }
}