class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    selected_elements = []
    my_each do |ele|
      selected_elements << ele if prc.call(ele)
    end
    selected_elements
  end

  def my_reject(&prc)
    not_rejected_elements = []
    my_each do |ele|
      not_rejected_elements << ele unless prc.call(ele)
    end
    not_rejected_elements
  end

  def my_any?(&prc)
    my_each { |ele| return true if prc.call(ele) }
    false
  end

  def my_all?(&prc)
    my_each { |ele| return false unless prc.call(ele) }
    true
  end

  def my_flatten
    reduce([]) do |flattened, element|
      if element.is_a?(Array)
        flattened + element.my_flatten
      else
        flattened << element
      end
    end
  end

  def my_zip(*args)
    zipped = []
    length.times do |index|
      row = [self[index]]
      args.each { |array| row << array[index] }
      zipped << row
    end
    zipped
  end

  # # [1, 2, 3, 4]
  # # [2, 3, 4, 1]
  # def rotate_forward_once
  #   rotated = []
  #   (1...length).each do |index|
  #     rotated << self[index]
  #   end
  #   rotated << self[0]
  #   rotated
  # end

  # # [1, 2, 3, 4]
  # # [4, 1, 2, 3]
  # def rotate_backward_once
  #   without_last = self[0...-1]
  #   without_last.unshift(self[-1])
  # end

  # def my_rotate(iterations = 1)
  #   rotated = self
  #   if iterations.positive?
  #     iterations.times { rotated = rotated.rotate_forward_once }
  #   else
  #     iterations.abs.times { rotated = rotated.rotate_backward_once }
  #   end
  #   rotated
  # end

  def my_rotate(positions = 1)
    split_idx = positions % self.length

    self.drop(split_idx) + self.take(split_idx)
  end

  def my_join(seperator = '')
    str = ''
    each { |ele| str += "#{ele}#{seperator}" }
    # Remove last seperator
    final_length = str.length - seperator.length
    str[0, final_length]
  end

  # [1, 2, 3, 4]
  # [4, 3, 2, 1]
  def my_reverse
    reversed = []

    self.my_each do |el|
     reversed.unshift(el)
    end

    reversed
  end

  def bubble_sort!(&prc)
    sorted = false
    until sorted
      sorted = true
      (0...length - 1).each do |index|
        no_prc_and_should_swap = prc.nil? && self[index] > self[index + 1]
        prc_exists_and_should_swap = !prc.nil? && prc.call(self[index], self[index + 1]) == 1

        if no_prc_and_should_swap || prc_exists_and_should_swap
          sorted = false
          self[index], self[index + 1] = self[index + 1], self[index]
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    new_arr = self.clone
    sorted = false
    until sorted
      sorted = true
      (0...length - 1).each do |index|
        no_prc_and_should_swap = prc.nil? && new_arr[index] > new_arr[index + 1]
        prc_exists_and_should_swap = !prc.nil? && prc.call(new_arr[index], new_arr[index + 1]) == 1

        if no_prc_and_should_swap || prc_exists_and_should_swap
          sorted = false
          new_arr[index], new_arr[index + 1] = new_arr[index + 1], new_arr[index]
        end
      end
    end
    new_arr
  end
end

# Review

# factors(2) # [1, 2]
# factors(1) # [1]
# factors(3) # [1, 3]
# factors(24) # [1, 2, 3, 4, 6, 8, 12, 24]
def factors(num)
  factors = []
  (1..num).each do |candidate|
    if (num % candidate).zero?
      factors << candidate 
    end
  end
  factors
end

def substrings(string) end

def subwords(word, dictionary)
  words_found = []
  dictionary.each do |word_to_find|
    (0...word.length).each do |index|
      words_found << word_to_find if word[index, word_to_find.length] == word_to_find
    end
  end
  words_found.uniq
end


# def bubble_sort!(arr)
#   sorted = false
#   until sorted
#     sorted = true
#     (0...arr.length - 1).each do |index|
#       if arr[index] > arr[index + 1]
#         sorted = false
#         arr[index], arr[index + 1] = arr[index + 1], arr[index]
#       end
#     end
#   end
# end


