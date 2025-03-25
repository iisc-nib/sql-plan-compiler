#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5906d56b92c0(uint64_t* COUNT5906d57a6c60, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
//Materialize count
atomicAdd((int*)COUNT5906d57a6c60, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5906d56b92c0(uint64_t* BUF_5906d57a6c60, uint64_t* BUF_IDX_5906d57a6c60, HASHTABLE_INSERT HT_5906d57a6c60, DBI32Type* customer__c_custkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_5906d57a6c60 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5906d57a6c60 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_5906d57a6c60 = atomicAdd((int*)BUF_IDX_5906d57a6c60, 1);
HT_5906d57a6c60.insert(cuco::pair{KEY_5906d57a6c60, buf_idx_5906d57a6c60});
BUF_5906d57a6c60[buf_idx_5906d57a6c60 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5906d573b0a0(uint64_t* BUF_5906d57a6c60, HASHTABLE_INSERT HT_5906d5762b30, HASHTABLE_PROBE HT_5906d57a6c60, DBI32Type* customer__c_custkey, DBI32Type* orders__o_custkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_5906d57a6c60 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_5906d57a6c60 |= reg_orders__o_custkey;
//Probe Hash table
HT_5906d57a6c60.for_each(KEY_5906d57a6c60, [&] __device__ (auto const SLOT_5906d57a6c60) {

auto const [slot_first5906d57a6c60, slot_second5906d57a6c60] = SLOT_5906d57a6c60;
if (!(true)) return;
uint64_t KEY_5906d5762b30 = 0;
auto reg_customer__c_custkey = customer__c_custkey[BUF_5906d57a6c60[slot_second5906d57a6c60 * 1 + 0]];

KEY_5906d5762b30 |= reg_customer__c_custkey;
//Create aggregation hash table
HT_5906d5762b30.insert(cuco::pair{KEY_5906d5762b30, 1});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5906d573b0a0(uint64_t* BUF_5906d57a6c60, HASHTABLE_FIND HT_5906d5762b30, HASHTABLE_PROBE HT_5906d57a6c60, DBI32Type* KEY_5906d5762b30customer__c_custkey, DBI64Type* aggr0__tmp_attr0, DBI32Type* customer__c_custkey, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_5906d57a6c60 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_5906d57a6c60 |= reg_orders__o_custkey;
//Probe Hash table
HT_5906d57a6c60.for_each(KEY_5906d57a6c60, [&] __device__ (auto const SLOT_5906d57a6c60) {
auto const [slot_first5906d57a6c60, slot_second5906d57a6c60] = SLOT_5906d57a6c60;
if (!(true)) return;
uint64_t KEY_5906d5762b30 = 0;
auto reg_customer__c_custkey = customer__c_custkey[BUF_5906d57a6c60[slot_second5906d57a6c60 * 1 + 0]];

KEY_5906d5762b30 |= reg_customer__c_custkey;
//Aggregate in hashtable
auto buf_idx_5906d5762b30 = HT_5906d5762b30.find(KEY_5906d5762b30)->second;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5906d5762b30], 1);
KEY_5906d5762b30customer__c_custkey[buf_idx_5906d5762b30] = reg_customer__c_custkey;
});
}
template<typename HASHTABLE_INSERT>
__global__ void count_5906d57b04b0(size_t COUNT5906d5762b30, HASHTABLE_INSERT HT_5906d5763ea0, DBI64Type* aggr0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5906d5762b30) return;
uint64_t KEY_5906d5763ea0 = 0;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];

KEY_5906d5763ea0 |= reg_aggr0__tmp_attr0;
//Create aggregation hash table
HT_5906d5763ea0.insert(cuco::pair{KEY_5906d5763ea0, 1});
}
template<typename HASHTABLE_FIND>
__global__ void main_5906d57b04b0(size_t COUNT5906d5762b30, HASHTABLE_FIND HT_5906d5763ea0, DBI64Type* KEY_5906d5763ea0aggr0__tmp_attr0, DBI64Type* aggr0__tmp_attr0, DBI64Type* aggr1__tmp_attr1) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5906d5762b30) return;
uint64_t KEY_5906d5763ea0 = 0;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];

KEY_5906d5763ea0 |= reg_aggr0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_5906d5763ea0 = HT_5906d5763ea0.find(KEY_5906d5763ea0)->second;
aggregate_sum(&aggr1__tmp_attr1[buf_idx_5906d5763ea0], 1);
KEY_5906d5763ea0aggr0__tmp_attr0[buf_idx_5906d5763ea0] = reg_aggr0__tmp_attr0;
}
__global__ void count_5906d57b1ff0(size_t COUNT5906d5763ea0, uint64_t* COUNT5906d5777840) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5906d5763ea0) return;
//Materialize count
atomicAdd((int*)COUNT5906d5777840, 1);
}
__global__ void main_5906d57b1ff0(size_t COUNT5906d5763ea0, DBI64Type* MAT5906d5777840aggr0__tmp_attr0, DBI64Type* MAT5906d5777840aggr1__tmp_attr1, uint64_t* MAT_IDX5906d5777840, DBI64Type* aggr0__tmp_attr0, DBI64Type* aggr1__tmp_attr1) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5906d5763ea0) return;
//Materialize buffers
auto mat_idx5906d5777840 = atomicAdd((int*)MAT_IDX5906d5777840, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5906d5777840aggr0__tmp_attr0[mat_idx5906d5777840] = reg_aggr0__tmp_attr0;
auto reg_aggr1__tmp_attr1 = aggr1__tmp_attr1[tid];
MAT5906d5777840aggr1__tmp_attr1[mat_idx5906d5777840] = reg_aggr1__tmp_attr1;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT5906d57a6c60;
cudaMalloc(&d_COUNT5906d57a6c60, sizeof(uint64_t));
cudaMemset(d_COUNT5906d57a6c60, 0, sizeof(uint64_t));
count_5906d56b92c0<<<std::ceil((float)customer_size/32.), 32>>>(d_COUNT5906d57a6c60, customer_size);
uint64_t COUNT5906d57a6c60;
cudaMemcpy(&COUNT5906d57a6c60, d_COUNT5906d57a6c60, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5906d57a6c60);
// Insert hash table control;
uint64_t* d_BUF_IDX_5906d57a6c60;
cudaMalloc(&d_BUF_IDX_5906d57a6c60, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5906d57a6c60, 0, sizeof(uint64_t));
uint64_t* d_BUF_5906d57a6c60;
cudaMalloc(&d_BUF_5906d57a6c60, sizeof(uint64_t) * COUNT5906d57a6c60 * 1);
auto d_HT_5906d57a6c60 = cuco::experimental::static_multimap{ (int)COUNT5906d57a6c60*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5906d56b92c0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5906d57a6c60, d_BUF_IDX_5906d57a6c60, d_HT_5906d57a6c60.ref(cuco::insert), d_customer__c_custkey, customer_size);
cudaFree(d_BUF_IDX_5906d57a6c60);
//Create aggregation hash table
auto d_HT_5906d5762b30 = cuco::static_map{ (int)1500000*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5906d573b0a0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5906d57a6c60, d_HT_5906d5762b30.ref(cuco::insert), d_HT_5906d57a6c60.ref(cuco::for_each), d_customer__c_custkey, d_orders__o_custkey, orders_size);
size_t COUNT5906d5762b30 = d_HT_5906d5762b30.size();
thrust::device_vector<int64_t> keys_5906d5762b30(COUNT5906d5762b30), vals_5906d5762b30(COUNT5906d5762b30);
d_HT_5906d5762b30.retrieve_all(keys_5906d5762b30.begin(), vals_5906d5762b30.begin());
thrust::host_vector<int64_t> h_keys_5906d5762b30(COUNT5906d5762b30);
thrust::copy(keys_5906d5762b30.begin(), keys_5906d5762b30.end(), h_keys_5906d5762b30.begin());
thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_5906d5762b30(COUNT5906d5762b30);
for (int i=0; i < COUNT5906d5762b30; i++)
{actual_dict_5906d5762b30[i] = cuco::make_pair(h_keys_5906d5762b30[i], i);}
d_HT_5906d5762b30.clear();
d_HT_5906d5762b30.insert(actual_dict_5906d5762b30.begin(), actual_dict_5906d5762b30.end());
//Aggregate in hashtable
DBI64Type* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT5906d5762b30);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT5906d5762b30);
DBI32Type* d_KEY_5906d5762b30customer__c_custkey;
cudaMalloc(&d_KEY_5906d5762b30customer__c_custkey, sizeof(DBI32Type) * COUNT5906d5762b30);
cudaMemset(d_KEY_5906d5762b30customer__c_custkey, 0, sizeof(DBI32Type) * COUNT5906d5762b30);
main_5906d573b0a0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5906d57a6c60, d_HT_5906d5762b30.ref(cuco::find), d_HT_5906d57a6c60.ref(cuco::for_each), d_KEY_5906d5762b30customer__c_custkey, d_aggr0__tmp_attr0, d_customer__c_custkey, d_orders__o_custkey, d_orders__o_orderkey, orders_size);
//Create aggregation hash table
auto d_HT_5906d5763ea0 = cuco::static_map{ (int)1500000*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5906d57b04b0<<<std::ceil((float)COUNT5906d5762b30/32.), 32>>>(COUNT5906d5762b30, d_HT_5906d5763ea0.ref(cuco::insert), d_aggr0__tmp_attr0);
size_t COUNT5906d5763ea0 = d_HT_5906d5763ea0.size();
thrust::device_vector<int64_t> keys_5906d5763ea0(COUNT5906d5763ea0), vals_5906d5763ea0(COUNT5906d5763ea0);
d_HT_5906d5763ea0.retrieve_all(keys_5906d5763ea0.begin(), vals_5906d5763ea0.begin());
thrust::host_vector<int64_t> h_keys_5906d5763ea0(COUNT5906d5763ea0);
thrust::copy(keys_5906d5763ea0.begin(), keys_5906d5763ea0.end(), h_keys_5906d5763ea0.begin());
thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_5906d5763ea0(COUNT5906d5763ea0);
for (int i=0; i < COUNT5906d5763ea0; i++)
{actual_dict_5906d5763ea0[i] = cuco::make_pair(h_keys_5906d5763ea0[i], i);}
d_HT_5906d5763ea0.clear();
d_HT_5906d5763ea0.insert(actual_dict_5906d5763ea0.begin(), actual_dict_5906d5763ea0.end());
//Aggregate in hashtable
DBI64Type* d_aggr1__tmp_attr1;
cudaMalloc(&d_aggr1__tmp_attr1, sizeof(DBI64Type) * COUNT5906d5763ea0);
cudaMemset(d_aggr1__tmp_attr1, 0, sizeof(DBI64Type) * COUNT5906d5763ea0);
DBI64Type* d_KEY_5906d5763ea0aggr0__tmp_attr0;
cudaMalloc(&d_KEY_5906d5763ea0aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT5906d5763ea0);
cudaMemset(d_KEY_5906d5763ea0aggr0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT5906d5763ea0);
main_5906d57b04b0<<<std::ceil((float)COUNT5906d5762b30/32.), 32>>>(COUNT5906d5762b30, d_HT_5906d5763ea0.ref(cuco::find), d_KEY_5906d5763ea0aggr0__tmp_attr0, d_aggr0__tmp_attr0, d_aggr1__tmp_attr1);
//Materialize count
uint64_t* d_COUNT5906d5777840;
cudaMalloc(&d_COUNT5906d5777840, sizeof(uint64_t));
cudaMemset(d_COUNT5906d5777840, 0, sizeof(uint64_t));
count_5906d57b1ff0<<<std::ceil((float)COUNT5906d5763ea0/32.), 32>>>(COUNT5906d5763ea0, d_COUNT5906d5777840);
uint64_t COUNT5906d5777840;
cudaMemcpy(&COUNT5906d5777840, d_COUNT5906d5777840, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5906d5777840);
//Materialize buffers
uint64_t* d_MAT_IDX5906d5777840;
cudaMalloc(&d_MAT_IDX5906d5777840, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5906d5777840, 0, sizeof(uint64_t));
auto MAT5906d5777840aggr0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT5906d5777840);
DBI64Type* d_MAT5906d5777840aggr0__tmp_attr0;
cudaMalloc(&d_MAT5906d5777840aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT5906d5777840);
auto MAT5906d5777840aggr1__tmp_attr1 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT5906d5777840);
DBI64Type* d_MAT5906d5777840aggr1__tmp_attr1;
cudaMalloc(&d_MAT5906d5777840aggr1__tmp_attr1, sizeof(DBI64Type) * COUNT5906d5777840);
main_5906d57b1ff0<<<std::ceil((float)COUNT5906d5763ea0/32.), 32>>>(COUNT5906d5763ea0, d_MAT5906d5777840aggr0__tmp_attr0, d_MAT5906d5777840aggr1__tmp_attr1, d_MAT_IDX5906d5777840, d_KEY_5906d5763ea0aggr0__tmp_attr0, d_aggr1__tmp_attr1);
cudaFree(d_MAT_IDX5906d5777840);
cudaMemcpy(MAT5906d5777840aggr0__tmp_attr0, d_MAT5906d5777840aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT5906d5777840, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5906d5777840aggr1__tmp_attr1, d_MAT5906d5777840aggr1__tmp_attr1, sizeof(DBI64Type) * COUNT5906d5777840, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5906d5777840; i++) { std::cout << MAT5906d5777840aggr0__tmp_attr0[i] << "\t";
std::cout << MAT5906d5777840aggr1__tmp_attr1[i] << "\t";
std::cout << std::endl; }
}