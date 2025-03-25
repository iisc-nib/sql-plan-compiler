#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_591de844c170(uint64_t* COUNT591de8429310, DBStringType* n1___n_name, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n1___n_name = n1___n_name[tid];
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
//Materialize count
atomicAdd((int*)COUNT591de8429310, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_591de844c170(uint64_t* BUF_591de8429310, uint64_t* BUF_IDX_591de8429310, HASHTABLE_INSERT HT_591de8429310, DBStringType* n1___n_name, DBI32Type* n1___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n1___n_name = n1___n_name[tid];
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
uint64_t KEY_591de8429310 = 0;
auto reg_n1___n_nationkey = n1___n_nationkey[tid];

KEY_591de8429310 |= reg_n1___n_nationkey;
// Insert hash table kernel;
auto buf_idx_591de8429310 = atomicAdd((int*)BUF_IDX_591de8429310, 1);
HT_591de8429310.insert(cuco::pair{KEY_591de8429310, buf_idx_591de8429310});
BUF_591de8429310[buf_idx_591de8429310 * 1 + 0] = tid;
}
__global__ void count_591de844f3c0(uint64_t* COUNT591de8440c60, DBStringType* n2___n_name, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n2___n_name = n2___n_name[tid];
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
//Materialize count
atomicAdd((int*)COUNT591de8440c60, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_591de844f3c0(uint64_t* BUF_591de8440c60, uint64_t* BUF_IDX_591de8440c60, HASHTABLE_INSERT HT_591de8440c60, DBStringType* n2___n_name, DBI32Type* n2___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n2___n_name = n2___n_name[tid];
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
uint64_t KEY_591de8440c60 = 0;
auto reg_n2___n_nationkey = n2___n_nationkey[tid];

KEY_591de8440c60 |= reg_n2___n_nationkey;
// Insert hash table kernel;
auto buf_idx_591de8440c60 = atomicAdd((int*)BUF_IDX_591de8440c60, 1);
HT_591de8440c60.insert(cuco::pair{KEY_591de8440c60, buf_idx_591de8440c60});
BUF_591de8440c60[buf_idx_591de8440c60 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_591de8450320(uint64_t* BUF_591de8440c60, uint64_t* COUNT591de843d4e0, HASHTABLE_PROBE HT_591de8440c60, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_591de8440c60 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_591de8440c60 |= reg_customer__c_nationkey;
//Probe Hash table
HT_591de8440c60.for_each(KEY_591de8440c60, [&] __device__ (auto const SLOT_591de8440c60) {

auto const [slot_first591de8440c60, slot_second591de8440c60] = SLOT_591de8440c60;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT591de843d4e0, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_591de8450320(uint64_t* BUF_591de843d4e0, uint64_t* BUF_591de8440c60, uint64_t* BUF_IDX_591de843d4e0, HASHTABLE_INSERT HT_591de843d4e0, HASHTABLE_PROBE HT_591de8440c60, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_591de8440c60 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_591de8440c60 |= reg_customer__c_nationkey;
//Probe Hash table
HT_591de8440c60.for_each(KEY_591de8440c60, [&] __device__ (auto const SLOT_591de8440c60) {
auto const [slot_first591de8440c60, slot_second591de8440c60] = SLOT_591de8440c60;
if (!(true)) return;
uint64_t KEY_591de843d4e0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_591de843d4e0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_591de843d4e0 = atomicAdd((int*)BUF_IDX_591de843d4e0, 1);
HT_591de843d4e0.insert(cuco::pair{KEY_591de843d4e0, buf_idx_591de843d4e0});
BUF_591de843d4e0[buf_idx_591de843d4e0 * 2 + 0] = BUF_591de8440c60[slot_second591de8440c60 * 1 + 0];
BUF_591de843d4e0[buf_idx_591de843d4e0 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_591de844ad20(uint64_t* BUF_591de843d4e0, uint64_t* COUNT591de8441dd0, HASHTABLE_PROBE HT_591de843d4e0, DBI32Type* orders__o_custkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_591de843d4e0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_591de843d4e0 |= reg_orders__o_custkey;
//Probe Hash table
HT_591de843d4e0.for_each(KEY_591de843d4e0, [&] __device__ (auto const SLOT_591de843d4e0) {

auto const [slot_first591de843d4e0, slot_second591de843d4e0] = SLOT_591de843d4e0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT591de8441dd0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_591de844ad20(uint64_t* BUF_591de843d4e0, uint64_t* BUF_591de8441dd0, uint64_t* BUF_IDX_591de8441dd0, HASHTABLE_PROBE HT_591de843d4e0, HASHTABLE_INSERT HT_591de8441dd0, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_591de843d4e0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_591de843d4e0 |= reg_orders__o_custkey;
//Probe Hash table
HT_591de843d4e0.for_each(KEY_591de843d4e0, [&] __device__ (auto const SLOT_591de843d4e0) {
auto const [slot_first591de843d4e0, slot_second591de843d4e0] = SLOT_591de843d4e0;
if (!(true)) return;
uint64_t KEY_591de8441dd0 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_591de8441dd0 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_591de8441dd0 = atomicAdd((int*)BUF_IDX_591de8441dd0, 1);
HT_591de8441dd0.insert(cuco::pair{KEY_591de8441dd0, buf_idx_591de8441dd0});
BUF_591de8441dd0[buf_idx_591de8441dd0 * 3 + 0] = tid;
BUF_591de8441dd0[buf_idx_591de8441dd0 * 3 + 1] = BUF_591de843d4e0[slot_second591de843d4e0 * 2 + 0];
BUF_591de8441dd0[buf_idx_591de8441dd0 * 3 + 2] = BUF_591de843d4e0[slot_second591de843d4e0 * 2 + 1];
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_591de83412c0(uint64_t* BUF_591de8429310, uint64_t* COUNT591de8441ee0, HASHTABLE_PROBE HT_591de8429310, DBI32Type* supplier__s_nationkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_591de8429310 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_591de8429310 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_591de8429310.for_each(KEY_591de8429310, [&] __device__ (auto const SLOT_591de8429310) {

auto const [slot_first591de8429310, slot_second591de8429310] = SLOT_591de8429310;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT591de8441ee0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_591de83412c0(uint64_t* BUF_591de8429310, uint64_t* BUF_591de8441ee0, uint64_t* BUF_IDX_591de8441ee0, HASHTABLE_PROBE HT_591de8429310, HASHTABLE_INSERT HT_591de8441ee0, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_591de8429310 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_591de8429310 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_591de8429310.for_each(KEY_591de8429310, [&] __device__ (auto const SLOT_591de8429310) {
auto const [slot_first591de8429310, slot_second591de8429310] = SLOT_591de8429310;
if (!(true)) return;
uint64_t KEY_591de8441ee0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_591de8441ee0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_591de8441ee0 = atomicAdd((int*)BUF_IDX_591de8441ee0, 1);
HT_591de8441ee0.insert(cuco::pair{KEY_591de8441ee0, buf_idx_591de8441ee0});
BUF_591de8441ee0[buf_idx_591de8441ee0 * 2 + 0] = tid;
BUF_591de8441ee0[buf_idx_591de8441ee0 * 2 + 1] = BUF_591de8429310[slot_second591de8429310 * 1 + 0];
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_591de83c4880(uint64_t* BUF_591de8441dd0, uint64_t* BUF_591de8441ee0, HASHTABLE_INSERT HT_591de83e4300, HASHTABLE_PROBE HT_591de8441dd0, HASHTABLE_PROBE HT_591de8441ee0, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBStringType* n2___n_name) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9861, Predicate::lte))) return;
uint64_t KEY_591de8441dd0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_591de8441dd0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_591de8441dd0.for_each(KEY_591de8441dd0, [&] __device__ (auto const SLOT_591de8441dd0) {

auto const [slot_first591de8441dd0, slot_second591de8441dd0] = SLOT_591de8441dd0;
if (!(true)) return;
uint64_t KEY_591de8441ee0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_591de8441ee0 |= reg_lineitem__l_suppkey;
//Probe Hash table
HT_591de8441ee0.for_each(KEY_591de8441ee0, [&] __device__ (auto const SLOT_591de8441ee0) {

auto const [slot_first591de8441ee0, slot_second591de8441ee0] = SLOT_591de8441ee0;
auto reg_n1___n_name = n1___n_name[BUF_591de8441ee0[slot_second591de8441ee0 * 2 + 1]];
auto reg_n2___n_name = n2___n_name[BUF_591de8441dd0[slot_second591de8441dd0 * 3 + 1]];
if (!((((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) && (true))) return;
uint64_t KEY_591de83e4300 = 0;
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_lineitem__l_shipdate);

KEY_591de83e4300 |= reg_map0__tmp_attr0;
//Create aggregation hash table
HT_591de83e4300.insert(cuco::pair{KEY_591de83e4300, 1});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_591de83c4880(uint64_t* BUF_591de8441dd0, uint64_t* BUF_591de8441ee0, HASHTABLE_FIND HT_591de83e4300, HASHTABLE_PROBE HT_591de8441dd0, HASHTABLE_PROBE HT_591de8441ee0, DBI64Type* KEY_591de83e4300map0__tmp_attr0, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBStringType* n2___n_name) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9861, Predicate::lte))) return;
uint64_t KEY_591de8441dd0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_591de8441dd0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_591de8441dd0.for_each(KEY_591de8441dd0, [&] __device__ (auto const SLOT_591de8441dd0) {
auto const [slot_first591de8441dd0, slot_second591de8441dd0] = SLOT_591de8441dd0;
if (!(true)) return;
uint64_t KEY_591de8441ee0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_591de8441ee0 |= reg_lineitem__l_suppkey;
//Probe Hash table
HT_591de8441ee0.for_each(KEY_591de8441ee0, [&] __device__ (auto const SLOT_591de8441ee0) {
auto const [slot_first591de8441ee0, slot_second591de8441ee0] = SLOT_591de8441ee0;
auto reg_n1___n_name = n1___n_name[BUF_591de8441ee0[slot_second591de8441ee0 * 2 + 1]];
auto reg_n2___n_name = n2___n_name[BUF_591de8441dd0[slot_second591de8441dd0 * 3 + 1]];
if (!((((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) && (true))) return;
uint64_t KEY_591de83e4300 = 0;
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_lineitem__l_shipdate);

KEY_591de83e4300 |= reg_map0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_591de83e4300 = HT_591de83e4300.find(KEY_591de83e4300)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_591de83e4300], reg_map0__tmp_attr1);
KEY_591de83e4300map0__tmp_attr0[buf_idx_591de83e4300] = reg_map0__tmp_attr0;
});
});
}
__global__ void count_591de8460c40(size_t COUNT591de83e4300, uint64_t* COUNT591de840aac0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT591de83e4300) return;
//Materialize count
atomicAdd((int*)COUNT591de840aac0, 1);
}
__global__ void main_591de8460c40(size_t COUNT591de83e4300, DBDecimalType* MAT591de840aac0aggr0__tmp_attr2, DBI64Type* MAT591de840aac0map0__tmp_attr0, uint64_t* MAT_IDX591de840aac0, DBDecimalType* aggr0__tmp_attr2, DBI64Type* map0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT591de83e4300) return;
//Materialize buffers
auto mat_idx591de840aac0 = atomicAdd((int*)MAT_IDX591de840aac0, 1);
auto reg_map0__tmp_attr0 = map0__tmp_attr0[tid];
MAT591de840aac0map0__tmp_attr0[mat_idx591de840aac0] = reg_map0__tmp_attr0;
auto reg_aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
MAT591de840aac0aggr0__tmp_attr2[mat_idx591de840aac0] = reg_aggr0__tmp_attr2;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT591de8429310;
cudaMalloc(&d_COUNT591de8429310, sizeof(uint64_t));
cudaMemset(d_COUNT591de8429310, 0, sizeof(uint64_t));
count_591de844c170<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT591de8429310, d_nation__n_name, nation_size);
uint64_t COUNT591de8429310;
cudaMemcpy(&COUNT591de8429310, d_COUNT591de8429310, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT591de8429310);
// Insert hash table control;
uint64_t* d_BUF_IDX_591de8429310;
cudaMalloc(&d_BUF_IDX_591de8429310, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_591de8429310, 0, sizeof(uint64_t));
uint64_t* d_BUF_591de8429310;
cudaMalloc(&d_BUF_591de8429310, sizeof(uint64_t) * COUNT591de8429310 * 1);
auto d_HT_591de8429310 = cuco::experimental::static_multimap{ (int)COUNT591de8429310*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_591de844c170<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_591de8429310, d_BUF_IDX_591de8429310, d_HT_591de8429310.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
cudaFree(d_BUF_IDX_591de8429310);
//Materialize count
uint64_t* d_COUNT591de8440c60;
cudaMalloc(&d_COUNT591de8440c60, sizeof(uint64_t));
cudaMemset(d_COUNT591de8440c60, 0, sizeof(uint64_t));
count_591de844f3c0<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT591de8440c60, d_nation__n_name, nation_size);
uint64_t COUNT591de8440c60;
cudaMemcpy(&COUNT591de8440c60, d_COUNT591de8440c60, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT591de8440c60);
// Insert hash table control;
uint64_t* d_BUF_IDX_591de8440c60;
cudaMalloc(&d_BUF_IDX_591de8440c60, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_591de8440c60, 0, sizeof(uint64_t));
uint64_t* d_BUF_591de8440c60;
cudaMalloc(&d_BUF_591de8440c60, sizeof(uint64_t) * COUNT591de8440c60 * 1);
auto d_HT_591de8440c60 = cuco::experimental::static_multimap{ (int)COUNT591de8440c60*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_591de844f3c0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_591de8440c60, d_BUF_IDX_591de8440c60, d_HT_591de8440c60.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
cudaFree(d_BUF_IDX_591de8440c60);
//Materialize count
uint64_t* d_COUNT591de843d4e0;
cudaMalloc(&d_COUNT591de843d4e0, sizeof(uint64_t));
cudaMemset(d_COUNT591de843d4e0, 0, sizeof(uint64_t));
count_591de8450320<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_591de8440c60, d_COUNT591de843d4e0, d_HT_591de8440c60.ref(cuco::for_each), d_customer__c_nationkey, customer_size);
uint64_t COUNT591de843d4e0;
cudaMemcpy(&COUNT591de843d4e0, d_COUNT591de843d4e0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT591de843d4e0);
// Insert hash table control;
uint64_t* d_BUF_IDX_591de843d4e0;
cudaMalloc(&d_BUF_IDX_591de843d4e0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_591de843d4e0, 0, sizeof(uint64_t));
uint64_t* d_BUF_591de843d4e0;
cudaMalloc(&d_BUF_591de843d4e0, sizeof(uint64_t) * COUNT591de843d4e0 * 2);
auto d_HT_591de843d4e0 = cuco::experimental::static_multimap{ (int)COUNT591de843d4e0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_591de8450320<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_591de843d4e0, d_BUF_591de8440c60, d_BUF_IDX_591de843d4e0, d_HT_591de843d4e0.ref(cuco::insert), d_HT_591de8440c60.ref(cuco::for_each), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
cudaFree(d_BUF_IDX_591de843d4e0);
//Materialize count
uint64_t* d_COUNT591de8441dd0;
cudaMalloc(&d_COUNT591de8441dd0, sizeof(uint64_t));
cudaMemset(d_COUNT591de8441dd0, 0, sizeof(uint64_t));
count_591de844ad20<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_591de843d4e0, d_COUNT591de8441dd0, d_HT_591de843d4e0.ref(cuco::for_each), d_orders__o_custkey, orders_size);
uint64_t COUNT591de8441dd0;
cudaMemcpy(&COUNT591de8441dd0, d_COUNT591de8441dd0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT591de8441dd0);
// Insert hash table control;
uint64_t* d_BUF_IDX_591de8441dd0;
cudaMalloc(&d_BUF_IDX_591de8441dd0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_591de8441dd0, 0, sizeof(uint64_t));
uint64_t* d_BUF_591de8441dd0;
cudaMalloc(&d_BUF_591de8441dd0, sizeof(uint64_t) * COUNT591de8441dd0 * 3);
auto d_HT_591de8441dd0 = cuco::experimental::static_multimap{ (int)COUNT591de8441dd0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_591de844ad20<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_591de843d4e0, d_BUF_591de8441dd0, d_BUF_IDX_591de8441dd0, d_HT_591de843d4e0.ref(cuco::for_each), d_HT_591de8441dd0.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderkey, orders_size);
cudaFree(d_BUF_IDX_591de8441dd0);
//Materialize count
uint64_t* d_COUNT591de8441ee0;
cudaMalloc(&d_COUNT591de8441ee0, sizeof(uint64_t));
cudaMemset(d_COUNT591de8441ee0, 0, sizeof(uint64_t));
count_591de83412c0<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_591de8429310, d_COUNT591de8441ee0, d_HT_591de8429310.ref(cuco::for_each), d_supplier__s_nationkey, supplier_size);
uint64_t COUNT591de8441ee0;
cudaMemcpy(&COUNT591de8441ee0, d_COUNT591de8441ee0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT591de8441ee0);
// Insert hash table control;
uint64_t* d_BUF_IDX_591de8441ee0;
cudaMalloc(&d_BUF_IDX_591de8441ee0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_591de8441ee0, 0, sizeof(uint64_t));
uint64_t* d_BUF_591de8441ee0;
cudaMalloc(&d_BUF_591de8441ee0, sizeof(uint64_t) * COUNT591de8441ee0 * 2);
auto d_HT_591de8441ee0 = cuco::experimental::static_multimap{ (int)COUNT591de8441ee0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_591de83412c0<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_591de8429310, d_BUF_591de8441ee0, d_BUF_IDX_591de8441ee0, d_HT_591de8429310.ref(cuco::for_each), d_HT_591de8441ee0.ref(cuco::insert), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
cudaFree(d_BUF_IDX_591de8441ee0);
//Create aggregation hash table
auto d_HT_591de83e4300 = cuco::static_map{ (int)13634*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_591de83c4880<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_591de8441dd0, d_BUF_591de8441ee0, d_HT_591de83e4300.ref(cuco::insert), d_HT_591de8441dd0.ref(cuco::for_each), d_HT_591de8441ee0.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name);
size_t COUNT591de83e4300 = d_HT_591de83e4300.size();
thrust::device_vector<int64_t> keys_591de83e4300(COUNT591de83e4300), vals_591de83e4300(COUNT591de83e4300);
d_HT_591de83e4300.retrieve_all(keys_591de83e4300.begin(), vals_591de83e4300.begin());
thrust::host_vector<int64_t> h_keys_591de83e4300(COUNT591de83e4300);
thrust::copy(keys_591de83e4300.begin(), keys_591de83e4300.end(), h_keys_591de83e4300.begin());
thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_591de83e4300(COUNT591de83e4300);
for (int i=0; i < COUNT591de83e4300; i++)
{actual_dict_591de83e4300[i] = cuco::make_pair(h_keys_591de83e4300[i], i);}
d_HT_591de83e4300.clear();
d_HT_591de83e4300.insert(actual_dict_591de83e4300.begin(), actual_dict_591de83e4300.end());
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT591de83e4300);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT591de83e4300);
DBI64Type* d_KEY_591de83e4300map0__tmp_attr0;
cudaMalloc(&d_KEY_591de83e4300map0__tmp_attr0, sizeof(DBI64Type) * COUNT591de83e4300);
cudaMemset(d_KEY_591de83e4300map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT591de83e4300);
main_591de83c4880<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_591de8441dd0, d_BUF_591de8441ee0, d_HT_591de83e4300.ref(cuco::find), d_HT_591de8441dd0.ref(cuco::for_each), d_HT_591de8441ee0.ref(cuco::for_each), d_KEY_591de83e4300map0__tmp_attr0, d_aggr0__tmp_attr2, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name);
//Materialize count
uint64_t* d_COUNT591de840aac0;
cudaMalloc(&d_COUNT591de840aac0, sizeof(uint64_t));
cudaMemset(d_COUNT591de840aac0, 0, sizeof(uint64_t));
count_591de8460c40<<<std::ceil((float)COUNT591de83e4300/32.), 32>>>(COUNT591de83e4300, d_COUNT591de840aac0);
uint64_t COUNT591de840aac0;
cudaMemcpy(&COUNT591de840aac0, d_COUNT591de840aac0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT591de840aac0);
//Materialize buffers
uint64_t* d_MAT_IDX591de840aac0;
cudaMalloc(&d_MAT_IDX591de840aac0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX591de840aac0, 0, sizeof(uint64_t));
auto MAT591de840aac0map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT591de840aac0);
DBI64Type* d_MAT591de840aac0map0__tmp_attr0;
cudaMalloc(&d_MAT591de840aac0map0__tmp_attr0, sizeof(DBI64Type) * COUNT591de840aac0);
auto MAT591de840aac0aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT591de840aac0);
DBDecimalType* d_MAT591de840aac0aggr0__tmp_attr2;
cudaMalloc(&d_MAT591de840aac0aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT591de840aac0);
main_591de8460c40<<<std::ceil((float)COUNT591de83e4300/32.), 32>>>(COUNT591de83e4300, d_MAT591de840aac0aggr0__tmp_attr2, d_MAT591de840aac0map0__tmp_attr0, d_MAT_IDX591de840aac0, d_aggr0__tmp_attr2, d_KEY_591de83e4300map0__tmp_attr0);
cudaFree(d_MAT_IDX591de840aac0);
cudaMemcpy(MAT591de840aac0map0__tmp_attr0, d_MAT591de840aac0map0__tmp_attr0, sizeof(DBI64Type) * COUNT591de840aac0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT591de840aac0aggr0__tmp_attr2, d_MAT591de840aac0aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT591de840aac0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT591de840aac0; i++) { std::cout << MAT591de840aac0map0__tmp_attr0[i] << "\t";
std::cout << MAT591de840aac0aggr0__tmp_attr2[i] << "\t";
std::cout << std::endl; }
}