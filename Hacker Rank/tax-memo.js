/*

You're working for AirBed & Breakfast on the payments team. Your team is planning to roll out a payment algorithm that computes the payment per transaction including tax. An engineer on your team has committed code to accomplish this, but your team's manager has reviewed the code and left a comment saying it is not performant.

Fix the code so that the function is called only once per distinct transaction value.

Example Input:

transactions: [10,24,12,8,10,24]
tax: 1.2
Example Output:

4
Explanation:

The function should be called 4 times, since there are 4 distinct transaction values: 10, 24, 12 and 8.

*/

/*
// ORIGINAL

const solution = (transactions, taxRate) => {
  let numCalls = 0

  const calculateCostAfterTax = (cost, taxRate) => {
    numCalls = numCalls + 1
    return cost * taxRate
  }

  const computeTotal = (taxRate) => {
    return (cost) => {
      return calculateCostAfterTax(cost, taxRate)
    }
  }

  transactions.map(computeTotal(taxRate))
  return numCalls
} 

*/

const solution = (transactions, taxRate) => {
  let numCalls = 0;

  const preCalculated = new Map();

  const calculateCostAfterTax = (cost, taxRate) => {
    numCalls = numCalls + 1;
    return cost * taxRate;
  };

  const computeTotal = (taxRate) => {
    return (cost) => {
      if (preCalculated.has(cost)) {
        return preCalculated.get(cost);
      }

      const result = calculateCostAfterTax(cost, taxRate);
      preCalculated.set(cost, result);
      return result;
    };
  };

  transactions.map(computeTotal(taxRate));
  return numCalls;
};

solution([10, 24, 12, 8, 10, 24], 1.2); //?
