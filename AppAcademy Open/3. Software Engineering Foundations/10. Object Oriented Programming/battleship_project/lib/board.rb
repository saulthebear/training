require 'byebug'

class Board
  attr_reader :size

  def self.print_grid(grid)
    grid.each { |row| puts row.join(' ') }
  end

  def initialize(width)
    @size = width * width
    @grid = []
    width.times do
      row = []
      width.times { row << :N }
      @grid << row
    end
  end

  def [](position)
    @grid[position[0]][position[1]]
  end

  def []=(position, value)
    @grid[position[0]][position[1]] = value
  end

  def num_ships
    count = 0
    @grid.each do |row|
      count += row.each.count { |val| val == :S }
    end
    count
  end

  def attack(position)
    if self[position] == :S
      self[position] = :H
      puts 'you sunk my battleship!'
      return true
    else
      self[position] = :X
      return false
    end
  end

  def place_random_ships
    num_ships = @size / 4
    # { row_idx => [col_idx, col_idx ...] }
    positions_set = Hash.new { |hash, key| hash[key] = [] }
    num_ships.times do
      open_position_found = false
      row, col = nil
      until open_position_found
        row = rand(0...@grid.length)
        col = rand(0...@grid.length)
        open_position_found = !positions_set[row].include?(col)
      end
      positions_set[row] << col
      @grid[row][col] = :S
    end
  end

  def hidden_ships_grid
    hidden_grid = []
    @grid.each do |row|
      hidden_grid << row.map { |ele| ele == :S ? :N : ele }
    end
    hidden_grid
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(hidden_ships_grid)
  end
end
