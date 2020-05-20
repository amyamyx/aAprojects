require "hanoi"

describe "Hanoi" do
    subject(:three_disc_game) { Hanoi.new }
    subject(:four_disc_game) { Hanoi.new(4) }
    let(:piles_3) { three_disc_game.piles }
    let(:piles_4) { four_disc_game.piles }

  describe "#initialize" do
    it "initializes the game with the num_discs" do
      expect(four_disc_game.num_discs).to be(4)
    end

    it "should initialize the game with 3 discs if no argument is given" do
      expect(three_disc_game.num_discs).to be(3)
    end

    it "should set the @move_count to zero upon initialization" do
      expect(three_disc_game.move_count).to be(0)
    end

    it "should have @piles that are an arry of 3 arrays" do
      expect(piles_3.length).to eq(3)
      expect(piles_3.all? { |el| el.is_a?(Array) }).to be(true)
    end

    it "all discs should be sorted and located in the first pile" do
      expect(piles_3[0]).to eq([1, 2, 3])
      expect(piles_4[0]).to eq([1, 2, 3, 4])
    end

    it "2nd and 3rd piles should be emtpy" do 
      expect(piles_3[1]).to eq([])
      expect(piles_3[2]).to eq([])
    end
  end

  describe "#won?" do
    it "should return whether or not all discs are in the last pile" do
      piles_3[2] = [1, 2, 3]
      piles_3[0] = []
      piles_4[1] = [1, 2, 3, 4]
      piles_4[0] = []
      
      expect(three_disc_game.won?).to be(true)
      expect(four_disc_game.won?).to be(false)
    end
  end

  describe "#move" do
    before(:each) do
      three_disc_game.piles[0] = [2, 3]
      three_disc_game.piles[1] = [1]
    end

    it "should return false if no valid move is made" do
      expect(three_disc_game.move(2, 1)).to be(false)
      expect(three_disc_game.move(0, 1)).to be(false)
    end

    it "should move the top disc of the starting pile to the ending pile" do 
      expect(three_disc_game.move(0, 2)).to be(true)
      expect(three_disc_game.piles).to eq([[3], [1], [2]])
    end
  end
end