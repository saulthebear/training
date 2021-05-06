# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/prime
# Write a method prime? that takes in a number and returns a boolean, indicating whether the number is prime. A prime
# number is only divisible by 1 and itself.

def prime?(num)
  return false if num < 2

  # Skip 0 and 1
  (2...num).each do |factor|
    return false if (num % factor).zero?
  end
  return true
end

puts prime?(2)  #=> true
puts prime?(5)  #=> true
puts prime?(11) #=> true
puts prime?(4)  #=> false
puts prime?(9)  #=> false
puts prime?(-5) #=> false
