function duplicateEncode(word) {
  const dictionary = {};
  let output = '';

  for (let i = 0; i < word.length; i++) {
    const char = word.charAt(i).toLowerCase();
    if (!dictionary.hasOwnProperty(char)) {
      dictionary[char] = '(';
    } else {
      dictionary[char] = ')';
    }
  }

  for (let i = 0; i < word.length; i++) {
    output += dictionary[word.charAt(i).toLowerCase()];
  }

  return output;
}

// Export function for tests to work
module.exports = {duplicateEncode};
