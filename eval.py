
#import sys
#print(str(sys.argv))
import argparse
import numpy as np

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('output_file')
args = parser.parse_args()
#print(args.output_file)
with open(args.output_file, 'r') as f:
    # print(f.read())
    lines = f.read().split('\n')[:-1]
    split_means = []
    split_stds = []

    for line in lines:
        if not line:
            continue
        tokens = line.split(",")
        metric = tokens[0]
        value=float(tokens[2])
        if metric == 'mean':
            split_means.append(value)
        elif metric == 'std':
            split_stds.append(value)
    print(f"mean {np.mean(split_means)}")
    print(f"std {np.std(split_means)}")

