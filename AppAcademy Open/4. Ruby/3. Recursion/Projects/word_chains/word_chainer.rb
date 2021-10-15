class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = dictionary_from_file(dictionary_file_name)
    
  end

  def run(source, target)
    @current_words = [source].to_set
    @all_seen_words = { source => nil }

    until @current_words.empty?
      new_current_words = explore_current_words
      @current_words = new_current_words
    end
  end

  def explore_current_words
    new_current_words = [].to_set
    @current_words.each do |current_word|
      adjacent_to_current = adjacent_words(current_word)
      adjacent_to_current.each do |adjacent_word|
        unless @all_seen_words.include?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = current_word
        end
      end
    end
    print_origins_pretty(new_current_words)
    new_current_words
  end

  def print_origins(words)
    words.each do |word|
      origin = @all_seen_words[word]
      puts "#{origin} => #{word}"
    end
  end

  def print_origins_pretty(words)
    prev_origin = nil
    words.each do |word|
      origin = @all_seen_words[word]
      if origin == prev_origin
        blank_origin = ' ' * prev_origin.length
        puts "#{blank_origin} => #{word}"
      else
        puts "#{origin} => #{word}"
      end
      prev_origin = origin
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
