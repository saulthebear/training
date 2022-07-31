# def flipCol(matrix, colIndex):
#     col = []
#     for row in matrix:
#         print(f'row: {row}')
#         col.append(row[colIndex])
    
#     print(col)
#     col.reverse()
#     print(col)
    
#     newMatrix = matrix.copy()
    
#     for rowIndex in range(len(matrix)):
#         newMatrix[rowIndex][colIndex] = col[rowIndex]
    
#     return newMatrix

# def flipRow(matrix, rowIndex):
#     matrix[rowIndex].reverse()
#     return matrix

# m = [[1,2], [3,4]]

# def flippingMatrix(matrix):
#     for rowIndex in range(len(matrix)):
#         row = matrix[rowIndex]
#         leftSum = 0
#         rightSum = 0
#         for colIndex in range(len(row)):
#             if colIndex < len(matrix) / 2:
#                 leftSum += row[colIndex]
#             else:
#                 rightSum += row[colIndex]
        
#         if rightSum > leftSum:
#             flipRow(matrix, rowIndex)
    
#     for rowIndex in range(len(matrix)):
#         for colIndex in range(len(matrix)):

def flippingMatrix(matrix):
    maxSum = 0
    n = len(matrix) // 2
    for rowIndex in range(n):
        for colIndex in range(n):
            rowComplement = len(matrix) - 1 - rowIndex
            colComplement = len(matrix) - 1 - colIndex
            
            cell1 = matrix[rowIndex][colIndex]
            cell2 = matrix[rowIndex][colComplement]
            cell3 = matrix[rowComplement][colIndex]
            cell4 = matrix[rowComplement][colComplement]
            
            maxSum += max(cell1, cell2, cell3, cell4)
    
    return maxSum

m1 = [
    [112, 42, 83, 119],
    [56, 125, 56, 49],
    [15, 78, 101, 43],
    [62, 98, 114, 108]
]

m2 = [
    [1,2],
    [3,4]
]

print(flippingMatrix(m2))
