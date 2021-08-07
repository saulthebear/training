# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/array-translate
# Write a method array_translate that takes in an array whose elements alternate between wordsand numbers. The method
# should return a string where each word is repeated the number of times that immediately follows in the array.

def array_translate(array)

  index = 0
  final_string = ''

  while index < array.length do
    array[index + 1].times do
      final_string += array[index]
    end
    index += 2
  end

  return final_string
end

print array_translate(["Cat", 2, "Dog", 3, "Mouse", 1]); # => "CatCatDogDogDogMouse"
puts

print array_translate(["red", 3, "blue", 1]); # => "redredredblue"
puts