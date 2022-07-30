#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'miniMaxSum' function below.
#
# The function accepts INTEGER_ARRAY arr as parameter.
#

def miniMaxSum(arr):
    # Write your code here
    
    if len(arr) == 0:
        print('0 0')
        return
    
    maxVal = arr[0]
    minVal = arr[0]
    totalSum = arr[0]
    for i in arr[1:]:
        if i < minVal:
            minVal = i
        if i > maxVal:
            maxVal = i
        totalSum += i
    
    maxSum = totalSum - minVal
    minSum = totalSum - maxVal
    print(f"{minSum} {maxSum}")
    
            
    

if __name__ == '__main__':

    arr = list(map(int, input().rstrip().split()))

    miniMaxSum(arr)
