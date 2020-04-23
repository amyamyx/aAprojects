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

  def neighbors
    neighbor_tiles = []
    row_i, col_i = pos

    -1.upto(1).each do |i|
      -1.upto(1).each do |j|
        new_pos = [row_i + i, col_i + j]
        next if !@board.valid_pos?(new_pos)
        next if new_pos == pos
        neighbor_tiles << @board[new_pos]
      end
    end

    neighbor_tiles
  end

  def neighbor_bomb_count
    neighbors.count { |tile| tile.is_bomb }
  end

  def pos
    row_i = @board.grid.map { |row| row.include?(self) }.index(true)
    col_i = @board.grid[row_i].index(self)
    [row_i, col_i]
  end

  def inspect
    pos
  end

end

b = Board.new(:beginner)
b.place_mines
tile = b[[3,3]]