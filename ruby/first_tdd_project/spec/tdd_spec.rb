require "tdd"

describe "#my_uniq" do
  arr = [1,2,2,2,1,3]
  it "takes an array as an arguement" do
    expect { my_uniq("asdf") }.to raise_error(ArgumentError)
  end

  it "removes duplicate elements in an array" do
    expect(my_uniq(arr)).to eq([1,2,3])
  end
end

describe "#two_sum" do
  
  arr1 = [-1, 0, 2, -2, 1]
  arr2 = [1, 2, 3, 4, 5]
  arr3 = [-1, -1, 1]
  arr4 = [-1, 1, 1]

  
  it "return nil if none of any two elements sum to zero" do
    expect(arr2.two_sum).to eq(nil)
  end

  it "returns the pairs of positions where the elements sums to zero" do
    expect(arr1.two_sum).to eq([[0, 4], [2, 3]])
  end

  it "result with smaller index comes first" do
    expect(arr3.two_sum).to eq([[0, 2], [1, 2]])
    expect(arr4.two_sum).to eq([[0, 1], [0, 2]])
  end
end

describe "#my_transpose" do
  arr1 = [1, 2, 3]
  arr2 = [1, [1, 2, 3], 2]
  arr3 = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ]
  arr4 = [
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9]
  ]

  it "should receives a 2-dimentional array as an argument" do
    expect { my_transpose(arr1) }.to raise_error(ArgumentError)
    expect { my_transpose(arr2) }.to raise_error(ArgumentError)
  end

  it "should return an empty array if received an empty array" do
    expect(my_transpose([])).to eq([])
  end

  it "should convert a row-oriented array to a column-oriented array" do
    expect(my_transpose(arr3)).to eq(arr4)
  end
end

describe "#stock_picker" do
  prices = [20, 19, 18, 9, 10, 12, 17, 2]
  it "should return the indices representing the most profitable days of buying and selling" do
    expect(stock_picker(prices)).to eq([3, 6])
  end
end