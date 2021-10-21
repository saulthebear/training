# Implement a map using a 2D array
class Map
  def initialize
    @data = []
  end

  def set(key, value)
    existing_index = index(key)
    if existing_index
      @data[existing_index][1] = value
    else
      @data << [key, value]
    end
  end

  def include?(key)
    @data.any? { |k, _| k == key }
  end

  def index(target_key)
    @data.each_with_index do |pair, index|
      key, = pair
      return index if key == target_key
    end
    nil
  end

  def get(key)
    return nil unless include?(key)

    @data[index(key)][1]
  end

  def delete(key)
    return unless include?(key)

    target_index = index(key)
    @data.delete_at(target_index)
  end

  def show
    data_strings = @data.map { |key, val| "#{key}=>#{val}" }.join(', ')
    puts "{#{data_strings}}"
  end
end
