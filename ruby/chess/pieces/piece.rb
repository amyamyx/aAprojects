require "colorize"

class Piece
  attr_reader :color, :pos
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def moves
  end
  
  def symbol
  end

  def to_s
    symbol.colorize(@color)
  end
end