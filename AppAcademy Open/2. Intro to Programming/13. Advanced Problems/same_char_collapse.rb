def same_char_collapse(str)

  i = 1
  while i < str.length
    if str[i] == str[i-1]
      if i == 1
        str = str[2..-1]
        # p str
        i = 1
        next
      else
        part_one = str[0..i-2]
        part_two = str[i + 1..-1]
        str = part_one + part_two
        # p str
        i = 1
        next
      end
    end
    i += 1
  end

  return str
end

puts same_char_collapse("zzzxaaxy")   #=> "zy"
# because zzzxaaxy -> zxaaxy -> zxxy -> zy


puts same_char_collapse("uqrssrqvtt") #=> "uv"
# because uqrssrqvtt -> uqrrqvtt -> uqqvtt -> uvtt -> uv