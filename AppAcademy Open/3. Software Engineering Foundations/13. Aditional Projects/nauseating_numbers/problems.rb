## Phase 1: No Big Deal

def strange_sums(nums)
  count = 0
  (0...nums.length).each do |idx1|
    (idx1 + 1...nums.length).each do |idx2|
      count += 1 if (nums[idx1] + nums[idx2]).zero?
    end
  end
  count
end

def pair_product(nums, target)
  (0...nums.length).each do |idx1|
    (idx1 + 1...nums.length).each do |idx2|
      return true if nums[idx1] * nums[idx2] == target
    end
  end
  false
end

def rampant_repeats(string, counts)
  mapped = string.chars.map do |char|
    if counts.key?(char)
      char * counts[char]
    else
      char
    end
  end
  mapped.join
end

def perfect_square?(num)
  (1...num).each { |f| return true if f * f == num }
  num == 1 ## True if num is 1, false otherwise
end


## Phase 2: Nothing you can't handle

def divisors(num)
  (1..num).select { |d| (num % d).zero? }
end

def anti_prime?(num)
  divisors = divisors(num).length
  (1...num).all? { |i| divisors(i).length < divisors }
end

def matrix_addition(matrix1, matrix2)
  matrix1.map.with_index do |row, row_idx|
    row.map.with_index do |num, col_idx|
      num + matrix2[row_idx][col_idx]
    end
  end
end

def mutual_factors(*nums)
  nums
    .map { |num| divisors(num) }
    .reduce(:&)
end

def tribonacci_number(n)
  return 1 if [1, 2].include?(n)
  return 2 if n == 3

  tribonacci_number(n - 1) + tribonacci_number(n - 2) + tribonacci_number(n - 3)
end


## Phase 3: Now we're having fun

def matrix_addition_reloaded(*matrices)
  height = matrices[0].length
  width = matrices[0][0].length
  return nil unless matrices.all? do |matrix|
    matrix.length == height && matrix[0].length == width
  end

  matrices.reduce { |sum, matrix| matrix_addition(sum, matrix) }
end

def squarocol?(grid)
  return true if grid.any? { |row| row.uniq.length == 1 }
  return true if grid.transpose.any? { |col| col.uniq.length == 1 }
  false
end

def squaragonal?(square_arr)
  square = true
  # Test diagonal 1
  (0...square_arr.length).each { |idx| square = false if square_arr[idx][idx] != square_arr[0][0] }
  return true if square

  # Test diagonal 2
  col_idx = square_arr.length - 1
  (0...square_arr.length).each do |row_idx|
    return false if square_arr[row_idx][col_idx] != square_arr[0][square_arr.length - 1]

    col_idx -= 1
  end

  return true

end

def pascals_triangle(rows)
  triangle = [[1]]
  (1...rows).each do |row_idx|
    row = []
    (0..row_idx).each do |col_idx|
      above =
        if col_idx > triangle[row_idx - 1].length - 1
          0
        else
          triangle[row_idx - 1][col_idx]
        end

      left = 
        if (col_idx - 1).negative?
          0
        else
          triangle[row_idx - 1][col_idx - 1]
        end

      row << above + left
    end
    triangle << row
  end
  triangle
end

## Phase 4: Nauseating
def prime?(n)
  return false if num < 2

  (2...num).none? { |i| (num % i).zero? }
end

def mersenne_prime(n)
  m_prime_count = 0
  last_m_prime = nil
  counter = 2

  while m_prime_count < n
    candidate = (2**counter) - 1
    if prime?(candidate)
      m_prime_count += 1
      last_m_prime = candidate
    end
    counter += 1
  end

  last_m_prime
end

def encode_word(word)
  alpha = ('a'..'z').to_a
  word.chars.map { |char| alpha.index(char) + 1 }.sum
end

def triangular_word?(word)
  num = encode_word(word)

  (0...num).each do |i|
    return true if ((i*(i+1))/2) == num 
  end
  false
end

def rem_first_adjacent!(arr)
  idx = 0
  while idx < arr.length - 1
    if (arr[idx] - arr[idx + 1]).abs == 1
      arr.delete_at(idx)
      arr.delete_at(idx)
      return true
    end
    idx += 1
  end
  false
end

def consecutive_collapse(arr)
  done = false

  done = !rem_first_adjacent!(arr) until done
  arr
end

def nth_prime(start, n)
  sign = n.negative? ? -1 : 1
  prime_count = 0
  last_prime = nil
  counter = start + (1 * sign)
  while prime_count < n.abs
    return nil if counter < 2

    if prime?(counter)
      last_prime = counter
      prime_count += 1
    end

    counter += (1 * sign)
  end
  last_prime
end

def pretentious_primes(arr, n)
  arr.map { |ele| nth_prime(ele, n) }
end
