class Hanoi

  attr_reader :piles, :num_discs, :move_count

  def initialize(num_discs = 3)
    @num_discs = num_discs
    @piles = Array.new(3) { Array.new }
    @move_count = 0

    place_discs
  end

  def place_discs
    (1..@num_discs).each { |num| @piles[0].push(num) }
  end
end