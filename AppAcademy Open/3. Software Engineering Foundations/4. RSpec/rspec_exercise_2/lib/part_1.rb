def partition(arr, num)
  less = []
  more = []

  arr.each do |el|
    if el < num
      less << el
    else
      more << el
    end
  end

  return [less, more]
end

def merge(h1, h2)
  merged = h2.clone
  h1.each do |key, val|
    merged[key] = val unless merged.key?(key)
  end
  merged
end

def censor(message, bad_words)
  words = message.split(' ')
  new_message = []
  words.each do |word|
    if bad_words.include?(word.downcase)
      new_message << censor_vowels(word)
    else
      new_message << word
    end
  end
  new_message.join(' ')
end

def censor_vowels(word)
  vowels = 'aeiou'
  censored = ''
  word.each_char do |char|
    if vowels.include?(char.downcase)
      censored += '*'
    else
      censored += char
    end
  end
  censored
end

def power_of_two?(num)
  log = Math.log(num, 2)
  log.floor == log.ceil
end
