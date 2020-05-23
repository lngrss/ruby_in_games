class Board
  attr_reader :field
  attr_reader :size

  def initialize(size)
    @size = size
    @field = Array.new(size, Array.new(size, '.'))
  end

  def make_move(column, sym)
    if column.between?(0, size - 1) && @field[column][size - 1] == '.'
      found_it = false
      @field[column] = @field[column].map do |field|
        if field == '.' && !found_it
          found_it = true
          sym
        else
          field
        end
      end
    end
  end

  def get_diagonals
    get_slash_diagonals + get_backslash_diagonals
  end

  def print_board
    (0..(size - 1)).each do |i|
      line = ""
      @field.each { |arr| line += " #{arr[size - 1 - i]}" }
      puts line
    end
  end

  private

  def get_slash_diagonals(arr=@field)
    diagonals, x, y = [], 1, 1
    while x < size do
      diagonals << (0...(arr.size - x)).map { |i| arr[x + i][i] }
      diagonals << (0...(arr.size - x)).map { |i| arr[i][x + i] }
      x +=  1
    end
    diagonals << (0...arr.size).map { |i| arr[i][i] }
  end

  def get_backslash_diagonals
    get_slash_diagonals @field.reverse
  end
end
