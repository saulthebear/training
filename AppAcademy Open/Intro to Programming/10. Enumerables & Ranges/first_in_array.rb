# Write a method first_in_array that takes in an array and two elements,
# the method should return the element that appears earlier in the array.

def first_in_array(arr, el1, el2)
  return arr.index(el1) < arr.index(el2) ? el1 : el2
end

puts first_in_array(["a", "b", "c", "d"], "d", "b"); # => "b"
puts first_in_array(["cat", "bird" ,"dog", "mouse" ], "dog", "mouse"); # => "dog"