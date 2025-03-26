#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5b4bb43a76a0(uint64_t* COUNT5b4bb439aa50, DBStringType* n1___n_name, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n1___n_name = n1___n_name[tid];
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
//Materialize count
atomicAdd((int*)COUNT5b4bb439aa50, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5b4bb43a76a0(uint64_t* BUF_5b4bb439aa50, uint64_t* BUF_IDX_5b4bb439aa50, HASHTABLE_INSERT HT_5b4bb439aa50, DBStringType* n1___n_name, DBI32Type* n1___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n1___n_name = n1___n_name[tid];
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
uint64_t KEY_5b4bb439aa50 = 0;
auto reg_n1___n_nationkey = n1___n_nationkey[tid];

KEY_5b4bb439aa50 |= reg_n1___n_nationkey;
// Insert hash table kernel;
auto buf_idx_5b4bb439aa50 = atomicAdd((int*)BUF_IDX_5b4bb439aa50, 1);
HT_5b4bb439aa50.insert(cuco::pair{KEY_5b4bb439aa50, buf_idx_5b4bb439aa50});
BUF_5b4bb439aa50[buf_idx_5b4bb439aa50 * 1 + 0] = tid;
}
__global__ void count_5b4bb43aa820(uint64_t* COUNT5b4bb4399bf0, DBStringType* n2___n_name, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n2___n_name = n2___n_name[tid];
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
//Materialize count
atomicAdd((int*)COUNT5b4bb4399bf0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5b4bb43aa820(uint64_t* BUF_5b4bb4399bf0, uint64_t* BUF_IDX_5b4bb4399bf0, HASHTABLE_INSERT HT_5b4bb4399bf0, DBStringType* n2___n_name, DBI32Type* n2___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n2___n_name = n2___n_name[tid];
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
uint64_t KEY_5b4bb4399bf0 = 0;
auto reg_n2___n_nationkey = n2___n_nationkey[tid];

KEY_5b4bb4399bf0 |= reg_n2___n_nationkey;
// Insert hash table kernel;
auto buf_idx_5b4bb4399bf0 = atomicAdd((int*)BUF_IDX_5b4bb4399bf0, 1);
HT_5b4bb4399bf0.insert(cuco::pair{KEY_5b4bb4399bf0, buf_idx_5b4bb4399bf0});
BUF_5b4bb4399bf0[buf_idx_5b4bb4399bf0 * 1 + 0] = tid;
}
template<typename HASHTABLE_PROBE>
__global__ void count_5b4bb43ab780(uint64_t* BUF_5b4bb4399bf0, uint64_t* COUNT5b4bb4398620, HASHTABLE_PROBE HT_5b4bb4399bf0, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_5b4bb4399bf0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_5b4bb4399bf0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_5b4bb4399bf0.for_each(KEY_5b4bb4399bf0, [&] __device__ (auto const SLOT_5b4bb4399bf0) {

auto const [slot_first5b4bb4399bf0, slot_second5b4bb4399bf0] = SLOT_5b4bb4399bf0;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5b4bb4398620, 1);
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void main_5b4bb43ab780(uint64_t* BUF_5b4bb4398620, uint64_t* BUF_5b4bb4399bf0, uint64_t* BUF_IDX_5b4bb4398620, HASHTABLE_INSERT HT_5b4bb4398620, HASHTABLE_PROBE HT_5b4bb4399bf0, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_5b4bb4399bf0 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];

KEY_5b4bb4399bf0 |= reg_customer__c_nationkey;
//Probe Hash table
HT_5b4bb4399bf0.for_each(KEY_5b4bb4399bf0, [&] __device__ (auto const SLOT_5b4bb4399bf0) {
auto const [slot_first5b4bb4399bf0, slot_second5b4bb4399bf0] = SLOT_5b4bb4399bf0;
if (!(true)) return;
uint64_t KEY_5b4bb4398620 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];

KEY_5b4bb4398620 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_5b4bb4398620 = atomicAdd((int*)BUF_IDX_5b4bb4398620, 1);
HT_5b4bb4398620.insert(cuco::pair{KEY_5b4bb4398620, buf_idx_5b4bb4398620});
BUF_5b4bb4398620[buf_idx_5b4bb4398620 * 2 + 0] = BUF_5b4bb4399bf0[slot_second5b4bb4399bf0 * 1 + 0];
BUF_5b4bb4398620[buf_idx_5b4bb4398620 * 2 + 1] = tid;
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_5b4bb43a6160(uint64_t* BUF_5b4bb4398620, uint64_t* COUNT5b4bb4398d20, HASHTABLE_PROBE HT_5b4bb4398620, DBI32Type* orders__o_custkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_5b4bb4398620 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_5b4bb4398620 |= reg_orders__o_custkey;
//Probe Hash table
HT_5b4bb4398620.for_each(KEY_5b4bb4398620, [&] __device__ (auto const SLOT_5b4bb4398620) {

auto const [slot_first5b4bb4398620, slot_second5b4bb4398620] = SLOT_5b4bb4398620;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5b4bb4398d20, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5b4bb43a6160(uint64_t* BUF_5b4bb4398620, uint64_t* BUF_5b4bb4398d20, uint64_t* BUF_IDX_5b4bb4398d20, HASHTABLE_PROBE HT_5b4bb4398620, HASHTABLE_INSERT HT_5b4bb4398d20, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_5b4bb4398620 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];

KEY_5b4bb4398620 |= reg_orders__o_custkey;
//Probe Hash table
HT_5b4bb4398620.for_each(KEY_5b4bb4398620, [&] __device__ (auto const SLOT_5b4bb4398620) {
auto const [slot_first5b4bb4398620, slot_second5b4bb4398620] = SLOT_5b4bb4398620;
if (!(true)) return;
uint64_t KEY_5b4bb4398d20 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];

KEY_5b4bb4398d20 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_5b4bb4398d20 = atomicAdd((int*)BUF_IDX_5b4bb4398d20, 1);
HT_5b4bb4398d20.insert(cuco::pair{KEY_5b4bb4398d20, buf_idx_5b4bb4398d20});
BUF_5b4bb4398d20[buf_idx_5b4bb4398d20 * 3 + 0] = tid;
BUF_5b4bb4398d20[buf_idx_5b4bb4398d20 * 3 + 1] = BUF_5b4bb4398620[slot_second5b4bb4398620 * 2 + 0];
BUF_5b4bb4398d20[buf_idx_5b4bb4398d20 * 3 + 2] = BUF_5b4bb4398620[slot_second5b4bb4398620 * 2 + 1];
});
}
template<typename HASHTABLE_PROBE>
__global__ void count_5b4bb429c2c0(uint64_t* BUF_5b4bb439aa50, uint64_t* COUNT5b4bb439b720, HASHTABLE_PROBE HT_5b4bb439aa50, DBI32Type* supplier__s_nationkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_5b4bb439aa50 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_5b4bb439aa50 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_5b4bb439aa50.for_each(KEY_5b4bb439aa50, [&] __device__ (auto const SLOT_5b4bb439aa50) {

auto const [slot_first5b4bb439aa50, slot_second5b4bb439aa50] = SLOT_5b4bb439aa50;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5b4bb439b720, 1);
});
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_INSERT>
__global__ void main_5b4bb429c2c0(uint64_t* BUF_5b4bb439aa50, uint64_t* BUF_5b4bb439b720, uint64_t* BUF_IDX_5b4bb439b720, HASHTABLE_PROBE HT_5b4bb439aa50, HASHTABLE_INSERT HT_5b4bb439b720, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_5b4bb439aa50 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];

KEY_5b4bb439aa50 |= reg_supplier__s_nationkey;
//Probe Hash table
HT_5b4bb439aa50.for_each(KEY_5b4bb439aa50, [&] __device__ (auto const SLOT_5b4bb439aa50) {
auto const [slot_first5b4bb439aa50, slot_second5b4bb439aa50] = SLOT_5b4bb439aa50;
if (!(true)) return;
uint64_t KEY_5b4bb439b720 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];

KEY_5b4bb439b720 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5b4bb439b720 = atomicAdd((int*)BUF_IDX_5b4bb439b720, 1);
HT_5b4bb439b720.insert(cuco::pair{KEY_5b4bb439b720, buf_idx_5b4bb439b720});
BUF_5b4bb439b720[buf_idx_5b4bb439b720 * 2 + 0] = tid;
BUF_5b4bb439b720[buf_idx_5b4bb439b720 * 2 + 1] = BUF_5b4bb439aa50[slot_second5b4bb439aa50 * 1 + 0];
});
}
template<typename HASHTABLE_INSERT, typename HASHTABLE_PROBE>
__global__ void count_5b4bb431f8f0(uint64_t* BUF_5b4bb4398d20, uint64_t* BUF_5b4bb439b720, HASHTABLE_INSERT HT_5b4bb43527f0, HASHTABLE_PROBE HT_5b4bb4398d20, HASHTABLE_PROBE HT_5b4bb439b720, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBStringType* n2___n_name) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9861, Predicate::lte))) return;
uint64_t KEY_5b4bb4398d20 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5b4bb4398d20 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5b4bb4398d20.for_each(KEY_5b4bb4398d20, [&] __device__ (auto const SLOT_5b4bb4398d20) {

auto const [slot_first5b4bb4398d20, slot_second5b4bb4398d20] = SLOT_5b4bb4398d20;
if (!(true)) return;
uint64_t KEY_5b4bb439b720 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_5b4bb439b720 |= reg_lineitem__l_suppkey;
//Probe Hash table
HT_5b4bb439b720.for_each(KEY_5b4bb439b720, [&] __device__ (auto const SLOT_5b4bb439b720) {

auto const [slot_first5b4bb439b720, slot_second5b4bb439b720] = SLOT_5b4bb439b720;
auto reg_n1___n_name = n1___n_name[BUF_5b4bb439b720[slot_second5b4bb439b720 * 2 + 1]];
auto reg_n2___n_name = n2___n_name[BUF_5b4bb4398d20[slot_second5b4bb4398d20 * 3 + 1]];
if (!((((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) && (true))) return;
uint64_t KEY_5b4bb43527f0 = 0;
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_lineitem__l_shipdate);

KEY_5b4bb43527f0 |= reg_map0__tmp_attr0;
//Create aggregation hash table
HT_5b4bb43527f0.insert(cuco::pair{KEY_5b4bb43527f0, 1});
});
});
}
template<typename HASHTABLE_FIND, typename HASHTABLE_PROBE>
__global__ void main_5b4bb431f8f0(uint64_t* BUF_5b4bb4398d20, uint64_t* BUF_5b4bb439b720, HASHTABLE_FIND HT_5b4bb43527f0, HASHTABLE_PROBE HT_5b4bb4398d20, HASHTABLE_PROBE HT_5b4bb439b720, DBI64Type* KEY_5b4bb43527f0map0__tmp_attr0, DBDecimalType* aggr0__tmp_attr2, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBStringType* n2___n_name) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9861, Predicate::lte))) return;
uint64_t KEY_5b4bb4398d20 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];

KEY_5b4bb4398d20 |= reg_lineitem__l_orderkey;
//Probe Hash table
HT_5b4bb4398d20.for_each(KEY_5b4bb4398d20, [&] __device__ (auto const SLOT_5b4bb4398d20) {
auto const [slot_first5b4bb4398d20, slot_second5b4bb4398d20] = SLOT_5b4bb4398d20;
if (!(true)) return;
uint64_t KEY_5b4bb439b720 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];

KEY_5b4bb439b720 |= reg_lineitem__l_suppkey;
//Probe Hash table
HT_5b4bb439b720.for_each(KEY_5b4bb439b720, [&] __device__ (auto const SLOT_5b4bb439b720) {
auto const [slot_first5b4bb439b720, slot_second5b4bb439b720] = SLOT_5b4bb439b720;
auto reg_n1___n_name = n1___n_name[BUF_5b4bb439b720[slot_second5b4bb439b720 * 2 + 1]];
auto reg_n2___n_name = n2___n_name[BUF_5b4bb4398d20[slot_second5b4bb4398d20 * 3 + 1]];
if (!((((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) && (true))) return;
uint64_t KEY_5b4bb43527f0 = 0;
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_lineitem__l_shipdate);

KEY_5b4bb43527f0 |= reg_map0__tmp_attr0;
//Aggregate in hashtable
auto buf_idx_5b4bb43527f0 = HT_5b4bb43527f0.find(KEY_5b4bb43527f0)->second;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
aggregate_sum(&aggr0__tmp_attr2[buf_idx_5b4bb43527f0], reg_map0__tmp_attr1);
KEY_5b4bb43527f0map0__tmp_attr0[buf_idx_5b4bb43527f0] = reg_map0__tmp_attr0;
});
});
}
__global__ void count_5b4bb43bbcf0(size_t COUNT5b4bb43527f0, uint64_t* COUNT5b4bb4365600) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5b4bb43527f0) return;
//Materialize count
atomicAdd((int*)COUNT5b4bb4365600, 1);
}
__global__ void main_5b4bb43bbcf0(size_t COUNT5b4bb43527f0, DBDecimalType* MAT5b4bb4365600aggr0__tmp_attr2, DBI64Type* MAT5b4bb4365600map0__tmp_attr0, uint64_t* MAT_IDX5b4bb4365600, DBDecimalType* aggr0__tmp_attr2, DBI64Type* map0__tmp_attr0) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= COUNT5b4bb43527f0) return;
//Materialize buffers
auto mat_idx5b4bb4365600 = atomicAdd((int*)MAT_IDX5b4bb4365600, 1);
auto reg_map0__tmp_attr0 = map0__tmp_attr0[tid];
MAT5b4bb4365600map0__tmp_attr0[mat_idx5b4bb4365600] = reg_map0__tmp_attr0;
auto reg_aggr0__tmp_attr2 = aggr0__tmp_attr2[tid];
MAT5b4bb4365600aggr0__tmp_attr2[mat_idx5b4bb4365600] = reg_aggr0__tmp_attr2;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT5b4bb439aa50;
cudaMalloc(&d_COUNT5b4bb439aa50, sizeof(uint64_t));
cudaMemset(d_COUNT5b4bb439aa50, 0, sizeof(uint64_t));
count_5b4bb43a76a0<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT5b4bb439aa50, d_nation__n_name, nation_size);
uint64_t COUNT5b4bb439aa50;
cudaMemcpy(&COUNT5b4bb439aa50, d_COUNT5b4bb439aa50, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5b4bb439aa50);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b4bb439aa50;
cudaMalloc(&d_BUF_IDX_5b4bb439aa50, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b4bb439aa50, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b4bb439aa50;
cudaMalloc(&d_BUF_5b4bb439aa50, sizeof(uint64_t) * COUNT5b4bb439aa50 * 1);
auto d_HT_5b4bb439aa50 = cuco::experimental::static_multimap{ (int)COUNT5b4bb439aa50*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b4bb43a76a0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_5b4bb439aa50, d_BUF_IDX_5b4bb439aa50, d_HT_5b4bb439aa50.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
cudaFree(d_BUF_IDX_5b4bb439aa50);
//Materialize count
uint64_t* d_COUNT5b4bb4399bf0;
cudaMalloc(&d_COUNT5b4bb4399bf0, sizeof(uint64_t));
cudaMemset(d_COUNT5b4bb4399bf0, 0, sizeof(uint64_t));
count_5b4bb43aa820<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT5b4bb4399bf0, d_nation__n_name, nation_size);
uint64_t COUNT5b4bb4399bf0;
cudaMemcpy(&COUNT5b4bb4399bf0, d_COUNT5b4bb4399bf0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5b4bb4399bf0);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b4bb4399bf0;
cudaMalloc(&d_BUF_IDX_5b4bb4399bf0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b4bb4399bf0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b4bb4399bf0;
cudaMalloc(&d_BUF_5b4bb4399bf0, sizeof(uint64_t) * COUNT5b4bb4399bf0 * 1);
auto d_HT_5b4bb4399bf0 = cuco::experimental::static_multimap{ (int)COUNT5b4bb4399bf0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b4bb43aa820<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_5b4bb4399bf0, d_BUF_IDX_5b4bb4399bf0, d_HT_5b4bb4399bf0.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
cudaFree(d_BUF_IDX_5b4bb4399bf0);
//Materialize count
uint64_t* d_COUNT5b4bb4398620;
cudaMalloc(&d_COUNT5b4bb4398620, sizeof(uint64_t));
cudaMemset(d_COUNT5b4bb4398620, 0, sizeof(uint64_t));
count_5b4bb43ab780<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5b4bb4399bf0, d_COUNT5b4bb4398620, d_HT_5b4bb4399bf0.ref(cuco::for_each), d_customer__c_nationkey, customer_size);
uint64_t COUNT5b4bb4398620;
cudaMemcpy(&COUNT5b4bb4398620, d_COUNT5b4bb4398620, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5b4bb4398620);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b4bb4398620;
cudaMalloc(&d_BUF_IDX_5b4bb4398620, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b4bb4398620, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b4bb4398620;
cudaMalloc(&d_BUF_5b4bb4398620, sizeof(uint64_t) * COUNT5b4bb4398620 * 2);
auto d_HT_5b4bb4398620 = cuco::experimental::static_multimap{ (int)COUNT5b4bb4398620*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b4bb43ab780<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5b4bb4398620, d_BUF_5b4bb4399bf0, d_BUF_IDX_5b4bb4398620, d_HT_5b4bb4398620.ref(cuco::insert), d_HT_5b4bb4399bf0.ref(cuco::for_each), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
cudaFree(d_BUF_IDX_5b4bb4398620);
//Materialize count
uint64_t* d_COUNT5b4bb4398d20;
cudaMalloc(&d_COUNT5b4bb4398d20, sizeof(uint64_t));
cudaMemset(d_COUNT5b4bb4398d20, 0, sizeof(uint64_t));
count_5b4bb43a6160<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5b4bb4398620, d_COUNT5b4bb4398d20, d_HT_5b4bb4398620.ref(cuco::for_each), d_orders__o_custkey, orders_size);
uint64_t COUNT5b4bb4398d20;
cudaMemcpy(&COUNT5b4bb4398d20, d_COUNT5b4bb4398d20, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5b4bb4398d20);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b4bb4398d20;
cudaMalloc(&d_BUF_IDX_5b4bb4398d20, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b4bb4398d20, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b4bb4398d20;
cudaMalloc(&d_BUF_5b4bb4398d20, sizeof(uint64_t) * COUNT5b4bb4398d20 * 3);
auto d_HT_5b4bb4398d20 = cuco::experimental::static_multimap{ (int)COUNT5b4bb4398d20*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b4bb43a6160<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5b4bb4398620, d_BUF_5b4bb4398d20, d_BUF_IDX_5b4bb4398d20, d_HT_5b4bb4398620.ref(cuco::for_each), d_HT_5b4bb4398d20.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderkey, orders_size);
cudaFree(d_BUF_IDX_5b4bb4398d20);
//Materialize count
uint64_t* d_COUNT5b4bb439b720;
cudaMalloc(&d_COUNT5b4bb439b720, sizeof(uint64_t));
cudaMemset(d_COUNT5b4bb439b720, 0, sizeof(uint64_t));
count_5b4bb429c2c0<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_5b4bb439aa50, d_COUNT5b4bb439b720, d_HT_5b4bb439aa50.ref(cuco::for_each), d_supplier__s_nationkey, supplier_size);
uint64_t COUNT5b4bb439b720;
cudaMemcpy(&COUNT5b4bb439b720, d_COUNT5b4bb439b720, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5b4bb439b720);
// Insert hash table control;
uint64_t* d_BUF_IDX_5b4bb439b720;
cudaMalloc(&d_BUF_IDX_5b4bb439b720, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5b4bb439b720, 0, sizeof(uint64_t));
uint64_t* d_BUF_5b4bb439b720;
cudaMalloc(&d_BUF_5b4bb439b720, sizeof(uint64_t) * COUNT5b4bb439b720 * 2);
auto d_HT_5b4bb439b720 = cuco::experimental::static_multimap{ (int)COUNT5b4bb439b720*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5b4bb429c2c0<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_5b4bb439aa50, d_BUF_5b4bb439b720, d_BUF_IDX_5b4bb439b720, d_HT_5b4bb439aa50.ref(cuco::for_each), d_HT_5b4bb439b720.ref(cuco::insert), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
cudaFree(d_BUF_IDX_5b4bb439b720);
//Create aggregation hash table
auto d_HT_5b4bb43527f0 = cuco::static_map{ (int)13634*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
count_5b4bb431f8f0<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5b4bb4398d20, d_BUF_5b4bb439b720, d_HT_5b4bb43527f0.ref(cuco::insert), d_HT_5b4bb4398d20.ref(cuco::for_each), d_HT_5b4bb439b720.ref(cuco::for_each), d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name);
size_t COUNT5b4bb43527f0 = d_HT_5b4bb43527f0.size();
thrust::device_vector<int64_t> keys_5b4bb43527f0(COUNT5b4bb43527f0), vals_5b4bb43527f0(COUNT5b4bb43527f0);
d_HT_5b4bb43527f0.retrieve_all(keys_5b4bb43527f0.begin(), vals_5b4bb43527f0.begin());
d_HT_5b4bb43527f0.clear();
int64_t* raw_keys5b4bb43527f0 = thrust::raw_pointer_cast(keys_5b4bb43527f0.data());
insertKeys<<<std::ceil((float)COUNT5b4bb43527f0/32.), 32>>>(raw_keys5b4bb43527f0, d_HT_5b4bb43527f0.ref(cuco::insert), COUNT5b4bb43527f0);
//Aggregate in hashtable
DBDecimalType* d_aggr0__tmp_attr2;
cudaMalloc(&d_aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT5b4bb43527f0);
cudaMemset(d_aggr0__tmp_attr2, 0, sizeof(DBDecimalType) * COUNT5b4bb43527f0);
DBI64Type* d_KEY_5b4bb43527f0map0__tmp_attr0;
cudaMalloc(&d_KEY_5b4bb43527f0map0__tmp_attr0, sizeof(DBI64Type) * COUNT5b4bb43527f0);
cudaMemset(d_KEY_5b4bb43527f0map0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT5b4bb43527f0);
main_5b4bb431f8f0<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5b4bb4398d20, d_BUF_5b4bb439b720, d_HT_5b4bb43527f0.ref(cuco::find), d_HT_5b4bb4398d20.ref(cuco::for_each), d_HT_5b4bb439b720.ref(cuco::for_each), d_KEY_5b4bb43527f0map0__tmp_attr0, d_aggr0__tmp_attr2, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name);
//Materialize count
uint64_t* d_COUNT5b4bb4365600;
cudaMalloc(&d_COUNT5b4bb4365600, sizeof(uint64_t));
cudaMemset(d_COUNT5b4bb4365600, 0, sizeof(uint64_t));
count_5b4bb43bbcf0<<<std::ceil((float)COUNT5b4bb43527f0/32.), 32>>>(COUNT5b4bb43527f0, d_COUNT5b4bb4365600);
uint64_t COUNT5b4bb4365600;
cudaMemcpy(&COUNT5b4bb4365600, d_COUNT5b4bb4365600, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5b4bb4365600);
//Materialize buffers
uint64_t* d_MAT_IDX5b4bb4365600;
cudaMalloc(&d_MAT_IDX5b4bb4365600, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5b4bb4365600, 0, sizeof(uint64_t));
auto MAT5b4bb4365600map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT5b4bb4365600);
DBI64Type* d_MAT5b4bb4365600map0__tmp_attr0;
cudaMalloc(&d_MAT5b4bb4365600map0__tmp_attr0, sizeof(DBI64Type) * COUNT5b4bb4365600);
auto MAT5b4bb4365600aggr0__tmp_attr2 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5b4bb4365600);
DBDecimalType* d_MAT5b4bb4365600aggr0__tmp_attr2;
cudaMalloc(&d_MAT5b4bb4365600aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT5b4bb4365600);
main_5b4bb43bbcf0<<<std::ceil((float)COUNT5b4bb43527f0/32.), 32>>>(COUNT5b4bb43527f0, d_MAT5b4bb4365600aggr0__tmp_attr2, d_MAT5b4bb4365600map0__tmp_attr0, d_MAT_IDX5b4bb4365600, d_aggr0__tmp_attr2, d_KEY_5b4bb43527f0map0__tmp_attr0);
cudaFree(d_MAT_IDX5b4bb4365600);
cudaMemcpy(MAT5b4bb4365600map0__tmp_attr0, d_MAT5b4bb4365600map0__tmp_attr0, sizeof(DBI64Type) * COUNT5b4bb4365600, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5b4bb4365600aggr0__tmp_attr2, d_MAT5b4bb4365600aggr0__tmp_attr2, sizeof(DBDecimalType) * COUNT5b4bb4365600, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5b4bb4365600; i++) { std::cout << MAT5b4bb4365600map0__tmp_attr0[i] << "\t";
std::cout << MAT5b4bb4365600aggr0__tmp_attr2[i] << "\t";
std::cout << std::endl; }
}