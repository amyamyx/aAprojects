require_relative "minesweeper"
require_relative "board"
require_relative "tile"

class TestBoard < Board
  def initialize
    @difficulty = { dimention: [9,9], num_mines: 10}
    @grid = Board.generate_grid([9, 9])
    @num_flags = 0
  end

  def render_answer
    puts "  " + (0...width).to_a.join(" ")
    rows.each_with_index do |row, row_i|
      print row_i.to_s + "|"
      row.each { |tile| print "#{tile.answer_to_s}|" }
      puts
    end
    nil
  end
end

class Tile
  def answer_to_s
    return "✸".colorize(:white) if is_bomb
    return " ".colorize(background: :blue) if neighbor_bomb_count == 0
    return neighbor_bomb_count
  end
end

class Minesweeper
  attr_accessor :board
  def display_board
    system("clear")
    @board.render
    @board.render_answer
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Minesweeper.new(:beginner)
  board = TestBoard.new
  game.board = board

  game.run
end