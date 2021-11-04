def sluggish_octopus(fish_arr)
  fish_arr.each_with_index do |fish1, fish1_index|
    fish1_is_longest = true
    fish_arr.each_with_index do |fish2, fish2_index|
      next if fish1_index == fish2_index

      fish1_is_longest = false if fish2.length > fish1.length
    end
    return fish1 if fish1_is_longest
  end
end

def dominant_octopus(fish_arr)
  sorted_fish = mergesort(fish_arr)
  sorted_fish.last
end

def clever_octopus(fish_arr)
  longest = ''
  fish_arr.each do |fish|
    longest = fish if fish.length > longest.length
  end
  longest
end

def mergesort(arr)
  return arr if arr.length == 1

  half_index = arr.length / 2
  left = arr[0...half_index]
  right = arr[half_index..-1]

  merge(mergesort(left), mergesort(right))
end

def merge(arr1, arr2)
  merged = []
  arr1_leftmost_index = 0
  arr2_leftmost_index = 0

  until arr1_leftmost_index == arr1.length || arr2_leftmost_index == arr2.length
    ele1 = arr1[arr1_leftmost_index]
    ele2 = arr2[arr2_leftmost_index]

    if ele1.length <= ele2.length
      merged << ele1
      arr1_leftmost_index += 1
    else
      merged << ele2
      arr2_leftmost_index += 1
    end
  end

  merged += arr1[arr1_leftmost_index..-1]
  merged += arr2[arr2_leftmost_index..-1]

  merged
end

def slow_dance(direction, tiles_array)
  tiles_array.each_with_index do |tile, index|
    return index if tile == direction
  end

  -1
end

def fast_dance(direction, tiles_hash)
  tiles_hash[direction]
end

if __FILE__ == $PROGRAM_NAME
  fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
  puts sluggish_octopus(fish)
  puts dominant_octopus(fish)
  puts clever_octopus(fish)

  puts 'Time to dance!'
  tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
  puts slow_dance('up', tiles_array)
  puts slow_dance('right-down', tiles_array)
  tiles_hash = {
    'up' => 0,
    'right-up' => 1,
    'right' => 2,
    'right-down' => 3,
    'down' => 4,
    'left-down' => 5,
    'left' => 6,
    'left-up' => 7
  }
  puts fast_dance('up', tiles_hash)
  puts fast_dance('right-down', tiles_hash)
end
