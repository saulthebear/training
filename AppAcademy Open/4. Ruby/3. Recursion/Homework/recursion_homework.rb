# Recursion Homework
# Stefan Vosloo - 14 October 2021

def sum_to(n)
  return nil if n.negative?
  return n if n.zero?

  n + sum_to(n - 1)
end

def add_numbers(nums_array)
  return nil if nums_array.empty?
  return nums_array.first if nums_array.length == 1

  nums_array.first + add_numbers(nums_array[1..-1])
end

def gamma_fnc(n)
  return nil if n < 1
  return 1 if n == 1

  (n - 1) * gamma_fnc(n - 1)
end

def ice_cream_shop(flavors, favorite)
  return true if flavors[0] == favorite
  return false if flavors.empty?

  ice_cream_shop(flavors[1..-1], favorite)
end

def reverse(string)
  return '' if string.length.zero?

  string[-1] + reverse(string[0..-2])
end

if __FILE__ == $PROGRAM_NAME
  puts '+++ sum_to(n) +++'
  p sum_to(5)
  p sum_to(1)
  p sum_to(9)
  p sum_to(-8)
  puts "+++++++++++++++++\n\n"

  puts '+++ add_numbers(nums_array) +++'
  p add_numbers([1, 2, 3, 4])
  p add_numbers([3])
  p add_numbers([-80, 34, 7])
  p add_numbers([])
  puts "+++++++++++++++++\n\n"

  puts '+++ gamma_fnc(n) +++'
  p gamma_fnc(0)
  p gamma_fnc(1)
  p gamma_fnc(4)
  p gamma_fnc(8)
  puts "+++++++++++++++++\n\n"

  puts '+++ ice_cream_shop(flavors, favorite) +++'
  p ice_cream_shop(['vanilla', 'strawberry'], 'blue moon')  # => returns false
  p ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea')  # => returns true
  p ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio')  # => returns false
  p ice_cream_shop(['moose tracks'], 'moose tracks')  # => returns true
  p ice_cream_shop([], 'honey lavender')  # => returns false
  puts "+++++++++++++++++\n\n"

  puts '+++ reverse(string) +++'
  p reverse("house") # => "esuoh"
  p reverse("dog") # => "god"
  p reverse("atom") # => "mota"
  p reverse("q") # => "q"
  p reverse("id") # => "di"
  p reverse("") # => ""
  puts "+++++++++++++++++\n\n"
end
