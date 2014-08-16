module Stacker
  class Interpreter
    def initialize
      @results = Array.new
      @call_chain = Array.new
    end

    def execute(item)
      @call_chain << item
    end

    def stack
      params_start = 0
      @call_chain.each_with_index do |item, index|
        if Calculator.operations.include?(item)
          params_end = index - 1
          params = @call_chain[params_start..params_end].map {|n| n.to_i}
          @results << Calculator.send(item.downcase, params)
          params_start = index + 1
        end
      end
      @results
    end

  end

  class Calculator
    IMPLEMENTED_OPERATIONS = %w(ADD SUBTRACT MULTIPLY DIVIDE MOD)
    # expose working operations:
    def operations
      IMPLEMENTED_OPERATIONS
    end

    def self.add(numbers)
      numbers.inject(:+)
    end

    def self.subtract(numbers)
      numbers.inject(:-)
    end

    def self.multiply(numbers)
      numbers.inject(:*)
    end

    def self.divide(numbers)
      numbers.inject(:/)
    end

    def self.mod(numbers)
      numbers.inject(:%)
    end

  end
end
