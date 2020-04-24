require "colorize"
require_relative "board"

class Tile
  def initialize(is_bomb, board)
    @board = board
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
    tile_to_s = " "
    tile_to_s = "⚑".colorize(:white) if flagged

    if revealed && !is_bomb
      tile_to_s = " ".colorize(background: :blue) if neighbor_bomb_count == 0
      tile_to_s = neighbor_bomb_count
    end

    if board.bombed_tile
      tile_to_s = wrong_flag_to_s if !is_bomb && flagged
      tile_to_s = "✸".colorize(:white).colorize(background: :red) if is_bomb
      tile_to_s = triggered_bomb_to_s if self == board.bombed_tile
    end

    tile_to_s
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

  def reveal_neighbors
    neighbors.each do |tile|
      next if tile.revealed || tile.is_bomb || tile.flagged
      tile.reveal
      tile.reveal_neighbors if tile.neighbor_bomb_count == 0
    end
  end

  def pos
    row_i = @board.grid.map { |row| row.include?(self) }.index(true)
    col_i = @board.grid[row_i].index(self)
    [row_i, col_i]
  end
  
end
