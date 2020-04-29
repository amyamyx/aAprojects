require_relative "piece"
require_relative "modules/slideable"

class Rook < Piece

  include Slideable

  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def symbol
    "♖"
  end

  protected

  def move_dirs
    HORIZONTAL_DIRS  
  end
end