require "hand"

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
  
  let(:h1) do 
    double("ace_of_heart", type: :heart, num:1)
  end

  let(:d1) do 
    double("ace_of_diamond", type: :diamond, num:1)
  end

  let(:c12) do
    double("queen_of_club", type: :club, num: 12)
  end

  let(:s12) do
    double("queen_of_spade", type: :spade, num: 12)
  end

  let(:c11) do
    double("jack_of_club", type: :club, num: 11)
  end
  
  let(:s11) do
    double("jack_of_spade", type: :spade, num: 11)
  end
  

  let(:c10) do
    double("ten_of_club", type: :club, num: 10)
  end

  let(:s10) do
    double("ten_of_spade", type: :spade, num:10)
  end

  let(:c5) do
    double("five_of_club", type: :club, num: 5)
  end
  
  let(:s5) do
    double("five_of_spade", type: :spade, num: 5)
  end

  let(:c4) do
    double("four_of_club", type: :club, num: 4)
  end

  let(:s4) do
    double("four_of_spade", type: :spade, num: 4)
  end

  let(:h2) do
    double("two_of_heart", type: :heart, num: 2)
  end
  let(:s2) do
    double("two_of_spade", type: :spade, num: 2)
  end

  let(:c3) do
    double("three_of_club", type: :club, num: 3)
  end
  
  let(:s3) do
    double("three_of_spade", type: :spade, num: 3)
  end
  
  let(:s9) do
    double("nine_of_spade", type: :spade, num: 9)
  end



  subject(:fh_hand) { Hand.new([c13, h13, s13, c1, s1]) }
  subject(:fh_hand2) { Hand.new([c1, h1, s1, c13, h13]) }
  subject(:foak_hand) { Hand.new([c13, h13, s13, d13, s1]) }
  subject(:foak_hand2) { Hand.new([c1, h1, s1, d1, c13]) }
  subject(:tp_hand) { Hand.new([c13, h13, c1, s1, c12]) }
  subject(:tp_hand2) { Hand.new([s13, d13, h1, d1, s12]) }
  subject(:tp_hand3) { Hand.new([s13, d13, c12, s12, c1] ) }
  subject(:tp_hand4) { Hand.new([c13, h13, c3, s3, c10]) }
  subject(:toak_hand) { Hand.new([c13, h13, s13, c1, c12]) }
  subject(:toak_hand2) { Hand.new([c1, h1, s1, c5, c10]) }
  subject(:pair_hand) { Hand.new([c13, h13, c1, c12, c11]) }
  subject(:pair_hand2) { Hand.new([c12, s12, c5, c10, d13]) }
  subject(:pair_hand3) { Hand.new([d13, s13, s1, c10, c5])}
  subject(:flush_hand) { Hand.new([c13, c1, c11, c10, c5]) } 
  subject(:flush_hand2) { Hand.new([s13, s1, s12, s5, s10])}
  subject(:flush_hand3) { Hand.new([s2, s3, s11, s4, s9])}
  subject(:s_hand) { Hand.new([h13, c1, c12, c11, c10]) }
  subject(:s_hand2) { Hand.new([s1, d13, s12, c11, s10]) }
  subject(:s_hand3) { Hand.new([d1, h2, c3, c4, s5])}
  subject(:sf_hand) { Hand.new([c1, c13, c12, c11, c10]) }
  subject(:sf_hand2) { Hand.new([s1, s2, s3, s4, s5])}
  subject(:sf_hand3) { Hand.new([s1, s13, s12, s11, s10])}
  subject(:hc_hand1) { Hand.new([c5, c10, h13, c11, c12]) }
  subject(:hc_hand2) { Hand.new([c5, c10, s1, c11, c12]) }
  subject(:hc_hand3) { Hand.new([s5, s10, s13, s11, h2])}

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

      it "high card" do
        expect(hc_hand1.hand_type).to eq(:high_card)
      end
    end
  end


  describe "#beat?" do
    it "takes another_hand as an arg" do
      expect{ fh_hand.beat?(tp_hand) }.to_not raise_error
    end

    context "when both hands are different kinds" do
      it "compares based on the strengths" do
        expect(fh_hand.beat?(flush_hand)).to be(true)
        expect(foak_hand.beat?(fh_hand)).to be(true)
        expect(sf_hand.beat?(foak_hand)).to be(true)
        expect(hc_hand1.beat?(foak_hand)).to be(false)
      end
    end

    context "when both hands are the same type" do
      context "straigt/straight flush/high card" do
        it "first compares the largest card" do
          expect(s_hand.beat?(s_hand3)).to be(true)
          expect(sf_hand.beat?(sf_hand2)).to be(true)
          expect(hc_hand1.beat?(hc_hand2)).to be(false)       
        end

        it "if same largest card num, compares card type" do
          expect(s_hand.beat?(s_hand2)).to be(false)
          expect(sf_hand.beat?(sf_hand)).to be(false)
          expect(hc_hand1.beat?(hc_hand3)).to be(false)
        end
      end

      context "full house/4 of a kind/3 of a kind" do
        it "compares the dominant sets" do
          expect(fh_hand.beat?(fh_hand2)).to be(false)
          expect(foak_hand.beat?(foak_hand2)).to be(false)
          expect(toak_hand.beat?(toak_hand2)).to be(false)
        end
      end
      
      context "flush" do
        it "compares card type first" do
          expect(flush_hand.beat?(flush_hand2)).to be(false)
        end
        
        it "compares the largest card num if type is the same" do
          expect(flush_hand2.beat?(flush_hand3)).to be(true)
        end
      end
      
      context "pair/two pairs" do
        it "compares the largest pair" do
          expect(pair_hand.beat?(pair_hand2)).to be(true)
          expect(tp_hand.beat?(tp_hand3)).to be(true)
        end

        it "compares the highest of the rest if pairs are the same" do
          expect(pair_hand.beat?(pair_hand3)).to be(false)
          expect(tp_hand.beat?(tp_hand2)).to be(false)
          expect(tp_hand3.beat?(tp_hand4)).to be(true)
        end
      end
    end
  end
end