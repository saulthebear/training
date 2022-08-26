function rotateCoord([row, col]: [number, number], len: number) {
  return [col, len - 1 - row];
}

function rotateMatrix(matrix: any[][]): any[][] {
  const output = new Array(matrix.length);
  for (let i = 0; i < output.length; i++) {
    output[i] = new Array(output.length);
  }

  for (let row = 0; row < matrix.length; row++) {
    for (let col = 0; col < matrix[row].length; col++) {
      const [outRow, outCol] = rotateCoord([row, col], matrix.length);
      output[outRow][outCol] = matrix[row][col];
    }
  }

  return output;
}

console.log(
  rotateMatrix([
    ['a', 'b', 'c'],
    ['d', 'e', 'f'],
    ['g', 'h', 'i'],
  ])
);
