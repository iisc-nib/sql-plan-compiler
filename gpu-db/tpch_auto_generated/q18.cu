#include "utils.h"

#include <cuco/static_map.cuh>

#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

namespace cg = cooperative_groups;
template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_0 (int32_t* l_orderkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, size_t lineitem_size) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= lineitem_size) return;
int32_t reg_l_orderkey = l_orderkey[tid];
int64_t key0 = 0;
key0 |= (((int64_t)reg_l_orderkey) << 0);
auto thread = cg::tiled_partition<1>(cg::this_thread_block());
HT0_I.insert(thread, cuco::pair{key0, 1});
}

template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_1 (int64_t* l_quantity, int32_t* l_orderkey, int64_t* agg1_l_quantity, int32_t* agg1_l_orderkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, size_t lineitem_size) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= lineitem_size) return;
int32_t reg_l_orderkey = l_orderkey[tid];
int64_t key0 = 0;
key0 |= (((int64_t)reg_l_orderkey) << 0);
auto slot0 = HT0_F.find(key0);
int64_t reg_l_quantity = l_quantity[tid];
agg1_l_orderkey[slot0->second] = reg_l_orderkey;
aggregate_sum(&(agg1_l_quantity[slot0->second]), reg_l_quantity);
}

__global__ void pipeline_3 (int32_t* c_custkey, size_t customer_size, int64_t* B2_idx) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= customer_size) return;
int32_t reg_c_custkey = c_custkey[tid];
int64_t key2 = 0;
key2 |= (((int64_t)reg_c_custkey) << 0);
atomicAdd((int*)B2_idx, 1);
}

template <typename TY_HT2_I, typename TY_HT2_F>
__global__ void pipeline_2 (int32_t* c_custkey, TY_HT2_I HT2_I, TY_HT2_F HT2_F, size_t customer_size, int64_t* B2_customer, int64_t* B2_idx) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= customer_size) return;
int32_t reg_c_custkey = c_custkey[tid];
int64_t key2 = 0;
key2 |= (((int64_t)reg_c_custkey) << 0);
auto reg_B2_idx = atomicAdd((int*)B2_idx, 1);
auto thread = cg::tiled_partition<1>(cg::this_thread_block());
HT2_I.insert(thread, cuco::pair{key2, reg_B2_idx});
B2_customer[reg_B2_idx] = tid;
}


__global__ void pipeline_5 (int32_t* o_orderkey, int64_t* B1_idx, size_t orders_size) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= orders_size) return;
int32_t reg_o_orderkey = o_orderkey[tid];
int64_t key1 = 0;
key1 |= (((int64_t)reg_o_orderkey) << 0);
atomicAdd((int*)B1_idx, 1);
}

template <typename TY_HT1_I, typename TY_HT1_F>
__global__ void pipeline_4 (int32_t* o_orderkey, TY_HT1_I HT1_I, TY_HT1_F HT1_F, int64_t* B1_idx, size_t orders_size, int64_t* B1_orders) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= orders_size) return;
int32_t reg_o_orderkey = o_orderkey[tid];
int64_t key1 = 0;
key1 |= (((int64_t)reg_o_orderkey) << 0);
auto reg_B1_idx = atomicAdd((int*)B1_idx, 1);
auto thread = cg::tiled_partition<1>(cg::this_thread_block());
HT1_I.insert(thread, cuco::pair{key1, reg_B1_idx});
B1_orders[reg_B1_idx] = tid;
}

template <typename TY_HT1_I, typename TY_HT1_F, typename TY_HT2_I, typename TY_HT2_F>
__global__ void pipeline_7 (int32_t* o_orderkey, int32_t* o_custkey, int64_t* agg1_l_quantity, int32_t* agg1_l_orderkey, TY_HT1_I HT1_I, TY_HT1_F HT1_F, TY_HT2_I HT2_I, TY_HT2_F HT2_F, int64_t* B2_customer, int64_t* B1_orders, int64_t* B3_idx, size_t agg1_size) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= agg1_size) return;
int64_t reg_agg1_l_quantity = agg1_l_quantity[tid];
if (!(reg_agg1_l_quantity  > 300)) return;
int32_t reg_agg1_l_orderkey = agg1_l_orderkey[tid];
int64_t key1 = 0;
key1 |= (((int64_t)reg_agg1_l_orderkey) << 0);
auto slot1 = HT1_F.find(key1);
if (slot1 == HT1_F.end()) return;int32_t reg_o_custkey = o_custkey[B1_orders[slot1->second]];
int64_t key2 = 0;
key2 |= (((int64_t)reg_o_custkey) << 0);
auto slot2 = HT2_F.find(key2);
if (slot2 == HT2_F.end()) return;int32_t reg_o_orderkey = o_orderkey[B1_orders[slot1->second]];
int64_t key3 = 0;
key3 |= (((int64_t)reg_o_orderkey) << 0);
atomicAdd((int*)B3_idx, 1);
}

template <typename TY_HT1_I, typename TY_HT1_F, typename TY_HT2_I, typename TY_HT2_F, typename TY_HT3_I, typename TY_HT3_F>
__global__ void pipeline_6 (int32_t* o_orderkey, int32_t* o_custkey, int64_t* agg1_l_quantity, int32_t* agg1_l_orderkey, TY_HT1_I HT1_I, TY_HT1_F HT1_F, TY_HT2_I HT2_I, TY_HT2_F HT2_F, TY_HT3_I HT3_I, TY_HT3_F HT3_F, int64_t* B1_orders, int64_t* B3_agg1, int64_t* B3_idx, size_t agg1_size, int64_t* B2_customer, int64_t* B3_orders, int64_t* B3_customer) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= agg1_size) return;
int64_t reg_agg1_l_quantity = agg1_l_quantity[tid];
if (!(reg_agg1_l_quantity  > 300)) return;
int32_t reg_agg1_l_orderkey = agg1_l_orderkey[tid];
int64_t key1 = 0;
key1 |= (((int64_t)reg_agg1_l_orderkey) << 0);
auto slot1 = HT1_F.find(key1);
if (slot1 == HT1_F.end()) return;int32_t reg_o_custkey = o_custkey[B1_orders[slot1->second]];
int64_t key2 = 0;
key2 |= (((int64_t)reg_o_custkey) << 0);
auto slot2 = HT2_F.find(key2);
if (slot2 == HT2_F.end()) return;int32_t reg_o_orderkey = o_orderkey[B1_orders[slot1->second]];
int64_t key3 = 0;
key3 |= (((int64_t)reg_o_orderkey) << 0);
auto reg_B3_idx = atomicAdd((int*)B3_idx, 1);
auto thread = cg::tiled_partition<1>(cg::this_thread_block());
HT3_I.insert(thread, cuco::pair{key3, reg_B3_idx});
B3_orders[reg_B3_idx] = B1_orders[slot1->second];
B3_agg1[reg_B3_idx] = tid;
B3_customer[reg_B3_idx] = B2_customer[slot2->second];
}

template <typename TY_HT3_I, typename TY_HT3_F, typename TY_HT4_I, typename TY_HT4_F>
__global__ void pipeline_8 (int32_t* l_orderkey, int32_t* o_orderkey, TY_HT3_I HT3_I, TY_HT3_F HT3_F, TY_HT4_I HT4_I, TY_HT4_F HT4_F, int64_t* B3_customer, size_t lineitem_size, int64_t* B3_orders, int64_t* B3_agg1) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= lineitem_size) return;
int32_t reg_l_orderkey = l_orderkey[tid];
int64_t key3 = 0;
key3 |= (((int64_t)reg_l_orderkey) << 0);
auto slot3 = HT3_F.find(key3);
if (slot3 == HT3_F.end()) return;int32_t reg_o_orderkey = o_orderkey[B3_orders[slot3->second]];
int64_t key4 = 0;
key4 |= (((int64_t)reg_o_orderkey) << 0);
auto thread = cg::tiled_partition<1>(cg::this_thread_block());
HT4_I.insert(thread, cuco::pair{key4, 1});
}

template <typename TY_HT3_I, typename TY_HT3_F, typename TY_HT4_I, typename TY_HT4_F>
__global__ void pipeline_9 (int64_t* l_quantity, int32_t* l_orderkey, int32_t* o_orderkey, int32_t* agg2_o_orderkey, int64_t* agg2_l_quantity, TY_HT3_I HT3_I, TY_HT3_F HT3_F, TY_HT4_I HT4_I, TY_HT4_F HT4_F, int64_t* B3_agg1, size_t lineitem_size, int64_t* B3_orders, int64_t* B3_customer) {
int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
if (tid >= lineitem_size) return;
int32_t reg_l_orderkey = l_orderkey[tid];
int64_t key3 = 0;
key3 |= (((int64_t)reg_l_orderkey) << 0);
auto slot3 = HT3_F.find(key3);
if (slot3 == HT3_F.end()) return;int32_t reg_o_orderkey = o_orderkey[B3_orders[slot3->second]];
int64_t key4 = 0;
key4 |= (((int64_t)reg_o_orderkey) << 0);
auto slot4 = HT4_F.find(key4);
int64_t reg_l_quantity = l_quantity[tid];
agg2_o_orderkey[slot4->second] = reg_o_orderkey;
aggregate_sum(&(agg2_l_quantity[slot4->second]), reg_l_quantity);
}

void control(
int32_t *c_custkey,
int32_t *l_orderkey,
int64_t *l_quantity,
int32_t *o_custkey,
int32_t *o_orderkey,
size_t customer_size,
size_t lineitem_size,
size_t orders_size
) {
    int64_t* d_l_quantity;

cudaMalloc(&d_l_quantity, sizeof(int64_t) * lineitem_size);

cudaMemcpy(d_l_quantity, l_quantity, sizeof(int64_t) * lineitem_size, cudaMemcpyHostToDevice);

int32_t* d_l_orderkey;

cudaMalloc(&d_l_orderkey, sizeof(int32_t) * lineitem_size);

cudaMemcpy(d_l_orderkey, l_orderkey, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);

int64_t* d_agg1_l_quantity;

int32_t* d_agg1_l_orderkey;

auto HT0 = cuco::static_map{ lineitem_size * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

auto d_HT0_F = HT0.ref(cuco::find);

auto d_HT0_I = HT0.ref(cuco::insert);

pipeline_0<<<std::ceil((float)lineitem_size/(float)32), 32>>>(d_l_orderkey, d_HT0_I, d_HT0_F, lineitem_size);

auto HT0_size = HT0.size();

cudaMalloc(&d_agg1_l_quantity, sizeof(int64_t) * HT0_size);

cudaMalloc(&d_agg1_l_orderkey, sizeof(int32_t) * HT0_size);

cudaMemset(d_agg1_l_quantity, 0, sizeof(int64_t) * HT0_size);

cudaMemset(d_agg1_l_orderkey, 0, sizeof(int32_t) * HT0_size);

thrust::device_vector<int64_t> keys_0(HT0_size), vals_0(HT0_size);
HT0.retrieve_all(keys_0.begin(), vals_0.begin());
thrust::host_vector<int64_t> h_keys_0(HT0_size);
thrust::copy(keys_0.begin(), keys_0.end(), h_keys_0.begin());
thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_0(HT0_size);
for (int i=0; i < HT0_size; i++) {
actual_dict_0[i] = cuco::make_pair(h_keys_0[i], i);
}
HT0.clear();
HT0.insert(actual_dict_0.begin(), actual_dict_0.end());
pipeline_1<<<std::ceil((float)lineitem_size/(float)32), 32>>>(d_l_quantity, d_l_orderkey, d_agg1_l_quantity, d_agg1_l_orderkey, d_HT0_I, d_HT0_F, lineitem_size);

size_t agg1_size = HT0_size;
int32_t* d_c_custkey;

cudaMalloc(&d_c_custkey, sizeof(int32_t) * customer_size);

cudaMemcpy(d_c_custkey, c_custkey, sizeof(int32_t) * customer_size, cudaMemcpyHostToDevice);

int64_t* B2_customer;
int64_t* B2_idx;
cudaMalloc(&B2_idx, sizeof(int64_t));
cudaMemset(B2_idx, 0, sizeof(int64_t));
pipeline_3<<<std::ceil((float)customer_size/(float)32), 32>>>(d_c_custkey, customer_size, B2_idx);

int64_t h_B2_idx;
cudaMemcpy(&h_B2_idx, B2_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
cudaMemset(B2_idx, 0, sizeof(int64_t));
cudaMalloc(&B2_customer, sizeof(int64_t) * h_B2_idx);
auto HT2 = cuco::static_map{ h_B2_idx * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

auto d_HT2_F = HT2.ref(cuco::find);

auto d_HT2_I = HT2.ref(cuco::insert);

pipeline_2<<<std::ceil((float)customer_size/(float)32), 32>>>(d_c_custkey, d_HT2_I, d_HT2_F, customer_size, B2_customer, B2_idx);

int32_t* d_o_orderkey;

cudaMalloc(&d_o_orderkey, sizeof(int32_t) * orders_size);

cudaMemcpy(d_o_orderkey, o_orderkey, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);

int64_t* B1_orders;
int64_t* B1_idx;
cudaMalloc(&B1_idx, sizeof(int64_t));
cudaMemset(B1_idx, 0, sizeof(int64_t));
pipeline_5<<<std::ceil((float)orders_size/(float)32), 32>>>(d_o_orderkey, B1_idx, orders_size);

int64_t h_B1_idx;
cudaMemcpy(&h_B1_idx, B1_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
cudaMemset(B1_idx, 0, sizeof(int64_t));
cudaMalloc(&B1_orders, sizeof(int64_t) * h_B1_idx);
auto HT1 = cuco::static_map{ h_B1_idx * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

auto d_HT1_F = HT1.ref(cuco::find);

auto d_HT1_I = HT1.ref(cuco::insert);

pipeline_4<<<std::ceil((float)orders_size/(float)32), 32>>>(d_o_orderkey, d_HT1_I, d_HT1_F, B1_idx, orders_size, B1_orders);

int32_t* d_o_custkey;

cudaMalloc(&d_o_custkey, sizeof(int32_t) * orders_size);

cudaMemcpy(d_o_custkey, o_custkey, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);

int64_t* B3_orders;
int64_t* B3_agg1;
int64_t* B3_customer;
int64_t* B3_idx;
cudaMalloc(&B3_idx, sizeof(int64_t));
cudaMemset(B3_idx, 0, sizeof(int64_t));
pipeline_7<<<std::ceil((float)agg1_size/(float)32), 32>>>(d_o_orderkey, d_o_custkey, d_agg1_l_quantity, d_agg1_l_orderkey, d_HT1_I, d_HT1_F, d_HT2_I, d_HT2_F, B2_customer, B1_orders, B3_idx, agg1_size);

int64_t h_B3_idx;
cudaMemcpy(&h_B3_idx, B3_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
cudaMemset(B3_idx, 0, sizeof(int64_t));
cudaMalloc(&B3_orders, sizeof(int64_t) * h_B3_idx);
cudaMalloc(&B3_agg1, sizeof(int64_t) * h_B3_idx);
cudaMalloc(&B3_customer, sizeof(int64_t) * h_B3_idx);
auto HT3 = cuco::static_map{ h_B3_idx * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

auto d_HT3_F = HT3.ref(cuco::find);

auto d_HT3_I = HT3.ref(cuco::insert);

pipeline_6<<<std::ceil((float)agg1_size/(float)32), 32>>>(d_o_orderkey, d_o_custkey, d_agg1_l_quantity, d_agg1_l_orderkey, d_HT1_I, d_HT1_F, d_HT2_I, d_HT2_F, d_HT3_I, d_HT3_F, B1_orders, B3_agg1, B3_idx, agg1_size, B2_customer, B3_orders, B3_customer);

int32_t* d_agg2_o_orderkey;

int64_t* d_agg2_l_quantity;

auto HT4 = cuco::static_map{ lineitem_size * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

auto d_HT4_F = HT4.ref(cuco::find);

auto d_HT4_I = HT4.ref(cuco::insert);

pipeline_8<<<std::ceil((float)lineitem_size/(float)32), 32>>>(d_l_orderkey, d_o_orderkey, d_HT3_I, d_HT3_F, d_HT4_I, d_HT4_F, B3_customer, lineitem_size, B3_orders, B3_agg1);

auto HT4_size = HT4.size();

cudaMalloc(&d_agg2_o_orderkey, sizeof(int32_t) * HT4_size);

cudaMalloc(&d_agg2_l_quantity, sizeof(int64_t) * HT4_size);

cudaMemset(d_agg2_o_orderkey, 0, sizeof(int32_t) * HT4_size);

cudaMemset(d_agg2_l_quantity, 0, sizeof(int64_t) * HT4_size);

thrust::device_vector<int64_t> keys_4(HT4_size), vals_4(HT4_size);
HT4.retrieve_all(keys_4.begin(), vals_4.begin());
thrust::host_vector<int64_t> h_keys_4(HT4_size);
thrust::copy(keys_4.begin(), keys_4.end(), h_keys_4.begin());
thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_4(HT4_size);
for (int i=0; i < HT4_size; i++) {
actual_dict_4[i] = cuco::make_pair(h_keys_4[i], i);
}
HT4.clear();
HT4.insert(actual_dict_4.begin(), actual_dict_4.end());
pipeline_9<<<std::ceil((float)lineitem_size/(float)32), 32>>>(d_l_quantity, d_l_orderkey, d_o_orderkey, d_agg2_o_orderkey, d_agg2_l_quantity, d_HT3_I, d_HT3_F, d_HT4_I, d_HT4_F, B3_agg1, lineitem_size, B3_orders, B3_customer);

size_t agg2_size = HT4_size;
int32_t* p_agg2_o_orderkey = (int32_t*)malloc(sizeof(int32_t) * agg2_size);
cudaMemcpy(p_agg2_o_orderkey, d_agg2_o_orderkey, sizeof(int32_t) * agg2_size, cudaMemcpyDeviceToHost);
int64_t* p_agg2_l_quantity = (int64_t*)malloc(sizeof(int64_t) * agg2_size);
cudaMemcpy(p_agg2_l_quantity, d_agg2_l_quantity, sizeof(int64_t) * agg2_size, cudaMemcpyDeviceToHost);
for (int i=0; i<agg2_size; i++) {
std::cout << p_agg2_o_orderkey[i] << "\t";
std::cout << p_agg2_l_quantity[i] << "\t";
std::cout << std::endl;
}
}

int main(int argc, const char** argv)
{
  std::string dbDir         = getDataDir(argv, argc);
  std::string lineitem_file = dbDir + "lineitem.parquet";
  std::string customer_file = dbDir + "customer.parquet";
  std::string orders_file   = dbDir + "orders.parquet";

  auto lineitem_table  = getArrowTable(lineitem_file);
  auto customer_table  = getArrowTable(customer_file);
  auto orders_table    = getArrowTable(orders_file);
  size_t lineitem_size = lineitem_table->num_rows();
  size_t customer_size = customer_table->num_rows();
  size_t orders_size   = orders_table->num_rows();

  auto l_orderkey = read_column_typecasted<int32_t>(lineitem_table, "l_orderkey");
  auto l_quantity = read_column<int64_t>(lineitem_table, "l_quantity");

  auto c_custkey = read_column_typecasted<int32_t>(customer_table, "c_custkey");

  auto o_custkey  = read_column_typecasted<int32_t>(orders_table, "o_custkey");
  auto o_orderkey = read_column_typecasted<int32_t>(orders_table, "o_orderkey");

  // for (auto p: c_mktsegment->dict) {
  //   std::cout << p.first << " " << (int)p.second << std::endl;
  // }
  control(c_custkey.data(),
          l_orderkey.data(),
          l_quantity.data(),
          o_custkey.data(),
          o_orderkey.data(),
          customer_size,
          lineitem_size,
          orders_size);
}