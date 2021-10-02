class Code
  attr_reader :pegs

  POSSIBLE_PEGS = {
    'R' => :red,
    'G' => :green,
    'B' => :blue,
    'Y' => :yellow
  }.freeze

  def self.valid_pegs?(chars)
    chars.all? { |char| POSSIBLE_PEGS.key?(char.upcase) }
  end

  def self.random(length)
    pegs = []
    length.times { pegs << POSSIBLE_PEGS.keys.sample }
    Code.new(pegs)
  end

  def self.from_string(str)
    Code.new(str.split(''))
  end

  def initialize(pegs)
    raise ArgumentError.new('Invalid Pegs') unless Code.valid_pegs?(pegs)
    @pegs = pegs.map(&:upcase)
  end

  def [](idx)
    @pegs[idx]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    correct_count = 0
    guess.pegs.each.with_index { |peg, idx| correct_count += 1 if @pegs[idx] == peg }
    correct_count
  end

  def num_near_matches(guess)
    near_count = 0

    # Clone secret & guess then remove exact matches
    secret_pegs = @pegs.clone
    guess_pegs = guess.pegs.clone
    guess.pegs.each.with_index do |peg, idx|
      # debugger
      if secret_pegs[idx] == peg
        secret_pegs[idx] = '.' 
        guess_pegs[idx] = '.'
      end
    end

    guess_pegs.each.with_index do |peg, idx|
      next if peg == '.'
      secret_idx = secret_pegs.index(peg)
      if secret_idx
        near_count += 1
        secret_pegs.delete_at(secret_idx)
      end
    end
    near_count
  end

  def ==(other)
    other.pegs == @pegs
  end

end
