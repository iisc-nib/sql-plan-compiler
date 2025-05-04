#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
template<typename HASHTABLE_FIND>
__global__ void main_1(HASHTABLE_FIND HT_0, int* SLOT_COUNT_0, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBDecimalType* lineitem__l_quantity, DBDateType* lineitem__l_shipdate, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 8766, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::lt))) return;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
if (!(evaluatePredicate(reg_lineitem__l_discount, 0.05, Predicate::gte) && evaluatePredicate(reg_lineitem__l_discount, 0.07, Predicate::lte))) return;
auto reg_lineitem__l_quantity = lineitem__l_quantity[tid];
if (!(evaluatePredicate(reg_lineitem__l_quantity, 24.0, Predicate::lt))) return;
uint64_t KEY_0 = 0;
//Aggregate in hashtable
auto buf_idx_0 = get_aggregation_slot(KEY_0, HT_0, SLOT_COUNT_0);
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * (reg_lineitem__l_discount);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_0], reg_map0__tmp_attr1);
}
__global__ void main_3(size_t COUNT0, DBDecimalType* MAT2aggr0__tmp_attr0, uint64_t* MAT_IDX2, DBDecimalType* aggr0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT0) return;
//Materialize buffers
auto mat_idx2 = atomicAdd((int*)MAT_IDX2, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT2aggr0__tmp_attr0[mat_idx2] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map) {
size_t COUNT0 = 1;
auto d_HT_0 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_0;
cudaMalloc(&d_SLOT_COUNT_0, sizeof(int));
cudaMemset(d_SLOT_COUNT_0, 0, sizeof(int));
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT0);
main_1<<<std::ceil((float)lineitem_size/128.), 128>>>(d_HT_0.ref(cuco::insert_and_find), d_SLOT_COUNT_0, d_aggr0__tmp_attr0, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_quantity, d_lineitem__l_shipdate, lineitem_size);
COUNT0 = d_HT_0.size();
size_t COUNT2 = COUNT0;
//Materialize buffers
uint64_t* d_MAT_IDX2;
cudaMalloc(&d_MAT_IDX2, sizeof(uint64_t));
cudaMemset(d_MAT_IDX2, 0, sizeof(uint64_t));
auto MAT2aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT2);
DBDecimalType* d_MAT2aggr0__tmp_attr0;
cudaMalloc(&d_MAT2aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT2);
main_3<<<std::ceil((float)COUNT0/128.), 128>>>(COUNT0, d_MAT2aggr0__tmp_attr0, d_MAT_IDX2, d_aggr0__tmp_attr0);
cudaMemcpy(MAT2aggr0__tmp_attr0, d_MAT2aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT2, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT2; i++) { std::cout << "" << MAT2aggr0__tmp_attr0[i];
std::cout << std::endl; }
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_MAT2aggr0__tmp_attr0);
cudaFree(d_MAT_IDX2);
free(MAT2aggr0__tmp_attr0);
}