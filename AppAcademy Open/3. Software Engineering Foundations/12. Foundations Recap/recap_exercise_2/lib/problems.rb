# Write a method, least_common_multiple, that takes in two numbers and returns the smallest number that is a mutiple
# of both of the given numbers
def greatest_common_factor(num1, num2)
    idx = [num1, num2].min
    while idx > 0
        return idx if (num1 % idx).zero? && (num2 % idx).zero?

        idx -= 1
    end
end

def least_common_multiple(num_1, num_2)
    return (num_1 * num_2) / greatest_common_factor(num_1, num_2)
end


# Write a method, most_frequent_bigram, that takes in a string and returns the two adjacent letters that appear the
# most in the string.
def most_frequent_bigram(str)
    bigram_counts = Hash.new(0)

    (0...str.length - 1).each do |idx|
        bigram = str[idx] + str[idx + 1]
        bigram_counts[bigram] += 1
    end
    max_count = 0
    max_bigram = ''
    bigram_counts.each do |curr_bigram, count|
        if count > max_count
            max_bigram = curr_bigram
            max_count = count
        end
    end

    max_bigram
end


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        new_hash = {}
        self.each { |old_key, old_val| new_hash[old_val] = old_key}
        new_hash
    end
end


class Array
    # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
    def pair_sum_count(target)
        count = 0

        (0...self.length).each do |idx1|
            (idx1...self.length).each do |idx2|
                count += 1 if self[idx1] + self[idx2] == target
            end
        end
        count
    end

    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    #
    # Sorting algorithms like bubble_sort, commonly accept a block. That block accepts
    # two parameters, which represents the two elements in the array being compared.
    # If the block returns 1, it means that the second element passed to the block
    # should go before the first (i.e. switch the elements). If the block returns -1,
    # it means the first element passed to the block should go before the second
    # (i.e. do not switch them). If the block returns 0 it implies that
    # it does not matter which element goes first (i.e. do nothing).
    #
    # This should remind you of the spaceship operator! Convenient :)
    def bubble_sort(&prc)

        prc ||= proc { |a, b| a <=> b }

        sorted = false
        while !sorted
            sorted = true
            (0...self.length - 1).each do |idx|
                a = self[idx]
                b = self[idx + 1]
                if prc.call(a, b) == 1
                    sorted = false
                    self[idx], self[idx + 1] = self[idx + 1], self[idx]
                end
            end
        end
        self
    end
end
