class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    each_with_index.reduce(0) { |acc, (ele, idx)| acc ^ (ele.to_i + idx.hash).hash }
  end
end

class String
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = to_a.sort.flatten.map do |ele|
      if ele.is_a?(Symbol)
        ele.to_s.ord 
      elsif ele.is_a?(String)
        ele.ord
      end
    end

    arr.hash
  end
end
