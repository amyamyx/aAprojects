require_relative "display"
require_relative "board"
require_relative "players/human_player"
require_relative "players/computer_player"

class Game
  def initialize
    @board = Board.setup
    @display = Display.new(@board)
    @player1 = HumanPlayer.new(:white, @display)
    @player2 = HumanPlayer.new(:red, @display)
    @current_player = @player1
  end

  def play
    until [:white, :red].any? { |color| @board.checkmate?(color)}
      @display.render
      notify_players
      @current_player.make_move(@board)
      swap_turn!
    end
    checkmate_message
  end

  private

  def notify_players
    puts "It's #{@current_player.color}'s turn..."
  end

  def checkmate_message
    puts "Checkmate! #{@current_player.color.capitalize} player lost."
  end

  def swap_turn!
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end