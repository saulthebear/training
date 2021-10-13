require_relative './position'

class ComputerPlayer

  def initialize(board_size)
    @board_size = board_size
    @guess_number = 0

    @known_cards = Hash.new { [] } # known_cards[card_calue] => [position1, position2]
    @known_positions = {} # known_positions[position] => card_value
    @matched_cards = {}
    @previous_value = nil
    @previous_position = nil
  end

  def prompt(message) end

  def get_position
    guessed_position =  if @guess_number.zero?
                          first_guess
                        else
                          second_guess
                        end
    @guess_number = (@guess_number + 1) % 2
    guessed_position
  end

  def random_new_location
    loop do
      position = Position.new(rand(0...@board_size), rand(0...@board_size))
      return position unless @known_positions.key?(position)
    end
  end

  def receive_revealed_card(position, value)
    @previous_position = position
    @previous_value = value

    @known_cards[value] = (@known_cards[value] << position).uniq
    @known_positions[position] = value
  end

  def receive_match(position1, position2)
    val = @known_positions[position1]
    @known_cards[val].delete(position1)
    @known_cards[val].delete(position2)
  end

  def find_pair_locations
    @known_cards.values.select { |positions| positions.length == 2 }.first
  end

  def first_guess
    puts "in first guess"
    pair_locations = find_pair_locations
    if pair_locations
      pair_locations[0]
    else
      random_new_location
    end
  end

  def second_guess
    puts 'in second guess'
    match_previous || random_new_location
  end

  def match_previous
    return nil unless @known_cards[@previous_value].length == 2

    @known_cards[@previous_value]
      .reject { |pos| pos == @previous_position }
      .first
  end
end
