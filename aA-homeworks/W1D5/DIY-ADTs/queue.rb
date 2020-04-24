class Queue
  def initialize
    @line = []
  end

  def dequeue
    @line.shift
  end

  def enqueue(el)
    @line.push(el)
  end

  def peek
    @line.first
  end
end