require './player'

class Game
  def initialize(*player_names)
    @dictionary = File.read('dictionary.txt').split.to_set
    @fragment = ''
    @players = []
    player_names.each { |player_name| @players << Player.new(player_name) }
  end

  def play_round
    game_status = 0
    while game_status.zero?
      game_status = take_turn(current_player)
      next_player!
    end

    case game_status
    when 1
      puts "You won, #{previous_player.name}! You spelled #{@fragment}"
    when -1
      puts "Uh-Oh. No word starts with '#{@fragment}'! You lost, #{previous_player.name}. :("
    else
      puts "ERROR. game_status is #{game_status}"
    end

    reset_round
  end

  def reset_round
    @fragment = ''
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
