# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/last-index
# Write a method last_index that takes in a string and a character. The method should return the last index where the
# character can be found in the string.

def last_index(str, char)
  idx = str.length - 1

  while idx >= 0
    return idx if str[idx] == char

    idx -= 1
  end

  return -1
  
end

puts last_index("abca", "a")       #=> 3
puts last_index("mississipi", "i") #=> 9
puts last_index("octagon", "o")    #=> 5
puts last_index("programming", "m")#=> 7
