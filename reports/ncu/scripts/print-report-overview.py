import os
import sys
from os.path import dirname as parent
import math

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
        print(f"Kernel: {kernel_name} took {kernel_time/1000.0} ms")
        if cumulative_time / total_time >= percentile:
            break

    return top_percentile_kernels

def print_divergence_top_kernels(report):
    top_kernels = get_top_kernels(report, 0.90)
    for kernel_idx in top_kernels:
        kernel = report.range_by_idx(0).action_by_idx(kernel_idx)
        warp_divergence = round(kernel.metric_by_name("smsp__thread_inst_executed_per_inst_executed.ratio").as_double(), 2)
        print(f"Kernel: {kernel.name()} has {warp_divergence} avg. active threads per warp")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python print-report-overview.py <report-file>")
        sys.exit(1)

    report_file = sys.argv[1]
    if not os.path.exists(report_file):
        print(f"Report file {report_file} does not exist.")
        sys.exit(1)

    # Load the report
    report = ncu_report.load_report(report_file)
    print(f"Loaded report: {report_file}")

    # print the top divergence
    print_divergence_top_kernels(report)





