require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    # base case
    if @board.over?
      return true if @board.winner != evaluator && !@board.winner.nil?
      return false if @board.winner == evaluator || @board.winner.nil?
    end

    # recursive case
    if @next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return true if @board.winner == evaluator
      return false if @board.winner.nil? || @board.winner != evaluator
    end

    if @next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_nodes = []
    empty_positions.each do |pos|
      new_board = @board.dup
      new_board[pos] = @next_mover_mark
      new_next_mover_mark = @next_mover_mark == :o ? :x : :o
      children_nodes << self.class.new(new_board, new_next_mover_mark, pos)
    end

    children_nodes
  end

  def empty_positions
    positions = []
    @board.rows.each_with_index do |row, row_i|
      row.each_with_index do |tile, col_i|
        curr_pos = [row_i, col_i]
        positions << curr_pos if @board.empty?(curr_pos)
      end
    end

    positions
  end
end
