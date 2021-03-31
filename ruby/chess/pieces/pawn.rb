require_relative "piece"


class Pawn < Piece
  def initialize(board, pos, color)
    super(board, pos, color)
    @og_pos = pos
  end
  
  def symbol
    @color == :red ? "♟" : "♙"
  end
  
  def moves
    result = []
    x, y = @pos
    forward_steps.each do |step|
      dx, dy = step
      new_pos = [x + dx, y + dy]
      if within_range?(new_pos) && !blocked?(new_pos)
        result << new_pos
      end
    end

    side_attacks.each do |step|
      dx, dy = step
      new_pos = [x + dx, y + dy]

      next unless within_range?(new_pos)
      result << new_pos if @board[new_pos].color == opposing_color
    end

    result
  end


  def dup(b)
    Pawn.new(b, @pos, @color)
  end

  private

  def at_start_pos?
    @pos == @og_pos
  end

  def forward_dir
    @color == :red ? 1 : -1
  end

  def forward_steps
    if at_start_pos?
      [[forward_dir, 0], [forward_dir * 2, 0]]
    else
      [[forward_dir, 0]]
    end
  end

  def side_attacks
    [[forward_dir, 1], [forward_dir, -1]]
  end
end