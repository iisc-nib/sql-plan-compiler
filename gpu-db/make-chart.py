import matplotlib.pyplot as plt
import os
import sys
from collections import defaultdict
import plotly.graph_objects as go

import numpy as np


def create_histograms(filepath, bins=10, title="Per operation cycles hist", xlabel="Cyles", ylabel="threads"):
    if not os.path.exists(filepath):
        print(f"Error: File not found at '{filepath}'")
        return

    # Check if the file exists
    if not os.path.exists(filepath):
        print(f"Error: File not found at '{filepath}'")
        return

    profiles = []
    stacks = dict()
    opnames = dict()
    try:
        with open(filepath, 'r') as f:
            for line_num, line in enumerate(f, 1):
                # Attempt to convert the line to a float
                line = line.strip()
                op = line.split(" ")[0]
                print(filepath)
                kernel_name = op.split("_")[0] + op.split("_")[1] 
                if kernel_name not in stacks:
                    stacks[kernel_name] = []
                    opnames[kernel_name] = []
                numbers = []
                for n in line.split(" ")[1:]:
                    numbers.append(float(n))
                    # Create the histogram
                # plt.figure(figsize=(10, 6)) # Set figure size for better readability
                # plt.hist(numbers, bins=bins, edgecolor='black', alpha=0.7) # Create the histogram
                
                # print average and standard deviation
                avg = sum(numbers) / len(numbers)
                std_dev = (sum((x - avg) ** 2 for x in numbers) / len(numbers)) ** 0.5
                print(f"{op}: Average: {avg:.2f}, Standard Deviation: {std_dev:.2f}")
                stacks[kernel_name].append(avg)
                opname = op.split("_")[2]
                if opname == "join":
                    opname = "join_" + op.split("_")[3]
                opnames[kernel_name].append(opname)
                # Add titles and labels
                # plt.title(op)
                # plt.xlabel(xlabel)
                # plt.ylabel(ylabel)
                
                # Add a grid for better readability
                # plt.grid(axis='y', alpha=0.75)

                # plt.show()
                # print(numbers[0])
                # print(numbers[0])
        # Find the maximum stack depth (i.e., max list length)
        data = stacks
        layer_info = opnames
        # Prepare the list of all unique layers
        all_layers = sorted({layer for layers in layer_info.values() for layer in layers})

        # Build layer-wise data
        layer_values = defaultdict(lambda: [0]*len(data))
        x_labels = list(data.keys())

        for col_index, key in enumerate(x_labels):
            for value, layer in zip(data[key], layer_info[key]):
                layer_values[layer][col_index] += value

        # Plotting
        x = np.arange(len(x_labels))
        bottom = np.zeros(len(x_labels))

        for layer in all_layers:
            heights = layer_values[layer]
            plt.bar(x, heights, bottom=bottom, label=layer)
            bottom += heights

        # Labels and formatting
        # plt.xticks(x, x_labels)
        # plt.xlabel('Kernel id')
        # plt.ylabel('Avg elapsed cycles')
        # plt.title('Cycles per operation split')
        # plt.legend(title='Layer')
        # plt.grid(True)
        # plt.tight_layout()
        # plt.show()
        # Create the stacked bar chart
        fig = go.Figure()

        for layer in all_layers:
            fig.add_trace(go.Bar(
                name=layer,
                x=x_labels,
                y=layer_values[layer],
                hovertemplate=f'Layer: {layer}<br>Category: %{{x}}<br>Value: %{{y}}<extra></extra>'
            ))

        fig.update_layout(
            barmode='stack',
            title='Stacked Bar Chart with Layers (Interactive)',
            xaxis_title='Category',
            yaxis_title='Value',
            legend_title='Layer',
        )

        # Save to HTML file (interactive)
        fig.write_html(f"{filepath}_chart.html")

                
    except IOError as e:
        print(f"Error reading file '{filepath}': {e}")
        return


for i in range(1, len(sys.argv)):
    create_histograms(sys.argv[i])
