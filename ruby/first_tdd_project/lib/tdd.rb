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

def stock_picker(stock)
  min_idx, max_idx = find_min_max_idx(stock)
  return nil if min_idx == max_idx || stock.empty?
  return nil if stock.reverse == stock.sort
  return [min_idx, max_idx] if min_idx < max_idx
  
  sections = [
    stock[0..max_idx],
    stock[max_idx + 1...min_idx],
    stock[min_idx..-1]
  ]

  profits = sections.map { |section| profit(section) }

  best_section_idx = profits.index(profits.max)
  best_section = sections[best_section_idx]
  best_idx_pair = find_min_max_idx(best_section)

  case best_section_idx
  when 0
    best_idx_pair
  when 1
    best_idx_pair.map { |idx| idx + max_idx + 1 }
  when 2
    best_idx_pair.map { |idx| idx + min_idx }
  end
end

def find_min_max_idx(arr)
  [arr.index(arr.min), arr.index(arr.max)]
end

def profit(stock)
  idx_pair = stock_picker(stock)
  return 0 if idx_pair.nil?

  min_idx, max_idx = idx_pair
  stock[max_idx] - stock[min_idx]
end