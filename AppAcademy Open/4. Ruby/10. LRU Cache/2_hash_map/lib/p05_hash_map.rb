require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key, val)
    else
      resize! if @count == num_buckets
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    return nil unless include?(key)

    bucket(key).get(key)
  end

  def delete(key)
    return unless include?(key)

    bucket(key).remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |list|
      list.each { |node| prc.call(node.key, node.val) }
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_pairs = []
    each { |key, val| old_pairs << [key, val] }

    @store = Array.new(@count * 2) { LinkedList.new }

    old_pairs.each { |(key, val)| set(key, val) }
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
