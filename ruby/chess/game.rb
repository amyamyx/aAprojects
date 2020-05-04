require_relative "display"
require_relative "board"
require_relative "players/human_player"
require_relative "players/computer_player"

class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = { 
      blue: HumanPlayer.new(:blue, @display),
      red: HumanPlayer.new(:red, @display)
    }
    @current_player = @players[:blue]
  end

  def play
    until over?
      notify_players
      @current_player.make_move(@board)
      swap_turn!
    end
  end

  private

  def notify_players
  end

  def swap_turn!
    @current_player = @current_player == @players[:blue] ? @players[:red] : @players[:blue]
  end

  def over?
    # TODO: @board.tie? and @board.win?

    # @board.tie? || @board.win?
  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end