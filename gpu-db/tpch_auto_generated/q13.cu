#include "utils.h"

#include <cuco/static_map.cuh>

#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

#include <chrono>

namespace cg = cooperative_groups;

__global__ void pipeline_1(int32_t *c_custkey, int32_t *o_custkey, int64_t *B0_idx, size_t customer_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= customer_size)
        return;
    int32_t reg_c_custkey = c_custkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_c_custkey) << 0);
    atomicAdd((int *)B0_idx, 1);
}

template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_0(int32_t *c_custkey, int32_t *o_custkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, int64_t *B0_idx, size_t customer_size, int64_t *B0_customer)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= customer_size)
        return;
    int32_t reg_c_custkey = c_custkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_c_custkey) << 0);
    auto reg_B0_idx = atomicAdd((int *)B0_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT0_I.insert(thread, cuco::pair{key0, reg_B0_idx});
    B0_customer[reg_B0_idx] = tid;
}

template <typename TY_HT1_I, typename TY_HT1_F>
__global__ void pipeline_2(TY_HT1_I HT1_I, TY_HT1_F HT1_F, int32_t *c_custkey, size_t customer_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= customer_size)
        return;
    int32_t reg_c_custkey = c_custkey[tid];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_c_custkey) << 0);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT1_I.insert(thread, cuco::pair{key1, 1});
}

template <typename TY_HT0_I, typename TY_HT0_F, typename TY_HT1_I, typename TY_HT1_F>
__global__ void pipeline_3(char *o_comment, int64_t *o_comment_offsets, int *o_comment_sizes, int32_t *c_custkey, int32_t *o_custkey, int32_t *agg_custkey, int64_t *agg_count, TY_HT0_I HT0_I, TY_HT0_F HT0_F, TY_HT1_I HT1_I, TY_HT1_F HT1_F, size_t orders_size, int64_t *B0_customer)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= orders_size)
        return;
    if ((like_operator(o_comment + o_comment_offsets[tid], o_comment_sizes[tid], "special", 7)))
        return;
    int32_t reg_o_custkey = o_custkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_o_custkey) << 0);
    auto slot0 = HT0_F.find(key0);
    if (slot0 == HT0_F.end())
        return;
    int32_t reg_c_custkey = c_custkey[B0_customer[slot0->second]];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_c_custkey) << 0);
    auto slot1 = HT1_F.find(key1);
    agg_custkey[slot1->second] = reg_c_custkey;
    aggregate_sum(&(agg_count[slot1->second]), 1);
}

template <typename TY_HT2_I, typename TY_HT2_F>
__global__ void pipeline_4(int64_t *agg_count, TY_HT2_I HT2_I, TY_HT2_F HT2_F, size_t agg_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= agg_size)
        return;
    int64_t reg_agg_count = agg_count[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_agg_count) << 0);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT2_I.insert(thread, cuco::pair{key2, 1});
}

template <typename TY_HT2_I, typename TY_HT2_F>
__global__ void pipeline_5(int64_t *agg_count, int64_t *agg2_count, int64_t *agg2_dist, TY_HT2_I HT2_I, TY_HT2_F HT2_F, size_t agg_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= agg_size)
        return;
    int64_t reg_agg_count = agg_count[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_agg_count) << 0);
    auto slot2 = HT2_F.find(key2);
    agg2_count[slot2->second] = reg_agg_count;
    aggregate_sum(&(agg2_dist[slot2->second]), 1);
}

void control(
    int32_t *c_custkey,
    StringColumn *o_comment,
    int32_t *o_custkey,
    size_t customer_size,
    size_t orders_size)
{
    int32_t *d_c_custkey;
    auto start = std::chrono::high_resolution_clock::now();

    cudaMalloc(&d_c_custkey, sizeof(int32_t) * customer_size);
    
    cudaMemcpy(d_c_custkey, c_custkey, sizeof(int32_t) * customer_size, cudaMemcpyHostToDevice);
    
    int32_t *d_o_custkey;
    
    cudaMalloc(&d_o_custkey, sizeof(int32_t) * orders_size);
    
    cudaMemcpy(d_o_custkey, o_custkey, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);
    auto stop = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start);
    std::cout << "mallocs time: " << duration.count() << " ms.\n";

    int64_t *B0_customer;
    int64_t *B0_idx;
    cudaMalloc(&B0_idx, sizeof(int64_t));
    cudaMemset(B0_idx, 0, sizeof(int64_t));
    pipeline_1<<<std::ceil((float)customer_size / (float)32), 32>>>(d_c_custkey, d_o_custkey, B0_idx, customer_size);

    int64_t h_B0_idx;
    cudaMemcpy(&h_B0_idx, B0_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B0_idx, 0, sizeof(int64_t));
    cudaMalloc(&B0_customer, sizeof(int64_t) * h_B0_idx);
    auto HT0 = cuco::static_map{h_B0_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT0_F = HT0.ref(cuco::find);

    auto d_HT0_I = HT0.ref(cuco::insert);

    pipeline_0<<<std::ceil((float)customer_size / (float)32), 32>>>(d_c_custkey, d_o_custkey, d_HT0_I, d_HT0_F, B0_idx, customer_size, B0_customer);

    char *d_o_comment;

    int64_t *d_o_comment_offsets;

    int *d_o_comment_sizes;

    cudaMalloc(&d_o_comment, sizeof(char) * (o_comment->offsets[orders_size - 1] + o_comment->sizes[orders_size - 1]));

    cudaMemcpy(d_o_comment, o_comment->data, sizeof(char) * (o_comment->offsets[orders_size - 1] + o_comment->sizes[orders_size - 1]), cudaMemcpyHostToDevice);

    cudaMalloc(&d_o_comment_offsets, sizeof(int64_t) * orders_size);

    cudaMemcpy(d_o_comment_offsets, o_comment->offsets, sizeof(int64_t) * orders_size, cudaMemcpyHostToDevice);

    cudaMalloc(&d_o_comment_sizes, sizeof(int) * orders_size);

    cudaMemcpy(d_o_comment_sizes, o_comment->sizes, sizeof(int) * orders_size, cudaMemcpyHostToDevice);

    int32_t *d_agg_custkey;

    int64_t *d_agg_count;

    auto HT1 = cuco::static_map{orders_size * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT1_F = HT1.ref(cuco::find);

    auto d_HT1_I = HT1.ref(cuco::insert);

    pipeline_2<<<std::ceil((float)orders_size / (float)32), 32>>>(d_HT1_I, d_HT1_F, d_c_custkey, customer_size);

    auto HT1_size = HT1.size();

    cudaMalloc(&d_agg_custkey, sizeof(int32_t) * HT1_size);

    cudaMalloc(&d_agg_count, sizeof(int64_t) * HT1_size);

    cudaMemset(d_agg_custkey, 0, sizeof(int32_t) * HT1_size);

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
    pipeline_3<<<std::ceil((float)orders_size / (float)32), 32>>>(d_o_comment, d_o_comment_offsets, d_o_comment_sizes, d_c_custkey, d_o_custkey, d_agg_custkey, d_agg_count, d_HT0_I, d_HT0_F, d_HT1_I, d_HT1_F, orders_size, B0_customer);

    size_t agg_size = HT1_size;
    
    int64_t *d_agg2_count;

    int64_t *d_agg2_dist;

    auto HT2 = cuco::static_map{agg_size * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT2_F = HT2.ref(cuco::find);

    auto d_HT2_I = HT2.ref(cuco::insert);

    pipeline_4<<<std::ceil((float)agg_size / (float)32), 32>>>(d_agg_count, d_HT2_I, d_HT2_F, agg_size);

    auto HT2_size = HT2.size();

    cudaMalloc(&d_agg2_count, sizeof(int64_t) * HT2_size);

    cudaMalloc(&d_agg2_dist, sizeof(int64_t) * HT2_size);

    cudaMemset(d_agg2_count, 0, sizeof(int64_t) * HT2_size);

    cudaMemset(d_agg2_dist, 0, sizeof(int64_t) * HT2_size);

    thrust::device_vector<int64_t> keys_2(HT2_size), vals_2(HT2_size);
    HT2.retrieve_all(keys_2.begin(), vals_2.begin());
    thrust::host_vector<int64_t> h_keys_2(HT2_size);
    thrust::copy(keys_2.begin(), keys_2.end(), h_keys_2.begin());
    thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_2(HT2_size);
    for (int i = 0; i < HT2_size; i++)
    {
        actual_dict_2[i] = cuco::make_pair(h_keys_2[i], i);
    }
    HT2.clear();
    HT2.insert(actual_dict_2.begin(), actual_dict_2.end());
    pipeline_5<<<std::ceil((float)agg_size / (float)32), 32>>>(d_agg_count, d_agg2_count, d_agg2_dist, d_HT2_I, d_HT2_F, agg_size);
    size_t agg2_size = HT2_size;
    int64_t *p_agg2_count = (int64_t *)malloc(sizeof(int64_t) * agg2_size);
    cudaMemcpy(p_agg2_count, d_agg2_count, sizeof(int64_t) * agg2_size, cudaMemcpyDeviceToHost);
    int64_t *p_agg2_dist = (int64_t *)malloc(sizeof(int64_t) * agg2_size);
    cudaMemcpy(p_agg2_dist, d_agg2_dist, sizeof(int64_t) * agg2_size, cudaMemcpyDeviceToHost);
    for (int i = 0; i < agg2_size; i++)
    {
        std::cout << p_agg2_count[i] << "\t";
        std::cout << p_agg2_dist[i] << "\t";
        std::cout << std::endl;
    }
}
int main(int argc, const char **argv)
{
    std::string dbDir = getDataDir(argv, argc);
    std::string customer_file = dbDir + "customer.parquet";
    auto customer_table = getArrowTable(customer_file);
    size_t customer_size = customer_table->num_rows();
    std::string orders_file = dbDir + "orders.parquet";
    auto orders_table = getArrowTable(orders_file);
    size_t orders_size = orders_table->num_rows();
    auto c_custkey = read_column_typecasted<int32_t>(customer_table, "c_custkey");
    auto o_comment = read_string_column(orders_table, "o_comment");
    auto o_custkey = read_column_typecasted<int32_t>(orders_table, "o_custkey");
    auto start = std::chrono::high_resolution_clock::now();
    control(c_custkey.data(), o_comment, o_custkey.data(), customer_size, orders_size);
    auto stop = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start);
    std::cout << "control execution time: " << duration.count() << " ms.\n";
}
