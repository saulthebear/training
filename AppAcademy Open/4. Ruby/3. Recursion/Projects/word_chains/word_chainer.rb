class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = dictionary_from_file(dictionary_file_name)
    
  end

  def dictionary_from_file(dictionary_file_name)
    file = File.open(dictionary_file_name)
    data = file.read
    words = data.split
    Set.new(words)
  end

  def adjacent_words(word)
    alpha = ('a'..'z').to_a
    all_adjacent_words = []
    word.chars.each_with_index do |char, index|
      new_words = []
      alpha.each do |new_letter|
        next if new_letter == char

        new_word = word.dup
        new_word[index] = new_letter
        new_words << new_word if in_dictionary?(new_word)
      end
      all_adjacent_words += new_words
    end
    all_adjacent_words
  end

  def in_dictionary?(word)
    @dictionary.include?(word)
  end

  def inspect
    "#<WordChainer: #{object_id} @dictionary.size: #{@dictionary.size}>"
  end
end
