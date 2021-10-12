# Holds a grid position
class Position
  attr_reader :row, :col

  def initialize(row, col)
    raise 'Position values must be integers' unless row.is_a?(Integer) && col.is_a?(Integer)

    @row = row
    @col = col
  end

  def valid?(max = nil)
    return false if @row.nil? || @col.nil?
    # Are row & col in range
    unless max.nil?
      return false unless (0..max).cover?(@row)
      return false unless (0..max).cover?(@col)
    end

    true
  end
end
