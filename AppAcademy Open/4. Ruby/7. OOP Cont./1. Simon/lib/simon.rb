require 'colorize'

class Simon
  # COLORS = ['red'.red, 'blue'.blue, 'green'.green, 'yellow'.yellow].freeze
  COLORS = %w(red blue green yellow)
  COLOR_MAP = {
    'red' => 'red'.red,
    'blue' => 'blue'.light_blue,
    'green' => 'green'.green,
    'yellow' => 'yellow'.yellow
  }

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @seq = []
    @game_over = false
  end

  def play
    take_turn until @game_over

    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    user_seq = require_sequence
    @game_over = user_seq != @seq
    return if @game_over

    round_success_message
    @sequence_length += 1
  end

  def show_sequence
    add_random_color
    system('clear')
    colorized_seq = @seq.map { |str| COLOR_MAP[str] }
    colorized_seq.each do |color|
      print "#{color} "
      sleep(1)
    end
    system('clear')
  end

  def display_sleep_timer(seconds)
    reverse_seconds = (1..seconds).to_a.reverse
    print 'Seconds remaining:'
    seconds.times do |index|
      print " ... #{reverse_seconds[index]}"
      sleep(1)
    end
  end

  def require_sequence
    puts 'Enter the sequence (each word seperated by a space)'
    print '> '
    gets.chomp.split(' ')
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts 'Good job!'
    sleep(1)
  end

  def game_over_message
    puts "Oh no! That wasn't correct :("
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Simon.new
  game.play
end
