# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
  new_str = ""
  current_letter = str[0]
  count = 0

  str.each_char.with_index do |char, idx|
    if char != current_letter && idx != 0
      new_str += count > 1 ? count.to_s + current_letter : current_letter
      count = 1
      current_letter = char
    else
      count += 1
    end
  end

  new_str += count > 1 ? count.to_s + current_letter : current_letter
end

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
