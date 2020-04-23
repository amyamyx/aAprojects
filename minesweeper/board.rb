require_relative "tile"

class Board
  DIFFICULTIES = {
    beginner: [[9, 9], 10],
    intermediate: [[16, 16], 40],
    expert: [[16, 30], 99]
  }
  def self.place_mines(difficulty)
    dimention, num_mines = DIFFICULTIES[difficulty]
    board_size = dimention.inject(:*)
    grid = Array.new(dimention[0]) { Array.new(dimention[1]) }

    tiles = []
    (board_size - num_mines).times { tiles << Tile.new(false) }
    num_mines.times { tiles << Tile.new(true) }
    tiles.shuffle!

    grid.each_with_index do |row, row_i|
      row.each_with_index do |tile, col_i|
        grid[row_i][col_i] = tiles.pop
      end
    end

    self.new(grid)
  end

  def initialize(grid)
    @grid = grid
    @bombed_tile = nil
    nil
  end

  def width
    @grid[0].length
  end

  def height
    @grid.length
  end

  def reveal(pos)
    tile = self[pos]
    @bombed_tile = tile if tile.is_bomb
    tile.reveal
    reveal_neighbors(pos)
  end

  def neighbors(pos)
    positions = []
    row, col = pos

    -1.upto(1) do |i|
      -1.upto(1) do |j|
        next if i == 0 && j == 0
        new_pos = [row + i, col + j]
        next if !valid_pos?(new_pos)
        positions << new_pos
      end
    end

    positions
  end

  def neighbor_bomb_count(pos)
    neighbors(pos).count { |neighbor_pos| self[neighbor_pos].is_bomb }
  end

  def reveal_neighbors(pos)
    neighbors(pos).each do |n_pos|
      tile = self[n_pos]
      next if tile.revealed

      if !(tile.is_bomb || tile.flagged)
        tile.reveal 
      end

      if neighbor_bomb_count(n_pos) == 0
        reveal_neighbors(n_pos)
      end
      
    end
  end

  attr_reader :grid
  alias_method :rows, :grid

  def render
    puts "  " + (0...width).to_a.join(" ")
    rows.each_with_index do |row, row_i|
      print row_i.to_s + "|"
      
      row.each_with_index { |tile, col_i| print "#{tile_to_s([row_i, col_i])}|"  }
      
      puts 
    end
    nil
  end

  def solved?
    rows.all? do |row|
      row.all? do |tile|
        tile.is_bomb ? tile.flagged : tile.revealed
      end
    end
  end

  def any_bomb_revealed?
    rows.any? do |row|
      row.any? { |tile| tile.is_bomb && tile.revealed }
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def tile_to_s(pos)
    tile_render = nil
    tile = self[pos]
    bomb_count = neighbor_bomb_count(pos)

    if @bombed_tile
      tile_render = tile.wrong_flag_to_s if !tile.is_bomb && tile.flagged
      tile.reveal if tile.is_bomb
      tile_render = tile.triggered_bomb_to_s if tile == @bombed_tile
    end

    if tile.revealed
      if bomb_count > 0
        tile_render = bomb_count
      else

      end
    end
    
    tile_render ||= tile.to_s


    return tile_render
  end

  def valid_pos?(pos)
    row, col = pos
    row.between?(0, 8) && col.between?(0, 8)
  end
end


