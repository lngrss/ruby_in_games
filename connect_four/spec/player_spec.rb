require './player'

describe Player do
  before(:each) do
    allow($stdout).to receive(:write)
  end

  let(:player) { Player.new('Peter', '#') }

  describe '#new' do
    it 'creates a player instance' do
      expect(player).to be_instance_of(Player)
    end
  end

  describe '#name' do
    it 'returnes the name attribute of the Player instance' do
      expect(player.name).to eql('Peter')
    end
  end

  describe '#symbol' do
    it 'returnes the symbol attribute of the Player instance' do
      expect(player.symbol).to eql('#')
    end
  end

  describe '#input' do
    it 'prompts for inout and returns the user input' do
      allow(player).to receive(:gets).and_return('1')
      expect(player.input).to eql(1)
    end
  end
end
