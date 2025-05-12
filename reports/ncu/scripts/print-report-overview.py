import os
import sys
from os.path import dirname as parent
import math

sys.path.append("/opt/nvidia/nsight-compute/2023.2.0/extras/python")
import ncu_report

def print_metrics(kernel):
    print(f"Kernel: {kernel.name()}")
    print(f"  Kernel metrics:", {kernel.metric_names()})

report_folder = parent(parent(parent(__file__)))
print(f"Report folder: {report_folder}")

first_report = ncu_report.load_report(
    os.path.join(report_folder, "ncu", "4060", "ssb-1", "q11-ssb.ncu-rep"))

num_ranges = first_report.num_ranges()
print(f"Number of ranges: {num_ranges}")

my_range = first_report.range_by_idx(0)
print(f"Range name: {my_range.num_actions()}")

first_kernel = my_range.action_by_idx(0)
print_metrics(first_kernel)

# # action is a kernel
# for i in range(my_range.num_actions()):
#     kernel = my_range.action_by_idx(i)
#     warp_divergence = round(kernel.metric_by_name(f"smsp__thread_inst_executed_per_inst_executed.ratio").as_double(), 2)
#     print(f"Kernel: {kernel.name()} took {warp_divergence} ms")


    # get the time taken by the action




