function isOneInsertionAway(strOne, strTwo) {
  let long = strOne;
  let short = strTwo;

  if (strOne.length < strTwo.length) {
    long = strTwo;
    short = strOne;
  }

  let numDiffs = 0;
  let longIndex = 0;
  let shortIndex = 0;

  while (longIndex < long.length && shortIndex < short.length) {
    if (numDiffs > 1) return false;

    const longChar = long[longIndex];
    const shortChar = short[shortIndex];

    if (longChar === shortChar) {
      longIndex += 1;
      shortIndex += 1;
    } else {
      longIndex += 1;
      numDiffs += 1;
    }
  }

  if (numDiffs > 1) return false;

  return true;
}

function isOneAway(strOne, strTwo) {
  if (strOne.length !== strTwo.length) {
    if (Math.abs(strOne.length - strTwo.length) > 1) return false;
    return isOneInsertionAway(strOne, strTwo);
  }

  // Substitution check - equal length
  // Is diff in only one place?

  let numDiffs = 0;

  for (let i = 0; i < strOne.length; i += 1) {
    const charOne = strOne[i];
    const charTwo = strTwo[i];

    if (charOne !== charTwo) numDiffs += 1;
    if (numDiffs > 1) return false;
  }

  return numDiffs < 2;
}

console.log(isOneAway('pale', 'ple')); // true
console.log(isOneAway('pales', 'pale')); // true
console.log(isOneAway('pale', 'bale')); // true
console.log(isOneAway('pale', 'bake')); // false
