import sys
from os.path import dirname as parent
import math
import os
import numpy as np
import matplotlib.pyplot as plt

sys.path.append("/opt/nvidia/nsight-compute/2025.1.1/extras/python")
import ncu_report

class instruction:
    def __init__(self, pc, instr_avg_pred_threads, instr_pred_executed_count, instr_executed_count):
        self.pc = pc
        self.instr_avg_pred_threads = instr_avg_pred_threads
        self.instr_pred_executed_count = instr_pred_executed_count
        self.instr_executed_count = instr_executed_count
    
class kernel:
    def __init__(self, action: ncu_report.IAction):
        self.action = action
        self.instructions = []
        self.__parse_kernel__()

    def time_in_ms(self):
        return self._time_in_ms

    def __parse_kernel__(self):
        self._time_in_ms = self.action.metric_by_name("gpu__time_duration.sum").as_double() / 1000.0
        self.total_instr_count = self.action.metric_by_name("inst_executed").as_double()
        self.__parse_instructions__()

    def __parse_instructions__(self):
            
        # for each instruction in the kernel, get the two metrics (derived__avg_thread_executed_true and inst_executed)
        # build a histogram of the avg_thread_executed_true (raning from 0 to 32) and the sum of inst_executed
        self.instructions = []
        source_files = self.action.source_files()
        self.inst_executed_metric = self.action.metric_by_name("inst_executed")
        total_instr_executed = self.inst_executed_metric.as_double()

        # metrics
        pred_avg_thread_executed_metric = self.action.metric_by_name("derived__avg_thread_executed_true")
        pred_inst_executed_metric = self.action.metric_by_name("thread_inst_executed_true")

        pcs = self.inst_executed_metric.correlation_ids() # get all the instructions in the kernel
        for cid in range(0, pcs.num_instances()):
            pc = pcs.as_uint64(cid)
            sass = self.action.sass_by_pc(pc)
            instr_avg_pred_threads = pred_avg_thread_executed_metric.as_double(cid) # average predicated threads
            instr_pred_executed_count = pred_inst_executed_metric.as_double(cid) 
            instr_executed_count = self.inst_executed_metric.as_double(cid)
            assert(instr_avg_pred_threads >= 0 and instr_avg_pred_threads <= 32)
            self.instructions.append(instruction(pc, instr_avg_pred_threads, instr_pred_executed_count, instr_executed_count))

    def get_mean_divergence_from_kernel_metric(self):
        warp_divergence = self.action.metric_by_name("smsp__thread_inst_executed_per_inst_executed.ratio").as_double()
        return round(warp_divergence, 2)
    
    def get_mean_divergence_from_instructions(self):
        # get the mean divergence from the instructions
        total_divergence = 0.0
        for instr in self.instructions:
            if instr.instr_executed_count > 0:
                total_divergence += (instr.instr_avg_pred_threads * instr.instr_executed_count) / self.total_instr_count
        return round(total_divergence, 2)
    
    def get_weighted_divergence(self):
        # get the weighted divergence per thread
        self.inst_executed_metric = self.action.metric_by_name("inst_executed")

        total_weighted_divergence = 0.0
        for instr in self.instructions:
            total_weighted_divergence += (instr.instr_avg_pred_threads * instr.instr_executed_count) / self.total_instr_count
        return round(total_weighted_divergence, 2)

    def get_kernel_occupancy(self):
        occupancy = self.action.metric_by_name("sm__warps_active.avg.pct_of_peak_sustained_active").as_double()
        return round(occupancy, 2)

    def print_metrics(self):
        print(f"Kernel: {self.name()}")
        print(f"  Kernel metrics:", {self.metric_names()})

    def get_memory_bandwidth(self):
        memory_bandwidth = self.action.metric_by_name("dram__bytes.sum").as_double()  # Convert to KB
        return round(memory_bandwidth, 2)

    def get_compute_throughput(self):
        compute_throughput = self.action.metric_by_name("sm__throughput.avg.pct_of_peak_sustained_elapsed").as_double()
        return round(compute_throughput, 2)
    
    def print_divergence_histogram(self):
        thread_buckets = np.zeros(33, dtype=np.double)  # Buckets for 0 to 32 threads

        for instr in self.instructions:
            thread_buckets[int(instr.instr_avg_pred_threads)] += instr.instr_executed_count

        # Normalize the histogram to get percentages
        thread_buckets = (thread_buckets / self.total_instr_count) * 100.0  # Convert to percentage

        # Calculate the expected value (weighted average)
        expected_value = 0
        for i in range(33):
            expected_value += i * thread_buckets[i] / 100.0  # Divide by 100 because values are percentages
        expected_value = round(expected_value, 2)

        # plot the histogram
        plt.figure(figsize=(10, 6))
        plt.bar(range(33), thread_buckets, color='#3498db', alpha=0.7)
        plt.xlabel('Number of Threads Executed')
        plt.ylabel('Percentage of Instructions Executed')
        plt.title(f'Kernel: {self.action.name()} - Warp Divergence Histogram')
        plt.axvline(expected_value, color='red', linestyle='dashed', linewidth=1, label=f'Expected Value: {expected_value}')
        plt.legend()  # Add this to display the legend with the expected value label
        plt.xticks(range(33))
        plt.grid(axis='y', linestyle='--', alpha=0.7)
        plt.tight_layout()
        plt.close()

class ncu_report_wrapper:
    @staticmethod
    def load_report(report_path):
        if not os.path.exists(report_path):
            raise FileNotFoundError(f"Report file {report_path} does not exist.")
        
        report = ncu_report.load_report(report_path)
        return ncu_report_wrapper(report, report_path)
    
    def __init__(self, report, report_path):
        self.report = report
        self.report_path = report_path
        self.name = os.path.basename(report_path)
        self.kernels = []
        self.__parse_report__()

    def __parse_report__(self):
        assert(self.report.num_ranges() == 1)
        my_range = self.report.range_by_idx(0)
        for j in range(my_range.num_actions()): # for all kernels
            self.kernels.append(kernel(my_range.action_by_idx(j)))
        self.total_time = np.sum([k.time_in_ms() for k in self.kernels])

    def __get_weighted_metric__(self, metric_func_ptr):
        if (len(self.kernels) == 0):
            return 0.0
        total_weighted_metric = 0.0
        for k in self.kernels:
            total_weighted_metric += (metric_func_ptr(k) * k.time_in_ms()) / self.total_time
        return round(total_weighted_metric, 2)
    
    def __get_mean_metric__(self, metric_func_ptr):
        if len(self.kernels) == 0:
            return 0.0
        total_metric = 0.0
        for k in self.kernels:
            total_metric += metric_func_ptr(k)
        total_metric /= len(self.kernels)
        return round(total_metric, 2)

    def get_weighted_branch_divergence(self):
        return self.__get_weighted_metric__(lambda k: k.get_mean_divergence())

    def get_mean_branch_divergence(self):
        return self.__get_mean_metric__(lambda k: k.get_mean_divergence())
    
    def get_mean_computed_throughput(self):
        return self.__get_mean_metric__(lambda k: k.get_compute_throughput())

    def get_weighted_compute_throughput(self):
        return self.__get_weighted_metric__(lambda k: k.get_compute_throughput())
    
    def print_inst_level_weighted_divergence(self):
        print(f"Kernel Name, Weighted Branch Divergence, Mean Branch Divergence From Metric, Mean Divergence From Instructions")
        for k in self.kernels:
            print(f"{k.action.name()}, {k.get_weighted_divergence()}, {k.get_mean_divergence_from_kernel_metric()}, {k.get_mean_divergence_from_instructions()}")

    def __print_weighted_kernel_histogram__(self, pdf_ref):
        thread_buckets = np.zeros(33, dtype=np.double)  # Buckets for 0 to 32 threads
        for k in self.kernels:
            weight = k.time_in_ms() / self.total_time
            for instr in k.instructions:
                thread_buckets[int(instr.instr_avg_pred_threads)] += (instr.instr_executed_count * weight)/ k.total_instr_count
            
        # Normalize the histogram to get percentages
        thread_buckets = thread_buckets * 100.0  # Convert to percentage

        plt.figure(figsize=(10, 6))
        plt.bar(range(33), thread_buckets, color="#76CC1E", alpha=0.7)
        plt.xlabel('Number of Threads Executed')
        plt.ylabel('Percentage of Instructions Executed')
        plt.title(f'Weighted Warp Divergence Histogram for Report (All Kernels): {self.name}')
        plt.xticks(range(33))
        plt.grid(axis='y', linestyle='--', alpha=0.7)
        plt.tight_layout()
        plt.close()

        if pdf_ref:
            plt.savefig(pdf_ref, format='pdf', bbox_inches='tight', pad_inches=10/72.0)

    def print_histogram(self, top_k=1, pdf_ref=None):
       
        # get the kernel with the highest gpu time and name has 'main'
        top_kernels = sorted(self.kernels, key=lambda k: k.time_in_ms(), reverse=True)[:top_k]

        # add a page to the pdf with the printed kernel
        if pdf_ref:
            for k in top_kernels:
                k.print_divergence_histogram()
                plt.suptitle(f"Report: {self.name}", fontsize=10, x=0.0, ha='left')
                # Add margins of 10 pixels
                plt.tight_layout(pad=0.4)
                plt.savefig(pdf_ref, format='pdf', bbox_inches='tight', pad_inches=10/72.0)  # 10 pixels converted to inches (72 DPI)
                plt.close()

            self.__print_weighted_kernel_histogram__(pdf_ref)
       

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
    


def print_divergence_top_kernels(report):    
    top_kernels = get_top_kernels(report, 0.90)
    print(f"kernel name, kernel gpu time (ms), warp_divergence")
    for kernel_idx in top_kernels:
        kernel = report.range_by_idx(0).action_by_idx(kernel_idx)
        build_divergence_stats(report, kernel_idx)        
        warp_divergence = get_kernel_divergence(kernel)
        kernel_gpu_time = kernel.metric_by_name("gpu__time_duration.sum").as_double()/1000.0
        print(f"{kernel.name()}, {kernel_gpu_time} ms, {warp_divergence}")


    
    
