#include <cuco/static_map.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
__global__ void count_5a3e586e76c0(uint64_t* COUNT5a3e586db7a0, DBStringType* n1___n_name, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n1___n_name = n1___n_name[tid];
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
//Materialize count
atomicAdd((int*)COUNT5a3e586db7a0, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5a3e586e76c0(uint64_t* BUF_5a3e586db7a0, uint64_t* BUF_IDX_5a3e586db7a0, HASHTABLE_INSERT HT_5a3e586db7a0, DBStringType* n1___n_name, DBI32Type* n1___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n1___n_name = n1___n_name[tid];
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) || (evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)))) return;
uint64_t KEY_5a3e586db7a0 = 0;
auto reg_n1___n_nationkey = n1___n_nationkey[tid];
KEY_5a3e586db7a0 <<= 32;
KEY_5a3e586db7a0 |= reg_n1___n_nationkey;
// Insert hash table kernel;
auto buf_idx_5a3e586db7a0 = atomicAdd((int*)BUF_IDX_5a3e586db7a0, 1);
HT_5a3e586db7a0.insert(cuco::pair{KEY_5a3e586db7a0, buf_idx_5a3e586db7a0});
BUF_5a3e586db7a0[buf_idx_5a3e586db7a0 * 1 + 0] = tid;
}
__global__ void count_5a3e586ea900(uint64_t* COUNT5a3e586dc300, DBStringType* n2___n_name, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n2___n_name = n2___n_name[tid];
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
//Materialize count
atomicAdd((int*)COUNT5a3e586dc300, 1);
}
template<typename HASHTABLE_INSERT>
__global__ void main_5a3e586ea900(uint64_t* BUF_5a3e586dc300, uint64_t* BUF_IDX_5a3e586dc300, HASHTABLE_INSERT HT_5a3e586dc300, DBStringType* n2___n_name, DBI32Type* n2___n_nationkey, size_t nation_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= nation_size) return;
auto reg_n2___n_name = n2___n_name[tid];
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
if (!((evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq)) || (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) return;
uint64_t KEY_5a3e586dc300 = 0;
auto reg_n2___n_nationkey = n2___n_nationkey[tid];
KEY_5a3e586dc300 <<= 32;
KEY_5a3e586dc300 |= reg_n2___n_nationkey;
// Insert hash table kernel;
auto buf_idx_5a3e586dc300 = atomicAdd((int*)BUF_IDX_5a3e586dc300, 1);
HT_5a3e586dc300.insert(cuco::pair{KEY_5a3e586dc300, buf_idx_5a3e586dc300});
BUF_5a3e586dc300[buf_idx_5a3e586dc300 * 1 + 0] = tid;
}
template<typename HASHTABLE_FIND>
__global__ void count_5a3e586eb880(uint64_t* BUF_5a3e586dc300, uint64_t* COUNT5a3e586de860, HASHTABLE_FIND HT_5a3e586dc300, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_5a3e586dc300 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];
KEY_5a3e586dc300 <<= 32;
KEY_5a3e586dc300 |= reg_customer__c_nationkey;
//Probe Hash table
auto SLOT_5a3e586dc300 = HT_5a3e586dc300.find(KEY_5a3e586dc300);
if (SLOT_5a3e586dc300 == HT_5a3e586dc300.end()) return;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5a3e586de860, 1);
}
template<typename HASHTABLE_FIND, typename HASHTABLE_INSERT>
__global__ void main_5a3e586eb880(uint64_t* BUF_5a3e586dc300, uint64_t* BUF_5a3e586de860, uint64_t* BUF_IDX_5a3e586de860, HASHTABLE_FIND HT_5a3e586dc300, HASHTABLE_INSERT HT_5a3e586de860, DBI32Type* customer__c_custkey, DBI32Type* customer__c_nationkey, size_t customer_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= customer_size) return;
uint64_t KEY_5a3e586dc300 = 0;
auto reg_customer__c_nationkey = customer__c_nationkey[tid];
KEY_5a3e586dc300 <<= 32;
KEY_5a3e586dc300 |= reg_customer__c_nationkey;
//Probe Hash table
auto SLOT_5a3e586dc300 = HT_5a3e586dc300.find(KEY_5a3e586dc300);
if (SLOT_5a3e586dc300 == HT_5a3e586dc300.end()) return;
if (!(true)) return;
uint64_t KEY_5a3e586de860 = 0;
auto reg_customer__c_custkey = customer__c_custkey[tid];
KEY_5a3e586de860 <<= 32;
KEY_5a3e586de860 |= reg_customer__c_custkey;
// Insert hash table kernel;
auto buf_idx_5a3e586de860 = atomicAdd((int*)BUF_IDX_5a3e586de860, 1);
HT_5a3e586de860.insert(cuco::pair{KEY_5a3e586de860, buf_idx_5a3e586de860});
BUF_5a3e586de860[buf_idx_5a3e586de860 * 2 + 0] = BUF_5a3e586dc300[SLOT_5a3e586dc300->second * 1 + 0];
BUF_5a3e586de860[buf_idx_5a3e586de860 * 2 + 1] = tid;
}
template<typename HASHTABLE_FIND>
__global__ void count_5a3e586e61f0(uint64_t* BUF_5a3e586de860, uint64_t* COUNT5a3e586de970, HASHTABLE_FIND HT_5a3e586de860, DBI32Type* orders__o_custkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_5a3e586de860 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];
KEY_5a3e586de860 <<= 32;
KEY_5a3e586de860 |= reg_orders__o_custkey;
//Probe Hash table
auto SLOT_5a3e586de860 = HT_5a3e586de860.find(KEY_5a3e586de860);
if (SLOT_5a3e586de860 == HT_5a3e586de860.end()) return;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5a3e586de970, 1);
}
template<typename HASHTABLE_FIND, typename HASHTABLE_INSERT>
__global__ void main_5a3e586e61f0(uint64_t* BUF_5a3e586de860, uint64_t* BUF_5a3e586de970, uint64_t* BUF_IDX_5a3e586de970, HASHTABLE_FIND HT_5a3e586de860, HASHTABLE_INSERT HT_5a3e586de970, DBI32Type* orders__o_custkey, DBI32Type* orders__o_orderkey, size_t orders_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= orders_size) return;
uint64_t KEY_5a3e586de860 = 0;
auto reg_orders__o_custkey = orders__o_custkey[tid];
KEY_5a3e586de860 <<= 32;
KEY_5a3e586de860 |= reg_orders__o_custkey;
//Probe Hash table
auto SLOT_5a3e586de860 = HT_5a3e586de860.find(KEY_5a3e586de860);
if (SLOT_5a3e586de860 == HT_5a3e586de860.end()) return;
if (!(true)) return;
uint64_t KEY_5a3e586de970 = 0;
auto reg_orders__o_orderkey = orders__o_orderkey[tid];
KEY_5a3e586de970 <<= 32;
KEY_5a3e586de970 |= reg_orders__o_orderkey;
// Insert hash table kernel;
auto buf_idx_5a3e586de970 = atomicAdd((int*)BUF_IDX_5a3e586de970, 1);
HT_5a3e586de970.insert(cuco::pair{KEY_5a3e586de970, buf_idx_5a3e586de970});
BUF_5a3e586de970[buf_idx_5a3e586de970 * 2 + 0] = BUF_5a3e586de860[SLOT_5a3e586de860->second * 2 + 0];
BUF_5a3e586de970[buf_idx_5a3e586de970 * 2 + 1] = tid;
}
template<typename HASHTABLE_FIND>
__global__ void count_5a3e585dcd70(uint64_t* BUF_5a3e586db7a0, uint64_t* COUNT5a3e586dea80, HASHTABLE_FIND HT_5a3e586db7a0, DBI32Type* supplier__s_nationkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_5a3e586db7a0 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];
KEY_5a3e586db7a0 <<= 32;
KEY_5a3e586db7a0 |= reg_supplier__s_nationkey;
//Probe Hash table
auto SLOT_5a3e586db7a0 = HT_5a3e586db7a0.find(KEY_5a3e586db7a0);
if (SLOT_5a3e586db7a0 == HT_5a3e586db7a0.end()) return;
if (!(true)) return;
//Materialize count
atomicAdd((int*)COUNT5a3e586dea80, 1);
}
template<typename HASHTABLE_FIND, typename HASHTABLE_INSERT>
__global__ void main_5a3e585dcd70(uint64_t* BUF_5a3e586db7a0, uint64_t* BUF_5a3e586dea80, uint64_t* BUF_IDX_5a3e586dea80, HASHTABLE_FIND HT_5a3e586db7a0, HASHTABLE_INSERT HT_5a3e586dea80, DBI32Type* supplier__s_nationkey, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= supplier_size) return;
uint64_t KEY_5a3e586db7a0 = 0;
auto reg_supplier__s_nationkey = supplier__s_nationkey[tid];
KEY_5a3e586db7a0 <<= 32;
KEY_5a3e586db7a0 |= reg_supplier__s_nationkey;
//Probe Hash table
auto SLOT_5a3e586db7a0 = HT_5a3e586db7a0.find(KEY_5a3e586db7a0);
if (SLOT_5a3e586db7a0 == HT_5a3e586db7a0.end()) return;
if (!(true)) return;
uint64_t KEY_5a3e586dea80 = 0;
auto reg_supplier__s_suppkey = supplier__s_suppkey[tid];
KEY_5a3e586dea80 <<= 32;
KEY_5a3e586dea80 |= reg_supplier__s_suppkey;
// Insert hash table kernel;
auto buf_idx_5a3e586dea80 = atomicAdd((int*)BUF_IDX_5a3e586dea80, 1);
HT_5a3e586dea80.insert(cuco::pair{KEY_5a3e586dea80, buf_idx_5a3e586dea80});
BUF_5a3e586dea80[buf_idx_5a3e586dea80 * 2 + 0] = BUF_5a3e586db7a0[SLOT_5a3e586db7a0->second * 1 + 0];
BUF_5a3e586dea80[buf_idx_5a3e586dea80 * 2 + 1] = tid;
}
template<typename HASHTABLE_FIND>
__global__ void count_5a3e586603c0(uint64_t* BUF_5a3e586de970, uint64_t* BUF_5a3e586dea80, uint64_t* COUNT5a3e586a5870, HASHTABLE_FIND HT_5a3e586de970, HASHTABLE_FIND HT_5a3e586dea80, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBStringType* n2___n_name) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9861, Predicate::lte))) return;
uint64_t KEY_5a3e586de970 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];
KEY_5a3e586de970 <<= 32;
KEY_5a3e586de970 |= reg_lineitem__l_orderkey;
//Probe Hash table
auto SLOT_5a3e586de970 = HT_5a3e586de970.find(KEY_5a3e586de970);
if (SLOT_5a3e586de970 == HT_5a3e586de970.end()) return;
if (!(true)) return;
uint64_t KEY_5a3e586dea80 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];
KEY_5a3e586dea80 <<= 32;
KEY_5a3e586dea80 |= reg_lineitem__l_suppkey;
//Probe Hash table
auto SLOT_5a3e586dea80 = HT_5a3e586dea80.find(KEY_5a3e586dea80);
if (SLOT_5a3e586dea80 == HT_5a3e586dea80.end()) return;
auto reg_n1___n_name = n1___n_name[BUF_5a3e586dea80[SLOT_5a3e586dea80->second * 2 + 0]];
auto reg_n2___n_name = n2___n_name[BUF_5a3e586de970[SLOT_5a3e586de970->second * 2 + 0]];
if (!((((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) && (true))) return;
//Materialize count
atomicAdd((int*)COUNT5a3e586a5870, 1);
}
template<typename HASHTABLE_FIND>
__global__ void main_5a3e586603c0(uint64_t* BUF_5a3e586de970, uint64_t* BUF_5a3e586dea80, HASHTABLE_FIND HT_5a3e586de970, HASHTABLE_FIND HT_5a3e586dea80, DBI64Type* MAT5a3e586a5870map0__tmp_attr0, DBDecimalType* MAT5a3e586a5870map0__tmp_attr1, DBStringType* MAT5a3e586a5870n1___n_name, DBStringType* MAT5a3e586a5870n2___n_name, uint64_t* MAT_IDX5a3e586a5870, DBDecimalType* lineitem__l_discount, DBDecimalType* lineitem__l_extendedprice, DBI32Type* lineitem__l_orderkey, DBDateType* lineitem__l_shipdate, DBI32Type* lineitem__l_suppkey, size_t lineitem_size, DBStringType* n1___n_name, DBStringType* n2___n_name) {
size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
if (tid >= lineitem_size) return;
auto reg_lineitem__l_shipdate = lineitem__l_shipdate[tid];
if (!(evaluatePredicate(reg_lineitem__l_shipdate, 9131, Predicate::gte) && evaluatePredicate(reg_lineitem__l_shipdate, 9861, Predicate::lte))) return;
uint64_t KEY_5a3e586de970 = 0;
auto reg_lineitem__l_orderkey = lineitem__l_orderkey[tid];
KEY_5a3e586de970 <<= 32;
KEY_5a3e586de970 |= reg_lineitem__l_orderkey;
//Probe Hash table
auto SLOT_5a3e586de970 = HT_5a3e586de970.find(KEY_5a3e586de970);
if (SLOT_5a3e586de970 == HT_5a3e586de970.end()) return;
if (!(true)) return;
uint64_t KEY_5a3e586dea80 = 0;
auto reg_lineitem__l_suppkey = lineitem__l_suppkey[tid];
KEY_5a3e586dea80 <<= 32;
KEY_5a3e586dea80 |= reg_lineitem__l_suppkey;
//Probe Hash table
auto SLOT_5a3e586dea80 = HT_5a3e586dea80.find(KEY_5a3e586dea80);
if (SLOT_5a3e586dea80 == HT_5a3e586dea80.end()) return;
auto reg_n1___n_name = n1___n_name[BUF_5a3e586dea80[SLOT_5a3e586dea80->second * 2 + 0]];
auto reg_n2___n_name = n2___n_name[BUF_5a3e586de970[SLOT_5a3e586de970->second * 2 + 0]];
if (!((((evaluatePredicate(reg_n1___n_name, "FRANCE", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "GERMANY", Predicate::eq))) || ((evaluatePredicate(reg_n1___n_name, "GERMANY", Predicate::eq)) && (evaluatePredicate(reg_n2___n_name, "FRANCE", Predicate::eq)))) && (true))) return;
//Materialize buffers
auto mat_idx5a3e586a5870 = atomicAdd((int*)MAT_IDX5a3e586a5870, 1);
MAT5a3e586a5870n1___n_name[mat_idx5a3e586a5870] = reg_n1___n_name;
MAT5a3e586a5870n2___n_name[mat_idx5a3e586a5870] = reg_n2___n_name;
auto reg_map0__tmp_attr0 = ExtractFromDate("year", reg_lineitem__l_shipdate);
MAT5a3e586a5870map0__tmp_attr0[mat_idx5a3e586a5870] = reg_map0__tmp_attr0;
auto reg_lineitem__l_discount = lineitem__l_discount[tid];
auto reg_lineitem__l_extendedprice = lineitem__l_extendedprice[tid];
auto reg_map0__tmp_attr1 = (reg_lineitem__l_extendedprice) * ((1) - (reg_lineitem__l_discount));
MAT5a3e586a5870map0__tmp_attr1[mat_idx5a3e586a5870] = reg_map0__tmp_attr1;
}
extern "C" void control( DBI32Type* d_nation__n_nationkey, DBStringType* d_nation__n_name, DBI32Type* d_nation__n_regionkey, DBStringType* d_nation__n_comment, size_t nation_size, DBI32Type* d_supplier__s_suppkey, DBI32Type* d_supplier__s_nationkey, DBStringType* d_supplier__s_name, DBStringType* d_supplier__s_address, DBStringType* d_supplier__s_phone, DBDecimalType* d_supplier__s_acctbal, DBStringType* d_supplier__s_comment, size_t supplier_size, DBI32Type* d_partsupp__ps_suppkey, DBI32Type* d_partsupp__ps_partkey, DBI32Type* d_partsupp__ps_availqty, DBDecimalType* d_partsupp__ps_supplycost, DBStringType* d_partsupp__ps_comment, size_t partsupp_size, DBI32Type* d_part__p_partkey, DBStringType* d_part__p_name, DBStringType* d_part__p_mfgr, DBStringType* d_part__p_brand, DBStringType* d_part__p_type, DBI32Type* d_part__p_size, DBStringType* d_part__p_container, DBDecimalType* d_part__p_retailprice, DBStringType* d_part__p_comment, size_t part_size, DBI32Type* d_lineitem__l_orderkey, DBI32Type* d_lineitem__l_partkey, DBI32Type* d_lineitem__l_suppkey, DBI64Type* d_lineitem__l_linenumber, DBDecimalType* d_lineitem__l_quantity, DBDecimalType* d_lineitem__l_extendedprice, DBDecimalType* d_lineitem__l_discount, DBDecimalType* d_lineitem__l_tax, DBCharType* d_lineitem__l_returnflag, DBCharType* d_lineitem__l_linestatus, DBDateType* d_lineitem__l_shipdate, DBDateType* d_lineitem__l_commitdate, DBDateType* d_lineitem__l_receiptdate, DBStringType* d_lineitem__l_shipinstruct, DBStringType* d_lineitem__l_shipmode, DBStringType* d_lineitem__comments, size_t lineitem_size, DBI32Type* d_orders__o_orderkey, DBCharType* d_orders__o_orderstatus, DBI32Type* d_orders__o_custkey, DBDecimalType* d_orders__o_totalprice, DBDateType* d_orders__o_orderdate, DBStringType* d_orders__o_orderpriority, DBStringType* d_orders__o_clerk, DBI32Type* d_orders__o_shippriority, DBStringType* d_orders__o_comment, size_t orders_size, DBI32Type* d_customer__c_custkey, DBStringType* d_customer__c_name, DBStringType* d_customer__c_address, DBI32Type* d_customer__c_nationkey, DBStringType* d_customer__c_phone, DBDecimalType* d_customer__c_acctbal, DBStringType* d_customer__c_mktsegment, DBStringType* d_customer__c_comment, size_t customer_size, DBI32Type* d_region__r_regionkey, DBStringType* d_region__r_name, DBStringType* d_region__r_comment, size_t region_size) {
//Materialize count
uint64_t* d_COUNT5a3e586db7a0;
cudaMalloc(&d_COUNT5a3e586db7a0, sizeof(uint64_t));
cudaMemset(d_COUNT5a3e586db7a0, 0, sizeof(uint64_t));
count_5a3e586e76c0<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT5a3e586db7a0, d_nation__n_name, nation_size);
uint64_t COUNT5a3e586db7a0;
cudaMemcpy(&COUNT5a3e586db7a0, d_COUNT5a3e586db7a0, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5a3e586db7a0);
// Insert hash table control;
uint64_t* d_BUF_IDX_5a3e586db7a0;
cudaMalloc(&d_BUF_IDX_5a3e586db7a0, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5a3e586db7a0, 0, sizeof(uint64_t));
uint64_t* d_BUF_5a3e586db7a0;
cudaMalloc(&d_BUF_5a3e586db7a0, sizeof(uint64_t) * COUNT5a3e586db7a0 * 1);
auto d_HT_5a3e586db7a0 = cuco::static_map{ (int)COUNT5a3e586db7a0*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5a3e586e76c0<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_5a3e586db7a0, d_BUF_IDX_5a3e586db7a0, d_HT_5a3e586db7a0.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
cudaFree(d_BUF_IDX_5a3e586db7a0);
//Materialize count
uint64_t* d_COUNT5a3e586dc300;
cudaMalloc(&d_COUNT5a3e586dc300, sizeof(uint64_t));
cudaMemset(d_COUNT5a3e586dc300, 0, sizeof(uint64_t));
count_5a3e586ea900<<<std::ceil((float)nation_size/32.), 32>>>(d_COUNT5a3e586dc300, d_nation__n_name, nation_size);
uint64_t COUNT5a3e586dc300;
cudaMemcpy(&COUNT5a3e586dc300, d_COUNT5a3e586dc300, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5a3e586dc300);
// Insert hash table control;
uint64_t* d_BUF_IDX_5a3e586dc300;
cudaMalloc(&d_BUF_IDX_5a3e586dc300, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5a3e586dc300, 0, sizeof(uint64_t));
uint64_t* d_BUF_5a3e586dc300;
cudaMalloc(&d_BUF_5a3e586dc300, sizeof(uint64_t) * COUNT5a3e586dc300 * 1);
auto d_HT_5a3e586dc300 = cuco::static_map{ (int)COUNT5a3e586dc300*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5a3e586ea900<<<std::ceil((float)nation_size/32.), 32>>>(d_BUF_5a3e586dc300, d_BUF_IDX_5a3e586dc300, d_HT_5a3e586dc300.ref(cuco::insert), d_nation__n_name, d_nation__n_nationkey, nation_size);
cudaFree(d_BUF_IDX_5a3e586dc300);
//Materialize count
uint64_t* d_COUNT5a3e586de860;
cudaMalloc(&d_COUNT5a3e586de860, sizeof(uint64_t));
cudaMemset(d_COUNT5a3e586de860, 0, sizeof(uint64_t));
count_5a3e586eb880<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5a3e586dc300, d_COUNT5a3e586de860, d_HT_5a3e586dc300.ref(cuco::find), d_customer__c_nationkey, customer_size);
uint64_t COUNT5a3e586de860;
cudaMemcpy(&COUNT5a3e586de860, d_COUNT5a3e586de860, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5a3e586de860);
// Insert hash table control;
uint64_t* d_BUF_IDX_5a3e586de860;
cudaMalloc(&d_BUF_IDX_5a3e586de860, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5a3e586de860, 0, sizeof(uint64_t));
uint64_t* d_BUF_5a3e586de860;
cudaMalloc(&d_BUF_5a3e586de860, sizeof(uint64_t) * COUNT5a3e586de860 * 2);
auto d_HT_5a3e586de860 = cuco::static_map{ (int)COUNT5a3e586de860*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5a3e586eb880<<<std::ceil((float)customer_size/32.), 32>>>(d_BUF_5a3e586dc300, d_BUF_5a3e586de860, d_BUF_IDX_5a3e586de860, d_HT_5a3e586dc300.ref(cuco::find), d_HT_5a3e586de860.ref(cuco::insert), d_customer__c_custkey, d_customer__c_nationkey, customer_size);
cudaFree(d_BUF_IDX_5a3e586de860);
//Materialize count
uint64_t* d_COUNT5a3e586de970;
cudaMalloc(&d_COUNT5a3e586de970, sizeof(uint64_t));
cudaMemset(d_COUNT5a3e586de970, 0, sizeof(uint64_t));
count_5a3e586e61f0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5a3e586de860, d_COUNT5a3e586de970, d_HT_5a3e586de860.ref(cuco::find), d_orders__o_custkey, orders_size);
uint64_t COUNT5a3e586de970;
cudaMemcpy(&COUNT5a3e586de970, d_COUNT5a3e586de970, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5a3e586de970);
// Insert hash table control;
uint64_t* d_BUF_IDX_5a3e586de970;
cudaMalloc(&d_BUF_IDX_5a3e586de970, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5a3e586de970, 0, sizeof(uint64_t));
uint64_t* d_BUF_5a3e586de970;
cudaMalloc(&d_BUF_5a3e586de970, sizeof(uint64_t) * COUNT5a3e586de970 * 2);
auto d_HT_5a3e586de970 = cuco::static_map{ (int)COUNT5a3e586de970*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5a3e586e61f0<<<std::ceil((float)orders_size/32.), 32>>>(d_BUF_5a3e586de860, d_BUF_5a3e586de970, d_BUF_IDX_5a3e586de970, d_HT_5a3e586de860.ref(cuco::find), d_HT_5a3e586de970.ref(cuco::insert), d_orders__o_custkey, d_orders__o_orderkey, orders_size);
cudaFree(d_BUF_IDX_5a3e586de970);
//Materialize count
uint64_t* d_COUNT5a3e586dea80;
cudaMalloc(&d_COUNT5a3e586dea80, sizeof(uint64_t));
cudaMemset(d_COUNT5a3e586dea80, 0, sizeof(uint64_t));
count_5a3e585dcd70<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_5a3e586db7a0, d_COUNT5a3e586dea80, d_HT_5a3e586db7a0.ref(cuco::find), d_supplier__s_nationkey, supplier_size);
uint64_t COUNT5a3e586dea80;
cudaMemcpy(&COUNT5a3e586dea80, d_COUNT5a3e586dea80, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5a3e586dea80);
// Insert hash table control;
uint64_t* d_BUF_IDX_5a3e586dea80;
cudaMalloc(&d_BUF_IDX_5a3e586dea80, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_5a3e586dea80, 0, sizeof(uint64_t));
uint64_t* d_BUF_5a3e586dea80;
cudaMalloc(&d_BUF_5a3e586dea80, sizeof(uint64_t) * COUNT5a3e586dea80 * 2);
auto d_HT_5a3e586dea80 = cuco::static_map{ (int)COUNT5a3e586dea80*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5a3e585dcd70<<<std::ceil((float)supplier_size/32.), 32>>>(d_BUF_5a3e586db7a0, d_BUF_5a3e586dea80, d_BUF_IDX_5a3e586dea80, d_HT_5a3e586db7a0.ref(cuco::find), d_HT_5a3e586dea80.ref(cuco::insert), d_supplier__s_nationkey, d_supplier__s_suppkey, supplier_size);
cudaFree(d_BUF_IDX_5a3e586dea80);
//Materialize count
uint64_t* d_COUNT5a3e586a5870;
cudaMalloc(&d_COUNT5a3e586a5870, sizeof(uint64_t));
cudaMemset(d_COUNT5a3e586a5870, 0, sizeof(uint64_t));
count_5a3e586603c0<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5a3e586de970, d_BUF_5a3e586dea80, d_COUNT5a3e586a5870, d_HT_5a3e586de970.ref(cuco::find), d_HT_5a3e586dea80.ref(cuco::find), d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name);
uint64_t COUNT5a3e586a5870;
cudaMemcpy(&COUNT5a3e586a5870, d_COUNT5a3e586a5870, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaFree(d_COUNT5a3e586a5870);
//Materialize buffers
uint64_t* d_MAT_IDX5a3e586a5870;
cudaMalloc(&d_MAT_IDX5a3e586a5870, sizeof(uint64_t));
cudaMemset(d_MAT_IDX5a3e586a5870, 0, sizeof(uint64_t));
auto MAT5a3e586a5870n1___n_name = (DBStringType*)malloc(sizeof(DBStringType) * COUNT5a3e586a5870);
DBStringType* d_MAT5a3e586a5870n1___n_name;
cudaMalloc(&d_MAT5a3e586a5870n1___n_name, sizeof(DBStringType) * COUNT5a3e586a5870);
auto MAT5a3e586a5870n2___n_name = (DBStringType*)malloc(sizeof(DBStringType) * COUNT5a3e586a5870);
DBStringType* d_MAT5a3e586a5870n2___n_name;
cudaMalloc(&d_MAT5a3e586a5870n2___n_name, sizeof(DBStringType) * COUNT5a3e586a5870);
auto MAT5a3e586a5870map0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT5a3e586a5870);
DBI64Type* d_MAT5a3e586a5870map0__tmp_attr0;
cudaMalloc(&d_MAT5a3e586a5870map0__tmp_attr0, sizeof(DBI64Type) * COUNT5a3e586a5870);
auto MAT5a3e586a5870map0__tmp_attr1 = (DBDecimalType*)malloc(sizeof(DBDecimalType) * COUNT5a3e586a5870);
DBDecimalType* d_MAT5a3e586a5870map0__tmp_attr1;
cudaMalloc(&d_MAT5a3e586a5870map0__tmp_attr1, sizeof(DBDecimalType) * COUNT5a3e586a5870);
main_5a3e586603c0<<<std::ceil((float)lineitem_size/32.), 32>>>(d_BUF_5a3e586de970, d_BUF_5a3e586dea80, d_HT_5a3e586de970.ref(cuco::find), d_HT_5a3e586dea80.ref(cuco::find), d_MAT5a3e586a5870map0__tmp_attr0, d_MAT5a3e586a5870map0__tmp_attr1, d_MAT5a3e586a5870n1___n_name, d_MAT5a3e586a5870n2___n_name, d_MAT_IDX5a3e586a5870, d_lineitem__l_discount, d_lineitem__l_extendedprice, d_lineitem__l_orderkey, d_lineitem__l_shipdate, d_lineitem__l_suppkey, lineitem_size, d_nation__n_name, d_nation__n_name);
cudaFree(d_MAT_IDX5a3e586a5870);
cudaMemcpy(MAT5a3e586a5870n1___n_name, d_MAT5a3e586a5870n1___n_name, sizeof(DBStringType) * COUNT5a3e586a5870, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5a3e586a5870n2___n_name, d_MAT5a3e586a5870n2___n_name, sizeof(DBStringType) * COUNT5a3e586a5870, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5a3e586a5870map0__tmp_attr0, d_MAT5a3e586a5870map0__tmp_attr0, sizeof(DBI64Type) * COUNT5a3e586a5870, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT5a3e586a5870map0__tmp_attr1, d_MAT5a3e586a5870map0__tmp_attr1, sizeof(DBDecimalType) * COUNT5a3e586a5870, cudaMemcpyDeviceToHost);
for (auto i=0ull; i < COUNT5a3e586a5870; i++) { 
//     std::cout << MAT5a3e586a5870n1___n_name[i] << "\t";
// std::cout << MAT5a3e586a5870n2___n_name[i] << "\t";
std::cout << MAT5a3e586a5870map0__tmp_attr0[i] << "\t";
std::cout << MAT5a3e586a5870map0__tmp_attr1[i] << "\t";
std::cout << std::endl; }
}