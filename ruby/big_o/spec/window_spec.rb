require "window"

describe "#windowed_max_range" do
  it "find the largest difference within the window size of 2" do
    expect(windowed_max_range([1, 0, 2, 5, 4, 8], 2)).to eq(4)
  end

  it "find the largest difference within the window size of 3" do
    expect(windowed_max_range([1, 0, 2, 5, 4, 8], 3)).to eq(5)
  end

  it "find the largest difference within the window size of 4" do
    expect(windowed_max_range([1, 0, 2, 5, 4, 8], 4)).to eq(6)
  end

  it "find the largest difference within the window size of 6" do
    expect(windowed_max_range([1, 3, 2, 5, 4, 8], 5)).to eq(6)
  end
end

describe "#queue_windowed_range" do
  it "find the largest difference within the window size of 2" do
    expect(queue_windowed_range([1, 0, 2, 5, 4, 8], 2)).to eq(4)
  end

  it "find the largest difference within the window size of 3" do
    expect(queue_windowed_range([1, 0, 2, 5, 4, 8], 3)).to eq(5)
  end

  it "find the largest difference within the window size of 4" do
    expect(queue_windowed_range([1, 0, 2, 5, 4, 8], 4)).to eq(6)
  end

  it "find the largest difference within the window size of 6" do
    expect(queue_windowed_range([1, 3, 2, 5, 4, 8], 5)).to eq(6)
  end
end

describe "#sq_windowed_range" do
  it "find the largest difference within the window size of 2" do
    expect(sq_windowed_range([1, 0, 2, 5, 4, 8], 2)).to eq(4)
  end

  it "find the largest difference within the window size of 3" do
    expect(sq_windowed_range([1, 0, 2, 5, 4, 8], 3)).to eq(5)
  end

  it "find the largest difference within the window size of 4" do
    expect(sq_windowed_range([1, 0, 2, 5, 4, 8], 4)).to eq(6)
  end

  it "find the largest difference within the window size of 6" do
    expect(sq_windowed_range([1, 3, 2, 5, 4, 8], 5)).to eq(6)
  end
end

describe "#mmsq_windowed_range" do
  it "find the largest difference within the window size of 2" do
    expect(mmsq_windowed_range([1, 0, 2, 5, 4, 8], 2)).to eq(4)
  end

  it "find the largest difference within the window size of 3" do
    expect(mmsq_windowed_range([1, 0, 2, 5, 4, 8], 3)).to eq(5)
  end

  it "find the largest difference within the window size of 4" do
    expect(mmsq_windowed_range([1, 0, 2, 5, 4, 8], 4)).to eq(6)
  end

  it "find the largest difference within the window size of 6" do
    expect(mmsq_windowed_range([1, 3, 2, 5, 4, 8], 5)).to eq(6)
  end
end

