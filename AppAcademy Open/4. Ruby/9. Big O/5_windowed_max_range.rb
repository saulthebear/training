# O(n)
def windowed_max_range(array, window_size)
  current_max_range = nil
  queue = MinMaxStackQueue.new

  array.each do |ele|
    queue.dequeue if queue.size == window_size
    queue.enqueue(ele)

    range = queue.max - queue.min
    within_window = queue.size == window_size
    greater_than_current = current_max_range.nil? || range > current_max_range

    current_max_range = range if within_window && greater_than_current
  end

  current_max_range
end

# time: O(n^2)
def bad_windowed_max_range(array, window_size)
  current_max_range = nil

  i = 0
  while i + window_size <= array.length 
    range_end = i + window_size - 1
    slice = array[i..range_end]
    max = slice.max
    min = slice.min
    diff = max - min

    current_max_range = diff if current_max_range.nil?
    current_max_range = diff if diff > current_max_range
    
    i += 1
  end

  current_max_range
end

class MyQueue
  def initialize
    @store = []
    @max = nil
    @min = nil
  end

  def peek
    @store.first
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def enqueue(ele)
    @store << ele
  end

  def dequeue
    @store.shift
  end
end

class MyStack
  def initialize
    @store = []
  end

  def peek
    @store.last
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def pop
    @store.pop
  end

  def push(ele)
    @store << ele
  end
end

class MinMaxStack

  attr_reader :min, :max

  def initialize
    @store = []
    @max = nil
    @min = nil
  end

  def peek
    @store.last[0]
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def pop
    data = @store.pop
    ele, prev_max, prev_min = data

    @max = prev_max if ele == @max
    @min = prev_min if ele == @min

    ele
  end

  def push(ele)
    data = [ele, @max, @min]
    @max = ele if @max.nil? || @max < ele
    @min = ele if @min.nil? || @min > ele

    @store << data
  end
end

class StackQueue
  def initialize
    @entry = MyStack.new
    @exit = MyStack.new
  end

  def enqueue(ele)
    @entry.push(ele)
  end

  def dequeue
    fill_exit if @exit.empty?

    @exit.pop
  end

  def peek
    fill_exit if @exit.empty?

    @exit.peek
  end

  def size
    @entry.size + @exit.size
  end

  def empty?
    @entry.empty? && @exit.empty?
  end

  private

  def fill_exit
    @exit.push(@entry.pop) until @entry.empty?
  end
end

class MinMaxStackQueue
  def initialize
    @entry = MinMaxStack.new
    @exit = MinMaxStack.new
  end

  def fill_exit
    @exit.push(@entry.pop) until @entry.empty?
  end

  def enqueue(ele)
    @entry.push(ele)
  end

  def dequeue
    fill_exit if @exit.empty?

    @exit.pop
  end

  def peek
    fill_exit if @exit.empty?

    @exit.peek
  end

  def size
    @entry.size + @exit.size
  end

  def empty?
    @entry.empty? && @exit.empty?
  end

  def min
    return @exit.min if @entry.min.nil?
    return @entry.min if @exit.min.nil?
    return @entry.min if @entry.min < @exit.min

    @exit.min
  end

  def max
    return @exit.max if @entry.max.nil?
    return @entry.max if @exit.max.nil?
    return @entry.max if @entry.max > @exit.max

    @exit.max
  end
end

puts windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
puts windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
puts windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
puts windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
