# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/combinations
# Write a method combinations that takes in an array of unique elements, the method should
# return a 2D array representing all possible combinations of 2 elements of the array.

def combinations(arr)
  combined = []

  arr.each_with_index do |ele1, i|
    arr.each_with_index do |ele2, j|
      combined << [ele1, ele2] if j > i
    end
  end

  return combined
end

print combinations(["a", "b", "c"]); # => [ [ "a", "b" ], [ "a", "c" ], [ "b", "c" ] ]
puts

print combinations([0, 1, 2, 3]); # => [ [ 0, 1 ], [ 0, 2 ], [ 0, 3 ], [ 1, 2 ], [ 1, 3 ], [ 2, 3 ] ]
puts