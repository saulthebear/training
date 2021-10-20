class KnightPathFinder
  def self.valid_moves(position)
    positions = [ position.up(2).right(1),
                  position.up(2).left(1),
                  position.down(2).right(1),
                  position.down(2).left(1),
                  position.right(2).up(1),
                  position.right(2).down(1),
                  position.left(2).up(1),
                  position.left(2).down(1)
                ]
    positions.select { |pos| valid_position?(pos) }
  end

  def self.valid_position?(position)
    return false if position.row.negative? || position.col.negative?
    return false if position.row >= 8 || position.col >= 8

    true
  end
  
  def initialize(starting_position)
    @starting_position = PolyTreeNode.new(starting_position)
    build_moveTree
    @considered_positions = []
  end

  def build_moveTree
  end

  def new_move_positions(position)
    all_possible_moves = KnightPathFinder.valid_moves(position)
    new_moves = all_possible_moves.reject { |pos| @considered_positions.include?(pos) }
    @considered_positions.concat(new_moves)
    new_moves
  end

  def find_path(target_position)
  end


end

class Position
  attr_reader :row, :col

  def initialize(row, col)
    raise ArgumentError unless row.is_a?(Integer) && col.is_a?(Integer)

    @row = row
    @col = col
  end

  def up(steps)
    Position.new(@row - steps, @col)
  end

  def down(steps)
    Position.new(@row + steps, @col)
  end

  def left(steps)
    Position.new(@row, @col - steps)
  end

  def right(steps)
    Position.new(@row, @col + steps)
  end

  def hash
    [@row, @col].hash
  end

  def eql?(other)
    @row == other.row && @col == other.col
  end

  def ==(other)
    @row == other.row && @col == other.col
  end

  def inspect
    "<Position [#{@row},#{@col}]>"
    # "<Position [#{@row},#{@col}] @row=#{@row} @col=#{@col}>"
  end
end

class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    prev_parent = @parent
    prev_parent&.children&.delete(self)

    @parent = node

    return if node.nil? || node.children.include?(self)

    node.children << self
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    raise "#{node} is not a child!" unless @children.include?(node)

    node.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value

    @children.each do |child|
      found = child.dfs(target_value)
      return found if found
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      node.children.each { |child| queue << child }
    end
    nil
  end

  def inspect
    if @parent
      "<Node #{@value.inspect} @parent=#{@parent&.value&.inspect}>"
    else
      "<Node #{@value.inspect} @parent=nil>"
    end
  end
end
