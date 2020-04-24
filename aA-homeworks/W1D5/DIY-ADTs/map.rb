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

  def get(key)
    pair = @pairs.find { |pair| pair.first == key }
    pair ? pair[1] : nil
  end
end