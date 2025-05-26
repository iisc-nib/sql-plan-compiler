import os
from helper.ncu_report_helper import get_top_kernels, load_report, get_kernel_divergence, get_kernel_occupancy, get_kernel_time, get_compute_throughput
import sys

attributes_list = ["gpu_time", "compute_throughput", "occupancy", "warp_divergence"]

class kernel_attributes:
    def __init__(self, kernel_name:str):
        self.kernel_name = kernel_name
        self.attributes = {}

class report_stats:
    def __init__(self, report_file_path):
        self.report_file_path = report_file_path
        self.kernels = []

    def add_kernel(self, kernel: kernel_attributes):
        self.kernels.append(kernel)

    def add_stats(self, kernel_name: str, attribute: str, value: float):
        for kernel in self.kernels:
            if kernel.kernel_name == kernel_name:
                kernel.attributes[attribute] = value
                return
        new_kernel = kernel_attributes(kernel_name)
        new_kernel.attributes[attribute] = value
        self.kernels.append(new_kernel)

report_stats_list = []

def parse_report(report_file_path, attributes_list, kernel_names=None):
    report = load_report(report_file_path)
    report_actions = report.range_by_idx(0)
    kernels = []
    if kernel_names is None:
        kernels = get_top_kernels(report, 0.90)
    else:
        kernels = [i for i in range(report_actions.num_actions()) if report_actions.action_by_idx(i).name() in kernel_names]

    report_printable_name = os.path.basename(report_file_path).replace(".ncu-rep", "")
    values = []
    for kernel_idx in kernels:
        kernel = report.range_by_idx(0).action_by_idx(kernel_idx)
        for attribute in attributes_list:
            if attribute == "occupancy":
                value = get_kernel_occupancy(kernel)
            elif attribute == "warp_divergence":
                value = get_kernel_divergence(kernel)
            elif attribute == "gpu_time":
                value = get_kernel_time(kernel)
            elif attribute == "compute_throughput":
                value = get_compute_throughput(kernel)
            else:
                raise ValueError(f"Unknown attribute: {attribute}")

            values.append(value)

        print(f"{(report_printable_name)}", end=", ")
        for value in values:
            print(f"{value}", end=", " if value != values[-1] else "\n")

def print_header(attributes_list):
    print("variation,", end="")
    for attribute in attributes_list:
        print(f"{attribute}", end=", " if attribute != attributes_list[-1] else "\n")

def compare_reports_directory(report_dir):
    if not os.path.exists(report_dir):
        print(f"-- Report directory {report_dir} does not exist. --")
        return

    print_header(attributes_list)

    for report_file in os.listdir(report_dir):
        if report_file.endswith(".ncu-rep"):
            full_report_path = os.path.join(report_dir, report_file)
            parse_report(full_report_path, attributes_list=attributes_list, kernel_names=["main_7"])

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python compare-reports.py <report-file1> <report-file2> ... <report-fileN> or \n python compare-reports.py <directory>")
        sys.exit(1)

    if (os.path.isdir(sys.argv[1])):
        compare_reports_directory(sys.argv[1])
    else:
        raise ValueError("Please provide a directory containing .ncu-rep files or a single report file.")
    





