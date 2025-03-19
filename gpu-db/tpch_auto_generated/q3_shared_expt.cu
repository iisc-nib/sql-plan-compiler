
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
#include <cuco/static_map.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
__global__ void count_pipeline_55c975d43320(DBStringType *customer__c_mktsegment,
int * BUF_IDX_55c975d38d60,
size_t customer_size
) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg__customer__c_mktsegment = customer__c_mktsegment[tid];
if (!(evaluatePredicate(reg__customer__c_mktsegment, "BUILDING", Predicate::eq))) return;
atomicAdd(BUF_IDX_55c975d38d60, 1);
return;
}
template<typename HASHTABLE_INSERT>
__global__ void main_pipeline_55c975d43320(DBI32Type *customer__c_custkey,
DBStringType *customer__c_mktsegment,
uint64_t * BUF_55c975d38d60,
int * BUF_IDX_55c975d38d60,
HASHTABLE_INSERT HT_55c975d38d60,
size_t customer_size
) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
auto reg__customer__c_mktsegment = customer__c_mktsegment[tid];
if (!(evaluatePredicate(reg__customer__c_mktsegment, "BUILDING", Predicate::eq))) return;
auto reg__customer__c_custkey = customer__c_custkey[tid];
int64_t KEY_55c975d38d60 = 0;
KEY_55c975d38d60 <<= 32;
KEY_55c975d38d60  |= reg__customer__c_custkey;

auto buf_idx_55c975d38d60 = atomicAdd(BUF_IDX_55c975d38d60, 1);
HT_55c975d38d60.insert(cuco::pair{KEY_55c975d38d60, buf_idx_55c975d38d60});
BUF_55c975d38d60[buf_idx_55c975d38d60 * 1 + 0] = tid;
return;
}
template<typename HASHTABLE_FIND>
__global__ void count_pipeline_55c975d43e60(DBI32Type *orders__o_custkey,
DBDateType *orders__o_orderdate,
uint64_t* BUF_55c975d38d60,
int * BUF_IDX_55c975d38ec0,
HASHTABLE_FIND HT_55c975d38d60,
size_t orders_size
) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg__orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg__orders__o_orderdate, 9204, Predicate::lt))) return;
auto reg__orders__o_custkey = orders__o_custkey[tid];
int64_t KEY_55c975d38d60 = 0;
KEY_55c975d38d60 <<= 32;
KEY_55c975d38d60  |= reg__orders__o_custkey;

auto SLOT_55c975d38d60 = HT_55c975d38d60.find(KEY_55c975d38d60);
if (SLOT_55c975d38d60 == HT_55c975d38d60.end()) return;
auto buf_idx_55c975d38d60 = SLOT_55c975d38d60->second;
atomicAdd(BUF_IDX_55c975d38ec0, 1);
return;
}
template<typename HASHTABLE_FIND, typename HASHTABLE_INSERT>
__global__ void main_pipeline_55c975d43e60(DBI32Type *orders__o_custkey,
DBDateType *orders__o_orderdate,
DBI32Type *orders__o_orderkey,
uint64_t* BUF_55c975d38d60,
uint64_t * BUF_55c975d38ec0,
int * BUF_IDX_55c975d38ec0,
HASHTABLE_FIND HT_55c975d38d60,
HASHTABLE_INSERT HT_55c975d38ec0,
size_t orders_size
) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
auto reg__orders__o_orderdate = orders__o_orderdate[tid];
if (!(evaluatePredicate(reg__orders__o_orderdate, 9204, Predicate::lt))) return;
auto reg__orders__o_custkey = orders__o_custkey[tid];
int64_t KEY_55c975d38d60 = 0;
KEY_55c975d38d60 <<= 32;
KEY_55c975d38d60  |= reg__orders__o_custkey;

auto SLOT_55c975d38d60 = HT_55c975d38d60.find(KEY_55c975d38d60);
if (SLOT_55c975d38d60 == HT_55c975d38d60.end()) return;
auto buf_idx_55c975d38d60 = SLOT_55c975d38d60->second;
auto reg__orders__o_orderkey = orders__o_orderkey[tid];
int64_t KEY_55c975d38ec0 = 0;
KEY_55c975d38ec0 <<= 32;
KEY_55c975d38ec0  |= reg__orders__o_orderkey;

auto buf_idx_55c975d38ec0 = atomicAdd(BUF_IDX_55c975d38ec0, 1);
HT_55c975d38ec0.insert(cuco::pair{KEY_55c975d38ec0, buf_idx_55c975d38ec0});
BUF_55c975d38ec0[buf_idx_55c975d38ec0 * 2 + 0] = BUF_55c975d38d60[buf_idx_55c975d38d60*1 + 0];
BUF_55c975d38ec0[buf_idx_55c975d38ec0 * 2 + 1] = tid;
return;
}
template<typename HASHTABLE_FIND, typename HASHTABLE_INSERT>
__global__ void count_pipeline_55c975d45c00(DBDecimalType *lineitem__l_discount,
DBDecimalType *lineitem__l_extendedprice,
DBI32Type *lineitem__l_orderkey,
DBDateType *lineitem__l_shipdate,
uint64_t* BUF_55c975d38ec0,
HASHTABLE_INSERT HT_55c975cf4cf0,
HASHTABLE_FIND HT_55c975d38ec0,
size_t lineitem_size
) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg__lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg__lineitem__l_shipdate, 9204, Predicate::gt))) return;
auto reg__lineitem__l_orderkey = lineitem__l_orderkey[tid];
int64_t KEY_55c975d38ec0 = 0;
KEY_55c975d38ec0 <<= 32;
KEY_55c975d38ec0  |= reg__lineitem__l_orderkey;

auto SLOT_55c975d38ec0 = HT_55c975d38ec0.find(KEY_55c975d38ec0);
if (SLOT_55c975d38ec0 == HT_55c975d38ec0.end()) return;
auto buf_idx_55c975d38ec0 = SLOT_55c975d38ec0->second;
auto reg__lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg__lineitem__l_discount = lineitem__l_discount[tid];
int64_t KEY_55c975cf4cf0 = 0;
KEY_55c975cf4cf0 <<= 32;
KEY_55c975cf4cf0  |= reg__lineitem__l_orderkey;

HT_55c975cf4cf0.insert(cuco::pair{KEY_55c975cf4cf0, 1});
return;
}
template<typename HASHTABLE_FIND>
__global__ void main_pipeline_55c975d45c00(DBI32Type *KEY_55c975cf4cf0lineitem__l_orderkey,
DBDecimalType *aggr0__tmp_attr0,
DBDateType *aggr__o_orderdate,
DBI32Type *aggr__o_shippriority,
DBDecimalType *lineitem__l_discount,
DBDecimalType *lineitem__l_extendedprice,
DBI32Type *lineitem__l_orderkey,
DBDateType *lineitem__l_shipdate,
DBDateType *orders__o_orderdate,
DBI32Type *orders__o_shippriority,
uint64_t* BUF_55c975d38ec0,
HASHTABLE_FIND HT_55c975cf4cf0,
HASHTABLE_FIND HT_55c975d38ec0,
size_t lineitem_size
) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg__lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg__lineitem__l_shipdate, 9204, Predicate::gt))) return;
auto reg__lineitem__l_orderkey = lineitem__l_orderkey[tid];
int64_t KEY_55c975d38ec0 = 0;
KEY_55c975d38ec0 <<= 32;
KEY_55c975d38ec0  |= reg__lineitem__l_orderkey;

auto SLOT_55c975d38ec0 = HT_55c975d38ec0.find(KEY_55c975d38ec0);
if (SLOT_55c975d38ec0 == HT_55c975d38ec0.end()) return;
auto buf_idx_55c975d38ec0 = SLOT_55c975d38ec0->second;
auto reg__lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg__lineitem__l_discount = lineitem__l_discount[tid];
int64_t KEY_55c975cf4cf0 = 0;
KEY_55c975cf4cf0 <<= 32;
KEY_55c975cf4cf0  |= reg__lineitem__l_orderkey;

auto buf_idx_55c975cf4cf0 = HT_55c975cf4cf0.find(KEY_55c975cf4cf0)->second;
KEY_55c975cf4cf0lineitem__l_orderkey[buf_idx_55c975cf4cf0] = reg__lineitem__l_orderkey;
auto reg__map0__tmp_attr1 = (reg__lineitem__l_extendedprice) * ((1) - (reg__lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr0[buf_idx_55c975cf4cf0], reg__map0__tmp_attr1);
auto reg__orders__o_shippriority = orders__o_shippriority[BUF_55c975d38ec0[buf_idx_55c975d38ec0*2 + 1]];
aggregate_any(&aggr__o_shippriority[buf_idx_55c975cf4cf0], reg__orders__o_shippriority);
auto reg__orders__o_orderdate = orders__o_orderdate[BUF_55c975d38ec0[buf_idx_55c975d38ec0*2 + 1]];
aggregate_any(&aggr__o_orderdate[buf_idx_55c975cf4cf0], reg__orders__o_orderdate);
return;
}
__global__ void count_pipeline_55c975d4fa00(size_t MAT_55c975cf4cf0_size
) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= MAT_55c975cf4cf0_size) return;
}
__global__ void main_pipeline_55c975d4fa00(DBDecimalType *MAT_55c975cd41b0aggr0__tmp_attr0,
DBDateType *MAT_55c975cd41b0aggr__o_orderdate,
DBI32Type *MAT_55c975cd41b0aggr__o_shippriority,
DBI32Type *MAT_55c975cd41b0lineitem__l_orderkey,
DBDecimalType *aggr0__tmp_attr0,
DBDateType *aggr__o_orderdate,
DBI32Type *aggr__o_shippriority,
DBI32Type *lineitem__l_orderkey,
size_t MAT_55c975cf4cf0_size
) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= MAT_55c975cf4cf0_size) return;
auto reg__lineitem__l_orderkey = lineitem__l_orderkey[tid];
MAT_55c975cd41b0lineitem__l_orderkey[tid] = reg__lineitem__l_orderkey;
auto reg__aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT_55c975cd41b0aggr0__tmp_attr0[tid] = reg__aggr0__tmp_attr0;
auto reg__aggr__o_orderdate = aggr__o_orderdate[tid];
MAT_55c975cd41b0aggr__o_orderdate[tid] = reg__aggr__o_orderdate;
auto reg__aggr__o_shippriority = aggr__o_shippriority[tid];
MAT_55c975cd41b0aggr__o_shippriority[tid] = reg__aggr__o_shippriority;
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
int *d_BUF_IDX_55c975d38d60;
cudaMalloc(&d_BUF_IDX_55c975d38d60, sizeof(int));
cudaMemset(d_BUF_IDX_55c975d38d60,0 , sizeof(int));
count_pipeline_55c975d43320<<<std::ceil((float)customer_size/(float)32), 32>>>(d_customer__c_mktsegment, d_BUF_IDX_55c975d38d60, customer_size);

int BUF_IDX_55c975d38d60;
cudaMemcpy(&BUF_IDX_55c975d38d60, d_BUF_IDX_55c975d38d60, sizeof(int), cudaMemcpyDeviceToHost);
std::cout << "first build, size: " << BUF_IDX_55c975d38d60 << std::endl;
cudaMemset(d_BUF_IDX_55c975d38d60,0 , sizeof(int));
auto HT_55c975d38d60 = cuco::static_map{ BUF_IDX_55c975d38d60* 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};
uint64_t *d_BUF_55c975d38d60;
cudaMalloc(&d_BUF_55c975d38d60, sizeof(uint64_t) * 1 * BUF_IDX_55c975d38d60);
cudaMemset(d_BUF_55c975d38d60,0 , sizeof(uint64_t) * 1 * BUF_IDX_55c975d38d60);
main_pipeline_55c975d43320<<<std::ceil((float)customer_size/(float)32), 32>>>(d_customer__c_custkey, d_customer__c_mktsegment, d_BUF_55c975d38d60, d_BUF_IDX_55c975d38d60, HT_55c975d38d60.ref(cuco::insert), customer_size);
std::cout << "customer hash table size: " << HT_55c975d38d60.size() << std::endl;
int *d_BUF_IDX_55c975d38ec0;
cudaMalloc(&d_BUF_IDX_55c975d38ec0, sizeof(int));
cudaMemset(d_BUF_IDX_55c975d38ec0,0 , sizeof(int));
count_pipeline_55c975d43e60<<<std::ceil((float)orders_size/(float)32), 32>>>(d_orders__o_custkey, d_orders__o_orderdate, d_BUF_55c975d38d60, d_BUF_IDX_55c975d38ec0, HT_55c975d38d60.ref(cuco::find), orders_size);

int BUF_IDX_55c975d38ec0;
cudaMemcpy(&BUF_IDX_55c975d38ec0, d_BUF_IDX_55c975d38ec0, sizeof(int), cudaMemcpyDeviceToHost);
std::cout << "second build, size: " << BUF_IDX_55c975d38ec0 << std::endl;
cudaMemset(d_BUF_IDX_55c975d38ec0,0 , sizeof(int));
auto HT_55c975d38ec0 = cuco::static_map{ BUF_IDX_55c975d38ec0* 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};
uint64_t *d_BUF_55c975d38ec0;
cudaMalloc(&d_BUF_55c975d38ec0, sizeof(uint64_t) * 2 * BUF_IDX_55c975d38ec0);
cudaMemset(d_BUF_55c975d38ec0,0 , sizeof(uint64_t) * 2 * BUF_IDX_55c975d38ec0);
main_pipeline_55c975d43e60<<<std::ceil((float)orders_size/(float)32), 32>>>(d_orders__o_custkey, d_orders__o_orderdate, d_orders__o_orderkey, d_BUF_55c975d38d60, d_BUF_55c975d38ec0, d_BUF_IDX_55c975d38ec0, HT_55c975d38d60.ref(cuco::find), HT_55c975d38ec0.ref(cuco::insert), orders_size);



auto HT_55c975cf4cf0 = cuco::static_map{ 35555* 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};
count_pipeline_55c975d45c00<<<std::ceil((float)lineitem_size/(float)32), 32>>>(d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_BUF_55c975d38ec0, HT_55c975cf4cf0.ref(cuco::insert), HT_55c975d38ec0.ref(cuco::find), lineitem_size);
std::cout << "Aggregation size: " << HT_55c975cf4cf0.size() << std::endl;


thrust::device_vector<int64_t> keys_55c975cf4cf0(HT_55c975cf4cf0.size()), vals_55c975cf4cf0(HT_55c975cf4cf0.size());
HT_55c975cf4cf0.retrieve_all(keys_55c975cf4cf0.begin(), vals_55c975cf4cf0.begin());
thrust::host_vector<int64_t> h_keys_55c975cf4cf0(HT_55c975cf4cf0.size());
thrust::copy(keys_55c975cf4cf0.begin(), keys_55c975cf4cf0.end(), h_keys_55c975cf4cf0.begin());
thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_55c975cf4cf0(HT_55c975cf4cf0.size());
for (int i=0; i < HT_55c975cf4cf0.size(); i++) {{
actual_dict_55c975cf4cf0[i] = cuco::make_pair(h_keys_55c975cf4cf0[i], i);
}}
HT_55c975cf4cf0.clear();
HT_55c975cf4cf0.insert(actual_dict_55c975cf4cf0.begin(), actual_dict_55c975cf4cf0.end());
DBDecimalType*  d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * HT_55c975cf4cf0.size());
cudaMemset(d_aggr0__tmp_attr0,0 , sizeof(DBDecimalType) * HT_55c975cf4cf0.size());
DBI32Type*  d_aggr__o_shippriority;
cudaMalloc(&d_aggr__o_shippriority, sizeof(DBI32Type) * HT_55c975cf4cf0.size());
cudaMemset(d_aggr__o_shippriority,0 , sizeof(DBI32Type) * HT_55c975cf4cf0.size());
DBDateType*  d_aggr__o_orderdate;
cudaMalloc(&d_aggr__o_orderdate, sizeof(DBDateType) * HT_55c975cf4cf0.size());
cudaMemset(d_aggr__o_orderdate,0 , sizeof(DBDateType) * HT_55c975cf4cf0.size());
auto MAT_55c975cf4cf0_size = HT_55c975cf4cf0.size();
DBI32Type*  d_KEY_55c975cf4cf0lineitem__l_orderkey;
cudaMalloc(&d_KEY_55c975cf4cf0lineitem__l_orderkey, sizeof(DBI32Type) * HT_55c975cf4cf0.size());
cudaMemset(d_KEY_55c975cf4cf0lineitem__l_orderkey,0 , sizeof(DBI32Type) * HT_55c975cf4cf0.size());
main_pipeline_55c975d45c00<<<std::ceil((float)lineitem_size/(float)32), 32>>>(d_KEY_55c975cf4cf0lineitem__l_orderkey, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_orders__o_orderdate, d_orders__o_shippriority, d_BUF_55c975d38ec0, HT_55c975cf4cf0.ref(cuco::find), HT_55c975d38ec0.ref(cuco::find), lineitem_size);


auto MAT_55c975cd41b0lineitem__l_orderkey = (DBI32Type*)malloc(sizeof(DBI32Type) * MAT_55c975cf4cf0_size);
DBI32Type* d_MAT_55c975cd41b0lineitem__l_orderkey;
cudaMalloc(&d_MAT_55c975cd41b0lineitem__l_orderkey, sizeof(DBI32Type) * MAT_55c975cf4cf0_size);
auto MAT_55c975cd41b0aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * MAT_55c975cf4cf0_size);
DBDecimalType* d_MAT_55c975cd41b0aggr0__tmp_attr0;
cudaMalloc(&d_MAT_55c975cd41b0aggr0__tmp_attr0, sizeof(DBDecimalType) * MAT_55c975cf4cf0_size);
auto MAT_55c975cd41b0aggr__o_orderdate = (DBDateType*)malloc(sizeof(DBDateType) * MAT_55c975cf4cf0_size);
DBDateType* d_MAT_55c975cd41b0aggr__o_orderdate;
cudaMalloc(&d_MAT_55c975cd41b0aggr__o_orderdate, sizeof(DBDateType) * MAT_55c975cf4cf0_size);
auto MAT_55c975cd41b0aggr__o_shippriority = (DBI32Type*)malloc(sizeof(DBI32Type) * MAT_55c975cf4cf0_size);
DBI32Type* d_MAT_55c975cd41b0aggr__o_shippriority;
cudaMalloc(&d_MAT_55c975cd41b0aggr__o_shippriority, sizeof(DBI32Type) * MAT_55c975cf4cf0_size);
main_pipeline_55c975d4fa00<<<std::ceil((float)MAT_55c975cf4cf0_size/(float)32), 32>>>(d_MAT_55c975cd41b0aggr0__tmp_attr0, d_MAT_55c975cd41b0aggr__o_orderdate, d_MAT_55c975cd41b0aggr__o_shippriority, d_MAT_55c975cd41b0lineitem__l_orderkey, d_aggr0__tmp_attr0, d_aggr__o_orderdate, d_aggr__o_shippriority, d_KEY_55c975cf4cf0lineitem__l_orderkey, MAT_55c975cf4cf0_size);
cudaMemcpy(MAT_55c975cd41b0lineitem__l_orderkey, d_MAT_55c975cd41b0lineitem__l_orderkey, sizeof(DBI32Type) * MAT_55c975cf4cf0_size, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT_55c975cd41b0aggr0__tmp_attr0, d_MAT_55c975cd41b0aggr0__tmp_attr0, sizeof(DBDecimalType) * MAT_55c975cf4cf0_size, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT_55c975cd41b0aggr__o_orderdate, d_MAT_55c975cd41b0aggr__o_orderdate, sizeof(DBDateType) * MAT_55c975cf4cf0_size, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT_55c975cd41b0aggr__o_shippriority, d_MAT_55c975cd41b0aggr__o_shippriority, sizeof(DBI32Type) * MAT_55c975cf4cf0_size, cudaMemcpyDeviceToHost);
for (auto i=0ull; i< MAT_55c975cf4cf0_size; i++) {
std::cout << MAT_55c975cd41b0lineitem__l_orderkey[i] << "\t";
std::cout << MAT_55c975cd41b0aggr0__tmp_attr0[i] << "\t";
std::cout << MAT_55c975cd41b0aggr__o_orderdate[i] << "\t";
std::cout << MAT_55c975cd41b0aggr__o_shippriority[i] << "\t";
std::cout << std::endl;}

}
