class Player
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def name
    @name
  end

  def symbol
    @symbol
  end

  def input
    puts "Your turn #{name}. Which column do you want to make your next move in?"
    gets().to_i
  end
end
