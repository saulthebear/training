def consonant_cancel(sentence)
  words = sentence.split(' ')
  new_words = words.map { |word| consonant_cancel_word(word) }
  return new_words.join(' ')
end

def consonant_cancel_word(word)
  vowels = 'aeiou'

  word.each_char.with_index do |char, i|
    return word[i..-1] if vowels.include?(char)
  end
end

puts consonant_cancel("down the rabbit hole") #=> "own e abbit ole"
puts consonant_cancel("writing code is challenging") #=> "iting ode is allenging"
