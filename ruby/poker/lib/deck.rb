require "card"

class Deck
  attr_reader :cards
  
  def initialize
    @cards = []

    place_cards
  end

  private

  def place_cards

    [:club, :spade, :heart, :diamond].each do |type|
      13.times { |i| @cards << Card.new(type, i + 1) }
    end

    @cards.shuffle!
  end

end