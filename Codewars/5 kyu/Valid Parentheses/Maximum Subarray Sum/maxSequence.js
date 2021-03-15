// eslint-disable-next-line no-unused-vars
const maxSequence = function(arr) {
  let max = 0;

  for (let subArrLen = arr.length; subArrLen > 0; subArrLen--) {
    for (let subArrNum = 0;
      subArrNum < arr.length - subArrLen + 1;
      subArrNum++) {
      const sum = arr.slice(subArrNum, subArrLen + subArrNum)
          .reduce((accumulator, currentValue) => accumulator + currentValue);
      if (sum > max) max = sum;
    }
  }

  return max;
};


