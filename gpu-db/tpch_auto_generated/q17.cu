#include "utils.h"

#include <cuco/static_map.cuh>

#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <chrono>

namespace cg = cooperative_groups;

__global__ void pipeline_1(int32_t *l_partkey, int32_t *p_partkey, int8_t *p_container, int8_t *p_brand, size_t part_size, int64_t *B0_idx)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= part_size)
        return;
    int8_t reg_p_container = p_container[tid];
    if (!(reg_p_container == 17))
        return;
    int8_t reg_p_brand = p_brand[tid];
    if (!(reg_p_brand == 7))
        return;
    int32_t reg_p_partkey = p_partkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_p_partkey) << 0);
    atomicAdd((int *)B0_idx, 1);
}

template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_0(int32_t *l_partkey, int8_t *p_brand, int32_t *p_partkey, int8_t *p_container, TY_HT0_I HT0_I, TY_HT0_F HT0_F, int64_t *B0_part, size_t part_size, int64_t *B0_idx)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= part_size)
        return;
    int8_t reg_p_container = p_container[tid];
    if (!(reg_p_container ==17))
        return;
    int8_t reg_p_brand = p_brand[tid];
    if (!(reg_p_brand == 7))
        return;
    int32_t reg_p_partkey = p_partkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_p_partkey) << 0);
    auto reg_B0_idx = atomicAdd((int *)B0_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT0_I.insert(thread, cuco::pair{key0, reg_B0_idx});
    B0_part[reg_B0_idx] = tid;
}

template <typename TY_HT0_I, typename TY_HT0_F, typename TY_HT1_I, typename TY_HT1_F>
__global__ void pipeline_2(int32_t *l_partkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, TY_HT1_I HT1_I, TY_HT1_F HT1_F, int64_t *B0_part, size_t lineitem_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= lineitem_size)
        return;
    int32_t reg_l_partkey = l_partkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_l_partkey) << 0);
    auto slot0 = HT0_F.find(key0);
    if (slot0 == HT0_F.end())
        return;
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_l_partkey) << 0);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT1_I.insert(thread, cuco::pair{key1, 1});
}

template <typename TY_HT0_I, typename TY_HT0_F, typename TY_HT1_I, typename TY_HT1_F>
__global__ void pipeline_3(int32_t *l_partkey, int64_t *l_quantity, int64_t *sum_quantity, int32_t *agg_partkey, int64_t *agg_count, TY_HT0_I HT0_I, TY_HT0_F HT0_F, TY_HT1_I HT1_I, TY_HT1_F HT1_F, int64_t *B0_part, size_t lineitem_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= lineitem_size)
        return;
    int32_t reg_l_partkey = l_partkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_l_partkey) << 0);
    auto slot0 = HT0_F.find(key0);
    if (slot0 == HT0_F.end())
        return;
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_l_partkey) << 0);
    auto slot1 = HT1_F.find(key1);
    int64_t reg_l_quantity = l_quantity[tid];
    agg_partkey[slot1->second] = reg_l_partkey;
    aggregate_sum(&(sum_quantity[slot1->second]), reg_l_quantity);
    aggregate_sum(&(agg_count[slot1->second]), 1);
}

__global__ void pipeline_5(int32_t *l_partkey, int64_t *sum_quantity, int64_t *agg_count, int32_t *agg_partkey, int64_t *B2_idx, size_t agg_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= agg_size)
        return;
    int64_t reg_sum_quantity = sum_quantity[tid];
    int64_t reg_agg_count = agg_count[tid];
    int32_t reg_agg_partkey = agg_partkey[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_agg_partkey) << 0);
    atomicAdd((int *)B2_idx, 1);
}

template <typename TY_HT2_I, typename TY_HT2_F>
__global__ void pipeline_4(int32_t *l_partkey, int64_t *agg_count, int64_t *sum_quantity, int32_t *agg_partkey, TY_HT2_I HT2_I, TY_HT2_F HT2_F, int64_t *B2_idx, size_t agg_size, int64_t *B2_agg)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= agg_size)
        return;
    int64_t reg_sum_quantity = sum_quantity[tid];
    int64_t reg_agg_count = agg_count[tid];
    int32_t reg_agg_partkey = agg_partkey[tid];
    int64_t key2 = 0;
    double reg_avg_qty = 0.2 * ((double)reg_sum_quantity / (double)reg_agg_count);
    key2 |= (((int64_t)reg_agg_partkey) << 0);
    auto reg_B2_idx = atomicAdd((int *)B2_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT2_I.insert(thread, cuco::pair{key2, reg_B2_idx});
    B2_agg[reg_B2_idx] = tid;
}

template <typename TY_HT2_I, typename TY_HT2_F, typename TY_HT3_I, typename TY_HT3_F>
__global__ void pipeline_6(int32_t *l_partkey, int64_t *l_quantity, int64_t *sum_quantity, int64_t *agg_count, TY_HT2_I HT2_I, TY_HT2_F HT2_F, TY_HT3_I HT3_I, TY_HT3_F HT3_F, size_t lineitem_size, int64_t *B2_agg)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= lineitem_size)
        return;
    int32_t reg_l_partkey = l_partkey[tid];
    int64_t reg_l_quantity = l_quantity[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_l_partkey) << 0);
    auto slot2 = HT2_F.find(key2);
    if (slot2 == HT2_F.end())
        return;
    // check if reg_l_quantity < sum_quantity[B2_agg[slot2->second]]
    int64_t reg_sum_quantity = sum_quantity[B2_agg[slot2->second]];
    int64_t reg_agg_count = agg_count[B2_agg[slot2->second]];
    double reg_avg_qty = 0.2 * ((double)reg_sum_quantity / (double)reg_agg_count);
    if (!((double)reg_l_quantity < reg_avg_qty))
        return;
    int64_t key3 = 0;
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT3_I.insert(thread, cuco::pair{key3, 1});
}

template <typename TY_HT2_I, typename TY_HT2_F, typename TY_HT3_I, typename TY_HT3_F>
__global__ void pipeline_7(int32_t *l_partkey, int64_t *l_quantity, int64_t *sum_quantity, int64_t *agg_count, double *l_extendedprice, double *agg2_extendedprice, TY_HT2_I HT2_I, TY_HT2_F HT2_F, TY_HT3_I HT3_I, TY_HT3_F HT3_F, size_t lineitem_size, int64_t *B2_agg)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= lineitem_size)
        return;
    int32_t reg_l_partkey = l_partkey[tid];
    int64_t reg_l_quantity = l_quantity[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_l_partkey) << 0);
    auto slot2 = HT2_F.find(key2);
    if (slot2 == HT2_F.end())
        return;

    int64_t reg_sum_quantity = sum_quantity[B2_agg[slot2->second]];
    int64_t reg_agg_count = agg_count[B2_agg[slot2->second]];
    double reg_avg_qty = 0.2 * ((double)reg_sum_quantity / (double)reg_agg_count);
    if (!((double)reg_l_quantity < reg_avg_qty))
        return;
    int64_t key3 = 0;
    auto slot3 = HT3_F.find(key3);
    double reg_l_extendedprice = l_extendedprice[tid];
    aggregate_sum(&(agg2_extendedprice[slot3->second]), reg_l_extendedprice);
}

void control(
    int32_t *l_partkey,
    double *l_extendedprice,
    int64_t *l_quantity,
    int8_t *p_brand,
    int8_t *p_container,
    int32_t *p_partkey,
    size_t lineitem_size,
    size_t part_size)
{
    std::cout << "HashJoin pipelines stats: \n";
    auto start_0 = std::chrono::high_resolution_clock::now();
    int32_t *d_l_partkey;

    cudaMalloc(&d_l_partkey, sizeof(int32_t) * lineitem_size);

    cudaMemcpy(d_l_partkey, l_partkey, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);

    int8_t *d_p_brand;

    cudaMalloc(&d_p_brand, sizeof(int8_t) * part_size);

    cudaMemcpy(d_p_brand, p_brand, sizeof(int8_t) * part_size, cudaMemcpyHostToDevice);

    int32_t *d_p_partkey;

    cudaMalloc(&d_p_partkey, sizeof(int32_t) * part_size);

    cudaMemcpy(d_p_partkey, p_partkey, sizeof(int32_t) * part_size, cudaMemcpyHostToDevice);

    int8_t *d_p_container;

    cudaMalloc(&d_p_container, sizeof(int8_t) * part_size);

    cudaMemcpy(d_p_container, p_container, sizeof(int8_t) * part_size, cudaMemcpyHostToDevice);

    auto stop_0 = std::chrono::high_resolution_clock::now();
    auto duration_0 = std::chrono::duration_cast<std::chrono::milliseconds>(stop_0 - start_0);
    std::cout << "\tAlloc and init: " << duration_0.count() << " ms.\n";
    int64_t *B0_part;
    int64_t *B0_idx;
    cudaMalloc(&B0_idx, sizeof(int64_t));
    cudaMemset(B0_idx, 0, sizeof(int64_t));
    pipeline_1<<<std::ceil((float)part_size / (float)32), 32>>>(d_l_partkey, d_p_partkey, d_p_container, d_p_brand, part_size, B0_idx);

    int64_t h_B0_idx;
    cudaMemcpy(&h_B0_idx, B0_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B0_idx, 0, sizeof(int64_t));
    cudaMalloc(&B0_part, sizeof(int64_t) * h_B0_idx);
    auto HT0 = cuco::static_map{h_B0_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT0_F = HT0.ref(cuco::find);

    auto d_HT0_I = HT0.ref(cuco::insert);

    pipeline_0<<<std::ceil((float)part_size / (float)32), 32>>>(d_l_partkey, d_p_brand, d_p_partkey, d_p_container, d_HT0_I, d_HT0_F, B0_part, part_size, B0_idx);

    std::cout << "Aggregation pipelines stats: \n";
    auto start_3 = std::chrono::high_resolution_clock::now();
    int64_t *d_l_quantity;

    cudaMalloc(&d_l_quantity, sizeof(int64_t) * lineitem_size);

    cudaMemcpy(d_l_quantity, l_quantity, sizeof(int64_t) * lineitem_size, cudaMemcpyHostToDevice);

    auto stop_3 = std::chrono::high_resolution_clock::now();
    auto duration_3 = std::chrono::duration_cast<std::chrono::milliseconds>(stop_3 - start_3);
    std::cout << "\tAlloc and init: " << duration_3.count() << " ms.\n";
    int64_t *d_sum_quantity;

    int32_t *d_agg_partkey;

    int64_t *d_agg_count;

    auto HT1 = cuco::static_map{lineitem_size * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT1_F = HT1.ref(cuco::find);

    auto d_HT1_I = HT1.ref(cuco::insert);

    pipeline_2<<<std::ceil((float)lineitem_size / (float)32), 32>>>(d_l_partkey, d_HT0_I, d_HT0_F, d_HT1_I, d_HT1_F, B0_part, lineitem_size);

    auto HT1_size = HT1.size();

    cudaMalloc(&d_sum_quantity, sizeof(int64_t) * HT1_size);

    cudaMalloc(&d_agg_partkey, sizeof(int32_t) * HT1_size);

    cudaMalloc(&d_agg_count, sizeof(int64_t) * HT1_size);

    cudaMemset(d_sum_quantity, 0, sizeof(int64_t) * HT1_size);

    cudaMemset(d_agg_partkey, 0, sizeof(int32_t) * HT1_size);

    cudaMemset(d_agg_count, 0, sizeof(int64_t) * HT1_size);

    thrust::device_vector<int64_t> keys_1(HT1_size), vals_1(HT1_size);
    HT1.retrieve_all(keys_1.begin(), vals_1.begin());
    thrust::host_vector<int64_t> h_keys_1(HT1_size);
    thrust::copy(keys_1.begin(), keys_1.end(), h_keys_1.begin());
    thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_1(HT1_size);
    for (int i = 0; i < HT1_size; i++)
    {
        actual_dict_1[i] = cuco::make_pair(h_keys_1[i], i);
    }
    HT1.clear();
    HT1.insert(actual_dict_1.begin(), actual_dict_1.end());
    pipeline_3<<<std::ceil((float)lineitem_size / (float)32), 32>>>(d_l_partkey, d_l_quantity, d_sum_quantity, d_agg_partkey, d_agg_count, d_HT0_I, d_HT0_F, d_HT1_I, d_HT1_F, B0_part, lineitem_size);

    size_t agg_size = HT1_size;

    std::cout << "First aggregation size: " << agg_size << std::endl;
    int64_t *B2_agg;
    int64_t *B2_idx;
    cudaMalloc(&B2_idx, sizeof(int64_t));
    cudaMemset(B2_idx, 0, sizeof(int64_t));
    pipeline_5<<<std::ceil((float)agg_size / (float)32), 32>>>(d_l_partkey, d_sum_quantity, d_agg_count, d_agg_partkey, B2_idx, agg_size);

    int64_t h_B2_idx;
    cudaMemcpy(&h_B2_idx, B2_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B2_idx, 0, sizeof(int64_t));
    cudaMalloc(&B2_agg, sizeof(int64_t) * h_B2_idx);
    auto HT2 = cuco::static_map{h_B2_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT2_F = HT2.ref(cuco::find);

    auto d_HT2_I = HT2.ref(cuco::insert);

    pipeline_4<<<std::ceil((float)agg_size / (float)32), 32>>>(d_l_partkey, d_agg_count, d_sum_quantity, d_agg_partkey, d_HT2_I, d_HT2_F, B2_idx, agg_size, B2_agg);

    std::cout << "Aggregation pipelines stats: \n";
    auto start_7 = std::chrono::high_resolution_clock::now();
    double *d_l_extendedprice;

    cudaMalloc(&d_l_extendedprice, sizeof(double) * lineitem_size);

    cudaMemcpy(d_l_extendedprice, l_extendedprice, sizeof(double) * lineitem_size, cudaMemcpyHostToDevice);

    auto stop_7 = std::chrono::high_resolution_clock::now();
    auto duration_7 = std::chrono::duration_cast<std::chrono::milliseconds>(stop_7 - start_7);
    std::cout << "\tAlloc and init: " << duration_7.count() << " ms.\n";
    double *d_agg2_extendedprice;

    auto HT3 = cuco::static_map{lineitem_size * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT3_F = HT3.ref(cuco::find);

    auto d_HT3_I = HT3.ref(cuco::insert);

    pipeline_6<<<std::ceil((float)lineitem_size / (float)32), 32>>>(d_l_partkey, d_l_quantity, d_sum_quantity, d_agg_count, d_HT2_I, d_HT2_F, d_HT3_I, d_HT3_F, lineitem_size, B2_agg);

    auto HT3_size = HT3.size();

    cudaMalloc(&d_agg2_extendedprice, sizeof(double) * HT3_size);

    cudaMemset(d_agg2_extendedprice, 0, sizeof(double) * HT3_size);

    thrust::device_vector<int64_t> keys_3(HT3_size), vals_3(HT3_size);
    HT3.retrieve_all(keys_3.begin(), vals_3.begin());
    thrust::host_vector<int64_t> h_keys_3(HT3_size);
    thrust::copy(keys_3.begin(), keys_3.end(), h_keys_3.begin());
    thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_3(HT3_size);
    for (int i = 0; i < HT3_size; i++)
    {
        actual_dict_3[i] = cuco::make_pair(h_keys_3[i], i);
    }
    HT3.clear();
    HT3.insert(actual_dict_3.begin(), actual_dict_3.end());
    pipeline_7<<<std::ceil((float)lineitem_size / (float)32), 32>>>(d_l_partkey, d_l_quantity, d_sum_quantity, d_agg_count, d_l_extendedprice, d_agg2_extendedprice, d_HT2_I, d_HT2_F, d_HT3_I, d_HT3_F, lineitem_size, B2_agg);

    size_t agg2_size = HT3_size;
    double *p_agg2_extendedprice = (double *)malloc(sizeof(double) * agg2_size);
    cudaMemcpy(p_agg2_extendedprice, d_agg2_extendedprice, sizeof(double) * agg2_size, cudaMemcpyDeviceToHost);
    for (int i = 0; i < agg2_size; i++)
    {
        std::cout << p_agg2_extendedprice[i] / 7.0 << "\t";
        std::cout << std::endl;
    }
}
int main(int argc, const char **argv)
{
    std::string dbDir = getDataDir(argv, argc);
    std::string lineitem_file = dbDir + "lineitem.parquet";
    auto lineitem_table = getArrowTable(lineitem_file);
    size_t lineitem_size = lineitem_table->num_rows();
    std::string part_file = dbDir + "part.parquet";
    auto part_table = getArrowTable(part_file);
    size_t part_size = part_table->num_rows();
    auto l_partkey = read_column_typecasted<int32_t>(lineitem_table, "l_partkey");
    auto l_extendedprice = read_column<double>(lineitem_table, "l_extendedprice");
    auto l_quantity = read_column<int64_t>(lineitem_table, "l_quantity");
    StringDictEncodedColumn *p_brand = read_string_dict_encoded_column(part_table, "p_brand");
    StringDictEncodedColumn *p_container = read_string_dict_encoded_column(part_table, "p_container");
    auto p_partkey = read_column_typecasted<int32_t>(part_table, "p_partkey");
    control(l_partkey.data(), l_extendedprice.data(), l_quantity.data(), p_brand->column, p_container->column, p_partkey.data(), lineitem_size, part_size);
}
