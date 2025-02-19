#include "utils.h"

#include <cuco/static_map.cuh>

#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
namespace cg = cooperative_groups;

__global__ void pipeline_1(int32_t *o_orderdate, int32_t *o_orderkey, int32_t *l_orderkey, size_t orders_size, int64_t *B0_idx)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= orders_size)
        return;
    int32_t reg_o_orderdate = o_orderdate[tid];
    if (!(reg_o_orderdate >= 8582))
        return;
    if (!(reg_o_orderdate < 8674))
        return;
    int32_t reg_o_orderkey = o_orderkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_o_orderkey) << 0);
    atomicAdd((int *)B0_idx, 1);
}

template <typename TY_HT0_I, typename TY_HT0_F>
__global__ void pipeline_0(int32_t *o_orderdate, int32_t *o_orderkey, int32_t *l_orderkey, TY_HT0_I HT0_I, TY_HT0_F HT0_F, int64_t *B0_orders, size_t orders_size, int64_t *B0_idx)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= orders_size)
        return;
    int32_t reg_o_orderdate = o_orderdate[tid];
    if (!(reg_o_orderdate >= 8582))
        return;
    if (!(reg_o_orderdate < 8674))
        return;
    int32_t reg_o_orderkey = o_orderkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_o_orderkey) << 0);
    auto reg_B0_idx = atomicAdd((int *)B0_idx, 1);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT0_I.insert(thread, cuco::pair{key0, reg_B0_idx});
    B0_orders[reg_B0_idx] = tid;
}

template <typename TY_HT0_I, typename TY_HT0_F, typename TY_HT1_I, typename TY_HT1_F>
__global__ void pipeline_2(int32_t *l_orderkey, int32_t *l_commitdate, int32_t *l_receiptdate, int8_t *o_orderpriority, TY_HT0_I HT0_I, TY_HT0_F HT0_F, TY_HT1_I HT1_I, TY_HT1_F HT1_F, size_t lineitem_size, int64_t *B0_orders)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= lineitem_size)
        return;
    int32_t reg_l_commitdate = l_commitdate[tid];
    if (!(reg_l_commitdate < l_receiptdate[tid]))
        return;
    int32_t reg_l_orderkey = l_orderkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_l_orderkey) << 0);
    auto slot0 = HT0_F.find(key0);
    if (slot0 == HT0_F.end())
        return;
    int8_t reg_o_orderpriority = o_orderpriority[B0_orders[slot0->second]];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_o_orderpriority) << 0);
    auto thread = cg::tiled_partition<1>(cg::this_thread_block());
    HT1_I.insert(thread, cuco::pair{key1, 1});
}

template <typename TY_HT0_I, typename TY_HT0_F, typename TY_HT1_I, typename TY_HT1_F>
__global__ void pipeline_3(int32_t *l_orderkey, int32_t *l_commitdate, int32_t *l_receiptdate, int8_t *o_orderpriority, int8_t *agg_op, int64_t *agg_count, TY_HT0_I HT0_I, TY_HT0_F HT0_F, TY_HT1_I HT1_I, TY_HT1_F HT1_F, size_t lineitem_size, int64_t *B0_orders)
{
    int64_t tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= lineitem_size)
        return;
    int32_t reg_l_commitdate = l_commitdate[tid];
    if (!(reg_l_commitdate < l_receiptdate[tid]))
        return;
    int32_t reg_l_orderkey = l_orderkey[tid];
    int64_t key0 = 0;
    key0 |= (((int64_t)reg_l_orderkey) << 0);
    auto slot0 = HT0_F.find(key0);
    if (slot0 == HT0_F.end())
        return;
    int8_t reg_o_orderpriority = o_orderpriority[B0_orders[slot0->second]];
    int64_t key1 = 0;
    key1 |= (((int64_t)reg_o_orderpriority) << 0);
    auto slot1 = HT1_F.find(key1);
    agg_op[slot1->second] = reg_o_orderpriority;
    aggregate_sum(&(agg_count[slot1->second]), 1);
}

void control(
    int32_t *l_commitdate,
    int32_t *l_receiptdate,
    int32_t *l_orderkey,
    int32_t *o_orderdate,
    int32_t *o_orderkey,
    int8_t *o_orderpriority,
    size_t lineitem_size,
    size_t orders_size)
{
    int32_t *d_o_orderdate;

    cudaMalloc(&d_o_orderdate, sizeof(int32_t) * orders_size);

    cudaMemcpy(d_o_orderdate, o_orderdate, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);

    int32_t *d_o_orderkey;

    cudaMalloc(&d_o_orderkey, sizeof(int32_t) * orders_size);

    cudaMemcpy(d_o_orderkey, o_orderkey, sizeof(int32_t) * orders_size, cudaMemcpyHostToDevice);

    int32_t *d_l_orderkey;

    cudaMalloc(&d_l_orderkey, sizeof(int32_t) * lineitem_size);

    cudaMemcpy(d_l_orderkey, l_orderkey, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);

    int64_t *B0_orders;
    int64_t *B0_idx;
    cudaMalloc(&B0_idx, sizeof(int64_t));
    cudaMemset(B0_idx, 0, sizeof(int64_t));
    pipeline_1<<<std::ceil((float)orders_size / (float)32), 32>>>(d_o_orderdate, d_o_orderkey, d_l_orderkey, orders_size, B0_idx);

    int64_t h_B0_idx;
    cudaMemcpy(&h_B0_idx, B0_idx, sizeof(int64_t), cudaMemcpyDeviceToHost);
    cudaMemset(B0_idx, 0, sizeof(int64_t));
    cudaMalloc(&B0_orders, sizeof(int64_t) * h_B0_idx);
    auto HT0 = cuco::static_map{h_B0_idx * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT0_F = HT0.ref(cuco::find);

    auto d_HT0_I = HT0.ref(cuco::insert);

    pipeline_0<<<std::ceil((float)orders_size / (float)32), 32>>>(d_o_orderdate, d_o_orderkey, d_l_orderkey, d_HT0_I, d_HT0_F, B0_orders, orders_size, B0_idx);

    int32_t *d_l_commitdate;

    cudaMalloc(&d_l_commitdate, sizeof(int32_t) * lineitem_size);

    cudaMemcpy(d_l_commitdate, l_commitdate, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);

    int32_t *d_l_receiptdate;

    cudaMalloc(&d_l_receiptdate, sizeof(int32_t) * lineitem_size);

    cudaMemcpy(d_l_receiptdate, l_receiptdate, sizeof(int32_t) * lineitem_size, cudaMemcpyHostToDevice);


    int8_t *d_o_orderpriority;

    cudaMalloc(&d_o_orderpriority, sizeof(int8_t) * orders_size);

    cudaMemcpy(d_o_orderpriority, o_orderpriority, sizeof(int8_t) * orders_size, cudaMemcpyHostToDevice);

    int8_t *d_agg_op;

    int64_t *d_agg_count;

    auto HT1 = cuco::static_map{lineitem_size * 2, cuco::empty_key{(int64_t)-1}, cuco::empty_value{(int64_t)-1}, thrust::equal_to<int64_t>{}, cuco::linear_probing<1, cuco::default_hash_function<int64_t>>()};

    auto d_HT1_F = HT1.ref(cuco::find);

    auto d_HT1_I = HT1.ref(cuco::insert);

    pipeline_2<<<std::ceil((float)lineitem_size / (float)32), 32>>>(d_l_orderkey, d_l_commitdate, d_l_receiptdate, d_o_orderpriority, d_HT0_I, d_HT0_F, d_HT1_I, d_HT1_F, lineitem_size, B0_orders);

    auto HT1_size = HT1.size();

    cudaMalloc(&d_agg_op, sizeof(int8_t) * HT1_size);

    cudaMalloc(&d_agg_count, sizeof(int64_t) * HT1_size);

    cudaMemset(d_agg_op, 0, sizeof(int8_t) * HT1_size);

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
    pipeline_3<<<std::ceil((float)lineitem_size / (float)32), 32>>>(d_l_orderkey, d_l_commitdate, d_l_receiptdate, d_o_orderpriority, d_agg_op, d_agg_count, d_HT0_I, d_HT0_F, d_HT1_I, d_HT1_F, lineitem_size, B0_orders);

    size_t agg_size = HT1_size;
    int8_t *p_agg_op = (int8_t *)malloc(sizeof(int8_t) * agg_size);
    cudaMemcpy(p_agg_op, d_agg_op, sizeof(int8_t) * agg_size, cudaMemcpyDeviceToHost);
    int64_t *p_agg_count = (int64_t *)malloc(sizeof(int64_t) * agg_size);
    cudaMemcpy(p_agg_count, d_agg_count, sizeof(int64_t) * agg_size, cudaMemcpyDeviceToHost);
    for (int i = 0; i < agg_size; i++)
    {
        std::cout << (int)p_agg_op[i] << "\t";
        std::cout << p_agg_count[i] << "\t";
        std::cout << std::endl;
    }
}

int main(int argc, const char **argv)
{
    std::string dbDir = getDataDir(argv, argc);
    std::string lineitem_file = dbDir + "lineitem.parquet";
    std::string orders_file = dbDir + "orders.parquet";

    auto lineitem_table = getArrowTable(lineitem_file);
    auto orders_table = getArrowTable(orders_file);
    size_t lineitem_size = lineitem_table->num_rows();
    size_t orders_size = orders_table->num_rows();

    auto l_commitdate = read_column<int32_t>(lineitem_table, "l_commitdate");
    auto l_receiptdate = read_column<int32_t>(lineitem_table, "l_receiptdate");
    auto l_orderkey = read_column_typecasted<int32_t>(lineitem_table, "l_orderkey");

    auto o_orderdate = read_column<int32_t>(orders_table, "o_orderdate");
    auto o_orderkey = read_column_typecasted<int32_t>(orders_table, "o_orderkey");
    StringDictEncodedColumn *o_orderpriority =
        read_string_dict_encoded_column(orders_table, "o_orderpriority");
    control(
        l_commitdate.data(),
        l_receiptdate.data(),
        l_orderkey.data(),
        o_orderdate.data(),
        o_orderkey.data(),
        o_orderpriority->column,
        lineitem_size,
        orders_size);
}