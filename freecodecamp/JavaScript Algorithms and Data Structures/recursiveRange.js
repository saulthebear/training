/* The function should return an array of integers which begins with a number
represented by the startNum parameter and ends with a number represented by the
endNum parameter. Your function must use recursion by calling itself and not use
loops of any kind. It should also work for cases where both startNum and endNum
are the same. */

function rangeOfNumbers(startNum, endNum) {
  if (startNum === endNum) {
    const arr = [];
    arr.push(endNum);
    return arr;
  }
  const arr = rangeOfNumbers(startNum, endNum - 1);
  arr.push(endNum);
  return arr;
}

console.log(rangeOfNumbers(3, 6));
