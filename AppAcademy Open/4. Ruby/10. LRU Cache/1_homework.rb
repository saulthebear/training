# basic LRU Cache.
# This will be a simple implementation that doesn't use a hash-map or linked list. 
class LRUCache
  def initialize(size)
    @store = []
    @size = size
  end

  # returns number of elements currently in cache
  def count
    @store.size
  end

  # adds element to cache according to LRU principle
  def add(el)
    included = @store.include?(el)
    @store.shift if count == @size && !included
    @store.delete(el) if included

    @store << el
  end

  # shows the items in the cache, with the LRU item first
  def show
    print @store
  end
end
