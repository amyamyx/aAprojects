# time: O(n^2)
# 
# def my_min(list)
#   list.find do |el|
#     list.all? { |el2| el2 >= el }
#   end
# end

# time: O(n)
def my_min(list)
  min = list[0]
  list.each { |el| min = el if el < min }
  min
end

# time: O(n^2)
# def largest_contiguous_subsum(list)
#   subsums = subsets(list).map { |set| set.inject(:+) } 
#   subsums.max
# end

# def subsets(ary)
#   result = []
#   (0...ary.length).each do |idx1|
#     (idx1...ary.length).each do |idx2|
#       result << ary[idx1..idx2]
#     end
#   end

#   result
# end

# time: O(n)
# def largest_contiguous_subsum(list)
#   best_sum = list[0]
#   curr_sum = best_sum

#   start_i, stop_i = 0, 0

#   while start_i < list.length
#     best_sum = curr_sum if curr_sum > best_sum
#     stop_i += 1

#     if stop_i == list.length
#       start_i += 1
#       stop_i = start_i
#       curr_sum = list[start_i]
#     else
#       curr_sum += list[stop_i]
#     end
#   end
  
#   best_sum
# end

def largest_contiguous_subsum(list)
  best_sum = list[0]
  curr_sum = list[0]

  (1...list.length).each do |i|
    curr_sum += list[i]
    curr_sum = 0 if curr_sum < 0 && best_sum >= 0
    best_sum = curr_sum if best_sum < curr_sum
  end

  best_sum
end