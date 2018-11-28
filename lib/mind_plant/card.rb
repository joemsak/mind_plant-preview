module MindPlant
  class Card
    attr_accessor :name, :number, :limit

    attr_reader :number_validator, :charges, :credits

    def initialize(name, number, limit, number_validator = Luhn)
      @name = name
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
      apply_charge(amount) if charge_can_be_applied?(amount)
    end

    def credit(amount)
      apply_credit(amount) if valid?
    end

    private
    def charge_can_be_applied?(amount)
      valid? && balance + amount <= limit
    end

    def apply_charge(amount)
      charges.push(amount)
    end

    def apply_credit(amount)
      credits.push(amount)
    end
  end
end