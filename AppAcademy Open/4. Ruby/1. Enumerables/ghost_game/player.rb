class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess(instruction)
    puts instruction
    gets.chomp.downcase
  end

  # def alert_invalid_guess(alert)
  #   guess(alert)
  # end
end
