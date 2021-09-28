def hipsterfy(word)
  vowels = "aeiou"
  idx = word.length - 1
  while idx >= 0
    if vowels.include?(word[idx])
      word.slice!(idx)
      return word
    end
    idx -= 1
  end
  return word
end

def vowel_counts(str)
  counts = {'a' => 0, 'e' => 0, 'i' => 0, 'o' => 0, 'u' => 0}
  str.each_char do |char|
    counts[char.downcase] += 1 if counts.has_key?(char.downcase)
  end
  counts
end

def caesar_cipher(message, n)
  message.each_char.with_index do |char, idx|
    next unless isConvertable(char)

    message[idx] = cycleChar(char, n)
  end
  message
end

def isConvertable(char)
  char.ord >= 97 && char.ord <= 122
end

def cycleChar(char, n)
  n -= 26 while n >= 26

  ascii = char.ord
  new_ascii = ascii + n
  new_ascii -= 26 if new_ascii > 122
  new_ascii.chr
end
