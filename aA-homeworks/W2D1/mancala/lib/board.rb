class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) { Array.new }
    @players = [name1, name2]
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, idx|
      next if idx % 7 == 6
      4.times { cup << :stone }
    end
  end

  def valid_move?(start_pos)
    starting_cup = @cups[start_pos]
    raise "Invalid starting cup" if starting_cup.nil?
    raise "Starting cup is empty" if starting_cup.empty?
  end

  def make_move(start_pos, current_player_name)
    starting_cup = @cups[start_pos]
    new_pos = start_pos + 1
    until starting_cup.empty?
      if new_pos != opponent_cup_pos(current_player_name)
        @cups[new_pos % 14] << starting_cup.shift
      end
      new_pos += 1
    end
    render
    next_turn(new_pos % 14 - 1)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    return :prompt if ending_cup_idx % 7 == 6
    return :switch if @cups[ending_cup_idx] == [:stone]
    return ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    [0, 1].any? do |i|
      @cups[0 + 7 * i, 6].all?(&:empty?)
    end
  end

  def winner
    case @cups[6] <=> @cups[13]
    when 1
      return @players[0]
    when -1
      return @players[1]
    end
    :draw
  end

  def opponent_cup_pos(current_player_name)
    @players[0] == current_player_name ? 13 : 6
  end
end
