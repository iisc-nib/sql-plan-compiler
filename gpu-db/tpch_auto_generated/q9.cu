#include "utils.h"

#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>

#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

namespace cg = cooperative_groups;

__global__ void pipeline_1(char *p_name, int64_t *p_name_offsets, int *p_name_sizes, int32_t *p_partkey, int32_t *l_partkey, size_t part_size, int64_t *B0_idx)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= part_size)
        return;
    if (!(like_operator(p_name + p_name_offsets[tid], p_name_sizes[tid], "green", 5)))
        return;
    int32_t reg_p_partkey = p_partkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_p_partkey) << 0);
    atomicAdd((int *)B0_idx, 1);
}

template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_0(char *p_name, int64_t *p_name_offsets, int *p_name_sizes, int32_t *l_partkey, int32_t *p_partkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, size_t part_size, int64_t *B0_idx, int64_t *B0_part)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= part_size)
        return;
    if (!(like_operator(p_name + p_name_offsets[tid], p_name_sizes[tid], "green", 5)))
        return;
    int32_t reg_p_partkey = p_partkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_p_partkey) << 0);
    auto reg_B0_idx = atomicAdd((int *)B0_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT0_I.insert(thread, cuco::pair{key0, reg_B0_idx});
    B0_part[reg_B0_idx] = tid;
}

template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_3(int32_t *l_partkey, int32_t *l_orderkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, size_t lineitem_size, int64_t *B0_part, int64_t *B1_idx)
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
    int32_t reg_l_orderkey = l_orderkey[tid];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_l_orderkey) << 0);
    atomicAdd((int *)B1_idx, 1);
}

template <typename TY_HT0_I, typename TY_HT0_F, typename TY_HT1_I, typename TY_HT1_F>
__global__ void pipeline_2(int32_t *l_partkey, int32_t *l_orderkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, TY_HT1_I HT1_I, TY_HT1_F HT1_F, size_t lineitem_size, int64_t *B1_lineitem, int64_t *B1_part, int64_t *B0_part, int64_t *B1_idx)
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
    int32_t reg_l_orderkey = l_orderkey[tid];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_l_orderkey) << 0);
    auto reg_B1_idx = atomicAdd((int *)B1_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT1_I.insert(thread, cuco::pair{key1, reg_B1_idx});
    B1_part[reg_B1_idx] = B0_part[slot0->second];
    B1_lineitem[reg_B1_idx] = tid;
}

template <typename TY_HT1_I, typename TY_HT1_F>
__global__ void pipeline_5(int32_t *l_partkey, int32_t *o_orderkey, int32_t *l_suppkey, TY_HT1_I HT1_I, TY_HT1_F HT1_F, int64_t *B1_part, size_t orders_size, int64_t *B4_idx, int64_t *B1_lineitem)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= orders_size)
        return;
    int32_t reg_o_orderkey = o_orderkey[tid];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_o_orderkey) << 0);
    HT1_F.for_each(key1, [&] __device__(auto const slot1)
                   {
    auto const [slot1_key, slot1_val] = slot1;
    int32_t reg_l_partkey = l_partkey[B1_lineitem[slot1_val]];
    int32_t reg_l_suppkey = l_suppkey[B1_lineitem[slot1_val]];
    int64_t key4 = 0;
    key4 |= (((int64_t)reg_l_partkey) << 0);
    key4 |= (((int64_t)reg_l_suppkey) << 32);
    atomicAdd((int*)B4_idx, 1); });
}

template <typename TY_HT1_I, typename TY_HT1_F, typename TY_HT4_I, typename TY_HT4_F>
__global__ void pipeline_4(int32_t *l_partkey, int32_t *o_orderkey, int32_t *l_suppkey, TY_HT1_I HT1_I, TY_HT1_F HT1_F, TY_HT4_I HT4_I, TY_HT4_F HT4_F, int64_t *B4_idx, int64_t *B4_orders, int64_t *B1_lineitem, int64_t *B1_part, size_t orders_size, int64_t *B4_lineitem, int64_t *B4_part)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= orders_size)
        return;
    int32_t reg_o_orderkey = o_orderkey[tid];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_o_orderkey) << 0);
    HT1_F.for_each(key1, [&] __device__(auto const slot1)
                   {
    auto const [slot1_key, slot1_val] = slot1;
    int32_t reg_l_partkey = l_partkey[B1_lineitem[slot1_val]];
    int32_t reg_l_suppkey = l_suppkey[B1_lineitem[slot1_val]];
    int64_t key4 = 0;
    key4 |= (((int64_t)reg_l_partkey) << 0);
    key4 |= (((int64_t)reg_l_suppkey) << 32);
    auto reg_B4_idx = atomicAdd((int*)B4_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT4_I.insert(thread, cuco::pair{key4, reg_B4_idx});
    B4_orders[reg_B4_idx] = tid;
    B4_part[reg_B4_idx] = B1_part[slot1_val];
    B4_lineitem[reg_B4_idx] = B1_lineitem[slot1_val]; });
}

__global__ void pipeline_7(int32_t *n_nationkey, int32_t *s_nationkey, int64_t *B2_idx, size_t nation_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= nation_size)
        return;
    int32_t reg_n_nationkey = n_nationkey[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_n_nationkey) << 0);
    atomicAdd((int *)B2_idx, 1);
}

template <typename TY_HT2_I, typename TY_HT2_F>
__global__ void pipeline_6(int32_t *n_nationkey, int32_t *s_nationkey, TY_HT2_I HT2_I, TY_HT2_F HT2_F, int64_t *B2_idx, int64_t *B2_nation, size_t nation_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= nation_size)
        return;
    int32_t reg_n_nationkey = n_nationkey[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_n_nationkey) << 0);
    auto reg_B2_idx = atomicAdd((int *)B2_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT2_I.insert(thread, cuco::pair{key2, reg_B2_idx});
    B2_nation[reg_B2_idx] = tid;
}

template <typename TY_HT2_I, typename TY_HT2_F>
__global__ void pipeline_9(int32_t *s_nationkey, int32_t *s_suppkey, int32_t *ps_suppkey, TY_HT2_I HT2_I, TY_HT2_F HT2_F, int64_t *B3_idx, size_t supplier_size, int64_t *B2_nation)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= supplier_size)
        return;
    int32_t reg_s_nationkey = s_nationkey[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_s_nationkey) << 0);
    auto slot2 = HT2_F.find(key2);
    if (slot2 == HT2_F.end())
        return;
    int32_t reg_s_suppkey = s_suppkey[tid];
    int64_t key3 = 0;
    key3 |= (((int64_t)reg_s_suppkey) << 0);
    atomicAdd((int *)B3_idx, 1);
}

template <typename TY_HT2_I, typename TY_HT2_F, typename TY_HT3_I, typename TY_HT3_F>
__global__ void pipeline_8(int32_t *ps_suppkey, int32_t *s_suppkey, int32_t *s_nationkey, TY_HT2_I HT2_I, TY_HT2_F HT2_F, TY_HT3_I HT3_I, TY_HT3_F HT3_F, int64_t *B3_nation, int64_t *B3_supplier, size_t supplier_size, int64_t *B2_nation, int64_t *B3_idx)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= supplier_size)
        return;
    int32_t reg_s_nationkey = s_nationkey[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_s_nationkey) << 0);
    auto slot2 = HT2_F.find(key2);
    if (slot2 == HT2_F.end())
        return;
    int32_t reg_s_suppkey = s_suppkey[tid];
    int64_t key3 = 0;
    key3 |= (((int64_t)reg_s_suppkey) << 0);
    auto reg_B3_idx = atomicAdd((int *)B3_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT3_I.insert(thread, cuco::pair{key3, reg_B3_idx});
    B3_supplier[reg_B3_idx] = tid;
    B3_nation[reg_B3_idx] = B2_nation[slot2->second];
}

template <typename TY_HT3_I, typename TY_HT3_F, typename TY_HT4_I, typename TY_HT4_F, typename TY_HT5_I, typename TY_HT5_F>
__global__ void pipeline_10(int32_t *ps_partkey, int32_t *ps_suppkey, double *l_extendedprice, double *l_discount, double *ps_supplycost, int8_t *n_name, int32_t *s_suppkey, int64_t *l_quantity, int32_t *o_orderdate, TY_HT3_I HT3_I, TY_HT3_F HT3_F, TY_HT4_I HT4_I, TY_HT4_F HT4_F, TY_HT5_I HT5_I, TY_HT5_F HT5_F, int64_t *B3_nation, int64_t *B3_supplier, int64_t *B4_orders, int64_t *B4_lineitem, size_t partsupp_size, int64_t *B4_part)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= partsupp_size)
        return;
    int32_t reg_ps_suppkey = ps_suppkey[tid];
    int64_t key3 = 0;
    key3 |= (((int64_t)reg_ps_suppkey) << 0);
    auto slot3 = HT3_F.find(key3);
    if (slot3 == HT3_F.end())
        return;
    int32_t reg_ps_partkey = ps_partkey[tid];
    int32_t reg_s_suppkey = s_suppkey[B3_supplier[slot3->second]];
    int64_t key4 = 0;
    key4 |= (((int64_t)reg_ps_partkey) << 0);
    key4 |= (((int64_t)reg_s_suppkey) << 32);
    HT4_F.for_each(key4, [&] __device__(auto const slot4)
                   {
    auto const [slot4_key, slot4_val] = slot4;
    double reg_l_extendedprice = l_extendedprice[B4_lineitem[slot4_val]];
    double reg_l_discount = l_discount[B4_lineitem[slot4_val]];
    double reg_ps_supplycost = ps_supplycost[tid];
    int64_t reg_l_quantity = l_quantity[B4_lineitem[slot4_val]];
    double reg_profit = ((reg_l_extendedprice * (1 - reg_l_discount))-(reg_ps_supplycost * reg_l_quantity));
    int8_t reg_n_name = n_name[B3_nation[slot3->second]];
    int32_t reg_o_orderdate = extract_year(o_orderdate[B4_orders[slot4_val]]);
    int64_t key5 = 0;
    key5 |= (((int64_t)reg_n_name) << 0);
    key5 |= (((int64_t)reg_o_orderdate) << 8);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT5_I.insert(thread, cuco::pair{key5, 1}); });
}

template <typename TY_HT3_I, typename TY_HT3_F, typename TY_HT4_I, typename TY_HT4_F, typename TY_HT5_I, typename TY_HT5_F>
__global__ void pipeline_11(int32_t *ps_partkey, int32_t *ps_suppkey, double *l_extendedprice, double *ps_supplycost, double *l_discount, int8_t *n_name, int32_t *s_suppkey, int64_t *l_quantity, int32_t *o_orderdate, int32_t *agg_o_orderdate, double *sum_profit, int8_t *agg_n_name, TY_HT3_I HT3_I, TY_HT3_F HT3_F, TY_HT4_I HT4_I, TY_HT4_F HT4_F, TY_HT5_I HT5_I, TY_HT5_F HT5_F, int64_t *B3_nation, int64_t *B3_supplier, int64_t *B4_orders, int64_t *B4_lineitem, size_t partsupp_size, int64_t *B4_part)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= partsupp_size)
        return;
    int32_t reg_ps_suppkey = ps_suppkey[tid];
    int64_t key3 = 0;
    key3 |= (((int64_t)reg_ps_suppkey) << 0);
    auto slot3 = HT3_F.find(key3);
    if (slot3 == HT3_F.end())
        return;
    int32_t reg_ps_partkey = ps_partkey[tid];
    int32_t reg_s_suppkey = s_suppkey[B3_supplier[slot3->second]];
    int64_t key4 = 0;
    key4 |= (((int64_t)reg_ps_partkey) << 0);
    key4 |= (((int64_t)reg_s_suppkey) << 32);
    HT4_F.for_each(key4, [&] __device__(auto const slot4)
                   {
    auto const [slot4_key, slot4_val] = slot4;
    double reg_l_extendedprice = l_extendedprice[B4_lineitem[slot4_val]];
    double reg_l_discount = l_discount[B4_lineitem[slot4_val]];
    double reg_ps_supplycost = ps_supplycost[tid];
    int64_t reg_l_quantity = l_quantity[B4_lineitem[slot4_val]];
    double reg_profit = ((reg_l_extendedprice * (1 - reg_l_discount))-(reg_ps_supplycost * reg_l_quantity));
    int8_t reg_n_name = n_name[B3_nation[slot3->second]];
    int32_t reg_o_orderdate = extract_year(o_orderdate[B4_orders[slot4_val]]);
    int64_t key5 = 0;
    key5 |= (((int64_t)reg_n_name) << 0);
    key5 |= (((int64_t)reg_o_orderdate) << 8);
    auto slot5 = HT5_F.find(key5);
    agg_n_name[slot5->second] = reg_n_name;
    agg_o_orderdate[slot5->second] = reg_o_orderdate;
    aggregate_sum(&(sum_profit[slot5->second]), reg_profit); });
}

void control(
    double *l_discount,
    double *l_extendedprice,
    int32_t *l_orderkey,
    int32_t *l_partkey,
    int64_t *l_quantity,
    int32_t *l_suppkey,
    int8_t *n_name,
    int32_t *n_nationkey,
    int32_t *o_orderdate,
    int32_t *o_orderkey,
    StringColumn *p_name,
    int32_t *p_partkey,
    int32_t *ps_partkey,
    int32_t *ps_suppkey,
    double *ps_supplycost,
    int32_t *s_nationkey,
    int32_t *s_suppkey,
    size_t lineitem_size,
    size_t nation_size,
    size_t orders_size,
    size_t part_size,
    size_t partsupp_size,
    size_t supplier_size)
{
    char *d_p_name;

    int64_t *d_p_name_offsets;

    int *d_p_name_sizes;

    cudaMalloc(&d_p_name, sizeof(char) * (p_name->offsets[part_size - 1] + p_name->sizes[part_size - 1]));

    cudaMemcpy(d_p_name, p_name->data, sizeof(char) * (p_name->offsets[part_size - 1] + p_name->sizes[part_size - 1]), cudaMemcpyHostToDevice);

    cudaMalloc(&d_p_name_offsets, sizeof(int64_t) * part_size);

    cudaMemcpy(d_p_name_offsets, p_name->offsets, sizeof(int64_t) * part_size, cudaMemcpyHostToDevice);

    cudaMalloc(&d_p_name_sizes, sizeof(int) * part_size);

    cudaMemcpy(d_p_name_sizes, p_name->sizes, sizeof(int) * part_size, cudaMemcpyHostToDevice);

    int32_t *d_l_partkey;

    cudaMalloc(&d_l_partkey, sizeof(int32_t) * lineitem_size);

    cudaMemcpy(d_l_partkey, l_partkey, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);

    int32_t *d_p_partkey;

    cudaMalloc(&d_p_partkey, sizeof(int32_t) * part_size);

    cudaMemcpy(d_p_partkey, p_partkey, sizeof(int32_t) * part_size, cudaMemcpyHostToDevice);

    int64_t *B0_part;
    int64_t *B0_idx;
    cudaMalloc(&B0_idx, sizeof(int64_t));
    cudaMemset(B0_idx, 0, sizeof(int64_t));
    pipeline_1<<<std::ceil((float)part_size / (float)32), 32>>>(d_p_name, d_p_name_offsets, d_p_name_sizes, d_p_partkey, d_l_partkey, part_size, B0_idx);

    int64_t h_B0_idx;
    cudaMemcpy(&h_B0_idx, B0_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B0_idx, 0, sizeof(int64_t));
    cudaMalloc(&B0_part, sizeof(int64_t) * h_B0_idx);
    auto HT0 = cuco::static_map{h_B0_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT0_F = HT0.ref(cuco::find);

    auto d_HT0_I = HT0.ref(cuco::insert);

    pipeline_0<<<std::ceil((float)part_size / (float)32), 32>>>(d_p_name, d_p_name_offsets, d_p_name_sizes, d_l_partkey, d_p_partkey, d_HT0_I, d_HT0_F, part_size, B0_idx, B0_part);

    int32_t *d_l_orderkey;

    cudaMalloc(&d_l_orderkey, sizeof(int32_t) * lineitem_size);

    cudaMemcpy(d_l_orderkey, l_orderkey, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);

    int64_t *B1_part;
    int64_t *B1_lineitem;
    int64_t *B1_idx;
    cudaMalloc(&B1_idx, sizeof(int64_t));
    cudaMemset(B1_idx, 0, sizeof(int64_t));
    pipeline_3<<<std::ceil((float)lineitem_size / (float)32), 32>>>(d_l_partkey, d_l_orderkey, d_HT0_I, d_HT0_F, lineitem_size, B0_part, B1_idx);

    int64_t h_B1_idx;
    cudaMemcpy(&h_B1_idx, B1_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B1_idx, 0, sizeof(int64_t));
    cudaMalloc(&B1_part, sizeof(int64_t) * h_B1_idx);
    cudaMalloc(&B1_lineitem, sizeof(int64_t) * h_B1_idx);
    auto HT1 = cuco::experimental::static_multimap{h_B1_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, {}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>(), {}, cuco::storage<2>{}};

    auto d_HT1_F = HT1.ref(cuco::for_each);

    auto d_HT1_I = HT1.ref(cuco::insert);

    pipeline_2<<<std::ceil((float)lineitem_size / (float)32), 32>>>(d_l_partkey, d_l_orderkey, d_HT0_I, d_HT0_F, d_HT1_I, d_HT1_F, lineitem_size, B1_lineitem, B1_part, B0_part, B1_idx);

    int32_t *d_o_orderkey;

    cudaMalloc(&d_o_orderkey, sizeof(int32_t) * orders_size);

    cudaMemcpy(d_o_orderkey, o_orderkey, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);

    int32_t *d_l_suppkey;

    cudaMalloc(&d_l_suppkey, sizeof(int32_t) * lineitem_size);

    cudaMemcpy(d_l_suppkey, l_suppkey, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);

    int64_t *B4_orders;
    int64_t *B4_part;
    int64_t *B4_lineitem;
    int64_t *B4_idx;
    cudaMalloc(&B4_idx, sizeof(int64_t));
    cudaMemset(B4_idx, 0, sizeof(int64_t));
    pipeline_5<<<std::ceil((float)orders_size / (float)32), 32>>>(d_l_partkey, d_o_orderkey, d_l_suppkey, d_HT1_I, d_HT1_F, B1_part, orders_size, B4_idx, B1_lineitem);

    int64_t h_B4_idx;
    cudaMemcpy(&h_B4_idx, B4_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B4_idx, 0, sizeof(int64_t));
    cudaMalloc(&B4_orders, sizeof(int64_t) * h_B4_idx);
    cudaMalloc(&B4_part, sizeof(int64_t) * h_B4_idx);
    cudaMalloc(&B4_lineitem, sizeof(int64_t) * h_B4_idx);
    auto HT4 = cuco::experimental::static_multimap{h_B4_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, {}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>(), {}, cuco::storage<2>{}};

    auto d_HT4_F = HT4.ref(cuco::for_each);

    auto d_HT4_I = HT4.ref(cuco::insert);

    pipeline_4<<<std::ceil((float)orders_size / (float)32), 32>>>(d_l_partkey, d_o_orderkey, d_l_suppkey, d_HT1_I, d_HT1_F, d_HT4_I, d_HT4_F, B4_idx, B4_orders, B1_lineitem, B1_part, orders_size, B4_lineitem, B4_part);

    int32_t *d_n_nationkey;

    cudaMalloc(&d_n_nationkey, sizeof(int32_t) * nation_size);

    cudaMemcpy(d_n_nationkey, n_nationkey, sizeof(int32_t) * nation_size, cudaMemcpyHostToDevice);

    int32_t *d_s_nationkey;

    cudaMalloc(&d_s_nationkey, sizeof(int32_t) * supplier_size);

    cudaMemcpy(d_s_nationkey, s_nationkey, sizeof(int32_t) * supplier_size, cudaMemcpyHostToDevice);

    int64_t *B2_nation;
    int64_t *B2_idx;
    cudaMalloc(&B2_idx, sizeof(int64_t));
    cudaMemset(B2_idx, 0, sizeof(int64_t));
    pipeline_7<<<std::ceil((float)nation_size / (float)32), 32>>>(d_n_nationkey, d_s_nationkey, B2_idx, nation_size);

    int64_t h_B2_idx;
    cudaMemcpy(&h_B2_idx, B2_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B2_idx, 0, sizeof(int64_t));
    cudaMalloc(&B2_nation, sizeof(int64_t) * h_B2_idx);
    auto HT2 = cuco::static_map{h_B2_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT2_F = HT2.ref(cuco::find);

    auto d_HT2_I = HT2.ref(cuco::insert);

    pipeline_6<<<std::ceil((float)nation_size / (float)32), 32>>>(d_n_nationkey, d_s_nationkey, d_HT2_I, d_HT2_F, B2_idx, B2_nation, nation_size);

    int32_t *d_ps_suppkey;

    cudaMalloc(&d_ps_suppkey, sizeof(int32_t) * partsupp_size);

    cudaMemcpy(d_ps_suppkey, ps_suppkey, sizeof(int32_t) * partsupp_size, cudaMemcpyHostToDevice);

    int32_t *d_s_suppkey;

    cudaMalloc(&d_s_suppkey, sizeof(int32_t) * supplier_size);

    cudaMemcpy(d_s_suppkey, s_suppkey, sizeof(int32_t) * supplier_size, cudaMemcpyHostToDevice);

    int64_t *B3_supplier;
    int64_t *B3_nation;
    int64_t *B3_idx;
    cudaMalloc(&B3_idx, sizeof(int64_t));
    cudaMemset(B3_idx, 0, sizeof(int64_t));
    pipeline_9<<<std::ceil((float)supplier_size / (float)32), 32>>>(d_s_nationkey, d_s_suppkey, d_ps_suppkey, d_HT2_I, d_HT2_F, B3_idx, supplier_size, B2_nation);

    int64_t h_B3_idx;
    cudaMemcpy(&h_B3_idx, B3_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B3_idx, 0, sizeof(int64_t));
    cudaMalloc(&B3_supplier, sizeof(int64_t) * h_B3_idx);
    cudaMalloc(&B3_nation, sizeof(int64_t) * h_B3_idx);
    auto HT3 = cuco::static_map{h_B3_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT3_F = HT3.ref(cuco::find);

    auto d_HT3_I = HT3.ref(cuco::insert);

    pipeline_8<<<std::ceil((float)supplier_size / (float)32), 32>>>(d_ps_suppkey, d_s_suppkey, d_s_nationkey, d_HT2_I, d_HT2_F, d_HT3_I, d_HT3_F, B3_nation, B3_supplier, supplier_size, B2_nation, B3_idx);

    int32_t *d_ps_partkey;

    cudaMalloc(&d_ps_partkey, sizeof(int32_t) * partsupp_size);

    cudaMemcpy(d_ps_partkey, ps_partkey, sizeof(int32_t) * partsupp_size, cudaMemcpyHostToDevice);

    double *d_l_extendedprice;

    cudaMalloc(&d_l_extendedprice, sizeof(double) * lineitem_size);

    cudaMemcpy(d_l_extendedprice, l_extendedprice, sizeof(double) * lineitem_size, cudaMemcpyHostToDevice);

    double *d_ps_supplycost;

    cudaMalloc(&d_ps_supplycost, sizeof(double) * partsupp_size);

    cudaMemcpy(d_ps_supplycost, ps_supplycost, sizeof(double) * partsupp_size, cudaMemcpyHostToDevice);

    double *d_l_discount;

    cudaMalloc(&d_l_discount, sizeof(double) * lineitem_size);

    cudaMemcpy(d_l_discount, l_discount, sizeof(double) * lineitem_size, cudaMemcpyHostToDevice);

    int8_t *d_n_name;

    cudaMalloc(&d_n_name, sizeof(int8_t) * nation_size);

    cudaMemcpy(d_n_name, n_name, sizeof(int8_t) * nation_size, cudaMemcpyHostToDevice);

    int64_t *d_l_quantity;

    cudaMalloc(&d_l_quantity, sizeof(int64_t) * lineitem_size);

    cudaMemcpy(d_l_quantity, l_quantity, sizeof(int64_t) * lineitem_size, cudaMemcpyHostToDevice);

    int32_t *d_o_orderdate;

    cudaMalloc(&d_o_orderdate, sizeof(int32_t) * orders_size);

    cudaMemcpy(d_o_orderdate, o_orderdate, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);

    int32_t *d_agg_o_orderdate;

    double *d_sum_profit;

    int8_t *d_agg_n_name;

    auto HT5 = cuco::static_map{partsupp_size * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT5_F = HT5.ref(cuco::find);

    auto d_HT5_I = HT5.ref(cuco::insert);

    pipeline_10<<<std::ceil((float)partsupp_size / (float)32), 32>>>(d_ps_partkey, d_ps_suppkey, d_l_extendedprice, d_l_discount, d_ps_supplycost, d_n_name, d_s_suppkey, d_l_quantity, d_o_orderdate, d_HT3_I, d_HT3_F, d_HT4_I, d_HT4_F, d_HT5_I, d_HT5_F, B3_nation, B3_supplier, B4_orders, B4_lineitem, partsupp_size, B4_part);

    auto HT5_size = HT5.size();

    cudaMalloc(&d_agg_o_orderdate, sizeof(int32_t) * HT5_size);

    cudaMalloc(&d_sum_profit, sizeof(double) * HT5_size);

    cudaMalloc(&d_agg_n_name, sizeof(int8_t) * HT5_size);

    cudaMemset(d_agg_o_orderdate, 0, sizeof(int32_t) * HT5_size);

    cudaMemset(d_sum_profit, 0, sizeof(double) * HT5_size);

    cudaMemset(d_agg_n_name, 0, sizeof(int8_t) * HT5_size);

    thrust::device_vector<int64_t> keys_5(HT5_size), vals_5(HT5_size);
    HT5.retrieve_all(keys_5.begin(), vals_5.begin());
    thrust::host_vector<int64_t> h_keys_5(HT5_size);
    thrust::copy(keys_5.begin(), keys_5.end(), h_keys_5.begin());
    thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_5(HT5_size);
    for (int i = 0; i < HT5_size; i++)
    {
        actual_dict_5[i] = cuco::make_pair(h_keys_5[i], i);
    }
    HT5.clear();
    HT5.insert(actual_dict_5.begin(), actual_dict_5.end());
    pipeline_11<<<std::ceil((float)partsupp_size / (float)32), 32>>>(d_ps_partkey, d_ps_suppkey, d_l_extendedprice, d_ps_supplycost, d_l_discount, d_n_name, d_s_suppkey, d_l_quantity, d_o_orderdate, d_agg_o_orderdate, d_sum_profit, d_agg_n_name, d_HT3_I, d_HT3_F, d_HT4_I, d_HT4_F, d_HT5_I, d_HT5_F, B3_nation, B3_supplier, B4_orders, B4_lineitem, partsupp_size, B4_part);

    size_t agg_size = HT5_size;
    int8_t *p_agg_n_name = (int8_t *)malloc(sizeof(int8_t) * agg_size);
    cudaMemcpy(p_agg_n_name, d_agg_n_name, sizeof(int8_t) * agg_size, cudaMemcpyDeviceToHost);
    int32_t *p_agg_o_orderdate = (int32_t *)malloc(sizeof(int32_t) * agg_size);
    cudaMemcpy(p_agg_o_orderdate, d_agg_o_orderdate, sizeof(int32_t) * agg_size, cudaMemcpyDeviceToHost);
    double *p_sum_profit = (double *)malloc(sizeof(double) * agg_size);
    cudaMemcpy(p_sum_profit, d_sum_profit, sizeof(double) * agg_size, cudaMemcpyDeviceToHost);
    for (int i = 0; i < agg_size; i++)
    {
        std::cout << (int)p_agg_n_name[i] << "\t";
        std::cout << p_agg_o_orderdate[i] << "\t";
        std::cout << p_sum_profit[i] << "\t";
        std::cout << std::endl;
    }
}

int main(int argc, const char **argv)
{
    std::string dbDir = getDataDir(argv, argc);
    std::string lineitem_file = dbDir + "lineitem.parquet";
    std::string nation_file = dbDir + "nation.parquet";
    std::string orders_file = dbDir + "orders.parquet";
    std::string part_file = dbDir + "part.parquet";
    std::string partsupp_file = dbDir + "partsupp.parquet";
    std::string supplier_file = dbDir + "supplier.parquet";

    // auto lineitem_table  = getArrowTable(lineitem_file);
    auto lineitem_table = getArrowTable(lineitem_file);
    auto nation_table = getArrowTable(nation_file);
    auto orders_table = getArrowTable(orders_file);
    auto part_table = getArrowTable(part_file);
    auto partsupp_table = getArrowTable(partsupp_file);
    auto supplier_table = getArrowTable(supplier_file);
    size_t lineitem_size = lineitem_table->num_rows();
    size_t nation_size = nation_table->num_rows();
    size_t orders_size = orders_table->num_rows();
    size_t part_size = part_table->num_rows();
    size_t partsupp_size = partsupp_table->num_rows();
    size_t supplier_size = supplier_table->num_rows();

    auto l_extendedprice = read_column<double>(lineitem_table, "l_extendedprice");
    auto l_discount = read_column<double>(lineitem_table, "l_discount");
    auto l_orderkey = read_column_typecasted<int32_t>(lineitem_table, "l_orderkey");
    auto l_partkey = read_column_typecasted<int32_t>(lineitem_table, "l_partkey");
    auto l_quantity = read_column<int64_t>(lineitem_table, "l_quantity");
    auto l_suppkey = read_column_typecasted<int32_t>(lineitem_table, "l_suppkey");

    auto n_name = read_string_dict_encoded_column(nation_table, "n_name");
    auto n_nationkey = read_column_typecasted<int32_t>(nation_table, "n_nationkey");

    auto o_orderkey = read_column_typecasted<int32_t>(orders_table, "o_orderkey");
    auto o_orderdate = read_column<int32_t>(orders_table, "o_orderdate");

    auto p_name = read_string_column(part_table, "p_name");
    auto p_partkey = read_column_typecasted<int32_t>(part_table, "p_partkey");

    auto ps_partkey = read_column_typecasted<int32_t>(partsupp_table, "ps_partkey");
    auto ps_suppkey = read_column_typecasted<int32_t>(partsupp_table, "ps_suppkey");
    auto ps_supplycost = read_column<double>(partsupp_table, "ps_supplycost");

    auto s_nationkey = read_column_typecasted<int32_t>(supplier_table, "s_nationkey");
    auto s_suppkey = read_column_typecasted<int32_t>(supplier_table, "s_suppkey");

    // for (auto p: c_mktsegment->dict) {
    //   std::cout << p.first << " " << (int)p.second << std::endl;
    // }
    control(
        l_discount.data(),
        l_extendedprice.data(),
        l_orderkey.data(),
        l_partkey.data(),
        l_quantity.data(),
        l_suppkey.data(),
        n_name->column,
        n_nationkey.data(),
        o_orderdate.data(),
        o_orderkey.data(),
        p_name,
        p_partkey.data(),
        ps_partkey.data(),
        ps_suppkey.data(),
        ps_supplycost.data(),
        s_nationkey.data(),
        s_suppkey.data(),
        lineitem_size,
        nation_size,
        orders_size,
        part_size,
        partsupp_size,
        supplier_size);
}