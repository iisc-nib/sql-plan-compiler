#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5acbf86a3a40(uint64_t* COUNT5acbf86bec60, DBStringType* customer__c_mktsegment, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_mktsegment = customer__c_mktsegment[tid];
if (!(evaluatePredicate(reg_customer__c_mktsegment, "BUILDING", Predicate::eq))) return;
//Materialize count
atomicAdd((int*)COUNT5acbf86bec60, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5acbf86a3a40(uint64_t* BUF_5acbf86bec60, uint64_t* BUF_IDX_5acbf86bec60, HASHTABLE_INSERT HT_5acbf86bec60, DBI32Type* customer__c_custkey, DBStringType* customer__c_mktsegment, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_mktsegment = customer__c_mktsegment[tid];
if (!(evaluatePredicate(reg_customer__c_mktsegment, "BUILDING", Predicate::eq))) return;
uint64_t KEY_5acbf86bec60 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5acbf86bec60 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_5acbf86bec60 = atomicAdd((int*)BUF_IDX_5acbf86bec60, 1);
HT_5acbf86bec60.insert(cuco::pair{KEY_5acbf86bec60, buf_idx_5acbf86bec60});
BUF_5acbf86bec60[buf_idx_5acbf86bec60 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5acbf86a3d10(uint64_t* BUF_5acbf86bec60, uint64_t* COUNT5acbf86b6480, HASHTABLE_PROBE HT_5acbf86bec60, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 9204, Predicate::lt))) return;
uint64_t KEY_5acbf86bec60 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_5acbf86bec60 |= reg_orders__o_custkey;
//Probe Hash table
HT_5acbf86bec60.for_each(KEY_5acbf86bec60, [&] __device__ (auto const SLOT_5acbf86bec60) {

auto const [slot_first5acbf86bec60, slot_second5acbf86bec60] = SLOT_5acbf86bec60;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5acbf86b6480, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_5acbf86a3d10(uint64_t* BUF_5acbf86b6480, uint64_t* BUF_5acbf86bec60, uint64_t* BUF_IDX_5acbf86b6480, HASHTABLE_INSERT HT_5acbf86b6480, HASHTABLE_PROBE HT_5acbf86bec60, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 9204, Predicate::lt))) return;
uint64_t KEY_5acbf86bec60 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_5acbf86bec60 |= reg_orders__o_custkey;
//Probe Hash table
HT_5acbf86bec60.for_each(KEY_5acbf86bec60, [&] __device__ (auto const SLOT_5acbf86bec60) {
auto const [slot_first5acbf86bec60, slot_second5acbf86bec60] = SLOT_5acbf86bec60;
if (!(true)) return;
uint64_t KEY_5acbf86b6480 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_5acbf86b6480 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_5acbf86b6480 = atomicAdd((int*)BUF_IDX_5acbf86b6480, 1);
HT_5acbf86b6480.insert(cuco::pair{KEY_5acbf86b6480, buf_idx_5acbf86b6480});
BUF_5acbf86b6480[buf_idx_5acbf86b6480 * 2 + 0] = BUF_5acbf86bec60[slot_second5acbf86bec60 * 1 + 0];
BUF_5acbf86b6480[buf_idx_5acbf86b6480 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5acbf86c3270(uint64_t* BUF_5acbf86b6480, HASHTABLE_INSERT HT_5acbf8671e00, HASHTABLE_PROBE HT_5acbf86b6480, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9204, Predicate::gt))) return;
uint64_t KEY_5acbf86b6480 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5acbf86b6480 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5acbf86b6480.for_each(KEY_5acbf86b6480, [&] __device__ (auto const SLOT_5acbf86b6480) {

auto const [slot_first5acbf86b6480, slot_second5acbf86b6480] = SLOT_5acbf86b6480;
if (!(true)) return;
uint64_t KEY_5acbf8671e00 = 0;

KEY_5acbf8671e00 |= reg_lineitem__l_orderkey;
//Create aggregation hash table
HT_5acbf8671e00.insert(cuco::pair{KEY_5acbf8671e00, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5acbf86c3270(uint64_t* BUF_5acbf86b6480, HASHTABLE_FIND HT_5acbf8671e00, HASHTABLE_PROBE HT_5acbf86b6480, DBI32Type* KEY_5acbf8671e00lineitem__l_orderkey, DBDecimalType* aggr0__tmp_attr0, DBDateType* aggr__o_orderdate, DBI32Type* aggr__o_shippriority, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, size_t lineitem_size, DBDateType* orders__o_orderdate, DBI32Type* orders__o_shippriority) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9204, Predicate::gt))) return;
uint64_t KEY_5acbf86b6480 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5acbf86b6480 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5acbf86b6480.for_each(KEY_5acbf86b6480, [&] __device__ (auto const SLOT_5acbf86b6480) {
auto const [slot_first5acbf86b6480, slot_second5acbf86b6480] = SLOT_5acbf86b6480;
if (!(true)) return;
uint64_t KEY_5acbf8671e00 = 0;

KEY_5acbf8671e00 |= reg_lineitem__l_orderkey;
//Aggregate in hashtable
auto buf_idx_5acbf8671e00 = HT_5acbf8671e00.find(KEY_5acbf8671e00)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5acbf8671e00], reg_map0__tmp_attr1);
auto reg_orders__o_shippriority = orders__o_shippriority[BUF_5acbf86b6480[slot_second5acbf86b6480 * 2 + 1]];
aggregate_any(&aggr__o_shippriority[buf_idx_5acbf8671e00], reg_orders__o_shippriority);
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_5acbf86b6480[slot_second5acbf86b6480 * 2 + 1]];
aggregate_any(&aggr__o_orderdate[buf_idx_5acbf8671e00], reg_orders__o_orderdate);
KEY_5acbf8671e00lineitem__l_orderkey[buf_idx_5acbf8671e00] = reg_lineitem__l_orderkey;
});
}
__global__ void count_5acbf86cddb0(uint64_t* COUNT5acbf8658a70, size_t COUNT5acbf8671e00) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5acbf8671e00) return;
//Materialize count
atomicAdd((int*)COUNT5acbf8658a70, 1);
}
__global__ void main_5acbf86cddb0(size_t COUNT5acbf8671e00, DBDecimalType* MAT5acbf8658a70aggr0__tmp_attr0, DBDateType* MAT5acbf8658a70aggr__o_orderdate, DBI32Type* MAT5acbf8658a70aggr__o_shippriority, DBI32Type* MAT5acbf8658a70lineitem__l_orderkey, uint64_t* MAT_IDX5acbf8658a70, DBDecimalType* aggr0__tmp_attr0, DBDateType* aggr__o_orderdate, DBI32Type* aggr__o_shippriority, DBI32Type* lineitem__l_orderkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5acbf8671e00) return;
//Materialize buffers
auto mat_idx5acbf8658a70 = atomicAdd((int*)MAT_IDX5acbf8658a70, 1);
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];
MAT5acbf8658a70lineitem__l_orderkey[mat_idx5acbf8658a70] = reg_lineitem__l_orderkey;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5acbf8658a70aggr0__tmp_attr0[mat_idx5acbf8658a70] = reg_aggr0__tmp_attr0;
auto reg_aggr__o_orderdate = aggr__o_orderdate[tid];
MAT5acbf8658a70aggr__o_orderdate[mat_idx5acbf8658a70] = reg_aggr__o_orderdate;
auto reg_aggr__o_shippriority = aggr__o_shippriority[tid];
MAT5acbf8658a70aggr__o_shippriority[mat_idx5acbf8658a70] = reg_aggr__o_shippriority;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT5acbf86bec60;
cudaMalloc(&d_COUNT5acbf86bec60, sizeof(uint64_t));
cudaMemset(d_COUNT5acbf86bec60, 0, sizeof(uint64_t));
count_5acbf86a3a40<<<std::ceil((float)customer_size/32.), 32>>>(d_COUNT5acbf86bec60, d_customer__c_mktsegment, customer_size);
uint64_t COUNT5acbf86bec60;
cudaMemcpy(&COUNT5acbf86bec60, d_COUNT5acbf86bec60, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5acbf86bec60;
cudaMalloc(&d_BUF_IDX_5acbf86bec60, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5acbf86bec60, 0, sizeof(uint64_t));
uint64_t* d_BUF_5acbf86bec60;
cudaMalloc(&d_BUF_5acbf86bec60, sizeof(uint64_t) * COUNT5acbf86bec60 * 1);
auto d_HT_5acbf86bec60 = cuco::experimental::static_multimap{ (int)COUNT5acbf86bec60*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5acbf86a3a40<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5acbf86bec60, d_BUF_IDX_5acbf86bec60, d_HT_5acbf86bec60.ref(cuco::insert), d_customer__c_custkey, d_customer__c_mktsegment, customer_size);
//Materialize count
uint64_t* d_COUNT5acbf86b6480;
cudaMalloc(&d_COUNT5acbf86b6480, sizeof(uint64_t));
cudaMemset(d_COUNT5acbf86b6480, 0, sizeof(uint64_t));
count_5acbf86a3d10<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5acbf86bec60, d_COUNT5acbf86b6480, d_HT_5acbf86bec60.ref(cuco::for_each), d_orders__o_custkey, d_orders__o_orderdate, orders_size);
uint64_t COUNT5acbf86b6480;
cudaMemcpy(&COUNT5acbf86b6480, d_COUNT5acbf86b6480, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5acbf86b6480;
cudaMalloc(&d_BUF_IDX_5acbf86b6480, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5acbf86b6480, 0, sizeof(uint64_t));
uint64_t* d_BUF_5acbf86b6480;
cudaMalloc(&d_BUF_5acbf86b6480, sizeof(uint64_t) * COUNT5acbf86b6480 * 2);
auto d_HT_5acbf86b6480 = cuco::experimental::static_multimap{ (int)COUNT5acbf86b6480*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5acbf86a3d10<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5acbf86b6480, d_BUF_5acbf86bec60, d_BUF_IDX_5acbf86b6480, d_HT_5acbf86b6480.ref(cuco::insert), d_HT_5acbf86bec60.ref(cuco::for_each), d_orders__o_custkey, d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
//Create aggregation hash table
auto d_HT_5acbf8671e00 = cuco::static_map{ (int)355555*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5acbf86c3270<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5acbf86b6480, d_HT_5acbf8671e00.ref(cuco::insert), d_HT_5acbf86b6480.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_shipdate, lineitem_size);
size_t COUNT5acbf8671e00 = d_HT_5acbf8671e00.size();
thrust::device_vector<int64_t> keys_5acbf8671e00(COUNT5acbf8671e00), vals_5acbf8671e00(COUNT5acbf8671e00);
d_HT_5acbf8671e00.retrieve_all(keys_5acbf8671e00.begin(), vals_5acbf8671e00.begin());
d_HT_5acbf8671e00.clear();
int64_t* raw_keys5acbf8671e00 = thrust::raw_pointer_cast(keys_5acbf8671e00.data());
insertKeys<<<std::ceil((float)COUNT5acbf8671e00/32.), 32>>>(raw_keys5acbf8671e00, d_HT_5acbf8671e00.ref(cuco::insert), COUNT5acbf8671e00);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5acbf8671e00);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5acbf8671e00);
DBI32Type* d_aggr__o_shippriority;
cudaMalloc(&d_aggr__o_shippriority, sizeof(DBI32Type) * COUNT5acbf8671e00);
cudaMemset(d_aggr__o_shippriority, 0, sizeof(DBI32Type) * COUNT5acbf8671e00);
DBDateType* d_aggr__o_orderdate;
cudaMalloc(&d_aggr__o_orderdate, sizeof(DBDateType) * COUNT5acbf8671e00);
cudaMemset(d_aggr__o_orderdate, 0, sizeof(DBDateType) * COUNT5acbf8671e00);
DBI32Type* d_KEY_5acbf8671e00lineitem__l_orderkey;
cudaMalloc(&d_KEY_5acbf8671e00lineitem__l_orderkey, sizeof(DBI32Type) * COUNT5acbf8671e00);
cudaMemset(d_KEY_5acbf8671e00lineitem__l_orderkey, 0, sizeof(DBI32Type) * COUNT5acbf8671e00);
main_5acbf86c3270<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5acbf86b6480, d_HT_5acbf8671e00.ref(cuco::find), d_HT_5acbf86b6480.ref(cuco::for_each), d_KEY_5acbf8671e00lineitem__l_orderkey, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, lineitem_size, d_orders__o_orderdate, d_orders__o_shippriority);
//Materialize count
uint64_t* d_COUNT5acbf8658a70;
cudaMalloc(&d_COUNT5acbf8658a70, sizeof(uint64_t));
cudaMemset(d_COUNT5acbf8658a70, 0, sizeof(uint64_t));
count_5acbf86cddb0<<<std::ceil((float)COUNT5acbf8671e00/32.), 32>>>(d_COUNT5acbf8658a70, COUNT5acbf8671e00);
uint64_t COUNT5acbf8658a70;
cudaMemcpy(&COUNT5acbf8658a70, d_COUNT5acbf8658a70, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5acbf8658a70;
cudaMalloc(&d_MAT_IDX5acbf8658a70, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5acbf8658a70, 0, sizeof(uint64_t));
auto MAT5acbf8658a70lineitem__l_orderkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5acbf8658a70);
DBI32Type* d_MAT5acbf8658a70lineitem__l_orderkey;
cudaMalloc(&d_MAT5acbf8658a70lineitem__l_orderkey, sizeof(DBI32Type) * COUNT5acbf8658a70);
auto MAT5acbf8658a70aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5acbf8658a70);
DBDecimalType* d_MAT5acbf8658a70aggr0__tmp_attr0;
cudaMalloc(&d_MAT5acbf8658a70aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5acbf8658a70);
auto MAT5acbf8658a70aggr__o_orderdate = (DBDateType*)malloc(sizeof(DBDateType) * COUNT5acbf8658a70);
DBDateType* d_MAT5acbf8658a70aggr__o_orderdate;
cudaMalloc(&d_MAT5acbf8658a70aggr__o_orderdate, sizeof(DBDateType) * COUNT5acbf8658a70);
auto MAT5acbf8658a70aggr__o_shippriority = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT5acbf8658a70);
DBI32Type* d_MAT5acbf8658a70aggr__o_shippriority;
cudaMalloc(&d_MAT5acbf8658a70aggr__o_shippriority, sizeof(DBI32Type) * COUNT5acbf8658a70);
main_5acbf86cddb0<<<std::ceil((float)COUNT5acbf8671e00/32.), 32>>>(COUNT5acbf8671e00, d_MAT5acbf8658a70aggr0__tmp_attr0, d_MAT5acbf8658a70aggr__o_orderdate, d_MAT5acbf8658a70aggr__o_shippriority, d_MAT5acbf8658a70lineitem__l_orderkey, d_MAT_IDX5acbf8658a70, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_KEY_5acbf8671e00lineitem__l_orderkey);
cudaMemcpy(MAT5acbf8658a70lineitem__l_orderkey, d_MAT5acbf8658a70lineitem__l_orderkey, sizeof(DBI32Type) * COUNT5acbf8658a70, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5acbf8658a70aggr0__tmp_attr0, d_MAT5acbf8658a70aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5acbf8658a70, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5acbf8658a70aggr__o_orderdate, d_MAT5acbf8658a70aggr__o_orderdate, sizeof(DBDateType) * COUNT5acbf8658a70, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5acbf8658a70aggr__o_shippriority, d_MAT5acbf8658a70aggr__o_shippriority, sizeof(DBI32Type) * COUNT5acbf8658a70, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5acbf8658a70; i++) { std::cout << MAT5acbf8658a70lineitem__l_orderkey[i] << "\t";
std::cout << MAT5acbf8658a70aggr0__tmp_attr0[i] << "\t";
std::cout << MAT5acbf8658a70aggr__o_orderdate[i] << "\t";
std::cout << MAT5acbf8658a70aggr__o_shippriority[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_5acbf86bec60);
cudaFree(d_BUF_IDX_5acbf86bec60);
cudaFree(d_COUNT5acbf86bec60);
cudaFree(d_BUF_5acbf86b6480);
cudaFree(d_BUF_IDX_5acbf86b6480);
cudaFree(d_COUNT5acbf86b6480);
cudaFree(d_KEY_5acbf8671e00lineitem__l_orderkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_aggr__o_orderdate);
cudaFree(d_aggr__o_shippriority);
cudaFree(d_COUNT5acbf8658a70);
cudaFree(d_MAT5acbf8658a70aggr0__tmp_attr0);
cudaFree(d_MAT5acbf8658a70aggr__o_orderdate);
cudaFree(d_MAT5acbf8658a70aggr__o_shippriority);
cudaFree(d_MAT5acbf8658a70lineitem__l_orderkey);
cudaFree(d_MAT_IDX5acbf8658a70);
free(MAT5acbf8658a70aggr0__tmp_attr0);
free(MAT5acbf8658a70aggr__o_orderdate);
free(MAT5acbf8658a70aggr__o_shippriority);
free(MAT5acbf8658a70lineitem__l_orderkey);
}