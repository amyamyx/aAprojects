require_relative "pieces/pawn"
require_relative "pieces/queen"
require_relative "pieces/bishop"
require_relative "pieces/rook"
require_relative "pieces/king"
require_relative "pieces/knight"
require_relative "pieces/null_piece"

class Board

  def initialize(rows = nil)
    @rows = rows

    place_pieces if rows.nil?
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
    moving_piece.pos = end_pos

    self[start_pos], self[end_pos] = self[end_pos], moving_piece
  end

  def valid_pos?(pos)
    pos.all? { |i| i.between?(0, 7) }
  end

  def in_check?(color)
    king_pos = find_king_pos(color)

    pieces.any? do |piece|
      piece.moves.include?(king_pos)
    end
  end

  def checkmate?(color)
    return false unless in_check?(color)

    pieces.select { |piece| piece.color == color }.all? do |piece|
      piece.valid_moves.empty?
    end
  end


  def dup
    dup_rows = Array.new(8) { Array.new(8, NullPiece.instance) }
    dup_board = Board.new(dup_rows)
    pieces.each do |piece|
      row, col = piece.pos
      dup_rows[row][col] = piece.class.new(piece.color, dup_board, peice.pos)
    end

    dup_board
  end

  private

  def pieces 
    result = []
    @rows.each do |row|
      row.each do |piece|
        result << piece unless piece.is_a?(NullPiece)
      end
    end

    result
  end

  def find_king_pos(color)
    king = pieces.select { |piece| piece.is_a?(King) && piece.color == color }.first
    king.pos
  end

  def place_pieces
    @rows = Array.new(8) { Array.new(8) }
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