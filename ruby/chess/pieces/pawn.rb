require_relative "piece"

class Pawn < Piece
  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def symbol
    "♙"
  end

  def move_dirs
  end

  def moves
    side_attacks + forward_steps
  end

  private
  
  def at_start_row?
    @pos[0] == (color == :blue ? 6 : 1)
  end

  def forward_dir
    d_row = @color == :red ? 1 : -1
    [d_row, 0]
  end

  def forward_steps
    forward_pos = [move_(*forward_dir)]
    forward_pos << move_(*forward_dir.map { |i| i * 2 }) if at_start_row?
    forward_pos.select { |pos| @board[pos].empty? }
  end

  def move_(d_row, d_col)
    row, col = @pos
    [row + d_row, col + d_col]
  end

  def side_attacks
    attack_pos = []
    row, col = @pos
    d_row = forward_dir[0]
    
    [1, -1].each do |d_col|
      new_pos = move_(d_row, d_col)
      next unless @board.valid_pos?(new_pos)
      attack_piece = @board[new_pos]
      if !attack_piece.empty? && attack_piece.color != @color
        attack_pos << new_pos
      end
    end

    attack_pos
  end
end