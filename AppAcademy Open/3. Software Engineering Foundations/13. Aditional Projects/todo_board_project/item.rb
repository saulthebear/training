# A single task item on a list
class Item
  attr_accessor :title, :description
  attr_reader :deadline

  # This method should accept a string and return a boolean indicating if it is
  # a valid date of the form YYYY-MM-DD where Y, M, and D are numbers,
  # such as 1912-06-23.
  # The month should be a number from 1 to 12 and
  # the day should be a number from 1 to 31.
  # @param date_string [String] YYY-MM-DD
  # @return [Boolean]
  def self.valid_date?(date_string)
    date = date_string.split('-').map(&:to_i)
    return false unless (0..12).include?(date[1])
    return false unless (0..31).include?(date[2])

    true
  end

  # Checks date string and prints an error message it isn't valid
  def self.check_date(deadline)
    raise 'invalid deadline!' unless Item.valid_date?(deadline)

    true
  end

  # @param title [String]
  # @param deadline [String] YYY-MM-DD
  # @param description [String]
  def initialize(title, deadline, description)
    Item.check_date(deadline)

    @title = title
    @deadline = deadline
    @description = description
  end

  # Change item's deadline if it's a valid date
  def deadline=(new_deadline)
    @deadline = new_deadline if Item.check_date(new_deadline)
  end
end
