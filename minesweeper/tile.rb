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

  def flag
    @flagged = true
  end

  def to_s
    return "⚑".colorize(:red) if flagged
    return " ".colorize(background: :blue) if revealed
    return " "
  end
end