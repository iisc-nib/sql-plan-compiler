#include <cuco/static_map.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_63411b08e9e0(uint64_t* COUNT63411b17f960, DBStringType* customer__c_mktsegment, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_mktsegment = customer__c_mktsegment[tid];
if (!(evaluatePredicate(reg_customer__c_mktsegment, "BUILDING", Predicate::eq))) return;
//Materialize count
atomicAdd((int*)COUNT63411b17f960, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_63411b08e9e0(uint64_t* BUF_63411b17f960, uint64_t* BUF_IDX_63411b17f960, HASHTABLE_INSERT HT_63411b17f960, DBI32Type* customer__c_custkey, DBStringType* customer__c_mktsegment, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg_customer__c_mktsegment = customer__c_mktsegment[tid];
if (!(evaluatePredicate(reg_customer__c_mktsegment, "BUILDING", Predicate::eq))) return;
uint64_t KEY_63411b17f960 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];
KEY_63411b17f960 <<= 32;
KEY_63411b17f960 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_63411b17f960 = atomicAdd((int*)BUF_IDX_63411b17f960, 1);
HT_63411b17f960.insert(cuco::pair{KEY_63411b17f960, buf_idx_63411b17f960});
BUF_63411b17f960[buf_idx_63411b17f960 * 1 + 0] = tid;
}
template<typename HASHTABLE_FIND>
__global__ void count_63411b111520(uint64_t* BUF_63411b17f960, uint64_t* COUNT63411b17fc20, HASHTABLE_FIND HT_63411b17f960, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 9204, Predicate::lt))) return;
uint64_t KEY_63411b17f960 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];
KEY_63411b17f960 <<= 32;
KEY_63411b17f960 |= reg_orders__o_custkey;
//Probe Hash table
auto SLOT_63411b17f960 = HT_63411b17f960.find(KEY_63411b17f960);
if (SLOT_63411b17f960 == HT_63411b17f960.end()) return;
//Materialize count
atomicAdd((int*)COUNT63411b17fc20, 1);
}
template<typename HASHTABLE_FIND, typename HASHTABLE_INSERT>
__global__ void main_63411b111520(uint64_t* BUF_63411b17f960, uint64_t* BUF_63411b17fc20, uint64_t* BUF_IDX_63411b17fc20, HASHTABLE_FIND HT_63411b17f960, HASHTABLE_INSERT HT_63411b17fc20, DBI32Type* orders__o_custkey, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg_orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg_orders__o_orderdate, 9204, Predicate::lt))) return;
uint64_t KEY_63411b17f960 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];
KEY_63411b17f960 <<= 32;
KEY_63411b17f960 |= reg_orders__o_custkey;
//Probe Hash table
auto SLOT_63411b17f960 = HT_63411b17f960.find(KEY_63411b17f960);
if (SLOT_63411b17f960 == HT_63411b17f960.end()) return;
uint64_t KEY_63411b17fc20 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];
KEY_63411b17fc20 <<= 32;
KEY_63411b17fc20 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_63411b17fc20 = atomicAdd((int*)BUF_IDX_63411b17fc20, 1);
HT_63411b17fc20.insert(cuco::pair{KEY_63411b17fc20, buf_idx_63411b17fc20});
BUF_63411b17fc20[buf_idx_63411b17fc20 * 2 + 0] = BUF_63411b17f960[SLOT_63411b17f960->second * 1 + 0];
BUF_63411b17fc20[buf_idx_63411b17fc20 * 2 + 1] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_FIND>
__global__ void count_63411b18bef0(uint64_t* BUF_63411b17fc20, HASHTABLE_INSERT HT_63411b13d830, HASHTABLE_FIND HT_63411b17fc20, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9204, Predicate::gt))) return;
uint64_t KEY_63411b17fc20 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];
KEY_63411b17fc20 <<= 32;
KEY_63411b17fc20 |= reg_lineitem__l_orderkey;
//Probe Hash table
auto SLOT_63411b17fc20 = HT_63411b17fc20.find(KEY_63411b17fc20);
if (SLOT_63411b17fc20 == HT_63411b17fc20.end()) return;
uint64_t KEY_63411b13d830 = 0;
KEY_63411b13d830 <<= 32;
KEY_63411b13d830 |= reg_lineitem__l_orderkey;
//Create aggregation hash table
HT_63411b13d830.insert(cuco::pair{KEY_63411b13d830, 1});
}
template<typename HASHTABLE_FIND>
__global__ void main_63411b18bef0(uint64_t* BUF_63411b17fc20, HASHTABLE_FIND HT_63411b13d830, HASHTABLE_FIND HT_63411b17fc20, DBI32Type* KEY_63411b13d830lineitem__l_orderkey, DBDecimalType* aggr0__tmp_attr0, DBDateType* aggr__o_orderdate, DBI32Type* aggr__o_shippriority, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, size_t lineitem_size, DBDateType* orders__o_orderdate, DBI32Type* orders__o_shippriority) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9204, Predicate::gt))) return;
uint64_t KEY_63411b17fc20 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];
KEY_63411b17fc20 <<= 32;
KEY_63411b17fc20 |= reg_lineitem__l_orderkey;
//Probe Hash table
auto SLOT_63411b17fc20 = HT_63411b17fc20.find(KEY_63411b17fc20);
if (SLOT_63411b17fc20 == HT_63411b17fc20.end()) return;
uint64_t KEY_63411b13d830 = 0;
KEY_63411b13d830 <<= 32;
KEY_63411b13d830 |= reg_lineitem__l_orderkey;
//Aggregate in hashtable
auto buf_idx_63411b13d830 = HT_63411b13d830.find(KEY_63411b13d830)->second;
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_63411b13d830], reg_lineitem__l_extendedprice);
auto reg_orders__o_shippriority = orders__o_shippriority[BUF_63411b17fc20[SLOT_63411b17fc20->second * 2 + 0]];
aggregate_any(&aggr__o_shippriority[buf_idx_63411b13d830], reg_orders__o_shippriority);
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_63411b17fc20[SLOT_63411b17fc20->second * 2 + 0]];
aggregate_any(&aggr__o_orderdate[buf_idx_63411b13d830], reg_orders__o_orderdate);
KEY_63411b13d830lineitem__l_orderkey[buf_idx_63411b13d830] = reg_lineitem__l_orderkey;
}
__global__ void count_63411b196f70(uint64_t* COUNT63411b11e300, size_t COUNT63411b13d830) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT63411b13d830) return;
//Materialize count
atomicAdd((int*)COUNT63411b11e300, 1);
}
__global__ void main_63411b196f70(size_t COUNT63411b13d830, DBDecimalType* MAT63411b11e300aggr0__tmp_attr0, DBDateType* MAT63411b11e300aggr__o_orderdate, DBI32Type* MAT63411b11e300aggr__o_shippriority, DBI32Type* MAT63411b11e300lineitem__l_orderkey, DBDecimalType* aggr0__tmp_attr0, DBDateType* aggr__o_orderdate, DBI32Type* aggr__o_shippriority, DBI32Type* lineitem__l_orderkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT63411b13d830) return;
//Materialize buffers
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];
MAT63411b11e300lineitem__l_orderkey[tid] = reg_lineitem__l_orderkey;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT63411b11e300aggr0__tmp_attr0[tid] = reg_aggr0__tmp_attr0;
auto reg_aggr__o_orderdate = aggr__o_orderdate[tid];
MAT63411b11e300aggr__o_orderdate[tid] = reg_aggr__o_orderdate;
auto reg_aggr__o_shippriority = aggr__o_shippriority[tid];
MAT63411b11e300aggr__o_shippriority[tid] = reg_aggr__o_shippriority;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT63411b17f960;
cudaMalloc(&d_COUNT63411b17f960, sizeof(uint64_t));
cudaMemset(d_COUNT63411b17f960, 0, sizeof(uint64_t));
count_63411b08e9e0<<<std::ceil((float)customer_size/32.), 32>>>(d_COUNT63411b17f960, d_customer__c_mktsegment, customer_size);
uint64_t COUNT63411b17f960;
cudaMemcpy(&COUNT63411b17f960, d_COUNT63411b17f960, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT63411b17f960);
// Insert hash table control;
uint64_t* d_BUF_IDX_63411b17f960;
cudaMalloc(&d_BUF_IDX_63411b17f960, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_63411b17f960, 0, sizeof(uint64_t));
uint64_t* d_BUF_63411b17f960;
cudaMalloc(&d_BUF_63411b17f960, sizeof(uint64_t) * COUNT63411b17f960 * 1);
auto d_HT_63411b17f960 = cuco::static_map{ (int)COUNT63411b17f960*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_63411b08e9e0<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_63411b17f960, d_BUF_IDX_63411b17f960, d_HT_63411b17f960.ref(cuco::insert), d_customer__c_custkey, d_customer__c_mktsegment, customer_size);
cudaFree(d_BUF_IDX_63411b17f960);
//Materialize count
uint64_t* d_COUNT63411b17fc20;
cudaMalloc(&d_COUNT63411b17fc20, sizeof(uint64_t));
cudaMemset(d_COUNT63411b17fc20, 0, sizeof(uint64_t));
count_63411b111520<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_63411b17f960, d_COUNT63411b17fc20, d_HT_63411b17f960.ref(cuco::find), d_orders__o_custkey, d_orders__o_orderdate, orders_size);
uint64_t COUNT63411b17fc20;
cudaMemcpy(&COUNT63411b17fc20, d_COUNT63411b17fc20, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT63411b17fc20);
// Insert hash table control;
uint64_t* d_BUF_IDX_63411b17fc20;
cudaMalloc(&d_BUF_IDX_63411b17fc20, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_63411b17fc20, 0, sizeof(uint64_t));
uint64_t* d_BUF_63411b17fc20;
cudaMalloc(&d_BUF_63411b17fc20, sizeof(uint64_t) * COUNT63411b17fc20 * 2);
auto d_HT_63411b17fc20 = cuco::static_map{ (int)COUNT63411b17fc20*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_63411b111520<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_63411b17f960, d_BUF_63411b17fc20, d_BUF_IDX_63411b17fc20, d_HT_63411b17f960.ref(cuco::find), d_HT_63411b17fc20.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderdate, d_orders__o_orderkey, orders_size);
cudaFree(d_BUF_IDX_63411b17fc20);
//Create aggregation hash table
auto d_HT_63411b13d830 = cuco::static_map{ (int)355555*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_63411b18bef0<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_63411b17fc20, d_HT_63411b13d830.ref(cuco::insert), d_HT_63411b17fc20.ref(cuco::find), d_lineitem__l_orderkey, d_lineitem__l_shipdate, lineitem_size);
size_t COUNT63411b13d830 = d_HT_63411b13d830.size();
thrust::device_vector<int64_t> keys_63411b13d830(COUNT63411b13d830), vals_63411b13d830(COUNT63411b13d830);
d_HT_63411b13d830.retrieve_all(keys_63411b13d830.begin(), vals_63411b13d830.begin());
thrust::host_vector<int64_t> h_keys_63411b13d830(COUNT63411b13d830);
thrust::copy(keys_63411b13d830.begin(), keys_63411b13d830.end(), h_keys_63411b13d830.begin());
thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_63411b13d830(COUNT63411b13d830);
for (int i=0; i < COUNT63411b13d830; i++)
{actual_dict_63411b13d830[i] = cuco::make_pair(h_keys_63411b13d830[i], i);}
d_HT_63411b13d830.clear();
d_HT_63411b13d830.insert(actual_dict_63411b13d830.begin(), actual_dict_63411b13d830.end());
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT63411b13d830);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT63411b13d830);
DBI32Type* d_aggr__o_shippriority;
cudaMalloc(&d_aggr__o_shippriority, sizeof(DBI32Type) * COUNT63411b13d830);
cudaMemset(d_aggr__o_shippriority, 0, sizeof(DBI32Type) * COUNT63411b13d830);
DBDateType* d_aggr__o_orderdate;
cudaMalloc(&d_aggr__o_orderdate, sizeof(DBDateType) * COUNT63411b13d830);
cudaMemset(d_aggr__o_orderdate, 0, sizeof(DBDateType) * COUNT63411b13d830);
DBI32Type* d_KEY_63411b13d830lineitem__l_orderkey;
cudaMalloc(&d_KEY_63411b13d830lineitem__l_orderkey, sizeof(DBI32Type) * COUNT63411b13d830);
cudaMemset(d_KEY_63411b13d830lineitem__l_orderkey, 0, sizeof(DBI32Type) * COUNT63411b13d830);
main_63411b18bef0<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_63411b17fc20, d_HT_63411b13d830.ref(cuco::find), d_HT_63411b17fc20.ref(cuco::find), d_KEY_63411b13d830lineitem__l_orderkey, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, lineitem_size, d_orders__o_orderdate, d_orders__o_shippriority);
//Materialize count
uint64_t* d_COUNT63411b11e300;
cudaMalloc(&d_COUNT63411b11e300, sizeof(uint64_t));
cudaMemset(d_COUNT63411b11e300, 0, sizeof(uint64_t));
count_63411b196f70<<<std::ceil((float)COUNT63411b13d830/32.), 32>>>(d_COUNT63411b11e300, COUNT63411b13d830);
uint64_t COUNT63411b11e300;
cudaMemcpy(&COUNT63411b11e300, d_COUNT63411b11e300, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT63411b11e300);
//Materialize buffers
auto MAT63411b11e300lineitem__l_orderkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT63411b11e300);
DBI32Type* d_MAT63411b11e300lineitem__l_orderkey;
cudaMalloc(&d_MAT63411b11e300lineitem__l_orderkey, sizeof(DBI32Type) * COUNT63411b11e300);
auto MAT63411b11e300aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT63411b11e300);
DBDecimalType* d_MAT63411b11e300aggr0__tmp_attr0;
cudaMalloc(&d_MAT63411b11e300aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT63411b11e300);
auto MAT63411b11e300aggr__o_orderdate = (DBDateType*)malloc(sizeof(DBDateType) * COUNT63411b11e300);
DBDateType* d_MAT63411b11e300aggr__o_orderdate;
cudaMalloc(&d_MAT63411b11e300aggr__o_orderdate, sizeof(DBDateType) * COUNT63411b11e300);
auto MAT63411b11e300aggr__o_shippriority = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT63411b11e300);
DBI32Type* d_MAT63411b11e300aggr__o_shippriority;
cudaMalloc(&d_MAT63411b11e300aggr__o_shippriority, sizeof(DBI32Type) * COUNT63411b11e300);
main_63411b196f70<<<std::ceil((float)COUNT63411b13d830/32.), 32>>>(COUNT63411b13d830, d_MAT63411b11e300aggr0__tmp_attr0, d_MAT63411b11e300aggr__o_orderdate, d_MAT63411b11e300aggr__o_shippriority, d_MAT63411b11e300lineitem__l_orderkey, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_KEY_63411b13d830lineitem__l_orderkey);
cudaMemcpy(MAT63411b11e300lineitem__l_orderkey, d_MAT63411b11e300lineitem__l_orderkey, sizeof(DBI32Type) * COUNT63411b11e300, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT63411b11e300aggr0__tmp_attr0, d_MAT63411b11e300aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT63411b11e300, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT63411b11e300aggr__o_orderdate, d_MAT63411b11e300aggr__o_orderdate, sizeof(DBDateType) * COUNT63411b11e300, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT63411b11e300aggr__o_shippriority, d_MAT63411b11e300aggr__o_shippriority, sizeof(DBI32Type) * COUNT63411b11e300, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT63411b11e300; i++) { std::cout << MAT63411b11e300lineitem__l_orderkey[i] << "\t";
std::cout << MAT63411b11e300aggr0__tmp_attr0[i] << "\t";
std::cout << MAT63411b11e300aggr__o_orderdate[i] << "\t";
std::cout << MAT63411b11e300aggr__o_shippriority[i] << "\t";
std::cout << std::endl; }
}