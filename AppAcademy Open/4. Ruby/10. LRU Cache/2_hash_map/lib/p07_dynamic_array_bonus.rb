class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i.abs > @count || i == @count

    i = @count + i if i.negative?
    @store[i]
  end

  def []=(i, val)
    
    if i.positive? && i > @count
      push(nil) until @count == i
      @store[i] = val
      @count += 1
      return
    end
    
    i = @count + i if i.negative?

    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    each { |ele| return true if ele == val }
    false
  end

  def push(val)
    resize! if @count == capacity

    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == capacity

    i = count - 1
    while i >= 0
      @store[i + 1] = @store[i]
      i -= 1
    end
    @store[0] = val
    @count += 1
    val
  end

  def pop
    return nil if @count == 0

    @count -= 1
    val = @store[@count]
    @store[@count] = nil
    val
  end

  def shift
    val = first
    if @count > 1
      i = 1
      while i < @count
        @store[i - 1] = @store[i]
        @store[i] = nil
        i += 1
      end
    else
      @store[0] = nil
    end
    @count -= 1
    val
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each(&prc)
    i = 0
    while i < @count
      prc.call(@store[i])
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    
    each_with_index { |ele, idx| return false unless ele == other[idx] }
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    old_array = @store

    @store = StaticArray.new(capacity * 2)

    i = 0
    while i < old_array.length
      @store[i] = old_array[i]
      i += 1
    end

    @store
  end
end
