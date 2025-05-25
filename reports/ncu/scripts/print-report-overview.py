import os
from helper.ncu_report_helper import print_report
import sys

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python print-report-overview.py <report-file>")
        sys.exit(1)

    if (os.path.isdir(sys.argv[1])):
        for report_file in os.listdir(sys.argv[1]):
            if report_file.endswith(".ncu-rep"):
                report_file = os.path.join(sys.argv[1], report_file)
                print_report(report_file)
    else:
        report_file = sys.argv[1]
        print_report(report_file)

    





