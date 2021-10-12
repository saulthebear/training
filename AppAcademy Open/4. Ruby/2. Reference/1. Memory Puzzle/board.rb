require_relative './card'

class Board

  def initialize(size = 4)
    @size = size
    @grid = Array.new(size) { Array.new(size) }
    populate
  end

  def place_card(card)
    return false if grid_full?

    loop do
      position = [rand(0...@size), rand(0...@size)]
      unless self[position]
        self[position] = card
        return true
      end
    end
  end

  def grid_full?
    @grid.all? do |row|
      row.none?(&:nil?)
    end
  end

  def populate
    num_pairs = (@size**2) / 2
    num_pairs.times do
      card1, card2 = Card.random_matching_pair
      place_card(card1)
      place_card(card2)
    end
  end

  def render
    index_row_str = '  '
    @size.times { |i| index_row_str += "#{i} " }
    puts index_row_str

    @grid.each_with_index do |row, index|
      row_str = "#{index} "
      row.each do |card|
        row_str += "#{card.display} "
      end
      puts row_str
    end
    nil
  end

  def won?
    @grid.all? { |row| row.all?(&:revealed?) }
  end

  def reveal(position)
    self[position].reveal
  end

  def hide(position)
    self[position].hide
  end

  def [](position)
    row, col = position
    @grid[row][col]
  end

  def []=(position, card)
    row, col = position
    @grid[row][col] = card
  end
end
