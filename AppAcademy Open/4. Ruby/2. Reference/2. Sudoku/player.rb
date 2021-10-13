require_relative 'position'

class Player
  def get_input
    gets.chomp
  end

  def get_position
    row, col = get_input.delete(' ').split(',').map(&:to_i)
    position = nil
    begin
      position = Position.new(row, col)
    rescue ArgumentError => e
      puts e.message
    end
    position
  end

  def prompt(message)
    puts message
  end

  def get_value
    get_input.delete(' ').to_i
  end
end
