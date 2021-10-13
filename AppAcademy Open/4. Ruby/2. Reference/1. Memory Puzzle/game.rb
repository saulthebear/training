require_relative './human_player'
require_relative './computer_player'
require_relative './board'
require_relative './card'
require_relative './position'

# Holds game loop for Memory Game
class Game
  def initialize(board_size = 4, player = HumanPlayer.new)
    @board_size = board_size
    @player = player
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
        @player.receive_match(current_guess, @previous_guess)
      else
        show_then_hide(@previous_guess, current_guess)
      end
      @previous_guess = nil
    else
      value = @board.reveal(current_guess)
      @player.receive_revealed_card(current_guess, value)
      @previous_guess = current_guess
    end
  end

  def show_then_hide(position1, position2)
    value = @board.reveal(position1)
    @player.receive_revealed_card(position1, value)
    value = @board.reveal(position2)
    @player.receive_revealed_card(position2, value)
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
      valid = valid_guess?(position)
      @player.prompt('That was an invalid guess. Please try again.') unless valid
    end
    position
  end

  def valid_guess?(position)
    return false unless position.is_a?(Position)
    return false unless position.valid?(@board_size - 1)
    # Has it been revealed already?
    return false if @board.revealed?(position)

    true
  end
end
