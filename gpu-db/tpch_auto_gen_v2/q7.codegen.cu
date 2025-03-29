#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_593adbb43030(uint64_t* COUNT593adbb34a00, DBStringType* n1___n_name, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n1___n_name = n1___n_name[tid];
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
//Materialize count
atomicAdd((int*)COUNT593adbb34a00, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_593adbb43030(uint64_t* BUF_593adbb34a00, uint64_t* BUF_IDX_593adbb34a00, HASHTABLE_INSERT HT_593adbb34a00, DBStringType* n1___n_name, DBI32Type* n1___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n1___n_name = n1___n_name[tid];
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
uint64_t KEY_593adbb34a00 = 0;
auto reg_n1___n_nationkey = n1___n_nationkey[tid];

KEY_593adbb34a00 |= reg_n1___n_nationkey;
// Insert hash table kernel;
auto buf_idx_593adbb34a00 = atomicAdd((int*)BUF_IDX_593adbb34a00, 1);
HT_593adbb34a00.insert(cuco::pair{KEY_593adbb34a00, buf_idx_593adbb34a00});
BUF_593adbb34a00[buf_idx_593adbb34a00 * 1 + 0] = tid;
}
__global__ void count_593adbb46470(uint64_t* COUNT593adbb35d50, DBStringType* n2___n_name, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n2___n_name = n2___n_name[tid];
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
//Materialize count
atomicAdd((int*)COUNT593adbb35d50, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_593adbb46470(uint64_t* BUF_593adbb35d50, uint64_t* BUF_IDX_593adbb35d50, HASHTABLE_INSERT HT_593adbb35d50, DBStringType* n2___n_name, DBI32Type* n2___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n2___n_name = n2___n_name[tid];
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
uint64_t KEY_593adbb35d50 = 0;
auto reg_n2___n_nationkey = n2___n_nationkey[tid];

KEY_593adbb35d50 |= reg_n2___n_nationkey;
// Insert hash table kernel;
auto buf_idx_593adbb35d50 = atomicAdd((int*)BUF_IDX_593adbb35d50, 1);
HT_593adbb35d50.insert(cuco::pair{KEY_593adbb35d50, buf_idx_593adbb35d50});
BUF_593adbb35d50[buf_idx_593adbb35d50 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_593adbb47430(uint64_t* BUF_593adbb35d50, uint64_t* COUNT593adbb34fe0, HASHTABLE_PROBE HT_593adbb35d50, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_593adbb35d50 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_593adbb35d50 |= reg_customer__c_nationkey;
//Probe Hash table
HT_593adbb35d50.for_each(KEY_593adbb35d50, [&] __device__ (auto const SLOT_593adbb35d50) {

auto const [slot_first593adbb35d50, slot_second593adbb35d50] = SLOT_593adbb35d50;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT593adbb34fe0, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_593adbb47430(uint64_t* BUF_593adbb34fe0, uint64_t* BUF_593adbb35d50, uint64_t* BUF_IDX_593adbb34fe0, HASHTABLE_INSERT HT_593adbb34fe0, HASHTABLE_PROBE HT_593adbb35d50, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_593adbb35d50 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_593adbb35d50 |= reg_customer__c_nationkey;
//Probe Hash table
HT_593adbb35d50.for_each(KEY_593adbb35d50, [&] __device__ (auto const SLOT_593adbb35d50) {
auto const [slot_first593adbb35d50, slot_second593adbb35d50] = SLOT_593adbb35d50;
if (!(true)) return;
uint64_t KEY_593adbb34fe0 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_593adbb34fe0 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_593adbb34fe0 = atomicAdd((int*)BUF_IDX_593adbb34fe0, 1);
HT_593adbb34fe0.insert(cuco::pair{KEY_593adbb34fe0, buf_idx_593adbb34fe0});
BUF_593adbb34fe0[buf_idx_593adbb34fe0 * 2 + 0] = BUF_593adbb35d50[slot_second593adbb35d50 * 1 + 0];
BUF_593adbb34fe0[buf_idx_593adbb34fe0 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_593adbb419a0(uint64_t* BUF_593adbb34fe0, uint64_t* COUNT593adbb36fd0, HASHTABLE_PROBE HT_593adbb34fe0, DBI32Type* orders__o_custkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_593adbb34fe0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_593adbb34fe0 |= reg_orders__o_custkey;
//Probe Hash table
HT_593adbb34fe0.for_each(KEY_593adbb34fe0, [&] __device__ (auto const SLOT_593adbb34fe0) {

auto const [slot_first593adbb34fe0, slot_second593adbb34fe0] = SLOT_593adbb34fe0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT593adbb36fd0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_593adbb419a0(uint64_t* BUF_593adbb34fe0, uint64_t* BUF_593adbb36fd0, uint64_t* BUF_IDX_593adbb36fd0, HASHTABLE_PROBE HT_593adbb34fe0, HASHTABLE_INSERT HT_593adbb36fd0, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_593adbb34fe0 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_593adbb34fe0 |= reg_orders__o_custkey;
//Probe Hash table
HT_593adbb34fe0.for_each(KEY_593adbb34fe0, [&] __device__ (auto const SLOT_593adbb34fe0) {
auto const [slot_first593adbb34fe0, slot_second593adbb34fe0] = SLOT_593adbb34fe0;
if (!(true)) return;
uint64_t KEY_593adbb36fd0 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_593adbb36fd0 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_593adbb36fd0 = atomicAdd((int*)BUF_IDX_593adbb36fd0, 1);
HT_593adbb36fd0.insert(cuco::pair{KEY_593adbb36fd0, buf_idx_593adbb36fd0});
BUF_593adbb36fd0[buf_idx_593adbb36fd0 * 3 + 0] = tid;
BUF_593adbb36fd0[buf_idx_593adbb36fd0 * 3 + 1] = BUF_593adbb34fe0[slot_second593adbb34fe0 * 2 + 0];
BUF_593adbb36fd0[buf_idx_593adbb36fd0 * 3 + 2] = BUF_593adbb34fe0[slot_second593adbb34fe0 * 2 + 1];
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_593adbb1fa30(uint64_t* BUF_593adbb34a00, uint64_t* COUNT593adbb370e0, HASHTABLE_PROBE HT_593adbb34a00, DBI32Type* supplier__s_nationkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_593adbb34a00 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_593adbb34a00 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_593adbb34a00.for_each(KEY_593adbb34a00, [&] __device__ (auto const SLOT_593adbb34a00) {

auto const [slot_first593adbb34a00, slot_second593adbb34a00] = SLOT_593adbb34a00;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT593adbb370e0, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_593adbb1fa30(uint64_t* BUF_593adbb34a00, uint64_t* BUF_593adbb370e0, uint64_t* BUF_IDX_593adbb370e0, HASHTABLE_PROBE HT_593adbb34a00, HASHTABLE_INSERT HT_593adbb370e0, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_593adbb34a00 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_593adbb34a00 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_593adbb34a00.for_each(KEY_593adbb34a00, [&] __device__ (auto const SLOT_593adbb34a00) {
auto const [slot_first593adbb34a00, slot_second593adbb34a00] = SLOT_593adbb34a00;
if (!(true)) return;
uint64_t KEY_593adbb370e0 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_593adbb370e0 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_593adbb370e0 = atomicAdd((int*)BUF_IDX_593adbb370e0, 1);
HT_593adbb370e0.insert(cuco::pair{KEY_593adbb370e0, buf_idx_593adbb370e0});
BUF_593adbb370e0[buf_idx_593adbb370e0 * 2 + 0] = tid;
BUF_593adbb370e0[buf_idx_593adbb370e0 * 2 + 1] = BUF_593adbb34a00[slot_second593adbb34a00 * 1 + 0];
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_593adbb20000(uint64_t* BUF_593adbb36fd0, uint64_t* BUF_593adbb370e0, HASHTABLE_INSERT HT_593adbaee6e0, HASHTABLE_PROBE HT_593adbb36fd0, HASHTABLE_PROBE HT_593adbb370e0, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBStringType* n2___n_name) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9861, Predicate::lte))) return;
uint64_t KEY_593adbb36fd0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_593adbb36fd0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_593adbb36fd0.for_each(KEY_593adbb36fd0, [&] __device__ (auto const SLOT_593adbb36fd0) {

auto const [slot_first593adbb36fd0, slot_second593adbb36fd0] = SLOT_593adbb36fd0;
if (!(true)) return;
uint64_t KEY_593adbb370e0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_593adbb370e0 |= reg_lineitem__l_suppkey;
//Probe Hash table
HT_593adbb370e0.for_each(KEY_593adbb370e0, [&] __device__ (auto const SLOT_593adbb370e0) {

auto const [slot_first593adbb370e0, slot_second593adbb370e0] = SLOT_593adbb370e0;
auto reg_n1___n_name = n1___n_name[BUF_593adbb370e0[slot_second593adbb370e0 * 2 + 1]];
auto reg_n2___n_name = n2___n_name[BUF_593adbb36fd0[slot_second593adbb36fd0 * 3 + 1]];
if (!((((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) && (true))) return;
uint64_t KEY_593adbaee6e0 = 0;
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_lineitem__l_shipdate);

KEY_593adbaee6e0 |= reg_map0__tmp_attr0;
//Create aggregation hash table
HT_593adbaee6e0.insert(cuco::pair{KEY_593adbaee6e0, 1});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_593adbb20000(uint64_t* BUF_593adbb36fd0, uint64_t* BUF_593adbb370e0, HASHTABLE_FIND HT_593adbaee6e0, HASHTABLE_PROBE HT_593adbb36fd0, HASHTABLE_PROBE HT_593adbb370e0, DBI64Type* KEY_593adbaee6e0map0__tmp_attr0, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBStringType* n2___n_name) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9861, Predicate::lte))) return;
uint64_t KEY_593adbb36fd0 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_593adbb36fd0 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_593adbb36fd0.for_each(KEY_593adbb36fd0, [&] __device__ (auto const SLOT_593adbb36fd0) {
auto const [slot_first593adbb36fd0, slot_second593adbb36fd0] = SLOT_593adbb36fd0;
if (!(true)) return;
uint64_t KEY_593adbb370e0 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_593adbb370e0 |= reg_lineitem__l_suppkey;
//Probe Hash table
HT_593adbb370e0.for_each(KEY_593adbb370e0, [&] __device__ (auto const SLOT_593adbb370e0) {
auto const [slot_first593adbb370e0, slot_second593adbb370e0] = SLOT_593adbb370e0;
auto reg_n1___n_name = n1___n_name[BUF_593adbb370e0[slot_second593adbb370e0 * 2 + 1]];
auto reg_n2___n_name = n2___n_name[BUF_593adbb36fd0[slot_second593adbb36fd0 * 3 + 1]];
if (!((((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) && (true))) return;
uint64_t KEY_593adbaee6e0 = 0;
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_lineitem__l_shipdate);

KEY_593adbaee6e0 |= reg_map0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_593adbaee6e0 = HT_593adbaee6e0.find(KEY_593adbaee6e0)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_593adbaee6e0], reg_map0__tmp_attr1);
KEY_593adbaee6e0map0__tmp_attr0[buf_idx_593adbaee6e0] = reg_map0__tmp_attr0;
});
});
}
__global__ void count_593adbb57100(size_t COUNT593adbaee6e0, uint64_t* COUNT593adbb01dc0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT593adbaee6e0) return;
//Materialize count
atomicAdd((int*)COUNT593adbb01dc0, 1);
}
__global__ void main_593adbb57100(size_t COUNT593adbaee6e0, DBDecimalType* MAT593adbb01dc0aggr0__tmp_attr2, DBI64Type* MAT593adbb01dc0map0__tmp_attr0, uint64_t* MAT_IDX593adbb01dc0, DBDecimalType* aggr0__tmp_attr2, DBI64Type* map0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT593adbaee6e0) return;
//Materialize buffers
auto mat_idx593adbb01dc0 = atomicAdd((int*)MAT_IDX593adbb01dc0, 1);
auto reg_map0__tmp_attr0 = map0__tmp_attr0[tid];
MAT593adbb01dc0map0__tmp_attr0[mat_idx593adbb01dc0] = reg_map0__tmp_attr0;
auto reg_aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
MAT593adbb01dc0aggr0__tmp_attr2[mat_idx593adbb01dc0] = reg_aggr0__tmp_attr2;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT593adbb34a00;
cudaMalloc(&d_COUNT593adbb34a00, sizeof(uint64_t));
cudaMemset(d_COUNT593adbb34a00, 0, sizeof(uint64_t));
count_593adbb43030<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT593adbb34a00, d_nation__n_name, nation_size);
uint64_t COUNT593adbb34a00;
cudaMemcpy(&COUNT593adbb34a00, d_COUNT593adbb34a00, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_593adbb34a00;
cudaMalloc(&d_BUF_IDX_593adbb34a00, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_593adbb34a00, 0, sizeof(uint64_t));
uint64_t* d_BUF_593adbb34a00;
cudaMalloc(&d_BUF_593adbb34a00, sizeof(uint64_t) * COUNT593adbb34a00 * 1);
auto d_HT_593adbb34a00 = cuco::experimental::static_multimap{ (int)COUNT593adbb34a00*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_593adbb43030<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_593adbb34a00, d_BUF_IDX_593adbb34a00, d_HT_593adbb34a00.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
//Materialize count
uint64_t* d_COUNT593adbb35d50;
cudaMalloc(&d_COUNT593adbb35d50, sizeof(uint64_t));
cudaMemset(d_COUNT593adbb35d50, 0, sizeof(uint64_t));
count_593adbb46470<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT593adbb35d50, d_nation__n_name, nation_size);
uint64_t COUNT593adbb35d50;
cudaMemcpy(&COUNT593adbb35d50, d_COUNT593adbb35d50, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_593adbb35d50;
cudaMalloc(&d_BUF_IDX_593adbb35d50, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_593adbb35d50, 0, sizeof(uint64_t));
uint64_t* d_BUF_593adbb35d50;
cudaMalloc(&d_BUF_593adbb35d50, sizeof(uint64_t) * COUNT593adbb35d50 * 1);
auto d_HT_593adbb35d50 = cuco::experimental::static_multimap{ (int)COUNT593adbb35d50*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_593adbb46470<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_593adbb35d50, d_BUF_IDX_593adbb35d50, d_HT_593adbb35d50.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
//Materialize count
uint64_t* d_COUNT593adbb34fe0;
cudaMalloc(&d_COUNT593adbb34fe0, sizeof(uint64_t));
cudaMemset(d_COUNT593adbb34fe0, 0, sizeof(uint64_t));
count_593adbb47430<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_593adbb35d50, d_COUNT593adbb34fe0, d_HT_593adbb35d50.ref(cuco::for_each), d_customer__c_nationkey, customer_size);
uint64_t COUNT593adbb34fe0;
cudaMemcpy(&COUNT593adbb34fe0, d_COUNT593adbb34fe0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_593adbb34fe0;
cudaMalloc(&d_BUF_IDX_593adbb34fe0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_593adbb34fe0, 0, sizeof(uint64_t));
uint64_t* d_BUF_593adbb34fe0;
cudaMalloc(&d_BUF_593adbb34fe0, sizeof(uint64_t) * COUNT593adbb34fe0 * 2);
auto d_HT_593adbb34fe0 = cuco::experimental::static_multimap{ (int)COUNT593adbb34fe0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_593adbb47430<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_593adbb34fe0, d_BUF_593adbb35d50, d_BUF_IDX_593adbb34fe0, d_HT_593adbb34fe0.ref(cuco::insert), d_HT_593adbb35d50.ref(cuco::for_each), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
//Materialize count
uint64_t* d_COUNT593adbb36fd0;
cudaMalloc(&d_COUNT593adbb36fd0, sizeof(uint64_t));
cudaMemset(d_COUNT593adbb36fd0, 0, sizeof(uint64_t));
count_593adbb419a0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_593adbb34fe0, d_COUNT593adbb36fd0, d_HT_593adbb34fe0.ref(cuco::for_each), d_orders__o_custkey, orders_size);
uint64_t COUNT593adbb36fd0;
cudaMemcpy(&COUNT593adbb36fd0, d_COUNT593adbb36fd0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_593adbb36fd0;
cudaMalloc(&d_BUF_IDX_593adbb36fd0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_593adbb36fd0, 0, sizeof(uint64_t));
uint64_t* d_BUF_593adbb36fd0;
cudaMalloc(&d_BUF_593adbb36fd0, sizeof(uint64_t) * COUNT593adbb36fd0 * 3);
auto d_HT_593adbb36fd0 = cuco::experimental::static_multimap{ (int)COUNT593adbb36fd0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_593adbb419a0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_593adbb34fe0, d_BUF_593adbb36fd0, d_BUF_IDX_593adbb36fd0, d_HT_593adbb34fe0.ref(cuco::for_each), d_HT_593adbb36fd0.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderkey, orders_size);
//Materialize count
uint64_t* d_COUNT593adbb370e0;
cudaMalloc(&d_COUNT593adbb370e0, sizeof(uint64_t));
cudaMemset(d_COUNT593adbb370e0, 0, sizeof(uint64_t));
count_593adbb1fa30<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_593adbb34a00, d_COUNT593adbb370e0, d_HT_593adbb34a00.ref(cuco::for_each), d_supplier__s_nationkey, supplier_size);
uint64_t COUNT593adbb370e0;
cudaMemcpy(&COUNT593adbb370e0, d_COUNT593adbb370e0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
// Insert hash table control;
uint64_t* d_BUF_IDX_593adbb370e0;
cudaMalloc(&d_BUF_IDX_593adbb370e0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_593adbb370e0, 0, sizeof(uint64_t));
uint64_t* d_BUF_593adbb370e0;
cudaMalloc(&d_BUF_593adbb370e0, sizeof(uint64_t) * COUNT593adbb370e0 * 2);
auto d_HT_593adbb370e0 = cuco::experimental::static_multimap{ (int)COUNT593adbb370e0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_593adbb1fa30<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_593adbb34a00, d_BUF_593adbb370e0, d_BUF_IDX_593adbb370e0, d_HT_593adbb34a00.ref(cuco::for_each), d_HT_593adbb370e0.ref(cuco::insert), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
//Create aggregation hash table
auto d_HT_593adbaee6e0 = cuco::static_map{ (int)13634*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_593adbb20000<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_593adbb36fd0, d_BUF_593adbb370e0, d_HT_593adbaee6e0.ref(cuco::insert), d_HT_593adbb36fd0.ref(cuco::for_each), d_HT_593adbb370e0.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name);
size_t COUNT593adbaee6e0 = d_HT_593adbaee6e0.size();
thrust::device_vector<int64_t> keys_593adbaee6e0(COUNT593adbaee6e0), vals_593adbaee6e0(COUNT593adbaee6e0);
d_HT_593adbaee6e0.retrieve_all(keys_593adbaee6e0.begin(), vals_593adbaee6e0.begin());
d_HT_593adbaee6e0.clear();
int64_t* raw_keys593adbaee6e0 = thrust::raw_pointer_cast(keys_593adbaee6e0.data());
insertKeys<<<std::ceil((float)COUNT593adbaee6e0/32.), 32>>>(raw_keys593adbaee6e0, d_HT_593adbaee6e0.ref(cuco::insert), COUNT593adbaee6e0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT593adbaee6e0);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT593adbaee6e0);
DBI64Type* d_KEY_593adbaee6e0map0__tmp_attr0;
cudaMalloc(&d_KEY_593adbaee6e0map0__tmp_attr0, sizeof(DBI64Type) * COUNT593adbaee6e0);
cudaMemset(d_KEY_593adbaee6e0map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT593adbaee6e0);
main_593adbb20000<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_593adbb36fd0, d_BUF_593adbb370e0, d_HT_593adbaee6e0.ref(cuco::find), d_HT_593adbb36fd0.ref(cuco::for_each), d_HT_593adbb370e0.ref(cuco::for_each), d_KEY_593adbaee6e0map0__tmp_attr0, d_aggr0__tmp_attr2, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name);
//Materialize count
uint64_t* d_COUNT593adbb01dc0;
cudaMalloc(&d_COUNT593adbb01dc0, sizeof(uint64_t));
cudaMemset(d_COUNT593adbb01dc0, 0, sizeof(uint64_t));
count_593adbb57100<<<std::ceil((float)COUNT593adbaee6e0/32.), 32>>>(COUNT593adbaee6e0, d_COUNT593adbb01dc0);
uint64_t COUNT593adbb01dc0;
cudaMemcpy(&COUNT593adbb01dc0, d_COUNT593adbb01dc0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
//Materialize buffers
uint64_t* d_MAT_IDX593adbb01dc0;
cudaMalloc(&d_MAT_IDX593adbb01dc0, sizeof(uint64_t));
cudaMemset(d_MAT_IDX593adbb01dc0, 0, sizeof(uint64_t));
auto MAT593adbb01dc0map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT593adbb01dc0);
DBI64Type* d_MAT593adbb01dc0map0__tmp_attr0;
cudaMalloc(&d_MAT593adbb01dc0map0__tmp_attr0, sizeof(DBI64Type) * COUNT593adbb01dc0);
auto MAT593adbb01dc0aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT593adbb01dc0);
DBDecimalType* d_MAT593adbb01dc0aggr0__tmp_attr2;
cudaMalloc(&d_MAT593adbb01dc0aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT593adbb01dc0);
main_593adbb57100<<<std::ceil((float)COUNT593adbaee6e0/32.), 32>>>(COUNT593adbaee6e0, d_MAT593adbb01dc0aggr0__tmp_attr2, d_MAT593adbb01dc0map0__tmp_attr0, d_MAT_IDX593adbb01dc0, d_aggr0__tmp_attr2, d_KEY_593adbaee6e0map0__tmp_attr0);
cudaMemcpy(MAT593adbb01dc0map0__tmp_attr0, d_MAT593adbb01dc0map0__tmp_attr0, sizeof(DBI64Type) * COUNT593adbb01dc0, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT593adbb01dc0aggr0__tmp_attr2, d_MAT593adbb01dc0aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT593adbb01dc0, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT593adbb01dc0; i++) { std::cout << MAT593adbb01dc0map0__tmp_attr0[i] << "\t";
std::cout << MAT593adbb01dc0aggr0__tmp_attr2[i] << "\t";
std::cout << std::endl; }
cudaFree(d_BUF_593adbb34a00);
cudaFree(d_BUF_IDX_593adbb34a00);
cudaFree(d_COUNT593adbb34a00);
cudaFree(d_BUF_593adbb35d50);
cudaFree(d_BUF_IDX_593adbb35d50);
cudaFree(d_COUNT593adbb35d50);
cudaFree(d_BUF_593adbb34fe0);
cudaFree(d_BUF_IDX_593adbb34fe0);
cudaFree(d_COUNT593adbb34fe0);
cudaFree(d_BUF_593adbb36fd0);
cudaFree(d_BUF_IDX_593adbb36fd0);
cudaFree(d_COUNT593adbb36fd0);
cudaFree(d_BUF_593adbb370e0);
cudaFree(d_BUF_IDX_593adbb370e0);
cudaFree(d_COUNT593adbb370e0);
cudaFree(d_KEY_593adbaee6e0map0__tmp_attr0);
cudaFree(d_aggr0__tmp_attr2);
cudaFree(d_COUNT593adbb01dc0);
cudaFree(d_MAT593adbb01dc0aggr0__tmp_attr2);
cudaFree(d_MAT593adbb01dc0map0__tmp_attr0);
cudaFree(d_MAT_IDX593adbb01dc0);
free(MAT593adbb01dc0aggr0__tmp_attr2);
free(MAT593adbb01dc0map0__tmp_attr0);
}