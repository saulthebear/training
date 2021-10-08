require './list'
require './print-utils'

# Responsible for receiving user input and performing the correct action on the stored list.
class TodoBoard
  def initialize
    @lists = {}
    # @list = List.new(label)
  end

  # Create a new List with given label and add it to @lists
  def add_list(label)
    @lists[label] = List.new(label)
  end

  # Prints the labels of each list
  def print_list_labels
    total_width = 42
    horizontal_divider = add_border('-' * total_width)
    puts horizontal_divider
    puts add_border(center_justify('Your Lists', total_width))
    puts horizontal_divider
    @lists.each_key.with_index { |k, i| puts add_border(" #{i}. #{k}".ljust(total_width)) }
    puts horizontal_divider
  end

  # Print contents of Each List
  def showall
    @lists.each_value { |l| l.print }
  end

  def get_command
    print "\nEnter a command: "
    cmd, list, *args = gets.chomp.split

    list = @lists[list] if @lists.key?(list)

    case cmd
    when 'mklist'
      add_list(list)
    when 'ls'
      print_list_labels
    when 'showall'
      showall
    when 'mktodo'
      list.add_item(*args)
    when 'up'
      list.up(*args.map(&:to_i))
    when 'down'
      list.down(*args.map(&:to_i))
    when 'swap'
      list.swap(*args.map(&:to_i))
    when 'sort'
      list.sort_by_date!
    when 'priority'
      list.print_priority
    when 'print'
      if args.length.zero?
        list.print
      else
        list.print_full_item(*args.map(&:to_i))
      end
    when 'toggle'
      list.toggle_item(*args.map(&:to_i))
    when 'rm'
      list.remove_item(*args.map(&:to_i))
    when 'purge'
      list.purge
    when 'quit'
      return false
    else
      print 'Sorry, that command is not recognized.'
    end

    true
  end

  # Main loop
  # Will keep prompting user until get_command returns false
  def run
    while true
      break unless get_command
    end
  end
end
