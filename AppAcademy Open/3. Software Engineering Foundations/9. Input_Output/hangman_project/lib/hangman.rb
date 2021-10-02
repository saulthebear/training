class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = ['_'] * @secret_word.length
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    attempted_chars.include?(char)
  end

  def get_matching_indices(target_char)
    matching_indices = []
    @secret_word.each_char.with_index { |curr_char, idx| matching_indices << idx if curr_char == target_char }
    matching_indices
  end

  def fill_indices(char, indices)
    indices.each { |i| @guess_word[i] = char }
  end


  ## PART 2 ##

  def try_guess(guess)
    if self.already_attempted?(guess)
      puts 'that has already been attempted'
      return false
    end
    @attempted_chars << guess
    matching_indices = self.get_matching_indices(guess)
    if matching_indices.empty?
      @remaining_incorrect_guesses -= 1
    else
      self.fill_indices(guess, matching_indices)
    end
    
    true
  end

  def ask_user_for_guess
    puts 'Enter a char:'
    self.try_guess(gets.chomp)
  end

  def win?
    if @secret_word == @guess_word.join
      puts 'WIN'
      return true
    end
    false
  end

  def lose?
    if @remaining_incorrect_guesses.zero?
      puts 'LOSE'
      return true
    end
    false
  end

  def game_over?
    return false unless self.win? || self.lose?
    puts @secret_word
    return true
  end

end
