require "colorize"

class Piece
  attr_reader :color, :selected
  attr_accessor :pos
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @selected = false
  end

  def empty?
    false
  end
  
  def moves
  end

  def valid_moves
    moves.select { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    dup_board = @board.dup
    dup_board.move_piece!(@pos, end_pos)
    dup_board.in_check?(@color == :blue ? :red : :blue)
  end
  
  def symbol
  end

  def toggle_selected
    @selected = !@selected
  end

  def to_s
    symbol.colorize(@color)
  end
end