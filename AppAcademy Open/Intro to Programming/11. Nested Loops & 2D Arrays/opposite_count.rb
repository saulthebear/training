# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/opposite-count
# Write a method opposite_count that takes in an array of unique numbers. The method should
# return the number of pairs of elements that sum to 0.

def opposite_count(nums)
  zero_sum_count = 0

  nums.each_with_index do |outer_ele, i|
    nums.each_with_index do |inner_ele, j|
      zero_sum_count += 1 if j > i && (outer_ele + inner_ele).zero?
    end
  end

  return zero_sum_count
end

puts opposite_count([ 2, 5, 11, -5, -2, 7 ]) # => 2
puts opposite_count([ 21, -23, 24 -12, 23 ]) # => 1
