import sys
from os.path import dirname as parent
import math
import os
import numpy as np
import matplotlib.pyplot as plt

sys.path.append("/opt/nvidia/nsight-compute/2025.1.1/extras/python")
import ncu_report

def print_metrics(kernel):
    print(f"Kernel: {kernel.name()}")
    print(f"  Kernel metrics:", {kernel.metric_names()})

def get_top_kernels(report, percentile=0.9):
    """
    Get the top kernels from the report that contribute to the given percentile of total time.
    """
    top_kernels = {}
    total_time = 0.0
    
    assert(report.num_ranges() == 1)
    my_range = report.range_by_idx(0)
    for j in range(my_range.num_actions()):
        kernel = my_range.action_by_idx(j)
        kernel_time = kernel.metric_by_name("gpu__time_duration.sum").as_double()
        top_kernels[j] = kernel_time
        total_time += kernel_time

    # Sort kernels by their execution time in descending order
    sorted_kernels = sorted(top_kernels.items(), key=lambda item: item[1], reverse=True)

    cumulative_time = 0.0
    top_percentile_kernels = []
    for kernel_idx, kernel_time in sorted_kernels:
        cumulative_time += kernel_time
        kernel_name = my_range.action_by_idx(kernel_idx).name()
        top_percentile_kernels.append(kernel_idx)
        # print(f"Kernel: {kernel_name} took {kernel_time/1000.0} ms")
        if cumulative_time / total_time >= percentile:
            break

    return top_percentile_kernels

def get_kernel_divergence(kernel):
    warp_divergence = kernel.metric_by_name("smsp__thread_inst_executed_per_inst_executed.ratio").as_double()
    return round(warp_divergence, 2)

def get_kernel_occupancy(kernel):
    occupancy = kernel.metric_by_name("sm__warps_active.avg.pct_of_peak_sustained_active").as_double()
    return round(occupancy, 2)

def get_kernel_memory_bandwidth(kernel):
    memory_bandwidth = kernel.metric_by_name("dram__bytes.sum").as_double() / 1000.0  # Convert to KB
    return round(memory_bandwidth, 2)

def get_kernel_time(kernel):
    kernel_time = kernel.metric_by_name("gpu__time_duration.sum").as_double() / 1000.0  # Convert to ms
    return round(kernel_time, 2)

def get_compute_throughput(kernel):
    compute_throughput = kernel.metric_by_name("sm__throughput.avg.pct_of_peak_sustained_elapsed").as_double() / 1000.0  # Convert to K
    return round(compute_throughput, 2)

def build_divergence_stats(report, kernel_idx):
    kernel = report.range_by_idx(0).action_by_idx(kernel_idx)
    # for each instruction in the kernel, get the two metrics (derived__avg_thread_executed_true and inst_executed)
    # build a histogram of the avg_thread_executed_true (raning from 0 to 32) and the sum of inst_executed
    
    source_files = kernel.source_files()
    instrs_executed = kernel.metric_by_name("inst_executed")
    total_instr_executed = instrs_executed.as_double()
    pcs = instrs_executed.correlation_ids()
    pred_thread_metric = kernel.metric_by_name("derived__avg_thread_executed_true")    
    pred_inst_metric = kernel.metric_by_name("thread_inst_executed_true")

    thread_buckets = np.zeros(33, dtype=np.double)  # Buckets for 0 to 32 threads

    for cid in range(0, pcs.num_instances()):
        pc = pcs.as_uint64(cid)
        sass = kernel.sass_by_pc(pc)
        instr_avg_pred_threads = pred_thread_metric.as_double(cid)
        instr_pred_executed_count = pred_inst_metric.as_double(cid)
        instr_executed_count = instrs_executed.as_double(cid)
        assert(instr_avg_pred_threads >= 0 and instr_avg_pred_threads <= 32)
        if instr_executed_count > 0:
            thread_buckets[int(instr_avg_pred_threads)] += instr_executed_count/total_instr_executed
    
    # plot the histogram
    plt.figure(figsize=(10, 6))
    plt.bar(range(33), thread_buckets, color='blue', alpha=0.7)
    plt.xlabel('Number of Threads Executed')
    plt.ylabel('Percentage of Instructions Executed')
    plt.title(f'Kernel: {kernel.name()} - Warp Divergence Histogram')
    plt.xticks(range(33))
    plt.grid(axis='y', linestyle='--', alpha=0.7)
    plt.tight_layout()
    plt.savefig(f"{kernel.name()}_warp_divergence_histogram.png")
    plt.close()



        

def print_divergence_top_kernels(report):    
    top_kernels = get_top_kernels(report, 0.90)
    print(f"kernel name, kernel gpu time (ms), warp_divergence")
    for kernel_idx in top_kernels:
        kernel = report.range_by_idx(0).action_by_idx(kernel_idx)
        build_divergence_stats(report, kernel_idx)        
        warp_divergence = get_kernel_divergence(kernel)
        kernel_gpu_time = kernel.metric_by_name("gpu__time_duration.sum").as_double()/1000.0
        print(f"{kernel.name()}, {kernel_gpu_time} ms, {warp_divergence}")

def load_report(report_file):
    """
    Load the report from the given file.
    """
    if not os.path.exists(report_file):
        raise FileNotFoundError(f"Report file {report_file} does not exist.")
    
    report = ncu_report.load_report(report_file)
    return report

def print_report(report_file):

    if not os.path.exists(report_file):
        print(f"-- Report file {report_file} does not exist. --") 
    # Load the report
    report = ncu_report.load_report(report_file)
    print(f"-- Loaded report: {report_file} --")

    # print the top divergence
    print_divergence_top_kernels(report)
    print(f"-- Finished printing report: {report_file} --")
    
