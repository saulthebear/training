# require 'byebug'
class Hanoi
  attr_reader :pegs

  def initialize
    @pegs = Array.new(3) { [] }
    @pegs[0] = [5, 4, 3, 2, 1]
  end

  def move(start_peg, end_peg)
    raise MoveError, 'That peg is empty! Nothing to move' if @pegs[start_peg].empty?

    unless @pegs[end_peg].empty?
      disk_to_move_size = @pegs[start_peg][-1]
      target_size = @pegs[end_peg][-1]
      err_msg = "#{disk_to_move_size} cannot fit ontop of #{target_size}"
      raise MoveError, err_msg if disk_to_move_size > target_size
    end
    disk = @pegs[start_peg].pop
    @pegs[end_peg] << disk

    render
  end

  def won?
    @pegs[1..2].any? { |peg| peg.length == 5 }
  end

  def render
    puts '-----'
    pegs_dup = []
    @pegs.each { |peg| pegs_dup << peg.dup }

    pegs_dup.each { |peg| peg << ' ' until peg.length == 5 }

    i = 4
    until i.negative?
      puts "#{pegs_dup[0][i]} #{pegs_dup[1][i]} #{pegs_dup[2][i]}"
      i -= 1
    end
  end
end

class MoveError < ArgumentError
end
