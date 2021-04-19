# O(n * n log n) linearithmic time
# O(n) linear space
def windowed_max_range(arr, w_size)
  current_max_range = nil

  (0..arr.size - w_size).each do |i|
    current_window = arr[i, w_size].sort
    range = current_window.last - current_window.first

    if current_max_range.nil? || range > current_max_range
      current_max_range = range
    end
  end

  current_max_range
end

class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store << el
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def size 
    @store.size
  end

  def empty?
    @store.empty?
  end

  def range
    @store.max - @store.min 
  end
end


def queue_windowed_range(arr, w_size)
  queue = MyQueue.new
  max_range = 0

  arr.each do |el|
    queue.dequeue if queue.size == w_size
    queue.enqueue(el)
    range = queue.range
    max_range = range if range > max_range
  end

  max_range
end

class MyStack
  def initialize
    @store = []
    @size = 0
  end

  def push(el)
    @store << el
    @size += 1
  end

  def pop
    @size -= 1
    @store.pop
  end

  def peek
    @store.last
  end

  def size
    @size
  end

  def empty?
    @size == 0
  end

  def range
    @store.max - @store.min
  end
end

def stack_windowed_range(arr, w_size)
end

class MyStackQueue
  def initialize
    @store1 = MyStack.new
    @store2 = MyStack.new
  end

  def size
    @store1.size
  end

  def empty?
    @store1.empty? && @store2.empty?
  end

  def enqueue(el)
    @store1.push(el)
  end

  def dequeue
    @store2.push(@store1.pop) until @store1.empty?
    @store2.pop
    @store1.push(@store2.pop) until @store2.empty?
  end

  def range
    @store1.range
  end
end

def sq_windowed_range(arr, w_size)
  sq = MyStackQueue.new
  max_range = 0

  arr.each do |el|
    sq.dequeue if sq.size == w_size
    sq.enqueue(el)
    range = sq.range
    max_range = range if range > max_range
  end

  max_range
end

class MinMaxStack
  def initialize
    @store = MyStack.new
    @size = 0
  end

  def push(el)
    @store.push({
      max: new_max?(el),
      min: new_min?(el),
      val: el
    })
    @size += 1
  end

  def pop
    @size -= 1
    popped = @store.pop
  end

  def peek
    @store.peek
  end

  def min
    @store.peek[:min] unless empty?
  end

  def max
    @store.peek[:max] unless empty?
  end

  def empty?
    @size == 0
  end

  def size 
    @size
  end

  def range
    @max - @min
  end

  def new_min?(el)
    empty? ? el : [min, el].min
  end

  def new_max?(el)
    empty? ? el : [max, el].max
  end
end

class MinMaxStackQueue
  def initialize
    @store1 = MinMaxStack.new
    @store2 = MinMaxStack.new
  end

  def size
    @store1.size
  end

  def empty?
    @store1.empty?
  end

  def enqueue(el)
    @store1.push(el)
  end

  def dequeue
    @store2.push(@store1.pop[:val]) until @store1.empty?
    @store2.pop
    @store1.push(@store2.pop[:val]) until @store2.empty?
  end

  def range
    @store1.peek[:max] - @store1.peek[:min]
  end
end


def mmsq_windowed_range(arr, w_size)
  mmsq = MinMaxStackQueue.new
  max_range = 0

  arr.each do |el|
    mmsq.dequeue if mmsq.size == w_size
    mmsq.enqueue(el)
    range = mmsq.range
    max_range = range if range > max_range
  end

  max_range
end