#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_59ce838df2c0(uint64_t* COUNT59ce839d2af0, DBStringType* customer__c_mktsegment, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_mktsegment = customer__c_mktsegment[tid];
if (!(evaluatePredicate(reg_customer__c_mktsegment, "BUILDING", Predicate::eq))) return;
//Materialize count
atomicAdd((int*)COUNT59ce839d2af0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_59ce838df2c0(uint64_t* BUF_59ce839d2af0, uint64_t* BUF_IDX_59ce839d2af0, HASHTABLE_INSERT HT_59ce839d2af0, DBI32Type* customer__c_custkey, DBStringType* customer__c_mktsegment, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_mktsegment = customer__c_mktsegment[tid];
if (!(evaluatePredicate(reg_customer__c_mktsegment, "BUILDING", Predicate::eq))) return;
uint64_t KEY_59ce839d2af0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_59ce839d2af0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_59ce839d2af0 = atomicAdd((int*)BUF_IDX_59ce839d2af0, 1);
HT_59ce839d2af0.insert(cuco::pair{KEY_59ce839d2af0, buf_idx_59ce839d2af0});
BUF_59ce839d2af0[buf_idx_59ce839d2af0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_59ce83962030(uint64_t* BUF_59ce839d2af0, uint64_t* COUNT59ce839d4170, HASHTABLE_PROBE HT_59ce839d2af0, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 9204, Predicate::lt))) return;
uint64_t KEY_59ce839d2af0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_59ce839d2af0 |= reg_orders__o_custkey;
//Probe Hash table
HT_59ce839d2af0.for_each(KEY_59ce839d2af0, [&] __device__ (auto const SLOT_59ce839d2af0) {

auto const [slot_first59ce839d2af0, slot_second59ce839d2af0] = SLOT_59ce839d2af0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT59ce839d4170, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_59ce83962030(uint64_t* BUF_59ce839d2af0, uint64_t* BUF_59ce839d4170, uint64_t* BUF_IDX_59ce839d4170, HASHTABLE_PROBE HT_59ce839d2af0, HASHTABLE_INSERT HT_59ce839d4170, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 9204, Predicate::lt))) return;
uint64_t KEY_59ce839d2af0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_59ce839d2af0 |= reg_orders__o_custkey;
//Probe Hash table
HT_59ce839d2af0.for_each(KEY_59ce839d2af0, [&] __device__ (auto const SLOT_59ce839d2af0) {
auto const [slot_first59ce839d2af0, slot_second59ce839d2af0] = SLOT_59ce839d2af0;
if (!(true)) return;
uint64_t KEY_59ce839d4170 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_59ce839d4170 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_59ce839d4170 = atomicAdd((int*)BUF_IDX_59ce839d4170, 1);
HT_59ce839d4170.insert(cuco::pair{KEY_59ce839d4170, buf_idx_59ce839d4170});
BUF_59ce839d4170[buf_idx_59ce839d4170 * 2 + 0] = BUF_59ce839d2af0[slot_second59ce839d2af0 * 1 + 0];
BUF_59ce839d4170[buf_idx_59ce839d4170 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_59ce839ded20(uint64_t* BUF_59ce839d4170, HASHTABLE_INSERT HT_59ce8398f540, HASHTABLE_PROBE HT_59ce839d4170, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9204, Predicate::gt))) return;
uint64_t KEY_59ce839d4170 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_59ce839d4170 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_59ce839d4170.for_each(KEY_59ce839d4170, [&] __device__ (auto const SLOT_59ce839d4170) {

auto const [slot_first59ce839d4170, slot_second59ce839d4170] = SLOT_59ce839d4170;
if (!(true)) return;
uint64_t KEY_59ce8398f540 = 0;

KEY_59ce8398f540 |= reg_lineitem__l_orderkey;
//Create aggregation hash table
HT_59ce8398f540.insert(cuco::pair{KEY_59ce8398f540, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_59ce839ded20(uint64_t* BUF_59ce839d4170, HASHTABLE_FIND HT_59ce8398f540, HASHTABLE_PROBE HT_59ce839d4170, DBI32Type* KEY_59ce8398f540lineitem__l_orderkey, DBDecimalType* aggr0__tmp_attr0, DBDateType* aggr__o_orderdate, DBI32Type* aggr__o_shippriority, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, size_t lineitem_size, DBDateType* orders__o_orderdate, DBI32Type* orders__o_shippriority) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9204, Predicate::gt))) return;
uint64_t KEY_59ce839d4170 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_59ce839d4170 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_59ce839d4170.for_each(KEY_59ce839d4170, [&] __device__ (auto const SLOT_59ce839d4170) {
auto const [slot_first59ce839d4170, slot_second59ce839d4170] = SLOT_59ce839d4170;
if (!(true)) return;
uint64_t KEY_59ce8398f540 = 0;

KEY_59ce8398f540 |= reg_lineitem__l_orderkey;
//Aggregate in hashtable
auto buf_idx_59ce8398f540 = HT_59ce8398f540.find(KEY_59ce8398f540)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_59ce8398f540], reg_map0__tmp_attr1);
auto reg_orders__o_shippriority = orders__o_shippriority[BUF_59ce839d4170[slot_second59ce839d4170 * 2 + 1]];
aggregate_any(&aggr__o_shippriority[buf_idx_59ce8398f540], reg_orders__o_shippriority);
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_59ce839d4170[slot_second59ce839d4170 * 2 + 1]];
aggregate_any(&aggr__o_orderdate[buf_idx_59ce8398f540], reg_orders__o_orderdate);
KEY_59ce8398f540lineitem__l_orderkey[buf_idx_59ce8398f540] = reg_lineitem__l_orderkey;
});
}
__global__ void count_59ce839e9fa0(uint64_t* COUNT59ce8396ea00, size_t COUNT59ce8398f540) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT59ce8398f540) return;
//Materialize count
atomicAdd((int*)COUNT59ce8396ea00, 1);
}
__global__ void main_59ce839e9fa0(size_t COUNT59ce8398f540, DBDecimalType* MAT59ce8396ea00aggr0__tmp_attr0, DBDateType* MAT59ce8396ea00aggr__o_orderdate, DBI32Type* MAT59ce8396ea00aggr__o_shippriority, DBI32Type* MAT59ce8396ea00lineitem__l_orderkey, uint64_t* MAT_IDX59ce8396ea00, DBDecimalType* aggr0__tmp_attr0, DBDateType* aggr__o_orderdate, DBI32Type* aggr__o_shippriority, DBI32Type* lineitem__l_orderkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT59ce8398f540) return;
//Materialize buffers
auto mat_idx59ce8396ea00 = atomicAdd((int*)MAT_IDX59ce8396ea00, 1);
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];
MAT59ce8396ea00lineitem__l_orderkey[mat_idx59ce8396ea00] = reg_lineitem__l_orderkey;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT59ce8396ea00aggr0__tmp_attr0[mat_idx59ce8396ea00] = reg_aggr0__tmp_attr0;
auto reg_aggr__o_orderdate = aggr__o_orderdate[tid];
MAT59ce8396ea00aggr__o_orderdate[mat_idx59ce8396ea00] = reg_aggr__o_orderdate;
auto reg_aggr__o_shippriority = aggr__o_shippriority[tid];
MAT59ce8396ea00aggr__o_shippriority[mat_idx59ce8396ea00] = reg_aggr__o_shippriority;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT59ce839d2af0;
cudaMalloc(&d_COUNT59ce839d2af0, sizeof(uint64_t));
cudaMemset(d_COUNT59ce839d2af0, 0, sizeof(uint64_t));
count_59ce838df2c0<<<std::ceil((float)customer_size/32.), 32>>>(d_COUNT59ce839d2af0, d_customer__c_mktsegment, customer_size);
uint64_t COUNT59ce839d2af0;
cudaMemcpy(&COUNT59ce839d2af0, d_COUNT59ce839d2af0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT59ce839d2af0);
// Insert hash table control;
uint64_t* d_BUF_IDX_59ce839d2af0;
cudaMalloc(&d_BUF_IDX_59ce839d2af0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59ce839d2af0, 0, sizeof(uint64_t));
uint64_t* d_BUF_59ce839d2af0;
cudaMalloc(&d_BUF_59ce839d2af0, sizeof(uint64_t) * COUNT59ce839d2af0 * 1);
auto d_HT_59ce839d2af0 = cuco::experimental::static_multimap{ (int)COUNT59ce839d2af0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59ce838df2c0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_59ce839d2af0, d_BUF_IDX_59ce839d2af0, d_HT_59ce839d2af0.ref(cuco::insert), d_customer__c_custkey, d_customer__c_mktsegment, customer_size);
cudaFree(d_BUF_IDX_59ce839d2af0);
//Materialize count
uint64_t* d_COUNT59ce839d4170;
cudaMalloc(&d_COUNT59ce839d4170, sizeof(uint64_t));
cudaMemset(d_COUNT59ce839d4170, 0, sizeof(uint64_t));
count_59ce83962030<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_59ce839d2af0, d_COUNT59ce839d4170, d_HT_59ce839d2af0.ref(cuco::for_each), d_orders__o_custkey, d_orders__o_orderdate, orders_size);
uint64_t COUNT59ce839d4170;
cudaMemcpy(&COUNT59ce839d4170, d_COUNT59ce839d4170, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT59ce839d4170);
// Insert hash table control;
uint64_t* d_BUF_IDX_59ce839d4170;
cudaMalloc(&d_BUF_IDX_59ce839d4170, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_59ce839d4170, 0, sizeof(uint64_t));
uint64_t* d_BUF_59ce839d4170;
cudaMalloc(&d_BUF_59ce839d4170, sizeof(uint64_t) * COUNT59ce839d4170 * 2);
auto d_HT_59ce839d4170 = cuco::experimental::static_multimap{ (int)COUNT59ce839d4170*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_59ce83962030<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_59ce839d2af0, d_BUF_59ce839d4170, d_BUF_IDX_59ce839d4170, d_HT_59ce839d2af0.ref(cuco::for_each), d_HT_59ce839d4170.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
cudaFree(d_BUF_IDX_59ce839d4170);
//Create aggregation hash table
auto d_HT_59ce8398f540 = cuco::static_map{ (int)355555*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_59ce839ded20<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_59ce839d4170, d_HT_59ce8398f540.ref(cuco::insert), d_HT_59ce839d4170.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_shipdate, lineitem_size);
size_t COUNT59ce8398f540 = d_HT_59ce8398f540.size();
thrust::device_vector<int64_t> keys_59ce8398f540(COUNT59ce8398f540), vals_59ce8398f540(COUNT59ce8398f540);
d_HT_59ce8398f540.retrieve_all(keys_59ce8398f540.begin(), vals_59ce8398f540.begin());
thrust::host_vector<int64_t> h_keys_59ce8398f540(COUNT59ce8398f540);
thrust::copy(keys_59ce8398f540.begin(), keys_59ce8398f540.end(), h_keys_59ce8398f540.begin());
thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_59ce8398f540(COUNT59ce8398f540);
for (int i=0; i < COUNT59ce8398f540; i++)
{actual_dict_59ce8398f540[i] = cuco::make_pair(h_keys_59ce8398f540[i], i);}
d_HT_59ce8398f540.clear();
d_HT_59ce8398f540.insert(actual_dict_59ce8398f540.begin(), actual_dict_59ce8398f540.end());
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT59ce8398f540);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT59ce8398f540);
DBI32Type* d_aggr__o_shippriority;
cudaMalloc(&d_aggr__o_shippriority, sizeof(DBI32Type) * COUNT59ce8398f540);
cudaMemset(d_aggr__o_shippriority, 0, sizeof(DBI32Type) * COUNT59ce8398f540);
DBDateType* d_aggr__o_orderdate;
cudaMalloc(&d_aggr__o_orderdate, sizeof(DBDateType) * COUNT59ce8398f540);
cudaMemset(d_aggr__o_orderdate, 0, sizeof(DBDateType) * COUNT59ce8398f540);
DBI32Type* d_KEY_59ce8398f540lineitem__l_orderkey;
cudaMalloc(&d_KEY_59ce8398f540lineitem__l_orderkey, sizeof(DBI32Type) * COUNT59ce8398f540);
cudaMemset(d_KEY_59ce8398f540lineitem__l_orderkey, 0, sizeof(DBI32Type) * COUNT59ce8398f540);
main_59ce839ded20<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_59ce839d4170, d_HT_59ce8398f540.ref(cuco::find), d_HT_59ce839d4170.ref(cuco::for_each), d_KEY_59ce8398f540lineitem__l_orderkey, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, lineitem_size, d_orders__o_orderdate, d_orders__o_shippriority);
//Materialize count
uint64_t* d_COUNT59ce8396ea00;
cudaMalloc(&d_COUNT59ce8396ea00, sizeof(uint64_t));
cudaMemset(d_COUNT59ce8396ea00, 0, sizeof(uint64_t));
count_59ce839e9fa0<<<std::ceil((float)COUNT59ce8398f540/32.), 32>>>(d_COUNT59ce8396ea00, COUNT59ce8398f540);
uint64_t COUNT59ce8396ea00;
cudaMemcpy(&COUNT59ce8396ea00, d_COUNT59ce8396ea00, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT59ce8396ea00);
//Materialize buffers
uint64_t* d_MAT_IDX59ce8396ea00;
cudaMalloc(&d_MAT_IDX59ce8396ea00, sizeof(uint64_t));
cudaMemset(d_MAT_IDX59ce8396ea00, 0, sizeof(uint64_t));
auto MAT59ce8396ea00lineitem__l_orderkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT59ce8396ea00);
DBI32Type* d_MAT59ce8396ea00lineitem__l_orderkey;
cudaMalloc(&d_MAT59ce8396ea00lineitem__l_orderkey, sizeof(DBI32Type) * COUNT59ce8396ea00);
auto MAT59ce8396ea00aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT59ce8396ea00);
DBDecimalType* d_MAT59ce8396ea00aggr0__tmp_attr0;
cudaMalloc(&d_MAT59ce8396ea00aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT59ce8396ea00);
auto MAT59ce8396ea00aggr__o_orderdate = (DBDateType*)malloc(sizeof(DBDateType) * COUNT59ce8396ea00);
DBDateType* d_MAT59ce8396ea00aggr__o_orderdate;
cudaMalloc(&d_MAT59ce8396ea00aggr__o_orderdate, sizeof(DBDateType) * COUNT59ce8396ea00);
auto MAT59ce8396ea00aggr__o_shippriority = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT59ce8396ea00);
DBI32Type* d_MAT59ce8396ea00aggr__o_shippriority;
cudaMalloc(&d_MAT59ce8396ea00aggr__o_shippriority, sizeof(DBI32Type) * COUNT59ce8396ea00);
main_59ce839e9fa0<<<std::ceil((float)COUNT59ce8398f540/32.), 32>>>(COUNT59ce8398f540, d_MAT59ce8396ea00aggr0__tmp_attr0, d_MAT59ce8396ea00aggr__o_orderdate, d_MAT59ce8396ea00aggr__o_shippriority, d_MAT59ce8396ea00lineitem__l_orderkey, d_MAT_IDX59ce8396ea00, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_KEY_59ce8398f540lineitem__l_orderkey);
cudaFree(d_MAT_IDX59ce8396ea00);
cudaMemcpy(MAT59ce8396ea00lineitem__l_orderkey, d_MAT59ce8396ea00lineitem__l_orderkey, sizeof(DBI32Type) * COUNT59ce8396ea00, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59ce8396ea00aggr0__tmp_attr0, d_MAT59ce8396ea00aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT59ce8396ea00, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59ce8396ea00aggr__o_orderdate, d_MAT59ce8396ea00aggr__o_orderdate, sizeof(DBDateType) * COUNT59ce8396ea00, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT59ce8396ea00aggr__o_shippriority, d_MAT59ce8396ea00aggr__o_shippriority, sizeof(DBI32Type) * COUNT59ce8396ea00, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT59ce8396ea00; i++) { std::cout << MAT59ce8396ea00lineitem__l_orderkey[i] << "\t";
std::cout << MAT59ce8396ea00aggr0__tmp_attr0[i] << "\t";
std::cout << MAT59ce8396ea00aggr__o_orderdate[i] << "\t";
std::cout << MAT59ce8396ea00aggr__o_shippriority[i] << "\t";
std::cout << std::endl; }
}