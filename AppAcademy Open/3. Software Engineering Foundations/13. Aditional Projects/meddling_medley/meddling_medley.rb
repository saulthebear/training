VOWELS = 'aeiou'.freeze

def vowel?(char)
  vowels = 'aeiou'
  vowels.include?(char)
end

def vowel_indices(word)
  vowels = 'aeiou'
  indices = []
  word.chars.each.with_index do |char, idx|
    indices << idx if vowel?(char)
  end
  indices
end

def find_first_vowel_index(word)
  vowel_indices(word)[0]
end

def find_last_vowel_index(word)
  vowel_indices(word)[-1]
end

## Phase 1: Modest Problems
def duos(str)
  count = 0
  (0...str.length - 1).each do |idx|
    count += 1 if str[idx] == str[idx + 1]
  end
  count
end

puts "--------------"
puts "duos"
puts "--------------"
p duos('bootcamp')      # 1
p duos('wxxyzz')        # 2
p duos('hoooraay')      # 3
p duos('dinosaurs')     # 0
p duos('e')             # 0

def sentence_swap(sentence, word_map)
  sentence
    .split
    .map do |word|
      if word_map.key?(word)
        word_map[word]
      else
        word
      end
    end
    .join(' ')
end

puts "--------------"
puts "sentence_swap"
puts "--------------"
p sentence_swap('anything you can do I can do',
  'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
) # 'nothing you shall drink I shall drink'

p sentence_swap('what a sad ad',
  'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
) # 'make a happy ad'

p sentence_swap('keep coding okay',
  'coding'=>'running', 'kay'=>'pen'
) # 'keep running okay'

def hash_mapped(hash, value_changer, &key_changer)
  mapped_hash = {}
  hash.each do |key, val|
    new_key = key_changer.call(key)
    new_val = value_changer.call(val)
    mapped_hash[new_key] = new_val
  end
  mapped_hash
end

puts "--------------"
puts "hash_mapped"
puts "--------------"
double = Proc.new { |n| n * 2 }
p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# {"A!!"=>8, "X!!"=>14, "C!!"=>-6}

first = Proc.new { |a| a[0] }
p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# {25=>"q", 36=>"w"}

def counted_characters(string)
  counts = Hash.new(0)
  string.chars.each { |c| counts[c] += 1 }
  counts.keys.select { |k| counts[k] > 2 }
end

puts "--------------"
puts "counted_characters"
puts "--------------"
p counted_characters("that's alright folks") # ["t"]
p counted_characters("mississippi") # ["i", "s"]
p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
p counted_characters("runtime") # []

def triplet_true?(str)
  (0...str.length - 2).each do |idx|
    return true if [str[idx], str[idx + 1], str[idx + 2]].uniq.length == 1
  end
  false
end

puts "--------------"
puts "triplet_true"
puts "--------------"
p triplet_true?('caaabb')        # true
p triplet_true?('terrrrrible')   # true
p triplet_true?('runninggg')     # true
p triplet_true?('bootcamp')      # false
p triplet_true?('e')             # false

def energetic_encoding(str, char_map)
  str
    .chars
    .map do |c|
      if c == ' '
        ' '
      elsif char_map.key?(c)
        char_map[c]
      else
        '?'
      end
    end
    .join
end

puts "--------------"
puts "energetic_encoding"
puts "--------------"
p energetic_encoding('sent sea',
  'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
) # 'zimp ziu'

p energetic_encoding('cat',
  'a'=>'o', 'c'=>'k'
) # 'ko?'

p energetic_encoding('hello world',
  'o'=>'i', 'l'=>'r', 'e'=>'a'
) # '?arri ?i?r?'

p energetic_encoding('bike', {}) # '????'

def uncompress(str)
  uncompressed = ''
  idx = 0
  while idx < str.length - 1
    char = str[idx]
    count = str[idx + 1].to_i
    uncompressed += char * count
    idx += 2
  end
  uncompressed
end

puts "--------------"
puts "uncompress"
puts "--------------"
p uncompress('a2b4c1') # 'aabbbbc'
p uncompress('b1o2t1') # 'boot'
p uncompress('x3y1x2z4') # 'xxxyxxzzzz'

## Phase 2: More difficult, maybe?
def conjunct_select(arr, *prcs)
  arr.select do |ele|
    prcs.all? { |prc| prc.call(ele) }
  end
end

puts "--------------"
puts "conjunct_select"
puts "--------------"
is_positive = Proc.new { |n| n > 0 }
is_odd = Proc.new { |n| n.odd? }
less_than_ten = Proc.new { |n| n < 10 }

p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]

def pig_latin_vowel_word(word)
  "#{word}yay"
end

def pig_latin_consonant_word(word)
  first_vowel_idx = find_first_vowel_index(word)
  "#{word[first_vowel_idx..-1]}#{word[0...first_vowel_idx]}ay" if first_vowel_idx
end

def convert_pig_latin(sentence)
  sentence
    .split
    .map do |word|
      if word.length >= 3
        if vowel?(word[0])
          pig_latin_vowel_word(word)
        else
          pig_latin_consonant_word(word)
        end
      else
        word
      end
    end
    .join(' ')
end

puts "--------------"
puts "convert_pig_latin"
puts "--------------"
p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"

def reverb_vowel_end(word)
  "#{word}#{word}"
end

def reverb_consonant_end(word)
  last_vowel_idx = find_last_vowel_index(word)
  "#{word}#{word[last_vowel_idx..-1]}"
end

def reverberate(sentence)
  sentence
    .split
    .map do |word|
      if word.length >= 3
        if vowel?(word[-1])
          reverb_vowel_end(word)
        else
          reverb_consonant_end(word)
        end
      else
        word
      end
    end
    .join(' ')
end

puts "--------------"
puts "reverberate"
puts "--------------"
p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"

def disjunct_select(arr, *prcs)
  arr.select do |ele|
    prcs.any? { |prc| prc.call(ele) }
  end
end

puts "--------------"
puts "disjunct_select"
puts "--------------"
longer_four = Proc.new { |s| s.length > 4 }
contains_o = Proc.new { |s| s.include?('o') }
starts_a = Proc.new { |s| s[0] == 'a' }

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
) # ["apple", "teeming"]

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
    contains_o
) # ["dog", "apple", "teeming", "boot"]

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
    contains_o,
    starts_a
) # ["ace", "dog", "apple", "teeming", "boot"]

def str_delete_at(str, idx)
  return str unless idx

  chars = str.chars
  chars.delete_at(idx)
  chars.join
end

def alternating_vowel(sentence)
  sentence
    .split
    .map.with_index do |word, idx|
      delete_at = if idx.even?
                    find_first_vowel_index(word)
                  else
                    find_last_vowel_index(word)
                  end
      str_delete_at(word, delete_at)
    end
    .join(' ')
end

puts "--------------"
puts "alternating_vowel"
puts "--------------"
p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
p alternating_vowel('code properly please') # "cde proprly plase"
p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"

def silly_vowel_word(word)
  return nil unless vowel?(word[-1])

  "#{word}#{word[-1]}"
end

def silly_consonant_word(word)
  word
    .chars
    .map do |char|
      if vowel?(char)
        "#{char}b#{char}"
      else
        char
      end
    end
    .join
end

def silly_talk(sentence)
  sentence
    .split
    .map do |word|
      if vowel?(word[-1])
        silly_vowel_word(word)
      else
        silly_consonant_word(word)
      end
    end
    .join(' ')
end

puts "--------------"
puts "silly_talk"
puts "--------------"
p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
p silly_talk('They can code') # "Thebey caban codee"
p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"

def compress_char(char, count)
  if count == 1
    char
  else
    "#{char}#{count}"
  end
end

def compress(str)
  return '' unless str.length > 0

  compressed = ''
  curr_char = str[0]
  curr_streak = 1

  (1...str.length).each do |idx|
    if curr_char == str[idx]
      curr_streak += 1
    else
      compressed += compress_char(curr_char, curr_streak)
      curr_char = str[idx]
      curr_streak = 1
    end
  end

  compressed + compress_char(curr_char, curr_streak)
end

puts "--------------"
puts "Compress"
puts "--------------"
p compress('aabbbbc')    # "a2b4c"
p compress('boot')       # "bo2t"
p compress('xxxyxxzzzz') # "x3yx2z4"
