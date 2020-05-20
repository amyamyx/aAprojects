class Hanoi

  attr_reader :piles, :num_discs, :move_count

  def initialize(num_discs = 3)
    @num_discs = num_discs
    @piles = Array.new(3) { Array.new }
    @move_count = 0

    place_discs
  end

  def place_discs
    @piles[0] = (1..@num_discs).to_a
  end

  def won?
    @piles[2] == (1..@num_discs).to_a
  end

  def move(pos_1, pos_2)
    return false if @piles[pos_1].empty?
    return false if !@piles[pos_2].empty? && @piles[pos_1].first > @piles[pos_2].first
    @piles[pos_2].unshift(@piles[pos_1].shift)
    true
  end

end