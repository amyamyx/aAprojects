module Slideable

  HORIZONTAL_DIRS = [
    [1, 0], 
    [0, 1], 
    [-1, 0], 
    [0, -1]
  ]
  DIAGONAL_DIRS = [
    [1, 1],
    [-1,-1], 
    [1, -1], 
    [-1, 1]
  ]

  def horizontal_dirs
  end

  def diagonal_dirs
  end

  def moves
    positions = []
    move_dirs.each do |move|
      new_pos = @pos.map_with_index { |i, idx| i + move[idx] }
      while @board.valid_pos?(new_pos)
        positions << new_pos
        new_pos = new_pos.map_with_index { |i, idx| i + move[idx]}
      end
    end

    positions
  end

  private

  def move_dirs
  end

  def grow_unblocked_moves_in_dir(dx, dy)
  end
end