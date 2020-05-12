def my_uniq(arr)
  raise ArgumentError unless arr.is_a?(Array)
  result = []

  arr.each do |el|
    result << el unless result.include?(el)
  end

  result
end

class Array
  def two_sum
    pairs = []
    (0...self.length).each do |idx1|
      (idx1 + 1...self.length).each do |idx2|
        pairs << [idx1, idx2] if self[idx1] + self[idx2] == 0
      end
    end

    pairs.empty? ? nil : pairs
  end
end

def my_transpose(arr)
  return arr if arr.empty?
  raise ArgumentError unless arr.all? { |el| el.is_a?(Array) }

  transposed = Array.new(arr[0].length) { Array.new(arr.length) }

  arr.each_with_index do |row, idx1|
    row.each_with_index do |el, idx2|
      transposed[idx1][idx2] = arr[idx2][idx1]
    end
  end

  transposed
end

def stock_picker(prices)
  min_idx = nil

  fence = prices.length

  until min_idx || fence == 0
    part_prices = prices[0...fence]
    min_idx = part_prices.index(part_prices.min)
    if min_idx == fence - 1
      min_idx = nil
      fence -= 1
    end
  end

  return nil if min_idx.nil?

  part_prices = prices[min_idx + 1..-1]

  max_idx = part_prices.index(part_prices.max) + min_idx + 1


  [min_idx, max_idx]
end
