module MindPlant
  class Application
    attr_reader :cards

    def initialize
      @cards = []
    end

    def run_command(command)
      tokenizer = CommandTokenizer.new(command)
      send(tokenizer.command, tokenizer)
    end

    def print_report
      report = Report.new(cards)
      report.print_summary
    end

    private
    def add(tokenizer)
      card = Card.new(
        tokenizer.name,
        tokenizer.card_number,
        tokenizer.card_limit
      )

      cards.push(card)
    end

    def charge(tokenizer)
      card = find_card_by_name(tokenizer.name)
      card.charge(tokenizer.amount)
    end

    def credit(tokenizer)
      card = find_card_by_name(tokenizer.name)
      card.credit(tokenizer.amount)
    end

    def find_card_by_name(name)
      cards.detect { |c| c.name == name }
    end
  end
end