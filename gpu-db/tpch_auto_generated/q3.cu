#include "utils.h"

#include <cuco/static_map.cuh>

#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

namespace cg = cooperative_groups;

__global__ void pipeline_1 (int8_t* c_mktsegment, int32_t* c_custkey, int64_t* B0_idx, size_t customer_size) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= customer_size) return;
int8_t reg_c_mktsegment = c_mktsegment[tid];
if (!(reg_c_mktsegment == 0)) return;
int32_t reg_c_custkey = c_custkey[tid];
int64_t key0 = 0;
key0 |= (((int64_t)reg_c_custkey) << 0);
atomicAdd((int*)B0_idx, 1);
}

template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_0 (int8_t* c_mktsegment, int32_t* c_custkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, int64_t* B0_customer, int64_t* B0_idx, size_t customer_size) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= customer_size) return;
int8_t reg_c_mktsegment = c_mktsegment[tid];
if (!(reg_c_mktsegment == 0)) return;
int32_t reg_c_custkey = c_custkey[tid];
int64_t key0 = 0;
key0 |= (((int64_t)reg_c_custkey) << 0);
auto reg_B0_idx = atomicAdd((int*)B0_idx, 1);
auto thread = cg::tiled_partition<1>(cg::this_thread_block());
HT0_I.insert(thread, cuco::pair{key0, reg_B0_idx});
B0_customer[reg_B0_idx] = tid;
}

template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_3 (int32_t* o_orderdate, int32_t* o_custkey, int32_t* o_orderkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, size_t orders_size, int64_t* B0_customer, int64_t* B1_idx) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= orders_size) return;
int32_t reg_o_orderdate = o_orderdate[tid];
if (!(reg_o_orderdate < 9204)) return;
int32_t reg_o_custkey = o_custkey[tid];
int64_t key0 = 0;
key0 |= (((int64_t)reg_o_custkey) << 0);
auto slot0 = HT0_F.find(key0);
if (slot0 == HT0_F.end()) return;int32_t reg_o_orderkey = o_orderkey[tid];
int64_t key1 = 0;
key1 |= (((int64_t)reg_o_orderkey) << 0);
atomicAdd((int*)B1_idx, 1);
}

template <typename TY_HT0_I, typename TY_HT0_F, typename TY_HT1_I, typename TY_HT1_F>
__global__ void pipeline_2 (int32_t* o_orderdate, int32_t* o_custkey, int32_t* o_orderkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, TY_HT1_I HT1_I, TY_HT1_F HT1_F, int64_t* B1_orders, int64_t* B1_idx, int64_t* B1_customer, size_t orders_size, int64_t* B0_customer) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= orders_size) return;
int32_t reg_o_orderdate = o_orderdate[tid];
if (!(reg_o_orderdate < 9204)) return;
int32_t reg_o_custkey = o_custkey[tid];
int64_t key0 = 0;
key0 |= (((int64_t)reg_o_custkey) << 0);
auto slot0 = HT0_F.find(key0);
if (slot0 == HT0_F.end()) return;int32_t reg_o_orderkey = o_orderkey[tid];
int64_t key1 = 0;
key1 |= (((int64_t)reg_o_orderkey) << 0);
auto reg_B1_idx = atomicAdd((int*)B1_idx, 1);
auto thread = cg::tiled_partition<1>(cg::this_thread_block());
HT1_I.insert(thread, cuco::pair{key1, reg_B1_idx});
B1_orders[reg_B1_idx] = tid;
B1_customer[reg_B1_idx] = B0_customer[slot0->second];
}

template <typename TY_HT1_I, typename TY_HT1_F, typename TY_HT2_I, typename TY_HT2_F>
__global__ void pipeline_4 (double* l_discount, int32_t* l_shipdate, int32_t* l_orderkey, double* l_extendedprice, TY_HT1_I HT1_I, TY_HT1_F HT1_F, TY_HT2_I HT2_I, TY_HT2_F HT2_F, size_t lineitem_size, int64_t* B1_orders, int64_t* B1_customer) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= lineitem_size) return;
int32_t reg_l_shipdate = l_shipdate[tid];
if (!(reg_l_shipdate > 9204)) return;
int32_t reg_l_orderkey = l_orderkey[tid];
int64_t key1 = 0;
key1 |= (((int64_t)reg_l_orderkey) << 0);
auto slot1 = HT1_F.find(key1);
if (slot1 == HT1_F.end()) return;double reg_l_extendedprice = l_extendedprice[tid];
double reg_l_discount = l_discount[tid];
double reg_revenue = (reg_l_extendedprice * (1 - reg_l_discount));
int64_t key2 = 0;
key2 |= (((int64_t)reg_l_orderkey) << 0);
auto thread = cg::tiled_partition<1>(cg::this_thread_block());
HT2_I.insert(thread, cuco::pair{key2, 1});
}

template <typename TY_HT1_I, typename TY_HT1_F, typename TY_HT2_I, typename TY_HT2_F>
__global__ void pipeline_5 (int32_t* o_shippriority, int32_t* l_orderkey, int32_t* o_orderdate, double* l_extendedprice, int32_t* l_shipdate, double* l_discount, int32_t* agg_l_orderkey, int32_t* agg_o_shippriority, double* agg_l_discount, double* revenue, int32_t* agg_o_orderdate, TY_HT1_I HT1_I, TY_HT1_F HT1_F, TY_HT2_I HT2_I, TY_HT2_F HT2_F, size_t lineitem_size, int64_t* B1_orders, int64_t* B1_customer) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= lineitem_size) return;
int32_t reg_l_shipdate = l_shipdate[tid];
if (!(reg_l_shipdate > 9204)) return;
int32_t reg_l_orderkey = l_orderkey[tid];
int64_t key1 = 0;
key1 |= (((int64_t)reg_l_orderkey) << 0);
auto slot1 = HT1_F.find(key1);
if (slot1 == HT1_F.end()) return;double reg_l_extendedprice = l_extendedprice[tid];
double reg_l_discount = l_discount[tid];
double reg_revenue = (reg_l_extendedprice * (1 - reg_l_discount));
int64_t key2 = 0;
key2 |= (((int64_t)reg_l_orderkey) << 0);
auto slot2 = HT2_F.find(key2);
int32_t reg_o_shippriority = o_shippriority[B1_orders[slot1->second]];
int32_t reg_o_orderdate = o_orderdate[B1_orders[slot1->second]];
agg_l_orderkey[slot2->second] = reg_l_orderkey;
aggregate_sum(&(agg_l_discount[slot2->second]), reg_l_discount);
agg_o_shippriority[slot2->second] = reg_o_shippriority;
aggregate_sum(&(revenue[slot2->second]), reg_revenue);
agg_o_orderdate[slot2->second] = reg_o_orderdate;
}

void control(
int32_t *c_custkey,
int8_t *c_mktsegment,
double *l_discount,
double *l_extendedprice,
int32_t *l_orderkey,
int32_t *l_shipdate,
int32_t *o_custkey,
int32_t *o_orderdate,
int32_t *o_orderkey,
int32_t *o_shippriority,
size_t customer_size,
size_t lineitem_size,
size_t orders_size
) {
int8_t* d_c_mktsegment;

cudaMalloc(&d_c_mktsegment, sizeof(int8_t) * customer_size);

cudaMemcpy(d_c_mktsegment, c_mktsegment, sizeof(int8_t) * customer_size, cudaMemcpyHostToDevice);

int32_t* d_c_custkey;

cudaMalloc(&d_c_custkey, sizeof(int32_t) * customer_size);

cudaMemcpy(d_c_custkey, c_custkey, sizeof(int32_t) * customer_size, cudaMemcpyHostToDevice);

int64_t* B0_customer;
int64_t* B0_idx;
cudaMalloc(&B0_idx, sizeof(int64_t));
cudaMemset(B0_idx, 0, sizeof(int64_t));
pipeline_1<<<std::ceil((float)customer_size/(float)32), 32>>>(d_c_mktsegment, d_c_custkey, B0_idx, customer_size);

int64_t h_B0_idx;
cudaMemcpy(&h_B0_idx, B0_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
cudaMemset(B0_idx, 0, sizeof(int64_t));
cudaMalloc(&B0_customer, sizeof(int64_t) * h_B0_idx);
auto HT0 = cuco::static_map{ h_B0_idx * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

auto d_HT0_F = HT0.ref(cuco::find);

auto d_HT0_I = HT0.ref(cuco::insert);

pipeline_0<<<std::ceil((float)customer_size/(float)32), 32>>>(d_c_mktsegment, d_c_custkey, d_HT0_I, d_HT0_F, B0_customer, B0_idx, customer_size);

int32_t* d_o_orderdate;

cudaMalloc(&d_o_orderdate, sizeof(int32_t) * orders_size);

cudaMemcpy(d_o_orderdate, o_orderdate, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);

int32_t* d_o_custkey;

cudaMalloc(&d_o_custkey, sizeof(int32_t) * orders_size);

cudaMemcpy(d_o_custkey, o_custkey, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);

int32_t* d_o_orderkey;

cudaMalloc(&d_o_orderkey, sizeof(int32_t) * orders_size);

cudaMemcpy(d_o_orderkey, o_orderkey, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);

int64_t* B1_orders;
int64_t* B1_customer;
int64_t* B1_idx;
cudaMalloc(&B1_idx, sizeof(int64_t));
cudaMemset(B1_idx, 0, sizeof(int64_t));
pipeline_3<<<std::ceil((float)orders_size/(float)32), 32>>>(d_o_orderdate, d_o_custkey, d_o_orderkey, d_HT0_I, d_HT0_F, orders_size, B0_customer, B1_idx);

int64_t h_B1_idx;
cudaMemcpy(&h_B1_idx, B1_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
cudaMemset(B1_idx, 0, sizeof(int64_t));
cudaMalloc(&B1_orders, sizeof(int64_t) * h_B1_idx);
cudaMalloc(&B1_customer, sizeof(int64_t) * h_B1_idx);
auto HT1 = cuco::static_map{ h_B1_idx * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

auto d_HT1_F = HT1.ref(cuco::find);

auto d_HT1_I = HT1.ref(cuco::insert);

pipeline_2<<<std::ceil((float)orders_size/(float)32), 32>>>(d_o_orderdate, d_o_custkey, d_o_orderkey, d_HT0_I, d_HT0_F, d_HT1_I, d_HT1_F, B1_orders, B1_idx, B1_customer, orders_size, B0_customer);

int32_t* d_o_shippriority;

cudaMalloc(&d_o_shippriority, sizeof(int32_t) * orders_size);

cudaMemcpy(d_o_shippriority, o_shippriority, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);

int32_t* d_l_orderkey;

cudaMalloc(&d_l_orderkey, sizeof(int32_t) * lineitem_size);

cudaMemcpy(d_l_orderkey, l_orderkey, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);

double* d_l_extendedprice;

cudaMalloc(&d_l_extendedprice, sizeof(double) * lineitem_size);

cudaMemcpy(d_l_extendedprice, l_extendedprice, sizeof(double) * lineitem_size, cudaMemcpyHostToDevice);

int32_t* d_l_shipdate;

cudaMalloc(&d_l_shipdate, sizeof(int32_t) * lineitem_size);

cudaMemcpy(d_l_shipdate, l_shipdate, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);

double* d_l_discount;

cudaMalloc(&d_l_discount, sizeof(double) * lineitem_size);

cudaMemcpy(d_l_discount, l_discount, sizeof(double) * lineitem_size, cudaMemcpyHostToDevice);

int32_t* d_agg_l_orderkey;

int32_t* d_agg_o_shippriority;

double* d_agg_l_discount;

double* d_revenue;

int32_t* d_agg_o_orderdate;

auto HT2 = cuco::static_map{ lineitem_size * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

auto d_HT2_F = HT2.ref(cuco::find);

auto d_HT2_I = HT2.ref(cuco::insert);

pipeline_4<<<std::ceil((float)lineitem_size/(float)32), 32>>>(d_l_discount, d_l_shipdate, d_l_orderkey, d_l_extendedprice, d_HT1_I, d_HT1_F, d_HT2_I, d_HT2_F, lineitem_size, B1_orders, B1_customer);

auto HT2_size = HT2.size();

cudaMalloc(&d_agg_l_orderkey, sizeof(int32_t) * HT2_size);

cudaMalloc(&d_agg_o_shippriority, sizeof(int32_t) * HT2_size);

cudaMalloc(&d_agg_l_discount, sizeof(double) * HT2_size);

cudaMalloc(&d_revenue, sizeof(double) * HT2_size);

cudaMalloc(&d_agg_o_orderdate, sizeof(int32_t) * HT2_size);

cudaMemset(d_agg_l_orderkey, 0, sizeof(int32_t) * HT2_size);

cudaMemset(d_agg_o_shippriority, 0, sizeof(int32_t) * HT2_size);

cudaMemset(d_agg_l_discount, 0, sizeof(double) * HT2_size);

cudaMemset(d_revenue, 0, sizeof(double) * HT2_size);

cudaMemset(d_agg_o_orderdate, 0, sizeof(int32_t) * HT2_size);

thrust::device_vector<int64_t> keys_2(HT2_size), vals_2(HT2_size);
HT2.retrieve_all(keys_2.begin(), vals_2.begin());
thrust::host_vector<int64_t> h_keys_2(HT2_size);
thrust::copy(keys_2.begin(), keys_2.end(), h_keys_2.begin());
thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_2(HT2_size);
for (int i=0; i < HT2_size; i++) {
actual_dict_2[i] = cuco::make_pair(h_keys_2[i], i);
}
HT2.clear();
HT2.insert(actual_dict_2.begin(), actual_dict_2.end());
pipeline_5<<<std::ceil((float)lineitem_size/(float)32), 32>>>(d_o_shippriority, d_l_orderkey, d_o_orderdate, d_l_extendedprice, d_l_shipdate, d_l_discount, d_agg_l_orderkey, d_agg_o_shippriority, d_agg_l_discount, d_revenue, d_agg_o_orderdate, d_HT1_I, d_HT1_F, d_HT2_I, d_HT2_F, lineitem_size, B1_orders, B1_customer);

size_t agg_size = HT2_size;
int32_t* p_agg_l_orderkey = (int32_t*)malloc(sizeof(int32_t) * agg_size);
cudaMemcpy(p_agg_l_orderkey, d_agg_l_orderkey, sizeof(int32_t) * agg_size, cudaMemcpyDeviceToHost);
double* p_revenue = (double*)malloc(sizeof(double) * agg_size);
cudaMemcpy(p_revenue, d_revenue, sizeof(double) * agg_size, cudaMemcpyDeviceToHost);
int32_t* p_agg_o_orderdate = (int32_t*)malloc(sizeof(int32_t) * agg_size);
cudaMemcpy(p_agg_o_orderdate, d_agg_o_orderdate, sizeof(int32_t) * agg_size, cudaMemcpyDeviceToHost);
int32_t* p_agg_o_shippriority = (int32_t*)malloc(sizeof(int32_t) * agg_size);
cudaMemcpy(p_agg_o_shippriority, d_agg_o_shippriority, sizeof(int32_t) * agg_size, cudaMemcpyDeviceToHost);
for (int i=0; i<agg_size; i++) {
std::cout << p_agg_l_orderkey[i] << "\t";
std::cout << p_revenue[i] << "\t";
std::cout << p_agg_o_orderdate[i] << "\t";
std::cout << p_agg_o_shippriority[i] << "\t";
std::cout << std::endl;
}
}


int main(int argc, const char** argv)
{
  std::string dbDir         = getDataDir(argv, argc);
  std::string lineitem_file = dbDir + "lineitem.parquet";
  std::string orders_file   = dbDir + "orders.parquet";
  std::string customer_file = dbDir + "customer.parquet";

  // auto lineitem_table  = getArrowTable(lineitem_file);
  auto orders_table    = getArrowTable(orders_file);
  auto customer_table  = getArrowTable(customer_file);
  auto lineitem_table  = getArrowTable(lineitem_file);
  size_t orders_size   = orders_table->num_rows();
  size_t customer_size = customer_table->num_rows();
  size_t lineitem_size = lineitem_table->num_rows();

  auto l_shipdate    = read_column<int32_t>(lineitem_table, "l_shipdate");
  auto l_discount    = read_column<double>(lineitem_table, "l_discount");
  auto l_extendedprice    = read_column<double>(lineitem_table, "l_extendedprice");
  auto l_orderkey      = read_column_typecasted<int32_t>(lineitem_table, "l_orderkey");

  auto o_custkey      = read_column_typecasted<int32_t>(orders_table, "o_custkey");
  auto o_orderdate    = read_column<int32_t>(orders_table, "o_orderdate");
  auto o_shippriority = read_column_typecasted<int32_t>(orders_table, "o_shippriority");
  auto o_orderkey     = read_column_typecasted<int32_t>(orders_table, "o_orderkey");

  StringDictEncodedColumn* c_mktsegment =
    read_string_dict_encoded_column(customer_table, "c_mktsegment");
  auto c_custkey      = read_column_typecasted<int32_t>(customer_table, "c_custkey");

  // for (auto p: c_mktsegment->dict) {
  //   std::cout << p.first << " " << (int)p.second << std::endl;
  // }
  control(
          c_custkey.data(),
          c_mktsegment->column,
          l_discount.data(),
          l_extendedprice.data(),
          l_orderkey.data(),
    l_shipdate.data(),
          o_custkey.data(),
          o_orderdate.data(),
          o_orderkey.data(),
          o_shippriority.data(),
          customer_size,
          lineitem_size,
          orders_size);
}