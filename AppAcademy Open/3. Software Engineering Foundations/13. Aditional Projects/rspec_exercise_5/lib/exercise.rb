def zip(*arrays)
  new_arr = []

  (0...arrays[0].length).each do |idx|
    row = []
    arrays.each do |array|
      row << array[idx]
    end
    new_arr << row
  end

  new_arr
end

def prizz_proc(arr, prc1, prc2)
  arr.select { |ele| prc1.call(ele) ^ prc2.call(ele) }
end

def zany_zip(*arrays)
  max_length = arrays.max { |a, b| a.length <=> b.length }.length
  new_arr = []
  (0...max_length).each do |idx|
    row = []
    arrays.each do |array|
      row << if idx >= array.length
               nil
             else
               array[idx]
             end
    end
    new_arr << row
  end

  new_arr
end

def maximum(arr, &prc)
  return nil if arr.empty?

  max_ele = nil
  max_val = nil
  arr.each do |ele|
    val = prc.call(ele)
    if max_val.nil? || val >= max_val
      max_ele = ele
      max_val = val
    end
  end
  max_ele
end

def my_group_by(arr, &prc)
  groups = Hash.new { |hash, key| hash[key] = [] }
  arr.each do |ele|
    groups[prc.call(ele)] << ele
  end
  groups
end

def max_tie_breaker(arr, prc_tiebreaker, &prc_evaluator )
  return nil if arr.empty?

  max_ele = nil
  max_val = nil
  tie = false

  # See if there is a tie
  arr.each do |ele|
    val = prc_evaluator.call(ele)
    val = prc_tiebreaker.call(ele) if val == max_val
    if max_val.nil? || val >= max_val
      max_ele = ele
      max_val = val
    end
  end
  max_ele
end

def silly_syllables(sentence)
  sentence.split
          .map { |word| silly_word(word) }
          .join(' ')
end

def silly_word(word)
  vowels = 'aeiou'
  first_vowel_idx = nil
  last_vowel_idx = nil

  word.chars.each.with_index do |char, idx|
    first_vowel_idx = idx if first_vowel_idx.nil? && vowels.include?(char)
    last_vowel_idx = idx if vowels.include?(char)
  end

  # Keep word if fewer than two vowels
  return word if last_vowel_idx == first_vowel_idx

  word[first_vowel_idx..last_vowel_idx]
end
