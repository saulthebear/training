# For simplicity, we'll consider an email valid when it satisfies all of the following:
# - contains exactly one @ symbol
# - contains only lowercase alphabetic letters before the @
# - contains exactly one . after the @

def is_valid_email(str)
  parts = str.split('@')
  puts 'input: ' + str
  print parts
  puts
  if parts.length != 2
    return false
  end
  
  if !lowercase?(parts[0])
    return false
  end

  num_of_periods = parts[1].split('.').length - 1
  puts 'number of periods: ' + num_of_periods.to_s

  if num_of_periods != 1
    return false
  end

  return true
end

def lowercase?(word)
  return word.downcase == word && word.match?([/[a-z]/])
end

puts is_valid_email("abc@xy.z")         # => true
puts
puts is_valid_email("jdoe@gmail.com")   # => true
puts
puts is_valid_email("jdoe@g@mail.com")  # => false
puts
puts is_valid_email("jdoe42@gmail.com") # => false
puts
puts is_valid_email("jdoegmail.com")    # => false
puts
puts is_valid_email("az@email")         # => false
puts
