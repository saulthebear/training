const rangeLoop = function constructRangeArrayIteratively(start, end) {
  const array = [];

  for (let i = start; i < end; i += 1) {
    array.push(i);
  }

  return array;
};

const rangeRecursive = function constructRangeArrayRecursively(start, end) {
  if (start === end) {
    return [];
  }

  return [start].concat(rangeRecursive(start + 1, end));
};

const sum = function sumRecursively(arr) {
  if (arr.length < 2) {
    return arr[0];
  }

  const [ele1, ele2] = arr;
  const newArr = arr.slice(2);
  newArr.unshift(ele1 + ele2);

  return sumRecursively(newArr);
};

const exponent = function exponentVersion1(base, exp) {
  if (exp === 0) {
    return 1;
  }

  return base * exponentVersion1(base, exp - 1);
};

const exponent2 = function exponentVersion2(base, exp) {
  if (exp === 0) {
    return 1;
  }

  if (exp === 1) {
    return base;
  }

  // Even exponent
  if (exp % 2 === 0) {
    const part = exponentVersion2(base, exp / 2);
    return part * part;
  }

  // Odd Exponent
  const part = exponentVersion2(base, (exp - 1) / 2);

  return part * part * base;
};

const fib = function nthFibonacci(n) {
  if (n === 1 || n === 2) {
    return 1;
  }

  return nthFibonacci(n - 1) + nthFibonacci(n - 2);
};

const fibonacci = function firstNFibonacci(n) {
  const results = [];

  for (let i = 1; i <= n; i += 1) {
    results.push(fib(i));
  }

  return results;
};

const deepDup = function deepDuplicateArray(array) {
  if (!(array instanceof Array)) {
    return array;
  }

  return array.map((element) => deepDuplicateArray(element));
};

const bsearch = function binarySearch(array, target) {
  if (array.length === 0) {
    return -1;
  }

  const middleIndex = Math.floor(array.length / 2);
  const middleValue = array[middleIndex];

  if (middleValue === target) {
    return middleIndex;
  }

  if (middleValue > target) {
    const left = array.slice(0, middleIndex);
    return binarySearch(left, target);
  }

  const right = array.slice(middleIndex + 1);
  const subIndex = bsearch(right, target);

  if (subIndex === -1) {
    return -1;
  }

  return subIndex + middleIndex + 1;
};

console.log(bsearch([1, 2, 3, 4, 5, 6, 7], 3));

function merge(leftArray, rightArray) {
  let leftIndex = 0;
  let rightIndex = 0;

  const mergedArray = [];

  let isLeftDone = false;
  let isRightDone = false;

  while (!(isLeftDone && isRightDone)) {
    if (isRightDone || leftArray[leftIndex] <= rightArray[rightIndex]) {
      mergedArray.push(leftArray[leftIndex]);
      leftIndex += 1;
    } else {
      mergedArray.push(rightArray[rightIndex]);
      rightIndex += 1;
    }

    isLeftDone = leftIndex === leftArray.length;
    isRightDone = rightIndex === rightArray.length;
  }

  return mergedArray;
}

function mergeSort(array) {
  if (array.length === 1) {
    return array;
  }

  const middleIndex = Math.floor(array.length / 2);
  return merge(
    mergeSort(array.slice(0, middleIndex)),
    mergeSort(array.slice(middleIndex, array.length))
  );
}
