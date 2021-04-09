require "time_diff"

describe "#my_min" do
  let(:list) { [0, 3, 5, 4, -5, 10, 1, 90] }
  it "return the minimum" do
    expect(my_min(list)).to eq(-5)
  end
end

describe "#largest_continuous_subsum" do
  let(:list1) { [5, 3, -7] }
  let(:list2) { [2, 3, -6, 7, -6, 7] }
  let(:list3) { [-5, -1, -3] }
  it "return the right subsum" do
    expect(largest_contiguous_subsum(list1)).to eq(8)
    expect(largest_contiguous_subsum(list2)).to eq(8)
  end

  it "return the min if all elements is negative" do
    expect(largest_contiguous_subsum(list3)).to eq(-5)
  end
end