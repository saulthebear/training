class Array
  def two_sum
    sum_indices = []
    (0...(length - 1)).each do |index1|
      ((index1 + 1)..(length - 1)).each do |index2|
        sum_indices << [index1, index2] if (self[index1] + self[index2]).zero?
      end
    end
    sum_indices
  end
end
