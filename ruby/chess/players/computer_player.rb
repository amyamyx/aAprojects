require_relative "player"

class ComputerPlayer < Player
  def initialize
    super(color, display)
  end

  def make_move(board)
  end
end