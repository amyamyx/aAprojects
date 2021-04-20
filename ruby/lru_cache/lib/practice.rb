class LRUCache
  attr_reader :size, :cache
  def initialize(size)
    raise TypeError unless size.is_a? Integer
    @size = size
    @cache = []
  end

  def count
    @cache.size
  end

  def add(el)
    @cache.delete(el) if include?(el)
    @cache.shift if count == @size    

    @cache.push(el)
  end

  def show
    print @cache
  end

  # private

  def include?(el)
    @cache.include?(el)
  end
end