require_relative "player"

class HumanPlayer < Player
  def initialize
    super(color, display)
  end

  def make_move(_board)
  end
end