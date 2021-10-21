class Queue
  def initialize
    @data = []
  end

  def enqueue(el)
    @data << el
  end

  def dequeue
    @data.shift
  end

  def peek
    @data[0]
  end
end
