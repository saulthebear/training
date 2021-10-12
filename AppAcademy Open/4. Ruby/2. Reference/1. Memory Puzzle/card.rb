class Card
  VALUES = ('A'..'Z').to_a.freeze

  def self.random_matching_pair
    value = VALUES.sample
    [Card.new(value), Card.new(value)]
  end

  attr_reader :value

  def initialize(value)
    @value = value
    @revealed = false
  end

  # Returns the value when card is revealed, or ' ' when not revealed
  def display
    if @revealed
      @value
    else
      ' '
    end
  end

  def hide
    @revealed = false
  end

  def reveal
    @revealed = true
  end

  def revealed?
    @revealed
  end

  def ==(other)
    @value == other.value
  end
end
