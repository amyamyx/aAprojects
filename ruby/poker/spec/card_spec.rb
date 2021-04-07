require "card"

describe Card do
  describe "#initialize" do
    subject(:king_of_club) { Card.new(:club, 13) }
    
    it "takes in a type and a number as arguments"  do
      expect { Card.new }.to raise_error(ArgumentError)
      expect { Card.new(:club, 13) }.to_not raise_error
    end

    it "set the arguments to the respective variables" do
      expect(king_of_club.type).to eq(:club)
      expect(king_of_club.num).to eq(13)
    end
  end
end