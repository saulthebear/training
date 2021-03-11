function validParentheses(parens){
    
    while(parens.length !== 0) {
      // Find last open paren so that we can process the inner-most parentheses first
      let last_index = parens.lastIndexOf('(');
      
      // If no open parentheses are found the input is invalid
      if(last_index < 0) return false;
      
      // If the character following the inner-most parentheses is not a close paren the input is invalid.
      if(parens.charAt(last_index + 1) !== ')') return false;
      
      // Remove the inner-most set of parentheses from the string
      parens = parens.slice(0, last_index) + parens.slice(last_index + 2);
    }
    // If all characters have been removed then all parens were valid
    return true;
  }