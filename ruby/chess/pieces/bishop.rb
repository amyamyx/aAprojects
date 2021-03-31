require_relative "piece"
require_relative "slidable"

class Bishop < Piece
  include Slidable

  def initialize(board, pos, color)
    super(board, pos, color)
  end
  
  def symbol
    @color == :red ? "♝" : "♗"
  end

  def dup(b)
    Bishop.new(b, @pos, @color)
  end

  private

  def move_dirs
    DIAGONAL_DIRS
  end
end