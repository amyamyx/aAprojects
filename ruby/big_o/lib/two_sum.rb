def bad_two_sum?(arr, target)
  sums(arr).include?(target)
end

def sums(arr)
  sums = []
  (0...arr.length).each do |idx1|
    (idx1 + 1...arr.length).each do |idx2|
      sums << arr[idx1] + arr[idx2]
    end
  end

  sums
end

def okay_two_sum?(arr, target)
  sorted = arr.sort

  sorted.each_with_index do |el, idx|
    remain = target - el
    return true if binary_search(sorted.drop(idx + 1), remain)
  end  

  false
end

def binary_search(arr, target)
  return arr[0] == target if arr.length <= 1
  mid = arr.length / 2
  piv = arr[mid]

  case piv <=> target
  when 0
    return true
  when 1
    return binary_search(arr.take(mid), target)
  when -1
    return binary_search(arr.drop(mid + 1), target)
  end
end

def two_sum?(arr, target)
  hash = Hash.new
  
  arr.each do |el|
    return true if hash[target - el] 
    hash[el] = true
  end

  false
end