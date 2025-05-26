import sys
from os.path import dirname as parent
import math
import os

sys.path.append("/opt/nvidia/nsight-compute/2023.2.0/extras/python")
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

def print_divergence_top_kernels(report):
    top_kernels = get_top_kernels(report, 0.90)
    for kernel_idx in top_kernels:
        kernel = report.range_by_idx(0).action_by_idx(kernel_idx)
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
    
