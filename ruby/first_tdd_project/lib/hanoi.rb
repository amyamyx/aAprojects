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

end