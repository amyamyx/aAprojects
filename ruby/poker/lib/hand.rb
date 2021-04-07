require "byebug"
class Hand
  attr_reader :cards, :hand_type
  
  def initialize(cards)
    @cards = cards
    @hand_type = define_type
  end

  def define_type
    count_hash = number_count
    n_of_nums = count_hash.keys.count
    values = count_hash.values.sort

    case n_of_nums
    when 4
      return :pair
    when 3
      return values == [1, 2, 2] ? :two_pairs : :three_of_a_kind
    when 2
      return values == [1, 4] ? :four_of_a_kind : :full_house
    end

    count_hash = type_count
    n_of_types = count_hash.keys.count

    if n_of_types == 1
      return self.straight? ? :straight_flush : :flush
    end
    
    return self.straight? ? :straight : :high_card
  end

  def beat?(another_hand)
    
  end

  def number_count
    count_hash = Hash.new(0)
    @cards.each { |card| count_hash[card.num] += 1 }
    count_hash
  end

  def type_count
    count_hash = Hash.new(0)
    @cards.each { |card| count_hash[card.type] += 1 }
    count_hash
  end

  def straight?
    numbers = @cards.map(&:num).sort
    return true if numbers == [1, 10, 11, 12, 13]
    n = numbers[0]
    numbers.map { |el| el - n } == (0..4).to_a
  end
end

# straight_flush: 6.5 + 5
# four_of_a_kind: 10
# full_house: 5 + 3
# flush:6.5
# straight:6
# three_of_a_kind:5
# two_pairs:2 + 2
# pair:2
