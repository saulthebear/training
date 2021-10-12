require_relative './human_player'
require_relative './board'
require_relative './card'

# Holds game loop for Memory Game
class Game
  def initialize
    @player = HumanPlayer.new
    @board_size = 4
    @board = Board.new(@board_size)
    @previous_guess = nil
  end

  def play
    until game_over?
      display_board
      guess_position = player_guess
      make_guess(guess_position)
    end
    display_board
    puts '==== You Won! ===='
  end

  def game_over?
    @board.won?
  end

  def make_guess(current_guess)
    if @previous_guess
      if @board[current_guess] == @board[@previous_guess]
        @board.reveal(current_guess)
      else
        show_then_hide(@previous_guess, current_guess)
      end
      @previous_guess = nil
    else
      @board.reveal(current_guess)
      @previous_guess = current_guess
    end
  end

  def show_then_hide(position1, position2)
    @board.reveal(position1)
    @board.reveal(position2)
    system('clear')
    display_board
    sleep(2)
    @board.hide(position1)
    @board.hide(position2)
    system('clear')
  end

  def display_board
    system('clear')
    @board.render
  end

  def player_guess
    
    valid = false
    until valid
      @player.prompt("Please enter the position of the card you'd like to filp (e.g. '2,3')")
      position = @player.get_position
      valid = valid_position?(position)
      @player.prompt('That was an invalid guess. Please try again.') unless valid
    end
    position
  end

  def valid_position?(position)
    return false unless position.length == 2
    return false unless position.all? { |pos| pos.is_a?(Integer) }
    # Is it in range?
    return false unless position.all? { |pos| (0...@board_size).cover?(pos) }
    # Has it been revealed already?
    return false if @board.revealed?(position)

    true
  end
end
