require 'byebug'
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

  def inspect
    # "<PolyTreeNode @value=#{@value} @parent=#{@parent.inspect} @children=#{@children.inspect}>"
    "<PolyTreeNode @value=#{@value} @parent=#{@parent.inspect}>"
  end
end
