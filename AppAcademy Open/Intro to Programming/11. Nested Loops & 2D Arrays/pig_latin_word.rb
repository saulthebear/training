# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/pig-latin-word
# Write a method pig_latin_word that takes in a word string and translates the word into pig latin.
# Pig latin translation uses the following rules:
# - for words that start with a vowel, add 'yay' to the end
# - for words that start with a nonvowel, move all letters before the first vowel to the end of the word and add 'ay'

def pig_latin_word(word)

  return "#{word}yay" if vowel?(word[0])

  word.each_char.with_index do |char, i|
    return word[i..-1] + word[0...i] + 'ay' if vowel?(char)
  end

end

def vowel?(char)
  return 'aeiou'.include?(char)
end

puts pig_latin_word("apple")   # => "appleyay"
puts pig_latin_word("eat")     # => "eatyay"
puts pig_latin_word("banana")  # => "ananabay"
puts pig_latin_word("trash")   # => "ashtray"