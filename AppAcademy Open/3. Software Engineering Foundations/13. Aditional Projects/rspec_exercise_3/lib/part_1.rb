def is_prime?(num)
  return false if num < 2

  (2...num).each do |f|
    return false if (num % f).zero?
  end
  true
end

def nth_prime(n)
  prime_count = 0
  factor = 1
  while prime_count < n
    factor += 1
    prime_count += 1 if is_prime?(factor)
  end
  factor
end

def prime_range(min, max)
  (min..max).to_a.select { |num| is_prime?(num) }
end
