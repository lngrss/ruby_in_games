require './mastermind'

describe Mastermind do
  let(:game) { Mastermind.new }

  describe '#generate_code' do
    it 'returns array of 4 random numbers between 0 and 6' do
      game.send(:generate_code).each do |rand|
        expect(rand).to be_between(0, 6).inclusive
      end
    end
  end

  describe '#game_won?' do
    it 'changes game message (or state) to game won' do
      game.send(:set_current_guess, game.send(:code))
      allow(game).to receive(:guess_inputter).and_return(nil)
      game.send(:game_won?)
      expect(game.message).to eql('You won')
    end
  end

  describe '#game_lost' do
    it 'changes game message (or state) to game lost' do
      game.send(:set_score, 7)
      game.send(:game_lost?)
      expect(game.message).to eql('You lost')
    end
  end

  describe '#valid?' do
    context 'the guess is valid' do
      it 'returns true' do
        expect(game.send(:valid?, '2')).to be_truthy
      end
    end

    context 'the guess is not valid' do
      it 'returns false' do
        expect(game.send(:valid?, 'XX')).to be_falsey
      end
    end
  end

  describe '#guess_checker' do
    context 'all guesses are wrong' do
      it 'returns an array of wrong' do
        allow(game).to receive(:generate_code).and_return([ 1, 2, 3, 4])
        game.send(:set_current_guess, [5, 6, 5, 6])
        expect(game.send(:guess_checker)).to eql([ 'wrong', 'wrong', 'wrong', 'wrong' ])
      end
    end

    context 'at least one guess is included in the code but at the wrong place' do
      it 'returns an array of hints with string close at the position of the close guess' do
      end
    end

    context 'at least one guess is correct' do
      it 'returns an array of hints with string correct at the position of the correct guess' do
      end
    end
  end


end
