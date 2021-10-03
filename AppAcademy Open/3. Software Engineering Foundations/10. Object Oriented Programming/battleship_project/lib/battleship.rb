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
    lose? || win?
  end

  def turn
    target = @player.get_move
    attack_success = @board.attack(target)
    @remaining_misses -= 1 unless attack_success
    @board.print
    puts "You have #{@remaining_misses} guesses remaining."
  end
end
