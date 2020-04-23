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
  end

  def width
    @grid[0].length
  end

  def height
    @grid.length
  end

  attr_reader :grid
  alias_method :rows, :grid

  def render
    puts "  " + (0...width).to_a.join(" ")
    rows.each_with_index do |row, row_i|
      print row_i.to_s + "|"
      
      row.each do |tile|
        print "#{tile_render(tile)}|"
      end
      puts 
    end
  end

  def tile_render(tile)
    return "F" if tile.flagged && tile.revealed
    return "_" if tile.revealed && !tile.is_bomb
    return " "
  end
  
end
