require "colorize"

class Tile
  def initialize(is_bomb)
    @is_bomb = is_bomb
    @revealed = false
    @flagged = false
  end

  attr_reader :is_bomb, :revealed, :flagged
  
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
    return "✘".colorize(:red).colorize(background: :white)
  end
end
