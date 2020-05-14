class Mastermind
  attr_reader :message
  attr_reader :score
  attr_reader :current_guess

  def initialize
    @score = 0
    @code = generate_code
    @current_guess = []
  end

  def play
    until game_won? || game_lost?
      outputter
    end
    puts @message
  end

  private

  def code
    @code
  end

  def set_current_guess(arr)
    @current_guess = arr
  end

  def set_score(int)
    @score = int
  end

  def generate_code
    [ rand(6), rand(6), rand(6), rand(6) ]
  end

  def game_lost?
    @message = 'You lost' if score >= 6
    @message
  end

  def game_won?
    guess_inputter
    @message = 'You won' if current_guess == code
    @message
  end

  def valid?(guess)
    guess.match /[0-6]/
  end

  def guess_checker
    result = []
    (0...4).each do |i|
      if current_guess[i] == code[i]
        result << 'correct'
      elsif code.include? current_guess[i]
        result << 'close'
      else
        result << 'wrong'
      end
    end
    result
  end

  def guess_inputter
    set_score(score + 1)
    set_current_guess [ input, input, input, input ]
  end

  def input
    print "Guess a number between 0 and 6: "
    guess = gets()
    if valid?(guess)
      guess.to_i
    else
      puts "Please input a valid guess -_-"
      input()
    end
  end

  def outputter
    p "You're guess was: #{current_guess}"
    p "And it was #{guess_checker}"
  end
end
