require_relative "piece"
require "Singleton"

class NullPiece < Piece
  include Singleton
  def initialize
    @color = nil
  end

  def moves
  end

  def dup(b)
    self
  end

  def symbol
    " "
  end

end