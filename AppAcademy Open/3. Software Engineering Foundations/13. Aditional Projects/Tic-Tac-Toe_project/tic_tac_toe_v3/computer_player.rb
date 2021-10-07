# Naive AI-player that plays random positions on the board
class ComputerPlayer
  attr_reader :mark
  
  def initialize(mark)
    @mark = mark
  end

  def get_position(legal_positions)
    pos = legal_positions.sample
    puts "Computer #{@mark} chose position #{pos}"
    pos
  end
end
