require "octopus"

describe "Hungry Octopus" do
  let(:fish_ary) { ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'] }

  it "#sluggish_octopus" do
    expect(sluggish_octopus(fish_ary)).to eq('fiiiissshhhhhh')
  end

  it "#dominant_octopus" do
    expect(dominant_octopus(fish_ary)).to eq('fiiiissshhhhhh')
  end

  it "#clever_octopus" do
    expect(clever_octopus(fish_ary)).to eq('fiiiissshhhhhh')
  end
end

describe "Dancing Octopus" do
  let(:tiles_array) { ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up"] }
  let(:tiles_hash) do
    {
      "up" => 0, 
      "right-up" => 1,
      "right" => 2, 
      "right-down" => 3, 
      "down" => 4, 
      "left-down" => 5, 
      "left" => 6, 
      "left-up" => 7
    }
  end
  it "#slow_dance" do
    expect(slow_dance("up", tiles_array)).to eq(0)
    expect(slow_dance("right-down", tiles_array)).to eq(3)
  end
  
  it "#array_to_hash_with_idx" do
    expect(array_to_hash_with_idx(tiles_array)).to eq(tiles_hash)
  end
  
  it "#constant_dance" do
    expect(constant_dance("up", tiles_hash)).to eq(0)
    expect(constant_dance("right-down", tiles_hash)).to eq(3)
  end
end