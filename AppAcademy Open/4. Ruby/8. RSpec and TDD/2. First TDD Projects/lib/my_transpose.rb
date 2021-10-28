def my_transpose(arr)
  raise(ArgumentError, 'Must be an array!') unless arr.is_a?(Array)
  raise(ArgumentError, 'Array must be square!') unless square?(arr)

  new_arr = []
  arr.length.times do |index1|
    new_row = []
    arr.length.times do |index2|
      new_row << arr[index2][index1]
    end
    new_arr << new_row
  end

  new_arr
end

def square?(arr)
  arr.all? { |sub| sub.length == arr.length }
end
