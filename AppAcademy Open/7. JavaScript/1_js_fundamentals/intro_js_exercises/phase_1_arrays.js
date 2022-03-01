/* eslint-disable no-extend-native */

Array.prototype.uniq = function uniqueElements() {
  const newArray = [];

  this.forEach((element) => {
    if (!newArray.includes(element)) {
      newArray.push(element);
    }
  });

  return newArray;
};

Array.prototype.twoSum = function findZeroSumIndices() {
  const indicies = [];

  for (let i = 0; i < this.length - 1; i += 1) {
    for (let j = i + 1; j < this.length; j += 1) {
      const num1 = this[i];
      const num2 = this[j];

      if (num1 + num2 === 0) {
        indicies.push([i, j]);
      }
    }
  }

  return indicies;
};

Array.prototype.transpose = function transpose2DArray() {
  const newRowCount = this[0].length;
  const newColCount = this.length;

  const transposedArray = [];

  // Construct empty array of correct size
  for (let i = 0; i < newRowCount; i += 1) {
    const row = [];
    for (let j = 0; j < newColCount; j += 1) {
      row.push(this[j][i]);
    }
    transposedArray.push(row);
  }

  return transposedArray;
};
