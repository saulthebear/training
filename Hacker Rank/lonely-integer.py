#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'lonelyinteger' function below.
#
# The function is expected to return an INTEGER.
# The function accepts INTEGER_ARRAY a as parameter.
#

def lonelyinteger(a):
    # Write your code here
    counts = {}
    for i in a:
        if i not in counts:
            counts[i] = 1
        else:
            counts[i] += 1
    
    for key, val in counts.items():
        if (val == 1):
            return key

# if __name__ == '__main__':
#     fptr = open(os.environ['OUTPUT_PATH'], 'w')

#     n = int(input().strip())

#     a = list(map(int, input().rstrip().split()))

#     result = lonelyinteger(a)

#     fptr.write(str(result) + '\n')

#     fptr.close()
