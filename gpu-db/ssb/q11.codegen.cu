#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5eadd96e7170(uint64_t* COUNT5eadd96fc3c0, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1993, Predicate::eq))) return;
//Materialize count
atomicAdd((int*)COUNT5eadd96fc3c0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5eadd96e7170(uint64_t* BUF_5eadd96fc3c0, uint64_t* BUF_IDX_5eadd96fc3c0, HASHTABLE_INSERT HT_5eadd96fc3c0, DBI32Type* date__d_datekey, DBI32Type* date__d_year, size_t date_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= date_size) return;
auto reg_date__d_year = date__d_year[tid];
if (!(evaluatePredicate(reg_date__d_year, 1993, Predicate::eq))) return;
uint64_t KEY_5eadd96fc3c0 = 0;
auto reg_date__d_datekey = date__d_datekey[tid];

KEY_5eadd96fc3c0 |= reg_date__d_datekey;
// Insert hash table kernel;
auto buf_idx_5eadd96fc3c0 = atomicAdd((int*)BUF_IDX_5eadd96fc3c0, 1);
HT_5eadd96fc3c0.insert(cuco::pair{KEY_5eadd96fc3c0, buf_idx_5eadd96fc3c0});
BUF_5eadd96fc3c0[buf_idx_5eadd96fc3c0 * 1 + 0] = tid;
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5eadd96e6e90(uint64_t* BUF_5eadd96fc3c0, HASHTABLE_INSERT HT_5eadd96b74d0, HASHTABLE_PROBE HT_5eadd96fc3c0, DBI32Type* lineorder__lo_discount, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_quantity, size_t lineorder_size) {

uint64_t KEY_5eadd96b74d0 = 0;
//Create aggregation hash table
HT_5eadd96b74d0.insert(cuco::pair{KEY_5eadd96b74d0, 1});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5eadd96e6e90(uint64_t* BUF_5eadd96fc3c0, HASHTABLE_FIND HT_5eadd96b74d0, HASHTABLE_PROBE HT_5eadd96fc3c0, DBDecimalType* aggr0__tmp_attr0, DBI32Type* lineorder__lo_discount, DBDecimalType* lineorder__lo_extendedprice, DBI32Type* lineorder__lo_orderdate, DBI32Type* lineorder__lo_quantity, size_t lineorder_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineorder_size) return;
auto reg_lineorder__lo_discount = lineorder__lo_discount[tid];
__shared__ DBDecimalType agg;
__syncthreads();
agg = 0.0;
__syncthreads();
if ((evaluatePredicate(reg_lineorder__lo_discount, 1, Predicate::gte) && evaluatePredicate(reg_lineorder__lo_discount, 3, Predicate::lte))) {
    auto reg_lineorder__lo_quantity = lineorder__lo_quantity[tid];
    if ((evaluatePredicate(reg_lineorder__lo_quantity, 25, Predicate::lt))) {
        uint64_t KEY_5eadd96fc3c0 = 0;
        auto reg_lineorder__lo_orderdate = lineorder__lo_orderdate[tid];
        
        KEY_5eadd96fc3c0 |= reg_lineorder__lo_orderdate;
        //Probe Hash table
        HT_5eadd96fc3c0.for_each(KEY_5eadd96fc3c0, [&] __device__ (auto const SLOT_5eadd96fc3c0) {
        auto const [slot_first5eadd96fc3c0, slot_second5eadd96fc3c0] = SLOT_5eadd96fc3c0;
        if (!(true)) return;
        uint64_t KEY_5eadd96b74d0 = 0;
        //Aggregate in hashtable
        auto buf_idx_5eadd96b74d0 = HT_5eadd96b74d0.find(KEY_5eadd96b74d0)->second;
        auto reg_lineorder__lo_extendedprice = lineorder__lo_extendedprice[tid];
        auto reg_map0__tmp_attr1 = (reg_lineorder__lo_extendedprice) * ((DBDecimalType)(reg_lineorder__lo_discount));
        aggregate_sum(&agg, reg_map0__tmp_attr1);
        });
    }
}
__syncthreads();
if (threadIdx.x == 0) {
    aggregate_sum(&aggr0__tmp_attr0[0], agg);
}
}
__global__ void count_5eadd970db50(uint64_t* COUNT5eadd9696480, size_t COUNT5eadd96b74d0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5eadd96b74d0) return;
//Materialize count
atomicAdd((int*)COUNT5eadd9696480, 1);
}
__global__ void main_5eadd970db50(size_t COUNT5eadd96b74d0, DBDecimalType* MAT5eadd9696480aggr0__tmp_attr0, uint64_t* MAT_IDX5eadd9696480, DBDecimalType* aggr0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5eadd96b74d0) return;
//Materialize buffers
auto mat_idx5eadd9696480 = atomicAdd((int*)MAT_IDX5eadd9696480, 1);
auto reg_aggr0__tmp_attr0 = aggr0__tmp_attr0[tid];
MAT5eadd9696480aggr0__tmp_attr0[mat_idx5eadd9696480] = reg_aggr0__tmp_attr0;
}
extern "C" void control (DBI32Type* d_supplier__s_suppkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_city, DBStringType* d_supplier__s_nation, DBStringType* d_supplier__s_region, DBStringType* d_supplier__s_phone, size_t supplier_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_category, DBStringType* d_part__p_brand1, DBStringType* d_part__p_color, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, size_t part_size, DBI32Type* d_lineorder__lo_orderkey, DBI32Type* d_lineorder__lo_linenumber, DBI32Type* d_lineorder__lo_custkey, DBI32Type* d_lineorder__lo_partkey, DBI32Type* d_lineorder__lo_suppkey, DBDateType* d_lineorder__lo_orderdate, DBDateType* d_lineorder__lo_commitdate, DBStringType* d_lineorder__lo_orderpriority, DBCharType* d_lineorder__lo_shippriority, DBI32Type* d_lineorder__lo_quantity, DBDecimalType* d_lineorder__lo_extendedprice, DBDecimalType* d_lineorder__lo_ordtotalprice, DBDecimalType* d_lineorder__lo_revenue, DBDecimalType* d_lineorder__lo_supplycost, DBI32Type* d_lineorder__lo_discount, DBI32Type* d_lineorder__lo_tax, DBStringType* d_lineorder__lo_shipmode, size_t lineorder_size, DBI32Type* d_date__d_datekey, DBStringType* d_date__d_date, DBStringType* d_date__d_dayofweek, DBStringType* d_date__d_month, DBI32Type* d_date__d_year, DBI32Type* d_date__d_yearmonthnum, DBStringType* d_date__d_yearmonth, DBI32Type* d_date__d_daynuminweek, DBI32Type* d_date__d_daynuminmonth, DBI32Type* d_date__d_daynuminyear, DBI32Type* d_date__d_monthnuminyear, DBI32Type* d_date__d_weeknuminyear, DBStringType* d_date__d_sellingseason, DBI32Type* d_date__d_lastdayinweekfl, DBI32Type* d_date__d_lastdayinmonthfl, DBI32Type* d_date__d_holidayfl, DBI32Type* d_date__d_weekdayfl, size_t date_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBStringType* d_customer__c_city, DBStringType* d_customer__c_nation, DBStringType* d_customer__c_region, DBStringType* d_customer__c_phone, DBStringType* d_customer__c_mktsegment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT5eadd96fc3c0;
cudaMalloc(&d_COUNT5eadd96fc3c0, sizeof(uint64_t));
cudaMemset(d_COUNT5eadd96fc3c0, 0, sizeof(uint64_t));
count_5eadd96e7170<<<std::ceil((float)date_size/32.), 32>>>(d_COUNT5eadd96fc3c0, d_date__d_year, date_size);
uint64_t COUNT5eadd96fc3c0;
cudaMemcpy(&COUNT5eadd96fc3c0, d_COUNT5eadd96fc3c0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5eadd96fc3c0;
cudaMalloc(&d_BUF_IDX_5eadd96fc3c0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5eadd96fc3c0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5eadd96fc3c0;
cudaMalloc(&d_BUF_5eadd96fc3c0, sizeof(uint64_t) * COUNT5eadd96fc3c0 * 1);
auto d_HT_5eadd96fc3c0 = cuco::experimental::static_multimap{ (int)COUNT5eadd96fc3c0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5eadd96e7170<<<std::ceil((float)date_size/32.), 32>>>(d_BUF_5eadd96fc3c0, d_BUF_IDX_5eadd96fc3c0, d_HT_5eadd96fc3c0.ref(cuco::insert), d_date__d_datekey, d_date__d_year, date_size);
//Create aggregation hash table
auto d_HT_5eadd96b74d0 = cuco::static_map{ (int)1*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5eadd96e6e90<<<1, 1>>>(d_BUF_5eadd96fc3c0, d_HT_5eadd96b74d0.ref(cuco::insert), d_HT_5eadd96fc3c0.ref(cuco::for_each), d_lineorder__lo_discount, d_lineorder__lo_orderdate, d_lineorder__lo_quantity, lineorder_size);
size_t COUNT5eadd96b74d0 = d_HT_5eadd96b74d0.size();
thrust::device_vector<int64_t> keys_5eadd96b74d0(COUNT5eadd96b74d0), vals_5eadd96b74d0(COUNT5eadd96b74d0);
d_HT_5eadd96b74d0.retrieve_all(keys_5eadd96b74d0.begin(), vals_5eadd96b74d0.begin());
d_HT_5eadd96b74d0.clear();
int64_t* raw_keys5eadd96b74d0 = thrust::raw_pointer_cast(keys_5eadd96b74d0.data());
insertKeys<<<std::ceil((float)COUNT5eadd96b74d0/32.), 32>>>(raw_keys5eadd96b74d0, d_HT_5eadd96b74d0.ref(cuco::insert), COUNT5eadd96b74d0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5eadd96b74d0);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBDecimalType) * COUNT5eadd96b74d0);
main_5eadd96e6e90<<<std::ceil((float)lineorder_size/128.), 128>>>(d_BUF_5eadd96fc3c0, d_HT_5eadd96b74d0.ref(cuco::find), d_HT_5eadd96fc3c0.ref(cuco::for_each), d_aggr0__tmp_attr0, d_lineorder__lo_discount, d_lineorder__lo_extendedprice, d_lineorder__lo_orderdate, d_lineorder__lo_quantity, lineorder_size);
//Materialize count
uint64_t* d_COUNT5eadd9696480;
cudaMalloc(&d_COUNT5eadd9696480, sizeof(uint64_t));
cudaMemset(d_COUNT5eadd9696480, 0, sizeof(uint64_t));
count_5eadd970db50<<<std::ceil((float)COUNT5eadd96b74d0/32.), 32>>>(d_COUNT5eadd9696480, COUNT5eadd96b74d0);
uint64_t COUNT5eadd9696480;
cudaMemcpy(&COUNT5eadd9696480, d_COUNT5eadd9696480, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5eadd9696480;
cudaMalloc(&d_MAT_IDX5eadd9696480, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5eadd9696480, 0, sizeof(uint64_t));
auto MAT5eadd9696480aggr0__tmp_attr0 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5eadd9696480);
DBDecimalType* d_MAT5eadd9696480aggr0__tmp_attr0;
cudaMalloc(&d_MAT5eadd9696480aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5eadd9696480);
main_5eadd970db50<<<std::ceil((float)COUNT5eadd96b74d0/32.), 32>>>(COUNT5eadd96b74d0, d_MAT5eadd9696480aggr0__tmp_attr0, d_MAT_IDX5eadd9696480, d_aggr0__tmp_attr0);
cudaMemcpy(MAT5eadd9696480aggr0__tmp_attr0, d_MAT5eadd9696480aggr0__tmp_attr0, sizeof(DBDecimalType) * COUNT5eadd9696480, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5eadd9696480; i++) { std::cout << MAT5eadd9696480aggr0__tmp_attr0[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_5eadd96fc3c0);
cudaFree(d_BUF_IDX_5eadd96fc3c0);
cudaFree(d_COUNT5eadd96fc3c0);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_COUNT5eadd9696480);
cudaFree(d_MAT5eadd9696480aggr0__tmp_attr0);
cudaFree(d_MAT_IDX5eadd9696480);
free(MAT5eadd9696480aggr0__tmp_attr0);
}