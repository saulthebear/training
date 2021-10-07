require './board'
require './human_player'

# The Game class will be the main class that houses the instances of Board and
# HumanPlayer required for gameplay. It will be responsible for passing data
# between the board and players. It will also serve to contain the main game loop.
class Game
  def initialize(size, *player_marks)
    @players = []
    player_marks.each { |p_mark| @players << HumanPlayer.new(p_mark) }
    @current_player = @players[0]
    @board = Board.new(size)
  end

  def switch_turn
    @current_player = @players.rotate![0]
  end

  def play
    while @board.empty_positions?
      @board.print
      pos = @current_player.get_position(@board.legal_positions)
      @board.place_mark(pos, @current_player.mark)
      if @board.win?(@current_player.mark)
        puts "== YOU WON, Player #{@current_player.mark}! =="
        @board.print
        return
      else
        switch_turn
      end
    end
    puts "== It's a DRAW =="
    @board.print
  end
end
