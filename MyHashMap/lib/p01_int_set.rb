class MaxIntSet
  def initialize(max)
    @store = Array.new(max){ false }
    @max = max
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    raise "input invalid" unless is_valid?(num) && @store[num]
    @store[num] = false
  end

  def include?(num)
    raise "input invalid" unless is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num <= @max && num >= 0
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless self.include?(num)
      self[num].push(num)
    end
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % 20]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self[num].include?(num)
      @count += 1
      self[num] << num
    end

    if @count == num_buckets
      resize!
    end
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
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
      bucket.each do |value|
        new_store[value % new_store.length].push(value)
      end
    end

    @store = new_store
  end
end
