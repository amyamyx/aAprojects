require_relative "piece"
require_relative "stepable"

class Knight < Piece
  include Stepable

  def initialize(board, pos, color)
    super(board, pos, color)
  end

  def symbol 
    @color == :red ? "♞" : "♘"
  end

  def dup(b)
    Knight.new(b, @pos, @color)
  end

  protected

  def move_diffs
    [
      [2, 1], [1, 2], 
      [1, -2],[-2, 1],
      [-1, 2], [2, -1],
      [-2, -1], [-1, -2]
    ]
  end
  
end