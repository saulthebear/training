# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/yell-sentence
# Write a method yell_sentence that takes in a sentence string and returns a new sentence where every word is yelled.
# See the examples. Use map to solve this.

def yell_sentence(sent)
  yelled_words = sent.split(' ').map { |word| word.upcase + '!' }
  return yelled_words.join(' ')
end

puts yell_sentence("I have a bad feeling about this") #=> "I! HAVE! A! BAD! FEELING! ABOUT! THIS!"