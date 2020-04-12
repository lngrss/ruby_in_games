require 'pry'

class LinkedList
  def append(value)
    if @head
      node = tail
      node.next_node = Node.new(value)
    else
      @head = Node.new(value)
    end
  end

  def prepend(value)
    node = @head
    @head = Node.new(value)
    @head.next_node = node
  end

  def size
    size = 0
    if @head
      node = @head
      while node
        size += 1
        node = node.next_node
        break unless node
      end
    end
    size
  end

  def head
    @head
  end

  def tail
    node = @head
    node = node.next_node while node.next_node
    node
  end

  def at(index)
    node = @head
    index.times do
      break unless node
      node = node.next_node
    end
    node
  end

  def pop
    if @head
      if @head.next_node
        node = @head
        while node.next_node.next_node
          node = node.next_node
        end
        node.next_node = nil
      else
        @head = nil
      end
    end
  end

  def contains?(value)
    result = false
    node = @head
    while node
      result = (node.value == value)
      node = node.next_node
      break if result || !node
    end
    result
  end

  def find(value)
    node = @head
    i = 0
    while node
      index = i if node.value == value
      i += 1
      node = node.next_node
      break unless node
    end
    index
  end

  def to_s
    result = ''
    node = @head
    while node
      result += "( #{node.value} ) -> "
      node = node.next_node
      break unless node
    end
    result += "nil"
  end

  def insert_at(value, index)
    if @head
      previous_node = @head
      node = @head.next_node
      (index - 1).times do
        break unless node
        previous_node = node
        node = node.next_node
      end
      previous_node.next_node = Node.new(value, node)
    else
      @head = Node.new(value)
    end
  end

  def remove_at(index)
    if @head
      previous_node = @head
      node = @head.next_node
      (index - 1).times do
        break unless node
        previous_node = node
        node = node.next_node
      end
      previous_node.next_node = node ? node.next_node : nil
    end
  end

  private

  def each
    # loop over list. Should accept a block
  end
end

class Node
  attr_accessor :value
  attr_accessor :next_node

  def initialize(value=nil, next_node=nil)
    @value = value
    @next_node = next_node
  end
end

### main

list = LinkedList.new
list.append('First')
list.append('Second')
list.prepend('New First')

empty_lst = LinkedList.new
binding.pry
