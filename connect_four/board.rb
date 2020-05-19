class Board
  attr_reader :field

  def initialize
    @field = Array.new(6, Array.new(7, '.'))
  end

  def make_move(column, sym)
    if column.between?(0, 6) && @field[5][column] == '.'
      @field.each do |line|
        if line[column] == '.'
          line[column] = sym
          break_loop = true
        end
        break if break_loop
      end
    end
  end

  def print_board
    @field.reverse.each { |line| puts line.join }
  end
end
