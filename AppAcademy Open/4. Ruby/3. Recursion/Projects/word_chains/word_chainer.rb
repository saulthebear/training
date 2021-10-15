class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = dictionary_from_file(dictionary_file_name)
    
  end

  def run(source, target)
    @current_words = [source].to_set
    @all_seen_words = [source].to_set

    until @current_words.empty?
      new_current_words = [].to_set
      @current_words.each do |current_word|
        adjacent_to_current = adjacent_words(current_word)
        adjacent_to_current.each do |adjacent_word|
          unless @all_seen_words.include?(adjacent_word)
            new_current_words << adjacent_word
            @all_seen_words << adjacent_word
          end
        end
      end
      puts new_current_words
      @current_words = new_current_words
    end
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
    all_adjacent_words.to_set
  end

  def in_dictionary?(word)
    @dictionary.include?(word)
  end

  def dictionary_from_file(dictionary_file_name)
    file = File.open(dictionary_file_name)
    data = file.read
    words = data.split
    Set.new(words)
  end

  def inspect
    "#<WordChainer: #{object_id} @dictionary.size: #{@dictionary.size}>"
  end
end
