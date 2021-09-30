# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

require "byebug"

def largest_prime_factor(num)
  answer = 1

  (2..num).each do |factor|
    if (num % factor).zero? && prime?(factor)
      answer = factor
    end
  end

  answer
end

def prime?(num)
  return false if num < 2

  (2...num).each do |factor|
    return false if (num % factor).zero?
  end
  true
end

def unique_chars?(str)
  chars_found = []

  str.each_char do |c|
    return false if chars_found.include?(c)

    chars_found << c
  end

  true
end

def dupe_indices(arr)
  indices = Hash.new { |hash, key| hash[key] = [] }
  arr.each.with_index do |ele, idx|
    indices[ele] << idx
  end
  indices.filter { |_, val| val.length > 1 }
end

def ana_array(arr_1, arr_2)
  arr_1.each do |ele|
    return false unless arr_2.include?(ele)
  end
  arr_2.each do |ele|
    return false unless arr_1.include?(ele)
  end
  true
end
