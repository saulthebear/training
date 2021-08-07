# For example, the base [1, 4, 6] gives us the following pyramid
#     15
#   5   10
# 1   4    6

def pyramid_sum(base)
  pyramid = [base]
  sum_arr = []

  until sum_arr.length == 1
    sum_arr = adjacent_sum(base)
    pyramid.unshift(sum_arr)
    base = sum_arr
  end

  return pyramid
end

def adjacent_sum(arr)
  sum_arr = []
  arr.each_with_index do |num, i|
    if i < arr.length - 1
      sum_arr << (num + arr[i + 1])
    end
  end
  return sum_arr
end

print pyramid_sum([1, 4, 6]) #=> [[15], [5, 10], [1, 4, 6]]
puts

print pyramid_sum([3, 7, 2, 11]) #=> [[41], [19, 22], [10, 9, 13], [3, 7, 2, 11]]
puts
