def all_words_capitalized?(words)
  words.all? do |word|
    word == word.capitalize
    # true
  end
end

def no_valid_url?(urls)
  valid_endings = ['.com', '.net', '.io', '.org']
  urls.none? { |url| url.end_with?(*valid_endings) }
end

def any_passing_students?(students)
  students.any? { |student| (student[:grades].sum / student[:grades].length) >= 75 }
end
