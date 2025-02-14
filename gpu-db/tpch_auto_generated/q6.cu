#include "utils.h"

#include <cuco/static_map.cuh>

#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

namespace cg = cooperative_groups;
template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_0(int64_t* l_quantity,
                           int32_t* l_shipdate,
                           double* l_discount,
                           double* l_extendedprice,
                           TY_HT0_I HT0_I,
                           TY_HT0_F HT0_F,
                           size_t lineitem_size)
{
  int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
  if (tid >= lineitem_size) return;
  int32_t reg_l_shipdate = l_shipdate[tid];
  if (!(reg_l_shipdate >= 8766)) return;
  if (!(reg_l_shipdate < 9131)) return;
  int64_t reg_l_quantity = l_quantity[tid];
  if (!(reg_l_quantity < 24)) return;
  double reg_l_discount = l_discount[tid];
  if (!(reg_l_discount >= 0.05)) return;
  if (!(reg_l_discount <= 0.07)) return;
  double reg_l_extendedprice = l_extendedprice[tid];
  double reg_revenue         = (reg_l_extendedprice * reg_l_discount);
  int64_t key0               = 0;
  auto thread                = cg::tiled_partition<1>(cg::this_thread_block());
  HT0_I.insert(thread, cuco::pair{key0, 1});
}

template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_1(double* l_extendedprice,
                           int32_t* l_shipdate,
                           int64_t* l_quantity,
                           double* l_discount,
                           double* agg_revenue,
                           TY_HT0_I HT0_I,
                           TY_HT0_F HT0_F,
                           size_t lineitem_size)
{
  int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
  if (tid >= lineitem_size) return;
  int32_t reg_l_shipdate = l_shipdate[tid];
  if (!(reg_l_shipdate >= 8766)) return;
  if (!(reg_l_shipdate < 9131)) return;
  int64_t reg_l_quantity = l_quantity[tid];
  if (!(reg_l_quantity < 24)) return;
  double reg_l_discount = l_discount[tid];
  if (!(reg_l_discount >= 0.05)) return;
  if (!(reg_l_discount <= 0.07)) return;
  double reg_l_extendedprice = l_extendedprice[tid];
  double reg_revenue         = (reg_l_extendedprice * reg_l_discount);
  int64_t key0               = 0;
  auto slot0                 = HT0_F.find(key0);
  aggregate_sum(&(agg_revenue[slot0->second]), reg_revenue);
}

void control(double* l_discount,
             double* l_extendedprice,
             int64_t* l_quantity,
             int32_t* l_shipdate,
             size_t lineitem_size)
{
  double* d_l_extendedprice;

  cudaMalloc(&d_l_extendedprice, sizeof(double) * lineitem_size);

  cudaMemcpy(
    d_l_extendedprice, l_extendedprice, sizeof(double) * lineitem_size, cudaMemcpyHostToDevice);

  int32_t* d_l_shipdate;

  cudaMalloc(&d_l_shipdate, sizeof(int32_t) * lineitem_size);

  cudaMemcpy(d_l_shipdate, l_shipdate, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);

  int64_t* d_l_quantity;

  cudaMalloc(&d_l_quantity, sizeof(int64_t) * lineitem_size);

  cudaMemcpy(d_l_quantity, l_quantity, sizeof(int64_t) * lineitem_size, cudaMemcpyHostToDevice);

  double* d_l_discount;

  cudaMalloc(&d_l_discount, sizeof(double) * lineitem_size);

  cudaMemcpy(d_l_discount, l_discount, sizeof(double) * lineitem_size, cudaMemcpyHostToDevice);

  double* d_agg_revenue;

  auto HT0 = cuco::static_map{lineitem_size * 2,
                              cuco::empty_key{(int64_t)-1},
                              cuco::empty_value{(int64_t)-1},
                              thrust::equal_to<int64_t>{},
                              cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

  auto d_HT0_F = HT0.ref(cuco::find);

  auto d_HT0_I = HT0.ref(cuco::insert);

  pipeline_0<<<std::ceil((float)lineitem_size / (float)32), 32>>>(
    d_l_quantity, d_l_shipdate, d_l_discount, d_l_extendedprice, d_HT0_I, d_HT0_F, lineitem_size);

  auto HT0_size = HT0.size();

  cudaMalloc(&d_agg_revenue, sizeof(double) * HT0_size);

  cudaMemset(d_agg_revenue, 0, sizeof(double) * HT0_size);

  thrust::device_vector<int64_t> keys_0(HT0_size), vals_0(HT0_size);
  HT0.retrieve_all(keys_0.begin(), vals_0.begin());
  thrust::host_vector<int64_t> h_keys_0(HT0_size);
  thrust::copy(keys_0.begin(), keys_0.end(), h_keys_0.begin());
  thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_0(HT0_size);
  for (int i = 0; i < HT0_size; i++) {
    actual_dict_0[i] = cuco::make_pair(h_keys_0[i], i);
  }
  HT0.clear();
  HT0.insert(actual_dict_0.begin(), actual_dict_0.end());
  pipeline_1<<<std::ceil((float)lineitem_size / (float)32), 32>>>(d_l_extendedprice,
                                                                  d_l_shipdate,
                                                                  d_l_quantity,
                                                                  d_l_discount,
                                                                  d_agg_revenue,
                                                                  d_HT0_I,
                                                                  d_HT0_F,
                                                                  lineitem_size);

  size_t agg_size       = HT0_size;
  double* p_agg_revenue = (double*)malloc(sizeof(double) * agg_size);
  cudaMemcpy(p_agg_revenue, d_agg_revenue, sizeof(double) * agg_size, cudaMemcpyDeviceToHost);
  for (int i = 0; i < agg_size; i++) {
    std::cout << p_agg_revenue[i] << "\t";
    std::cout << std::endl;
  }
}

int main(int argc, const char** argv)
{
  std::string dbDir         = getDataDir(argv, argc);
  std::string lineitem_file = dbDir + "lineitem.parquet";

  // auto lineitem_table  = getArrowTable(lineitem_file);
  auto lineitem_table  = getArrowTable(lineitem_file);
  size_t lineitem_size = lineitem_table->num_rows();

  auto l_shipdate      = read_column<int32_t>(lineitem_table, "l_shipdate");
  auto l_quantity      = read_column<int64_t>(lineitem_table, "l_quantity");
  auto l_discount      = read_column<double>(lineitem_table, "l_discount");
  auto l_extendedprice = read_column<double>(lineitem_table, "l_extendedprice");

  // for (auto p: c_mktsegment->dict) {
  //   std::cout << p.first << " " << (int)p.second << std::endl;
  // }
  control(
    l_discount.data(), l_extendedprice.data(), l_quantity.data(), l_shipdate.data(), lineitem_size);
}