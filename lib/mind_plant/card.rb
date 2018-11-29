require 'luhn'

module MindPlant
  class Card
    attr_accessor :number, :limit

    attr_reader :number_validator, :charges, :credits

    def initialize(number, limit, number_validator = Luhn)
      @number = number
      @limit = limit
      @number_validator = number_validator
      @charges = []
      @credits = []
    end

    def valid?
      number_validator.valid?(number)
    end

    def balance
      total_charges - total_credits
    end

    def total_charges
      charges.sum
    end

    def total_credits
      credits.sum
    end

    def charge(amount)
      charges.push(amount) if charge_can_be_applied?(amount)
    end

    def credit(amount)
      credits.push(amount) if valid?
    end

    private
    def charge_can_be_applied?(amount)
      valid? && balance + amount <= limit
    end
  end
end