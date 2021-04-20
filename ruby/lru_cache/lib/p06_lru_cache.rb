require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    node = @map[key]

    if node
      val = node.val
      update_node!(node)
    else
      eject! if count == @max
      val = calc!(key)
      @map[key] = @store.append(key, val)
    end

    return val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    key, val = node.key, node.val
    node.remove
    @map[key] = @store.append(key, val)
  end

  def eject!
    key = @store.first.key
    @store.remove(key)
    @map.delete(key)
  end
end