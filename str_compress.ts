function solution(input: string) {
  let output = '';
  let char = input[0];
  let count = 1;

  for (let i = 1; i < input.length; i++) {
    if (input[i] !== char) {
      output += `${char}${count}`;
      char = input[i];
      count = 1;
    } else {
      count += 1;
    }
  }

  output += `${char}${count}`;

  if (output.length > input.length) {
    return input;
  }

  return output;
}

console.log(solution('aabcccccaaa')); // a2b1c5a3
console.log(solution('a')); // a
