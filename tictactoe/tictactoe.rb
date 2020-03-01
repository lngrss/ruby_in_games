require 'pry'

class TicTacToe
  def initialize
    @play = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']] #x
  end

  def round(player, move)
    @play[move[0]][move[1]] = player
  end

  def input_valid?
    move.all? { |a| [0, 1, 2].include? a }
  end

  def move_valid? (move)
    @play[move[0]][move[1]] == ' '
  end

  def output
    result = @play.map { |row| " #{row.join(" | ")} " }.join("\n#{'-'* 11}\n")
    puts result
  end

  def game_over?
    @play.none? { |a| a.any? { |b| b == ' ' } }
  end

  def row_won
    @play.any? { |a| a[0] == a[1] && a[1] == a[2] && a[2] != ' ' }
  end

  def column_won
    false
  end

  def diagonal_won
    false
  end

  def game_won?
    row_won || column_won || diagonal_won
  end

  def get_move(player)
    puts "Time for your move, Player #{player}. Give me the row and column count of your play and remember to start counting at zero!"
    print 'Row: '
    row = gets().to_i
    print 'Column: '
    column = gets().to_i
    if move_valid? [row, column]
      return [row, column]
    else
      puts 'That move is not valid.'
      get_move(player)
    end
  end

  def play
    output
    until game_over? || game_won?
      for player in ['o', 'x']
        round(player, get_move(player))
        output()
        if game_won?
          puts "Congrats! Player #{player} won."
          break
        elsif game_over?
          puts "Ah damn, this round goes to the bank."
          break
        end
      end
    end
  end
end

game = TicTacToe.new
# binding.pry
game.play
