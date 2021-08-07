# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/prime-factors
# Write a method prime_factors that takes in a number and returns an array containing all
# of the prime factors of the given number.

def prime_factors(num)
  factors = []
  (2...num).each do |n|
    factors << n if (num % n).zero? && prime?(n)
  end
  return factors
end

def prime?(num)
  return false if num < 2

  # Skip 0 and 1
  (2...num).each do |factor|
    return false if (num % factor).zero?
  end
  return true
end

print prime_factors(24) #=> [2, 3]
puts
print prime_factors(60) #=> [2, 3, 5]
puts