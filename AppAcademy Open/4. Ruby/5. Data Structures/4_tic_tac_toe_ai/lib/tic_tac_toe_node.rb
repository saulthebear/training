require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      winner = @board.winner
      return false if winner == evaluator || winner.nil?

      return true
    end

    # If it is our turn
    if @next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      winner = @board.winner
      return true if winner == evaluator

      return false
    end

    # If it's our turn
    if @next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    possible_states = []
    (0...3).each do |row_index|
      (0...3).each do |col_index|
        pos = [row_index, col_index]
        next unless @board.empty?(pos)

        board_copy = @board.dup
        board_copy[pos] = @next_mover_mark
        possible_states << TicTacToeNode.new(board_copy, next_mark, pos)
      end
    end
    possible_states
  end

  def next_mark
    return :o if @next_mover_mark == :x

    :x
  end

end
