def vowel_cipher(string)
  vowels = 'aeiou'
  cipher_text = ''

  string.each_char do |char|
    # cipher_text += vowels.include?(char) ? vowels[(vowels.index(char) + 1) % vowels.length] : char
    if vowels.include?(char)
      cipher_text += vowels[(vowels.index(char) + 1) % vowels.length]
    else
      cipher_text += char
    end
  end

  return cipher_text
end

puts vowel_cipher("bootcamp") #=> buutcemp
puts vowel_cipher("paper cup") #=> pepir cap