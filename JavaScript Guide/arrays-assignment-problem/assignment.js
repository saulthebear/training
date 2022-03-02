const arr = [1, 6, 4, 6, 7, 1, 8, 9, 7, 0, -29, 5, 89];

console.log(arr.filter((ele) => ele > 5));
console.log(arr.map((ele) => ({ num: ele })));
console.log(arr.reduce((product, ele) => product * ele));

const findMax = (...elements) =>
  elements.reduce((max, current) => {
    if (current > max) {
      return current;
    }
    return max;
  });

const findExtremes = (...elements) => {
  let max = elements[0];
  let min = elements[0];

  for (let i = 1; i < elements.length; i += 1) {
    const ele = elements[i];
    if (ele > max) max = ele;
    if (ele < min) min = ele;
  }

  return [min, max];
};

console.log(findMax(...arr));
console.log(findExtremes(...arr));

const list = new Set(arr);
console.log(list);
