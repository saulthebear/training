class HumanPlayer

  def get_input
    gets.chomp
  end

  def get_position
    row, col = get_input.delete(' ').split(',').map(&:to_i)
    Position.new(row, col)
  end

  def prompt(message)
    puts message
  end
  
end