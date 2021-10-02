class Board
  attr_reader :size

  def initialize(n)
    @size = n * n
    @grid = []
    n.times do
      row = []
      n.times { row << :N }
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

  
end
