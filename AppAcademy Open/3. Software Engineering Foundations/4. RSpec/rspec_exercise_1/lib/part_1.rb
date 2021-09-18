def average(num_1, num_2)
  (num_1 + num_2) / 2.0
end

def average_array(arr)
  arr.sum / arr.length.to_f
end

def repeat(str, num)
  str * num
end

def yell(str)
  "#{str.upcase}!"
end

def alternating_case(str)
  arr = str.split
  (0...arr.length).each do |idx|
    if (idx % 2 == 0)
      arr[idx] = arr[idx].upcase
    else
      arr[idx] = arr[idx].downcase
    end
  end
  
  arr.join(' ')
end