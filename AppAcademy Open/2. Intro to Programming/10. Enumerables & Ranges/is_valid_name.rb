# Write a method is_valid_name that takes in a string and
# return sa boolean indicating whether or not it is a valid name.

# A name is valid is if satisfies all of the following:
# - contains at least a first name and last name, separated by spaces
# - each part of the name should be capitalized
#
# Hint: use str.upcase or str.downcase
# "a".upcase # => "A"

def is_valid_name(str)
  parts = str.split(' ')

  if parts.length < 2
    return false
  end

  valid = true
  parts.each do |part|
    first_letter = part[0]
    rest_of_name = part[1..-1]
    if first_letter != first_letter.upcase || rest_of_name != rest_of_name.downcase
      valid = false
    end
  end
  return valid
end

puts is_valid_name("Kush Patel")       # => true
puts is_valid_name("Daniel")           # => false
puts is_valid_name("Robert Downey Jr") # => true
puts is_valid_name("ROBERT DOWNEY JR") # => false
