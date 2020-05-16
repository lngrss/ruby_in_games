class Tree
  def initialize(arr)
    @root = build_tree(arr.sort.uniq)
  end

  def root
    @root
  end

  def build_tree(arr)
    if arr.size < 2
      unless arr.empty?
        root = Node.new(arr[0])
      end
    else
      root = Node.new(arr[arr.size / 2])
      root.left_node = build_tree(arr[0...(arr.size / 2)])
      root.right_node = build_tree(arr[((arr.size / 2) + 1)..])
    end
    root
  end

  def insert(value)
    node = @root
    while node
      if value < node.value
        if node.left_node
          node = node.left_node
        else
          node.left_node = Node.new(value)
          break
        end
      else
        if node.right_node
          node = node.right_node
        else
          node.right_node = Node.new(value)
          break
        end
      end
    end
  end

  def delete(value, root=@root)
    node = @root
    parent = nil
    is_left = nil
    while node
      if value < node.value
        parent = node
        node = node.left_node
        is_left = true
      elsif value > node.value
        parent = node
        node = node.right_node
        is_left = false
      else ## found our node

        if !node.left_node && !node.right_node ## found a leaf
          if is_left
            parent.left_node = nil
          else
            parent.right_node = nil if parent
          end
          node = nil ##wiping it off memory

        elsif !node.left_node ## only right node has a value
          if is_left
            parent.left_node = node.right_node
          else
            if parent
              parent.right_node = node.right_node
            else
              @root = node.right_node
            end
          end
          node = nil

        elsif !node.right_node ## only right node has a value
          if is_left
            parent.left_node = node.left_node
          else
            if parent
              parent.right_node = node.left_node
            else
              @root = node.left_node
            end
          end
          node = nil

        else
          ## find max from left
          parent = node
          potential = node.left_node
          is_left =  true
          while potential.right_node ##while there is still a bigger value
            parent = potential
            is_left = false
            potential = potential.right_node
          end
          ## found maximum of left tree in potential
          node.value = potential.value
          ## delete potential
          if is_left
            parent.left_node = potential.left_node
          else
            parent.right_node = potential.left_node
          end
          potential = nil
        end
      end
    end
  end

  def find(value)
    node = @root
    while node
      if value < node.value
        node = node.left_node
      elsif value > node.value
        node = node.right_node
      else
        return node
      end
    end
    node
  end

  def level_order
    if block_given?
      queue = [@root]
      queue.each do |item|
        if item
          yield item
          queue << item.left_node if item.left_node
          queue << item.right_node if item.right_node
        end
        queue.drop(1)
      end
    else
      queue = [@root]
      result = []
      queue.each do |item|
        if item
          result << item.value
          queue << item.left_node if item.left_node
          queue << item.right_node if item.right_node
        end
        queue.drop(1)
      end
      result
    end
  end

  def inorder(node=@root, &block)
    if block_given?
      if !node.left_node && !node.right_node ##leaf element
        yield node
      else
        inorder(node.left_node, &block) if node.left_node
        yield node
        inorder(node.right_node, &block) if node.right_node
      end
    else
      result = []
      if !node.left_node && !node.right_node
        result << node.value
      else
        result += inorder(node.left_node) if node.left_node
        result << node.value
        result += inorder(node.right_node) if node.right_node
      end
      result
    end
  end

  def preorder(node=@root, &block)
    if block_given?
      if !node.left_node && !node.right_node ##leaf element
        yield node
      else
        yield node
        preorder(node.left_node, &block) if node.left_node
        preorder(node.right_node, &block) if node.right_node
      end
    else
      result = []
      if !node.left_node && !node.right_node
        result << node.value
      else
        result << node.value
        result += preorder(node.left_node) if node.left_node
        result += preorder(node.right_node) if node.right_node
      end
      result
    end
  end

  def postorder(node=@root, &block)
    if block_given?
      if !node.left_node && !node.right_node ##leaf element
        yield node
      else
        postorder(node.left_node, &block) if node.left_node
        postorder(node.right_node, &block) if node.right_node
        yield node
      end
    else
      result = []
      if !node.left_node && !node.right_node
        result << node.value
      else
        result += postorder(node.left_node) if node.left_node
        result += postorder(node.right_node) if node.right_node
        result << node.value
      end
      result
    end
  end

  def depth(node)
    count = -1
    searched = []
    to_be_searched = [node]
    while to_be_searched.any? do
      searched = to_be_searched
      to_be_searched = []
      searched.each do |node|
        to_be_searched << node.left_node if node.left_node
        to_be_searched << node.right_node if node.right_node
      end
      count += 1
    end
    count
  end

  def balanced?(node=@root)
    left_balanced = node.left_node ? balanced?(node.left_node) : true
    right_balanced = node.right_node ? balanced?(node.right_node) : true
    height_difference_ok = (depth(node.left_node) - depth(node.right_node)).abs < 2
    left_balanced && right_balanced && height_difference_ok
  end

  def rebalance!
    @root = build_tree(inorder)
  end
end
