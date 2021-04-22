class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i % length)
    self.store[i % length]
  end

  def []=(i, val)
    validate!(i % length)
    self.store[i % length] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start_idx = 0
  end

  def [](i)
    return nil if i >= @count
    return nil if i < -@count
    idx = @start_idx + i
    idx += @count if i < 0

    @store[idx % capacity]
  end

  def []=(i, val)
    return nil if i < -@count
    if i >= @count
      (i - @count + 1).times { push(nil) }
    end

    idx = @start_idx + i
    idx += @count if i < 0

    @store[idx % capacity] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    any? { |el| el == val }
  end

  def push(val)
    resize! if @count == capacity
    @store[(@start_idx + @count) % capacity] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == capacity
    @store[(@start_idx - 1) % capacity] = val
    @start_idx = (@start_idx - 1) % capacity
    @count += 1
  end

  def pop
    @count -= 1
    @store[(@start_idx + @count) % capacity]
  end

  def shift
    return nil if @count == 0
    first_item = first
    @start_idx = (@start_idx + 1) % capacity
    @count -= 1
    first_item
  end

  def first
    @store[@start_idx]
  end

  def last
    @store[(@start_idx + @count - 1) % capacity]
  end

  def each
    self.count.times { |i| yield self[i] }
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless length == other.length
    each_with_index { |el, idx| return false if other[idx] != el }
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)
    each_with_index { |el, idx| new_store[idx] = el }
    
    @store = new_store
    @start_idx = 0
  end
end

