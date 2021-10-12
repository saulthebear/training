class Card
  VALUES = ('A'..'Z').to_a.freeze

  def self.random_matching_pair
    value = VALUES.sample
    [Card.new(value), Card.new(value)]
  end

  # attr_reader :value

  def initialize(value)
    @value = value
    @shown = false
  end

  # Returns the value when card is shown, or empty string when not shown
  def display
    if @shown
      @value
    else
      ''
    end
  end

  def hide
    @shown = false
  end

  def reveal
    @shown = true
  end

  def revealed?
    @shown
  end

  def ==(other_card)
    @value == other_card.value
  end
end
