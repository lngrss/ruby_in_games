class Calculator
  def add(*args)
    args.sum
  end

  def multiply(*args)
    result = 1
    args.each { |arg| result = result * arg }
    result
  end

  def substract(*args)
    result = args[0]
    args[1..].each { |arg| result -= arg }
    result
  end

  def divide(*args)
    result = args[0]
    args[1..].each { |arg| result /= arg }
    result
  end
end
