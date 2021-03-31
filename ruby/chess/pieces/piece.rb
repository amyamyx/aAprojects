class Piece
  attr_accessor :pos
  attr_reader :color
  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def moves
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def symbol
  end

  def dup(b)
  end

  protected

  def within_range?(position)
    position.all? { |x| x.between?(0, 7) }
  end

  def blocked?(position)
    @board[position].symbol != " "
  end

  def same_color?(position)
    @board[position].color == @color
  end
  
  def move_into_check?(end_pos)
    board_dup = @board.dup
    board_dup.move_piece!(@pos, end_pos)
    board_dup.in_check?(@color)
  end

  def opposing_color
    @color == :white ? :red : :white
  end
end