require "two_sum"
describe "Two Sums" do
  let(:arr) { [0, 1, 5, 7] }

  it "#bad_two_sum?" do
    expect(bad_two_sum?(arr, 6)).to be(true)
    expect(bad_two_sum?(arr, 10)).to be(false)
  end

  it "#okay_two_sum?" do
    expect(okay_two_sum?(arr, 6)).to be(true)
    expect(okay_two_sum?(arr, 10)).to be(false)
  end

  it "#two_sum?" do
    expect(two_sum?(arr, 6)).to be(true)
    expect(two_sum?(arr, 10)).to be(false)
  end
end

describe "Four Sum" do
  let(:arr) { [-1, 2, 4, -5, 9, 12, 7, 2, 19, 23]}
  it "#four_sum?" do
    expect(four_sum?(arr, 0)).to be(true)
    expect(four_sum?(arr, 28)).to be(true)
    expect(four_sum?(arr, 35)).to be(true)
    expect(four_sum?(arr, 9)).to be(false)
  end
end