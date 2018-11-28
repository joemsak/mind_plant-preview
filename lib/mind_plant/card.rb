module MindPlant
  class Card
    attr_accessor :name, :number, :limit

    attr_reader :number_validator

    def initialize(name, number, limit, number_validator = Luhn)
      @name = name
      @number = number
      @limit = limit
      @number_validator = number_validator
    end

    def valid?
      number_validator.valid?(number)
    end

    def balance
      0
    end
  end
end