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
  okay_stock = [20, 19, 18, 9, 10, 12, 17]
  amazing_stock = [2, 3, 4, 6, 80, 55, 33]
  good_stock = [15, 12, 15, 30, 10, 25]
  meh_stock = [23, 35, 17, 30, 10, 16]
  bad_stock = [20, 19, 18, 17, 16, 15, 14]

  it "should return the indices representing the most profitable days of buying and selling" do
    expect(stock_picker(okay_stock)).to eq([3, 6])
    expect(stock_picker(amazing_stock)).to eq([0, 4])
  end
  
  it "should return the most profitable pair" do 
    expect(stock_picker(meh_stock)).to eq([2, 3])
    expect(stock_picker(good_stock)).to eq([1, 3])
  end

  it "should return nil when there's no profitable buying points" do
    expect(stock_picker(bad_stock)).to be(nil)
  end
end