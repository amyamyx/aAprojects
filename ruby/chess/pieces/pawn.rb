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

  private
  
  def at_start_row?
  end

  def forward_dir
    d_row = @color == :red ? 1 : -1
    row, col = @pos
    [[row + d_row, col], [row + d_row * 2, col]].select { |i| @board.valid_pos?(i) }
  end

  def forwawrd_steps
  end

  def side_attacks
    attack_pos = []
    row, col = @pos
    d_row = @color == :red ? 1 : -1
    
    [1, -1].each do |d_col|
      new_pos = [row + d_row, col + d_col]
      attack_piece = attack_piece
      if !attack_piece.nil? !&& attack_piece.color.nil?
        attack_pos << new_pos if attack_piece.color != @color
      end
    end

    attack_pos
  end
end