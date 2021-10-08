# The HumanPlayer class is responsible for holding information about the user
# and prompting them to enter a position for gameplay.
class HumanPlayer
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  # prompt and allow the user to enter a valid row col position.
  def get_position(legal_positions)
    legal = false
    until legal
      puts "Player #{@mark}, enter two numbers representing a position in the format `row col`"
      pos = gets.chomp.split.map(&:to_i)
      legal = legal_positions.include?(pos)
      puts "Sorry, #{pos} is not a legal position! Try again." unless legal
    end
    pos
  end
end
