def element_count(arr)
  counts = Hash.new(0)
  arr.each { |ele| counts[ele] += 1}
  counts
end

def char_replace!(str, hash)
  str.each_char.with_index { |char, idx| str[idx] = hash[char] if hash.key?(char) }
end

def product_inject(nums)
  nums.inject(&:*)
end
