require './game'

describe Game do
  let(:player_1) { double('Player', :name => 'Peter', :symbol => '#', :input => 2) }
  let(:player_2) { double('Player', :name => 'Max', :symbol => '+', :input => 0) }
  let(:game) { Game.new(player_1, player_2) }


  describe '#new' do
    it 'creates a game instance' do
      expect(game).to be_instance_of(Game)
    end

    it 'takes two players and sets them as readable attributes' do
      expect(game.players).to eql([player_1, player_2])
    end

    it 'has a readable board attribute' do
      expect(game.board).to be_instance_of(Board)
    end
  end

  describe '#move' do
    it 'takes a player calls board.make_move' do
      game.move(player_1)
      expect(game.board.field[2][0]).to eql('#')
    end
  end

  describe '#won?' do
    context 'when the game is not won' do
      it 'takes a player and returns false' do
        expect(game.won?(player_1)).to be false
      end
    end

    context 'when the game is won because the board has four in a row vertically' do
      it 'takes a player and returnes true' do
        4.times { game.move(player_1) }
        expect(game.won?(player_1)).to be true
      end
    end

    context 'when the game is won because the board has four in a row horizontally' do
      it 'takes a player and returnes true' do
        game.board.make_move(1, '#')
        game.board.make_move(2, '#')
        game.board.make_move(3, '#')
        game.board.make_move(4, '#')
        expect(game.won?(player_1)).to be true
      end
    end

    context 'when the game is won because the board has four in a row diagonally' do
      it 'akes a player and returnes true' do
        3.times { game.board.make_move(0, '+') }
        2.times { game.board.make_move(1, '+') }
        1.times { game.board.make_move(2, '+') }
        (0..3).each { |i| game.board.make_move(i, '#') }
        expect(game.won?(player_1)).to be true
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
      it 'returns true' do
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
        expect(game.lost?).to be true
      end
    end
  end
end
