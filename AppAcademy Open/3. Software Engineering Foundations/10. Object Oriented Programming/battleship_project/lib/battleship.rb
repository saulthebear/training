require_relative "board"
require_relative "player"

class Battleship
  attr_reader :board, :player

  def initialize(board_width)
    @player = Player.new
    @board = Board.new(board_width)
    @remaining_misses = @board.size / 2
  end

  def start_game
    @board.place_random_ships
    puts "There are #{@board.num_ships} ships remaining!"
    @board.print
  end

  def lose?
    return false if @remaining_misses.positive?

    puts 'you lose'
    true
  end

  def win?
    return false if @board.num_ships.positive?

    puts 'you win'
    true
  end

  def game_over?
    return lose? || win?
  end

  def turn
    @remaining_misses -= 1 unless @board.attack(@player.get_move)
    @board.print
    puts "You have #{@remaining_misses} guesses remaining."
  end
end
