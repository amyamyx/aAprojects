require_relative "poly_tree_node"

class KnightPathFinder

  def self.valid_moves(pos)
    moves = [[1, 2], [-1, 2], [1, -2], [-1, -2]]
    moves += moves.map(&:reverse)
    moves.map do |move|
      move.map.with_index { |el, idx| el + pos[idx] }
    end.reject { |move| move.any? { |el| el < 0 } }
  end

  attr_reader :considered_positions, :root_node

  def initialize(start_pos)
    @start_pos = start_pos
    @root_node = PolyTreeNode.new(start_pos)
    @considered_positions = []
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    new_positions = valid_moves.reject { |move| @considered_positions.include?(move) }
    @considered_positions += new_positions
    new_positions
  end

  def build_move_tree
    queue = [@root_node]

    until queue.empty?
      curr_node = queue.shift
      curr_pos = curr_node.value
      # break if curr_pos == pos
      new_moves = new_move_positions(curr_pos)
      children_nodes = new_moves.map { |new_pos| PolyTreeNode.new(new_pos) }
      children_nodes.each do |node|
        curr_node.add_child(node)
        queue << node
      end
    end
  end

  def find_path(end_pos)

  end

  def trace_path_back(node)
  end

end