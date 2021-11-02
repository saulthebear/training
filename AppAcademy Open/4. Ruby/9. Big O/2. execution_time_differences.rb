# O(n^2)
def my_min1(list)
  list.each_with_index do |ele, index|
    smallest = true
    list.each_with_index do |ele2, index2|
      next if index == index2

      smallest = false if ele2 < ele
    end
    return ele if smallest
  end
end

# O(n)
def my_min2(list)
  smallest = list.first
  list.each do |ele|
    smallest = ele if ele < smallest
  end
  smallest
end

# O(n^2)?
def largest_contiguous_subsum1(list)
  subarrs = []
  list.length.times do |index1|
    (index1...list.length).each do |index2|
      subarrs << list[index1..index2]
    end
  end
  
  sums = subarrs.map(&:sum)
  sums.max
end

# O(n)
def largest_contiguous_subsum2(list)
  largest_sum = list.first
  current_sum = list.first
  (1...list.length).each do |index|
    current_sum = 0 if current_sum < 1

    current_sum += list[index]
    largest_sum = current_sum if current_sum > largest_sum
  end

  largest_sum
end

if __FILE__ == $PROGRAM_NAME
  # list1 = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
  # puts my_min2(list1)

  list2 = [5, 3, -7]
  puts largest_contiguous_subsum2(list2)
  list3 = [2, 3, -6, 7, -6, 7]
  puts largest_contiguous_subsum2(list3)
  list4 = [-5, -1, -3]
  puts largest_contiguous_subsum2(list4)
end
