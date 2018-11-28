module MindPlant
  class Card
    attr_accessor :name, :number, :limit

    def initialize(name, number, limit)
      @name = name
      @number = number
      @limit = limit
    end
  end
end