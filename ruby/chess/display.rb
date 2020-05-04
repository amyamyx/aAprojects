require "colorize"
require_relative "cursor"

class Display

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  attr_reader :board, :cursor

  def render
    puts "  " + (0..7).to_a.join("  ")
    @board.rows.each_with_index do |row, row_i|
      print row_i.to_s + "|"
      row.map(&:to_s).each_with_index do |piece, col_i|
        if [row_i, col_i] == @cursor.cursor_pos
          print (piece + " ").colorize(background: :yellow) + "|"
        elsif @board[[row_i, col_i]].selected 
          print (piece + " ").colorize(background: :white) + "|"
        else
          print piece + " |"
        end
      end
      puts 
      puts " -------------------------"
    end
    nil
  end
end