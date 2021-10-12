class HumanPlayer

  def get_input
    gets.chomp
  end

  def get_position
    # prompt = "Please enter the position of the card you'd like to filp (e.g. '2,3')"
    get_input.delete(' ').split(',').map(&:to_i)
    # valid = false
    # until valid
    #   puts 
    #   position = gets.chomp.delete(' ').split(',').map(&:to_i)
    #   valid = valid_position?(position)
    #   puts 'That was an invalid guess. Please try again.' unless valid
    # end
    # position
  end

  def prompt(message)
    puts message
  end
  
end