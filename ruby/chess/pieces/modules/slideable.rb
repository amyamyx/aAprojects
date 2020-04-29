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
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    positions = []
    move_dirs.each do |move|
      dx, dy = move
      new_pos = grow_unblocked_moves_in_dir(dx, dy)

      while @board.valid_pos?(new_pos) && @board[new_pos].empty?
        positions << new_pos if @board[new_pos].color != @color
        dx += move[0]
        dy += move[1]
        new_pos = grow_unblocked_moves_in_dir(dx, dy)
      end
    end

    positions
  end

  private

  def move_dirs
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    row, col = @pos
    [row + dx, col + dy]
  end
end