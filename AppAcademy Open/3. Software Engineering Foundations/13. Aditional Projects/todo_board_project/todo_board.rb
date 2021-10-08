require './list'

# Responsible for receiving user input and performing the correct action on the stored list.
class TodoBoard
  def initialize(label)
    @list = List.new(label)
  end

  def get_command
    print "\nEnter a command: "
    cmd, *args = gets.chomp.split

    case cmd
    when 'mktodo'
      @list.add_item(*args)
    when 'up'
      @list.up(*args.map(&:to_i))
    when 'down'
      @list.down(*args.map(&:to_i))
    when 'swap'
      @list.swap(*args.map(&:to_i))
    when 'sort'
      @list.sort_by_date!
    when 'priority'
      @list.print_priority
    when 'print'
      if args.length.zero?
        @list.print
      else
        @list.print_full_item(*args.map(&:to_i))
      end
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
