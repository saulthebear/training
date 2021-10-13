require_relative 'tile'
require_relative 'position'

class Board
  attr_reader :grid # Debugging only

  def self.from_file(path)
    file = File.open(path)
    data = file.read
    rows = data.split
    grid = rows.map do |row_text|
      row_text.chars.map { |num_str| Tile.from_int(num_str.to_i) }
    end
    Board.new(grid)
  end

  def initialize(grid)
    @grid = grid
  end

  def render
    # Print column index numbers
    col_index_row = '   '
    9.times do |col|
      col_index_row += ' ' if (col % 3).zero?

      col_index_row += "#{col}  "
    end
    puts col_index_row
    @grid.each_with_index do |row, row_index|
      row_str = "#{row_index} | "
      row.each_with_index do |num, col_index|
        row_str +=  if ((col_index + 1) % 3).zero?
                      "#{num} | "
                    else
                      "#{num}  "
                    end
      end
      puts "  #{'-' * 31}" if (row_index % 3).zero?
      puts row_str
    end
    puts "  #{'-' * 31}"
  end

  def line_solved?(line)
    ((1..9).to_a - line.map(&:value)).empty?
  end

  def rows_solved?
    @grid.all? { |row| line_solved?(row) }
  end

  def cols_solved?
    @grid.transpose.all? { |col| line_solved?(col) }
  end

  def square_solved?(square)
    nums_not_found = (1..9).to_a
    square.each { |tile| nums_not_found.delete(tile.value) }
    nums_not_found.empty?
  end

  def squares_solved?
    squares.all? { |square| square_solved?(square) }
  end

  def squares
    squares = Array.new(9) { [] }
    9.times do |row_index|
      9.times do |col_index|
        squares[square_index(row_index, col_index)] << @grid[row_index][col_index]
      end
    end
    squares
  end

  def square_index(row_index, col_index)
    base =  if (0..2).cover? row_index
              0
            elsif (3..5).cover? row_index
              3
            else
              6
            end
    base + (col_index / 3)
  end

  def solved?
    rows_solved? && cols_solved? && squares_solved?
  end

  def [](position)
    @grid[position.row][position.col]
  end

  def []=(position, value)
    @grid[position.row][position.col].value = value
  end

  def editable?(position)
    !self[position].given
  end
end
