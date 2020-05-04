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
      make_move
      swap_turn!
    end
  end

  private

  def notify_players
    puts "#{@current_player.color.to_s}'s turn"
  end

  def swap_turn!
    @current_player = @current_player == @players[:blue] ? @players[:red] : @players[:blue]
  end

  def over?
    # TODO: @board.tie? and @board.win?

    # @board.tie? || @board.win?
  end

  def make_move
    @current_player.make_move(@board)
  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end