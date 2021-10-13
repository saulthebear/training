require 'colorize'

class Tile

  attr_reader :value, :given

  def self.from_int(int)
    Tile.new(int, !int.zero?)
  end

  def initialize(value, given)
    @value = value
    @given = given
  end

  def to_s
    string = @value.to_s
    if @given
      string.colorize(:light_red)
    else
      string.colorize(:cyan)
    end
  end

  def ==(other)
    return true if other.is_a?(Tile) && other.value == @value
    return true if other.is_a?(Numeric) && other == @value

    false
  end

  def value=(other_value)
    raise 'Cannot change a given value!' if @given

    @value = other_value
  end
end
