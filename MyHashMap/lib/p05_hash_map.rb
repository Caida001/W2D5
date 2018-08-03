require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if self.include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      @count += 1
    end

    if @count == num_buckets
      resize!
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield [node.key, node.val]
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }

    @store.each do |bucket|
      bucket.each do |node|
        key = node.key
        key_hash = key.hash
        new_store[key_hash % new_store.length].append(node.key, node.val)
      end
    end
    @store = new_store
  end

  def bucket(key)
    key_hash = key.hash
    @store[key_hash % num_buckets]
  end
end
