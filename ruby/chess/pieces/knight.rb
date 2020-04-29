require_relative "piece"
require_relative "modules/stepable"

class Rook < Piece

  include Stepable

  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def symbol
    "♞"
  end

  protected

  def move_dirs
    dirs = [[1, 2], [1, -2], [-1, 2], [-1, -2]]    
    dirs + dirs.map(&:reverse)
  end
end