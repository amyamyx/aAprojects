require_relative "piece"
require_relative "slidable"

class Rook < Piece
  include Slidable

  def initialize(board, pos, color)
    super(board, pos, color)
  end

  def symbol
    @color == :red ? "♜" : "♖"
  end

  def dup(b)
    Rook.new(b, @pos, @color)
  end

  private
  
  def move_dirs
     HORIZONTAL_DIRS
  end
end