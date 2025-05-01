#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5f1f02980ad0(uint64_t* COUNT5f1f0296f570, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
//Materialize count
atomicAdd((int*)COUNT5f1f0296f570, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5f1f02980ad0(uint64_t* BUF_5f1f0296f570, uint64_t* BUF_IDX_5f1f0296f570, HASHTABLE_INSERT HT_5f1f0296f570, DBI32Type* nation__n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_5f1f0296f570 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_5f1f0296f570 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_5f1f0296f570 = atomicAdd((int*)BUF_IDX_5f1f0296f570, 1);
HT_5f1f0296f570.insert(cuco::pair{KEY_5f1f0296f570, buf_idx_5f1f0296f570});
BUF_5f1f0296f570[buf_idx_5f1f0296f570 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5f1f0295b9f0(uint64_t* BUF_5f1f0296f570, uint64_t* COUNT5f1f0296f690, HASHTABLE_PROBE HT_5f1f0296f570, DBI32Type* supplier__s_nationkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_5f1f0296f570 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_5f1f0296f570 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_5f1f0296f570.for_each(KEY_5f1f0296f570, [&] __device__ (auto const SLOT_5f1f0296f570) {

auto const [slot_first5f1f0296f570, slot_second5f1f0296f570] = SLOT_5f1f0296f570;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5f1f0296f690, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5f1f0295b9f0(uint64_t* BUF_5f1f0296f570, uint64_t* BUF_5f1f0296f690, uint64_t* BUF_IDX_5f1f0296f690, HASHTABLE_PROBE HT_5f1f0296f570, HASHTABLE_INSERT HT_5f1f0296f690, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_5f1f0296f570 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_5f1f0296f570 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_5f1f0296f570.for_each(KEY_5f1f0296f570, [&] __device__ (auto const SLOT_5f1f0296f570) {
auto const [slot_first5f1f0296f570, slot_second5f1f0296f570] = SLOT_5f1f0296f570;
if (!(true)) return;
uint64_t KEY_5f1f0296f690 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5f1f0296f690 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5f1f0296f690 = atomicAdd((int*)BUF_IDX_5f1f0296f690, 1);
HT_5f1f0296f690.insert(cuco::pair{KEY_5f1f0296f690, buf_idx_5f1f0296f690});
BUF_5f1f0296f690[buf_idx_5f1f0296f690 * 2 + 0] = tid;
BUF_5f1f0296f690[buf_idx_5f1f0296f690 * 2 + 1] = BUF_5f1f0296f570[slot_second5f1f0296f570 * 1 + 0];
});
}
__global__ void count_5f1f02987af0(uint64_t* COUNT5f1f02977190, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
//Materialize count
atomicAdd((int*)COUNT5f1f02977190, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5f1f02987af0(uint64_t* BUF_5f1f02977190, uint64_t* BUF_IDX_5f1f02977190, HASHTABLE_INSERT HT_5f1f02977190, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_5f1f02977190 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_5f1f02977190 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_5f1f02977190 = atomicAdd((int*)BUF_IDX_5f1f02977190, 1);
HT_5f1f02977190.insert(cuco::pair{KEY_5f1f02977190, buf_idx_5f1f02977190});
BUF_5f1f02977190[buf_idx_5f1f02977190 * 1 + 0] = tid;
}
__global__ void count_5f1f0295b3c0(uint64_t* COUNT5f1f02977250, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
//Materialize count
atomicAdd((int*)COUNT5f1f02977250, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5f1f0295b3c0(uint64_t* BUF_5f1f02977250, uint64_t* BUF_IDX_5f1f02977250, HASHTABLE_INSERT HT_5f1f02977250, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
uint64_t KEY_5f1f02977250 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_5f1f02977250 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_5f1f02977250 = atomicAdd((int*)BUF_IDX_5f1f02977250, 1);
HT_5f1f02977250.insert(cuco::pair{KEY_5f1f02977250, buf_idx_5f1f02977250});
BUF_5f1f02977250[buf_idx_5f1f02977250 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5f1f0297f920(uint64_t* BUF_5f1f0296f690, uint64_t* COUNT5f1f02977310, HASHTABLE_PROBE HT_5f1f0296f690, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= partsupp_size) return;
uint64_t KEY_5f1f0296f690 = 0;
auto reg_partsupp__ps_suppkey = partsupp__ps_suppkey[tid];

KEY_5f1f0296f690 |= reg_partsupp__ps_suppkey;
//Probe Hash table
HT_5f1f0296f690.for_each(KEY_5f1f0296f690, [&] __device__ (auto const SLOT_5f1f0296f690) {

auto const [slot_first5f1f0296f690, slot_second5f1f0296f690] = SLOT_5f1f0296f690;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5f1f02977310, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5f1f0297f920(uint64_t* BUF_5f1f0296f690, uint64_t* BUF_5f1f02977310, uint64_t* BUF_IDX_5f1f02977310, HASHTABLE_PROBE HT_5f1f0296f690, HASHTABLE_INSERT HT_5f1f02977310, DBI32Type* partsupp__ps_partkey, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size, DBI32Type* supplier__s_suppkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= partsupp_size) return;
uint64_t KEY_5f1f0296f690 = 0;
auto reg_partsupp__ps_suppkey = partsupp__ps_suppkey[tid];

KEY_5f1f0296f690 |= reg_partsupp__ps_suppkey;
//Probe Hash table
HT_5f1f0296f690.for_each(KEY_5f1f0296f690, [&] __device__ (auto const SLOT_5f1f0296f690) {
auto const [slot_first5f1f0296f690, slot_second5f1f0296f690] = SLOT_5f1f0296f690;
if (!(true)) return;
uint64_t KEY_5f1f02977310 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[BUF_5f1f0296f690[slot_second5f1f0296f690 * 2 + 0]];

KEY_5f1f02977310 |= reg_supplier__s_suppkey;
auto reg_partsupp__ps_partkey = partsupp__ps_partkey[tid];
KEY_5f1f02977310 <<= 32;
KEY_5f1f02977310 |= reg_partsupp__ps_partkey;
// Insert hash table kernel;
auto buf_idx_5f1f02977310 = atomicAdd((int*)BUF_IDX_5f1f02977310, 1);
HT_5f1f02977310.insert(cuco::pair{KEY_5f1f02977310, buf_idx_5f1f02977310});
BUF_5f1f02977310[buf_idx_5f1f02977310 * 3 + 0] = BUF_5f1f0296f690[slot_second5f1f0296f690 * 2 + 0];
BUF_5f1f02977310[buf_idx_5f1f02977310 * 3 + 1] = tid;
BUF_5f1f02977310[buf_idx_5f1f02977310 * 3 + 2] = BUF_5f1f0296f690[slot_second5f1f0296f690 * 2 + 1];
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5f1f0297ce00(uint64_t* BUF_5f1f02977190, uint64_t* BUF_5f1f02977250, uint64_t* BUF_5f1f02977310, HASHTABLE_INSERT HT_5f1f0292c180, HASHTABLE_PROBE HT_5f1f02977190, HASHTABLE_PROBE HT_5f1f02977250, HASHTABLE_PROBE HT_5f1f02977310, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_partkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBI16Type* nation__n_name_encoded, DBDateType* orders__o_orderdate) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_5f1f02977190 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5f1f02977190 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5f1f02977190.for_each(KEY_5f1f02977190, [&] __device__ (auto const SLOT_5f1f02977190) {

auto const [slot_first5f1f02977190, slot_second5f1f02977190] = SLOT_5f1f02977190;
if (!(true)) return;
uint64_t KEY_5f1f02977250 = 0;
auto reg_lineitem__l_partkey = lineitem__l_partkey[tid];

KEY_5f1f02977250 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_5f1f02977250.for_each(KEY_5f1f02977250, [&] __device__ (auto const SLOT_5f1f02977250) {

auto const [slot_first5f1f02977250, slot_second5f1f02977250] = SLOT_5f1f02977250;
if (!(true)) return;
uint64_t KEY_5f1f02977310 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_5f1f02977310 |= reg_lineitem__l_suppkey;
KEY_5f1f02977310 <<= 32;
KEY_5f1f02977310 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_5f1f02977310.for_each(KEY_5f1f02977310, [&] __device__ (auto const SLOT_5f1f02977310) {

auto const [slot_first5f1f02977310, slot_second5f1f02977310] = SLOT_5f1f02977310;
if (!(true)) return;
uint64_t KEY_5f1f0292c180 = 0;
auto reg_nation__n_name_encoded = nation__n_name_encoded[BUF_5f1f02977310[slot_second5f1f02977310 * 3 + 2]];

KEY_5f1f0292c180 |= reg_nation__n_name_encoded;
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_5f1f02977190[slot_second5f1f02977190 * 1 + 0]];
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_orders__o_orderdate);
KEY_5f1f0292c180 <<= 32;
KEY_5f1f0292c180 |= (DBI32Type)reg_map0__tmp_attr0;
//Create aggregation hash table
HT_5f1f0292c180.insert(cuco::pair{KEY_5f1f0292c180, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5f1f0297ce00(uint64_t* BUF_5f1f02977190, uint64_t* BUF_5f1f02977250, uint64_t* BUF_5f1f02977310, HASHTABLE_FIND HT_5f1f0292c180, HASHTABLE_PROBE HT_5f1f02977190, HASHTABLE_PROBE HT_5f1f02977250, HASHTABLE_PROBE HT_5f1f02977310, DBI64Type* KEY_5f1f0292c180map0__tmp_attr0, DBI16Type* KEY_5f1f0292c180nation__n_name_encoded, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_partkey, DBDecimalType* lineitem__l_quantity, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBI16Type* nation__n_name_encoded, DBDateType* orders__o_orderdate, DBDecimalType* partsupp__ps_supplycost) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_5f1f02977190 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5f1f02977190 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5f1f02977190.for_each(KEY_5f1f02977190, [&] __device__ (auto const SLOT_5f1f02977190) {
auto const [slot_first5f1f02977190, slot_second5f1f02977190] = SLOT_5f1f02977190;
if (!(true)) return;
uint64_t KEY_5f1f02977250 = 0;
auto reg_lineitem__l_partkey = lineitem__l_partkey[tid];

KEY_5f1f02977250 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_5f1f02977250.for_each(KEY_5f1f02977250, [&] __device__ (auto const SLOT_5f1f02977250) {
auto const [slot_first5f1f02977250, slot_second5f1f02977250] = SLOT_5f1f02977250;
if (!(true)) return;
uint64_t KEY_5f1f02977310 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_5f1f02977310 |= reg_lineitem__l_suppkey;
KEY_5f1f02977310 <<= 32;
KEY_5f1f02977310 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_5f1f02977310.for_each(KEY_5f1f02977310, [&] __device__ (auto const SLOT_5f1f02977310) {
auto const [slot_first5f1f02977310, slot_second5f1f02977310] = SLOT_5f1f02977310;
if (!(true)) return;
uint64_t KEY_5f1f0292c180 = 0;
auto reg_nation__n_name_encoded = nation__n_name_encoded[BUF_5f1f02977310[slot_second5f1f02977310 * 3 + 2]];

KEY_5f1f0292c180 |= reg_nation__n_name_encoded;
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_5f1f02977190[slot_second5f1f02977190 * 1 + 0]];
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_orders__o_orderdate);
KEY_5f1f0292c180 <<= 32;
KEY_5f1f0292c180 |= (DBI32Type)reg_map0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_5f1f0292c180 = HT_5f1f0292c180.find(KEY_5f1f0292c180)->second;
auto reg_lineitem__l_quantity = lineitem__l_quantity[tid];
auto reg_partsupp__ps_supplycost = partsupp__ps_supplycost[BUF_5f1f02977310[slot_second5f1f02977310 * 3 + 1]];
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = ((reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount))) - ((reg_partsupp__ps_supplycost) * (reg_lineitem__l_quantity));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_5f1f0292c180], reg_map0__tmp_attr1);
KEY_5f1f0292c180nation__n_name_encoded[buf_idx_5f1f0292c180] = reg_nation__n_name_encoded;
KEY_5f1f0292c180map0__tmp_attr0[buf_idx_5f1f0292c180] = reg_map0__tmp_attr0;
});
});
});
}
__global__ void count_5f1f02996ab0(size_t COUNT5f1f0292c180, uint64_t* COUNT5f1f0293eb10) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5f1f0292c180) return;
//Materialize count
atomicAdd((int*)COUNT5f1f0293eb10, 1);
}
__global__ void main_5f1f02996ab0(size_t COUNT5f1f0292c180, DBDecimalType* MAT5f1f0293eb10aggr0__tmp_attr2, DBI64Type* MAT5f1f0293eb10map0__tmp_attr0, DBI16Type* MAT5f1f0293eb10nation__n_name_encoded, uint64_t* MAT_IDX5f1f0293eb10, DBDecimalType* aggr0__tmp_attr2, DBI64Type* map0__tmp_attr0, DBI16Type* nation__n_name_encoded) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5f1f0292c180) return;
//Materialize buffers
auto mat_idx5f1f0293eb10 = atomicAdd((int*)MAT_IDX5f1f0293eb10, 1);
auto reg_nation__n_name_encoded = nation__n_name_encoded[tid];
MAT5f1f0293eb10nation__n_name_encoded[mat_idx5f1f0293eb10] = reg_nation__n_name_encoded;
auto reg_map0__tmp_attr0 = map0__tmp_attr0[tid];
MAT5f1f0293eb10map0__tmp_attr0[mat_idx5f1f0293eb10] = reg_map0__tmp_attr0;
auto reg_aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
MAT5f1f0293eb10aggr0__tmp_attr2[mat_idx5f1f0293eb10] = reg_aggr0__tmp_attr2;
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map) {
//Materialize count
uint64_t* d_COUNT5f1f0296f570;
cudaMalloc(&d_COUNT5f1f0296f570, sizeof(uint64_t));
cudaMemset(d_COUNT5f1f0296f570, 0, sizeof(uint64_t));
count_5f1f02980ad0<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT5f1f0296f570, nation_size);
uint64_t COUNT5f1f0296f570;
cudaMemcpy(&COUNT5f1f0296f570, d_COUNT5f1f0296f570, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5f1f0296f570;
cudaMalloc(&d_BUF_IDX_5f1f0296f570, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5f1f0296f570, 0, sizeof(uint64_t));
uint64_t* d_BUF_5f1f0296f570;
cudaMalloc(&d_BUF_5f1f0296f570, sizeof(uint64_t) * COUNT5f1f0296f570 * 1);
auto d_HT_5f1f0296f570 = cuco::experimental::static_multimap{ (int)COUNT5f1f0296f570*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5f1f02980ad0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_5f1f0296f570, d_BUF_IDX_5f1f0296f570, d_HT_5f1f0296f570.ref(cuco::insert), d_nation__n_nationkey, nation_size);
//Materialize count
uint64_t* d_COUNT5f1f0296f690;
cudaMalloc(&d_COUNT5f1f0296f690, sizeof(uint64_t));
cudaMemset(d_COUNT5f1f0296f690, 0, sizeof(uint64_t));
count_5f1f0295b9f0<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_5f1f0296f570, d_COUNT5f1f0296f690, d_HT_5f1f0296f570.ref(cuco::for_each), d_supplier__s_nationkey, supplier_size);
uint64_t COUNT5f1f0296f690;
cudaMemcpy(&COUNT5f1f0296f690, d_COUNT5f1f0296f690, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5f1f0296f690;
cudaMalloc(&d_BUF_IDX_5f1f0296f690, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5f1f0296f690, 0, sizeof(uint64_t));
uint64_t* d_BUF_5f1f0296f690;
cudaMalloc(&d_BUF_5f1f0296f690, sizeof(uint64_t) * COUNT5f1f0296f690 * 2);
auto d_HT_5f1f0296f690 = cuco::experimental::static_multimap{ (int)COUNT5f1f0296f690*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5f1f0295b9f0<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_5f1f0296f570, d_BUF_5f1f0296f690, d_BUF_IDX_5f1f0296f690, d_HT_5f1f0296f570.ref(cuco::for_each), d_HT_5f1f0296f690.ref(cuco::insert), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
//Materialize count
uint64_t* d_COUNT5f1f02977190;
cudaMalloc(&d_COUNT5f1f02977190, sizeof(uint64_t));
cudaMemset(d_COUNT5f1f02977190, 0, sizeof(uint64_t));
count_5f1f02987af0<<<std::ceil((float)orders_size/32.), 32>>>(d_COUNT5f1f02977190, orders_size);
uint64_t COUNT5f1f02977190;
cudaMemcpy(&COUNT5f1f02977190, d_COUNT5f1f02977190, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5f1f02977190;
cudaMalloc(&d_BUF_IDX_5f1f02977190, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5f1f02977190, 0, sizeof(uint64_t));
uint64_t* d_BUF_5f1f02977190;
cudaMalloc(&d_BUF_5f1f02977190, sizeof(uint64_t) * COUNT5f1f02977190 * 1);
auto d_HT_5f1f02977190 = cuco::experimental::static_multimap{ (int)COUNT5f1f02977190*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5f1f02987af0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5f1f02977190, d_BUF_IDX_5f1f02977190, d_HT_5f1f02977190.ref(cuco::insert), d_orders__o_orderkey, orders_size);
//Materialize count
uint64_t* d_COUNT5f1f02977250;
cudaMalloc(&d_COUNT5f1f02977250, sizeof(uint64_t));
cudaMemset(d_COUNT5f1f02977250, 0, sizeof(uint64_t));
count_5f1f0295b3c0<<<std::ceil((float)part_size/32.), 32>>>(d_COUNT5f1f02977250, part_size);
uint64_t COUNT5f1f02977250;
cudaMemcpy(&COUNT5f1f02977250, d_COUNT5f1f02977250, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5f1f02977250;
cudaMalloc(&d_BUF_IDX_5f1f02977250, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5f1f02977250, 0, sizeof(uint64_t));
uint64_t* d_BUF_5f1f02977250;
cudaMalloc(&d_BUF_5f1f02977250, sizeof(uint64_t) * COUNT5f1f02977250 * 1);
auto d_HT_5f1f02977250 = cuco::experimental::static_multimap{ (int)COUNT5f1f02977250*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5f1f0295b3c0<<<std::ceil((float)part_size/32.), 32>>>(d_BUF_5f1f02977250, d_BUF_IDX_5f1f02977250, d_HT_5f1f02977250.ref(cuco::insert), d_part__p_partkey, part_size);
//Materialize count
uint64_t* d_COUNT5f1f02977310;
cudaMalloc(&d_COUNT5f1f02977310, sizeof(uint64_t));
cudaMemset(d_COUNT5f1f02977310, 0, sizeof(uint64_t));
count_5f1f0297f920<<<std::ceil((float)partsupp_size/32.), 32>>>(d_BUF_5f1f0296f690, d_COUNT5f1f02977310, d_HT_5f1f0296f690.ref(cuco::for_each), d_partsupp__ps_suppkey, partsupp_size);
uint64_t COUNT5f1f02977310;
cudaMemcpy(&COUNT5f1f02977310, d_COUNT5f1f02977310, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_5f1f02977310;
cudaMalloc(&d_BUF_IDX_5f1f02977310, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5f1f02977310, 0, sizeof(uint64_t));
uint64_t* d_BUF_5f1f02977310;
cudaMalloc(&d_BUF_5f1f02977310, sizeof(uint64_t) * COUNT5f1f02977310 * 3);
auto d_HT_5f1f02977310 = cuco::experimental::static_multimap{ (int)COUNT5f1f02977310*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5f1f0297f920<<<std::ceil((float)partsupp_size/32.), 32>>>(d_BUF_5f1f0296f690, d_BUF_5f1f02977310, d_BUF_IDX_5f1f02977310, d_HT_5f1f0296f690.ref(cuco::for_each), d_HT_5f1f02977310.ref(cuco::insert), d_partsupp__ps_partkey, d_partsupp__ps_suppkey, partsupp_size, d_supplier__s_suppkey);
//Create aggregation hash table
auto d_HT_5f1f0292c180 = cuco::static_map{ (int)48009721*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5f1f0297ce00<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5f1f02977190, d_BUF_5f1f02977250, d_BUF_5f1f02977310, d_HT_5f1f0292c180.ref(cuco::insert), d_HT_5f1f02977190.ref(cuco::for_each), d_HT_5f1f02977250.ref(cuco::for_each), d_HT_5f1f02977310.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_partkey, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name_encoded, d_orders__o_orderdate);
size_t COUNT5f1f0292c180 = d_HT_5f1f0292c180.size();
thrust::device_vector<int64_t> keys_5f1f0292c180(COUNT5f1f0292c180), vals_5f1f0292c180(COUNT5f1f0292c180);
d_HT_5f1f0292c180.retrieve_all(keys_5f1f0292c180.begin(), vals_5f1f0292c180.begin());
d_HT_5f1f0292c180.clear();
int64_t* raw_keys5f1f0292c180 = thrust::raw_pointer_cast(keys_5f1f0292c180.data());
insertKeys<<<std::ceil((float)COUNT5f1f0292c180/32.), 32>>>(raw_keys5f1f0292c180, d_HT_5f1f0292c180.ref(cuco::insert), COUNT5f1f0292c180);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT5f1f0292c180);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT5f1f0292c180);
DBI16Type* d_KEY_5f1f0292c180nation__n_name_encoded;
cudaMalloc(&d_KEY_5f1f0292c180nation__n_name_encoded, sizeof(DBI16Type) * COUNT5f1f0292c180);
cudaMemset(d_KEY_5f1f0292c180nation__n_name_encoded, 0, sizeof(DBI16Type) * COUNT5f1f0292c180);
DBI64Type* d_KEY_5f1f0292c180map0__tmp_attr0;
cudaMalloc(&d_KEY_5f1f0292c180map0__tmp_attr0, sizeof(DBI64Type) * COUNT5f1f0292c180);
cudaMemset(d_KEY_5f1f0292c180map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT5f1f0292c180);
main_5f1f0297ce00<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5f1f02977190, d_BUF_5f1f02977250, d_BUF_5f1f02977310, d_HT_5f1f0292c180.ref(cuco::find), d_HT_5f1f02977190.ref(cuco::for_each), d_HT_5f1f02977250.ref(cuco::for_each), d_HT_5f1f02977310.ref(cuco::for_each), d_KEY_5f1f0292c180map0__tmp_attr0, d_KEY_5f1f0292c180nation__n_name_encoded, d_aggr0__tmp_attr2, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_partkey, d_lineitem__l_quantity, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name_encoded, d_orders__o_orderdate, d_partsupp__ps_supplycost);
//Materialize count
uint64_t* d_COUNT5f1f0293eb10;
cudaMalloc(&d_COUNT5f1f0293eb10, sizeof(uint64_t));
cudaMemset(d_COUNT5f1f0293eb10, 0, sizeof(uint64_t));
count_5f1f02996ab0<<<std::ceil((float)COUNT5f1f0292c180/32.), 32>>>(COUNT5f1f0292c180, d_COUNT5f1f0293eb10);
uint64_t COUNT5f1f0293eb10;
cudaMemcpy(&COUNT5f1f0293eb10, d_COUNT5f1f0293eb10, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX5f1f0293eb10;
cudaMalloc(&d_MAT_IDX5f1f0293eb10, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5f1f0293eb10, 0, sizeof(uint64_t));
auto MAT5f1f0293eb10nation__n_name_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT5f1f0293eb10);
DBI16Type* d_MAT5f1f0293eb10nation__n_name_encoded;
cudaMalloc(&d_MAT5f1f0293eb10nation__n_name_encoded, sizeof(DBI16Type) * COUNT5f1f0293eb10);
auto MAT5f1f0293eb10map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT5f1f0293eb10);
DBI64Type* d_MAT5f1f0293eb10map0__tmp_attr0;
cudaMalloc(&d_MAT5f1f0293eb10map0__tmp_attr0, sizeof(DBI64Type) * COUNT5f1f0293eb10);
auto MAT5f1f0293eb10aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5f1f0293eb10);
DBDecimalType* d_MAT5f1f0293eb10aggr0__tmp_attr2;
cudaMalloc(&d_MAT5f1f0293eb10aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT5f1f0293eb10);
main_5f1f02996ab0<<<std::ceil((float)COUNT5f1f0292c180/32.), 32>>>(COUNT5f1f0292c180, d_MAT5f1f0293eb10aggr0__tmp_attr2, d_MAT5f1f0293eb10map0__tmp_attr0, d_MAT5f1f0293eb10nation__n_name_encoded, d_MAT_IDX5f1f0293eb10, d_aggr0__tmp_attr2, d_KEY_5f1f0292c180map0__tmp_attr0, d_KEY_5f1f0292c180nation__n_name_encoded);
cudaMemcpy(MAT5f1f0293eb10nation__n_name_encoded, d_MAT5f1f0293eb10nation__n_name_encoded, sizeof(DBI16Type) * COUNT5f1f0293eb10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5f1f0293eb10map0__tmp_attr0, d_MAT5f1f0293eb10map0__tmp_attr0, sizeof(DBI64Type) * COUNT5f1f0293eb10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5f1f0293eb10aggr0__tmp_attr2, d_MAT5f1f0293eb10aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT5f1f0293eb10, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5f1f0293eb10; i++) { std::cout << nation__n_name_map[MAT5f1f0293eb10nation__n_name_encoded[i]] << "\t";
std::cout << MAT5f1f0293eb10map0__tmp_attr0[i] << "\t";
std::cout << MAT5f1f0293eb10aggr0__tmp_attr2[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_5f1f0296f570);
cudaFree(d_BUF_IDX_5f1f0296f570);
cudaFree(d_COUNT5f1f0296f570);
cudaFree(d_BUF_5f1f0296f690);
cudaFree(d_BUF_IDX_5f1f0296f690);
cudaFree(d_COUNT5f1f0296f690);
cudaFree(d_BUF_5f1f02977190);
cudaFree(d_BUF_IDX_5f1f02977190);
cudaFree(d_COUNT5f1f02977190);
cudaFree(d_BUF_5f1f02977250);
cudaFree(d_BUF_IDX_5f1f02977250);
cudaFree(d_COUNT5f1f02977250);
cudaFree(d_BUF_5f1f02977310);
cudaFree(d_BUF_IDX_5f1f02977310);
cudaFree(d_COUNT5f1f02977310);
cudaFree(d_KEY_5f1f0292c180map0__tmp_attr0);
cudaFree(d_KEY_5f1f0292c180nation__n_name_encoded);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_COUNT5f1f0293eb10);
cudaFree(d_MAT5f1f0293eb10aggr0__tmp_attr2);
cudaFree(d_MAT5f1f0293eb10map0__tmp_attr0);
cudaFree(d_MAT5f1f0293eb10nation__n_name_encoded);
cudaFree(d_MAT_IDX5f1f0293eb10);
free(MAT5f1f0293eb10aggr0__tmp_attr2);
free(MAT5f1f0293eb10map0__tmp_attr0);
free(MAT5f1f0293eb10nation__n_name_encoded);
}