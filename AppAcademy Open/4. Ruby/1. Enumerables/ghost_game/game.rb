require './player'

class Game
  def initialize(*player_names)
    @dictionary = File.read('dictionary.txt').split.to_set
    @fragment = ''
    @round_number = 1
    @losses = {}
    @players = []
    player_names.each do |player_name|
      player = Player.new(player_name)
      @players << player
      @losses[player] = 0
    end
  end

  def print_records
    @players.each { |player| puts "#{player.name}, you have '#{record(player)}'" }
  end

  def record(player)
    letters = ['G', 'H', 'O', 'S', 'T']
    losses = @losses[player]
    letters[0...losses].join
  end

  def play_round
    round_outcome = 0
    while round_outcome.zero?
      round_outcome = take_turn(current_player)
      next_player!
    end

    case round_outcome
    when 1
      puts "You lost, #{previous_player.name}! You spelled #{@fragment}."
      losers = @players.reject { |player| player == previous_player }
      @losses[previous_player] += 1
    when -1
      puts "Uh-Oh. No word starts with '#{@fragment}'! You lost, #{previous_player.name}. :("
      @losses[previous_player] += 1
    else
      puts "ERROR. round_outcome is #{round_outcome}"
    end

    reset_round
  end

  def reset_round
    @fragment = ''
  end

  def eliminate_player(player)
    @players.delete(player)
    @losses.delete(player)
  end

  def run
    until @players.length == 1
      until @losses.any? { |_, losses| losses == 5 }
        puts "\n==ROUND #{@round_number}=="
        puts 'Here are the standings, so far:'
        print_records
        puts "\n"
        play_round
        @round_number += 1
      end
      loser = @losses.select { |_, losses| losses == 5 }.keys[0]
      puts "\n==SET OVER=="
      puts "Sorry, #{loser.name}, you are a GHOST and have been eliminated!\n"
      puts "===============\n"
      eliminate_player(loser)
      @round_number = 1
    end
    puts "\n\n==GAME OVER=="
    puts "Congratulations, #{current_player.name}, you are the winner!"
  end

  def current_player
    @players[0]
  end

  def previous_player
    @players[-1]
  end

  def next_player!
    @players.rotate!
  end

  # @return [Integer] 1 if word was formed, -1 if no more words can be formed, 0 if play can continue
  def take_turn(player)
    instruction = "#{player.name}, add a letter to the fragment '#{@fragment}':"
    valid_play = false
    until valid_play
      guess = player.guess(instruction)
      if valid_play?(guess)
        valid_play = true
      else
        puts "Sorry, that wasn't a valid guess. Your guess must be 1 letter. Try again."
      end
    end

    @fragment += guess

    return 1 if word?(@fragment)

    return -1 unless valid_fragment?(@fragment)

    return 0
  end

  def valid_play?(string)
    string.match?(/[[:alpha:]]/) && string.length == 1
  end

  def valid_fragment?(fragment)
    @dictionary.each do |word|
      return true if word.start_with?(fragment)
    end
    false
  end

  def word?(fragment)
    @dictionary.include?(fragment)
  end
end
