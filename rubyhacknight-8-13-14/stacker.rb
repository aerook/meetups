require 'pry'
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

        # Need to handle the '=' explicty; can't define self.= in ruby.
        # Swapping with 'EQUALITY'
        item = (item == '=' ? 'EQUALITY' : item)

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
    IMPLEMENTED_OPERATIONS = %w(ADD SUBTRACT MULTIPLY DIVIDE MOD > < EQUALITY)
    # expose working operations:
    def self.operations
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

    def self.<(numbers)
      numbers[0] < numbers[1] ? :true : :false
    end

    def self.>(numbers)
      numbers[0] > numbers[1] ? :true : :false
    end

    def self.equality(numbers)
      numbers[0] == numbers[1] ? :true : :false
    end

  end


end
