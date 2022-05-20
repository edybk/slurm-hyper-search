import numpy as np

# number of trees T = 1 - 3
# paths traversed in tree (beam search) P = 10
# max no of labels in leaf M = 100
# misclass. penality for classifiers C = 10 (1) log loss (squared hinge loss)

# P = 5, 10, 15, 20, 50, 100 ?

space = {
    'num_f_maps': [32, 64, 128, 256, 512],                            # T in Parabel paper
    'num_layers_PG': [7, 11, 15, 30],  # M
    'num_layers_R': [6, 10, 14, 26],
    'num_R': [1, 3, 6, 12],            # C
    'lr': [0.0001, 0.0005, 0.005, 0.001],
}

# Note: you can also specify probability distributions, e.g.,
# import scipy
#     'C': scipy.stats.expon(scale=100),
#     'gamma': scipy.stats.expon(scale=.1),
