# The Board class is responsible for adding a player's marks,
# checking for winners, and printing the game board. A board instance must have
# an attribute to represent the grid.
# This board has a 3x3 grid
class Board
  EMPTY_MARK = '-'.freeze
  def initialize(n)
    raise 'Board size must be greater than 1' if n < 2

    @board_width = n
    @grid = []
    @board_width.times { @grid << Array.new(n) { EMPTY_MARK } }
  end

  # @return [Boolean] is the given position within bounds?
  def valid?(position)
    position.all? { |pos| pos >= 0 && pos < @board_width }
  end

  # @return [Boolean] is the given position not occupied by a mark?
  def empty?(position)
    @grid[position[0]][position[1]] == EMPTY_MARK
  end

  # Places a mark on the board
  # @param position [Array] where to place the mark. Format: [row, col]
  # @param mark [String] the mark to place
  def place_mark(position, mark)
    raise "#{position} is an invalid position!" unless valid?(position)
    raise "#{position} is already occupied!" unless empty?(position)

    @grid[position[0]][position[1]] = mark
  end

  # Prints the board
  def print
    margin = ' ' * 2
    top_border = "#{margin}* #{'* ' * @board_width}*"
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
    # puts margin + ('* * ' * (@board_width - 1))
    puts top_border
  end

  # Checks if the given mark occupies any entire row
  def win_row?(mark)
    @grid.each do |row|
      return true if row.uniq == [mark]
    end
    false
  end

  # Checks if the given mark occupies any entire column
  def win_col?(mark)
    @grid.transpose.each do |row|
      return true if row.uniq == [mark]
    end
    false
  end

  # Checks if the given mark occupies the diagonal from top-left to bottom-right
  def win_diagonal_one?(mark)
    row_idx = 0
    col_idx = 0
    while row_idx < @board_width
      return false if @grid[row_idx][col_idx] != mark
      row_idx += 1
      col_idx += 1
    end
    true
  end

  # Checks if the given mark occupies the diagonal from top-right to bottom-left
  def win_diagonal_two?(mark)
    row_idx = 0
    col_idx = @board_width - 1
    while row_idx < @board_width
      return false if @grid[row_idx][col_idx] != mark

      row_idx += 1
      col_idx -= 1
    end
    true
  end

  def win_diagonal?(mark)
    win_diagonal_one?(mark) || win_diagonal_two?(mark)
  end

  # Checks if a mark occupies all positions in a vertical, horizontal, or diagonal line
  # @param [String] Mark to check
  # @return [Boolean] Did this mark win?
  def win?(mark)
    win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
  end

  # @return [Boolean] is there at least one empty position on the board?
  def empty_positions?
    @grid.any? { |row| row.any? { |mark| mark == EMPTY_MARK } }
  end
end
