require "deck"

describe Deck do
  subject(:deck) { Deck.new }
  

  describe "#initialize" do
    let(:number_of_cards) { deck.cards.length }

    let(:first_13_cards_numbers) do
      deck.cards.map(&:num).take(13)
    end

    let(:all_cards?) do
      deck.cards.all? { |card| card.is_a?(Card)} 
    end

    
    it "has an array of cards" do
      expect(deck.cards.class).to be(Array) 
    end

    it "starts with 52 shuffuled cards" do
      expect(number_of_cards).to eq(52)
      expect(all_cards?).to be(true)
      expect(first_13_cards_numbers).to_not eq((1..13).to_a)
    end
  end
end