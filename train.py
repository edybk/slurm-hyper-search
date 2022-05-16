import sys
print(str(sys.argv))
import argparse

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('--output-file')
args = parser.parse_args()
print(args.output_file)
with open(args.output_file, 'a') as f:
    f.write("P@5 1")

