
#import sys
#print(str(sys.argv))
import argparse

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('output_file')
args = parser.parse_args()
#print(args.output_file)
with open(args.output_file, 'r') as f:
    print(f.read())

