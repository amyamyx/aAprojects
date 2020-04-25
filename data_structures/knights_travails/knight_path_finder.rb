require_relative "poly_tree_node"
class KnightPathFinder

  def self.valid_moves(pos)
    moves = [[1, 2], [-1, 2], [1, -2], [-1, -2]]
    moves += moves.map(&:reverse)
    moves.map do |move|
      move.map.with_index { |el, idx| el + pos[idx] }
    end.select { |move| KnightPathFinder.valid_pos?(move) }
  end

  attr_reader :start_pos

  def initialize(start_pos)
    @start_pos = start_pos
    @root_node = PolyTreeNode.new(start_pos)
    @considered_positions = []

    build_move_tree
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
      new_moves = new_move_positions(curr_pos)
      children_nodes = new_moves.map { |new_pos| PolyTreeNode.new(new_pos) }
      children_nodes.each do |node|
        curr_node.add_child(node)
        queue << node
      end
    end
  end

  def find_path(end_pos)
    node = @root_node.bfs(end_pos)
    trace_path_back(node)
  end

  def trace_path_back(node)
    path = []
    curr_node = node
    until curr_node.nil?
      path.unshift(curr_node.value)
      curr_node = curr_node.parent
    end

    path
  end

  def self.valid_pos?(pos)
    pos.all? { |dimension| dimension.between?(0, 7) }
  end
end