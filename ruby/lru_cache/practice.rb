class LRUCache
  def initialize(size)
    @size = size
    @cache = []
  end

  def count
    @cache.size
  end

  def add(el)
    if count == @size
      include?(el) ? @cache.delete(el) : @cache.shift
    end

    @cache.push(el)
  end

  def show
    print @cache
  end

  private

  def include?(el)
    @cache.include?(el)
  end
end

if __FILE__ == $PROGRAM_NAME
  johnny_cache = LRUCache.new(4)

  johnny_cache.add("I walk the line")
  johnny_cache.add(5)

  puts johnny_cache.count == 2 # => returns 2

  johnny_cache.add([1,2,3])
  johnny_cache.add(5)
  johnny_cache.add(-5)
  johnny_cache.add({a: 1, b: 2, c: 3})
  johnny_cache.add([1,2,3,4])
  johnny_cache.add("I walk the line")
  johnny_cache.add(:ring_of_fire)
  johnny_cache.add("I walk the line")
  johnny_cache.add({a: 1, b: 2, c: 3})


  johnny_cache.show

end