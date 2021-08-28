# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
  new_str = ''

  curr_char = str[0]
  curr_count = 1
  str.each_char.with_index do |char, idx|
    next if idx.zero? # Skip first char

    if char == curr_char
      curr_count += 1
      next
    else
      new_str += encode(curr_char, curr_count)
      curr_char = char
      curr_count = 1
    end
  end

  new_str += encode(curr_char, curr_count)
end

def encode(char, count)
  return "#{count}#{char}" if count > 1

  char
end

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
