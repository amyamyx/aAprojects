require_relative "piece"
require "singleton"

class NullPiece < Piece
  include Singleton

  attr_reader :symbol, :color

  def initialize
  end
  
  def empty?
    true
  end

  def move
  end

  def symbol
    " "
  end
end