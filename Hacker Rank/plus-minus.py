#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'plusMinus' function below.
#
# The function accepts INTEGER_ARRAY arr as parameter.
#

def plusMinus(arr):
    # Write your code here
    positiveCount = 0
    negativeCount = 0
    zeroCount = 0
    for i in arr:
        if i > 0:
            positiveCount += 1
        elif i < 0:
            negativeCount += 1
        else:
            zeroCount += 1
    
    positiveRatio = positiveCount / len(arr)
    negativeRatio = negativeCount / len(arr)
    zeroRatio = zeroCount / len(arr)
    
    print("%.6f" % positiveRatio)
    print("%.6f" % negativeRatio)
    print("%.6f" % zeroRatio)
    

if __name__ == '__main__':
    n = int(input().strip())

    arr = list(map(int, input().rstrip().split()))

    plusMinus(arr)
