class Board
  attr_reader :size

  def self.print_grid(grid)
    grid.each { |row| puts row.join(' ') }
  end

  def initialize(width)
    @size = width * width
    @grid = Array.new(width) { Array.new(width, :N) }
  end

  def [](position)
    row, col = position
    @grid[row][col]
  end

  def []=(position, value)
    row, col = position
    @grid[row][col] = value
  end

  def num_ships
    @grid.flatten.count { |val| val == :S }
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
    total_ships = @size / 4
    while num_ships < total_ships
      row = rand(0...@grid.length)
      col = rand(0...@grid.length)
      self[[row, col]] = :S
    end
  end

  def hidden_ships_grid
    @grid.map do |row|
      row.map { |ele| ele == :S ? :N : ele }
    end
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(hidden_ships_grid)
  end
end
