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
  end

  def forwawrd_steps
  end

  def side_attacks
  end
end