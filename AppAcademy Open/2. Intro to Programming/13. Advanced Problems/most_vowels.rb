# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/most-vowels
# Write a method most_vowels that takes in a sentence string and returns the word of the sentence that contains the most
# vowels.

def most_vowels(sentence)
  words = sentence.split(' ')
  max_vowels = ['', 0]
  words.each do |word|
    vowel_count = count_vowels(word)
    if vowel_count > max_vowels[1]
      max_vowels = [word, vowel_count]
    end
  end
  return max_vowels[0]
end

def count_vowels(word)
  vowels = 'aeiou'
  count = 0
  word.each_char { |char| count += 1 if vowels.include? char }
  return count
end

print most_vowels("what a wonderful life") #=> "wonderful"
