require_relative "display"
require_relative "board"
require_relative "players/human_player"
require_relative "players/computer_player"

class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {}
    @current_player = nil
  end

  def play
  end

  private

  def notify_players
  end

  def swap_turn!
  end
end