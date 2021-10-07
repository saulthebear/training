require './item'

# A named collection of todo Items
class List
  attr_accessor :label

  def initialize(label)
    @label = label
    @items = []
  end

  # Add a todo Item to this list
  # @param title [String]
  # @param deadline [String] YYYY-MM-DD
  # @param description [String]
  def add_item(title, deadline, description = '')
    return false unless Item.valid_date?(deadline)

    @items << Item.new(title, deadline, description)
    true
  end

  # @return [Integer] The number of Items on this List
  def size
    @items.length
  end

  # Returns a boolean indicating whether or not the given number is a valid position in the list.
  # Cannot be negative or larger than the number of items on the list.
  def valid_index?(index)
    index >= 0 && index < size
  end

  # Swaps the position of two items on the list
  # @return [Boolean] true if successful
  def swap(index1, index2)
    return false unless valid_index?(index1) && valid_index?(index2)

    @items[index1], @items[index2] = @items[index2], @items[index1]
    true
  end

  # @return [Item] Item at given position on the List
  def [](index)
    return nil unless valid_index?(index)

    @items[index]
  end

  # @return [Item] Item at the top of the list (Position 0)
  def priority
    @items[0]
  end

  # Used in printing to center justify a word
  # @return [String] 
  def center_justify(string, col_width, padding_str)
    left_padding_width = (col_width / 2) - (string.length / 2)
    right_padding_width = col_width - (string.length + left_padding_width)
    return (padding_str * left_padding_width) + string + (padding_str * right_padding_width)

  end

  # Prints all the items on this List
  def print
    col_widths = [6, 22, 11]
    total_width = col_widths.sum + ((col_widths.length - 1) * 3) # includes vertical dividers
    horizontal_divider = '-' * total_width

    puts horizontal_divider
    puts center_justify(@label.upcase, total_width, ' ')
    puts horizontal_divider
    puts "#{'Index'.ljust(col_widths[0])} | #{'Item'.ljust(col_widths[1])} | #{'Deadline'.ljust(col_widths[2])}"
    puts horizontal_divider

    @items.each.with_index do |item, idx|
      puts "#{idx.to_s.ljust(col_widths[0])} | #{item.title.ljust(col_widths[1])} | #{item.deadline.ljust(col_widths[2])}"
    end

    puts horizontal_divider
  end

  # Print all information for the item at the given index,
  # including the title, deadline, and description.
  # Does not print anything if the index not valid.
  def print_full_item(index)
    return unless valid_index?(index)

    item = @items[index]
    total_width = 42
    horizontal_divider = '-' * total_width
    puts horizontal_divider
    puts "#{item.title.ljust(total_width - item.deadline.length)}#{item.deadline}"
    puts item.description
    puts horizontal_divider
  end

  # Prints all information about item at top of list
  def print_priority
    print_full_item(0)
  end

  # Move item up the list the given amount of spaces
  def up(index, amount = 1)
    return false unless valid_index?(index)

    places_moved = 0
    current_index = index
    while places_moved < amount
      break if current_index.zero?

      swap(current_index, current_index - 1)
      current_index -= 1
      places_moved += 1
    end
    true
  end

  # Move item down the list the given amount of spaces
  def down(index, amount = 1)
    return false unless valid_index?(index)

    places_moved = 0
    current_index = index
    while places_moved < amount
      break if current_index == @items.length - 1

      swap(current_index, current_index + 1)
      current_index += 1
      places_moved += 1
    end
    true
  end

  # Sort the items in the list according to their deadlines, mutating the list
  def sort_by_date!
    # @items.sort_by! { |item| item.deadline }
    @items.sort_by!(&:deadline)
  end
end
