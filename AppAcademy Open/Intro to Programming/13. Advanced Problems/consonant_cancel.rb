def consonant_cancel(sentence)
  new_sentence_arr = []
  sentence.split(' ').each do |word|
     new_sentence_arr << consonant_cancel_word(word)
  end
  return new_sentence_arr.join(' ')
end

def consonant_cancel_word(word)
  vowels = 'aeiou'
  word_arr = word.split('')
  new_word_arr = []
  vowel_found = false

  word_arr.each do |char|
    vowel_found = true if vowels.include?(char)
    new_word_arr << char if vowel_found
  end

  return new_word_arr.join('')

end

puts consonant_cancel("down the rabbit hole") #=> "own e abbit ole"
puts consonant_cancel("writing code is challenging") #=> "iting ode is allenging"
