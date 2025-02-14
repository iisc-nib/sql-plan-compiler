#include "utils.h"

#include <cuco/static_map.cuh>

#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
namespace cg = cooperative_groups;

template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_0(double *l_discount, int32_t *l_shipdate, int8_t *l_linestatus, int8_t *l_returnflag, double *l_extendedprice, double *l_tax, TY_HT0_I HT0_I, TY_HT0_F HT0_F, size_t lineitem_size)
{
  int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
  if (tid >= lineitem_size)
    return;
  int32_t reg_l_shipdate = l_shipdate[tid];
  if (!(reg_l_shipdate <= 10471))
    return;
  double reg_l_extendedprice = l_extendedprice[tid];
  double reg_l_discount = l_discount[tid];
  double reg_sum_disc_price = (reg_l_extendedprice * (1 - reg_l_discount));
  double reg_l_tax = l_tax[tid];
  double reg_sum_charge = ((reg_l_extendedprice * (1 - reg_l_discount)) * (1 + reg_l_tax));
  int8_t reg_l_returnflag = l_returnflag[tid];
  int8_t reg_l_linestatus = l_linestatus[tid];
  int64_t key0 = 0;
  key0 |= (((int64_t)reg_l_returnflag) << 0);
  key0 |= (((int64_t)reg_l_linestatus) << 8);
  auto thread = cg::tiled_partition<1>(cg::this_thread_block());
  HT0_I.insert(thread, cuco::pair{key0, 1});
}

template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_1(double *l_discount, int32_t *l_shipdate, int8_t *l_linestatus, int8_t *l_returnflag, double *l_extendedprice, double *l_tax, int64_t *l_quantity, double *sum_disc_price, int8_t *agg_l_linestatus, double *sum_discount, int64_t *sum_qty, double *sum_charge, double *sum_base_price, int64_t *count_order, int8_t *agg_l_returnflag, TY_HT0_I HT0_I, TY_HT0_F HT0_F, size_t lineitem_size)
{
  int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
  if (tid >= lineitem_size)
    return;
  int32_t reg_l_shipdate = l_shipdate[tid];
  if (!(reg_l_shipdate <= 10471))
    return;
  double reg_l_extendedprice = l_extendedprice[tid];
  double reg_l_discount = l_discount[tid];
  double reg_sum_disc_price = (reg_l_extendedprice * (1 - reg_l_discount));
  double reg_l_tax = l_tax[tid];
  double reg_sum_charge = ((reg_l_extendedprice * (1 - reg_l_discount)) * (1 + reg_l_tax));
  int8_t reg_l_returnflag = l_returnflag[tid];
  int8_t reg_l_linestatus = l_linestatus[tid];
  int64_t key0 = 0;
  key0 |= (((int64_t)reg_l_returnflag) << 0);
  key0 |= (((int64_t)reg_l_linestatus) << 8);
  auto slot0 = HT0_F.find(key0);
  int64_t reg_l_quantity = l_quantity[tid];
  agg_l_returnflag[slot0->second] = reg_l_returnflag;
  agg_l_linestatus[slot0->second] = reg_l_linestatus;
  aggregate_sum(&(sum_qty[slot0->second]), reg_l_quantity);
  aggregate_sum(&(sum_discount[slot0->second]), reg_l_discount);
  aggregate_sum(&(sum_base_price[slot0->second]), reg_l_extendedprice);
  aggregate_sum(&(sum_disc_price[slot0->second]), reg_sum_disc_price);
  aggregate_sum(&(sum_charge[slot0->second]), reg_sum_charge);
  aggregate_sum(&(count_order[slot0->second]), 1);
}

void control(
    double *l_discount,
    double *l_extendedprice,
    int8_t *l_linestatus,
    int64_t *l_quantity,
    int8_t *l_returnflag,
    int32_t *l_shipdate,
    double *l_tax,
    size_t lineitem_size)
{
  double *d_l_discount;

  cudaMalloc(&d_l_discount, sizeof(double) * lineitem_size);

  cudaMemcpy(d_l_discount, l_discount, sizeof(double) * lineitem_size, cudaMemcpyHostToDevice);

  int32_t *d_l_shipdate;

  cudaMalloc(&d_l_shipdate, sizeof(int32_t) * lineitem_size);

  cudaMemcpy(d_l_shipdate, l_shipdate, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);

  int8_t *d_l_linestatus;

  cudaMalloc(&d_l_linestatus, sizeof(int8_t) * lineitem_size);

  cudaMemcpy(d_l_linestatus, l_linestatus, sizeof(int8_t) * lineitem_size, cudaMemcpyHostToDevice);

  int8_t *d_l_returnflag;

  cudaMalloc(&d_l_returnflag, sizeof(int8_t) * lineitem_size);

  cudaMemcpy(d_l_returnflag, l_returnflag, sizeof(int8_t) * lineitem_size, cudaMemcpyHostToDevice);

  double *d_l_extendedprice;

  cudaMalloc(&d_l_extendedprice, sizeof(double) * lineitem_size);

  cudaMemcpy(d_l_extendedprice, l_extendedprice, sizeof(double) * lineitem_size, cudaMemcpyHostToDevice);

  double *d_l_tax;

  cudaMalloc(&d_l_tax, sizeof(double) * lineitem_size);

  cudaMemcpy(d_l_tax, l_tax, sizeof(double) * lineitem_size, cudaMemcpyHostToDevice);

  int64_t *d_l_quantity;

  cudaMalloc(&d_l_quantity, sizeof(int64_t) * lineitem_size);

  cudaMemcpy(d_l_quantity, l_quantity, sizeof(int64_t) * lineitem_size, cudaMemcpyHostToDevice);

  double *d_sum_disc_price;

  int8_t *d_agg_l_linestatus;

  double *d_sum_discount;

  int64_t *d_sum_qty;

  double *d_sum_charge;

  double *d_sum_base_price;

  int64_t *d_count_order;

  int8_t *d_agg_l_returnflag;

  auto HT0 = cuco::static_map{lineitem_size * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

  auto d_HT0_F = HT0.ref(cuco::find);

  auto d_HT0_I = HT0.ref(cuco::insert);

  pipeline_0<<<std::ceil((float)lineitem_size / (float)32), 32>>>(d_l_discount, d_l_shipdate, d_l_linestatus, d_l_returnflag, d_l_extendedprice, d_l_tax, d_HT0_I, d_HT0_F, lineitem_size);

  auto HT0_size = HT0.size();

  cudaMalloc(&d_sum_disc_price, sizeof(double) * HT0_size);

  cudaMalloc(&d_agg_l_linestatus, sizeof(int8_t) * HT0_size);

  cudaMalloc(&d_sum_discount, sizeof(double) * HT0_size);

  cudaMalloc(&d_sum_qty, sizeof(int64_t) * HT0_size);

  cudaMalloc(&d_sum_charge, sizeof(double) * HT0_size);

  cudaMalloc(&d_sum_base_price, sizeof(double) * HT0_size);

  cudaMalloc(&d_count_order, sizeof(int64_t) * HT0_size);

  cudaMalloc(&d_agg_l_returnflag, sizeof(int8_t) * HT0_size);

  cudaMemset(d_sum_disc_price, 0, sizeof(double) * HT0_size);

  cudaMemset(d_agg_l_linestatus, 0, sizeof(int8_t) * HT0_size);

  cudaMemset(d_sum_discount, 0, sizeof(double) * HT0_size);

  cudaMemset(d_sum_qty, 0, sizeof(int64_t) * HT0_size);

  cudaMemset(d_sum_charge, 0, sizeof(double) * HT0_size);

  cudaMemset(d_sum_base_price, 0, sizeof(double) * HT0_size);

  cudaMemset(d_count_order, 0, sizeof(int64_t) * HT0_size);

  cudaMemset(d_agg_l_returnflag, 0, sizeof(int8_t) * HT0_size);

  thrust::device_vector<int64_t> keys_0(HT0_size), vals_0(HT0_size);
  HT0.retrieve_all(keys_0.begin(), vals_0.begin());
  thrust::host_vector<int64_t> h_keys_0(HT0_size);
  thrust::copy(keys_0.begin(), keys_0.end(), h_keys_0.begin());
  thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_0(HT0_size);
  for (int i = 0; i < HT0_size; i++)
  {
    actual_dict_0[i] = cuco::make_pair(h_keys_0[i], i);
  }
  HT0.clear();
  HT0.insert(actual_dict_0.begin(), actual_dict_0.end());
  pipeline_1<<<std::ceil((float)lineitem_size / (float)32), 32>>>(d_l_discount, d_l_shipdate, d_l_linestatus, d_l_returnflag, d_l_extendedprice, d_l_tax, d_l_quantity, d_sum_disc_price, d_agg_l_linestatus, d_sum_discount, d_sum_qty, d_sum_charge, d_sum_base_price, d_count_order, d_agg_l_returnflag, d_HT0_I, d_HT0_F, lineitem_size);

  size_t agg_size = HT0_size;
  int8_t *p_agg_l_returnflag = (int8_t *)malloc(sizeof(int8_t) * agg_size);
  cudaMemcpy(p_agg_l_returnflag, d_agg_l_returnflag, sizeof(int8_t) * agg_size, cudaMemcpyDeviceToHost);
  int8_t *p_agg_l_linestatus = (int8_t *)malloc(sizeof(int8_t) * agg_size);
  cudaMemcpy(p_agg_l_linestatus, d_agg_l_linestatus, sizeof(int8_t) * agg_size, cudaMemcpyDeviceToHost);
  int64_t *p_sum_qty = (int64_t *)malloc(sizeof(int64_t) * agg_size);
  cudaMemcpy(p_sum_qty, d_sum_qty, sizeof(int64_t) * agg_size, cudaMemcpyDeviceToHost);
  double *p_sum_discount = (double *)malloc(sizeof(double) * agg_size);
  cudaMemcpy(p_sum_discount, d_sum_discount, sizeof(double) * agg_size, cudaMemcpyDeviceToHost);
  double *p_sum_base_price = (double *)malloc(sizeof(double) * agg_size);
  cudaMemcpy(p_sum_base_price, d_sum_base_price, sizeof(double) * agg_size, cudaMemcpyDeviceToHost);
  double *p_sum_disc_price = (double *)malloc(sizeof(double) * agg_size);
  cudaMemcpy(p_sum_disc_price, d_sum_disc_price, sizeof(double) * agg_size, cudaMemcpyDeviceToHost);
  double *p_sum_charge = (double *)malloc(sizeof(double) * agg_size);
  cudaMemcpy(p_sum_charge, d_sum_charge, sizeof(double) * agg_size, cudaMemcpyDeviceToHost);
  int64_t *p_count_order = (int64_t *)malloc(sizeof(int64_t) * agg_size);
  cudaMemcpy(p_count_order, d_count_order, sizeof(int64_t) * agg_size, cudaMemcpyDeviceToHost);
  for (int i = 0; i < agg_size; i++)
  {
    std::cout << (int)p_agg_l_returnflag[i] << "\t";
    std::cout << p_agg_l_returnflag[i] << "\t";
    std::cout << (int)p_agg_l_linestatus[i] << "\t";
    std::cout << p_agg_l_linestatus[i] << "\t";
    std::cout << p_sum_qty[i] << "\t";
    std::cout << p_sum_discount[i] << "\t";
    std::cout << p_sum_base_price[i] << "\t";
    std::cout << p_sum_disc_price[i] << "\t";
    std::cout << p_sum_charge[i] << "\t";
    std::cout << p_count_order[i] << "\t";
    std::cout << std::endl;
  }
}
int main(int argc, const char **argv)
{
  std::string dbDir = getDataDir(argv, argc);
  std::string lineitem_file = dbDir + "lineitem.parquet";

  auto lineitem_table = getArrowTable(lineitem_file);
  size_t lineitem_size = lineitem_table->num_rows();

  auto l_quantity = read_column<int64_t>(lineitem_table, "l_quantity");
  auto l_shipdate = read_column<int32_t>(lineitem_table, "l_shipdate");
  auto l_extendedprice = read_column<double>(lineitem_table, "l_extendedprice");
  auto l_discount = read_column<double>(lineitem_table, "l_discount");
  auto l_tax = read_column<double>(lineitem_table, "l_tax");
  StringDictEncodedColumn *l_returnflag =
      read_string_dict_encoded_column(lineitem_table, "l_returnflag");
  StringDictEncodedColumn *l_linestatus =
      read_string_dict_encoded_column(lineitem_table, "l_linestatus");
  control(l_discount.data(),
          l_extendedprice.data(),
          l_linestatus->column,
          l_quantity.data(),
          l_returnflag->column,
          l_shipdate.data(),
          l_tax.data(),
          lineitem_size);
}