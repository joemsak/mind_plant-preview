module MindPlant
  class Report
    attr_reader :cards

    def initialize(cards)
      @cards = cards
    end

    def print_summary
      cards.sort_by(&:name).each do |card|
        $stdout.puts(build_summary(card))
      end
    end

    private
    def build_summary(card)
      name = "#{card.name}: "

      if card.valid?
        name + "$#{card.balance}"
      else
        name + "error"
      end
    end
  end
end