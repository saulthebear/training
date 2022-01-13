class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
    @next = nil
    @prev = nil
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return nil if empty?

    @head.next
  end

  def last
    return nil if empty?

    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    return nil unless include?(key)

    get_node(key).val
  end

  def include?(key)
    get_node(key) != nil
  end

  def append(key, val)
    prev = @tail.prev
    new_node = Node.new(key, val)
    @tail.prev = new_node
    new_node.prev = prev
    new_node.next = @tail
    prev.next = new_node
    new_node
  end

  def update(key, val)
    return unless include?(key)

    get_node(key).val = val
  end

  def remove(key)
    node = get_node(key)
    return if node.nil?

    node.prev.next = node.next
    node.next.prev = node.prev
  end

  def each(&prc)
    node = @head.next
    until node == @tail
      prc.call(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private

  def get_node(key)
    each do |node|
      return node if node.key == key
    end
    nil
  end
end
