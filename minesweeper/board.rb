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
  end

  def width
    @grid[0].length
  end

  def height
    @grid.length
  end

  def reveal(pos)
    @bombed_tile = self[pos] if self[pos].is_bomb
    self[pos].reveal
  end

  attr_reader :grid
  alias_method :rows, :grid

  def render
    puts "  " + (0...width).to_a.join(" ")
    rows.each_with_index do |row, row_i|
      print row_i.to_s + "|"
      
      row.each do |tile|
        print "#{tile.wrong_flag_to_s}|" if @bombed_tile && !tile.is_bomb && tile.flagged
        print "#{tile.to_s}|" 
      end
      
      puts 
    end
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
end


