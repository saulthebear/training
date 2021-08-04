def anagrams?(word1, word2)
  return false if word1.length != word2.length

  word2_arr = word2.split('')

  word1.split('').each do |letter|
    index = word2_arr.index(letter)
    return false if index.nil?

    word2_arr.delete_at(index)
  end

  return true
end

puts anagrams?("cat", "act")          #=> true
puts anagrams?("restful", "fluster")  #=> true
puts anagrams?("cat", "dog")          #=> false
puts anagrams?("boot", "bootcamp")    #=> false
