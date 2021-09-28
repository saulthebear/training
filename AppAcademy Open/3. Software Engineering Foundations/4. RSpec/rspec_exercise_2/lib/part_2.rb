def palindrome?(string)
  idx = 0
  while idx < string.length / 2
    return false unless string[idx] == string[-(idx + 1)]

    idx += 1
    next
  end
  return true
end

def substrings(str)
  subs = []
  str.each_char.with_index do |char, idx|
    j = 1
    while j <= str.length - idx
      subs << str[idx, j]
      j += 1
    end
  end
  subs
end

def palindrome_substrings(str)
  substrings(str)
    .filter { |s| s.length > 1 }
    .filter { |s| palindrome?(s) }
end
