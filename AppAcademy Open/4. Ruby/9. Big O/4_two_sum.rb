# time: O(1)
# space: O(n)
def two_sum?(arr, target_sum)
  complements = Hash.new(false)
  arr.each do |ele|
    return true if complements[ele]

    complements[target_sum - ele] = true
  end

  false
end

# time: O(n^2)
# space: O(1)
def bad_two_sum?(arr, target_sum)
  arr.each_with_index do |ele1, index1|
    (index1 + 1...arr.length).each do |index2|
      ele2 = arr[index2]
      return true if ele1 + ele2 == target_sum
    end
  end
  false
end

arr = [0, 1, 5, 7]
puts two_sum?(arr, 6) # => true
puts two_sum?(arr, 10) # => false
