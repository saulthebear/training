require './board'
require './human_player'

# The Game class will be the main class that houses the instances of Board and
# HumanPlayer required for gameplay. It will be responsible for passing data
# between the board and players. It will also serve to contain the main game loop.
class Game
  def initialize(player1_mark, player2_mark)
    @player1 = HumanPlayer.new(player1_mark)
    @player2 = HumanPlayer.new(player2_mark)
    @current_player = @player1
    @board = Board.new
  end

  def switch_turn
    @current_player = if @current_player == @player1
                        @player2
                      else
                        @player1
                      end
  end

  def play
    while @board.empty_positions?
      @board.print
      pos = @current_player.get_position
      @board.place_mark(pos, @current_player.mark)
      if @board.win?(@current_player.mark)
        puts "== YOU WON, Player #{@current_player.mark}! =="
        return
      else
        switch_turn
      end
    end
    puts "== It's a DRAW =="
  end
end
