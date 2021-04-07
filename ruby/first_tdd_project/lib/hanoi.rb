class Hanoi
  attr_reader :num_disc, :piles
  def initialize(num_disc = 3)
    raise ArgumentError unless num_disc.is_a?(Integer)
    raise "There has to be at least 3 discs" if num_disc < 3
    @num_disc = num_disc
    @piles = Array.new(3) { Array.new }

    @piles[0] = (1..@num_disc).to_a
  end


  def run
    until won?
      render

      begin
        print "enter 2 numbers: "
        input = gets.chomp.chars.map(&:to_i)
        move(*input)
      rescue StandardError => e
        puts e.message
        retry
      end
    end

    render
    puts "you won!"
  end

  def move(pos1, pos2)
    raise "Invalid index" if [pos1, pos2].any? { |arg| !arg.between?(0, 2) }
    pile1, pile2 = @piles[pos1], @piles[pos2]
    raise "There's no disc on pile #{pos1}" if pile1.empty?
    raise "You can't move there." if !pile2.empty? && pile1[0] > pile2[0]
    pile2.unshift(pile1.shift)
  end

  def won?
    @piles.last == (1..@num_disc).to_a && @piles.take(2).all? { |pile| pile.empty? }
  end

  def render
    system("clear")
    @piles.each_with_index do |pile, idx|
      puts "pile #{idx}: #{pile.join(", ")}"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Hanoi.new(4)
  game.run
end