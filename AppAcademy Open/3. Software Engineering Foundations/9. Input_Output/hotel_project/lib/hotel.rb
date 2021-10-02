require_relative "room"

class Hotel

  def initialize(name, rooms)
    @name = name
    @rooms = {}
    rooms.each do |room_name, room_capacity|
      @rooms[room_name] = Room.new(room_capacity)
    end
  end

  def name
    @name.split.map(&:capitalize).join(' ')
  end

  def rooms
    @rooms
  end

  def room_exists?(room_name)
    @rooms.key?(room_name)
  end

  def check_in(guest_name, room_name)
    if room_exists?(room_name)
      if @rooms[room_name].add_occupant(guest_name)
        puts 'check in successful'
      else
        puts 'sorry, room is full'
      end
    else
      puts 'sorry, room does not exist'
      return false
    end
  end

  def has_vacancy?
    @rooms.each do |k, v|
      return true unless rooms[k].full?
    end
    return false
  end

  def list_rooms
    rooms.each do |k, v|
      puts "#{k} #{@rooms[k].available_space}"
    end
  end
  
end
