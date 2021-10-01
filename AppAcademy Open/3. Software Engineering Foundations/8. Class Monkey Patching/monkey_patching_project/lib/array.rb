# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  def span
    return nil if self.empty?

    self.max - self.min
  end

  def average
    return nil if self.empty?

    self.sum / self.length.to_f
  end

  def median
    return nil if self.empty?

    sorted = self.sort
    if self.length.odd?
      middle_index = self.length / 2
      return sorted[middle_index]
    else
      middle_index_1 = self.length / 2
      middle_index_2 = middle_index_1 - 1
      return (sorted[middle_index_1] + sorted[middle_index_2]) / 2.0
    end
  end

  def counts
    sums = Hash.new(0)

    self.each { |ele| sums[ele] += 1 }
    sums
  end

  ## Part 2 ##

  def my_count(val)
    count = 0
    self.each { |ele| count += 1 if ele == val }
    count
  end

  def my_index(val)
    self.each.with_index { |ele, idx| return idx if ele == val }
    nil
  end

  def my_uniq
    unique = []
    self.each { |ele| unique << ele unless unique.include?(ele) }
    unique
  end

  def my_transpose
    transposed = []
    self.length.times do |i|
      row = []
      self.length.times do |j|
        row << self[j][i]
      end
      transposed << row
    end
    transposed
  end
end
