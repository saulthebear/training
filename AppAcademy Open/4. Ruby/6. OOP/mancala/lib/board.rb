class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player1 = name1
    @player2 = name2
    @cups = Array.new(14) { [] }
    place_stones
  end

  def valid_move?(start_pos)
    valid_start_indices = normal_cups
    raise 'Invalid starting cup' unless valid_start_indices.include?(start_pos)
    raise 'Starting cup is empty' if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    picked_up_stones = pickup_stones(start_pos)
    curr_index = increment_index(start_pos)
    until picked_up_stones.empty?
      if normal_cups.include?(curr_index) || curr_index == player_store_index(current_player_name)
        @cups[curr_index] << picked_up_stones.pop
      end
      curr_index = increment_index(curr_index)
    end
    render
    next_turn(increment_index(curr_index, -1), current_player_name)
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    side_one_empty = side_one_cups.map { |i| @cups[i] }.all?(&:empty?)
    side_two_empty = side_two_cups.map { |i| @cups[i] }.all?(&:empty?)
    side_one_empty || side_two_empty
  end

  def winner
    return :draw if player1_score == player2_score
    return @player1 if player1_score > player2_score

    @player2
  end

  private

  def place_stones
    13.times do |cup_index|
      @cups[cup_index] = Array.new(4) { :stone } unless cup_index == 6
    end
  end

  def normal_cups
    side_one_cups + side_two_cups
  end

  def side_one_cups
    (0..5).to_a
  end

  def side_two_cups
    (7..12).to_a
  end

  def pickup_stones(index)
    picked_up_stones = @cups[index]
    @cups[index] = []
    picked_up_stones
  end

  def player_store_index(name)
    return 6 if name == @player1

    13
  end

  def increment_index(index, times = 1)
    (index + times) % 14
  end

  # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  def next_turn(ending_cup_idx, current_player_name)
    return :prompt if ending_cup_idx == player_store_index(current_player_name)
    return :switch if @cups[ending_cup_idx].length == 1

    ending_cup_idx
  end

  def player1_score
    @cups[6].length
  end

  def player2_score
    @cups[13].length
  end
end
