require_relative "tile"

class Board

  def initialize(difficulty)
    @difficulty = DIFFICULTIES[difficulty]
    @grid = Board.generate_grid(difficulty)
    @bombed_tile = nil
    nil
  end

  def place_mines
    dimention, num_mines = @difficulty
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
    reveal_neighbors(pos)
  end

  # def neighbors(pos)
  #   positions = []
  #   row, col = pos

  #   -1.upto(1) do |i|
  #     -1.upto(1) do |j|
  #       next if i == 0 && j == 0
  #       new_pos = [row + i, col + j]
  #       next if !valid_pos?(new_pos)
  #       positions << new_pos
  #     end
  #   end

  #   positions
  # end

  # def neighbor_bomb_count(pos)
  #   neighbors(pos).count { |neighbor_pos| self[neighbor_pos].is_bomb }
  # end

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

  

  DIFFICULTIES = {
    beginner: [[9, 9], 10],
    intermediate: [[16, 16], 40],
    expert: [[16, 30], 99]
  }

  def valid_pos?(pos)
    row, col = pos
    row.between?(0, 8) && col.between?(0, 8)
  end
  private

  def self.generate_grid(difficulty)
    dimention = DIFFICULTIES[difficulty][0]

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


