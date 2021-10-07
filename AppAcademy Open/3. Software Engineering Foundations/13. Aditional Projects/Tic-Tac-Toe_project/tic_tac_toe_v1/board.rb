# The Board class is responsible for adding a player's marks,
# checking for winners, and printing the game board. A board instance must have
# an attribute to represent the grid.
# This board has a 3x3 grid
class Board
  def initialize
    @board_width = 3
    @grid = []
    @board_width.times { @grid << Array.new(3) { '_' } }
  end

  def valid?(position)
    position.all? { |pos| pos >= 0 && pos < @board_width }
  end

  def empty?(position)
    @grid[position[0]][position[1]] == '_'
  end

  def place_mark(position, mark)
    raise "#{position} is an invalid position!" unless valid?(position)
    raise "#{position} is already occupied!" unless empty?(position)

    @grid[position[0]][position[1]] = mark
  end

  def print
    margin = ' ' * 2
    top_border = margin + ('*' * (@board_width * @board_width))
    puts top_border
    @grid.each do |row|
      row_str = ''
      row.each.with_index do |mark, idx|
        row_str +=  if idx.zero?
                      "#{margin}* #{mark} "
                    elsif idx == row.length - 1
                      "#{mark} *"
                    else
                      "#{mark} "
                    end
      end
      puts row_str
    end
    puts margin + ('* * ' * (@board_width - 1))
    puts top_border
  end

  def win_row?(mark)
    @grid.each do |row|
      return true if row.uniq == [mark]
    end
    false
  end

  def win_col?(mark)
    @grid.transpose.each do |row|
      return true if row.uniq == [mark]
    end
    false
  end

  def win_diagonal_one?(mark)
    # Test top-left to bottom-right
    row_idx = 0
    col_idx = 0
    while row_idx < @grid.length
      return false if @grid[row_idx][col_idx] != mark
      row_idx += 1
      col_idx += 1
    end
    true
  end

  def win_diagonal_two?(mark)
    # Test top-right to bottom-left
    row_idx = 0
    col_idx = @grid.length - 1
    while row_idx < @grid.length
      return false if @grid[row_idx][col_idx] != mark

      row_idx += 1
      col_idx -= 1
    end
    true
  end

  def win_diagonal?(mark)
    win_diagonal_one?(mark) || win_diagonal_two?(mark)
  end

  # @return [Boolean] is there at least one empty position on the board?
  def empty_positions?
    @grid.any? { |row| row.any? { |mark| mark == '_' } }
  end
end
