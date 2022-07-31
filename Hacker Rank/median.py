def findMedian(arr):
    arrCopy = arr.copy()
    arrCopy.sort()
    midIndex = len(arrCopy)//2
    midVal = arrCopy[midIndex]
    return midVal

