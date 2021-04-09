# space: O(1)
# time:  O(n^2)
def sluggish_octopus(ary)
  ary.find do |fish1|
    ary.all? { |fish2| fish1.length >= fish2.length }
  end
end

# space: O(1)
# time:  O(nlog n)
def dominant_octopus(ary)
  return ary[0] || "" if ary.length <= 1

  mid = ary.length / 2
  
  left = dominant_octopus(ary.take(mid))
  right = dominant_octopus(ary.drop(mid))

  return right.length > left.length ? right : left
end

# space: O(1)
# time:  O(n)
def clever_octopus(ary)
  best_fish = ""

  ary.each do |fish|
    best_fish = fish if fish.length > best_fish.length
  end

  best_fish
end

# time: O(n)
def slow_dance(direction, tiles_array)
  tiles_array.index(direction)
end

def array_to_hash_with_idx(array)
  hash = {}
  array.each_with_index { |el, idx| hash[el] = idx }
  hash
end

# time: O(1)
def constant_dance(direction, tiles_hash)
  tiles_hash[direction]
end