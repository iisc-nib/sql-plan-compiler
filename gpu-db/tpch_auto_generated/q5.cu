#include "utils.h"

#include <cuco/static_map.cuh>

#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
namespace cg = cooperative_groups;

__global__ void pipeline_1 (int32_t* c_nationkey, int32_t* l_suppkey, int32_t* s_suppkey, int32_t* s_nationkey, size_t supplier_size, int64_t* B4_idx) {
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= supplier_size) return;
    int32_t reg_s_nationkey = s_nationkey[tid];
    int32_t reg_s_suppkey = s_suppkey[tid];
    int64_t key4 = 0;
    key4 |= (((int64_t)reg_s_nationkey) << 0);
    key4 |= (((int64_t)reg_s_suppkey) << 32);
    atomicAdd((int*)B4_idx, 1);
    }
    
    template <typename TY_HT4_I, typename TY_HT4_F>
    __global__ void pipeline_0 (int32_t* c_nationkey, int32_t* l_suppkey, int32_t* s_suppkey, int32_t* s_nationkey, TY_HT4_I HT4_I, TY_HT4_F HT4_F, size_t supplier_size, int64_t* B4_supplier, int64_t* B4_idx) {
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= supplier_size) return;
    int32_t reg_s_nationkey = s_nationkey[tid];
    int32_t reg_s_suppkey = s_suppkey[tid];
    int64_t key4 = 0;
    key4 |= (((int64_t)reg_s_nationkey) << 0);
    key4 |= (((int64_t)reg_s_suppkey) << 32);
    auto reg_B4_idx = atomicAdd((int*)B4_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT4_I.insert(thread, cuco::pair{key4, reg_B4_idx});
    B4_supplier[reg_B4_idx] = tid;
    }
    
    
    __global__ void pipeline_3 (int32_t* r_regionkey, int32_t* n_regionkey, int8_t* r_name, size_t region_size, int64_t* B0_idx) {
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= region_size) return;
    int8_t reg_r_name = r_name[tid];
    if (!(reg_r_name  == 2)) return;
    int32_t reg_r_regionkey = r_regionkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_r_regionkey) << 0);
    atomicAdd((int*)B0_idx, 1);
    }
    
    template <typename TY_HT0_I, typename TY_HT0_F>
    __global__ void pipeline_2 (int32_t* r_regionkey, int32_t* n_regionkey, int8_t* r_name, TY_HT0_I HT0_I, TY_HT0_F HT0_F, int64_t* B0_region, size_t region_size, int64_t* B0_idx) {
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= region_size) return;
    int8_t reg_r_name = r_name[tid];
    if (!(reg_r_name  == 2)) return;
    int32_t reg_r_regionkey = r_regionkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_r_regionkey) << 0);
    auto reg_B0_idx = atomicAdd((int*)B0_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT0_I.insert(thread, cuco::pair{key0, reg_B0_idx});
    B0_region[reg_B0_idx] = tid;
    }
    
    template <typename TY_HT0_I, typename TY_HT0_F>
    __global__ void pipeline_5 (int32_t* c_nationkey, int32_t* n_regionkey, int32_t* n_nationkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, int64_t* B0_region, size_t nation_size, int64_t* B1_idx) {
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= nation_size) return;
    int32_t reg_n_regionkey = n_regionkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_n_regionkey) << 0);
    auto slot0 = HT0_F.find(key0);
    if (slot0 == HT0_F.end()) return;
    int32_t reg_n_nationkey = n_nationkey[tid];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_n_nationkey) << 0);
    atomicAdd((int*)B1_idx, 1);
    }
    
    template <typename TY_HT0_I, typename TY_HT0_F, typename TY_HT1_I, typename TY_HT1_F>
    __global__ void pipeline_4 (int32_t* c_nationkey, int32_t* n_regionkey, int32_t* n_nationkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, TY_HT1_I HT1_I, TY_HT1_F HT1_F, int64_t* B0_region, int64_t* B1_region, int64_t* B1_nation, size_t nation_size, int64_t* B1_idx) {
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= nation_size) return;
    int32_t reg_n_regionkey = n_regionkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_n_regionkey) << 0);
    auto slot0 = HT0_F.find(key0);
    if (slot0 == HT0_F.end()) return;
    int32_t reg_n_nationkey = n_nationkey[tid];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_n_nationkey) << 0);
    auto reg_B1_idx = atomicAdd((int*)B1_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT1_I.insert(thread, cuco::pair{key1, reg_B1_idx});
    B1_region[reg_B1_idx] = B0_region[slot0->second];
    B1_nation[reg_B1_idx] = tid;
    }
    
    template <typename TY_HT1_I, typename TY_HT1_F>
    __global__ void pipeline_7 (int32_t* c_custkey, int32_t* c_nationkey, int32_t* o_custkey, TY_HT1_I HT1_I, TY_HT1_F HT1_F, size_t customer_size, int64_t* B1_region, int64_t* B1_nation, int64_t* B2_idx) {
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= customer_size) return;
    int32_t reg_c_nationkey = c_nationkey[tid];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_c_nationkey) << 0);
    auto slot1 = HT1_F.find(key1);
    if (slot1 == HT1_F.end()) return;
    int32_t reg_c_custkey = c_custkey[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_c_custkey) << 0);
    atomicAdd((int*)B2_idx, 1);
    }
    
    template <typename TY_HT1_I, typename TY_HT1_F, typename TY_HT2_I, typename TY_HT2_F>
    __global__ void pipeline_6 (int32_t* c_custkey, int32_t* c_nationkey, int32_t* o_custkey, TY_HT1_I HT1_I, TY_HT1_F HT1_F, TY_HT2_I HT2_I, TY_HT2_F HT2_F, int64_t* B1_region, int64_t* B2_nation, size_t customer_size, int64_t* B1_nation, int64_t* B2_region, int64_t* B2_customer, int64_t* B2_idx) {
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= customer_size) return;
    int32_t reg_c_nationkey = c_nationkey[tid];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_c_nationkey) << 0);
    auto slot1 = HT1_F.find(key1);
    if (slot1 == HT1_F.end()) return;
    int32_t reg_c_custkey = c_custkey[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_c_custkey) << 0);
    auto reg_B2_idx = atomicAdd((int*)B2_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT2_I.insert(thread, cuco::pair{key2, reg_B2_idx});
    B2_region[reg_B2_idx] = B1_region[slot1->second];
    B2_customer[reg_B2_idx] = tid;
    B2_nation[reg_B2_idx] = B1_nation[slot1->second];
    }
    
    template <typename TY_HT2_I, typename TY_HT2_F>
    __global__ void pipeline_9 (int32_t* o_orderdate, int32_t* o_custkey, int32_t* l_orderkey, int32_t* o_orderkey, TY_HT2_I HT2_I, TY_HT2_F HT2_F, int64_t* B3_idx, int64_t* B2_nation, int64_t* B2_customer, size_t orders_size, int64_t* B2_region) {
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= orders_size) return;
    int32_t reg_o_orderdate = o_orderdate[tid];
    if (!(reg_o_orderdate >= 8766)) return;
    if (!(reg_o_orderdate < 9131)) return;
    int32_t reg_o_custkey = o_custkey[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_o_custkey) << 0);
    auto slot2 = HT2_F.find(key2);
    if (slot2 == HT2_F.end()) return;
    int32_t reg_o_orderkey = o_orderkey[tid];
    int64_t key3 = 0;
    key3 |= (((int64_t)reg_o_orderkey) << 0);
    atomicAdd((int*)B3_idx, 1);
    }
    
    template <typename TY_HT2_I, typename TY_HT2_F, typename TY_HT3_I, typename TY_HT3_F>
    __global__ void pipeline_8 (int32_t* o_orderdate, int32_t* o_custkey, int32_t* l_orderkey, int32_t* o_orderkey, TY_HT2_I HT2_I, TY_HT2_F HT2_F, TY_HT3_I HT3_I, TY_HT3_F HT3_F, int64_t* B3_idx, int64_t* B2_nation, int64_t* B2_customer, int64_t* B2_region, size_t orders_size, int64_t* B3_orders, int64_t* B3_nation, int64_t* B3_customer, int64_t* B3_region) {
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= orders_size) return;
    int32_t reg_o_orderdate = o_orderdate[tid];
    if (!(reg_o_orderdate >= 8766)) return;
    if (!(reg_o_orderdate < 9131)) return;
    int32_t reg_o_custkey = o_custkey[tid];
    int64_t key2 = 0;
    key2 |= (((int64_t)reg_o_custkey) << 0);
    auto slot2 = HT2_F.find(key2);
    if (slot2 == HT2_F.end()) return;
    int32_t reg_o_orderkey = o_orderkey[tid];
    int64_t key3 = 0;
    key3 |= (((int64_t)reg_o_orderkey) << 0);
    auto reg_B3_idx = atomicAdd((int*)B3_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT3_I.insert(thread, cuco::pair{key3, reg_B3_idx});
    B3_region[reg_B3_idx] = B2_region[slot2->second];
    B3_nation[reg_B3_idx] = B2_nation[slot2->second];
    B3_customer[reg_B3_idx] = B2_customer[slot2->second];
    B3_orders[reg_B3_idx] = tid;
    }
    
    template <typename TY_HT3_I, typename TY_HT3_F, typename TY_HT4_I, typename TY_HT4_F, typename TY_HT5_I, typename TY_HT5_F>
    __global__ void pipeline_10 (int32_t* l_suppkey, int32_t* l_orderkey, double* l_discount, int8_t* n_name, int32_t* c_nationkey, double* l_extendedprice, TY_HT3_I HT3_I, TY_HT3_F HT3_F, TY_HT4_I HT4_I, TY_HT4_F HT4_F, TY_HT5_I HT5_I, TY_HT5_F HT5_F, size_t lineitem_size, int64_t* B4_supplier, int64_t* B3_orders, int64_t* B3_nation, int64_t* B3_customer, int64_t* B3_region) {
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= lineitem_size) return;
    int32_t reg_l_orderkey = l_orderkey[tid];
    int64_t key3 = 0;
    key3 |= (((int64_t)reg_l_orderkey) << 0);
    auto slot3 = HT3_F.find(key3);
    if (slot3 == HT3_F.end()) return;
    int32_t reg_c_nationkey = c_nationkey[B3_customer[slot3->second]];
    int32_t reg_l_suppkey = l_suppkey[tid];
    int64_t key4 = 0;
    key4 |= (((int64_t)reg_c_nationkey) << 0);
    key4 |= (((int64_t)reg_l_suppkey) << 32);
    auto slot4 = HT4_F.find(key4);
    if (slot4 == HT4_F.end()) return;
    double reg_l_extendedprice = l_extendedprice[tid];
    double reg_l_discount = l_discount[tid];
    double reg_revenue = (reg_l_extendedprice * (1 - reg_l_discount));
    int8_t reg_n_name = n_name[B3_nation[slot3->second]];
    int64_t key5 = 0;
    key5 |= (((int64_t)reg_n_name) << 0);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT5_I.insert(thread, cuco::pair{key5, 1});
    }
    
    template <typename TY_HT3_I, typename TY_HT3_F, typename TY_HT4_I, typename TY_HT4_F, typename TY_HT5_I, typename TY_HT5_F>
    __global__ void pipeline_11 (int32_t* l_suppkey, double* l_extendedprice, int32_t* l_orderkey, double* l_discount, int32_t* c_nationkey, int8_t* n_name, int8_t* agg_n_name, double* agg_revenue, TY_HT3_I HT3_I, TY_HT3_F HT3_F, TY_HT4_I HT4_I, TY_HT4_F HT4_F, TY_HT5_I HT5_I, TY_HT5_F HT5_F, int64_t* B4_supplier, size_t lineitem_size, int64_t* B3_orders, int64_t* B3_nation, int64_t* B3_customer, int64_t* B3_region) {
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= lineitem_size) return;
    int32_t reg_l_orderkey = l_orderkey[tid];
    int64_t key3 = 0;
    key3 |= (((int64_t)reg_l_orderkey) << 0);
    auto slot3 = HT3_F.find(key3);
    if (slot3 == HT3_F.end()) return;
    int32_t reg_c_nationkey = c_nationkey[B3_customer[slot3->second]];
    int32_t reg_l_suppkey = l_suppkey[tid];
    int64_t key4 = 0;
    key4 |= (((int64_t)reg_c_nationkey) << 0);
    key4 |= (((int64_t)reg_l_suppkey) << 32);
    auto slot4 = HT4_F.find(key4);
    if (slot4 == HT4_F.end()) return;
    double reg_l_extendedprice = l_extendedprice[tid];
    double reg_l_discount = l_discount[tid];
    double reg_revenue = (reg_l_extendedprice * (1 - reg_l_discount));
    int8_t reg_n_name = n_name[B3_nation[slot3->second]];
    int64_t key5 = 0;
    key5 |= (((int64_t)reg_n_name) << 0);
    auto slot5 = HT5_F.find(key5);
    agg_n_name[slot5->second] = reg_n_name;
    aggregate_sum(&(agg_revenue[slot5->second]), reg_revenue);
    }
    
    void control(
    int32_t *c_custkey,
    int32_t *c_nationkey,
    double *l_discount,
    double *l_extendedprice,
    int32_t *l_orderkey,
    int32_t *l_suppkey,
    int8_t *n_name,
    int32_t *n_nationkey,
    int32_t *n_regionkey,
    int32_t *o_custkey,
    int32_t *o_orderdate,
    int32_t *o_orderkey,
    int8_t *r_name,
    int32_t *r_regionkey,
    int32_t *s_nationkey,
    int32_t *s_suppkey,
    size_t customer_size,
    size_t lineitem_size,
    size_t nation_size,
    size_t orders_size,
    size_t region_size,
    size_t supplier_size
    ) {
    int32_t* d_c_nationkey;
    
    cudaMalloc(&d_c_nationkey, sizeof(int32_t) * customer_size);
    
    cudaMemcpy(d_c_nationkey, c_nationkey, sizeof(int32_t) * customer_size, cudaMemcpyHostToDevice);
    
    int32_t* d_l_suppkey;
    
    cudaMalloc(&d_l_suppkey, sizeof(int32_t) * lineitem_size);
    
    cudaMemcpy(d_l_suppkey, l_suppkey, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);
    
    int32_t* d_s_suppkey;
    
    cudaMalloc(&d_s_suppkey, sizeof(int32_t) * supplier_size);
    
    cudaMemcpy(d_s_suppkey, s_suppkey, sizeof(int32_t) * supplier_size, cudaMemcpyHostToDevice);
    
    int32_t* d_s_nationkey;
    
    cudaMalloc(&d_s_nationkey, sizeof(int32_t) * supplier_size);
    
    cudaMemcpy(d_s_nationkey, s_nationkey, sizeof(int32_t) * supplier_size, cudaMemcpyHostToDevice);
    
    int64_t* B4_supplier;
    int64_t* B4_idx;
    cudaMalloc(&B4_idx, sizeof(int64_t));
    cudaMemset(B4_idx, 0, sizeof(int64_t));
    pipeline_1<<<std::ceil((float)supplier_size/(float)32), 32>>>(d_c_nationkey, d_l_suppkey, d_s_suppkey, d_s_nationkey, supplier_size, B4_idx);
    
    int64_t h_B4_idx;
    cudaMemcpy(&h_B4_idx, B4_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B4_idx, 0, sizeof(int64_t));
    cudaMalloc(&B4_supplier, sizeof(int64_t) * h_B4_idx);
    auto HT4 = cuco::static_map{ h_B4_idx * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};
    
    auto d_HT4_F = HT4.ref(cuco::find);
    
    auto d_HT4_I = HT4.ref(cuco::insert);
    
    pipeline_0<<<std::ceil((float)supplier_size/(float)32), 32>>>(d_c_nationkey, d_l_suppkey, d_s_suppkey, d_s_nationkey, d_HT4_I, d_HT4_F, supplier_size, B4_supplier, B4_idx);
    
    int32_t* d_r_regionkey;
    
    cudaMalloc(&d_r_regionkey, sizeof(int32_t) * region_size);
    
    cudaMemcpy(d_r_regionkey, r_regionkey, sizeof(int32_t) * region_size, cudaMemcpyHostToDevice);
    
    int32_t* d_n_regionkey;
    
    cudaMalloc(&d_n_regionkey, sizeof(int32_t) * nation_size);
    
    cudaMemcpy(d_n_regionkey, n_regionkey, sizeof(int32_t) * nation_size, cudaMemcpyHostToDevice);
    
    int8_t* d_r_name;
    
    cudaMalloc(&d_r_name, sizeof(int8_t) * region_size);
    
    cudaMemcpy(d_r_name, r_name, sizeof(int8_t) * region_size, cudaMemcpyHostToDevice);
    
    int64_t* B0_region;
    int64_t* B0_idx;
    cudaMalloc(&B0_idx, sizeof(int64_t));
    cudaMemset(B0_idx, 0, sizeof(int64_t));
    pipeline_3<<<std::ceil((float)region_size/(float)32), 32>>>(d_r_regionkey, d_n_regionkey, d_r_name, region_size, B0_idx);
    
    int64_t h_B0_idx;
    cudaMemcpy(&h_B0_idx, B0_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B0_idx, 0, sizeof(int64_t));
    cudaMalloc(&B0_region, sizeof(int64_t) * h_B0_idx);
    auto HT0 = cuco::static_map{ h_B0_idx * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};
    
    auto d_HT0_F = HT0.ref(cuco::find);
    
    auto d_HT0_I = HT0.ref(cuco::insert);
    
    pipeline_2<<<std::ceil((float)region_size/(float)32), 32>>>(d_r_regionkey, d_n_regionkey, d_r_name, d_HT0_I, d_HT0_F, B0_region, region_size, B0_idx);
    
    int32_t* d_n_nationkey;
    
    cudaMalloc(&d_n_nationkey, sizeof(int32_t) * nation_size);
    
    cudaMemcpy(d_n_nationkey, n_nationkey, sizeof(int32_t) * nation_size, cudaMemcpyHostToDevice);
    
    int64_t* B1_region;
    int64_t* B1_nation;
    int64_t* B1_idx;
    cudaMalloc(&B1_idx, sizeof(int64_t));
    cudaMemset(B1_idx, 0, sizeof(int64_t));
    pipeline_5<<<std::ceil((float)nation_size/(float)32), 32>>>(d_c_nationkey, d_n_regionkey, d_n_nationkey, d_HT0_I, d_HT0_F, B0_region, nation_size, B1_idx);
    
    int64_t h_B1_idx;
    cudaMemcpy(&h_B1_idx, B1_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B1_idx, 0, sizeof(int64_t));
    cudaMalloc(&B1_region, sizeof(int64_t) * h_B1_idx);
    cudaMalloc(&B1_nation, sizeof(int64_t) * h_B1_idx);
    auto HT1 = cuco::static_map{ h_B1_idx * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};
    
    auto d_HT1_F = HT1.ref(cuco::find);
    
    auto d_HT1_I = HT1.ref(cuco::insert);
    
    pipeline_4<<<std::ceil((float)nation_size/(float)32), 32>>>(d_c_nationkey, d_n_regionkey, d_n_nationkey, d_HT0_I, d_HT0_F, d_HT1_I, d_HT1_F, B0_region, B1_region, B1_nation, nation_size, B1_idx);
    
    int32_t* d_c_custkey;
    
    cudaMalloc(&d_c_custkey, sizeof(int32_t) * customer_size);
    
    cudaMemcpy(d_c_custkey, c_custkey, sizeof(int32_t) * customer_size, cudaMemcpyHostToDevice);
    
    int32_t* d_o_custkey;
    
    cudaMalloc(&d_o_custkey, sizeof(int32_t) * orders_size);
    
    cudaMemcpy(d_o_custkey, o_custkey, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);
    
    int64_t* B2_region;
    int64_t* B2_customer;
    int64_t* B2_nation;
    int64_t* B2_idx;
    cudaMalloc(&B2_idx, sizeof(int64_t));
    cudaMemset(B2_idx, 0, sizeof(int64_t));
    pipeline_7<<<std::ceil((float)customer_size/(float)32), 32>>>(d_c_custkey, d_c_nationkey, d_o_custkey, d_HT1_I, d_HT1_F, customer_size, B1_region, B1_nation, B2_idx);
    
    int64_t h_B2_idx;
    cudaMemcpy(&h_B2_idx, B2_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B2_idx, 0, sizeof(int64_t));
    cudaMalloc(&B2_region, sizeof(int64_t) * h_B2_idx);
    cudaMalloc(&B2_customer, sizeof(int64_t) * h_B2_idx);
    cudaMalloc(&B2_nation, sizeof(int64_t) * h_B2_idx);
    auto HT2 = cuco::static_map{ h_B2_idx * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};
    
    auto d_HT2_F = HT2.ref(cuco::find);
    
    auto d_HT2_I = HT2.ref(cuco::insert);
    
    pipeline_6<<<std::ceil((float)customer_size/(float)32), 32>>>(d_c_custkey, d_c_nationkey, d_o_custkey, d_HT1_I, d_HT1_F, d_HT2_I, d_HT2_F, B1_region, B2_nation, customer_size, B1_nation, B2_region, B2_customer, B2_idx);
    
    int32_t* d_o_orderdate;
    
    cudaMalloc(&d_o_orderdate, sizeof(int32_t) * orders_size);
    
    cudaMemcpy(d_o_orderdate, o_orderdate, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);
    
    int32_t* d_l_orderkey;
    
    cudaMalloc(&d_l_orderkey, sizeof(int32_t) * lineitem_size);
    
    cudaMemcpy(d_l_orderkey, l_orderkey, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);
    
    int32_t* d_o_orderkey;
    
    cudaMalloc(&d_o_orderkey, sizeof(int32_t) * orders_size);
    
    cudaMemcpy(d_o_orderkey, o_orderkey, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);
    
    int64_t* B3_region;
    int64_t* B3_nation;
    int64_t* B3_customer;
    int64_t* B3_orders;
    int64_t* B3_idx;
    cudaMalloc(&B3_idx, sizeof(int64_t));
    cudaMemset(B3_idx, 0, sizeof(int64_t));
    pipeline_9<<<std::ceil((float)orders_size/(float)32), 32>>>(d_o_orderdate, d_o_custkey, d_l_orderkey, d_o_orderkey, d_HT2_I, d_HT2_F, B3_idx, B2_nation, B2_customer, orders_size, B2_region);
    
    int64_t h_B3_idx;
    cudaMemcpy(&h_B3_idx, B3_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B3_idx, 0, sizeof(int64_t));
    cudaMalloc(&B3_orders, sizeof(int64_t) * h_B3_idx);
    cudaMalloc(&B3_region, sizeof(int64_t) * h_B3_idx);
    cudaMalloc(&B3_customer, sizeof(int64_t) * h_B3_idx);
    cudaMalloc(&B3_nation, sizeof(int64_t) * h_B3_idx);
    auto HT3 = cuco::static_map{ h_B3_idx * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};
    
    auto d_HT3_F = HT3.ref(cuco::find);
    
    auto d_HT3_I = HT3.ref(cuco::insert);
    
    pipeline_8<<<std::ceil((float)orders_size/(float)32), 32>>>(d_o_orderdate, d_o_custkey, d_l_orderkey, d_o_orderkey, d_HT2_I, d_HT2_F, d_HT3_I, d_HT3_F, B3_idx, B2_nation, B2_customer, B2_region, orders_size, B3_orders, B3_nation, B3_customer, B3_region);
    
    double* d_l_extendedprice;
    
    cudaMalloc(&d_l_extendedprice, sizeof(double) * lineitem_size);
    
    cudaMemcpy(d_l_extendedprice, l_extendedprice, sizeof(double) * lineitem_size, cudaMemcpyHostToDevice);
    
    double* d_l_discount;
    
    cudaMalloc(&d_l_discount, sizeof(double) * lineitem_size);
    
    cudaMemcpy(d_l_discount, l_discount, sizeof(double) * lineitem_size, cudaMemcpyHostToDevice);
    
    int8_t* d_n_name;
    
    cudaMalloc(&d_n_name, sizeof(int8_t) * nation_size);
    
    cudaMemcpy(d_n_name, n_name, sizeof(int8_t) * nation_size, cudaMemcpyHostToDevice);
    
    int8_t* d_agg_n_name;
    
    double* d_agg_revenue;
    
    auto HT5 = cuco::static_map{ lineitem_size * 2,cuco::empty_key{(int64_t)-1},cuco::empty_value{(int64_t)-1},thrust::equal_to<int64_t>{},cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};
    
    auto d_HT5_F = HT5.ref(cuco::find);
    
    auto d_HT5_I = HT5.ref(cuco::insert);
    
    pipeline_10<<<std::ceil((float)lineitem_size/(float)32), 32>>>(d_l_suppkey, d_l_orderkey, d_l_discount, d_n_name, d_c_nationkey, d_l_extendedprice, d_HT3_I, d_HT3_F, d_HT4_I, d_HT4_F, d_HT5_I, d_HT5_F, lineitem_size, B4_supplier, B3_orders, B3_nation, B3_customer, B3_region);
    
    auto HT5_size = HT5.size();
    
    cudaMalloc(&d_agg_n_name, sizeof(int8_t) * HT5_size);
    
    cudaMalloc(&d_agg_revenue, sizeof(double) * HT5_size);
    
    cudaMemset(d_agg_n_name, 0, sizeof(int8_t) * HT5_size);
    
    cudaMemset(d_agg_revenue, 0, sizeof(double) * HT5_size);
    
    thrust::device_vector<int64_t> keys_5(HT5_size), vals_5(HT5_size);
    HT5.retrieve_all(keys_5.begin(), vals_5.begin());
    thrust::host_vector<int64_t> h_keys_5(HT5_size);
    thrust::copy(keys_5.begin(), keys_5.end(), h_keys_5.begin());
    thrust::host_vector<cuco::pair<int64_t, int64_t>> actual_dict_5(HT5_size);
    for (int i=0; i < HT5_size; i++) {
    actual_dict_5[i] = cuco::make_pair(h_keys_5[i], i);
    }
    HT5.clear();
    HT5.insert(actual_dict_5.begin(), actual_dict_5.end());
    pipeline_11<<<std::ceil((float)lineitem_size/(float)32), 32>>>(d_l_suppkey, d_l_extendedprice, d_l_orderkey, d_l_discount, d_c_nationkey, d_n_name, d_agg_n_name, d_agg_revenue, d_HT3_I, d_HT3_F, d_HT4_I, d_HT4_F, d_HT5_I, d_HT5_F, B4_supplier, lineitem_size, B3_orders, B3_nation, B3_customer, B3_region);
    
    size_t agg_size = HT5_size;
    int8_t* p_agg_n_name = (int8_t*)malloc(sizeof(int8_t) * agg_size);
    cudaMemcpy(p_agg_n_name, d_agg_n_name, sizeof(int8_t) * agg_size, cudaMemcpyDeviceToHost);
    double* p_agg_revenue = (double*)malloc(sizeof(double) * agg_size);
    cudaMemcpy(p_agg_revenue, d_agg_revenue, sizeof(double) * agg_size, cudaMemcpyDeviceToHost);
    for (int i=0; i<agg_size; i++) {
    std::cout << (int)p_agg_n_name[i] << "\t";
    std::cout << p_agg_revenue[i] << "\t";
    std::cout << std::endl;
    }
    }
    int main(int argc, const char **argv) {
    std::string dbDir = getDataDir(argv, argc);
    std::string customer_file = dbDir + "customer.parquet";
    auto customer_table = getArrowTable(customer_file);
    size_t customer_size = customer_table->num_rows();
    std::string lineitem_file = dbDir + "lineitem.parquet";
    auto lineitem_table = getArrowTable(lineitem_file);
    size_t lineitem_size = lineitem_table->num_rows();
    std::string nation_file = dbDir + "nation.parquet";
    auto nation_table = getArrowTable(nation_file);
    size_t nation_size = nation_table->num_rows();
    std::string orders_file = dbDir + "orders.parquet";
    auto orders_table = getArrowTable(orders_file);
    size_t orders_size = orders_table->num_rows();
    std::string region_file = dbDir + "region.parquet";
    auto region_table = getArrowTable(region_file);
    size_t region_size = region_table->num_rows();
    std::string supplier_file = dbDir + "supplier.parquet";
    auto supplier_table = getArrowTable(supplier_file);
    size_t supplier_size = supplier_table->num_rows();
    auto c_custkey = read_column_typecasted<int32_t>(customer_table, "c_custkey");
    auto c_nationkey = read_column_typecasted<int32_t>(customer_table, "c_nationkey");
    auto l_discount = read_column<double>(lineitem_table, "l_discount");
    auto l_extendedprice = read_column<double>(lineitem_table, "l_extendedprice");
    auto l_orderkey = read_column_typecasted<int32_t>(lineitem_table, "l_orderkey");
    auto l_suppkey = read_column_typecasted<int32_t>(lineitem_table, "l_suppkey");
    StringDictEncodedColumn *n_name = read_string_dict_encoded_column(nation_table, "n_name");
    auto n_nationkey = read_column_typecasted<int32_t>(nation_table, "n_nationkey");
    auto n_regionkey = read_column_typecasted<int32_t>(nation_table, "n_regionkey");
    auto o_custkey = read_column_typecasted<int32_t>(orders_table, "o_custkey");
    auto o_orderdate = read_column<int32_t>(orders_table, "o_orderdate");
    auto o_orderkey = read_column_typecasted<int32_t>(orders_table, "o_orderkey");
    StringDictEncodedColumn *r_name = read_string_dict_encoded_column(region_table, "r_name");
    auto r_regionkey = read_column_typecasted<int32_t>(region_table, "r_regionkey");
    auto s_nationkey = read_column_typecasted<int32_t>(supplier_table, "s_nationkey");
    auto s_suppkey = read_column_typecasted<int32_t>(supplier_table, "s_suppkey");
    control(c_custkey.data(),c_nationkey.data(),l_discount.data(),l_extendedprice.data(),l_orderkey.data(),l_suppkey.data(),n_name->column,n_nationkey.data(),n_regionkey.data(),o_custkey.data(),o_orderdate.data(),o_orderkey.data(),r_name->column,r_regionkey.data(),s_nationkey.data(),s_suppkey.data(),customer_size,lineitem_size,nation_size,orders_size,region_size,supplier_size);
    }
        