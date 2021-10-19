class Stack
  def initialize
    @data = []
  end

  def push(el)
    @data << el
  end

  def pop
    @data.pop
  end

  def peek
    @data[-1]
  end
end
