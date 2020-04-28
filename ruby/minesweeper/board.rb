require_relative "tile"

class Board

  def initialize(difficulty)
    @difficulty = difficulty
    @grid = Board.generate_grid(difficulty[:dimention])
    @bombed_tile = nil
    @num_flags = 0
  end

  def place_mines
    num_mines = @difficulty[:num_mines]
    board_size = width * height

    bomb_tiles = generate_tiles(num_mines, true)
    regular_tiles = generate_tiles(board_size - num_mines, false)

    tiles =  bomb_tiles + regular_tiles
    fill_grid_with_tiles(tiles.shuffle)
  end

  def reveal(pos)
    tile = self[pos]
    @bombed_tile = tile if tile.is_bomb
    tile.reveal
    tile.reveal_neighbors if tile.neighbor_bomb_count == 0 && @bombed_tile.nil?
  end
  
  def toggle_flag(pos)
    tile = self[pos]
    if tile.flagged
      @num_flags -= 1
    else
      @num_flags += 1
    end

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
    puts "Number of flags: #{@num_flags} ⚑"
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

  def flag_all_bombs
    rows.each do |row|
      row.each do |tile|
        tile.flagged = true if tile.is_bomb
      end
    end
  end

  private

  def width
    @grid[0].length
  end

  def height
    @grid.length
  end

  def self.generate_grid(dimention)
    Array.new(dimention[0]) { Array.new(dimention[1]) }
  end

  def generate_tiles(num, is_bomb)
    tiles = []
    num.times { tiles << Tile.new(is_bomb, self) }
    tiles
  end

  def fill_grid_with_tiles(tiles)
    rows.each_with_index do |row, row_i|
      row.each_with_index do |col, col_i|
        grid[row_i][col_i] = tiles.pop
      end
    end
  end

end


