require "hanoi"

describe Hanoi do 
  subject(:hanoi_3) { Hanoi.new }
  subject(:hanoi_4) { Hanoi.new(4) }

  describe "#initialize" do
    it "can take a number as an arugument and set it as a variable @num_disc" do 
      expect { Hanoi.new(4) }.to_not raise_error
      expect(hanoi_4.num_disc).to eq(4)
      expect { Hanoi.new("yo") }.to raise_error(ArgumentError)
    end

    it "if no argument is given, set it to 3 by default" do
      expect { Hanoi.new }.to_not raise_error
      expect(hanoi_3.num_disc).to eq(3)
    end

    it "raises an error if the argument given is smaller than 3" do
      expect { Hanoi.new(2) }.to raise_error("There has to be at least 3 discs")
    end

    it "sets up the @piles as an array of 3 arrays" do 
      expect(hanoi_3.piles.length).to eq(3)
      expect(hanoi_4.piles.length).to eq(3)
    end

    it "starts with all discs in the first pile" do
      expect(hanoi_3.piles).to eq([[1, 2, 3], [], []])
      expect(hanoi_4.piles).to eq([[1, 2, 3, 4], [], []])
    end
  end


  describe "#move" do
    it "takes in 2 numbers as arguments" do
      expect { hanoi_3.move(0, 1) }.to_not raise_error
    end

    it "raises an error if any of the indices is not between 0 and 2" do      
      expect { hanoi_3.move(4, 0) }.to raise_error("Invalid index")
      expect { hanoi_3.move(0, 7) }.to raise_error("Invalid index")
    end

    it "raises an error if there is no disc on the starting position" do
      expect { hanoi_3.move(1, 2) }.to raise_error("There's no disc on pile 1")  
    end

    it "raises an error if the end pile has a smaller disc" do
      hanoi_3.piles[1] = [1, 2]
      hanoi_3.piles[0] = [3]
      expect { hanoi_3.move(0, 1) }.to raise_error("You can't move there.")
    end

    it "moves the top disc from the start pile to the top of the end pile" do
      hanoi_3.move(0, 1)
      expect(hanoi_3.piles[0]).to eq([2, 3])
      expect(hanoi_3.piles[1]).to eq([1])
    end
  end

  describe "#won?" do
    it "returns true if all discs are in the last pile and sorted" do
      hanoi_3.piles[-1] = [1, 2, 3]
      hanoi_3.piles[0] = []
      hanoi_4.piles[-1] = [1, 2, 3, 4]
      hanoi_4.piles[0] = []
      expect(hanoi_3.won?).to be(true)
      expect(hanoi_4.won?).to be(true)
    end

    it "returns false if not all discs are the last pile" do
      hanoi_3.piles[-1] = [1]
      hanoi_3.piles[0] = [2, 3]
      expect(hanoi_3.won?).to be(false)
    end
  end
end