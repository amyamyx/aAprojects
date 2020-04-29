require_relative "pieces/piece"

class Board
  def place_pieces
    @rows.each_with_index do |row, row_i|
      row.map! { |piece| Piece.new } if !row_i.between?(2, 5)
    end
  end
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

  def move_piece(start_pos, end_pos) 
    moving_piece = self[start_pos]

    raise "There's no piece here" if moving_piece.nil?
    raise "Invalid pos" if !valid_pos?(end_pos)
    raise "You can't move here" if !self[end_pos].nil?

    self[start_pos], self[end_pos] = nil, moving_piece
  end

  def valid_pos?(pos)
    pos.all? { |i| i.between?(0, 7) }
  end
end