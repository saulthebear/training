require 'byebug'
class MaxIntSet

  attr_reader :store

  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise ArgumentError, 'Out of bounds' unless is_valid?(num)

    @store[num] = true
  end

  def remove(num)
    @store[num] = false if is_valid?(num)
  end

  def include?(num)
    return false unless is_valid?(num)

    @store[num]
  end

  private

  def is_valid?(num)
    num.positive? && num < @max
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return if include?(num)

    resize! if count == num_buckets
    self[num] << num 
    @count += 1
  end

  def remove(num)
    return unless include?(num)

    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    all_elements = @store.flatten
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0

    all_elements.each { |ele| insert(ele) }
  end
end
