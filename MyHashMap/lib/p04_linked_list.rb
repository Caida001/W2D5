# class Node
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next
    self.next.prev = self.prev
  end
end

class Sentinel < Node
  def initialize
    @next = nil
    @prev = nil
  end

  def remove
    raise "can't be removed"
  end

  def to_s
    raise "no show"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @sen_head = Sentinel.new
    @sen_tail = Sentinel.new
    @sen_head.next = @sen_tail
    @sen_tail.prev = @sen_head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sen_head.next
  end

  def last
    @sen_tail.prev
  end

  def empty?
    (@sen_head.next == @sen_tail) && (@sen_tail.prev == @sen_head)
  end

  def get(key)
    return nil if self.empty?
    node = self.first
    until node.key == key
      return nil if node == @sen_tail
      node = node.next
    end
    node.val
  end

  def include?(key)
    return false if self.empty?
    node = self.first
    until node.key == key
      return false if node == @sen_tail
      node = node.next
    end
    true
  end

  def append(key, val)
    new_node = Node.new(key, val)
    @sen_tail.prev.next = new_node
    new_node.prev = @sen_tail.prev
    @sen_tail.prev = new_node
    new_node.next = @sen_tail

    new_node
  end

  def update(key, val)
    return nil if self.empty?
    node = self.first
    until node.key == key

      node = node.next
      return nil if node == self.last
    end
    node.val = val
  end

  def remove(key)
    return nil if self.empty?
    node = self.first
    until node.key == key
      return nil if node == @sen_tail
      node = node.next
    end

    node.prev.next = node.next
    node.next.prev = node.prev
  end

  def each
    return nil if self.empty?
    node = self.first
    until node == @sen_tail
      yield node
      node = node.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
