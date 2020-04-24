class Map
  def initialize
    @pairs = []
  end

  def set(key, value)
    delete(key)
    @pairs << [key, value]
  end

  def delete(key)
    pair = [key, get(key)]
    @pairs.delete(pair)
  end

  def show
    deep_dup(pairs)
  end

  def get(key)
    pair = @pairs.find { |pair| pair.first == key }
    pair ? pair[1] : nil
  end

  private

  def deep_dup(arr)
    arr.map { |el| el.is_a?(Array) ? deep_dup(el) : el }
  end
end