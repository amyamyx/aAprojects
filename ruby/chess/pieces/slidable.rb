module Slidable
  
  def moves
    result = []
    x, y = @pos
    move_dirs.each do |move|
      dx, dy = move
      multiplier = 1
      new_pos = [x + dx, y + dy]
      
      while within_range?(new_pos)
        if blocked?(new_pos)
          result << new_pos if !same_color?(new_pos)
          break
        end
        result << new_pos
        multiplier += 1
        new_pos = [x + dx * multiplier, y + dy * multiplier]
      end
    end

    result
  end

  private
  
  HORIZONTAL_DIRS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  DIAGONAL_DIRS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]

  def move_dirs
  end
end