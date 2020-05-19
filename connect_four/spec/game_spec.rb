require './game'

describe Game do
  before(:each) do
    game = Game.new
    player = double('Player', :name => 'Peter', :symbol => '#', :input => '2')
  end

  describe '#move' do
    it 'takes a player calls board.make_move' do
      game.move(player)
      expect(game.board.field[0][1]).to eql('#')
    end
  end

  describe '#won?' do
    context 'when the game is not won' do
      it 'returns false' do
        expect(game.won?).to be false
      end
    end

    context 'when the game is won because the board has four in a row vertically' do
      it 'returnes true and sets message' do
        4.times { game.move(player) }
        expect(game.won?).to be true
        expect(game.message).to eql('Good job, Peter! You won!')
      end
    end

    context 'when the game is won because the board has four in a row horizontally' do
      it 'returnes true and sets message' do
        game.board.make_move(1, '#')
        game.board.make_move(2, '#')
        game.board.make_move(3, '#')
        game.board.make_move(4, '#')
        expect(game.won?).to be true
        expect(game.message).to eql('Good job, Peter! You won!')
      end
    end

    context 'when the game is won because the board has four in a row diagonally' do
      it 'returnes true and sets message' do
        3.times { game.board.make_move(0, '+') }
        2.times { game.board.make_move(1, '+') }
        1.times { game.board.make_move(2, '+') }
        (0..3).each { |i| game.board.make_move(i, '#') }
        expect(game.won?).to be true
        expect(game.message).to eql('Good job, Peter! You won!')
      end
    end
  end

  describe '#lost?' do
    context 'when the game is not lost' do
      it 'returns false' do
        expect(game.lost?).to be false
      end
    end

    context 'when the game is lost' do
      it 'returnes true and sets message' do
        3.times do
          game.board.make_move(0, '+')
          game.board.make_move(1, '+')
          game.board.make_move(2, '+')
          game.board.make_move(3, '#')
          game.board.make_move(4, '+')
          game.board.make_move(5, '+')
          game.board.make_move(6, '+')
          game.board.make_move(0, '#')
          game.board.make_move(1, '#')
          game.board.make_move(2, '#')
          game.board.make_move(3, '+')
          game.board.make_move(4, '#')
          game.board.make_move(5, '#')
          game.board.make_move(6, '#')
        end
        expect(game.lost?).to be false
        expect(game.message).to eql('Oh no, this game is over')
      end
    end
  end
end
