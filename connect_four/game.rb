class Game
  attr_reader :players
  attr_reader :board

  def initialize(player_1, player_2)
    @players = [player_1, player_2]
    @board = Board.new(7)
    @message = nil
  end

  def play
    until @message
      keep_moving
    end
    @board.print_board
    puts @message
  end

  def keep_moving
    players.each do |player|
      @board.print_board
      move player
      if won? player
        @message = "Congrats #{player.name}, you won!"
        break
      elsif lost?
        @message = "Upps, this game is lost"
        break
      end
    end
  end

  def move(player)
    @board.make_move(player.input, player.symbol)
  end

  def won?(p)
    four_in_line_diagonally?(p) || four_in_line_vertically?(p) || four_in_line_horizontally?(p)
  end

  def lost?
    @board.field.all? { |column| column[5] != '.' }
  end

  private

  def four_in_line_vertically?(player)
    @board.field.any? { |column| column.join.include? player.symbol * 4 }
  end

  def four_in_line_horizontally?(player)
    (0..6).any? do |i|
      @board.field.map { |x| x[i] }.join.include? player.symbol * 4
    end
  end

  def four_in_line_diagonally?(player)
    @board.get_diagonals.any? { |dia| dia.join.include? player.symbol * 4 }
  end
end
