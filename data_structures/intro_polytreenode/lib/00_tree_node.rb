require_relative "searchable"

class PolyTreeNode

  include Searchable

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  attr_reader :value, :children, :parent
  
  def parent=(node)
    remove_self_from_children_list if parent_exists
    @parent = node
    add_self_to_children_list if parent_exists
  end

  def add_child(node)
    node.parent = self
    @children << node unless is_child?(node)
  end

  def remove_child(node)
    raise "This is not a child node" unless is_child?(node)
    node.parent = nil
    @children.delete(node)
  end

  def is_child?(node)
    @children.include?(node)
  end

  private

  def parent_exists
    !@parent.nil?
  end

  def remove_self_from_children_list
    @parent._children.delete(self)
  end

  def add_self_to_children_list
    @parent._children << self unless @parent.is_child?(self)
  end
  
  protected
  
  def _children
    @children
  end
end