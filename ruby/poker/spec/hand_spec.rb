require "hand"
require "byebug"

describe Hand do
  let(:c13) do 
    double("king_of_club", type: :club, num: 13)
  end

  let(:s13) do
    double("king_of_spade", type: :spade, num: 13)
  end

  let(:h13) do 
    double("king_of_heart", type: :heart, num: 13) 
  end

  let(:d13) do
    double("king_of_diamond", type: :diamond, num: 13)
  end

  let(:c1) do
     double("ace_of_club", type: :club, num: 1)
  end
  
  let(:s1) do 
    double("ace_of_spade", type: :spade, num:1)
  end

  let(:c12) do
    double("queen_of_club", type: :club, num: 12)
  end

  let(:c11) do
    double("jack_of_club", type: :club, num: 11)
  end

  let(:c10) do
    double("ten_of_club", type: :club, num: 10)
  end

  let(:c5) do
    double("five_of_club", type: :club, num: 5)
  end
  
  subject(:fh_hand) { Hand.new([c13, h13, s13, c1, s1]) }
  subject(:foak_hand) { Hand.new([c13, h13, s13, d13, s1]) }
  subject(:tp_hand) { Hand.new([c13, h13, c1, s1, c12])}
  subject(:toak_hand) { Hand.new([c13, h13, s13, c1, c12])}
  subject(:pair_hand) { Hand.new([c13, h13, c1, c12, c11])}
  subject(:flush_hand) { Hand.new([c13, c1, c11, c10, c5])}
  subject(:s_hand) { Hand.new([h13, c1, c12, c11, c10])}
  subject(:sf_hand) { Hand.new([c1, c13, c12, c11, c10])}

  describe "#initialize" do
  
    it "takes an array of 5 cards as an arg" do
      expect(fh_hand.cards.length).to eq(5)
    end
  end

  describe "#define_type" do
    context "identifies correct hand types: " do
      it "full house" do
        expect(fh_hand.hand_type).to eq(:full_house)
      end
      
      it "four of a kind" do
        expect(foak_hand.hand_type).to eq(:four_of_a_kind)
      end

      it "two_pair" do
        expect(tp_hand.hand_type).to eq(:two_pairs)
      end

      it "three of a kind" do
        expect(toak_hand.hand_type).to eq(:three_of_a_kind)
      end

      it "pair" do
        expect(pair_hand.hand_type).to eq(:pair)
      end

      it "flush" do
        flush_hand.hand_type
        expect(flush_hand.hand_type).to eq(:flush)
      end

      it "staight" do
        expect(s_hand.hand_type).to eq(:straight)
      end

      it "staight flush" do
        expect(sf_hand.hand_type).to eq(:straight_flush)
      end
    end
  end


  describe "#beat?" do
  end
end