/* eslint-disable no-extend-native */

Array.prototype.myEach = function (callback) {
  for (let i = 0; i < this.length; i += 1) {
    const element = this[i];
    callback(element);
  }
};

Array.prototype.myMap = function (callback) {
  const newArray = [];

  this.myEach((ele) => {
    newArray.push(callback(ele));
  });

  return newArray;
};

Array.prototype.myReduce = function (callback, initialValue) {
  let reduction;
  let i = 0;

  if (initialValue === undefined) {
    [reduction] = this;
    i += 1;
  } else {
    reduction = initialValue;
  }

  for (; i < this.length; i += 1) {
    const element = this[i];
    reduction = callback(reduction, element);
  }

  return reduction;
};

const arr = [1, 2, 3, 4, 5, 6];
console.log(arr.myMap((n) => n * 2));

console.log(arr.myReduce((acc, el) => acc + el));

console.log([1, 2, 3].myReduce((acc, el) => acc + el, 25));
