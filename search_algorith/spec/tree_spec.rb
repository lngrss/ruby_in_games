require './tree'

describe Tree do
  let(:tree) { Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) }

  describe '#new' do
    it 'should be an instance of Tree' do
      expect(tree).to be_instance_of(Tree)
    end
  end

  describe '#root' do
    it 'should have value 8' do
      expect(tree.root.value).to eql(8)
    end
  end

  describe '#insert' do
    it 'should insert the node at the correct spot' do
      tree.insert(32)
      expect(tree.root.right_node.left_node.right_node).to eq(Node.new(32))
    end
  end

  describe '#delete' do
    context 'delete leaf Node' do
      it 'should delete the Node with the given value from the tree' do
        tree.delete(32)
        expect(tree.root.right_node.left_node.right_node).to be_nil
      end
    end

    context 'delete Node with one branch' do
      it 'should delete the Node with the given value from the tree' do
        tree.delete(3)
        expect(tree.root.left_node.left_node).to eq(Node.new(1))
      end
    end

    context 'delete Node with two branches' do
      it 'should delete the Node with the given value from the tree' do
        tree.delete(8)
        expect(tree.root.value).to eql(7)
        expect(tree.root.left_node.right_node).to eq(Node.new(5))
      end
    end
  end

  describe '#find' do
    it 'should return Node for the given value' do
      left = Node.new(9)
      expect(tree.find(23)).to eq(Node.new(23, left))
    end
  end

  describe '#level_order' do
    context 'when a block is passed' do
      it 'shoud return the result of the Nodes passed to the block in level order' do
        arr = []
        tree.level_order { |node| arr << node.value * 10 }
        expect(arr).to eql([80, 40, 670, 30, 70, 230, 63450, 10, 50, 90, 3240])
      end
    end
    context 'when no block is passed' do
      it 'shoud return an array of the Nodes values in level order' do
        expect(tree.level_order).to eql([8, 4, 67, 3, 7, 23, 6345, 1, 5, 9, 324])
      end
    end
  end

  describe '#inorder' do
    context 'when a block is passed' do
      it 'should return the result of the Nodes passed to the block inorder' do
        arr = []
        tree.inorder { |node| arr << node.value }
        expect(arr).to eql([1, 3, 4, 5, 7, 8, 9, 23, 67, 324, 6345])
      end
    end
    context 'when no block is passed' do
      it 'should return an array of the Nodes values in level order' do
        expect(tree.inorder).to eql([1, 3, 4, 5, 7, 8, 9, 23, 67, 324, 6345])
      end
    end
  end

  describe '#preorder' do
    context 'when a block is passed' do
      it 'should return the result of the Nodes passed to the block preorder' do
        arr = []
        tree.preorder { |node| arr << node.value }
        expect(arr).to eql([8, 4, 3, 1, 7, 5, 67, 23, 9, 6345, 324])
      end
    end
    context 'when no block is passed' do
      it 'should return an array of the Nodes values preorder' do
        expect(tree.preorder).to eql([8, 4, 3, 1, 7, 5, 67, 23, 9, 6345, 324])
      end
    end
  end

  describe '#postorder' do
    context 'when a block is passed' do
      it 'should return the result of the Nodes passed to the block postorder' do
        arr = []
        tree.postorder { |node| arr << node.value }
        expect(arr).to eql([1, 3, 5, 7, 4, 9, 23, 324, 6345, 67, 8])
      end
    end
    context 'when no block is passed' do
      it 'should return an array of the Nodes values postorder' do
        expect(tree.postorder).to eql([1, 3, 5, 7, 4, 9, 23, 324, 6345, 67, 8])
      end
    end
  end

  describe '#depth' do
    it 'should return the depth of the passed Node' do
      node = tree.find(7)
      expect(tree.depth(node)).to eql(1)
    end
  end

  describe 'balanced?' do
    context 'when the tree is balanced' do
      it 'should return true' do
        expect(tree.balanced?).to be true
      end
    end
    context 'when the tree is not balanced' do
      it 'should return false' do
        tree.insert(323)
        tree.insert(322)
        tree.insert(321)
        expect(tree.balanced?).to be false
      end
    end
  end

  describe '#rebalance!' do
    it 'should rebalance the unbalanced tree' do
      tree.insert(323)
      tree.insert(322)
      tree.insert(321)
      tree.rebalance!
      expect(tree.balanced?).to be true
    end
  end
end
