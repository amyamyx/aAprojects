require "colorize"
require_relative "board"

class Tile
  def initialize(is_bomb, board)
    @board = board
    @is_bomb = is_bomb
    @revealed = false
    @flagged = false
  end

  attr_reader :is_bomb, :revealed, :flagged, :board
  
  def reveal
    @revealed = true
  end

  def toggle_flag
    @flagged = @flagged ? false : true
  end

  def to_s
    return "⚑".colorize(:white) if flagged
    return "✸".colorize(:white).colorize(background: :red) if revealed && is_bomb
    return " ".colorize(background: :blue) if revealed
    return " "
  end

  def wrong_flag_to_s
    "✘".colorize(:red).colorize(background: :white)
  end

  def triggered_bomb_to_s
    "✸".colorize(:yello).colorize(background: :red)
  end

  #adding_board on initialize

end
