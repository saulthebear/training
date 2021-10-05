## Part 1: General problems

def no_dupes?(arr)
  ele_counts = Hash.new(0)

  arr.each { |ele| ele_counts[ele] += 1 }

  ele_counts.keys.select { |el| ele_counts[el] == 1 }
end

def no_consecutive_repeats?(arr)
  (0...arr.length).each do |idx1|
    idx2 = idx1 + 1
    return false if arr[idx1] == arr[idx2]
  end
  true
end

def char_indices(str)
  indices = Hash.new { |hash, key| hash[key] = [] }
  str.chars.each.with_index { |char, idx| indices[char] << idx }
  indices
end

def longest_streak(str)
  long_streak = ''
  curr_streak = ''

  (0...str.length).each do |idx|
    if str[idx] == str[idx - 1] || idx.zero?
      curr_streak += str[idx]
    else
      curr_streak = str[idx]
    end

    long_streak = curr_streak if curr_streak.length >= long_streak.length
  end
  long_streak
end

def prime?(num)
  return false if num < 2

  (2...num).each do |f|
    return false if (num % f).zero?
  end
  true
end

def list_primes(max)
  (2..max).to_a.select { |n| prime?(n) }
end

def bi_prime?(num)
  half = (num / 2.0).ceil
  primes = list_primes(half)

  (0...primes.length).each do |idx1|
    (idx1...primes.length).each do |idx2|
      pair_product = primes[idx1] * primes[idx2]
      return true if pair_product == num
    end
  end

  false
end

def caesar_cipher(message, offset)
  alpha = ('a'..'z').to_a
  cipher_arr = []

  message.chars.each do |char|
    new_char_idx = (alpha.index(char) + offset) % 26
    cipher_arr << alpha[new_char_idx]
  end
  cipher_arr.join
end

def vigenere_cipher(message, keys)
  cipher_arr = []
  message.chars.each.with_index do |char, idx|
    key_to_use = keys[idx % keys.length]
    cipher_arr << caesar_cipher(char, key_to_use)
  end
  cipher_arr.join
end

def vowel_rotate(str)
  vowels = 'aeiou'
  new_str = ''
  str.chars.each.with_index do |char, idx|
    if vowels.include?(char)
      idx2 = idx - 1
      prev_vowel_found = false
      until prev_vowel_found
        if vowels.include?(str[idx2])
          new_str += str[idx2]
          prev_vowel_found = true
        else
          idx2 -= 1
        end
      end
    else
      new_str += char
    end
  end
  new_str
end

## Part 2: Proc Problems

class String
  def select(&prc)
    return '' unless prc

    new_str = ''
    self.chars.each { |char| new_str += char if prc.call(char) }
    new_str
  end

  def map!(&prc)
    self.chars.each.with_index { |c, i| self[i] = prc.call(c, i) }
  end
end

## Part 3: Recursion Problems

def multiply(a, b)
  return a if b == 1

  return -(a + multiply(a, -b - 1)) if b.negative?

  a + multiply(a, b - 1)
end

def lucas_sequence(length)
  return [] if length.zero?
  return [2] if length == 1
  return [2, 1] if length == 2

  sequence = lucas_sequence(length - 1)
  sequence << (prev[-1] + prev[-2])
  sequence
end

def prime_factorization(num)
  return [num] if prime?(num)

  found = false
  lowest_prime_factor = 2

  until found
    if prime?(lowest_prime_factor) && (num % lowest_prime_factor).zero?
      found = true
    else
      lowest_prime_factor += 1
    end
  end

  return prime_factorization(num / lowest_prime_factor).unshift(lowest_prime_factor)
end
