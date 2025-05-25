#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>
#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include "cudautils.cuh"
#include "db_types.h"
#include "dbruntime.h"
#include <chrono>
#define ITEMS_PER_THREAD 4
#define TILE_SIZE 512
#define TB TILE_SIZE/ITEMS_PER_THREAD
template<typename HASHTABLE_INSERT>
__global__ void main_1(uint64_t* BUF_6, uint64_t* BUF_IDX_6, HASHTABLE_INSERT HT_6, int64_t* cycles_per_warp_main_1_join_build_6, int64_t* cycles_per_warp_main_1_selection_0, int64_t* cycles_per_warp_main_1_selection_2, int64_t* cycles_per_warp_main_1_selection_3, DBStringType* part__p_brand, DBI32Type* part__p_partkey, DBI32Type* part__p_size, DBStringType* part__p_type, size_t part_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBI32Type reg_part__p_size[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_size[ITEM] = part__p_size[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= (evaluatePredicate(reg_part__p_size[ITEM], 49, Predicate::eq)) || (evaluatePredicate(reg_part__p_size[ITEM], 14, Predicate::eq)) || (evaluatePredicate(reg_part__p_size[ITEM], 23, Predicate::eq)) || (evaluatePredicate(reg_part__p_size[ITEM], 45, Predicate::eq)) || (evaluatePredicate(reg_part__p_size[ITEM], 19, Predicate::eq)) || (evaluatePredicate(reg_part__p_size[ITEM], 3, Predicate::eq)) || (evaluatePredicate(reg_part__p_size[ITEM], 36, Predicate::eq)) || (evaluatePredicate(reg_part__p_size[ITEM], 9, Predicate::eq));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_0[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
DBStringType reg_part__p_brand[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_brand[ITEM] = part__p_brand[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= evaluatePredicate(reg_part__p_brand[ITEM], "Brand#45", Predicate::neq);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_2[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
DBStringType reg_part__p_type[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_type[ITEM] = part__p_type[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= !(Like(reg_part__p_type[ITEM], "MEDIUM POLISHED", "", nullptr, nullptr, 0));
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_selection_3[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_part__p_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
reg_part__p_partkey[ITEM] = part__p_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_part__p_partkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < part_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_6.insert(cuco::pair{KEY_6[ITEM], ITEM*TB + tid});
BUF_6[(ITEM*TB + tid) * 1 + 0] = ITEM*TB + tid;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_1_join_build_6[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_INSERT_SJ>
__global__ void main_5(HASHTABLE_INSERT_SJ HT_8, int64_t* cycles_per_warp_main_5_anti_semi_join_build_8, int64_t* cycles_per_warp_main_5_selection_4, DBStringType* supplier__s_comment, DBI32Type* supplier__s_suppkey, size_t supplier_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
DBStringType reg_supplier__s_comment[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_comment[ITEM] = supplier__s_comment[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= Like(reg_supplier__s_comment[ITEM], "", "", (const char*[]){ "Customer", "Complaints" }, (const int[]){ 8, 10 }, 2);
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_selection_4[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_8[ITEMS_PER_THREAD];
DBI32Type reg_supplier__s_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
reg_supplier__s_suppkey[ITEM] = supplier__s_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_supplier__s_suppkey[ITEM];
}
// Insert hash table kernel;
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < supplier_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
HT_8.insert(cuco::pair{KEY_8[ITEM], 1});
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_5_anti_semi_join_build_8[blockIdx.x] = cycles_per_warp;}
}
template<typename HASHTABLE_PROBE, typename HASHTABLE_PROBE_SJ, typename HASHTABLE_FIND>
__global__ void main_7(uint64_t* BUF_6, HASHTABLE_PROBE HT_6, HASHTABLE_PROBE_SJ HT_8, HASHTABLE_FIND HT_9, DBI16Type* KEY_9part__p_brand_encoded, DBI32Type* KEY_9part__p_size, DBI16Type* KEY_9part__p_type_encoded, int* SLOT_COUNT_9, DBI64Type* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_7_aggregation_9, int64_t* cycles_per_warp_main_7_anti_semi_join_probe_8, int64_t* cycles_per_warp_main_7_join_probe_6, DBI16Type* part__p_brand_encoded, DBI32Type* part__p_size, DBI16Type* part__p_type_encoded, DBI32Type* partsupp__ps_partkey, DBI32Type* partsupp__ps_suppkey, size_t partsupp_size) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_6[ITEMS_PER_THREAD];
DBI32Type reg_partsupp__ps_partkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
reg_partsupp__ps_partkey[ITEM] = partsupp__ps_partkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_6[ITEM] = 0;
KEY_6[ITEM] |= reg_partsupp__ps_partkey[ITEM];
}
//Probe Hash table
int64_t slot_second6[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_6 = HT_6.find(KEY_6[ITEM]);
if (SLOT_6 == HT_6.end()) {selection_flags[ITEM] = 0; continue;}
slot_second6[ITEM] = SLOT_6->second;
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_join_probe_6[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_8[ITEMS_PER_THREAD];
DBI32Type reg_partsupp__ps_suppkey[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
reg_partsupp__ps_suppkey[ITEM] = partsupp__ps_suppkey[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_8[ITEM] = 0;
KEY_8[ITEM] |= reg_partsupp__ps_suppkey[ITEM];
}
//Probe Hash table
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto SLOT_8 = HT_8.find(KEY_8[ITEM]);
if (!(SLOT_8 == HT_8.end())) {selection_flags[ITEM] = 0;}
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
selection_flags[ITEM] &= true;
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_anti_semi_join_probe_8[blockIdx.x] = cycles_per_warp;}
if (threadIdx.x == 0) start = clock64();
uint64_t KEY_9[ITEMS_PER_THREAD];
DBI16Type reg_part__p_brand_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_brand_encoded[ITEM] = part__p_brand_encoded[BUF_6[slot_second6[ITEM] * 1 + 0]];
}
DBI16Type reg_part__p_type_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_type_encoded[ITEM] = part__p_type_encoded[BUF_6[slot_second6[ITEM] * 1 + 0]];
}
DBI32Type reg_part__p_size[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
reg_part__p_size[ITEM] = part__p_size[BUF_6[slot_second6[ITEM] * 1 + 0]];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
KEY_9[ITEM] = 0;
KEY_9[ITEM] |= reg_part__p_brand_encoded[ITEM];
KEY_9[ITEM] <<= 16;
KEY_9[ITEM] |= reg_part__p_type_encoded[ITEM];
KEY_9[ITEM] <<= 32;
KEY_9[ITEM] |= reg_part__p_size[ITEM];
}
//Aggregate in hashtable
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < partsupp_size); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto buf_idx_9 = get_aggregation_slot(KEY_9[ITEM], HT_9, SLOT_COUNT_9);
aggregate_sum(&aggr0__tmp_attr0[buf_idx_9], 1);
KEY_9part__p_brand_encoded[buf_idx_9] = reg_part__p_brand_encoded[ITEM];
KEY_9part__p_type_encoded[buf_idx_9] = reg_part__p_type_encoded[ITEM];
KEY_9part__p_size[buf_idx_9] = reg_part__p_size[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_7_aggregation_9[blockIdx.x] = cycles_per_warp;}
}
__global__ void main_11(size_t COUNT9, DBI64Type* MAT10aggr0__tmp_attr0, DBI16Type* MAT10part__p_brand_encoded, DBI32Type* MAT10part__p_size, DBI16Type* MAT10part__p_type_encoded, uint64_t* MAT_IDX10, DBI64Type* aggr0__tmp_attr0, int64_t* cycles_per_warp_main_11_materialize_10, DBI16Type* part__p_brand_encoded, DBI32Type* part__p_size, DBI16Type* part__p_type_encoded) {
int64_t start, stop, cycles_per_warp;
size_t tile_offset = blockIdx.x * TILE_SIZE;
size_t tid = tile_offset + threadIdx.x;
int selection_flags[ITEMS_PER_THREAD];
for (int i=0; i<ITEMS_PER_THREAD; i++) selection_flags[i] = 1;
if (threadIdx.x == 0) start = clock64();
//Materialize buffers
DBI16Type reg_part__p_brand_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_part__p_brand_encoded[ITEM] = part__p_brand_encoded[ITEM*TB + tid];
}
DBI16Type reg_part__p_type_encoded[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_part__p_type_encoded[ITEM] = part__p_type_encoded[ITEM*TB + tid];
}
DBI32Type reg_part__p_size[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_part__p_size[ITEM] = part__p_size[ITEM*TB + tid];
}
DBI64Type reg_aggr0__tmp_attr0[ITEMS_PER_THREAD];
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
reg_aggr0__tmp_attr0[ITEM] = aggr0__tmp_attr0[ITEM*TB + tid];
}
#pragma unroll
for (int ITEM = 0; ITEM < ITEMS_PER_THREAD && (ITEM*TB + tid < COUNT9); ++ITEM) {
if (!selection_flags[ITEM]) continue;
auto mat_idx10 = atomicAdd((int*)MAT_IDX10, 1);
MAT10part__p_brand_encoded[mat_idx10] = reg_part__p_brand_encoded[ITEM];
MAT10part__p_type_encoded[mat_idx10] = reg_part__p_type_encoded[ITEM];
MAT10part__p_size[mat_idx10] = reg_part__p_size[ITEM];
MAT10aggr0__tmp_attr0[mat_idx10] = reg_aggr0__tmp_attr0[ITEM];
}
if (threadIdx.x == 0) {            stop = clock64();            cycles_per_warp = (stop - start);            cycles_per_warp_main_11_materialize_10[blockIdx.x] = cycles_per_warp;}
}
extern "C" void control (DBI32Type * d_nation__n_nationkey, DBStringType * d_nation__n_name, DBI32Type * d_nation__n_regionkey, DBStringType * d_nation__n_comment, size_t nation_size, DBI32Type * d_supplier__s_suppkey, DBI32Type * d_supplier__s_nationkey, DBStringType * d_supplier__s_name, DBStringType * d_supplier__s_address, DBStringType * d_supplier__s_phone, DBDecimalType * d_supplier__s_acctbal, DBStringType * d_supplier__s_comment, size_t supplier_size, DBI32Type * d_partsupp__ps_suppkey, DBI32Type * d_partsupp__ps_partkey, DBI32Type * d_partsupp__ps_availqty, DBDecimalType * d_partsupp__ps_supplycost, DBStringType * d_partsupp__ps_comment, size_t partsupp_size, DBI32Type * d_part__p_partkey, DBStringType * d_part__p_name, DBStringType * d_part__p_mfgr, DBStringType * d_part__p_brand, DBStringType * d_part__p_type, DBI32Type * d_part__p_size, DBStringType * d_part__p_container, DBDecimalType * d_part__p_retailprice, DBStringType * d_part__p_comment, size_t part_size, DBI32Type * d_lineitem__l_orderkey, DBI32Type * d_lineitem__l_partkey, DBI32Type * d_lineitem__l_suppkey, DBI64Type * d_lineitem__l_linenumber, DBDecimalType * d_lineitem__l_quantity, DBDecimalType * d_lineitem__l_extendedprice, DBDecimalType * d_lineitem__l_discount, DBDecimalType * d_lineitem__l_tax, DBCharType * d_lineitem__l_returnflag, DBCharType * d_lineitem__l_linestatus, DBI32Type * d_lineitem__l_shipdate, DBI32Type * d_lineitem__l_commitdate, DBI32Type * d_lineitem__l_receiptdate, DBStringType * d_lineitem__l_shipinstruct, DBStringType * d_lineitem__l_shipmode, DBStringType * d_lineitem__comments, size_t lineitem_size, DBI32Type * d_orders__o_orderkey, DBCharType * d_orders__o_orderstatus, DBI32Type * d_orders__o_custkey, DBDecimalType * d_orders__o_totalprice, DBI32Type * d_orders__o_orderdate, DBStringType * d_orders__o_orderpriority, DBStringType * d_orders__o_clerk, DBI32Type * d_orders__o_shippriority, DBStringType * d_orders__o_comment, size_t orders_size, DBI32Type * d_customer__c_custkey, DBStringType * d_customer__c_name, DBStringType * d_customer__c_address, DBI32Type * d_customer__c_nationkey, DBStringType * d_customer__c_phone, DBDecimalType * d_customer__c_acctbal, DBStringType * d_customer__c_mktsegment, DBStringType * d_customer__c_comment, size_t customer_size, DBI32Type * d_region__r_regionkey, DBStringType * d_region__r_name, DBStringType * d_region__r_comment, size_t region_size, DBI16Type* d_nation__n_name_encoded, std::unordered_map<DBI16Type, DBStringType> &nation__n_name_map, std::unordered_map<DBI16Type, DBStringType> &n1___n_name_map, std::unordered_map<DBI16Type, DBStringType> &n2___n_name_map, DBI16Type* d_orders__o_orderpriority_encoded, std::unordered_map<DBI16Type, std::string>& orders__o_orderpriority_map, DBI16Type* d_customer__c_name_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_name_map, DBI16Type* d_customer__c_comment_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_comment_map, DBI16Type* d_customer__c_phone_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_phone_map, DBI16Type* d_customer__c_address_encoded, std::unordered_map<DBI16Type, std::string>& customer__c_address_map, DBI16Type* d_supplier__s_name_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_name_map, DBI16Type* d_part__p_brand_encoded, std::unordered_map<DBI16Type, std::string>& part__p_brand_map, DBI16Type* d_part__p_type_encoded, std::unordered_map<DBI16Type, std::string>& part__p_type_map, DBI16Type* d_lineitem__l_shipmode_encoded, std::unordered_map<DBI16Type, std::string>& lineitem__l_shipmode_map, DBI16Type* d_supplier__s_address_encoded, std::unordered_map<DBI16Type, std::string>& supplier__s_address_map) {
size_t used_mem = usedGpuMem();
auto startTime = std::chrono::high_resolution_clock::now();
int64_t* d_cycles_per_warp_main_1_selection_0;
auto main_1_selection_0_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_0, -1, sizeof(int64_t) * main_1_selection_0_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_2;
auto main_1_selection_2_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_2, sizeof(int64_t) * main_1_selection_2_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_2, -1, sizeof(int64_t) * main_1_selection_2_cpw_size);
int64_t* d_cycles_per_warp_main_1_selection_3;
auto main_1_selection_3_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_selection_3, sizeof(int64_t) * main_1_selection_3_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_selection_3, -1, sizeof(int64_t) * main_1_selection_3_cpw_size);
int64_t* d_cycles_per_warp_main_1_join_build_6;
auto main_1_join_build_6_cpw_size = std::ceil((float)part_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_1_join_build_6, sizeof(int64_t) * main_1_join_build_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_1_join_build_6, -1, sizeof(int64_t) * main_1_join_build_6_cpw_size);
size_t COUNT6 = part_size;
// Insert hash table control;
uint64_t* d_BUF_IDX_6;
cudaMalloc(&d_BUF_IDX_6, sizeof(uint64_t));
cudaMemset(d_BUF_IDX_6, 0, sizeof(uint64_t));
uint64_t* d_BUF_6;
cudaMalloc(&d_BUF_6, sizeof(uint64_t) * COUNT6 * 1);
auto d_HT_6 = cuco::static_map{ (int)COUNT6*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_1<<<std::ceil((float)part_size/(float)TILE_SIZE), TB>>>(d_BUF_6, d_BUF_IDX_6, d_HT_6.ref(cuco::insert), d_cycles_per_warp_main_1_join_build_6, d_cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_2, d_cycles_per_warp_main_1_selection_3, d_part__p_brand, d_part__p_partkey, d_part__p_size, d_part__p_type, part_size);
int64_t* cycles_per_warp_main_1_selection_0 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_0_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_0, d_cycles_per_warp_main_1_selection_0, sizeof(int64_t) * main_1_selection_0_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_0 ";
for (auto i=0ull; i < main_1_selection_0_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_0[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_selection_2 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_2_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_2, d_cycles_per_warp_main_1_selection_2, sizeof(int64_t) * main_1_selection_2_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_2 ";
for (auto i=0ull; i < main_1_selection_2_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_2[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_selection_3 = (int64_t*)malloc(sizeof(int64_t) * main_1_selection_3_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_selection_3, d_cycles_per_warp_main_1_selection_3, sizeof(int64_t) * main_1_selection_3_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_selection_3 ";
for (auto i=0ull; i < main_1_selection_3_cpw_size; i++) std::cout << cycles_per_warp_main_1_selection_3[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_1_join_build_6 = (int64_t*)malloc(sizeof(int64_t) * main_1_join_build_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_1_join_build_6, d_cycles_per_warp_main_1_join_build_6, sizeof(int64_t) * main_1_join_build_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_1_join_build_6 ";
for (auto i=0ull; i < main_1_join_build_6_cpw_size; i++) std::cout << cycles_per_warp_main_1_join_build_6[i] << " ";
std::cout << std::endl;
int64_t* d_cycles_per_warp_main_5_selection_4;
auto main_5_selection_4_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_selection_4, sizeof(int64_t) * main_5_selection_4_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_selection_4, -1, sizeof(int64_t) * main_5_selection_4_cpw_size);
int64_t* d_cycles_per_warp_main_5_anti_semi_join_build_8;
auto main_5_anti_semi_join_build_8_cpw_size = std::ceil((float)supplier_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_5_anti_semi_join_build_8, sizeof(int64_t) * main_5_anti_semi_join_build_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_5_anti_semi_join_build_8, -1, sizeof(int64_t) * main_5_anti_semi_join_build_8_cpw_size);
size_t COUNT8 = supplier_size;
// Insert hash table control;
auto d_HT_8 = cuco::static_map{ (int)COUNT8*2, cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
main_5<<<std::ceil((float)supplier_size/(float)TILE_SIZE), TB>>>(d_HT_8.ref(cuco::insert), d_cycles_per_warp_main_5_anti_semi_join_build_8, d_cycles_per_warp_main_5_selection_4, d_supplier__s_comment, d_supplier__s_suppkey, supplier_size);
int64_t* d_cycles_per_warp_main_7_join_probe_6;
auto main_7_join_probe_6_cpw_size = std::ceil((float)partsupp_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_join_probe_6, sizeof(int64_t) * main_7_join_probe_6_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_join_probe_6, -1, sizeof(int64_t) * main_7_join_probe_6_cpw_size);
int64_t* d_cycles_per_warp_main_7_anti_semi_join_probe_8;
auto main_7_anti_semi_join_probe_8_cpw_size = std::ceil((float)partsupp_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_anti_semi_join_probe_8, sizeof(int64_t) * main_7_anti_semi_join_probe_8_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_anti_semi_join_probe_8, -1, sizeof(int64_t) * main_7_anti_semi_join_probe_8_cpw_size);
int64_t* d_cycles_per_warp_main_7_aggregation_9;
auto main_7_aggregation_9_cpw_size = std::ceil((float)partsupp_size/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_7_aggregation_9, sizeof(int64_t) * main_7_aggregation_9_cpw_size);
cudaMemset(d_cycles_per_warp_main_7_aggregation_9, -1, sizeof(int64_t) * main_7_aggregation_9_cpw_size);
size_t COUNT9 = 120976;
auto d_HT_9 = cuco::static_map{ (int)120976*2, cuco::empty_key{(int64_t)-1},         cuco::empty_value{(int64_t)-1},         thrust::equal_to<int64_t>{},         cuco::linear_probing<1, cuco::default_hash_function<int64_t>>() };
int* d_SLOT_COUNT_9;
cudaMalloc(&d_SLOT_COUNT_9, sizeof(int));
cudaMemset(d_SLOT_COUNT_9, 0, sizeof(int));
//Aggregate in hashtable
DBI64Type* d_aggr0__tmp_attr0;
cudaMalloc(&d_aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT9);
cudaMemset(d_aggr0__tmp_attr0, 0, sizeof(DBI64Type) * COUNT9);
DBI16Type* d_KEY_9part__p_brand_encoded;
cudaMalloc(&d_KEY_9part__p_brand_encoded, sizeof(DBI16Type) * COUNT9);
cudaMemset(d_KEY_9part__p_brand_encoded, 0, sizeof(DBI16Type) * COUNT9);
DBI16Type* d_KEY_9part__p_type_encoded;
cudaMalloc(&d_KEY_9part__p_type_encoded, sizeof(DBI16Type) * COUNT9);
cudaMemset(d_KEY_9part__p_type_encoded, 0, sizeof(DBI16Type) * COUNT9);
DBI32Type* d_KEY_9part__p_size;
cudaMalloc(&d_KEY_9part__p_size, sizeof(DBI32Type) * COUNT9);
cudaMemset(d_KEY_9part__p_size, 0, sizeof(DBI32Type) * COUNT9);
main_7<<<std::ceil((float)partsupp_size/(float)TILE_SIZE), TB>>>(d_BUF_6, d_HT_6.ref(cuco::find), d_HT_8.ref(cuco::find), d_HT_9.ref(cuco::insert_and_find), d_KEY_9part__p_brand_encoded, d_KEY_9part__p_size, d_KEY_9part__p_type_encoded, d_SLOT_COUNT_9, d_aggr0__tmp_attr0, d_cycles_per_warp_main_7_aggregation_9, d_cycles_per_warp_main_7_anti_semi_join_probe_8, d_cycles_per_warp_main_7_join_probe_6, d_part__p_brand_encoded, d_part__p_size, d_part__p_type_encoded, d_partsupp__ps_partkey, d_partsupp__ps_suppkey, partsupp_size);
int64_t* cycles_per_warp_main_7_join_probe_6 = (int64_t*)malloc(sizeof(int64_t) * main_7_join_probe_6_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_join_probe_6, d_cycles_per_warp_main_7_join_probe_6, sizeof(int64_t) * main_7_join_probe_6_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_join_probe_6 ";
for (auto i=0ull; i < main_7_join_probe_6_cpw_size; i++) std::cout << cycles_per_warp_main_7_join_probe_6[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_anti_semi_join_probe_8 = (int64_t*)malloc(sizeof(int64_t) * main_7_anti_semi_join_probe_8_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_anti_semi_join_probe_8, d_cycles_per_warp_main_7_anti_semi_join_probe_8, sizeof(int64_t) * main_7_anti_semi_join_probe_8_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_anti_semi_join_probe_8 ";
for (auto i=0ull; i < main_7_anti_semi_join_probe_8_cpw_size; i++) std::cout << cycles_per_warp_main_7_anti_semi_join_probe_8[i] << " ";
std::cout << std::endl;
int64_t* cycles_per_warp_main_7_aggregation_9 = (int64_t*)malloc(sizeof(int64_t) * main_7_aggregation_9_cpw_size);
cudaMemcpy(cycles_per_warp_main_7_aggregation_9, d_cycles_per_warp_main_7_aggregation_9, sizeof(int64_t) * main_7_aggregation_9_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_7_aggregation_9 ";
for (auto i=0ull; i < main_7_aggregation_9_cpw_size; i++) std::cout << cycles_per_warp_main_7_aggregation_9[i] << " ";
std::cout << std::endl;
COUNT9 = d_HT_9.size();
int64_t* d_cycles_per_warp_main_11_materialize_10;
auto main_11_materialize_10_cpw_size = std::ceil((float)COUNT9/(float)TILE_SIZE);
cudaMalloc(&d_cycles_per_warp_main_11_materialize_10, sizeof(int64_t) * main_11_materialize_10_cpw_size);
cudaMemset(d_cycles_per_warp_main_11_materialize_10, -1, sizeof(int64_t) * main_11_materialize_10_cpw_size);
size_t COUNT10 = COUNT9;
//Materialize buffers
uint64_t* d_MAT_IDX10;
cudaMalloc(&d_MAT_IDX10, sizeof(uint64_t));
cudaMemset(d_MAT_IDX10, 0, sizeof(uint64_t));
auto MAT10part__p_brand_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT10);
DBI16Type* d_MAT10part__p_brand_encoded;
cudaMalloc(&d_MAT10part__p_brand_encoded, sizeof(DBI16Type) * COUNT10);
auto MAT10part__p_type_encoded = (DBI16Type*)malloc(sizeof(DBI16Type) * COUNT10);
DBI16Type* d_MAT10part__p_type_encoded;
cudaMalloc(&d_MAT10part__p_type_encoded, sizeof(DBI16Type) * COUNT10);
auto MAT10part__p_size = (DBI32Type*)malloc(sizeof(DBI32Type) * COUNT10);
DBI32Type* d_MAT10part__p_size;
cudaMalloc(&d_MAT10part__p_size, sizeof(DBI32Type) * COUNT10);
auto MAT10aggr0__tmp_attr0 = (DBI64Type*)malloc(sizeof(DBI64Type) * COUNT10);
DBI64Type* d_MAT10aggr0__tmp_attr0;
cudaMalloc(&d_MAT10aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT10);
main_11<<<std::ceil((float)COUNT9/(float)TILE_SIZE), TB>>>(COUNT9, d_MAT10aggr0__tmp_attr0, d_MAT10part__p_brand_encoded, d_MAT10part__p_size, d_MAT10part__p_type_encoded, d_MAT_IDX10, d_aggr0__tmp_attr0, d_cycles_per_warp_main_11_materialize_10, d_KEY_9part__p_brand_encoded, d_KEY_9part__p_size, d_KEY_9part__p_type_encoded);
uint64_t MATCOUNT_10 = 0;
cudaMemcpy(&MATCOUNT_10, d_MAT_IDX10, sizeof(uint64_t), cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10part__p_brand_encoded, d_MAT10part__p_brand_encoded, sizeof(DBI16Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10part__p_type_encoded, d_MAT10part__p_type_encoded, sizeof(DBI16Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10part__p_size, d_MAT10part__p_size, sizeof(DBI32Type) * COUNT10, cudaMemcpyDeviceToHost);
cudaMemcpy(MAT10aggr0__tmp_attr0, d_MAT10aggr0__tmp_attr0, sizeof(DBI64Type) * COUNT10, cudaMemcpyDeviceToHost);
auto endTime = std::chrono::high_resolution_clock::now();
auto duration = std::chrono::duration_cast<std::chrono::microseconds>(endTime - startTime);
int64_t* cycles_per_warp_main_11_materialize_10 = (int64_t*)malloc(sizeof(int64_t) * main_11_materialize_10_cpw_size);
cudaMemcpy(cycles_per_warp_main_11_materialize_10, d_cycles_per_warp_main_11_materialize_10, sizeof(int64_t) * main_11_materialize_10_cpw_size, cudaMemcpyDeviceToHost);
std::cout << "main_11_materialize_10 ";
for (auto i=0ull; i < main_11_materialize_10_cpw_size; i++) std::cout << cycles_per_warp_main_11_materialize_10[i] << " ";
std::cout << std::endl;
std::clog << "Used memory: " << used_mem / (1024 * 1024) << " MB" << std::endl; 
size_t aux_mem = usedGpuMem() - used_mem;
std::clog << "Auxiliary memory: " << aux_mem / (1024) << " KB" << std::endl;
cudaFree(d_BUF_6);
cudaFree(d_BUF_IDX_6);
cudaFree(d_KEY_9part__p_brand_encoded);
cudaFree(d_KEY_9part__p_size);
cudaFree(d_KEY_9part__p_type_encoded);
cudaFree(d_aggr0__tmp_attr0);
cudaFree(d_MAT10aggr0__tmp_attr0);
cudaFree(d_MAT10part__p_brand_encoded);
cudaFree(d_MAT10part__p_size);
cudaFree(d_MAT10part__p_type_encoded);
cudaFree(d_MAT_IDX10);
free(MAT10aggr0__tmp_attr0);
free(MAT10part__p_brand_encoded);
free(MAT10part__p_size);
free(MAT10part__p_type_encoded);
}