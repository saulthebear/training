function madLib(verb, adj, noun) {
  const upperVerb = verb.toUpperCase();
  const upperAdj = adj.toUpperCase();
  const upperNoun = noun.toUpperCase();
  return `We shall ${upperVerb} the ${upperAdj} ${upperNoun}`;
}

// console.log(madLib('make', 'best', 'guac'));

function isSubstring(searchString, subString) {
  const regex = new RegExp(subString);

  return searchString.search(regex) !== -1;
}

// console.log(isSubstring('time to program', 'time'));
// console.log(isSubstring('Jump for joy', 'joys'));

/**
 * Filters the passed in array so that it doesn't include numbers
 * divisible by 3 or 5
 * @param {number[]} numbers
 * @return {number[]}
 */
function fizzBuzz(numbers) {
  const newArr = numbers.filter((num) => {
    const notDivisibleBy3 = num % 3 !== 0;
    const notDivisibleBy5 = num % 5 !== 0;
    return notDivisibleBy3 && notDivisibleBy5;
  });

  return newArr;
}

const arr = [];
for (let i = 0; i < 20; i += 1) {
  arr.push(i);
}

// console.log(fizzBuzz(arr));

/**
 * @param {number} number - A positive integer.
 * @return {boolean} true if the number is prime
 */
function isPrime(number) {
  if (number < 1) {
    return undefined;
  }

  for (let i = 2; i < number; i += 1) {
    if (number % i === 0) {
      return false;
    }
  }

  return true;
}

// console.log(isPrime(2));
// console.log(isPrime(10));
// console.log(isPrime(15485863));
// console.log(isPrime(3548563));

/**
 * @param {number} n - The number of primes to return
 * @return {number[]}
 */
function firstNPrimes(n) {
  const primes = [];
  let candidate = 2;

  while (primes.length < n) {
    if (isPrime(candidate)) {
      primes.push(candidate);
    }
    candidate += 1;
  }

  return primes;
}

function sumOfNPrimes(n) {
  const primes = firstNPrimes(n);

  if (primes.length === 0) {
    return 0;
  }

  return primes.reduce((accumulator, element) => accumulator + element);
}

// console.log(sumOfNPrimes(4));
