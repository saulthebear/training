# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/reverse-words
# Write a method reverse_words that takes in a sentence string and returns the sentence
# with the order of the characters in each word reversed. Note that we need to reverse
# the order of characters in the words, do not reverse the order of words in the sentence.

def reverse_words(sent)
  reversed_words = []
  sent.split(' ').each do |word|
    reversed_words.push(reverse_word(word))
  end
  return reversed_words.join(' ')
end

def reverse_word(word)
  chars = word.split('')
  reversed_chars = []

  chars.each do |char|
    reversed_chars.unshift(char)
  end
  return reversed_chars.join('')
end

puts reverse_words('keep coding') # => 'peek gnidoc'
puts reverse_words('simplicity is prerequisite for reliability') # => 'yticilpmis si etisiuqererp rof ytilibailer'
