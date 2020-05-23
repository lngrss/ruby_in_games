require './board'

describe Board do
  let(:board) { Board.new(7) }

  before(:each) do
    allow($stdout).to receive(:write)
  end

  describe '#new' do
    it 'creates an instance of board' do
      expect(board).to be_instance_of(Board)
    end

    it 'creates a board object with an empty 6x7 field' do
      expect(board.field).to eql(Array.new(7, Array.new(7, '.')))
    end
  end

  describe '#make_move' do
    context 'when the move is in an existing and not yet full column' do
      it 'takes a column and a string and sets the move at the lowest point in the given column' do
        board.make_move(1, '#')
        expect(board.field[1][0]).to eql('#')
        expect(board.field[1][1]).to eql('.')
      end
    end

    context 'When the column is already full' do
      it 'takes a column and a string and does not change the game field' do
        7.times { board.make_move(1, '#') }
        expect(board.make_move(1, '#')).to eql nil
      end
    end

    context 'When a colum is passed that does not exist' do
      it 'takes a column and a string and does not change the board' do
        expect(board.make_move(10, '#')).to eql nil
      end
    end
  end

  describe '#get_diagonals' do
    it 'returns an array of arrays with all diagonals' do
      7.times { board.make_move(0, '#') }
      (1 ... 7).each { |i| board.make_move(i, '+') }
      arr = [
        ['+', '.', '.', '.', '.', '.'],
        ['#', '.', '.', '.', '.', '.'],
        ['+', '.', '.', '.', '.'],
        ['#', '.', '.', '.', '.'],
        ['+', '.', '.', '.'],
        ['#', '.', '.', '.'],
        ['+', '.', '.'],
        ['#', '.', '.'],
        ['+', '.'],
        ['#', '.'],
        ['+'],
        ['#'],
        ['#', '.', '.', '.', '.', '.', '.'],
        ['+', '.', '.', '.', '.', '#'],
        ['.', '.', '.', '.', '.', '.'],
        ['+', '.', '.', '.', '#'],
        ['.', '.', '.', '.', '.'],
        ['+', '.', '.', '#'],
        ['.', '.', '.', '.'],
        ['+', '.', '#'],
        ['.', '.', '.'],
        ['+', '#'],
        ['.', '.'],
        ['#'],
        ['.'],
        ['+', '.', '.', '.', '.', '.', '#'],
      ]
      expect(board.get_diagonals).to eql(arr)
    end
  end

  describe '#print_board' do
    it 'prints the board to the terminal' do
      3.times { board.make_move(0, '#') }
      str = " . . . . . . .\n . . . . . . .\n . . . . . . .\n . . . . . . .\n # . . . . . .\n # . . . . . .\n # . . . . . .\n"
      expect { board.print_board.inspect }.to output(str).to_stdout
    end
  end
end
