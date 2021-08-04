def adjacent_sum(arr)
  sum_arr = []
  arr.each_with_index do |num, i|
    if i < arr.length - 1
      # p "#{num} , #{arr[i+1]}"
      # p "#{num} + #{arr[i+1]} = #{num + arr[i+1]}"
      sum_arr.push(num + arr[i + 1])
    end
  end
  return sum_arr
end

print adjacent_sum([3, 7, 2, 11]) #=> [10, 9, 13], because [ 3+7, 7+2, 2+11 ]
puts
print adjacent_sum([2, 5, 1, 9, 2, 4]) #=> [7, 6, 10, 11, 6], because [2+5, 5+1, 1+9, 9+2, 2+4]
puts
