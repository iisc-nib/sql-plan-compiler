#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
template<typename HASHTABLE_INSERT>
__global__ void count_57c908d41c20(HASHTABLE_INSERT HT_57c908d0d780, DBCharType* lineitem__l_linestatus, DBCharType* lineitem__l_returnflag, DBDateType* lineitem__l_shipdate, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 10471, Predicate::lte))) return;
uint64_t KEY_57c908d0d780 = 0;
auto reg_lineitem__l_returnflag = lineitem__l_returnflag[tid];

KEY_57c908d0d780 |= reg_lineitem__l_returnflag;
auto reg_lineitem__l_linestatus = lineitem__l_linestatus[tid];
KEY_57c908d0d780 <<= 8;
KEY_57c908d0d780 |= reg_lineitem__l_linestatus;
//Create aggregation hash table
HT_57c908d0d780.insert(cuco::pair{KEY_57c908d0d780, 1});
}
template<typename HASHTABLE_FIND>
__global__ void main_57c908d41c20(HASHTABLE_FIND HT_57c908d0d780, DBCharType* KEY_57c908d0d780lineitem__l_linestatus, DBCharType* KEY_57c908d0d780lineitem__l_returnflag, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr0__tmp_attr1, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* aggr0__tmp_attr4, DBI64Type* aggr0__tmp_attr9, DBDecimalType* aggr_rw__rw0, DBI64Type* aggr_rw__rw1, DBDecimalType* aggr_rw__rw2, DBI64Type* aggr_rw__rw3, DBDecimalType* aggr_rw__rw4, DBI64Type* aggr_rw__rw5, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBCharType* lineitem__l_linestatus, DBDecimalType* lineitem__l_quantity, DBCharType* lineitem__l_returnflag, DBDateType* lineitem__l_shipdate, DBDecimalType* lineitem__l_tax, size_t lineitem_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 10471, Predicate::lte))) return;
uint64_t KEY_57c908d0d780 = 0;
auto reg_lineitem__l_returnflag = lineitem__l_returnflag[tid];

KEY_57c908d0d780 |= reg_lineitem__l_returnflag;
auto reg_lineitem__l_linestatus = lineitem__l_linestatus[tid];
KEY_57c908d0d780 <<= 8;
KEY_57c908d0d780 |= reg_lineitem__l_linestatus;
//Aggregate in hashtable
auto buf_idx_57c908d0d780 = HT_57c908d0d780.find(KEY_57c908d0d780)->second;
aggregate_sum(&aggr0__tmp_attr9[buf_idx_57c908d0d780], 1);
auto reg_lineitem__l_tax = lineitem__l_tax[tid];
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr5 = ((reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount))) * ((1) + (reg_lineitem__l_tax));
aggregate_sum(&aggr0__tmp_attr4[buf_idx_57c908d0d780], reg_map0__tmp_attr5);
auto reg_map0__tmp_attr3 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_57c908d0d780], reg_map0__tmp_attr3);
aggregate_sum(&aggr0__tmp_attr1[buf_idx_57c908d0d780], reg_lineitem__l_extendedprice);
auto reg_lineitem__l_quantity = lineitem__l_quantity[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_57c908d0d780], reg_lineitem__l_quantity);
aggregate_sum(&aggr_rw__rw0[buf_idx_57c908d0d780], reg_lineitem__l_discount);
aggregate_sum(&aggr_rw__rw1[buf_idx_57c908d0d780], 1);
aggregate_sum(&aggr_rw__rw2[buf_idx_57c908d0d780], reg_lineitem__l_extendedprice);
aggregate_sum(&aggr_rw__rw3[buf_idx_57c908d0d780], 1);
aggregate_sum(&aggr_rw__rw4[buf_idx_57c908d0d780], reg_lineitem__l_quantity);
aggregate_sum(&aggr_rw__rw5[buf_idx_57c908d0d780], 1);
KEY_57c908d0d780lineitem__l_returnflag[buf_idx_57c908d0d780] = reg_lineitem__l_returnflag;
KEY_57c908d0d780lineitem__l_linestatus[buf_idx_57c908d0d780] = reg_lineitem__l_linestatus;
}
__global__ void count_57c908d41e60(uint64_t* COUNT57c908cee9c0, size_t COUNT57c908d0d780) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT57c908d0d780) return;
//Materialize count
atomicAdd((int*)COUNT57c908cee9c0, 1);
}
__global__ void main_57c908d41e60(size_t COUNT57c908d0d780, DBDecimalType* MAT57c908cee9c0aggr0__tmp_attr0, DBDecimalType* MAT57c908cee9c0aggr0__tmp_attr1, DBDecimalType* MAT57c908cee9c0aggr0__tmp_attr2, DBDecimalType* MAT57c908cee9c0aggr0__tmp_attr4, DBDecimalType* MAT57c908cee9c0aggr0__tmp_attr6, DBDecimalType* MAT57c908cee9c0aggr0__tmp_attr7, DBDecimalType* MAT57c908cee9c0aggr0__tmp_attr8, DBI64Type* MAT57c908cee9c0aggr0__tmp_attr9, DBCharType* MAT57c908cee9c0lineitem__l_linestatus, DBCharType* MAT57c908cee9c0lineitem__l_returnflag, uint64_t* MAT_IDX57c908cee9c0, DBDecimalType* aggr0__tmp_attr0, DBDecimalType* aggr0__tmp_attr1, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* aggr0__tmp_attr4, DBI64Type* aggr0__tmp_attr9, DBDecimalType* aggr_rw__rw0, DBI64Type* aggr_rw__rw1, DBDecimalType* aggr_rw__rw2, DBI64Type* aggr_rw__rw3, DBDecimalType* aggr_rw__rw4, DBI64Type* aggr_rw__rw5, DBCharType* lineitem__l_linestatus, DBCharType* lineitem__l_returnflag) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT57c908d0d780) return;
//Materialize buffers
auto mat_idx57c908cee9c0 = atomicAdd((int*)MAT_IDX57c908cee9c0, 1);
auto reg_lineitem__l_returnflag = lineitem__l_returnflag[tid];
MAT57c908cee9c0lineitem__l_returnflag[mat_idx57c908cee9c0] = reg_lineitem__l_returnflag;
auto reg_lineitem__l_linestatus = lineitem__l_linestatus[tid];
MAT57c908cee9c0lineitem__l_linestatus[mat_idx57c908cee9c0] = reg_lineitem__l_linestatus;
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT57c908cee9c0aggr0__tmp_attr0[mat_idx57c908cee9c0] = reg_aggr0__tmp_attr0;
auto reg_aggr0__tmp_attr1 = aggr0__tmp_attr1[tid];
MAT57c908cee9c0aggr0__tmp_attr1[mat_idx57c908cee9c0] = reg_aggr0__tmp_attr1;
auto reg_aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
MAT57c908cee9c0aggr0__tmp_attr2[mat_idx57c908cee9c0] = reg_aggr0__tmp_attr2;
auto reg_aggr0__tmp_attr4 = aggr0__tmp_attr4[tid];
MAT57c908cee9c0aggr0__tmp_attr4[mat_idx57c908cee9c0] = reg_aggr0__tmp_attr4;
auto reg_aggr_rw__rw5 = aggr_rw__rw5[tid];
auto reg_aggr_rw__rw4 = aggr_rw__rw4[tid];
auto reg_aggr0__tmp_attr6 = (reg_aggr_rw__rw4) / ((DBDecimalType)(reg_aggr_rw__rw5));
MAT57c908cee9c0aggr0__tmp_attr6[mat_idx57c908cee9c0] = reg_aggr0__tmp_attr6;
auto reg_aggr_rw__rw3 = aggr_rw__rw3[tid];
auto reg_aggr_rw__rw2 = aggr_rw__rw2[tid];
auto reg_aggr0__tmp_attr7 = (reg_aggr_rw__rw2) / ((DBDecimalType)(reg_aggr_rw__rw3));
MAT57c908cee9c0aggr0__tmp_attr7[mat_idx57c908cee9c0] = reg_aggr0__tmp_attr7;
auto reg_aggr_rw__rw1 = aggr_rw__rw1[tid];
auto reg_aggr_rw__rw0 = aggr_rw__rw0[tid];
auto reg_aggr0__tmp_attr8 = (reg_aggr_rw__rw0) / ((DBDecimalType)(reg_aggr_rw__rw1));
MAT57c908cee9c0aggr0__tmp_attr8[mat_idx57c908cee9c0] = reg_aggr0__tmp_attr8;
auto reg_aggr0__tmp_attr9 = aggr0__tmp_attr9[tid];
MAT57c908cee9c0aggr0__tmp_attr9[mat_idx57c908cee9c0] = reg_aggr0__tmp_attr9;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Create aggregation hash table
auto d_HT_57c908d0d780 = cuco::static_map{ (int)5930889*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_57c908d41c20<<<std::ceil((float)lineitem_size/32.), 32>>>(d_HT_57c908d0d780.ref(cuco::insert), d_lineitem__l_linestatus, d_lineitem__l_returnflag, d_lineitem__l_shipdate, lineitem_size);
size_t COUNT57c908d0d780 = d_HT_57c908d0d780.size();
thrust::device_vector<int64_t> keys_57c908d0d780(COUNT57c908d0d780), vals_57c908d0d780(COUNT57c908d0d780);
d_HT_57c908d0d780.retrieve_all(keys_57c908d0d780.begin(), vals_57c908d0d780.begin());
d_HT_57c908d0d780.clear();
int64_t* raw_keys57c908d0d780 = thrust::raw_pointer_cast(keys_57c908d0d780.data());
insertKeys<<<std::ceil((float)COUNT57c908d0d780/32.), 32>>>(raw_keys57c908d0d780, d_HT_57c908d0d780.ref(cuco::insert), COUNT57c908d0d780);
//Aggregate in hashtable
DBI64Type* d_aggr0__tmp_attr9;
cudaMalloc(&d_aggr0__tmp_attr9, sizeof(DBI64Type) * COUNT57c908d0d780);
cudaMemset(d_aggr0__tmp_attr9, 0, sizeof(DBI64Type) * COUNT57c908d0d780);
DBDecimalType* d_aggr0__tmp_attr4;
cudaMalloc(&d_aggr0__tmp_attr4, sizeof(DBDecimalType) * COUNT57c908d0d780);
cudaMemset(d_aggr0__tmp_attr4, 0, sizeof(DBDecimalType) * COUNT57c908d0d780);
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT57c908d0d780);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT57c908d0d780);
DBDecimalType* d_aggr0__tmp_attr1;
cudaMalloc(&d_aggr0__tmp_attr1, sizeof(DBDecimalType) * COUNT57c908d0d780);
cudaMemset(d_aggr0__tmp_attr1, 0, sizeof(DBDecimalType) * COUNT57c908d0d780);
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT57c908d0d780);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT57c908d0d780);
DBDecimalType* d_aggr_rw__rw0;
cudaMalloc(&d_aggr_rw__rw0, sizeof(DBDecimalType) * COUNT57c908d0d780);
cudaMemset(d_aggr_rw__rw0, 0, sizeof(DBDecimalType) * COUNT57c908d0d780);
DBI64Type* d_aggr_rw__rw1;
cudaMalloc(&d_aggr_rw__rw1, sizeof(DBI64Type) * COUNT57c908d0d780);
cudaMemset(d_aggr_rw__rw1, 0, sizeof(DBI64Type) * COUNT57c908d0d780);
DBDecimalType* d_aggr_rw__rw2;
cudaMalloc(&d_aggr_rw__rw2, sizeof(DBDecimalType) * COUNT57c908d0d780);
cudaMemset(d_aggr_rw__rw2, 0, sizeof(DBDecimalType) * COUNT57c908d0d780);
DBI64Type* d_aggr_rw__rw3;
cudaMalloc(&d_aggr_rw__rw3, sizeof(DBI64Type) * COUNT57c908d0d780);
cudaMemset(d_aggr_rw__rw3, 0, sizeof(DBI64Type) * COUNT57c908d0d780);
DBDecimalType* d_aggr_rw__rw4;
cudaMalloc(&d_aggr_rw__rw4, sizeof(DBDecimalType) * COUNT57c908d0d780);
cudaMemset(d_aggr_rw__rw4, 0, sizeof(DBDecimalType) * COUNT57c908d0d780);
DBI64Type* d_aggr_rw__rw5;
cudaMalloc(&d_aggr_rw__rw5, sizeof(DBI64Type) * COUNT57c908d0d780);
cudaMemset(d_aggr_rw__rw5, 0, sizeof(DBI64Type) * COUNT57c908d0d780);
DBCharType* d_KEY_57c908d0d780lineitem__l_returnflag;
cudaMalloc(&d_KEY_57c908d0d780lineitem__l_returnflag, sizeof(DBCharType) * COUNT57c908d0d780);
cudaMemset(d_KEY_57c908d0d780lineitem__l_returnflag, 0, sizeof(DBCharType) * COUNT57c908d0d780);
DBCharType* d_KEY_57c908d0d780lineitem__l_linestatus;
cudaMalloc(&d_KEY_57c908d0d780lineitem__l_linestatus, sizeof(DBCharType) * COUNT57c908d0d780);
cudaMemset(d_KEY_57c908d0d780lineitem__l_linestatus, 0, sizeof(DBCharType) * COUNT57c908d0d780);
main_57c908d41c20<<<std::ceil((float)lineitem_size/32.), 32>>>(d_HT_57c908d0d780.ref(cuco::find), d_KEY_57c908d0d780lineitem__l_linestatus, d_KEY_57c908d0d780lineitem__l_returnflag, d_aggr0__tmp_attr0, d_aggr0__tmp_attr1, d_aggr0__tmp_attr2, d_aggr0__tmp_attr4, d_aggr0__tmp_attr9, d_aggr_rw__rw0, d_aggr_rw__rw1, d_aggr_rw__rw2, d_aggr_rw__rw3, d_aggr_rw__rw4, d_aggr_rw__rw5, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_linestatus, d_lineitem__l_quantity, d_lineitem__l_returnflag, d_lineitem__l_shipdate, d_lineitem__l_tax, lineitem_size);
//Materialize count
uint64_t* d_COUNT57c908cee9c0;
cudaMalloc(&d_COUNT57c908cee9c0, sizeof(uint64_t));
cudaMemset(d_COUNT57c908cee9c0, 0, sizeof(uint64_t));
count_57c908d41e60<<<std::ceil((float)COUNT57c908d0d780/32.), 32>>>(d_COUNT57c908cee9c0, COUNT57c908d0d780);
uint64_t COUNT57c908cee9c0;
cudaMemcpy(&COUNT57c908cee9c0, d_COUNT57c908cee9c0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX57c908cee9c0;
cudaMalloc(&d_MAT_IDX57c908cee9c0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX57c908cee9c0, 0, sizeof(uint64_t));
auto MAT57c908cee9c0lineitem__l_returnflag = (DBCharType*)malloc(sizeof(DBCharType) * COUNT57c908cee9c0);
DBCharType* d_MAT57c908cee9c0lineitem__l_returnflag;
cudaMalloc(&d_MAT57c908cee9c0lineitem__l_returnflag, sizeof(DBCharType) * COUNT57c908cee9c0);
auto MAT57c908cee9c0lineitem__l_linestatus = (DBCharType*)malloc(sizeof(DBCharType) * COUNT57c908cee9c0);
DBCharType* d_MAT57c908cee9c0lineitem__l_linestatus;
cudaMalloc(&d_MAT57c908cee9c0lineitem__l_linestatus, sizeof(DBCharType) * COUNT57c908cee9c0);
auto MAT57c908cee9c0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT57c908cee9c0);
DBDecimalType* d_MAT57c908cee9c0aggr0__tmp_attr0;
cudaMalloc(&d_MAT57c908cee9c0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT57c908cee9c0);
auto MAT57c908cee9c0aggr0__tmp_attr1 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT57c908cee9c0);
DBDecimalType* d_MAT57c908cee9c0aggr0__tmp_attr1;
cudaMalloc(&d_MAT57c908cee9c0aggr0__tmp_attr1, sizeof(DBDecimalType) * COUNT57c908cee9c0);
auto MAT57c908cee9c0aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT57c908cee9c0);
DBDecimalType* d_MAT57c908cee9c0aggr0__tmp_attr2;
cudaMalloc(&d_MAT57c908cee9c0aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT57c908cee9c0);
auto MAT57c908cee9c0aggr0__tmp_attr4 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT57c908cee9c0);
DBDecimalType* d_MAT57c908cee9c0aggr0__tmp_attr4;
cudaMalloc(&d_MAT57c908cee9c0aggr0__tmp_attr4, sizeof(DBDecimalType) * COUNT57c908cee9c0);
auto MAT57c908cee9c0aggr0__tmp_attr6 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT57c908cee9c0);
DBDecimalType* d_MAT57c908cee9c0aggr0__tmp_attr6;
cudaMalloc(&d_MAT57c908cee9c0aggr0__tmp_attr6, sizeof(DBDecimalType) * COUNT57c908cee9c0);
auto MAT57c908cee9c0aggr0__tmp_attr7 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT57c908cee9c0);
DBDecimalType* d_MAT57c908cee9c0aggr0__tmp_attr7;
cudaMalloc(&d_MAT57c908cee9c0aggr0__tmp_attr7, sizeof(DBDecimalType) * COUNT57c908cee9c0);
auto MAT57c908cee9c0aggr0__tmp_attr8 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT57c908cee9c0);
DBDecimalType* d_MAT57c908cee9c0aggr0__tmp_attr8;
cudaMalloc(&d_MAT57c908cee9c0aggr0__tmp_attr8, sizeof(DBDecimalType) * COUNT57c908cee9c0);
auto MAT57c908cee9c0aggr0__tmp_attr9 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT57c908cee9c0);
DBI64Type* d_MAT57c908cee9c0aggr0__tmp_attr9;
cudaMalloc(&d_MAT57c908cee9c0aggr0__tmp_attr9, sizeof(DBI64Type) * COUNT57c908cee9c0);
main_57c908d41e60<<<std::ceil((float)COUNT57c908d0d780/32.), 32>>>(COUNT57c908d0d780, d_MAT57c908cee9c0aggr0__tmp_attr0, d_MAT57c908cee9c0aggr0__tmp_attr1, d_MAT57c908cee9c0aggr0__tmp_attr2, d_MAT57c908cee9c0aggr0__tmp_attr4, d_MAT57c908cee9c0aggr0__tmp_attr6, d_MAT57c908cee9c0aggr0__tmp_attr7, d_MAT57c908cee9c0aggr0__tmp_attr8, d_MAT57c908cee9c0aggr0__tmp_attr9, d_MAT57c908cee9c0lineitem__l_linestatus, d_MAT57c908cee9c0lineitem__l_returnflag, d_MAT_IDX57c908cee9c0, d_aggr0__tmp_attr0, d_aggr0__tmp_attr1, d_aggr0__tmp_attr2, d_aggr0__tmp_attr4, d_aggr0__tmp_attr9, d_aggr_rw__rw0, d_aggr_rw__rw1, d_aggr_rw__rw2, d_aggr_rw__rw3, d_aggr_rw__rw4, d_aggr_rw__rw5, d_KEY_57c908d0d780lineitem__l_linestatus, d_KEY_57c908d0d780lineitem__l_returnflag);
cudaMemcpy(MAT57c908cee9c0lineitem__l_returnflag, d_MAT57c908cee9c0lineitem__l_returnflag, sizeof(DBCharType) * COUNT57c908cee9c0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT57c908cee9c0lineitem__l_linestatus, d_MAT57c908cee9c0lineitem__l_linestatus, sizeof(DBCharType) * COUNT57c908cee9c0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT57c908cee9c0aggr0__tmp_attr0, d_MAT57c908cee9c0aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT57c908cee9c0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT57c908cee9c0aggr0__tmp_attr1, d_MAT57c908cee9c0aggr0__tmp_attr1, sizeof(DBDecimalType) * COUNT57c908cee9c0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT57c908cee9c0aggr0__tmp_attr2, d_MAT57c908cee9c0aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT57c908cee9c0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT57c908cee9c0aggr0__tmp_attr4, d_MAT57c908cee9c0aggr0__tmp_attr4, sizeof(DBDecimalType) * COUNT57c908cee9c0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT57c908cee9c0aggr0__tmp_attr6, d_MAT57c908cee9c0aggr0__tmp_attr6, sizeof(DBDecimalType) * COUNT57c908cee9c0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT57c908cee9c0aggr0__tmp_attr7, d_MAT57c908cee9c0aggr0__tmp_attr7, sizeof(DBDecimalType) * COUNT57c908cee9c0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT57c908cee9c0aggr0__tmp_attr8, d_MAT57c908cee9c0aggr0__tmp_attr8, sizeof(DBDecimalType) * COUNT57c908cee9c0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT57c908cee9c0aggr0__tmp_attr9, d_MAT57c908cee9c0aggr0__tmp_attr9, sizeof(DBI64Type) * COUNT57c908cee9c0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT57c908cee9c0; i++) { std::cout << MAT57c908cee9c0lineitem__l_returnflag[i] << "\t";
std::cout << MAT57c908cee9c0lineitem__l_linestatus[i] << "\t";
std::cout << MAT57c908cee9c0aggr0__tmp_attr0[i] << "\t";
std::cout << MAT57c908cee9c0aggr0__tmp_attr1[i] << "\t";
std::cout << MAT57c908cee9c0aggr0__tmp_attr2[i] << "\t";
std::cout << MAT57c908cee9c0aggr0__tmp_attr4[i] << "\t";
std::cout << MAT57c908cee9c0aggr0__tmp_attr6[i] << "\t";
std::cout << MAT57c908cee9c0aggr0__tmp_attr7[i] << "\t";
std::cout << MAT57c908cee9c0aggr0__tmp_attr8[i] << "\t";
std::cout << MAT57c908cee9c0aggr0__tmp_attr9[i] << "\t";
std::cout << std::endl; }
cudaFree(d_KEY_57c908d0d780lineitem__l_linestatus);
cudaFree(d_KEY_57c908d0d780lineitem__l_returnflag);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_aggr0__tmp_attr1);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_aggr0__tmp_attr4);
cudaFree(d_aggr0__tmp_attr9);
cudaFree(d_aggr_rw__rw0);
cudaFree(d_aggr_rw__rw1);
cudaFree(d_aggr_rw__rw2);
cudaFree(d_aggr_rw__rw3);
cudaFree(d_aggr_rw__rw4);
cudaFree(d_aggr_rw__rw5);
cudaFree(d_COUNT57c908cee9c0);
cudaFree(d_MAT57c908cee9c0aggr0__tmp_attr0);
cudaFree(d_MAT57c908cee9c0aggr0__tmp_attr1);
cudaFree(d_MAT57c908cee9c0aggr0__tmp_attr2);
cudaFree(d_MAT57c908cee9c0aggr0__tmp_attr4);
cudaFree(d_MAT57c908cee9c0aggr0__tmp_attr6);
cudaFree(d_MAT57c908cee9c0aggr0__tmp_attr7);
cudaFree(d_MAT57c908cee9c0aggr0__tmp_attr8);
cudaFree(d_MAT57c908cee9c0aggr0__tmp_attr9);
cudaFree(d_MAT57c908cee9c0lineitem__l_linestatus);
cudaFree(d_MAT57c908cee9c0lineitem__l_returnflag);
cudaFree(d_MAT_IDX57c908cee9c0);
free(MAT57c908cee9c0aggr0__tmp_attr0);
free(MAT57c908cee9c0aggr0__tmp_attr1);
free(MAT57c908cee9c0aggr0__tmp_attr2);
free(MAT57c908cee9c0aggr0__tmp_attr4);
free(MAT57c908cee9c0aggr0__tmp_attr6);
free(MAT57c908cee9c0aggr0__tmp_attr7);
free(MAT57c908cee9c0aggr0__tmp_attr8);
free(MAT57c908cee9c0aggr0__tmp_attr9);
free(MAT57c908cee9c0lineitem__l_linestatus);
free(MAT57c908cee9c0lineitem__l_returnflag);
}