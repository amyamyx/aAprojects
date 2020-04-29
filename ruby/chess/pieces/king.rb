require_relative "piece"
require_relative "modules/stepable"

class King < Piece

  include Stepable

  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def symbol
    "♚"
  end

  protected

  def move_dirs
    dirs = [[1, 0], [-1, 1], [-1, 0]]    
    dirs + dirs.map(&:reverse) + [[1, 1], [-1, -1]]
  end
end