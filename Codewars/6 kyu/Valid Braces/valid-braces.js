// eslint-disable-next-line no-unused-vars
function validBraces(braces) {
  const matchingBracket = {
    '(': ')',
    '[': ']',
    '{': '}',
  };

  while (braces.length !== 0) {
    // Find last open brackets so that we can process
    // the inner-most brackets first
    const lastOpenParenIndex = braces.lastIndexOf('(');
    const lastOpenSquareIndex = braces.lastIndexOf('[');
    const lastOpenCurlyIndex = braces.lastIndexOf('{');

    const innerMostOpenBracketIndex = Math.max(lastOpenParenIndex,
        lastOpenSquareIndex,
        lastOpenCurlyIndex);

    // If no open brackets are found the input is invalid
    if (innerMostOpenBracketIndex < 0) {
      return false;
    }

    // If the character following the inner-most open bracket
    // is not a matching close bracket the input is invalid.
    if (braces.charAt(innerMostOpenBracketIndex + 1) !==
      matchingBracket[braces.charAt(innerMostOpenBracketIndex)]) {
      return false;
    }

    // Remove the inner-most set of brackets from the string
    braces = braces.slice(0, innerMostOpenBracketIndex) +
      braces.slice(innerMostOpenBracketIndex + 2);
  }
  // If all characters have been removed then all braces were valid
  return true;
}
