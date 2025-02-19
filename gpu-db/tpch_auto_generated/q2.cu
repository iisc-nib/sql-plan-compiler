
#include "utils.h"

#include <cuco/static_map.cuh>
#include <cuco/static_multimap.cuh>

#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

namespace cg = cooperative_groups;

__global__ void pipeline_1(int32_t *p_size, int32_t *p_partkey, char *p_type, int64_t *p_type_offsets, int *p_type_sizes, int32_t *ps_partkey, int64_t *B3_idx, size_t part_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= part_size)
        return;
    int32_t reg_p_size = p_size[tid];
    if (!(reg_p_size == 15))
        return;
    if (!(like_operator(p_type + p_type_offsets[tid], p_type_sizes[tid], "BRASS", 5)))
        return;
    int32_t reg_p_partkey = p_partkey[tid];
    int64_t key3 = 0;
    key3 |= (((int64_t)reg_p_partkey) << 0);
    atomicAdd((int *)B3_idx, 1);
}

template <typename TY_HT3_I, typename TY_HT3_F>
__global__ void pipeline_0(int32_t *p_size, int32_t *p_partkey, char *p_type, int64_t *p_type_offsets, int *p_type_sizes, int32_t *ps_partkey, TY_HT3_I HT3_I, TY_HT3_F HT3_F, int64_t *B3_part, int64_t *B3_idx, size_t part_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= part_size)
        return;
    int32_t reg_p_size = p_size[tid];
    if (!(reg_p_size == 15))
        return;
    if (!(like_operator(p_type + p_type_offsets[tid], p_type_sizes[tid], "BRASS", 5)))
        return;
    int32_t reg_p_partkey = p_partkey[tid];
    int64_t key3 = 0;
    key3 |= (((int64_t)reg_p_partkey) << 0);
    auto reg_B3_idx = atomicAdd((int *)B3_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT3_I.insert(thread, cuco::pair{key3, reg_B3_idx});
    B3_part[reg_B3_idx] = tid;
}

__global__ void pipeline_3(int8_t *r_name, int32_t *r_regionkey, int32_t *n_regionkey, int64_t *B0_idx, size_t region_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= region_size)
        return;
    int8_t reg_r_name = r_name[tid];
    if (!(reg_r_name == 3))
        return;
    int32_t reg_r_regionkey = r_regionkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_r_regionkey) << 0);
    atomicAdd((int *)B0_idx, 1);
}

template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_2(int32_t *r_regionkey, int32_t *n_regionkey, int8_t *r_name, TY_HT0_I HT0_I, TY_HT0_F HT0_F, int64_t *B0_idx, size_t region_size, int64_t *B0_region)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= region_size)
        return;
    int8_t reg_r_name = r_name[tid];
    if (!(reg_r_name == 3))
        return;
    int32_t reg_r_regionkey = r_regionkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_r_regionkey) << 0);
    auto reg_B0_idx = atomicAdd((int *)B0_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT0_I.insert(thread, cuco::pair{key0, reg_B0_idx});
    B0_region[reg_B0_idx] = tid;
}

template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_5(int32_t *n_nationkey, int32_t *s_nationkey, int32_t *n_regionkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, int64_t *B1_idx, int64_t *B0_region, size_t nation_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= nation_size)
        return;
    int32_t reg_n_regionkey = n_regionkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_n_regionkey) << 0);
    auto slot0 = HT0_F.find(key0);
    if (slot0 == HT0_F.end())
        return;
    int32_t reg_n_nationkey = n_nationkey[tid];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_n_nationkey) << 0);
    atomicAdd((int *)B1_idx, 1);
}

template <typename TY_HT0_I, typename TY_HT0_F, typename TY_HT1_I, typename TY_HT1_F>
__global__ void pipeline_4(int32_t *n_nationkey, int32_t *s_nationkey, int32_t *n_regionkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, TY_HT1_I HT1_I, TY_HT1_F HT1_F, int64_t *B1_region, int64_t *B1_idx, int64_t *B1_nation, size_t nation_size, int64_t *B0_region)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= nation_size)
        return;
    int32_t reg_n_regionkey = n_regionkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_n_regionkey) << 0);
    auto slot0 = HT0_F.find(key0);
    if (slot0 == HT0_F.end())
        return;
    int32_t reg_n_nationkey = n_nationkey[tid];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_n_nationkey) << 0);
    auto reg_B1_idx = atomicAdd((int *)B1_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT1_I.insert(thread, cuco::pair{key1, reg_B1_idx});
    B1_region[reg_B1_idx] = B0_region[slot0->second];
    B1_nation[reg_B1_idx] = tid;
}

template <typename TY_HT1_I, typename TY_HT1_F>
__global__ void pipeline_7(int32_t *ps_suppkey, int32_t *s_nationkey, int32_t *s_suppkey, TY_HT1_I HT1_I, TY_HT1_F HT1_F, size_t supplier_size, int64_t *B1_region, int64_t *B2_idx, int64_t *B1_nation)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= supplier_size)
        return;
    int32_t reg_s_nationkey = s_nationkey[tid];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_s_nationkey) << 0);
    auto slot1 = HT1_F.find(key1);
    if (slot1 == HT1_F.end())
        return;
    int32_t reg_s_suppkey = s_suppkey[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_s_suppkey) << 0);
    atomicAdd((int *)B2_idx, 1);
}

template <typename TY_HT1_I, typename TY_HT1_F, typename TY_HT2_I, typename TY_HT2_F>
__global__ void pipeline_6(int32_t *ps_suppkey, int32_t *s_nationkey, int32_t *s_suppkey, TY_HT1_I HT1_I, TY_HT1_F HT1_F, TY_HT2_I HT2_I, TY_HT2_F HT2_F, int64_t *B2_idx, int64_t *B2_supplier, int64_t *B2_nation, size_t supplier_size, int64_t *B1_nation, int64_t *B2_region, int64_t *B1_region)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= supplier_size)
        return;
    int32_t reg_s_nationkey = s_nationkey[tid];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_s_nationkey) << 0);
    auto slot1 = HT1_F.find(key1);
    if (slot1 == HT1_F.end())
        return;
    int32_t reg_s_suppkey = s_suppkey[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_s_suppkey) << 0);
    auto reg_B2_idx = atomicAdd((int *)B2_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT2_I.insert(thread, cuco::pair{key2, reg_B2_idx});
    B2_supplier[reg_B2_idx] = tid;
    B2_nation[reg_B2_idx] = B1_nation[slot1->second];
    B2_region[reg_B2_idx] = B1_region[slot1->second];
}

template <typename TY_HT2_I, typename TY_HT2_F, typename TY_HT3_I, typename TY_HT3_F, typename TY_HT4_I, typename TY_HT4_F>
__global__ void pipeline_8(int32_t *ps_suppkey, int32_t *ps_partkey, TY_HT2_I HT2_I, TY_HT2_F HT2_F, TY_HT3_I HT3_I, TY_HT3_F HT3_F, TY_HT4_I HT4_I, TY_HT4_F HT4_F, int64_t *B2_supplier, size_t partsupp_size, int64_t *B3_part, int64_t *B2_region, int64_t *B2_nation)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= partsupp_size)
        return;
    int32_t reg_ps_suppkey = ps_suppkey[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_ps_suppkey) << 0);
    auto slot2 = HT2_F.find(key2);
    if (slot2 == HT2_F.end())
        return;
    int32_t reg_ps_partkey = ps_partkey[tid];
    int64_t key3 = 0;
    key3 |= (((int64_t)reg_ps_partkey) << 0);
    auto slot3 = HT3_F.find(key3);
    if (slot3 == HT3_F.end())
        return;
    int64_t key4 = 0;
    key4 |= (((int64_t)reg_ps_partkey) << 0);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT4_I.insert(thread, cuco::pair{key4, 1});
}

template <typename TY_HT2_I, typename TY_HT2_F, typename TY_HT3_I, typename TY_HT3_F, typename TY_HT4_I, typename TY_HT4_F>
__global__ void pipeline_9(double *ps_supplycost, int32_t *ps_suppkey, int32_t *ps_partkey, int8_t *p_mfgr, int32_t *p_partkey, int32_t *agg_p_partkey, int8_t *agg_p_mfgr, double *min_supplycost, TY_HT2_I HT2_I, TY_HT2_F HT2_F, TY_HT3_I HT3_I, TY_HT3_F HT3_F, TY_HT4_I HT4_I, TY_HT4_F HT4_F, int64_t *B2_supplier, size_t partsupp_size, int64_t *B3_part, int64_t *B2_region, int64_t *B2_nation)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= partsupp_size)
        return;
    int32_t reg_ps_suppkey = ps_suppkey[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_ps_suppkey) << 0);
    auto slot2 = HT2_F.find(key2);
    if (slot2 == HT2_F.end())
        return;
    int32_t reg_ps_partkey = ps_partkey[tid];
    int64_t key3 = 0;
    key3 |= (((int64_t)reg_ps_partkey) << 0);
    auto slot3 = HT3_F.find(key3);
    if (slot3 == HT3_F.end())
        return;
    int64_t key4 = 0;
    key4 |= (((int64_t)reg_ps_partkey) << 0);
    auto slot4 = HT4_F.find(key4);
    double reg_ps_supplycost = ps_supplycost[tid];
    int8_t reg_p_mfgr = p_mfgr[B3_part[slot3->second]];
    int32_t reg_p_partkey = p_partkey[B3_part[slot3->second]];
    aggregate_min(&(min_supplycost[slot4->second]), reg_ps_supplycost);
    agg_p_mfgr[slot4->second] = reg_p_mfgr;
    agg_p_partkey[slot4->second] = reg_p_partkey;
}

__global__ void pipeline_11(int32_t *n_regionkey, int8_t *r_name, int32_t *r_regionkey, size_t region_size, int64_t *B7_idx)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= region_size)
        return;
    int8_t reg_r_name = r_name[tid];
    if (!(reg_r_name == 3))
        return;
    int32_t reg_r_regionkey = r_regionkey[tid];
    int64_t key7 = 0;
    key7 |= (((int64_t)reg_r_regionkey) << 0);
    atomicAdd((int *)B7_idx, 1);
}

template <typename TY_HT7_I, typename TY_HT7_F>
__global__ void pipeline_10(int32_t *n_regionkey, int8_t *r_name, int32_t *r_regionkey, TY_HT7_I HT7_I, TY_HT7_F HT7_F, int64_t *B7_region, size_t region_size, int64_t *B7_idx)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= region_size)
        return;
    int8_t reg_r_name = r_name[tid];
    if (!(reg_r_name == 3))
        return;
    int32_t reg_r_regionkey = r_regionkey[tid];
    int64_t key7 = 0;
    key7 |= (((int64_t)reg_r_regionkey) << 0);
    auto reg_B7_idx = atomicAdd((int *)B7_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT7_I.insert(thread, cuco::pair{key7, reg_B7_idx});
    B7_region[reg_B7_idx] = tid;
}

template <typename TY_HT7_I, typename TY_HT7_F>
__global__ void pipeline_13(int32_t *s_nationkey, int32_t *n_regionkey, int32_t *n_nationkey, TY_HT7_I HT7_I, TY_HT7_F HT7_F, int64_t *B8_idx, int64_t *B7_region, size_t nation_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= nation_size)
        return;
    int32_t reg_n_regionkey = n_regionkey[tid];
    int64_t key7 = 0;
    key7 |= (((int64_t)reg_n_regionkey) << 0);
    auto slot7 = HT7_F.find(key7);
    if (slot7 == HT7_F.end())
        return;
    int32_t reg_n_nationkey = n_nationkey[tid];
    int64_t key8 = 0;
    key8 |= (((int64_t)reg_n_nationkey) << 0);
    atomicAdd((int *)B8_idx, 1);
}

template <typename TY_HT8_I, typename TY_HT8_F, typename TY_HT7_I, typename TY_HT7_F>
__global__ void pipeline_12(int32_t *s_nationkey, int32_t *n_regionkey, int32_t *n_nationkey, TY_HT8_I HT8_I, TY_HT8_F HT8_F, TY_HT7_I HT7_I, TY_HT7_F HT7_F, int64_t *B7_region, int64_t *B8_region, int64_t *B8_nation, int64_t *B8_idx, size_t nation_size)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= nation_size)
        return;
    int32_t reg_n_regionkey = n_regionkey[tid];
    int64_t key7 = 0;
    key7 |= (((int64_t)reg_n_regionkey) << 0);
    auto slot7 = HT7_F.find(key7);
    if (slot7 == HT7_F.end())
        return;
    int32_t reg_n_nationkey = n_nationkey[tid];
    int64_t key8 = 0;
    key8 |= (((int64_t)reg_n_nationkey) << 0);
    auto reg_B8_idx = atomicAdd((int *)B8_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT8_I.insert(thread, cuco::pair{key8, reg_B8_idx});
    B8_region[reg_B8_idx] = B7_region[slot7->second];
    B8_nation[reg_B8_idx] = tid;
}

__global__ void pipeline_15(int32_t *s_suppkey, int32_t *ps_suppkey, size_t supplier_size, int64_t *B6_idx)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= supplier_size)
        return;
    int32_t reg_s_suppkey = s_suppkey[tid];
    int64_t key6 = 0;
    key6 |= (((int64_t)reg_s_suppkey) << 0);
    atomicAdd((int *)B6_idx, 1);
}

template <typename TY_HT6_I, typename TY_HT6_F>
__global__ void pipeline_14(int32_t *s_suppkey, int32_t *ps_suppkey, TY_HT6_I HT6_I, TY_HT6_F HT6_F, size_t supplier_size, int64_t *B6_supplier, int64_t *B6_idx)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= supplier_size)
        return;
    int32_t reg_s_suppkey = s_suppkey[tid];
    int64_t key6 = 0;
    key6 |= (((int64_t)reg_s_suppkey) << 0);
    auto reg_B6_idx = atomicAdd((int *)B6_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT6_I.insert(thread, cuco::pair{key6, reg_B6_idx});
    B6_supplier[reg_B6_idx] = tid;
}

__global__ void pipeline_17(double *ps_supplycost, int32_t *ps_partkey, int32_t *agg_p_partkey, double *min_supplycost, size_t agg_size, int64_t *B5_idx)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= agg_size)
        return;
    int32_t reg_agg_p_partkey = agg_p_partkey[tid];
    double reg_min_supplycost = min_supplycost[tid];
    int64_t key5 = 0;
    key5 |= (((int64_t)reg_agg_p_partkey) << 0);
    key5 |= (((int64_t)__double_as_longlong(reg_min_supplycost)) << 32);
    atomicAdd((int *)B5_idx, 1);
}

template <typename TY_HT5_I, typename TY_HT5_F>
__global__ void pipeline_16(double *ps_supplycost, int32_t *ps_partkey, int32_t *agg_p_partkey, double *min_supplycost, TY_HT5_I HT5_I, TY_HT5_F HT5_F, size_t agg_size, int64_t *B5_agg, int64_t *B5_idx)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= agg_size)
        return;
    int32_t reg_agg_p_partkey = agg_p_partkey[tid];
    float reg_min_supplycost = (float)min_supplycost[tid];
    int64_t key5 = 0;
    key5 |= (((int64_t)reg_agg_p_partkey) << 0);
    key5 |= (((int64_t)__double_as_longlong(reg_min_supplycost)) << 32);
    auto reg_B5_idx = atomicAdd((int *)B5_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT5_I.insert(thread, cuco::pair{key5, reg_B5_idx});
    B5_agg[reg_B5_idx] = tid;
}

template <typename TY_HT8_I, typename TY_HT8_F, typename TY_HT5_I, typename TY_HT5_F, typename TY_HT6_I, typename TY_HT6_F>
__global__ void pipeline_18(double *ps_supplycost, int32_t *s_nationkey, int32_t *ps_suppkey, int32_t *ps_partkey, TY_HT8_I HT8_I, TY_HT8_F HT8_F, TY_HT5_I HT5_I, TY_HT5_F HT5_F, TY_HT6_I HT6_I, TY_HT6_F HT6_F, int64_t *B5_agg, int64_t *B6_supplier, int64_t *B8_region, int64_t *B8_nation, size_t partsupp_size, int64_t *d_mat_idx9)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= partsupp_size)
        return;
    int32_t reg_ps_partkey = ps_partkey[tid];
    float reg_ps_supplycost = (float)ps_supplycost[tid];
    int64_t key5 = 0;
    key5 |= (((int64_t)reg_ps_partkey) << 0);
    key5 |= (((int64_t)__double_as_longlong(reg_ps_supplycost)) << 32);
    auto slot5 = HT5_F.find(key5);
    if (slot5 == HT5_F.end())
        return;
    int32_t reg_ps_suppkey = ps_suppkey[tid];
    int64_t key6 = 0;
    key6 |= (((int64_t)reg_ps_suppkey) << 0);
    auto slot6 = HT6_F.find(key6);
    if (slot6 == HT6_F.end())
        return;
    int32_t reg_s_nationkey = s_nationkey[B6_supplier[slot6->second]];
    int64_t key8 = 0;
    key8 |= (((int64_t)reg_s_nationkey) << 0);
    auto slot8 = HT8_F.find(key8);
    if (slot8 == HT8_F.end())
        return;
    atomicAdd((int *)d_mat_idx9, 1);
}

template <typename TY_HT8_I, typename TY_HT8_F, typename TY_HT5_I, typename TY_HT5_F, typename TY_HT6_I, typename TY_HT6_F>
__global__ void pipeline_19(double *s_acctbal, int32_t *ps_suppkey, int32_t *s_nationkey, double *ps_supplycost, int8_t *n_name, int8_t *agg_p_mfgr, int32_t *agg_p_partkey, int32_t *ps_partkey, double *mat_s_acctbal, int32_t *mat_p_partkey, int8_t *mat_p_mfgr, int8_t *mat_n_name, TY_HT8_I HT8_I, TY_HT8_F HT8_F, TY_HT5_I HT5_I, TY_HT5_F HT5_F, TY_HT6_I HT6_I, TY_HT6_F HT6_F, int64_t *B5_agg, int64_t *B6_supplier, int64_t *B8_region, int64_t *B8_nation, size_t partsupp_size, int64_t *d_mat_idx9)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= partsupp_size)
        return;
    int32_t reg_ps_partkey = ps_partkey[tid];
    float reg_ps_supplycost = (float)ps_supplycost[tid];
    int64_t key5 = 0;
    key5 |= (((int64_t)reg_ps_partkey) << 0);
    key5 |= (((int64_t)__double_as_longlong(reg_ps_supplycost)) << 32);
    auto slot5 = HT5_F.find(key5);
    if (slot5 == HT5_F.end())
        return;
    int32_t reg_ps_suppkey = ps_suppkey[tid];
    int64_t key6 = 0;
    key6 |= (((int64_t)reg_ps_suppkey) << 0);
    auto slot6 = HT6_F.find(key6);
    if (slot6 == HT6_F.end())
        return;
    int32_t reg_s_nationkey = s_nationkey[B6_supplier[slot6->second]];
    int64_t key8 = 0;
    key8 |= (((int64_t)reg_s_nationkey) << 0);
    auto slot8 = HT8_F.find(key8);
    if (slot8 == HT8_F.end())
        return;
    double reg_s_acctbal = s_acctbal[B6_supplier[slot6->second]];
    int8_t reg_n_name = n_name[B8_nation[slot8->second]];
    int32_t reg_agg_p_partkey = agg_p_partkey[B5_agg[slot5->second]];
    int8_t reg_agg_p_mfgr = agg_p_mfgr[B5_agg[slot5->second]];
    auto tmp_idx9 = atomicAdd((int *)d_mat_idx9, 1); 
    mat_s_acctbal[tmp_idx9] = reg_s_acctbal;
    mat_n_name[tmp_idx9] = reg_n_name;
    mat_p_partkey[tmp_idx9] = reg_agg_p_partkey;
    mat_p_mfgr[tmp_idx9] = reg_agg_p_mfgr;
}

void control(
    int8_t *n_name,
    int32_t *n_nationkey,
    int32_t *n_regionkey,
    int8_t *p_mfgr,
    int32_t *p_partkey,
    int32_t *p_size,
    StringColumn *p_type,
    int32_t *ps_partkey,
    int32_t *ps_suppkey,
    double *ps_supplycost,
    int8_t *r_name,
    int32_t *r_regionkey,
    int32_t *s_nationkey,
    double *s_acctbal,
    int32_t *s_suppkey,
    size_t nation_size,
    size_t part_size,
    size_t partsupp_size,
    size_t region_size,
    size_t supplier_size)
{
    int32_t *d_p_size;

    cudaMalloc(&d_p_size, sizeof(int32_t) * part_size);

    cudaMemcpy(d_p_size, p_size, sizeof(int32_t) * part_size, cudaMemcpyHostToDevice);

    int32_t *d_p_partkey;

    cudaMalloc(&d_p_partkey, sizeof(int32_t) * part_size);

    cudaMemcpy(d_p_partkey, p_partkey, sizeof(int32_t) * part_size, cudaMemcpyHostToDevice);

    char *d_p_type;

    int64_t *d_p_type_offsets;

    int *d_p_type_sizes;

    cudaMalloc(&d_p_type, sizeof(char) * (p_type->offsets[part_size - 1] + p_type->sizes[part_size - 1]));

    cudaMemcpy(d_p_type, p_type->data, sizeof(char) * (p_type->offsets[part_size - 1] + p_type->sizes[part_size - 1]), cudaMemcpyHostToDevice);

    cudaMalloc(&d_p_type_offsets, sizeof(int64_t) * part_size);

    cudaMemcpy(d_p_type_offsets, p_type->offsets, sizeof(int64_t) * part_size, cudaMemcpyHostToDevice);

    cudaMalloc(&d_p_type_sizes, sizeof(int) * part_size);

    cudaMemcpy(d_p_type_sizes, p_type->sizes, sizeof(int) * part_size, cudaMemcpyHostToDevice);

    int32_t *d_ps_partkey;

    cudaMalloc(&d_ps_partkey, sizeof(int32_t) * partsupp_size);

    cudaMemcpy(d_ps_partkey, ps_partkey, sizeof(int32_t) * partsupp_size, cudaMemcpyHostToDevice);

    int64_t *B3_part;
    int64_t *B3_idx;
    cudaMalloc(&B3_idx, sizeof(int64_t));
    cudaMemset(B3_idx, 0, sizeof(int64_t));
    pipeline_1<<<std::ceil((float)part_size / (float)32), 32>>>(d_p_size, d_p_partkey, d_p_type, d_p_type_offsets, d_p_type_sizes, d_ps_partkey, B3_idx, part_size);

    int64_t h_B3_idx;
    cudaMemcpy(&h_B3_idx, B3_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B3_idx, 0, sizeof(int64_t));
    cudaMalloc(&B3_part, sizeof(int64_t) * h_B3_idx);
    auto HT3 = cuco::static_map{h_B3_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT3_F = HT3.ref(cuco::find);

    auto d_HT3_I = HT3.ref(cuco::insert);

    pipeline_0<<<std::ceil((float)part_size / (float)32), 32>>>(d_p_size, d_p_partkey, d_p_type, d_p_type_offsets, d_p_type_sizes, d_ps_partkey, d_HT3_I, d_HT3_F, B3_part, B3_idx, part_size);

    int32_t *d_r_regionkey;

    cudaMalloc(&d_r_regionkey, sizeof(int32_t) * region_size);

    cudaMemcpy(d_r_regionkey, r_regionkey, sizeof(int32_t) * region_size, cudaMemcpyHostToDevice);

    int32_t *d_n_regionkey;

    cudaMalloc(&d_n_regionkey, sizeof(int32_t) * nation_size);

    cudaMemcpy(d_n_regionkey, n_regionkey, sizeof(int32_t) * nation_size, cudaMemcpyHostToDevice);

    int8_t *d_r_name;

    cudaMalloc(&d_r_name, sizeof(int8_t) * region_size);

    cudaMemcpy(d_r_name, r_name, sizeof(int8_t) * region_size, cudaMemcpyHostToDevice);

    int64_t *B0_region;
    int64_t *B0_idx;
    cudaMalloc(&B0_idx, sizeof(int64_t));
    cudaMemset(B0_idx, 0, sizeof(int64_t));
    pipeline_3<<<std::ceil((float)region_size / (float)32), 32>>>(d_r_name, d_r_regionkey, d_n_regionkey, B0_idx, region_size);

    int64_t h_B0_idx;
    cudaMemcpy(&h_B0_idx, B0_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B0_idx, 0, sizeof(int64_t));
    cudaMalloc(&B0_region, sizeof(int64_t) * h_B0_idx);
    auto HT0 = cuco::static_map{h_B0_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT0_F = HT0.ref(cuco::find);

    auto d_HT0_I = HT0.ref(cuco::insert);

    pipeline_2<<<std::ceil((float)region_size / (float)32), 32>>>(d_r_regionkey, d_n_regionkey, d_r_name, d_HT0_I, d_HT0_F, B0_idx, region_size, B0_region);

    int32_t *d_n_nationkey;

    cudaMalloc(&d_n_nationkey, sizeof(int32_t) * nation_size);

    cudaMemcpy(d_n_nationkey, n_nationkey, sizeof(int32_t) * nation_size, cudaMemcpyHostToDevice);

    int32_t *d_s_nationkey;

    cudaMalloc(&d_s_nationkey, sizeof(int32_t) * supplier_size);

    cudaMemcpy(d_s_nationkey, s_nationkey, sizeof(int32_t) * supplier_size, cudaMemcpyHostToDevice);

    int64_t *B1_region;
    int64_t *B1_nation;
    int64_t *B1_idx;
    cudaMalloc(&B1_idx, sizeof(int64_t));
    cudaMemset(B1_idx, 0, sizeof(int64_t));
    pipeline_5<<<std::ceil((float)nation_size / (float)32), 32>>>(d_n_nationkey, d_s_nationkey, d_n_regionkey, d_HT0_I, d_HT0_F, B1_idx, B0_region, nation_size);

    int64_t h_B1_idx;
    cudaMemcpy(&h_B1_idx, B1_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B1_idx, 0, sizeof(int64_t));
    cudaMalloc(&B1_nation, sizeof(int64_t) * h_B1_idx);
    cudaMalloc(&B1_region, sizeof(int64_t) * h_B1_idx);
    auto HT1 = cuco::static_map{h_B1_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT1_F = HT1.ref(cuco::find);

    auto d_HT1_I = HT1.ref(cuco::insert);

    pipeline_4<<<std::ceil((float)nation_size / (float)32), 32>>>(d_n_nationkey, d_s_nationkey, d_n_regionkey, d_HT0_I, d_HT0_F, d_HT1_I, d_HT1_F, B1_region, B1_idx, B1_nation, nation_size, B0_region);

    int32_t *d_ps_suppkey;

    cudaMalloc(&d_ps_suppkey, sizeof(int32_t) * partsupp_size);

    cudaMemcpy(d_ps_suppkey, ps_suppkey, sizeof(int32_t) * partsupp_size, cudaMemcpyHostToDevice);

    int32_t *d_s_suppkey;

    cudaMalloc(&d_s_suppkey, sizeof(int32_t) * supplier_size);

    cudaMemcpy(d_s_suppkey, s_suppkey, sizeof(int32_t) * supplier_size, cudaMemcpyHostToDevice);

    int64_t *B2_supplier;
    int64_t *B2_nation;
    int64_t *B2_region;
    int64_t *B2_idx;
    cudaMalloc(&B2_idx, sizeof(int64_t));
    cudaMemset(B2_idx, 0, sizeof(int64_t));
    pipeline_7<<<std::ceil((float)supplier_size / (float)32), 32>>>(d_ps_suppkey, d_s_nationkey, d_s_suppkey, d_HT1_I, d_HT1_F, supplier_size, B1_region, B2_idx, B1_nation);

    int64_t h_B2_idx;
    cudaMemcpy(&h_B2_idx, B2_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B2_idx, 0, sizeof(int64_t));
    cudaMalloc(&B2_region, sizeof(int64_t) * h_B2_idx);
    cudaMalloc(&B2_supplier, sizeof(int64_t) * h_B2_idx);
    cudaMalloc(&B2_nation, sizeof(int64_t) * h_B2_idx);
    auto HT2 = cuco::static_map{h_B2_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT2_F = HT2.ref(cuco::find);

    auto d_HT2_I = HT2.ref(cuco::insert);

    pipeline_6<<<std::ceil((float)supplier_size / (float)32), 32>>>(d_ps_suppkey, d_s_nationkey, d_s_suppkey, d_HT1_I, d_HT1_F, d_HT2_I, d_HT2_F, B2_idx, B2_supplier, B2_nation, supplier_size, B1_nation, B2_region, B1_region);

    double *d_ps_supplycost;

    cudaMalloc(&d_ps_supplycost, sizeof(double) * partsupp_size);

    cudaMemcpy(d_ps_supplycost, ps_supplycost, sizeof(double) * partsupp_size, cudaMemcpyHostToDevice);

    int8_t *d_p_mfgr;

    cudaMalloc(&d_p_mfgr, sizeof(int8_t) * part_size);

    cudaMemcpy(d_p_mfgr, p_mfgr, sizeof(int8_t) * part_size, cudaMemcpyHostToDevice);

    int32_t *d_agg_p_partkey;

    int8_t *d_agg_p_mfgr;

    double *d_min_supplycost;

    auto HT4 = cuco::static_map{partsupp_size * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT4_F = HT4.ref(cuco::find);

    auto d_HT4_I = HT4.ref(cuco::insert);

    pipeline_8<<<std::ceil((float)partsupp_size / (float)32), 32>>>(d_ps_suppkey, d_ps_partkey, d_HT2_I, d_HT2_F, d_HT3_I, d_HT3_F, d_HT4_I, d_HT4_F, B2_supplier, partsupp_size, B3_part, B2_region, B2_nation);

    auto HT4_size = HT4.size();

    cudaMalloc(&d_agg_p_partkey, sizeof(int32_t) * HT4_size);

    cudaMalloc(&d_agg_p_mfgr, sizeof(int8_t) * HT4_size);

    cudaMalloc(&d_min_supplycost, sizeof(double) * HT4_size);

    cudaMemset(d_agg_p_partkey, 0, sizeof(int32_t) * HT4_size);

    cudaMemset(d_agg_p_mfgr, 0, sizeof(int8_t) * HT4_size);

    cudaMemset(d_min_supplycost, 0, sizeof(double) * HT4_size);

    thrust::device_vector<int64_t> keys_4(HT4_size), vals_4(HT4_size);
    HT4.retrieve_all(keys_4.begin(), vals_4.begin());
    thrust::host_vector<int64_t> h_keys_4(HT4_size);
    thrust::copy(keys_4.begin(), keys_4.end(), h_keys_4.begin());
    thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_4(HT4_size);
    for (int i = 0; i < HT4_size; i++)
    {
        actual_dict_4[i] = cuco::make_pair(h_keys_4[i], i);
    }
    HT4.clear();
    HT4.insert(actual_dict_4.begin(), actual_dict_4.end());
    pipeline_9<<<std::ceil((float)partsupp_size / (float)32), 32>>>(d_ps_supplycost, d_ps_suppkey, d_ps_partkey, d_p_mfgr, d_p_partkey, d_agg_p_partkey, d_agg_p_mfgr, d_min_supplycost, d_HT2_I, d_HT2_F, d_HT3_I, d_HT3_F, d_HT4_I, d_HT4_F, B2_supplier, partsupp_size, B3_part, B2_region, B2_nation);

    size_t agg_size = HT4_size;

    std::cout << "Agg size 1: " << agg_size << std::endl;

    int64_t *B7_region;
    int64_t *B7_idx;
    cudaMalloc(&B7_idx, sizeof(int64_t));
    cudaMemset(B7_idx, 0, sizeof(int64_t));
    pipeline_11<<<std::ceil((float)region_size / (float)32), 32>>>(d_n_regionkey, d_r_name, d_r_regionkey, region_size, B7_idx);

    int64_t h_B7_idx;
    cudaMemcpy(&h_B7_idx, B7_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B7_idx, 0, sizeof(int64_t));
    cudaMalloc(&B7_region, sizeof(int64_t) * h_B7_idx);
    auto HT7 = cuco::static_map{h_B7_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT7_F = HT7.ref(cuco::find);

    auto d_HT7_I = HT7.ref(cuco::insert);

    pipeline_10<<<std::ceil((float)region_size / (float)32), 32>>>(d_n_regionkey, d_r_name, d_r_regionkey, d_HT7_I, d_HT7_F, B7_region, region_size, B7_idx);

    int64_t *B8_region;
    int64_t *B8_nation;
    int64_t *B8_idx;
    cudaMalloc(&B8_idx, sizeof(int64_t));
    cudaMemset(B8_idx, 0, sizeof(int64_t));
    pipeline_13<<<std::ceil((float)nation_size / (float)32), 32>>>(d_s_nationkey, d_n_regionkey, d_n_nationkey, d_HT7_I, d_HT7_F, B8_idx, B7_region, nation_size);

    int64_t h_B8_idx;
    cudaMemcpy(&h_B8_idx, B8_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B8_idx, 0, sizeof(int64_t));
    cudaMalloc(&B8_region, sizeof(int64_t) * h_B8_idx);
    cudaMalloc(&B8_nation, sizeof(int64_t) * h_B8_idx);
    auto HT8 = cuco::static_map{h_B8_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT8_F = HT8.ref(cuco::find);

    auto d_HT8_I = HT8.ref(cuco::insert);

    pipeline_12<<<std::ceil((float)nation_size / (float)32), 32>>>(d_s_nationkey, d_n_regionkey, d_n_nationkey, d_HT8_I, d_HT8_F, d_HT7_I, d_HT7_F, B7_region, B8_region, B8_nation, B8_idx, nation_size);

    int64_t *B6_supplier;
    int64_t *B6_idx;
    cudaMalloc(&B6_idx, sizeof(int64_t));
    cudaMemset(B6_idx, 0, sizeof(int64_t));
    pipeline_15<<<std::ceil((float)supplier_size / (float)32), 32>>>(d_s_suppkey, d_ps_suppkey, supplier_size, B6_idx);

    int64_t h_B6_idx;
    cudaMemcpy(&h_B6_idx, B6_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B6_idx, 0, sizeof(int64_t));
    cudaMalloc(&B6_supplier, sizeof(int64_t) * h_B6_idx);
    auto HT6 = cuco::static_map{h_B6_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT6_F = HT6.ref(cuco::find);

    auto d_HT6_I = HT6.ref(cuco::insert);

    pipeline_14<<<std::ceil((float)supplier_size / (float)32), 32>>>(d_s_suppkey, d_ps_suppkey, d_HT6_I, d_HT6_F, supplier_size, B6_supplier, B6_idx);

    int64_t *B5_agg;
    int64_t *B5_idx;
    cudaMalloc(&B5_idx, sizeof(int64_t));
    cudaMemset(B5_idx, 0, sizeof(int64_t));
    pipeline_17<<<std::ceil((float)agg_size / (float)32), 32>>>(d_ps_supplycost, d_ps_partkey, d_agg_p_partkey, d_min_supplycost, agg_size, B5_idx);

    int64_t h_B5_idx;
    cudaMemcpy(&h_B5_idx, B5_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B5_idx, 0, sizeof(int64_t));
    cudaMalloc(&B5_agg, sizeof(int64_t) * h_B5_idx);
    auto HT5 = cuco::static_map{h_B5_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT5_F = HT5.ref(cuco::find);

    auto d_HT5_I = HT5.ref(cuco::insert);

    pipeline_16<<<std::ceil((float)agg_size / (float)32), 32>>>(d_ps_supplycost, d_ps_partkey, d_agg_p_partkey, d_min_supplycost, d_HT5_I, d_HT5_F, agg_size, B5_agg, B5_idx);

    double *d_mat_s_acctbal;

    int32_t *d_mat_p_partkey;

    int8_t *d_mat_p_mfgr;

    int8_t *d_mat_n_name;

    int64_t *d_mat_idx9;
    cudaMalloc(&d_mat_idx9, sizeof(int64_t));

    cudaMemset(d_mat_idx9, 0, sizeof(int64_t));

    pipeline_18<<<std::ceil((float)partsupp_size / (float)32), 32>>>(d_ps_supplycost, d_s_nationkey, d_ps_suppkey, d_ps_partkey, d_HT8_I, d_HT8_F, d_HT5_I, d_HT5_F, d_HT6_I, d_HT6_F, B5_agg, B6_supplier, B8_region, B8_nation, partsupp_size, d_mat_idx9);

    int64_t mat_size;

    cudaMemcpy(&mat_size, d_mat_idx9, sizeof(int64_t), cudaMemcpyDeviceToHost);

    std::cout << "mat size: " << mat_size << std::endl;

    cudaMemset(d_mat_idx9, 0, sizeof(int64_t));

    cudaMalloc(&d_mat_s_acctbal, sizeof(double) * mat_size);

    cudaMalloc(&d_mat_p_partkey, sizeof(int32_t) * mat_size);

    cudaMalloc(&d_mat_p_mfgr, sizeof(int8_t) * mat_size);

    cudaMalloc(&d_mat_n_name, sizeof(int8_t) * mat_size);

    cudaMemset(d_mat_s_acctbal, 0, sizeof(double) * mat_size);

    cudaMemset(d_mat_p_partkey, 0, sizeof(int32_t) * mat_size);

    cudaMemset(d_mat_p_mfgr, 0, sizeof(int8_t) * mat_size);

    cudaMemset(d_mat_n_name, 0, sizeof(int8_t) * mat_size);
    double *d_s_acctbal;

    cudaMalloc(&d_s_acctbal, sizeof(double) * supplier_size);

    cudaMemcpy(d_s_acctbal, s_acctbal, sizeof(double) * supplier_size, cudaMemcpyHostToDevice);

    int8_t *d_n_name;

    cudaMalloc(&d_n_name, sizeof(int8_t) * nation_size);

    cudaMemcpy(d_n_name, n_name, sizeof(int8_t) * nation_size, cudaMemcpyHostToDevice);

    pipeline_19<<<std::ceil((float)partsupp_size / (float)32), 32>>>(d_s_acctbal, d_ps_suppkey, d_s_nationkey, d_ps_supplycost, d_n_name, d_agg_p_mfgr, d_agg_p_partkey, d_ps_partkey, d_mat_s_acctbal, d_mat_p_partkey, d_mat_p_mfgr, d_mat_n_name, d_HT8_I, d_HT8_F, d_HT5_I, d_HT5_F, d_HT6_I, d_HT6_F, B5_agg, B6_supplier, B8_region, B8_nation, partsupp_size, d_mat_idx9);

    double *p_mat_s_acctbal = (double *)malloc(sizeof(double) * mat_size);
    cudaMemcpy(p_mat_s_acctbal, d_mat_s_acctbal, sizeof(double) * mat_size, cudaMemcpyDeviceToHost);
    int8_t *p_mat_n_name = (int8_t *)malloc(sizeof(int8_t) * mat_size);
    cudaMemcpy(p_mat_n_name, d_mat_n_name, sizeof(int8_t) * mat_size, cudaMemcpyDeviceToHost);
    int32_t *p_mat_p_partkey = (int32_t *)malloc(sizeof(int32_t) * mat_size);
    cudaMemcpy(p_mat_p_partkey, d_mat_p_partkey, sizeof(int32_t) * mat_size, cudaMemcpyDeviceToHost);
    int8_t *p_mat_p_mfgr = (int8_t *)malloc(sizeof(int8_t) * mat_size);
    cudaMemcpy(p_mat_p_mfgr, d_mat_p_mfgr, sizeof(int8_t) * mat_size, cudaMemcpyDeviceToHost);
    for (int i = 0; i < mat_size; i++)
    {
        std::cout << p_mat_s_acctbal[i] << "\t";
        std::cout << (int)p_mat_n_name[i] << "\t";
        std::cout << p_mat_p_partkey[i] << "\t";
        std::cout << (int)p_mat_p_mfgr[i] << "\t";
        std::cout << std::endl;
    }
}

int main(int argc, const char **argv)
{
    std::string dbDir = getDataDir(argv, argc);
    std::string nation_file = dbDir + "nation.parquet";
    std::string part_file = dbDir + "part.parquet";
    std::string partsupp_file = dbDir + "partsupp.parquet";
    std::string supplier_file = dbDir + "supplier.parquet";
    std::string region_file = dbDir + "region.parquet";

    // auto lineitem_table  = getArrowTable(lineitem_file);
    auto nation_table = getArrowTable(nation_file);
    auto region_table = getArrowTable(region_file);
    auto part_table = getArrowTable(part_file);
    auto partsupp_table = getArrowTable(partsupp_file);
    auto supplier_table = getArrowTable(supplier_file);
    size_t nation_size = nation_table->num_rows();
    size_t part_size = part_table->num_rows();
    size_t partsupp_size = partsupp_table->num_rows();
    size_t region_size = region_table->num_rows();
    size_t supplier_size = supplier_table->num_rows();

    auto n_nationkey = read_column_typecasted<int32_t>(nation_table, "n_nationkey");
    auto n_regionkey = read_column_typecasted<int32_t>(nation_table, "n_regionkey");
    auto n_name = read_string_dict_encoded_column(nation_table, "n_name");

    auto p_partkey = read_column_typecasted<int32_t>(part_table, "p_partkey");
    auto p_mfgr = read_string_dict_encoded_column(part_table, "p_mfgr");
    auto p_size = read_column_typecasted<int32_t>(part_table, "p_size");
    auto p_type = read_string_column(part_table, "p_type");

    auto ps_partkey = read_column_typecasted<int32_t>(partsupp_table, "ps_partkey");
    auto ps_suppkey = read_column_typecasted<int32_t>(partsupp_table, "ps_suppkey");
    auto ps_supplycost = read_column<double>(partsupp_table, "ps_supplycost");

    auto r_name = read_string_dict_encoded_column(region_table, "r_name");
    auto r_regionkey = read_column_typecasted<int32_t>(region_table, "r_regionkey");

    auto s_nationkey = read_column_typecasted<int32_t>(supplier_table, "s_nationkey");
    auto s_suppkey = read_column_typecasted<int32_t>(supplier_table, "s_suppkey");
    auto s_acctbal = read_column<double>(supplier_table, "s_acctbal");

    // for (auto p: c_mktsegment->dict) {
    //   std::cout << p.first << " " << (int)p.second << std::endl;
    // }
    control(
        n_name->column,
        n_nationkey.data(),
        n_regionkey.data(),
        p_mfgr->column,
        p_partkey.data(),
        p_size.data(),
        p_type,
        ps_partkey.data(),
        ps_suppkey.data(),
        ps_supplycost.data(),
        r_name->column,
        r_regionkey.data(),
        s_nationkey.data(),
        s_acctbal.data(),
        s_suppkey.data(),
        nation_size,
        part_size,
        partsupp_size,
        region_size,
        supplier_size);
}