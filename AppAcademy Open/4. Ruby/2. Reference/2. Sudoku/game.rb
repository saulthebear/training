require_relative 'board'
require_relative 'player'

class Game
  def initialize(file_path)
    @player = Player.new
    @board = Board.from_file(file_path)
  end

  def play
    until game_over?
      render
      play_move
    end
    render
    puts "=== PUZZLE SOLVED ==="
  end

  def play_move
    position_to_edit = player_position_input
    new_value = player_value_input
    @board[position_to_edit] = new_value
  end

  def render
    system('clear')
    @board.render
  end

  def game_over?
    @board.solved?
  end

  def player_position_input
    valid = false
    until valid
      @player.prompt("Please enter the position you'd like to edit in the form `row,col` (e.g. '2,3')")
      position = @player.get_position
      valid = valid_position?(position)
      @player.prompt('That was an invalid position. Please try again.') unless valid
    end
    position
  end

  def player_value_input
    valid = false
    until valid
      @player.prompt('Please enter a new value:')
      value = @player.get_value
      valid = valid_value?(value)
      @player.prompt('That was invalide. Please enter a number between 0 and 9.') unless valid
    end

    value
  end

  def valid_position?(position)
    return false unless position.is_a?(Position)
    return false unless position.valid?(8)
    return false unless @board.editable?(position)

    true
  end

  def valid_value?(value)
    return false unless value.is_a?(Integer)
    return false unless (0..9).cover?(value)

    true
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new('./puzzles/sudoku1.txt')
  game.play
end
