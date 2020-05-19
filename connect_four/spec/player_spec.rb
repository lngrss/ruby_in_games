require './player'

describe Player do
  before(:each) do
    allow($stdout).to receive(:write)
    player = Player.new('Peter', '#')
  end

  describe '#new' do
    it 'creates a player instance' do
      expect(player).to be_instance_of(Player)
    end
    it 'initializes the player object with a name and a symbol' do
      expect(:player).to have_attributes(:name => 'Peter', :symbol => '#')
    end
  end

  describe '#input' do
    it 'prompts for inout and returns the user input' do
      allow(:player).to receive(:gets).and_return(1)
      expect(player.input).to eql(2)
    end
  end
end
