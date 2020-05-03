module Stepable
  def moves
    positions = []
    move_dirs.each do |move|
      new_pos = @pos.map.with_index { |i, idx| i + move[idx] }
      next unless @board.valid_pos?(new_pos)
      positions << new_pos if @board[new_pos].empty? || @board[new_pos].color != @color
      # next if @board[new_pos].color == @color
    end
    positions
  end

  private

  def move_diffs
  end
end