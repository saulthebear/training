function solution(number){
    let sum = 0;
    
    // Start 1 below number passed in
    // Decrement by 1 and check divisibility of each number
    for(let i = number - 1; i > 0; i--) {
      sum += check(i);
    }
    
    return sum;
  }
  
  // if number is divisible by 5 or 3, return that number
  // if it's divisible by both it returns after the divisibility by 5 check
  // if not divisible by either return 0
  function check(number) {
    
    if (number % 5 == 0) {
      return number;
    }
    
    if (number % 3 == 0) {
      return number;
    }
    
    return 0;
  }