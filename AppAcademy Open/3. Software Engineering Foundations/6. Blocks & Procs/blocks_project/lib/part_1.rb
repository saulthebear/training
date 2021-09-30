def select_even_nums(arr)
  arr.select(&:even?)
end

def reject_puppies(dogs)
  dogs.reject { |dog| dog['age'] <= 2 }
end

def count_positive_subarrays(arr)
  arr.count { |subarray| subarray.sum.positive? }
end

def aba_translate(word)
  vowels = 'aeiou'
  new_word = ''
  word.each_char do |char|
    new_word += char
    new_word += "b#{char}" if vowels.include?(char)
  end
  new_word
end

def aba_array(words)
  words.map { |word| aba_translate(word) }
end
