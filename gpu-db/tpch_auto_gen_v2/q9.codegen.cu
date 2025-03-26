#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_615ba43438a0(uint64_t* COUNT615ba4334f00, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
//Materialize count
atomicAdd((int*)COUNT615ba4334f00, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_615ba43438a0(uint64_t* BUF_615ba4334f00, uint64_t* BUF_IDX_615ba4334f00, HASHTABLE_INSERT HT_615ba4334f00, DBI32Type* nation__n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
uint64_t KEY_615ba4334f00 = 0;
auto reg_nation__n_nationkey = nation__n_nationkey[tid];

KEY_615ba4334f00 |= reg_nation__n_nationkey;
// Insert hash table kernel;
auto buf_idx_615ba4334f00 = atomicAdd((int*)BUF_IDX_615ba4334f00, 1);
HT_615ba4334f00.insert(cuco::pair{KEY_615ba4334f00, buf_idx_615ba4334f00});
BUF_615ba4334f00[buf_idx_615ba4334f00 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_615ba42bf660(uint64_t* BUF_615ba4334f00, uint64_t* COUNT615ba4334780, HASHTABLE_PROBE HT_615ba4334f00, DBI32Type* supplier__s_nationkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_615ba4334f00 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_615ba4334f00 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_615ba4334f00.for_each(KEY_615ba4334f00, [&] __device__ (auto const SLOT_615ba4334f00) {

auto const [slot_first615ba4334f00, slot_second615ba4334f00] = SLOT_615ba4334f00;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT615ba4334780, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_615ba42bf660(uint64_t* BUF_615ba4334780, uint64_t* BUF_615ba4334f00, uint64_t* BUF_IDX_615ba4334780, HASHTABLE_INSERT HT_615ba4334780, HASHTABLE_PROBE HT_615ba4334f00, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_615ba4334f00 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_615ba4334f00 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_615ba4334f00.for_each(KEY_615ba4334f00, [&] __device__ (auto const SLOT_615ba4334f00) {
auto const [slot_first615ba4334f00, slot_second615ba4334f00] = SLOT_615ba4334f00;
if (!(true)) return;
uint64_t KEY_615ba4334780 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_615ba4334780 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_615ba4334780 = atomicAdd((int*)BUF_IDX_615ba4334780, 1);
HT_615ba4334780.insert(cuco::pair{KEY_615ba4334780, buf_idx_615ba4334780});
BUF_615ba4334780[buf_idx_615ba4334780 * 2 + 0] = tid;
BUF_615ba4334780[buf_idx_615ba4334780 * 2 + 1] = BUF_615ba4334f00[slot_second615ba4334f00 * 1 + 0];
});
}
__global__ void count_615ba4348d10(uint64_t* COUNT615ba433cfe0, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
//Materialize count
atomicAdd((int*)COUNT615ba433cfe0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_615ba4348d10(uint64_t* BUF_615ba433cfe0, uint64_t* BUF_IDX_615ba433cfe0, HASHTABLE_INSERT HT_615ba433cfe0, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_615ba433cfe0 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_615ba433cfe0 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_615ba433cfe0 = atomicAdd((int*)BUF_IDX_615ba433cfe0, 1);
HT_615ba433cfe0.insert(cuco::pair{KEY_615ba433cfe0, buf_idx_615ba433cfe0});
BUF_615ba433cfe0[buf_idx_615ba433cfe0 * 1 + 0] = tid;
}
__global__ void count_615ba423c2c0(uint64_t* COUNT615ba433d0a0, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
//Materialize count
atomicAdd((int*)COUNT615ba433d0a0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_615ba423c2c0(uint64_t* BUF_615ba433d0a0, uint64_t* BUF_IDX_615ba433d0a0, HASHTABLE_INSERT HT_615ba433d0a0, DBI32Type* part__p_partkey, size_t part_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= part_size) return;
uint64_t KEY_615ba433d0a0 = 0;
auto reg_part__p_partkey = part__p_partkey[tid];

KEY_615ba433d0a0 |= reg_part__p_partkey;
// Insert hash table kernel;
auto buf_idx_615ba433d0a0 = atomicAdd((int*)BUF_IDX_615ba433d0a0, 1);
HT_615ba433d0a0.insert(cuco::pair{KEY_615ba433d0a0, buf_idx_615ba433d0a0});
BUF_615ba433d0a0[buf_idx_615ba433d0a0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_615ba43429c0(uint64_t* BUF_615ba4334780, uint64_t* COUNT615ba433d1b0, HASHTABLE_PROBE HT_615ba4334780, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= partsupp_size) return;
uint64_t KEY_615ba4334780 = 0;
auto reg_partsupp__ps_suppkey = partsupp__ps_suppkey[tid];

KEY_615ba4334780 |= reg_partsupp__ps_suppkey;
//Probe Hash table
HT_615ba4334780.for_each(KEY_615ba4334780, [&] __device__ (auto const SLOT_615ba4334780) {

auto const [slot_first615ba4334780, slot_second615ba4334780] = SLOT_615ba4334780;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT615ba433d1b0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_615ba43429c0(uint64_t* BUF_615ba4334780, uint64_t* BUF_615ba433d1b0, uint64_t* BUF_IDX_615ba433d1b0, HASHTABLE_PROBE HT_615ba4334780, HASHTABLE_INSERT HT_615ba433d1b0, DBI32Type* partsupp__ps_partkey, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size, DBI32Type* supplier__s_suppkey) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= partsupp_size) return;
uint64_t KEY_615ba4334780 = 0;
auto reg_partsupp__ps_suppkey = partsupp__ps_suppkey[tid];

KEY_615ba4334780 |= reg_partsupp__ps_suppkey;
//Probe Hash table
HT_615ba4334780.for_each(KEY_615ba4334780, [&] __device__ (auto const SLOT_615ba4334780) {
auto const [slot_first615ba4334780, slot_second615ba4334780] = SLOT_615ba4334780;
if (!(true)) return;
uint64_t KEY_615ba433d1b0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[BUF_615ba4334780[slot_second615ba4334780 * 2 + 0]];

KEY_615ba433d1b0 |= reg_supplier__s_suppkey;
auto reg_partsupp__ps_partkey = partsupp__ps_partkey[tid];
KEY_615ba433d1b0 <<= 32;
KEY_615ba433d1b0 |= reg_partsupp__ps_partkey;
// Insert hash table kernel;
auto buf_idx_615ba433d1b0 = atomicAdd((int*)BUF_IDX_615ba433d1b0, 1);
HT_615ba433d1b0.insert(cuco::pair{KEY_615ba433d1b0, buf_idx_615ba433d1b0});
BUF_615ba433d1b0[buf_idx_615ba433d1b0 * 3 + 0] = BUF_615ba4334780[slot_second615ba4334780 * 2 + 0];
BUF_615ba433d1b0[buf_idx_615ba433d1b0 * 3 + 1] = tid;
BUF_615ba433d1b0[buf_idx_615ba433d1b0 * 3 + 2] = BUF_615ba4334780[slot_second615ba4334780 * 2 + 1];
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_615ba4340570(uint64_t* BUF_615ba433cfe0, uint64_t* BUF_615ba433d0a0, uint64_t* BUF_615ba433d1b0, HASHTABLE_INSERT HT_615ba42f1d30, HASHTABLE_PROBE HT_615ba433cfe0, HASHTABLE_PROBE HT_615ba433d0a0, HASHTABLE_PROBE HT_615ba433d1b0, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_partkey, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBDateType* orders__o_orderdate) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_615ba433cfe0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_615ba433cfe0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_615ba433cfe0.for_each(KEY_615ba433cfe0, [&] __device__ (auto const SLOT_615ba433cfe0) {

auto const [slot_first615ba433cfe0, slot_second615ba433cfe0] = SLOT_615ba433cfe0;
if (!(true)) return;
uint64_t KEY_615ba433d0a0 = 0;
auto reg_lineitem__l_partkey = lineitem__l_partkey[tid];

KEY_615ba433d0a0 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_615ba433d0a0.for_each(KEY_615ba433d0a0, [&] __device__ (auto const SLOT_615ba433d0a0) {

auto const [slot_first615ba433d0a0, slot_second615ba433d0a0] = SLOT_615ba433d0a0;
if (!(true)) return;
uint64_t KEY_615ba433d1b0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_615ba433d1b0 |= reg_lineitem__l_suppkey;
KEY_615ba433d1b0 <<= 32;
KEY_615ba433d1b0 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_615ba433d1b0.for_each(KEY_615ba433d1b0, [&] __device__ (auto const SLOT_615ba433d1b0) {

auto const [slot_first615ba433d1b0, slot_second615ba433d1b0] = SLOT_615ba433d1b0;
if (!(true)) return;
uint64_t KEY_615ba42f1d30 = 0;
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_615ba433cfe0[slot_second615ba433cfe0 * 1 + 0]];
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_orders__o_orderdate);

KEY_615ba42f1d30 |= reg_map0__tmp_attr0;
//Create aggregation hash table
HT_615ba42f1d30.insert(cuco::pair{KEY_615ba42f1d30, 1});
});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_615ba4340570(uint64_t* BUF_615ba433cfe0, uint64_t* BUF_615ba433d0a0, uint64_t* BUF_615ba433d1b0, HASHTABLE_FIND HT_615ba42f1d30, HASHTABLE_PROBE HT_615ba433cfe0, HASHTABLE_PROBE HT_615ba433d0a0, HASHTABLE_PROBE HT_615ba433d1b0, DBI64Type* KEY_615ba42f1d30map0__tmp_attr0, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBI32Type* lineitem__l_partkey, DBDecimalType* lineitem__l_quantity, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBDateType* orders__o_orderdate, DBDecimalType* partsupp__ps_supplycost) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
uint64_t KEY_615ba433cfe0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_615ba433cfe0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_615ba433cfe0.for_each(KEY_615ba433cfe0, [&] __device__ (auto const SLOT_615ba433cfe0) {
auto const [slot_first615ba433cfe0, slot_second615ba433cfe0] = SLOT_615ba433cfe0;
if (!(true)) return;
uint64_t KEY_615ba433d0a0 = 0;
auto reg_lineitem__l_partkey = lineitem__l_partkey[tid];

KEY_615ba433d0a0 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_615ba433d0a0.for_each(KEY_615ba433d0a0, [&] __device__ (auto const SLOT_615ba433d0a0) {
auto const [slot_first615ba433d0a0, slot_second615ba433d0a0] = SLOT_615ba433d0a0;
if (!(true)) return;
uint64_t KEY_615ba433d1b0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_615ba433d1b0 |= reg_lineitem__l_suppkey;
KEY_615ba433d1b0 <<= 32;
KEY_615ba433d1b0 |= reg_lineitem__l_partkey;
//Probe Hash table
HT_615ba433d1b0.for_each(KEY_615ba433d1b0, [&] __device__ (auto const SLOT_615ba433d1b0) {
auto const [slot_first615ba433d1b0, slot_second615ba433d1b0] = SLOT_615ba433d1b0;
if (!(true)) return;
uint64_t KEY_615ba42f1d30 = 0;
auto reg_orders__o_orderdate = orders__o_orderdate[BUF_615ba433cfe0[slot_second615ba433cfe0 * 1 + 0]];
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_orders__o_orderdate);

KEY_615ba42f1d30 |= reg_map0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_615ba42f1d30 = HT_615ba42f1d30.find(KEY_615ba42f1d30)->second;
auto reg_lineitem__l_quantity = lineitem__l_quantity[tid];
auto reg_partsupp__ps_supplycost = partsupp__ps_supplycost[BUF_615ba433d1b0[slot_second615ba433d1b0 * 3 + 1]];
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = ((reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount))) - ((reg_partsupp__ps_supplycost) * (reg_lineitem__l_quantity));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_615ba42f1d30], reg_map0__tmp_attr1);
KEY_615ba42f1d30map0__tmp_attr0[buf_idx_615ba42f1d30] = reg_map0__tmp_attr0;
});
});
});
}
__global__ void count_615ba4356b90(size_t COUNT615ba42f1d30, uint64_t* COUNT615ba43041f0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT615ba42f1d30) return;
//Materialize count
atomicAdd((int*)COUNT615ba43041f0, 1);
}
__global__ void main_615ba4356b90(size_t COUNT615ba42f1d30, DBDecimalType* MAT615ba43041f0aggr0__tmp_attr2, DBI64Type* MAT615ba43041f0map0__tmp_attr0, uint64_t* MAT_IDX615ba43041f0, DBDecimalType* aggr0__tmp_attr2, DBI64Type* map0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT615ba42f1d30) return;
//Materialize buffers
auto mat_idx615ba43041f0 = atomicAdd((int*)MAT_IDX615ba43041f0, 1);
auto reg_map0__tmp_attr0 = map0__tmp_attr0[tid];
MAT615ba43041f0map0__tmp_attr0[mat_idx615ba43041f0] = reg_map0__tmp_attr0;
auto reg_aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
MAT615ba43041f0aggr0__tmp_attr2[mat_idx615ba43041f0] = reg_aggr0__tmp_attr2;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT615ba4334f00;
cudaMalloc(&d_COUNT615ba4334f00, sizeof(uint64_t));
cudaMemset(d_COUNT615ba4334f00, 0, sizeof(uint64_t));
count_615ba43438a0<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT615ba4334f00, nation_size);
uint64_t COUNT615ba4334f00;
cudaMemcpy(&COUNT615ba4334f00, d_COUNT615ba4334f00, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT615ba4334f00);
// Insert hash table control;
uint64_t* d_BUF_IDX_615ba4334f00;
cudaMalloc(&d_BUF_IDX_615ba4334f00, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_615ba4334f00, 0, sizeof(uint64_t));
uint64_t* d_BUF_615ba4334f00;
cudaMalloc(&d_BUF_615ba4334f00, sizeof(uint64_t) * COUNT615ba4334f00 * 1);
auto d_HT_615ba4334f00 = cuco::experimental::static_multimap{ (int)COUNT615ba4334f00*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_615ba43438a0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_615ba4334f00, d_BUF_IDX_615ba4334f00, d_HT_615ba4334f00.ref(cuco::insert), d_nation__n_nationkey, nation_size);
cudaFree(d_BUF_IDX_615ba4334f00);
//Materialize count
uint64_t* d_COUNT615ba4334780;
cudaMalloc(&d_COUNT615ba4334780, sizeof(uint64_t));
cudaMemset(d_COUNT615ba4334780, 0, sizeof(uint64_t));
count_615ba42bf660<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_615ba4334f00, d_COUNT615ba4334780, d_HT_615ba4334f00.ref(cuco::for_each), d_supplier__s_nationkey, supplier_size);
uint64_t COUNT615ba4334780;
cudaMemcpy(&COUNT615ba4334780, d_COUNT615ba4334780, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT615ba4334780);
// Insert hash table control;
uint64_t* d_BUF_IDX_615ba4334780;
cudaMalloc(&d_BUF_IDX_615ba4334780, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_615ba4334780, 0, sizeof(uint64_t));
uint64_t* d_BUF_615ba4334780;
cudaMalloc(&d_BUF_615ba4334780, sizeof(uint64_t) * COUNT615ba4334780 * 2);
auto d_HT_615ba4334780 = cuco::experimental::static_multimap{ (int)COUNT615ba4334780*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_615ba42bf660<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_615ba4334780, d_BUF_615ba4334f00, d_BUF_IDX_615ba4334780, d_HT_615ba4334780.ref(cuco::insert), d_HT_615ba4334f00.ref(cuco::for_each), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
cudaFree(d_BUF_IDX_615ba4334780);
//Materialize count
uint64_t* d_COUNT615ba433cfe0;
cudaMalloc(&d_COUNT615ba433cfe0, sizeof(uint64_t));
cudaMemset(d_COUNT615ba433cfe0, 0, sizeof(uint64_t));
count_615ba4348d10<<<std::ceil((float)orders_size/32.), 32>>>(d_COUNT615ba433cfe0, orders_size);
uint64_t COUNT615ba433cfe0;
cudaMemcpy(&COUNT615ba433cfe0, d_COUNT615ba433cfe0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT615ba433cfe0);
// Insert hash table control;
uint64_t* d_BUF_IDX_615ba433cfe0;
cudaMalloc(&d_BUF_IDX_615ba433cfe0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_615ba433cfe0, 0, sizeof(uint64_t));
uint64_t* d_BUF_615ba433cfe0;
cudaMalloc(&d_BUF_615ba433cfe0, sizeof(uint64_t) * COUNT615ba433cfe0 * 1);
auto d_HT_615ba433cfe0 = cuco::experimental::static_multimap{ (int)COUNT615ba433cfe0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_615ba4348d10<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_615ba433cfe0, d_BUF_IDX_615ba433cfe0, d_HT_615ba433cfe0.ref(cuco::insert), d_orders__o_orderkey, orders_size);
cudaFree(d_BUF_IDX_615ba433cfe0);
//Materialize count
uint64_t* d_COUNT615ba433d0a0;
cudaMalloc(&d_COUNT615ba433d0a0, sizeof(uint64_t));
cudaMemset(d_COUNT615ba433d0a0, 0, sizeof(uint64_t));
count_615ba423c2c0<<<std::ceil((float)part_size/32.), 32>>>(d_COUNT615ba433d0a0, part_size);
uint64_t COUNT615ba433d0a0;
cudaMemcpy(&COUNT615ba433d0a0, d_COUNT615ba433d0a0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT615ba433d0a0);
// Insert hash table control;
uint64_t* d_BUF_IDX_615ba433d0a0;
cudaMalloc(&d_BUF_IDX_615ba433d0a0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_615ba433d0a0, 0, sizeof(uint64_t));
uint64_t* d_BUF_615ba433d0a0;
cudaMalloc(&d_BUF_615ba433d0a0, sizeof(uint64_t) * COUNT615ba433d0a0 * 1);
auto d_HT_615ba433d0a0 = cuco::experimental::static_multimap{ (int)COUNT615ba433d0a0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_615ba423c2c0<<<std::ceil((float)part_size/32.), 32>>>(d_BUF_615ba433d0a0, d_BUF_IDX_615ba433d0a0, d_HT_615ba433d0a0.ref(cuco::insert), d_part__p_partkey, part_size);
cudaFree(d_BUF_IDX_615ba433d0a0);
//Materialize count
uint64_t* d_COUNT615ba433d1b0;
cudaMalloc(&d_COUNT615ba433d1b0, sizeof(uint64_t));
cudaMemset(d_COUNT615ba433d1b0, 0, sizeof(uint64_t));
count_615ba43429c0<<<std::ceil((float)partsupp_size/32.), 32>>>(d_BUF_615ba4334780, d_COUNT615ba433d1b0, d_HT_615ba4334780.ref(cuco::for_each), d_partsupp__ps_suppkey, partsupp_size);
uint64_t COUNT615ba433d1b0;
cudaMemcpy(&COUNT615ba433d1b0, d_COUNT615ba433d1b0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT615ba433d1b0);
// Insert hash table control;
uint64_t* d_BUF_IDX_615ba433d1b0;
cudaMalloc(&d_BUF_IDX_615ba433d1b0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_615ba433d1b0, 0, sizeof(uint64_t));
uint64_t* d_BUF_615ba433d1b0;
cudaMalloc(&d_BUF_615ba433d1b0, sizeof(uint64_t) * COUNT615ba433d1b0 * 3);
auto d_HT_615ba433d1b0 = cuco::experimental::static_multimap{ (int)COUNT615ba433d1b0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_615ba43429c0<<<std::ceil((float)partsupp_size/32.), 32>>>(d_BUF_615ba4334780, d_BUF_615ba433d1b0, d_BUF_IDX_615ba433d1b0, d_HT_615ba4334780.ref(cuco::for_each), d_HT_615ba433d1b0.ref(cuco::insert), d_partsupp__ps_partkey, d_partsupp__ps_suppkey, partsupp_size, d_supplier__s_suppkey);
cudaFree(d_BUF_IDX_615ba433d1b0);
//Create aggregation hash table
auto d_HT_615ba42f1d30 = cuco::static_map{ (int)48009721*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_615ba4340570<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_615ba433cfe0, d_BUF_615ba433d0a0, d_BUF_615ba433d1b0, d_HT_615ba42f1d30.ref(cuco::insert), d_HT_615ba433cfe0.ref(cuco::for_each), d_HT_615ba433d0a0.ref(cuco::for_each), d_HT_615ba433d1b0.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_partkey, d_lineitem__l_suppkey, lineitem_size, d_orders__o_orderdate);
size_t COUNT615ba42f1d30 = d_HT_615ba42f1d30.size();
thrust::device_vector<int64_t> keys_615ba42f1d30(COUNT615ba42f1d30), vals_615ba42f1d30(COUNT615ba42f1d30);
d_HT_615ba42f1d30.retrieve_all(keys_615ba42f1d30.begin(), vals_615ba42f1d30.begin());
d_HT_615ba42f1d30.clear();
int64_t* raw_keys615ba42f1d30 = thrust::raw_pointer_cast(keys_615ba42f1d30.data());
insertKeys<<<std::ceil((float)COUNT615ba42f1d30/32.), 32>>>(raw_keys615ba42f1d30, d_HT_615ba42f1d30.ref(cuco::insert), COUNT615ba42f1d30);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT615ba42f1d30);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT615ba42f1d30);
DBI64Type* d_KEY_615ba42f1d30map0__tmp_attr0;
cudaMalloc(&d_KEY_615ba42f1d30map0__tmp_attr0, sizeof(DBI64Type) * COUNT615ba42f1d30);
cudaMemset(d_KEY_615ba42f1d30map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT615ba42f1d30);
main_615ba4340570<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_615ba433cfe0, d_BUF_615ba433d0a0, d_BUF_615ba433d1b0, d_HT_615ba42f1d30.ref(cuco::find), d_HT_615ba433cfe0.ref(cuco::for_each), d_HT_615ba433d0a0.ref(cuco::for_each), d_HT_615ba433d1b0.ref(cuco::for_each), d_KEY_615ba42f1d30map0__tmp_attr0, d_aggr0__tmp_attr2, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_partkey, d_lineitem__l_quantity, d_lineitem__l_suppkey, lineitem_size, d_orders__o_orderdate, d_partsupp__ps_supplycost);
//Materialize count
uint64_t* d_COUNT615ba43041f0;
cudaMalloc(&d_COUNT615ba43041f0, sizeof(uint64_t));
cudaMemset(d_COUNT615ba43041f0, 0, sizeof(uint64_t));
count_615ba4356b90<<<std::ceil((float)COUNT615ba42f1d30/32.), 32>>>(COUNT615ba42f1d30, d_COUNT615ba43041f0);
uint64_t COUNT615ba43041f0;
cudaMemcpy(&COUNT615ba43041f0, d_COUNT615ba43041f0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT615ba43041f0);
//Materialize buffers
uint64_t* d_MAT_IDX615ba43041f0;
cudaMalloc(&d_MAT_IDX615ba43041f0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX615ba43041f0, 0, sizeof(uint64_t));
auto MAT615ba43041f0map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT615ba43041f0);
DBI64Type* d_MAT615ba43041f0map0__tmp_attr0;
cudaMalloc(&d_MAT615ba43041f0map0__tmp_attr0, sizeof(DBI64Type) * COUNT615ba43041f0);
auto MAT615ba43041f0aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT615ba43041f0);
DBDecimalType* d_MAT615ba43041f0aggr0__tmp_attr2;
cudaMalloc(&d_MAT615ba43041f0aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT615ba43041f0);
main_615ba4356b90<<<std::ceil((float)COUNT615ba42f1d30/32.), 32>>>(COUNT615ba42f1d30, d_MAT615ba43041f0aggr0__tmp_attr2, d_MAT615ba43041f0map0__tmp_attr0, d_MAT_IDX615ba43041f0, d_aggr0__tmp_attr2, d_KEY_615ba42f1d30map0__tmp_attr0);
cudaFree(d_MAT_IDX615ba43041f0);
cudaMemcpy(MAT615ba43041f0map0__tmp_attr0, d_MAT615ba43041f0map0__tmp_attr0, sizeof(DBI64Type) * COUNT615ba43041f0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT615ba43041f0aggr0__tmp_attr2, d_MAT615ba43041f0aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT615ba43041f0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT615ba43041f0; i++) { std::cout << MAT615ba43041f0map0__tmp_attr0[i] << "\t";
std::cout << MAT615ba43041f0aggr0__tmp_attr2[i] << "\t";
std::cout << std::endl; }
}