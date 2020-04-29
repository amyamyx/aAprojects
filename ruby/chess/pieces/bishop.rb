require_relative "piece"
require_relative "modules/slideable"

class Bishop < Piece

  include Slideable

  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def symbol
    "♝"
  end

  protected

  def move_dirs
    diagonal_dirs 
  end
end