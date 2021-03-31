require_relative "piece"
require_relative "stepable"

class King < Piece
  include Stepable
  def initialize(board, pos, color)
    super(board, pos, color)
  end

  def symbol 
    @color == :red ? "♚" : "♔"
  end

  def dup(b)
    King.new(b, @pos, @color)
  end

  protected

  def move_diffs
    [
      [1, 1], [1, 0], [1, -1],
      [0, 1], [0, -1],
      [-1, 1], [-1, 0], [-1, -1]
    ]
  end
  
end