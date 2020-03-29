class Mastermind
  def initialize
    @score = 0
    @code = generate_code
    @current_guess = []
  end

  def generate_code
    [rand(6), rand(6), rand(6), rand(6)]
  end

  def game_lost?
    @message = 'You lost' if @score == 6
    @message
  end

  def game_won?
    guess_inputter
    @message = 'You won' if @current_guess == @code
    @message
  end

  def guess_validator
    result = []
    (0...4).each do |i|
      if @current_guess[i] == @code[i]
        result << 'correct'
      elsif @code.include? @current_guess[i]
        result << 'close'
      else
        result << 'wrong'
      end
    end
    result
  end

  def guess_inputter
    @score += 1
    @current_guess = [ input, input, input, input ]
  end

  def input
    print "Guess a number between 0 and 6: "
    gets().to_i
  end

  def outputter
    p "You're guess was: #{@current_guess}"
    p "And it was #{guess_validator}"
  end

  def play
    until game_won? || game_lost?
      outputter
    end
    puts @message
  end
end
