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
    tile.reveal_neighbors if tile.neighbor_bomb_count == 0 && @bombed_tile.nil?
  end
  
  def toggle_flag(pos)
    self[pos].toggle_flag
  end

  attr_reader :grid, :bombed_tile
  alias_method :rows, :grid

  def render
    puts "  " + (0...width).to_a.join(" ")
    rows.each_with_index do |row, row_i|
      print row_i.to_s + "|"

      row.each do |tile|
        tile.reveal if @bombed_tile && tile.is_bomb
        print "#{tile.to_s}|"
      end
      
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

  def any_triggered_bomb?
    !@bombed_tile.nil?
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
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


