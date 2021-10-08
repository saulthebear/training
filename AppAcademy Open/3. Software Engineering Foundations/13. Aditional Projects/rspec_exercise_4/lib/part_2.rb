def proper_factors(num)
  (1...num).select { |i| (num % i).zero?}
end

def aliquot_sum(num)
  proper_factors(num).sum
end

def perfect_number?(num)
  num == aliquot_sum(num)
end

def ideal_numbers(n)
  ideals = []
  i = 1
  while ideals.length < n
    ideals << i if perfect_number?(i)
    i += 1
  end
  ideals
end
