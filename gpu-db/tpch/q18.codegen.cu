#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
template<typename HASHTABLE_INSERT>
__global__ void count_1(HASHTABLE_INSERT HT_0, size_t lineitem_size, DBI32Type* lineitem_u_1__l_orderkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_0 = 0;
auto reg_lineitem_u_1__l_orderkey = lineitem_u_1__l_orderkey[tid];

KEY_0 |= reg_lineitem_u_1__l_orderkey;
//Create aggregation hash table
HT_0.insert(cuco::pair{KEY_0, 1});
}
template<typename HASHTABLE_FIND>
__global__ void main_1(HASHTABLE_FIND HT_0, DBI32Type* KEY_0lineitem_u_1__l_orderkey, DBDecimalType* aggr0__tmp_attr0, size_t lineitem_size, DBI32Type* lineitem_u_1__l_orderkey, DBDecimalType* lineitem_u_1__l_quantity) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_0 = 0;
auto reg_lineitem_u_1__l_orderkey = lineitem_u_1__l_orderkey[tid];

KEY_0 |= reg_lineitem_u_1__l_orderkey;
//Aggregate in hashtable
auto buf_idx_0 = HT_0.find(KEY_0)->second;
auto reg_lineitem_u_1__l_quantity = lineitem_u_1__l_quantity[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_0], reg_lineitem_u_1__l_quantity);
KEY_0lineitem_u_1__l_orderkey[buf_idx_0] = reg_lineitem_u_1__l_orderkey;
}
__global__ void count_3(size_t COUNT0, uint64_t* COUNT2, DBDecimalType* aggr0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT0) return;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
if (!(evaluatePredicate(reg_aggr0__tmp_attr0, 300.0, Predicate::gt))) return;
//Materialize count
atomicAdd((int*)COUNT2, 1);
}
template<typename HASHTABLE_INSERT_SJ>
__global__ void main_3(size_t COUNT0, HASHTABLE_INSERT_SJ HT_2, DBDecimalType* aggr0__tmp_attr0, DBI32Type* lineitem_u_1__l_orderkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT0) return;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
if (!(evaluatePredicate(reg_aggr0__tmp_attr0, 300.0, Predicate::gt))) return;
uint64_t KEY_2 = 0;
auto reg_lineitem_u_1__l_orderkey = lineitem_u_1__l_orderkey[tid];

KEY_2 |= reg_lineitem_u_1__l_orderkey;
// Insert hash table kernel;
HT_2.insert(cuco::pair{KEY_2, 1});
}
__global__ void count_5(uint64_t* COUNT4, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
//Materialize count
atomicAdd((int*)COUNT4, 1);
}
template<typename HASHTABLE_INSERT_PK>
__global__ void main_5(uint64_t* BUF_4, uint64_t* BUF_IDX_4, HASHTABLE_INSERT_PK HT_4, DBI32Type* customer__c_custkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_4 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_4 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_4 = atomicAdd((int*)BUF_IDX_4, 1);
HT_4.insert(cuco::pair{KEY_4, buf_idx_4});
BUF_4[buf_idx_4 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE_SJ, typename HASHTABLE_PROBE_PK>
__global__ void count_7(uint64_t* BUF_4, uint64_t* COUNT6, HASHTABLE_PROBE_SJ HT_2, HASHTABLE_PROBE_PK HT_4, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_2 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_2 |= reg_orders__o_orderkey;
//Probe Hash table
auto SLOT_2 = HT_2.find(KEY_2);
if (SLOT_2 == HT_2.end()) return;
if (!(true)) return;
uint64_t KEY_4 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_4 |= reg_orders__o_custkey;
//Probe Hash table
auto SLOT_4 = HT_4.find(KEY_4);
if (SLOT_4 == HT_4.end()) return;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT6, 1);
}
template<typename HASHTABLE_PROBE_SJ, typename HASHTABLE_PROBE_PK, typename HASHTABLE_INSERT_PK>
__global__ void main_7(uint64_t* BUF_4, uint64_t* BUF_6, uint64_t* BUF_IDX_6, HASHTABLE_PROBE_SJ HT_2, HASHTABLE_PROBE_PK HT_4, HASHTABLE_INSERT_PK HT_6, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_2 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_2 |= reg_orders__o_orderkey;
//Probe Hash table
auto SLOT_2 = HT_2.find(KEY_2);
if (SLOT_2 == HT_2.end()) return;
if (!(true)) return;
uint64_t KEY_4 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_4 |= reg_orders__o_custkey;
//Probe Hash table
auto SLOT_4 = HT_4.find(KEY_4);
if (SLOT_4 == HT_4.end()) return;
if (!(true)) return;
uint64_t KEY_6 = 0;

KEY_6 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_6 = atomicAdd((int*)BUF_IDX_6, 1);
HT_6.insert(cuco::pair{KEY_6, buf_idx_6});
BUF_6[buf_idx_6 * 2 + 0] = BUF_4[SLOT_4->second * 1 + 0];
BUF_6[buf_idx_6 * 2 + 1] = tid;
}
template<typename HASHTABLE_PROBE_PK, typename HASHTABLE_INSERT>
__global__ void count_9(uint64_t* BUF_6, HASHTABLE_PROBE_PK HT_6, HASHTABLE_INSERT HT_8, DBI32Type* lineitem__l_orderkey, size_t lineitem_size, DBI32Type* orders__o_orderkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_6 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_6 |= reg_lineitem__l_orderkey;
//Probe Hash table
auto SLOT_6 = HT_6.find(KEY_6);
if (SLOT_6 == HT_6.end()) return;
if (!(true)) return;
uint64_t KEY_8 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[BUF_6[SLOT_6->second * 2 + 1]];

KEY_8 |= reg_orders__o_orderkey;
//Create aggregation hash table
HT_8.insert(cuco::pair{KEY_8, 1});
}
template<typename HASHTABLE_PROBE_PK, typename HASHTABLE_FIND>
__global__ void main_9(uint64_t* BUF_6, HASHTABLE_PROBE_PK HT_6, HASHTABLE_FIND HT_8, DBI32Type* KEY_8orders__o_orderkey, DBDecimalType* aggr1__tmp_attr1, DBI32Type* aggr__c_custkey, DBDateType* aggr__o_orderdate, DBDecimalType* aggr__o_totalprice, DBI32Type* customer__c_custkey, DBI32Type* lineitem__l_orderkey, DBDecimalType* lineitem__l_quantity, size_t lineitem_size, DBDateType* orders__o_orderdate, DBI32Type* orders__o_orderkey, DBDecimalType* orders__o_totalprice) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_6 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_6 |= reg_lineitem__l_orderkey;
//Probe Hash table
auto SLOT_6 = HT_6.find(KEY_6);
if (SLOT_6 == HT_6.end()) return;
if (!(true)) return;
uint64_t KEY_8 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[BUF_6[SLOT_6->second * 2 + 1]];

KEY_8 |= reg_orders__o_orderkey;
//Aggregate in hashtable
auto buf_idx_8 = HT_8.find(KEY_8)->second;
auto reg_lineitem__l_quantity = lineitem__l_quantity[tid];
aggregate_sum(&aggr1__tmp_attr1[buf_idx_8], reg_lineitem__l_quantity);
auto reg_customer__c_custkey = customer__c_custkey[BUF_6[SLOT_6->second * 2 + 0]];
aggregate_any(&aggr__c_custkey[buf_idx_8], reg_customer__c_custkey);
auto reg_orders__o_totalprice = orders__o_totalprice[BUF_6[SLOT_6->second * 2 + 1]];
aggregate_any(&aggr__o_totalprice[buf_idx_8], reg_orders__o_totalprice);
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_6[SLOT_6->second * 2 + 1]];
aggregate_any(&aggr__o_orderdate[buf_idx_8], reg_orders__o_orderdate);
KEY_8orders__o_orderkey[buf_idx_8] = reg_orders__o_orderkey;
}
__global__ void count_11(uint64_t* COUNT10, size_t COUNT8) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT8) return;
//Materialize count
atomicAdd((int*)COUNT10, 1);
}
__global__ void main_11(size_t COUNT8, DBDecimalType* MAT10aggr1__tmp_attr1, DBI32Type* MAT10aggr__c_custkey, DBDateType* MAT10aggr__o_orderdate, DBDecimalType* MAT10aggr__o_totalprice, DBI32Type* MAT10orders__o_orderkey, uint64_t* MAT_IDX10, DBDecimalType* aggr1__tmp_attr1, DBI32Type* aggr__c_custkey, DBDateType* aggr__o_orderdate, DBDecimalType* aggr__o_totalprice, DBI32Type* orders__o_orderkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT8) return;
//Materialize buffers
auto mat_idx10 = atomicAdd((int*)MAT_IDX10, 1);
auto reg_aggr__c_custkey = aggr__c_custkey[tid];
MAT10aggr__c_custkey[mat_idx10] = reg_aggr__c_custkey;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];
MAT10orders__o_orderkey[mat_idx10] = reg_orders__o_orderkey;
auto reg_aggr__o_orderdate = aggr__o_orderdate[tid];
MAT10aggr__o_orderdate[mat_idx10] = reg_aggr__o_orderdate;
auto reg_aggr__o_totalprice = aggr__o_totalprice[tid];
MAT10aggr__o_totalprice[mat_idx10] = reg_aggr__o_totalprice;
auto reg_aggr1__tmp_attr1 = aggr1__tmp_attr1[tid];
MAT10aggr1__tmp_attr1[mat_idx10] = reg_aggr1__tmp_attr1;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
//Create aggregation hash table
auto d_HT_0 = cuco::static_map{ (int)6001215*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_1<<<std::ceil((float)lineitem_size/128.), 128>>>(d_HT_0.ref(cuco::insert), lineitem_size, d_lineitem__l_orderkey);
size_t COUNT0 = d_HT_0.size();
thrust::device_vector<int64_t> keys_0(COUNT0), vals_0(COUNT0);
d_HT_0.retrieve_all(keys_0.begin(), vals_0.begin());
d_HT_0.clear();
int64_t* raw_keys0 = thrust::raw_pointer_cast(keys_0.data());
insertKeys<<<std::ceil((float)COUNT0/128.), 128>>>(raw_keys0, d_HT_0.ref(cuco::insert), COUNT0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT0);
DBI32Type* d_KEY_0lineitem_u_1__l_orderkey;
cudaMalloc(&d_KEY_0lineitem_u_1__l_orderkey, sizeof(DBI32Type) * COUNT0);
cudaMemset(d_KEY_0lineitem_u_1__l_orderkey, 0, sizeof(DBI32Type) * COUNT0);
main_1<<<std::ceil((float)lineitem_size/128.), 128>>>(d_HT_0.ref(cuco::find), d_KEY_0lineitem_u_1__l_orderkey, d_aggr0__tmp_attr0, lineitem_size, d_lineitem__l_orderkey, d_lineitem__l_quantity);
//Materialize count
uint64_t* d_COUNT2;
cudaMalloc(&d_COUNT2, sizeof(uint64_t));
cudaMemset(d_COUNT2, 0, sizeof(uint64_t));
count_3<<<std::ceil((float)COUNT0/128.), 128>>>(COUNT0, d_COUNT2, d_aggr0__tmp_attr0);
uint64_t COUNT2;
cudaMemcpy(&COUNT2, d_COUNT2, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
auto d_HT_2 = cuco::static_map{ (int)COUNT2*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_3<<<std::ceil((float)COUNT0/128.), 128>>>(COUNT0, d_HT_2.ref(cuco::insert), d_aggr0__tmp_attr0, d_KEY_0lineitem_u_1__l_orderkey);
//Materialize count
uint64_t* d_COUNT4;
cudaMalloc(&d_COUNT4, sizeof(uint64_t));
cudaMemset(d_COUNT4, 0, sizeof(uint64_t));
count_5<<<std::ceil((float)customer_size/128.), 128>>>(d_COUNT4, customer_size);
uint64_t COUNT4;
cudaMemcpy(&COUNT4, d_COUNT4, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_4;
cudaMalloc(&d_BUF_IDX_4, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_4, 0, sizeof(uint64_t));
uint64_t* d_BUF_4;
cudaMalloc(&d_BUF_4, sizeof(uint64_t) * COUNT4 * 1);
auto d_HT_4 = cuco::static_map{ (int)COUNT4*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)customer_size/128.), 128>>>(d_BUF_4, d_BUF_IDX_4, d_HT_4.ref(cuco::insert), d_customer__c_custkey, customer_size);
//Materialize count
uint64_t* d_COUNT6;
cudaMalloc(&d_COUNT6, sizeof(uint64_t));
cudaMemset(d_COUNT6, 0, sizeof(uint64_t));
count_7<<<std::ceil((float)orders_size/128.), 128>>>(d_BUF_4, d_COUNT6, d_HT_2.ref(cuco::find), d_HT_4.ref(cuco::find), d_orders__o_custkey, d_orders__o_orderkey, orders_size);
uint64_t COUNT6;
cudaMemcpy(&COUNT6, d_COUNT6, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_6;
cudaMalloc(&d_BUF_IDX_6, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6, 0, sizeof(uint64_t));
uint64_t* d_BUF_6;
cudaMalloc(&d_BUF_6, sizeof(uint64_t) * COUNT6 * 2);
auto d_HT_6 = cuco::static_map{ (int)COUNT6*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_7<<<std::ceil((float)orders_size/128.), 128>>>(d_BUF_4, d_BUF_6, d_BUF_IDX_6, d_HT_2.ref(cuco::find), d_HT_4.ref(cuco::find), d_HT_6.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderkey, orders_size);
//Create aggregation hash table
auto d_HT_8 = cuco::static_map{ (int)6001215*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_9<<<std::ceil((float)lineitem_size/128.), 128>>>(d_BUF_6, d_HT_6.ref(cuco::find), d_HT_8.ref(cuco::insert), d_lineitem__l_orderkey, lineitem_size, d_orders__o_orderkey);
size_t COUNT8 = d_HT_8.size();
thrust::device_vector<int64_t> keys_8(COUNT8), vals_8(COUNT8);
d_HT_8.retrieve_all(keys_8.begin(), vals_8.begin());
d_HT_8.clear();
int64_t* raw_keys8 = thrust::raw_pointer_cast(keys_8.data());
insertKeys<<<std::ceil((float)COUNT8/128.), 128>>>(raw_keys8, d_HT_8.ref(cuco::insert), COUNT8);
//Aggregate in hashtable
DBDecimalType* d_aggr1__tmp_attr1;
cudaMalloc(&d_aggr1__tmp_attr1, sizeof(DBDecimalType) * COUNT8);
cudaMemset(d_aggr1__tmp_attr1, 0, sizeof(DBDecimalType) * COUNT8);
DBI32Type* d_aggr__c_custkey;
cudaMalloc(&d_aggr__c_custkey, sizeof(DBI32Type) * COUNT8);
cudaMemset(d_aggr__c_custkey, 0, sizeof(DBI32Type) * COUNT8);
DBDecimalType* d_aggr__o_totalprice;
cudaMalloc(&d_aggr__o_totalprice, sizeof(DBDecimalType) * COUNT8);
cudaMemset(d_aggr__o_totalprice, 0, sizeof(DBDecimalType) * COUNT8);
DBDateType* d_aggr__o_orderdate;
cudaMalloc(&d_aggr__o_orderdate, sizeof(DBDateType) * COUNT8);
cudaMemset(d_aggr__o_orderdate, 0, sizeof(DBDateType) * COUNT8);
DBI32Type* d_KEY_8orders__o_orderkey;
cudaMalloc(&d_KEY_8orders__o_orderkey, sizeof(DBI32Type) * COUNT8);
cudaMemset(d_KEY_8orders__o_orderkey, 0, sizeof(DBI32Type) * COUNT8);
main_9<<<std::ceil((float)lineitem_size/128.), 128>>>(d_BUF_6, d_HT_6.ref(cuco::find), d_HT_8.ref(cuco::find), d_KEY_8orders__o_orderkey, d_aggr1__tmp_attr1, d_aggr__c_custkey, d_aggr__o_orderdate, d_aggr__o_totalprice, d_customer__c_custkey, d_lineitem__l_orderkey, d_lineitem__l_quantity, lineitem_size, d_orders__o_orderdate, d_orders__o_orderkey, d_orders__o_totalprice);
//Materialize count
uint64_t* d_COUNT10;
cudaMalloc(&d_COUNT10, sizeof(uint64_t));
cudaMemset(d_COUNT10, 0, sizeof(uint64_t));
count_11<<<std::ceil((float)COUNT8/128.), 128>>>(d_COUNT10, COUNT8);
uint64_t COUNT10;
cudaMemcpy(&COUNT10, d_COUNT10, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX10;
cudaMalloc(&d_MAT_IDX10, sizeof(uint64_t));
cudaMemset(d_MAT_IDX10, 0, sizeof(uint64_t));
auto MAT10aggr__c_custkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT10);
DBI32Type* d_MAT10aggr__c_custkey;
cudaMalloc(&d_MAT10aggr__c_custkey, sizeof(DBI32Type) * COUNT10);
auto MAT10orders__o_orderkey = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT10);
DBI32Type* d_MAT10orders__o_orderkey;
cudaMalloc(&d_MAT10orders__o_orderkey, sizeof(DBI32Type) * COUNT10);
auto MAT10aggr__o_orderdate = (DBDateType*)malloc(sizeof(DBDateType) * COUNT10);
DBDateType* d_MAT10aggr__o_orderdate;
cudaMalloc(&d_MAT10aggr__o_orderdate, sizeof(DBDateType) * COUNT10);
auto MAT10aggr__o_totalprice = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT10);
DBDecimalType* d_MAT10aggr__o_totalprice;
cudaMalloc(&d_MAT10aggr__o_totalprice, sizeof(DBDecimalType) * COUNT10);
auto MAT10aggr1__tmp_attr1 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT10);
DBDecimalType* d_MAT10aggr1__tmp_attr1;
cudaMalloc(&d_MAT10aggr1__tmp_attr1, sizeof(DBDecimalType) * COUNT10);
main_11<<<std::ceil((float)COUNT8/128.), 128>>>(COUNT8, d_MAT10aggr1__tmp_attr1, d_MAT10aggr__c_custkey, d_MAT10aggr__o_orderdate, d_MAT10aggr__o_totalprice, d_MAT10orders__o_orderkey, d_MAT_IDX10, d_aggr1__tmp_attr1, d_aggr__c_custkey, d_aggr__o_orderdate, d_aggr__o_totalprice, d_KEY_8orders__o_orderkey);
cudaMemcpy(MAT10aggr__c_custkey, d_MAT10aggr__c_custkey, sizeof(DBI32Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10orders__o_orderkey, d_MAT10orders__o_orderkey, sizeof(DBI32Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr__o_orderdate, d_MAT10aggr__o_orderdate, sizeof(DBDateType) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr__o_totalprice, d_MAT10aggr__o_totalprice, sizeof(DBDecimalType) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr1__tmp_attr1, d_MAT10aggr1__tmp_attr1, sizeof(DBDecimalType) * COUNT10, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT10; i++) { std::cout << "" << MAT10aggr__c_custkey[i];
std::cout << "|" << MAT10orders__o_orderkey[i];
std::cout << "|" << MAT10aggr__o_orderdate[i];
std::cout << "|" << MAT10aggr__o_totalprice[i];
std::cout << "|" << MAT10aggr1__tmp_attr1[i];
std::cout << std::endl; }
cudaFree(d_KEY_0lineitem_u_1__l_orderkey);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT2);
cudaFree(d_BUF_4);
cudaFree(d_BUF_IDX_4);
cudaFree(d_COUNT4);
cudaFree(d_BUF_6);
cudaFree(d_BUF_IDX_6);
cudaFree(d_COUNT6);
cudaFree(d_KEY_8orders__o_orderkey);
cudaFree(d_aggr1__tmp_attr1);
cudaFree(d_aggr__c_custkey);
cudaFree(d_aggr__o_orderdate);
cudaFree(d_aggr__o_totalprice);
cudaFree(d_COUNT10);
cudaFree(d_MAT10aggr1__tmp_attr1);
cudaFree(d_MAT10aggr__c_custkey);
cudaFree(d_MAT10aggr__o_orderdate);
cudaFree(d_MAT10aggr__o_totalprice);
cudaFree(d_MAT10orders__o_orderkey);
cudaFree(d_MAT_IDX10);
free(MAT10aggr1__tmp_attr1);
free(MAT10aggr__c_custkey);
free(MAT10aggr__o_orderdate);
free(MAT10aggr__o_totalprice);
free(MAT10orders__o_orderkey);
}