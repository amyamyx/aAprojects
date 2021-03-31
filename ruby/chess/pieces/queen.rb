require_relative "piece"
require_relative "slidable"

class Queen < Piece
  include Slidable

  def initialize(board, pos, color)
    super(board, pos, color)
  end

  def symbol
    @color == :red ? "♛" : "♕"
  end

  def dup(b)
    Queen.new(b, @pos, @color)
  end
  
  private

  def move_dirs
     HORIZONTAL_DIRS + DIAGONAL_DIRS
  end
end