# O(n!)
def first_anagram?(string1, string2)
  all_anagrams_of_string1 = string1.chars.permutation.map(&:join)
  all_anagrams_of_string1.include?(string2)
end

# O(n^2)
def second_anagram?(string1, string2)
  string2_arr = string2.chars
  string1.each_char do |char1|
    index = string2_arr.find_index(char1)
    return false unless index

    string2_arr.delete_at(index)
  end

  string2_arr.empty?
end

# O(n * log(n))
def third_anagram?(string1, string2)
  string1.chars.sort == string2.chars.sort
end

# O(n)
def fourth_anagram?(string1, string2)
  hash = Hash.new(0)

  string1.each_char do |char|
    hash[char] += 1
  end

  string2.each_char do |char|
    hash[char] -= 1
  end

  hash.values.all?(&:zero?)
end
