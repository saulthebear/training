require 'byebug'

## Part 1: General problems

def no_dupes?(arr)
  ele_counts = Hash.new(0)

  arr.each { |ele| ele_counts[ele] += 1 }

  selected = []

  ele_counts.each { |ele, count| selected << ele if count == 1 }
  selected
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
  curr_streak_char = ''
  curr_streak_count = 0

  str.chars.each do |char|
    if curr_streak_char == ''
      curr_streak_char = char
      curr_streak_count = 1
    elsif curr_streak_char == char
      curr_streak_count += 1
    else
      curr_streak_char = char
      curr_streak_count = 1
    end

    if curr_streak_count >= long_streak.length
      long_streak = curr_streak_char * curr_streak_count
    end
  end
  long_streak
end

def prime?(num)
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
  def select(&prc) end

  def map!(&prc) end
end

## Part 3: Recursion Problems

def multiply(a, b) end

def lucas_sequence(length) end

def prime_factorization(num) end
