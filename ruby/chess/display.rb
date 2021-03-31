require "colorize"
require_relative "cursor"

class Display
  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end


  def render
    system("clear")
    puts "   0   1   2   3   4   5   6   7".colorize(:blue)
    puts "  -------------------------------".colorize(:blue)
    @board.grid.each_with_index do |row, row_i|
      print "#{row_i}|".colorize(:blue)
      row.each_with_index do |piece, col_i|
        pos = [row_i, col_i]
        print " "
        if @cursor.selected && pos == @cursor.selected_pos
          print piece.symbol.colorize(:color => piece.color, :background => :green)
        elsif pos == @cursor.cursor_pos
          print piece.symbol.colorize(:color => piece.color, :background => :yellow)
        else
          print piece.symbol.colorize(piece.color)
        end
        print " |".colorize(:blue)
      end
      puts
      puts "  -------------------------------".colorize(:blue)
    end
    nil
  end
end