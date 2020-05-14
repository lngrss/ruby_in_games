#spec/calculator_spec.rb
require './lib/calculator'

describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end

    it "returns the sum of more then two numbers" do
      calc = Calculator.new
      expect(calc.add(1, 4, 6, 5)).to eql(16)
    end
  end

  describe "#multiply" do
    it "returns the multiplication of three numbers" do
      calc = Calculator.new
      expect(calc.multiply(4, 7, 1)).to eql(28)
    end
  end

  describe "#substract" do
    it "returns the difference of given numbers" do
      calc = Calculator.new
      expect(calc.substract(1, 2, 3)).to eql(-4)
    end
  end

  describe "#divide" do
    it "returns the division of several numbers" do
      calc = Calculator.new
      expect(calc.divide(6, 3, 2)).to eql(1)
    end
  end 
end
