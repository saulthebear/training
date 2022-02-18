/* eslint-disable no-extend-native */

Array.prototype.bubbleSort = function bubbleSortArray() {
  let sorted = false;

  while (!sorted) {
    sorted = true;

    for (let i = 0; i < this.length - 1; i += 1) {
      const ele1 = this[i];
      const ele2 = this[i + 1];

      if (ele1 > ele2) {
        sorted = false;
        this[i] = ele2;
        this[i + 1] = ele1;
      }
    }
  }

  return this;
};

String.prototype.substrings = function stringSubstrings() {
  const substrings = [];

  for (let i = 0; i < this.length; i += 1) {
    for (let j = i; j < this.length; j += 1) {
      // Exclude the full string
      if (i === 0 && j === this.length - 1) {
        continue;
      }

      const sub = this.slice(i, j + 1);

      // Only add substrings that aren't already included
      if (!substrings.includes(sub)) {
        substrings.push(sub);
      }
    }
  }

  return substrings;
};
