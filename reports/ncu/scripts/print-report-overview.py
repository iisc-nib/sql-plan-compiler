import os
from helper.ncu_report_helper import ncu_report_wrapper
import sys
from matplotlib.backends.backend_pdf import PdfPages

def print_report(report_file):

    if not os.path.exists(report_file):
        print(f"-- Report file {report_file} does not exist. --") 
    # Load the report
    report = ncu_report_wrapper.load_report(report_file)
    if report is None:
        print(f"-- Failed to load report {report_file}. --")
        return
    print(f"Weighted Branch Divergence: {report.get_weighted_branch_divergence()}")
    print(f"Mean Branch Divergence: {report.get_mean_branch_divergence()}")
    print(f"Weighted Computed Throughput: {report.get_weighted_compute_throughput()}")
    print(f"Mean Computed Throughput: {report.get_mean_computed_throughput()}")
    print(f"Total Time: {report.total_time} ms")
    print(f"Report Name: {report.name}")

def generate_histogram_dir(report_dir):
    if not os.path.exists(report_dir):
        print(f"-- Report directory {report_dir} does not exist. --")
        return
            
    pdf_path = os.path.join(report_dir, "thread_divergence_report.pdf")
    pdf_ref = PdfPages(pdf_path)

    for report_file in sorted(os.listdir(report_dir)):
        if report_file.endswith(".ncu-rep"):
            report_file_path = os.path.join(report_dir, report_file)
            report = ncu_report_wrapper.load_report(report_file_path)
            if report is None:
                print(f"-- Failed to load report {report_file_path}. --")
                continue
            print(f"Report Name: {report.name}")
            report.print_histogram(1, pdf_ref)

    pdf_ref.close()

def get_basic_stats(report_dir):
    if not os.path.exists(report_dir):
        print(f"-- Report directory {report_dir} does not exist. --")
        return
    
    print(f"report_name, compute_throughput (weighted metric mean), memory_throughput (weighted metric mean)")

    for report_file in sorted(os.listdir(report_dir)):
        if report_file.endswith(".ncu-rep"):
            report_file_path = os.path.join(report_dir, report_file)
            report = ncu_report_wrapper.load_report(report_file_path)
            if report is None:
                print(f"-- Failed to load report {report_file_path}. --")
                continue

            print(f"{report.name}, {report.get_weighted_compute_throughput()}, {report.get_weighted_memory_throughput()}")
            
            
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python print-report-overview.py <report-file>")
        sys.exit(1)

    if (os.path.isdir(sys.argv[1])):
        report_dir = sys.argv[1]
        get_basic_stats(report_dir)
    else:
        report_file = sys.argv[1]
        print_report(report_file)

    





