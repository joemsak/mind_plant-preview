module MindPlant
  class Application
    attr_reader :cards

    def initialize
      @cards = {}
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
      card = Card.new(tokenizer.card_number, tokenizer.card_limit)
      cards[tokenizer.name] = card
    end

    def charge(tokenizer)
      cards[tokenizer.name].charge(tokenizer.amount)
    end

    def credit(tokenizer)
      cards[tokenizer.name].credit(tokenizer.amount)
    end
  end
end