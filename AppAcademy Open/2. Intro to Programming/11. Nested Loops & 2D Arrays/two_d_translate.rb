# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/two-dimensional-translate
# Write a method two_d_translate that takes in a 2 dimensional array and translates it into a 1 dimensional
# array. You can assume that the inner arrays always have 2 elements. See the examples.

def two_d_translate(arr)
  flat_array = []

  arr.each do |el|
    el[1].times do
      flat_array << el[0]
    end
  end

  return flat_array
end

arr_1 = [
  ['boot', 3],
  ['camp', 2],
  ['program', 0]
]

print two_d_translate(arr_1) # => [ 'boot', 'boot', 'boot', 'camp', 'camp' ]
puts

arr_2 = [
  ['red', 1],
  ['blue', 4]
]

print two_d_translate(arr_2) # => [ 'red', 'blue', 'blue', 'blue', 'blue' ]
puts