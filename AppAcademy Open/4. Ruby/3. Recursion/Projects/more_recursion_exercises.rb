#Problem 1: 

def sum_recur(array)
  return nil unless array.is_a?(Array) && array.all? { |ele| ele.is_a?(Integer) }
  return array[0] if array.length == 1

  array.pop + sum_recur(array)
end

#Problem 2: 

def includes?(array, target)
  return false if array.empty?

  return true if array[0] == target

  includes?(array[1..-1], target)
end

# Problem 3: 

def num_occur(array, target)
  return 0 if array.empty?

  last_ele = array.pop
  return 1 + num_occur(array, target) if last_ele == target

  num_occur(array, target)
end

# Problem 4: 

def add_to_twelve?(array)
  return false if array.length == 1

  first_ele = array.shift
  second_ele = array[0]
  return true if (first_ele + second_ele) == 12

  add_to_twelve?(array)
end

# Problem 5: 

def sorted?(array)
  return true if array.length == 1
  return false if array[0] > array[1]

  sorted?(array[1..-1])
end

# Problem 6: 

def reverse(string)
  return string if string.length == 1

  string[-1] + reverse(string[0...-1])
end
