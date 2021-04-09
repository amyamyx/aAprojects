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