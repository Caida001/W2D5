require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
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
    if @map.include?(key)
      update_node!(@map.get(key))
    else
      eject! if @map.count == @max
      calc!(key)
    end

    @map[key].val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    value = @prc.call(key)
    new_node = @store.append(key, value)
    @map[key] = new_node
  end

  def update_node!(node)
    @store.remove(node.key)
    updated_node = @store.append(node.key, node.val)
    @map.set(updated_node.key, updated_node)
  end

  def eject!
    eject_key = @store.first.key
    @store.remove(eject_key)
    @map.delete(eject_key)
  end
end
