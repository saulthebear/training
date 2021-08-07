# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/caesar-cipher
# Write a method caesar_cipher that takes in a string and a number. The method should return a new string where every
# character of the original is shifted num characters in the alphabet.

# Feel free to use this variable:
# alphabet = "abcdefghijklmnopqrstuvwxyz"

def caesar_cipher(str, num)
  alphabet = "abcdefghijklmnopqrstuvwxyz"

  str_arr = str.split('')

  cipher_arr = str_arr.map do |char|
    input_idx = alphabet.index(char)
    output_idx = (input_idx + num) % 26
    alphabet[output_idx]
  end

  return cipher_arr.join('')
end

puts caesar_cipher("apple", 1)    #=> "bqqmf"
puts caesar_cipher("bootcamp", 2) #=> "dqqvecor"
puts caesar_cipher("zebra", 4)    #=> "difve"
