class Stack
  def initialize
    @queue = []
  end

  def push(el)
    @queue.push(el)
  end

  def pop
    @queue.pop
  end

  def peek
    @queue.last
  end
end