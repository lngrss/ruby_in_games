class Tree
  def initialize(arr)
    @root = build_tree(arr.sort.uniq)
  end

  def root
    @root
  end

  def build_tree(arr)
    if arr.size < 2
      if arr
        root = Node.new(arr[0])
      end
    else
      root = Node.new(arr[arr.size / 2])
      root.left_node = build_tree(arr[0...(arr.size / 2)])
      root.right_node = build_tree(arr[(arr.size / 2)..])
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

        else ## and now shit is happening
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
#     ＼＼ ＿
# 　　 ＼(　•_•) F
# 　　　 <　⌒ヽ A
# 　　　/ 　 へ＼ B
# 　　 /　　/　＼＼ U
# 　　 |　ノ　　 ヽ_つ L
# 　　/　/ O
# 　 /　/| U
# 　(　(ヽ S
# 　|　|、＼
# 　| 丿 ＼ ⌒)
# 　| |　　) /
# `ノ )　　Lﾉ
  end

  def inorder
  end

  def preorder
  end

  def postorder
  end

  def depth(node)
  end

  def balanced?
  end

  def rebalance!
  end
end
