# Given a square matrix, calculate the absolute difference between the sums of its diagonals.

def diagonalDifference(arr):
    # aSum = 0
    # bSum = 0
    diff = 0
    size = len(arr)
    
    for i in range(size):
        # row = arr[i]
        # aSum += row[i]
        # bSum += row[len(arr) - 1 - i]
        diff += arr[i][i] - arr[i][size - 1 - i]
    return abs(diff)

m1 = [
    [1, 2, 3],
    [4, 5, 6],
    [9, 8, 9]
]

# m1 => 2

m2 = [
    [11, 2, 4],
    [4, 5, 6],
    [10, 8, -12]
]
# m2 => 15

print(diagonalDifference(m1))
