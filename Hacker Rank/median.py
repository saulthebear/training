def findMedian(arr):
    arr.sort()
    midIndex = round(len(arr)/2) - 1
    midVal = arr[midIndex]
    return midVal

