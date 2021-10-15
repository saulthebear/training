require 'byebug'

## Warmup

# Write a recursive method, range, that takes a start and an end and returns an
# array of all numbers in that range, exclusive. For example, range(1, 5) should
# return [1, 2, 3, 4]. If end < start, you can return an empty array.
def range(start_num, end_num)
  return [] if start_num >= end_num

  range(start_num, end_num - 1) + [end_num - 1]
end

# write both a recursive and iterative version of sum of an array.
def recursive_array_sum(nums_array)
  return nil if nums_array.empty?
  return nums_array.first if nums_array.length == 1

  nums_array.first + recursive_array_sum(nums_array[1..-1])
end

def iterative_array_sum(nums_array)
  return nil if nums_array.empty?

  index = 0
  sum = 0
  while index < nums_array.length
    sum += nums_array[index]
    index += 1
  end
  sum
end

## Exponentiation
# Write two versions of exponent that use two different recursions:
# this is math, not Ruby methods.
# # recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)
# # recursion 2
# exp(b, 0) = 1
# exp(b, 1) = b
# exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]

def exponentiation1(base, power)
  return 1 if power.zero?

  base * exponentiation1(base, power - 1)
end

def exponentiation2(base, power)
  return 1 if power.zero?
  return base if power == 1

  if power.even?
    base_to_half_power = exponentiation2(base, power / 2)
    base_to_half_power * base_to_half_power
  else
    base_to_half_lower_power = exponentiation2(base, (power - 1) / 2)
    base_to_half_lower_power_squared = base_to_half_lower_power * base_to_half_lower_power
    base * base_to_half_lower_power_squared
  end
end

## Deep dup of arrays
class Array
  def deep_dup
    return self.dup if self.none? { |ele| ele.is_a?(Array) }

    duplicated = []
    self.each do |ele|
      duplicated << if ele.is_a?(Array)
                      ele.deep_dup
                    else
                      duplicated << ele
                    end
    end
    duplicated
  end
end

## Fibonacci
# Write a recursive and an iterative Fibonacci method. The method should take in
# an integer n and return the first n Fibonacci numbers in an array.

# You shouldn't have to pass any arrays between methods; you should be able to 
# do this just passing a single argument for the number of Fibonacci numbers
# requested.

def fibonnaci_array_recursive(n)
  return [0] if n == 1
  return [0, 1] if n == 2

  smaller_fib = fibonnaci_array_recursive(n - 1)

  smaller_fib << (smaller_fib.last(2).sum) 
end

def fibonnaci_array_iterative(n)
  return [0] if n == 1

  series = [0, 1]
  series << series.last(2).sum while series.length < n
  series
end

## Binary Search
def bsearch(array, target)
  return nil if array.empty?

  middle_ele_index = (array.length / 2)
  middle_ele = array[middle_ele_index]

  return middle_ele_index if target == middle_ele

  if target > middle_ele
    start_of_right_half = middle_ele_index + 1
    right_half = array[start_of_right_half..-1]
    result = bsearch(right_half, target)
    return start_of_right_half + result if result
  else
    left_half = array[0...middle_ele_index]
    return bsearch(left_half, target)
  end
end

## Merge Sort
def merge(lesser_arr, greater_arr)
  merged = []
  until lesser_arr.empty? || greater_arr.empty?
    merged << if lesser_arr.first < greater_arr.first
                lesser_arr.shift
              else
                greater_arr.shift
              end
  end

  merged + lesser_arr + greater_arr
end

def merge_sort(array)
  return array if array.length == 1

  mid_index = array.length / 2
  left = array[0...mid_index]
  right = array[mid_index..-1]

  merge(merge_sort(left), merge_sort(right))
end

def subsets(array)
  return [[]] if array.empty?

  rest = array.dup[1..-1]
  first = array[0]

  subsetsOfRest = subsets(rest)

  subsetsOfRestWithFirst = []
  subsetsOfRest.each do |ele|
    subsetsOfRestWithFirst << ([first] + ele)
  end

  subsetsOfRest + subsetsOfRestWithFirst
end

def permutations(array)
  return [array] if array.length == 1

  all_perms = []

  (array.length).times do |index|
    # debugger
    rest = array[0...index] + array[(index + 1)..-1]
    rest_permutations = permutations(rest)
    rest_permutations.each do |perm|
      all_perms << (perm + [array[index]])
    end
  end

  all_perms
end

def greedy_make_change(amount, coins = [25, 10, 5, 1])
  first_coin = coins.shift

  return [] + greedy_make_change(amount, coins) if first_coin > amount

  number_of_coin = amount / first_coin
  coins_of_this_type = Array.new(number_of_coin) { first_coin }
  return coins_of_this_type if amount == first_coin * number_of_coin

  remaining_amount = amount - (first_coin * number_of_coin)
  coins_of_this_type + greedy_make_change(remaining_amount, coins)
end

def make_better_change(amount, coins = [25, 10, 5, 1])
  coins = coins.uniq
  # Base case: Coin == amount
  coins.each do |coin|
    return [coin] if coin == amount
  end

  # Iterative case
  ways_to_make_change = []
  coins.each do |coin|
    next if coin > amount

    amount_remaining = amount - coin
    best_change_for_remainder = make_better_change(amount_remaining, coins)
    next unless best_change_for_remainder # In case nil is returned

    way = [coin] + best_change_for_remainder
    ways_to_make_change << way
  end

  # Return the shortest way
  ways_to_make_change.each.min_by(&:length)
end
