class Hand
  attr_reader :cards, :hand_type

  HAND_RANK = {
    straight_flush: 10, 
    four_of_a_kind: 9,
    full_house: 8,
    flush: 7,
    straight: 6,
    three_of_a_kind: 5,
    two_pairs: 4,
    pair: 3,
    high_card:2
  }


  CARD_RANK = {
    spade: 4,
    heart: 3,
    diamond: 2,
    club: 1
  }

  
  def initialize(cards)
    @cards = cards
    @hand_type = define_type
  end

  def beat?(another_hand)
    another_type = another_hand.hand_type
    case HAND_RANK[@hand_type] <=> HAND_RANK[another_type]
    when 1
      return true
    when -1
      return false
    else
      return same_type_beat?(another_hand)
    end
  end

  protected

  def define_type
    count_hash = number_count
    n_of_nums = count_hash.keys.count
    values = count_hash.values.sort
    n_of_types = type_count.keys.count

    case n_of_nums
    when 4
      return :pair
    when 3
      return values == [1, 2, 2] ? :two_pairs : :three_of_a_kind
    when 2
      return values == [1, 4] ? :four_of_a_kind : :full_house
    when 5
      return define_type_of_5_nums(n_of_types)
    end
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

  def define_type_of_5_nums(n_of_types)
    if n_of_types == 1
      return self.straight? ? :straight_flush : :flush
    else
      return self.straight? ? :straight : :high_card
    end
  end

  def same_type_beat?(another_hand)
    case @hand_type
    when :straight
      compare_straights(another_hand)
    when :straight_flush
      compare_sf(another_hand)
    when :high_card
      compare_hc(another_hand)
    when :full_house
      compare_dominant_set(another_hand)
    when :four_of_a_kind
      compare_dominant_set(another_hand)
    when :three_of_a_kind
      compare_dominant_set(another_hand)
    when :flush
      compare_flushes(another_hand)
    when :pair
      compare_pairs(another_hand)
    when :two_pairs
      compare_tp(another_hand)
    end
  end

  def compare_straights(another_hand)
    my_largest_card = self.largest_card
    other_largest_card = another_hand.largest_card

    if my_largest_card.num == other_largest_card.num
      return CARD_RANK[my_largest_card] > CARD_RANK[other_largest_card] 
    else
      return true if my_largest_card.num == 1
      return false if other_largest_card.num == 1
      return my_largest_card.num > other_largest_card.num
    end
  end

  def largest_card
    sorted_cards = cards_sort_by_num
    if sorted_cards.map(&:num) == [1, 10, 11, 12, 13]
      return sorted_cards.first
    else
      return sorted_cards.last
    end
  end

  def cards_sort_by_num
    @cards.sort { |card| card.num }.reverse
  end

  def compare_sf(hand)
  end

  def compare_hc(hand)
  end

  def compare_dominant_set(hand)
    return true if self.dominant_number == 1 
    return false if hand.dominant_number == 1

    dominant_number > hand.dominant_number
  end

  def dominant_number
    number_count.select { |k, v| v == 3 || v == 4 }.keys.first
  end

  def compare_flushes(hand)
    my_largest_card = largest_card
    other_largest_card = hand.largest_card

    case CARD_RANK[my_largest_card.type] <=> CARD_RANK[other_largest_card.type]
    when 1
      return true
    when -1
      return false
    when 0
      return true if my_largest_card.num == 1
      return false if other_largest_card.num == 1
      my_largest_card.num > other_largest_card.num
    end
  end

  def compare_types(hand)

  end

  def compare_pairs(hand)
  end

  def compare_tp(hand)
  end
end

