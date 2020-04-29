module Stepable
  def moves
    positions = []
    move_diffs.each do |move|
      new_pos = @pos.map_with_index { |i, idx| i + move[i] }
      positions << new_pos if @board.valid_pos?(new_pos)
    end
    positions
  end

  private

  def move_diffs
  end
end