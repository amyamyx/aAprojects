require_relative "tile"

class Board

  def initialize(difficulty)
    @difficulty = difficulty
    @grid = Board.generate_grid(difficulty[:dimention])
    @bombed_tile = nil
    nil
  end

  def place_mines
    dimention, num_mines = @difficulty.values
    board_size = width * height
    
    tiles = generate_tiles(num_mines, true) + generate_tiles(board_size - num_mines, false)
    fill_grid_with_tiles(tiles.shuffle)
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
    tile.reveal_neighbors if tile.neighbor_bomb_count == 0
  end
  
  def toggle_flag(pos)
    self[pos].toggle_flag
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
        tile.is_bomb ? !tile.revealed : tile.revealed
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
    bomb_count = tile.neighbor_bomb_count

    if @bombed_tile
      tile_render = tile.wrong_flag_to_s if !tile.is_bomb && tile.flagged
      tile.reveal if tile.is_bomb
      tile_render = tile.triggered_bomb_to_s if tile == @bombed_tile
    end

    if tile.revealed && !tile.is_bomb
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
    row.between?(0, height - 1) && col.between?(0, width - 1)
  end

  private

  def self.generate_grid(dimention)
    Array.new(dimention[0]) { Array.new(dimention[1]) }
  end

  def generate_tiles(num, is_bomb)
    tiles = []
    num.times { tiles << Tile.new(is_bomb, self) }
    tiles
  end

  def fill_grid_with_tiles(tiles)
    @grid.each_with_index do |row, row_i|
      row.each_with_index do |tile, col_i|
        grid[row_i][col_i] = tiles.pop
      end
    end
  end



  def inspect
    render
  end
end


