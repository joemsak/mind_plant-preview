module MindPlant
  class Card
    attr_accessor :name, :number, :limit

    attr_reader :number_validator, :charges

    def initialize(name, number, limit, number_validator = Luhn)
      @name = name
      @number = number
      @limit = limit
      @number_validator = number_validator
      @charges = []
    end

    def valid?
      number_validator.valid?(number)
    end

    def balance
      charges.sum { |c| c[:amount] }
    end

    def charge(amount)
      if balance + amount <= limit
        @charges.push({
          processed_at: Time.now.to_i,
          amount: amount
        })
      end
    end
  end
end