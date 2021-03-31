require_relative "pieces/require_pieces"

class Board

  attr_accessor :grid

  def self.setup
    b = Board.new
    b.place_pieces
  end

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) } 
  end

  def place_pieces
    
    @grid.each_with_index do |row, row_i|
      color = :red if row_i < 2
      color = :white if row_i > 5

      row.each_with_index do |place, col_i|
        pos = [row_i, col_i]
        args = [self, pos, color]
        if row_i.between?(2, 5)
          self[pos] = NullPiece.instance
        elsif row_i == 1 || row_i == 6
          self[pos] = Pawn.new(*args)
        else
          if col_i == 0 || col_i == 7
            self[pos] = Rook.new(*args)
          elsif col_i == 1 || col_i == 6
            self[pos] = Knight.new(*args)
          elsif col_i == 2 || col_i == 5
            self[pos] = Bishop.new(*args)
          elsif col_i == 3
            self[pos] = Queen.new(*args)
          elsif col_i == 4
            self[pos] = King.new(*args)
          end
        end
      end
    end
    self
  end


  def move_piece(start_pos, end_pos)
    raise "No Piece at start_pos" if self[start_pos] == NullPiece.instance
    raise "Not a valid move" if !valid_move?(start_pos, end_pos)
    raise "This move will leave you in check!" if in_check_move?(start_pos, end_pos)
    move_piece!(start_pos, end_pos)
  end

  def move_piece!(start_pos, end_pos)
    moving_piece = self[start_pos]
    destination = self[end_pos]
    if destination.color != moving_piece.color
      destination.pos = nil
      self[end_pos] = NullPiece.instance
    end

    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
    moving_piece.pos = end_pos
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def in_check?(color)
    oppo_color = color == :white ? :red : :white
    king = pieces.find { |p| p.color == color && p.class == King }
    opposing_pieces = pieces.select { |p| p.color == oppo_color}
    opposing_pieces.any? { |p| p.moves.include?(king.pos) }
  end
  
  def checkmate?(color)
    if in_check?(color)
      other_pieces = pieces.select { |p| p.color == color && p.class != King }
      other_pieces.all? { |p| p.valid_moves.empty? }
    else
      false
    end
  end

  def pieces 
    @grid.flatten
  end

  def dup
    board_dup = Board.new

    @grid.each_with_index do |row, row_i|
      row.each_with_index do |piece, col_i|
        board_dup[[row_i, col_i]] = piece.dup(board_dup)
      end
    end

    board_dup
  end

  private

  def valid_move?(start_pos, end_pos)
    piece = self[start_pos]
    piece.moves.include?(end_pos)
  end

  def in_check_move?(start_pos, end_pos)
    piece = self[start_pos]
    piece.moves.include?(end_pos) && !piece.valid_moves.include?(end_pos)
  end

  def inspect
  end
end