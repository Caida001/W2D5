class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    key_hash = key.hash
    unless self[key_hash].include?(key)
      @count += 1
      self[key_hash] << key
    end

    if @count == num_buckets
      resize!
    end
  end

  def include?(key)
    key_hash = key.hash
    self[key_hash].include?(key)
  end

  def remove(key)
    key_hash = key.hash
    if self[key_hash].include?(key)
      self[key_hash].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
      @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }

    @store.each do |bucket|
      bucket.each do |key|
        new_store[key.hash % new_store.length].push(key)
      end
    end

    @store = new_store
  end
end
