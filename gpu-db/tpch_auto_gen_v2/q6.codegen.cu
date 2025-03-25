#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
template<typename HASHTABLE_INSERT>
__global__ void count_62f8e8faa090(HASHTABLE_INSERT HT_62f8e9056380, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_quantity, DBDateType* lineitem__l_shipdate, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 8766, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::lt))) return;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
if (!(evaluatePredicate(reg_lineitem__l_discount, 0.05, Predicate::gte) && evaluatePredicate(reg_lineitem__l_discount, 0.07, Predicate::lte))) return;
auto reg_lineitem__l_quantity = lineitem__l_quantity[tid];
if (!(evaluatePredicate(reg_lineitem__l_quantity, 24., Predicate::lt))) return;
uint64_t KEY_62f8e9056380 = 0;
//Create aggregation hash table
HT_62f8e9056380.insert(cuco::pair{KEY_62f8e9056380, 1});
}
template<typename HASHTABLE_FIND>
__global__ void main_62f8e8faa090(HASHTABLE_FIND HT_62f8e9056380, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBDecimalType* lineitem__l_quantity, DBDateType* lineitem__l_shipdate, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 8766, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::lt))) return;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
if (!(evaluatePredicate(reg_lineitem__l_discount, 0.05, Predicate::gte) && evaluatePredicate(reg_lineitem__l_discount, 0.07, Predicate::lte))) return;
auto reg_lineitem__l_quantity = lineitem__l_quantity[tid];
if (!(evaluatePredicate(reg_lineitem__l_quantity, 24., Predicate::lt))) return;
uint64_t KEY_62f8e9056380 = 0;
//Aggregate in hashtable
auto buf_idx_62f8e9056380 = HT_62f8e9056380.find(KEY_62f8e9056380)->second;
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * (reg_lineitem__l_discount);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_62f8e9056380], reg_map0__tmp_attr1);
}
__global__ void count_62f8e902c890(size_t COUNT62f8e9056380, uint64_t* COUNT62f8e90687e0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT62f8e9056380) return;
//Materialize count
atomicAdd((int*)COUNT62f8e90687e0, 1);
}
__global__ void main_62f8e902c890(size_t COUNT62f8e9056380, DBDecimalType* MAT62f8e90687e0aggr0__tmp_attr0, uint64_t* MAT_IDX62f8e90687e0, DBDecimalType* aggr0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT62f8e9056380) return;
//Materialize buffers
auto mat_idx62f8e90687e0 = atomicAdd((int*)MAT_IDX62f8e90687e0, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT62f8e90687e0aggr0__tmp_attr0[mat_idx62f8e90687e0] = reg_aggr0__tmp_attr0;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Create aggregation hash table
auto d_HT_62f8e9056380 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_62f8e8faa090<<<std::ceil((float)lineitem_size/32.), 32>>>(d_HT_62f8e9056380.ref(cuco::insert), d_lineitem__l_discount, d_lineitem__l_quantity, d_lineitem__l_shipdate, lineitem_size);
size_t COUNT62f8e9056380 = d_HT_62f8e9056380.size();
thrust::device_vector<int64_t> keys_62f8e9056380(COUNT62f8e9056380), vals_62f8e9056380(COUNT62f8e9056380);
d_HT_62f8e9056380.retrieve_all(keys_62f8e9056380.begin(), vals_62f8e9056380.begin());
thrust::host_vector<int64_t> h_keys_62f8e9056380(COUNT62f8e9056380);
thrust::copy(keys_62f8e9056380.begin(), keys_62f8e9056380.end(), h_keys_62f8e9056380.begin());
thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_62f8e9056380(COUNT62f8e9056380);
for (int i=0; i < COUNT62f8e9056380; i++)
{actual_dict_62f8e9056380[i] = cuco::make_pair(h_keys_62f8e9056380[i], i);}
d_HT_62f8e9056380.clear();
d_HT_62f8e9056380.insert(actual_dict_62f8e9056380.begin(), actual_dict_62f8e9056380.end());
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT62f8e9056380);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT62f8e9056380);
main_62f8e8faa090<<<std::ceil((float)lineitem_size/32.), 32>>>(d_HT_62f8e9056380.ref(cuco::find), d_aggr0__tmp_attr0, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_quantity, d_lineitem__l_shipdate, lineitem_size);
//Materialize count
uint64_t* d_COUNT62f8e90687e0;
cudaMalloc(&d_COUNT62f8e90687e0, sizeof(uint64_t));
cudaMemset(d_COUNT62f8e90687e0, 0, sizeof(uint64_t));
count_62f8e902c890<<<std::ceil((float)COUNT62f8e9056380/32.), 32>>>(COUNT62f8e9056380, d_COUNT62f8e90687e0);
uint64_t COUNT62f8e90687e0;
cudaMemcpy(&COUNT62f8e90687e0, d_COUNT62f8e90687e0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT62f8e90687e0);
//Materialize buffers
uint64_t* d_MAT_IDX62f8e90687e0;
cudaMalloc(&d_MAT_IDX62f8e90687e0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX62f8e90687e0, 0, sizeof(uint64_t));
auto MAT62f8e90687e0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT62f8e90687e0);
DBDecimalType* d_MAT62f8e90687e0aggr0__tmp_attr0;
cudaMalloc(&d_MAT62f8e90687e0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT62f8e90687e0);
main_62f8e902c890<<<std::ceil((float)COUNT62f8e9056380/32.), 32>>>(COUNT62f8e9056380, d_MAT62f8e90687e0aggr0__tmp_attr0, d_MAT_IDX62f8e90687e0, d_aggr0__tmp_attr0);
cudaFree(d_MAT_IDX62f8e90687e0);
cudaMemcpy(MAT62f8e90687e0aggr0__tmp_attr0, d_MAT62f8e90687e0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT62f8e90687e0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT62f8e90687e0; i++) { std::cout << MAT62f8e90687e0aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
}