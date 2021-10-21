require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    children = node.children
    winners = children.select { |child| child.winning_node?(mark) }

    return winners[0].prev_move_pos unless winners.empty?

    non_losers = children.reject { |child| child.losing_node?(mark) }
    raise 'Unable to find move' if non_losers.empty?

    non_losers[0].prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
