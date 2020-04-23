require_relative "tile"

class Board
  DIFFICULTIES = {
    beginner: [[9, 9], 10],
    intermediate: [[16, 16], 40],
    expert: [[16, 30], 99]
  }
  def self.place_mines(difficulty)
    dimention, num_mines = DIFFICULTIES[difficulty]
    size = dimention.inject(:*)
    grid = Array.new(dimention[0]) { Array.new(dimention[1]) }

    tiles = []
    (size - num_mines).times { tiles << Tile.new(false) }
    num_mines.times { tiles << Tile.new(true) }
    tiles.shuffle!

    grid.each do |row|
      row.each do |tile|
        tile = tiles.pop
      end
    end

    self.new(grid)
  end

  def initialize(grid)
    @grid = grid
  end
end