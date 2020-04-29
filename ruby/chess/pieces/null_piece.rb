require_relative "piece"

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def move
  end

  def symbol
  end
end