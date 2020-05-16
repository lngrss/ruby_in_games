require './node'

describe Node do
  let(:node) { Node.new(23) }

  describe '#new' do
    it 'should return a Node' do
      expect(node).to be_instance_of(Node)
    end
  end

  describe '#<=>' do
    context 'when one node has a bigger value' do
      it 'should return true if the first nodes value is smaller' do
        node_1 = Node.new(32)
        expect(node < node_1).to be true
      end
      it 'should return false if the first node is not smaller' do
        node_1 = Node.new(12)
        expect(node < node_1).to be false
      end
    end
    context 'when two nodes have equal values' do
      it 'should return true if the nodes have the same value' do
        node_1 = Node.new(23)
        expect(node == node_1).to be true
      end
      it 'should return false if the nodes do not have the same value' do
        node_1 = Node.new(21)
        expect(node == node_1).to be false
      end
    end
  end
end
