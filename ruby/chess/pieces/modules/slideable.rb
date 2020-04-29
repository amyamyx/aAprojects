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
    move_dirs(HORIZONTAL_DIRS)
  end

  def diagonal_dirs
    move_dirs(DIAGONAL_DIRS)
  end

  def moves
  end

  private

  def move_dirs(directions)
    positions = []
    directions.each do |move|
      new_pos = @pos.map_with_index { |i, idx| i + move[idx] }
      while @board.valid_pos?(new_pos)
        positions << new_pos
        new_pos = new_pos.map_with_index { |i, idx| i + move[idx]}
      end
    end
    
    positions
  end
end