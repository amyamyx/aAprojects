require_relative "pieces/pawn"
require_relative "pieces/queen"
require_relative "pieces/bishop"
require_relative "pieces/rook"
require_relative "pieces/king"
require_relative "pieces/knight"
require_relative "pieces/null_piece"

class Board

  def initialize
    @rows = Array.new(8) { Array.new(8) }

    place_pieces
  end
  
  attr_reader :rows

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @rows[row][col] = val
  end

  def move_piece!(start_pos, end_pos) 
    moving_piece = self[start_pos]

    raise "There's no piece here" if moving_piece.nil?
    raise "Invalid pos" if !valid_pos?(end_pos)
    raise "You can't move here" if self[end_pos] != NullPiece.instance

    self[start_pos], self[end_pos] = self[end_pos], moving_piece
    render
  end

  def valid_pos?(pos)
    pos.all? { |i| i.between?(0, 7) }
  end

  private

    def place_pieces
    @rows.each_with_index do |row, row_i|
      color = row_i < 2 ? :red : :blue
      if row_i == 1 || row_i == 6
        row.map!.with_index { |x, col_i| Pawn.new(color, self, [row_i, col_i]) }
      elsif row_i == 0 || row_i == 7
        row.map!.with_index do |x, col_i|
          args = [color, self, [row_i, col_i]]
          if col_i == 0 || col_i == 7
            Rook.new(*args)
          elsif col_i == 1 || col_i == 6
            Knight.new(*args)
          elsif col_i == 2 || col_i == 5
            Bishop.new(*args)
          elsif col_i == 3
            Queen.new(*args)
          else
            King.new(*args)
          end
        end
      else
        row.map! { |i| NullPiece.instance }
      end
    end
  end
end