# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/frequent-letters
# Write a method frequent_letters that takes in a string and returns an array containing the characters that appeared
# more than twice in the string.

def frequent_letters(string)
  char_count = Hash.new(0)
  selected_chars = []

  string.each_char { |char| char_count[char] += 1 }

  char_count.each { |key, val| selected_chars << key if val > 2 }

  return selected_chars
end

print frequent_letters('mississippi') #=> ["i", "s"]
puts
print frequent_letters('bootcamp') #=> []
puts
