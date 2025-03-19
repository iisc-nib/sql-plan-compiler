
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"

#include <cuco/static_map.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <iomanip>

template<typename HASHTABLE_INSERT>
__global__ void count_pipeline_5fe3c684fb10(DBDecimalType *lineitem__l_discount,
DBDecimalType *lineitem__l_extendedprice,
DBCharType *lineitem__l_linestatus,
DBCharType *lineitem__l_returnflag,
DBDateType *lineitem__l_shipdate,
DBDecimalType *lineitem__l_tax,
HASHTABLE_INSERT HT_5fe3c6804700,
size_t lineitem_size
) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg__lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg__lineitem__l_shipdate, 10471, Predicate::lte))) return;
auto reg__lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg__lineitem__l_discount = lineitem__l_discount[tid];
auto reg__lineitem__l_tax = lineitem__l_tax[tid];
auto reg__lineitem__l_returnflag = lineitem__l_returnflag[tid];
auto reg__lineitem__l_linestatus = lineitem__l_linestatus[tid];
int64_t KEY_5fe3c6804700 = 0;
KEY_5fe3c6804700 <<= 8;
KEY_5fe3c6804700  |= reg__lineitem__l_returnflag;
KEY_5fe3c6804700 <<= 8;
KEY_5fe3c6804700  |= reg__lineitem__l_linestatus;

HT_5fe3c6804700.insert(cuco::pair{KEY_5fe3c6804700, 1});
return;
}
template<typename HASHTABLE_FIND>
__global__ void main_pipeline_5fe3c684fb10(DBCharType *KEY_5fe3c6804700lineitem__l_linestatus,
DBCharType *KEY_5fe3c6804700lineitem__l_returnflag,
DBDecimalType *aggr0__tmp_attr0,
DBDecimalType *aggr0__tmp_attr1,
DBDecimalType *aggr0__tmp_attr2,
DBDecimalType *aggr0__tmp_attr4,
DBI64Type *aggr0__tmp_attr9,
DBDecimalType *aggr_rw__rw0,
DBI64Type *aggr_rw__rw1,
DBDecimalType *aggr_rw__rw2,
DBI64Type *aggr_rw__rw3,
DBDecimalType *aggr_rw__rw4,
DBI64Type *aggr_rw__rw5,
DBDecimalType *lineitem__l_discount,
DBDecimalType *lineitem__l_extendedprice,
DBCharType *lineitem__l_linestatus,
DBDecimalType *lineitem__l_quantity,
DBCharType *lineitem__l_returnflag,
DBDateType *lineitem__l_shipdate,
DBDecimalType *lineitem__l_tax,
HASHTABLE_FIND HT_5fe3c6804700,
size_t lineitem_size
) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg__lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg__lineitem__l_shipdate, 10471, Predicate::lte))) return;
auto reg__lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg__lineitem__l_discount = lineitem__l_discount[tid];
auto reg__lineitem__l_tax = lineitem__l_tax[tid];
auto reg__lineitem__l_returnflag = lineitem__l_returnflag[tid];
auto reg__lineitem__l_linestatus = lineitem__l_linestatus[tid];
int64_t KEY_5fe3c6804700 = 0;
KEY_5fe3c6804700 <<= 8;
KEY_5fe3c6804700  |= reg__lineitem__l_returnflag;
KEY_5fe3c6804700 <<= 8;
KEY_5fe3c6804700  |= reg__lineitem__l_linestatus;

auto buf_idx_5fe3c6804700 = HT_5fe3c6804700.find(KEY_5fe3c6804700)->second;
KEY_5fe3c6804700lineitem__l_returnflag[buf_idx_5fe3c6804700] = reg__lineitem__l_returnflag;
KEY_5fe3c6804700lineitem__l_linestatus[buf_idx_5fe3c6804700] = reg__lineitem__l_linestatus;
aggregate_sum(&aggr0__tmp_attr9[buf_idx_5fe3c6804700], 1);
auto reg__map0__tmp_attr5 = ((reg__lineitem__l_extendedprice) * ((1) - (reg__lineitem__l_discount))) * ((1) + (reg__lineitem__l_tax));
aggregate_sum(&aggr0__tmp_attr4[buf_idx_5fe3c6804700], reg__map0__tmp_attr5);
auto reg__map0__tmp_attr3 = (reg__lineitem__l_extendedprice) * ((1) - (reg__lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_5fe3c6804700], reg__map0__tmp_attr3);
aggregate_sum(&aggr0__tmp_attr1[buf_idx_5fe3c6804700], reg__lineitem__l_extendedprice);
auto reg__lineitem__l_quantity = lineitem__l_quantity[tid];
aggregate_sum(&aggr0__tmp_attr0[buf_idx_5fe3c6804700], reg__lineitem__l_quantity);
aggregate_sum(&aggr_rw__rw0[buf_idx_5fe3c6804700], reg__lineitem__l_discount);
aggregate_sum(&aggr_rw__rw1[buf_idx_5fe3c6804700], 1);
aggregate_sum(&aggr_rw__rw2[buf_idx_5fe3c6804700], reg__lineitem__l_extendedprice);
aggregate_sum(&aggr_rw__rw3[buf_idx_5fe3c6804700], 1);
aggregate_sum(&aggr_rw__rw4[buf_idx_5fe3c6804700], reg__lineitem__l_quantity);
aggregate_sum(&aggr_rw__rw5[buf_idx_5fe3c6804700], 1);
return;
}
__global__ void count_pipeline_5fe3c6857360(DBDecimalType *aggr_rw__rw0,
DBI64Type *aggr_rw__rw1,
DBDecimalType *aggr_rw__rw2,
DBI64Type *aggr_rw__rw3,
DBDecimalType *aggr_rw__rw4,
DBI64Type *aggr_rw__rw5,
size_t MAT_5fe3c6804700_size
) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= MAT_5fe3c6804700_size) return;
auto reg__aggr_rw__rw0 = aggr_rw__rw0[tid];
auto reg__aggr_rw__rw1 = aggr_rw__rw1[tid];
auto reg__aggr_rw__rw2 = aggr_rw__rw2[tid];
auto reg__aggr_rw__rw3 = aggr_rw__rw3[tid];
auto reg__aggr_rw__rw4 = aggr_rw__rw4[tid];
auto reg__aggr_rw__rw5 = aggr_rw__rw5[tid];
}
__global__ void main_pipeline_5fe3c6857360(DBDecimalType *MAT_5fe3c67e4900aggr0__tmp_attr0,
DBDecimalType *MAT_5fe3c67e4900aggr0__tmp_attr1,
DBDecimalType *MAT_5fe3c67e4900aggr0__tmp_attr2,
DBDecimalType *MAT_5fe3c67e4900aggr0__tmp_attr4,
DBDecimalType *MAT_5fe3c67e4900aggr0__tmp_attr6,
DBDecimalType *MAT_5fe3c67e4900aggr0__tmp_attr7,
DBDecimalType *MAT_5fe3c67e4900aggr0__tmp_attr8,
DBI64Type *MAT_5fe3c67e4900aggr0__tmp_attr9,
DBCharType *MAT_5fe3c67e4900lineitem__l_linestatus,
DBCharType *MAT_5fe3c67e4900lineitem__l_returnflag,
DBDecimalType *aggr0__tmp_attr0,
DBDecimalType *aggr0__tmp_attr1,
DBDecimalType *aggr0__tmp_attr2,
DBDecimalType *aggr0__tmp_attr4,
DBI64Type *aggr0__tmp_attr9,
DBDecimalType *aggr_rw__rw0,
DBI64Type *aggr_rw__rw1,
DBDecimalType *aggr_rw__rw2,
DBI64Type *aggr_rw__rw3,
DBDecimalType *aggr_rw__rw4,
DBI64Type *aggr_rw__rw5,
DBCharType *lineitem__l_linestatus,
DBCharType *lineitem__l_returnflag,
size_t MAT_5fe3c6804700_size
) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= MAT_5fe3c6804700_size) return;
auto reg__aggr_rw__rw0 = aggr_rw__rw0[tid];
auto reg__aggr_rw__rw1 = aggr_rw__rw1[tid];
auto reg__aggr_rw__rw2 = aggr_rw__rw2[tid];
auto reg__aggr_rw__rw3 = aggr_rw__rw3[tid];
auto reg__aggr_rw__rw4 = aggr_rw__rw4[tid];
auto reg__aggr_rw__rw5 = aggr_rw__rw5[tid];
auto reg__lineitem__l_returnflag = lineitem__l_returnflag[tid];
MAT_5fe3c67e4900lineitem__l_returnflag[tid] = reg__lineitem__l_returnflag;
auto reg__lineitem__l_linestatus = lineitem__l_linestatus[tid];
MAT_5fe3c67e4900lineitem__l_linestatus[tid] = reg__lineitem__l_linestatus;
auto reg__aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT_5fe3c67e4900aggr0__tmp_attr0[tid] = reg__aggr0__tmp_attr0;
auto reg__aggr0__tmp_attr1 = aggr0__tmp_attr1[tid];
MAT_5fe3c67e4900aggr0__tmp_attr1[tid] = reg__aggr0__tmp_attr1;
auto reg__aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
MAT_5fe3c67e4900aggr0__tmp_attr2[tid] = reg__aggr0__tmp_attr2;
auto reg__aggr0__tmp_attr4 = aggr0__tmp_attr4[tid];
MAT_5fe3c67e4900aggr0__tmp_attr4[tid] = reg__aggr0__tmp_attr4;
auto reg__aggr0__tmp_attr6 = (reg__aggr_rw__rw4) / ((DBDecimalType)(reg__aggr_rw__rw5));
MAT_5fe3c67e4900aggr0__tmp_attr6[tid] = reg__aggr0__tmp_attr6;
auto reg__aggr0__tmp_attr7 = (reg__aggr_rw__rw2) / ((DBDecimalType)(reg__aggr_rw__rw3));
MAT_5fe3c67e4900aggr0__tmp_attr7[tid] = reg__aggr0__tmp_attr7;
auto reg__aggr0__tmp_attr8 = (reg__aggr_rw__rw0) / ((DBDecimalType)(reg__aggr_rw__rw1));
MAT_5fe3c67e4900aggr0__tmp_attr8[tid] = reg__aggr0__tmp_attr8;
auto reg__aggr0__tmp_attr9 = aggr0__tmp_attr9[tid];
MAT_5fe3c67e4900aggr0__tmp_attr9[tid] = reg__aggr0__tmp_attr9;
}

extern "C" void control(
DBI32Type* d_nation__n_nationkey,
DBStringType* d_nation__n_name,
DBI32Type* d_nation__n_regionkey,
DBStringType* d_nation__n_comment,
size_t nation_size,
DBI32Type* d_supplier__s_suppkey,
DBI32Type* d_supplier__s_nationkey,
DBStringType* d_supplier__s_name,
DBStringType* d_supplier__s_address,
DBStringType* d_supplier__s_phone,
DBDecimalType* d_supplier__s_acctbal,
DBStringType* d_supplier__s_comment,
size_t supplier_size,
DBI32Type* d_partsupp__ps_suppkey,
DBI32Type* d_partsupp__ps_partkey,
DBI32Type* d_partsupp__ps_availqty,
DBDecimalType* d_partsupp__ps_supplycost,
DBStringType* d_partsupp__ps_comment,
size_t partsupp_size,
DBI32Type* d_part__p_partkey,
DBStringType* d_part__p_name,
DBStringType* d_part__p_mfgr,
DBStringType* d_part__p_brand,
DBStringType* d_part__p_type,
DBI32Type* d_part__p_size,
DBStringType* d_part__p_container,
DBDecimalType* d_part__p_retailprice,
DBStringType* d_part__p_comment,
size_t part_size,
DBI32Type* d_lineitem__l_orderkey,
DBI32Type* d_lineitem__l_partkey,
DBI32Type* d_lineitem__l_suppkey,
DBI64Type* d_lineitem__l_linenumber,
DBDecimalType* d_lineitem__l_quantity,
DBDecimalType* d_lineitem__l_extendedprice,
DBDecimalType* d_lineitem__l_discount,
DBDecimalType* d_lineitem__l_tax,
DBCharType* d_lineitem__l_returnflag,
DBCharType* d_lineitem__l_linestatus,
DBI32Type* d_lineitem__l_shipdate,
DBI32Type* d_lineitem__l_commitdate,
DBI32Type* d_lineitem__l_receiptdate,
DBStringType* d_lineitem__l_shipinstruct,
DBStringType* d_lineitem__l_shipmode,
DBStringType* d_lineitem__comments,
size_t lineitem_size,
DBI32Type* d_orders__o_orderkey,
DBCharType* d_orders__o_orderstatus,
DBI32Type* d_orders__o_custkey,
DBDecimalType* d_orders__o_totalprice,
DBI32Type* d_orders__o_orderdate,
DBStringType* d_orders__o_orderpriority,
DBStringType* d_orders__o_clerk,
DBI32Type* d_orders__o_shippriority,
DBStringType* d_orders__o_comment,
size_t orders_size,
DBI32Type* d_customer__c_custkey,
DBStringType* d_customer__c_name,
DBStringType* d_customer__c_address,
DBI32Type* d_customer__c_nationkey,
DBStringType* d_customer__c_phone,
DBDecimalType* d_customer__c_acctbal,
DBStringType* d_customer__c_mktsegment,
DBStringType* d_customer__c_comment,
size_t customer_size,
DBI32Type* d_region__r_regionkey,
DBStringType* d_region__r_name,
DBStringType* d_region__r_comment,
size_t region_size
)
{
    auto HT_5fe3c6804700 = cuco::static_map{ 5930889* 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};
    count_pipeline_5fe3c684fb10<<<std::ceil((float)lineitem_size/(float)32), 32>>>(d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_linestatus, d_lineitem__l_returnflag, d_lineitem__l_shipdate, d_lineitem__l_tax, HT_5fe3c6804700.ref(cuco::insert), lineitem_size);
    
    thrust::device_vector<int64_t> keys_5fe3c6804700(HT_5fe3c6804700.size()), vals_5fe3c6804700(HT_5fe3c6804700.size());
    HT_5fe3c6804700.retrieve_all(keys_5fe3c6804700.begin(), vals_5fe3c6804700.begin());
    thrust::host_vector<int64_t> h_keys_5fe3c6804700(HT_5fe3c6804700.size());
    thrust::copy(keys_5fe3c6804700.begin(), keys_5fe3c6804700.end(), h_keys_5fe3c6804700.begin());
    thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_5fe3c6804700(HT_5fe3c6804700.size());
    for (int i=0; i < HT_5fe3c6804700.size(); i++) {{
    actual_dict_5fe3c6804700[i] = cuco::make_pair(h_keys_5fe3c6804700[i], i);
    }}
    HT_5fe3c6804700.clear();
    HT_5fe3c6804700.insert(actual_dict_5fe3c6804700.begin(), actual_dict_5fe3c6804700.end());
    DBI64Type*  d_aggr0__tmp_attr9;
    cudaMalloc(&d_aggr0__tmp_attr9, sizeof(DBI64Type) * HT_5fe3c6804700.size());
    cudaMemset(d_aggr0__tmp_attr9,0 , sizeof(DBI64Type) * HT_5fe3c6804700.size());
    DBDecimalType*  d_aggr0__tmp_attr4;
    cudaMalloc(&d_aggr0__tmp_attr4, sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    cudaMemset(d_aggr0__tmp_attr4,0 , sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    DBDecimalType*  d_aggr0__tmp_attr2;
    cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    cudaMemset(d_aggr0__tmp_attr2,0 , sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    DBDecimalType*  d_aggr0__tmp_attr1;
    cudaMalloc(&d_aggr0__tmp_attr1, sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    cudaMemset(d_aggr0__tmp_attr1,0 , sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    DBDecimalType*  d_aggr0__tmp_attr0;
    cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    cudaMemset(d_aggr0__tmp_attr0,0 , sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    DBDecimalType*  d_aggr_rw__rw0;
    cudaMalloc(&d_aggr_rw__rw0, sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    cudaMemset(d_aggr_rw__rw0,0 , sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    DBI64Type*  d_aggr_rw__rw1;
    cudaMalloc(&d_aggr_rw__rw1, sizeof(DBI64Type) * HT_5fe3c6804700.size());
    cudaMemset(d_aggr_rw__rw1,0 , sizeof(DBI64Type) * HT_5fe3c6804700.size());
    DBDecimalType*  d_aggr_rw__rw2;
    cudaMalloc(&d_aggr_rw__rw2, sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    cudaMemset(d_aggr_rw__rw2,0 , sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    DBI64Type*  d_aggr_rw__rw3;
    cudaMalloc(&d_aggr_rw__rw3, sizeof(DBI64Type) * HT_5fe3c6804700.size());
    cudaMemset(d_aggr_rw__rw3,0 , sizeof(DBI64Type) * HT_5fe3c6804700.size());
    DBDecimalType*  d_aggr_rw__rw4;
    cudaMalloc(&d_aggr_rw__rw4, sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    cudaMemset(d_aggr_rw__rw4,0 , sizeof(DBDecimalType) * HT_5fe3c6804700.size());
    DBI64Type*  d_aggr_rw__rw5;
    cudaMalloc(&d_aggr_rw__rw5, sizeof(DBI64Type) * HT_5fe3c6804700.size());
    cudaMemset(d_aggr_rw__rw5,0 , sizeof(DBI64Type) * HT_5fe3c6804700.size());
    auto MAT_5fe3c6804700_size = HT_5fe3c6804700.size();
    DBCharType*  d_KEY_5fe3c6804700lineitem__l_returnflag;
    cudaMalloc(&d_KEY_5fe3c6804700lineitem__l_returnflag, sizeof(DBCharType) * HT_5fe3c6804700.size());
    cudaMemset(d_KEY_5fe3c6804700lineitem__l_returnflag,0 , sizeof(DBCharType) * HT_5fe3c6804700.size());
    DBCharType*  d_KEY_5fe3c6804700lineitem__l_linestatus;
    cudaMalloc(&d_KEY_5fe3c6804700lineitem__l_linestatus, sizeof(DBCharType) * HT_5fe3c6804700.size());
    cudaMemset(d_KEY_5fe3c6804700lineitem__l_linestatus,0 , sizeof(DBCharType) * HT_5fe3c6804700.size());
    main_pipeline_5fe3c684fb10<<<std::ceil((float)lineitem_size/(float)32), 32>>>(d_KEY_5fe3c6804700lineitem__l_linestatus, d_KEY_5fe3c6804700lineitem__l_returnflag, d_aggr0__tmp_attr0, d_aggr0__tmp_attr1, d_aggr0__tmp_attr2, d_aggr0__tmp_attr4, d_aggr0__tmp_attr9, d_aggr_rw__rw0, d_aggr_rw__rw1, d_aggr_rw__rw2, d_aggr_rw__rw3, d_aggr_rw__rw4, d_aggr_rw__rw5, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_linestatus, d_lineitem__l_quantity, d_lineitem__l_returnflag, d_lineitem__l_shipdate, d_lineitem__l_tax, HT_5fe3c6804700.ref(cuco::find), lineitem_size);
    
    
    auto MAT_5fe3c67e4900lineitem__l_returnflag = (DBCharType*)malloc(sizeof(DBCharType) * MAT_5fe3c6804700_size);
    DBCharType* d_MAT_5fe3c67e4900lineitem__l_returnflag;
    cudaMalloc(&d_MAT_5fe3c67e4900lineitem__l_returnflag, sizeof(DBCharType) * MAT_5fe3c6804700_size);
    auto MAT_5fe3c67e4900lineitem__l_linestatus = (DBCharType*)malloc(sizeof(DBCharType) * MAT_5fe3c6804700_size);
    DBCharType* d_MAT_5fe3c67e4900lineitem__l_linestatus;
    cudaMalloc(&d_MAT_5fe3c67e4900lineitem__l_linestatus, sizeof(DBCharType) * MAT_5fe3c6804700_size);
    auto MAT_5fe3c67e4900aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    DBDecimalType* d_MAT_5fe3c67e4900aggr0__tmp_attr0;
    cudaMalloc(&d_MAT_5fe3c67e4900aggr0__tmp_attr0, sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    auto MAT_5fe3c67e4900aggr0__tmp_attr1 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    DBDecimalType* d_MAT_5fe3c67e4900aggr0__tmp_attr1;
    cudaMalloc(&d_MAT_5fe3c67e4900aggr0__tmp_attr1, sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    auto MAT_5fe3c67e4900aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    DBDecimalType* d_MAT_5fe3c67e4900aggr0__tmp_attr2;
    cudaMalloc(&d_MAT_5fe3c67e4900aggr0__tmp_attr2, sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    auto MAT_5fe3c67e4900aggr0__tmp_attr4 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    DBDecimalType* d_MAT_5fe3c67e4900aggr0__tmp_attr4;
    cudaMalloc(&d_MAT_5fe3c67e4900aggr0__tmp_attr4, sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    auto MAT_5fe3c67e4900aggr0__tmp_attr6 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    DBDecimalType* d_MAT_5fe3c67e4900aggr0__tmp_attr6;
    cudaMalloc(&d_MAT_5fe3c67e4900aggr0__tmp_attr6, sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    auto MAT_5fe3c67e4900aggr0__tmp_attr7 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    DBDecimalType* d_MAT_5fe3c67e4900aggr0__tmp_attr7;
    cudaMalloc(&d_MAT_5fe3c67e4900aggr0__tmp_attr7, sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    auto MAT_5fe3c67e4900aggr0__tmp_attr8 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    DBDecimalType* d_MAT_5fe3c67e4900aggr0__tmp_attr8;
    cudaMalloc(&d_MAT_5fe3c67e4900aggr0__tmp_attr8, sizeof(DBDecimalType) * MAT_5fe3c6804700_size);
    auto MAT_5fe3c67e4900aggr0__tmp_attr9 = (DBI64Type*)malloc(sizeof(DBI64Type) * MAT_5fe3c6804700_size);
    DBI64Type* d_MAT_5fe3c67e4900aggr0__tmp_attr9;
    cudaMalloc(&d_MAT_5fe3c67e4900aggr0__tmp_attr9, sizeof(DBI64Type) * MAT_5fe3c6804700_size);
    main_pipeline_5fe3c6857360<<<std::ceil((float)MAT_5fe3c6804700_size/(float)32), 32>>>(d_MAT_5fe3c67e4900aggr0__tmp_attr0, d_MAT_5fe3c67e4900aggr0__tmp_attr1, d_MAT_5fe3c67e4900aggr0__tmp_attr2, d_MAT_5fe3c67e4900aggr0__tmp_attr4, d_MAT_5fe3c67e4900aggr0__tmp_attr6, d_MAT_5fe3c67e4900aggr0__tmp_attr7, d_MAT_5fe3c67e4900aggr0__tmp_attr8, d_MAT_5fe3c67e4900aggr0__tmp_attr9, d_MAT_5fe3c67e4900lineitem__l_linestatus, d_MAT_5fe3c67e4900lineitem__l_returnflag, d_aggr0__tmp_attr0, d_aggr0__tmp_attr1, d_aggr0__tmp_attr2, d_aggr0__tmp_attr4, d_aggr0__tmp_attr9, d_aggr_rw__rw0, d_aggr_rw__rw1, d_aggr_rw__rw2, d_aggr_rw__rw3, d_aggr_rw__rw4, d_aggr_rw__rw5, d_KEY_5fe3c6804700lineitem__l_linestatus, d_KEY_5fe3c6804700lineitem__l_returnflag, MAT_5fe3c6804700_size);
    cudaMemcpy(MAT_5fe3c67e4900lineitem__l_returnflag, d_MAT_5fe3c67e4900lineitem__l_returnflag, sizeof(DBCharType) * MAT_5fe3c6804700_size, cudaMemcpyDeviceToHost);
    cudaMemcpy(MAT_5fe3c67e4900lineitem__l_linestatus, d_MAT_5fe3c67e4900lineitem__l_linestatus, sizeof(DBCharType) * MAT_5fe3c6804700_size, cudaMemcpyDeviceToHost);
    cudaMemcpy(MAT_5fe3c67e4900aggr0__tmp_attr0, d_MAT_5fe3c67e4900aggr0__tmp_attr0, sizeof(DBDecimalType) * MAT_5fe3c6804700_size, cudaMemcpyDeviceToHost);
    cudaMemcpy(MAT_5fe3c67e4900aggr0__tmp_attr1, d_MAT_5fe3c67e4900aggr0__tmp_attr1, sizeof(DBDecimalType) * MAT_5fe3c6804700_size, cudaMemcpyDeviceToHost);
    cudaMemcpy(MAT_5fe3c67e4900aggr0__tmp_attr2, d_MAT_5fe3c67e4900aggr0__tmp_attr2, sizeof(DBDecimalType) * MAT_5fe3c6804700_size, cudaMemcpyDeviceToHost);
    cudaMemcpy(MAT_5fe3c67e4900aggr0__tmp_attr4, d_MAT_5fe3c67e4900aggr0__tmp_attr4, sizeof(DBDecimalType) * MAT_5fe3c6804700_size, cudaMemcpyDeviceToHost);
    cudaMemcpy(MAT_5fe3c67e4900aggr0__tmp_attr6, d_MAT_5fe3c67e4900aggr0__tmp_attr6, sizeof(DBDecimalType) * MAT_5fe3c6804700_size, cudaMemcpyDeviceToHost);
    cudaMemcpy(MAT_5fe3c67e4900aggr0__tmp_attr7, d_MAT_5fe3c67e4900aggr0__tmp_attr7, sizeof(DBDecimalType) * MAT_5fe3c6804700_size, cudaMemcpyDeviceToHost);
    cudaMemcpy(MAT_5fe3c67e4900aggr0__tmp_attr8, d_MAT_5fe3c67e4900aggr0__tmp_attr8, sizeof(DBDecimalType) * MAT_5fe3c6804700_size, cudaMemcpyDeviceToHost);
    cudaMemcpy(MAT_5fe3c67e4900aggr0__tmp_attr9, d_MAT_5fe3c67e4900aggr0__tmp_attr9, sizeof(DBI64Type) * MAT_5fe3c6804700_size, cudaMemcpyDeviceToHost);
    
    std::cout << std::setprecision(24);
    for (auto i=0ull; i< MAT_5fe3c6804700_size; i++) {
    std::cout << MAT_5fe3c67e4900lineitem__l_returnflag[i] << "\t";
    std::cout << MAT_5fe3c67e4900lineitem__l_linestatus[i] << "\t";
    std::cout << MAT_5fe3c67e4900aggr0__tmp_attr0[i] << "\t";
    std::cout << MAT_5fe3c67e4900aggr0__tmp_attr1[i] << "\t";
    std::cout << MAT_5fe3c67e4900aggr0__tmp_attr2[i] << "\t";
    std::cout << MAT_5fe3c67e4900aggr0__tmp_attr4[i] << "\t";
    std::cout << MAT_5fe3c67e4900aggr0__tmp_attr6[i] << "\t";
    std::cout << MAT_5fe3c67e4900aggr0__tmp_attr7[i] << "\t";
    std::cout << MAT_5fe3c67e4900aggr0__tmp_attr8[i] << "\t";
    std::cout << MAT_5fe3c67e4900aggr0__tmp_attr9[i] << "\t";
    std::cout << std::endl;}
    
}
