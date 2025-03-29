#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_56f0025ab110(uint64_t* COUNT56f0025a6fd0, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
//Materialize count
atomicAdd((int*)COUNT56f0025a6fd0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_56f0025ab110(uint64_t* BUF_56f0025a6fd0, uint64_t* BUF_IDX_56f0025a6fd0, HASHTABLE_INSERT HT_56f0025a6fd0, DBI32Type* customer__c_custkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_56f0025a6fd0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_56f0025a6fd0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_56f0025a6fd0 = atomicAdd((int*)BUF_IDX_56f0025a6fd0, 1);
HT_56f0025a6fd0.insert(cuco::pair{KEY_56f0025a6fd0, buf_idx_56f0025a6fd0});
BUF_56f0025a6fd0[buf_idx_56f0025a6fd0 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_56f0025abe20(uint64_t* BUF_56f0025a6fd0, HASHTABLE_INSERT HT_56f002565020, HASHTABLE_PROBE HT_56f0025a6fd0, DBI32Type* customer__c_custkey, DBI32Type* orders__o_custkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_56f0025a6fd0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_56f0025a6fd0 |= reg_orders__o_custkey;
//Probe Hash table
HT_56f0025a6fd0.for_each(KEY_56f0025a6fd0, [&] __device__ (auto const SLOT_56f0025a6fd0) {

auto const [slot_first56f0025a6fd0, slot_second56f0025a6fd0] = SLOT_56f0025a6fd0;
if (!(true)) return;
uint64_t KEY_56f002565020 = 0;
auto reg_customer__c_custkey = customer__c_custkey[BUF_56f0025a6fd0[slot_second56f0025a6fd0 * 1 + 0]];

KEY_56f002565020 |= reg_customer__c_custkey;
//Create aggregation hash table
HT_56f002565020.insert(cuco::pair{KEY_56f002565020, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_56f0025abe20(uint64_t* BUF_56f0025a6fd0, HASHTABLE_FIND HT_56f002565020, HASHTABLE_PROBE HT_56f0025a6fd0, DBI32Type* KEY_56f002565020customer__c_custkey, DBI64Type* aggr0__tmp_attr0, DBI32Type* customer__c_custkey, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_56f0025a6fd0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_56f0025a6fd0 |= reg_orders__o_custkey;
//Probe Hash table
HT_56f0025a6fd0.for_each(KEY_56f0025a6fd0, [&] __device__ (auto const SLOT_56f0025a6fd0) {
auto const [slot_first56f0025a6fd0, slot_second56f0025a6fd0] = SLOT_56f0025a6fd0;
if (!(true)) return;
uint64_t KEY_56f002565020 = 0;
auto reg_customer__c_custkey = customer__c_custkey[BUF_56f0025a6fd0[slot_second56f0025a6fd0 * 1 + 0]];

KEY_56f002565020 |= reg_customer__c_custkey;
//Aggregate in hashtable
auto buf_idx_56f002565020 = HT_56f002565020.find(KEY_56f002565020)->second;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_56f002565020], 1);
KEY_56f002565020customer__c_custkey[buf_idx_56f002565020] = reg_customer__c_custkey;
});
}
template<typename HASHTABLE_INSERT>
__global__ void count_56f0025b1760(size_t COUNT56f002565020, HASHTABLE_INSERT HT_56f002566800, DBI64Type* aggr0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT56f002565020) return;
uint64_t KEY_56f002566800 = 0;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];

KEY_56f002566800 |= reg_aggr0__tmp_attr0;
//Create aggregation hash table
HT_56f002566800.insert(cuco::pair{KEY_56f002566800, 1});
}
template<typename HASHTABLE_FIND>
__global__ void main_56f0025b1760(size_t COUNT56f002565020, HASHTABLE_FIND HT_56f002566800, DBI64Type* KEY_56f002566800aggr0__tmp_attr0, DBI64Type* aggr0__tmp_attr0, DBI64Type* aggr1__tmp_attr1) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT56f002565020) return;
uint64_t KEY_56f002566800 = 0;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];

KEY_56f002566800 |= reg_aggr0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_56f002566800 = HT_56f002566800.find(KEY_56f002566800)->second;
aggregate_sum(&aggr1__tmp_attr1[buf_idx_56f002566800], 1);
KEY_56f002566800aggr0__tmp_attr0[buf_idx_56f002566800] = reg_aggr0__tmp_attr0;
}
__global__ void count_56f0025b32b0(size_t COUNT56f002566800, uint64_t* COUNT56f0025798c0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT56f002566800) return;
//Materialize count
atomicAdd((int*)COUNT56f0025798c0, 1);
}
__global__ void main_56f0025b32b0(size_t COUNT56f002566800, DBI64Type* MAT56f0025798c0aggr0__tmp_attr0, DBI64Type* MAT56f0025798c0aggr1__tmp_attr1, uint64_t* MAT_IDX56f0025798c0, DBI64Type* aggr0__tmp_attr0, DBI64Type* aggr1__tmp_attr1) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT56f002566800) return;
//Materialize buffers
auto mat_idx56f0025798c0 = atomicAdd((int*)MAT_IDX56f0025798c0, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT56f0025798c0aggr0__tmp_attr0[mat_idx56f0025798c0] = reg_aggr0__tmp_attr0;
auto reg_aggr1__tmp_attr1 = aggr1__tmp_attr1[tid];
MAT56f0025798c0aggr1__tmp_attr1[mat_idx56f0025798c0] = reg_aggr1__tmp_attr1;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT56f0025a6fd0;
cudaMalloc(&d_COUNT56f0025a6fd0, sizeof(uint64_t));
cudaMemset(d_COUNT56f0025a6fd0, 0, sizeof(uint64_t));
count_56f0025ab110<<<std::ceil((float)customer_size/32.), 32>>>(d_COUNT56f0025a6fd0, customer_size);
uint64_t COUNT56f0025a6fd0;
cudaMemcpy(&COUNT56f0025a6fd0, d_COUNT56f0025a6fd0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_56f0025a6fd0;
cudaMalloc(&d_BUF_IDX_56f0025a6fd0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_56f0025a6fd0, 0, sizeof(uint64_t));
uint64_t* d_BUF_56f0025a6fd0;
cudaMalloc(&d_BUF_56f0025a6fd0, sizeof(uint64_t) * COUNT56f0025a6fd0 * 1);
auto d_HT_56f0025a6fd0 = cuco::experimental::static_multimap{ (int)COUNT56f0025a6fd0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_56f0025ab110<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_56f0025a6fd0, d_BUF_IDX_56f0025a6fd0, d_HT_56f0025a6fd0.ref(cuco::insert), d_customer__c_custkey, customer_size);
//Create aggregation hash table
auto d_HT_56f002565020 = cuco::static_map{ (int)1500000*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_56f0025abe20<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_56f0025a6fd0, d_HT_56f002565020.ref(cuco::insert), d_HT_56f0025a6fd0.ref(cuco::for_each), d_customer__c_custkey, d_orders__o_custkey, orders_size);
size_t COUNT56f002565020 = d_HT_56f002565020.size();
thrust::device_vector<int64_t> keys_56f002565020(COUNT56f002565020), vals_56f002565020(COUNT56f002565020);
d_HT_56f002565020.retrieve_all(keys_56f002565020.begin(), vals_56f002565020.begin());
d_HT_56f002565020.clear();
int64_t* raw_keys56f002565020 = thrust::raw_pointer_cast(keys_56f002565020.data());
insertKeys<<<std::ceil((float)COUNT56f002565020/32.), 32>>>(raw_keys56f002565020, d_HT_56f002565020.ref(cuco::insert), COUNT56f002565020);
//Aggregate in hashtable
DBI64Type* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT56f002565020);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT56f002565020);
DBI32Type* d_KEY_56f002565020customer__c_custkey;
cudaMalloc(&d_KEY_56f002565020customer__c_custkey, sizeof(DBI32Type) * COUNT56f002565020);
cudaMemset(d_KEY_56f002565020customer__c_custkey, 0, sizeof(DBI32Type) * COUNT56f002565020);
main_56f0025abe20<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_56f0025a6fd0, d_HT_56f002565020.ref(cuco::find), d_HT_56f0025a6fd0.ref(cuco::for_each), d_KEY_56f002565020customer__c_custkey, d_aggr0__tmp_attr0, d_customer__c_custkey, d_orders__o_custkey, d_orders__o_orderkey, orders_size);
//Create aggregation hash table
auto d_HT_56f002566800 = cuco::static_map{ (int)1500000*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_56f0025b1760<<<std::ceil((float)COUNT56f002565020/32.), 32>>>(COUNT56f002565020, d_HT_56f002566800.ref(cuco::insert), d_aggr0__tmp_attr0);
size_t COUNT56f002566800 = d_HT_56f002566800.size();
thrust::device_vector<int64_t> keys_56f002566800(COUNT56f002566800), vals_56f002566800(COUNT56f002566800);
d_HT_56f002566800.retrieve_all(keys_56f002566800.begin(), vals_56f002566800.begin());
d_HT_56f002566800.clear();
int64_t* raw_keys56f002566800 = thrust::raw_pointer_cast(keys_56f002566800.data());
insertKeys<<<std::ceil((float)COUNT56f002566800/32.), 32>>>(raw_keys56f002566800, d_HT_56f002566800.ref(cuco::insert), COUNT56f002566800);
//Aggregate in hashtable
DBI64Type* d_aggr1__tmp_attr1;
cudaMalloc(&d_aggr1__tmp_attr1, sizeof(DBI64Type) * COUNT56f002566800);
cudaMemset(d_aggr1__tmp_attr1, 0, sizeof(DBI64Type) * COUNT56f002566800);
DBI64Type* d_KEY_56f002566800aggr0__tmp_attr0;
cudaMalloc(&d_KEY_56f002566800aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT56f002566800);
cudaMemset(d_KEY_56f002566800aggr0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT56f002566800);
main_56f0025b1760<<<std::ceil((float)COUNT56f002565020/32.), 32>>>(COUNT56f002565020, d_HT_56f002566800.ref(cuco::find), d_KEY_56f002566800aggr0__tmp_attr0, d_aggr0__tmp_attr0, d_aggr1__tmp_attr1);
//Materialize count
uint64_t* d_COUNT56f0025798c0;
cudaMalloc(&d_COUNT56f0025798c0, sizeof(uint64_t));
cudaMemset(d_COUNT56f0025798c0, 0, sizeof(uint64_t));
count_56f0025b32b0<<<std::ceil((float)COUNT56f002566800/32.), 32>>>(COUNT56f002566800, d_COUNT56f0025798c0);
uint64_t COUNT56f0025798c0;
cudaMemcpy(&COUNT56f0025798c0, d_COUNT56f0025798c0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX56f0025798c0;
cudaMalloc(&d_MAT_IDX56f0025798c0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX56f0025798c0, 0, sizeof(uint64_t));
auto MAT56f0025798c0aggr0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT56f0025798c0);
DBI64Type* d_MAT56f0025798c0aggr0__tmp_attr0;
cudaMalloc(&d_MAT56f0025798c0aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT56f0025798c0);
auto MAT56f0025798c0aggr1__tmp_attr1 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT56f0025798c0);
DBI64Type* d_MAT56f0025798c0aggr1__tmp_attr1;
cudaMalloc(&d_MAT56f0025798c0aggr1__tmp_attr1, sizeof(DBI64Type) * COUNT56f0025798c0);
main_56f0025b32b0<<<std::ceil((float)COUNT56f002566800/32.), 32>>>(COUNT56f002566800, d_MAT56f0025798c0aggr0__tmp_attr0, d_MAT56f0025798c0aggr1__tmp_attr1, d_MAT_IDX56f0025798c0, d_KEY_56f002566800aggr0__tmp_attr0, d_aggr1__tmp_attr1);
cudaMemcpy(MAT56f0025798c0aggr0__tmp_attr0, d_MAT56f0025798c0aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT56f0025798c0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT56f0025798c0aggr1__tmp_attr1, d_MAT56f0025798c0aggr1__tmp_attr1, sizeof(DBI64Type) * COUNT56f0025798c0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT56f0025798c0; i++) { std::cout << MAT56f0025798c0aggr0__tmp_attr0[i] << "\t";
std::cout << MAT56f0025798c0aggr1__tmp_attr1[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_56f0025a6fd0);
cudaFree(d_BUF_IDX_56f0025a6fd0);
cudaFree(d_COUNT56f0025a6fd0);
cudaFree(d_KEY_56f002565020customer__c_custkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_KEY_56f002566800aggr0__tmp_attr0);
cudaFree(d_aggr1__tmp_attr1);
cudaFree(d_COUNT56f0025798c0);
cudaFree(d_MAT56f0025798c0aggr0__tmp_attr0);
cudaFree(d_MAT56f0025798c0aggr1__tmp_attr1);
cudaFree(d_MAT_IDX56f0025798c0);
free(MAT56f0025798c0aggr0__tmp_attr0);
free(MAT56f0025798c0aggr1__tmp_attr1);
}