module Stepable
  def moves
    result = []
    x, y = @pos
    move_diffs.each do |diff|
      dx, dy = diff
      new_pos = [x + dx, y + dy]
      next unless within_range?(new_pos)
      
      if !blocked?(new_pos) || !same_color?(new_pos)
        result << new_pos
      end
    end
    
    result
  end
end