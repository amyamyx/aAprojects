require "colorize"
require_relative "cursor"

class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    puts "  " + (0..7).to_a.join("  ")
    @board.rows.each_with_index do |row, row_i|
      print row_i.to_s + "|"
      row.map(&:to_s).each_with_index do |piece, col_i|
        if [row_i, col_i] == @cursor.cursor_pos
          print (piece + " ").colorize(background: :white) + "|"
        end
        print piece + " |"
      end
      puts " |"
      puts " -------------------------"
    end
    nil
  end
end