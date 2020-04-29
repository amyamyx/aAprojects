require_relative "piece"

class NullPiece < Piece
  include Singleton

  attr_reader :symbol, :color

  def initialize
  end

  def move
  end

  def symbol
  end
end