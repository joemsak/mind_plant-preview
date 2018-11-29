module MindPlant
  class CommandTokenizer
    VALID_COMMANDS = %i{
      add
      charge
      credit
    }

    private
    attr_reader :line, :tokens

    public
    attr_reader :command

    def initialize(line)
      @line = line
      @tokens = line.split(" ")
      @command = parse_command_from_tokens
    end

    def name
      tokens[1]
    end

    def card_number
      if command == :add
        tokens[2]
      else
        raise CommandDoesNotSupportCardNumbersError
      end
    end

    def card_limit
      # Reminder: In this iteration, the following input assumptions are true:
        # dollar amounts are always whole
        # and they always begin with a `$`
      if command == :add
        tokens[3].sub("$", "").to_i
      else
        raise CommandDoesNotSupportCardLimitsError
      end
    end

    private
    def parse_command_from_tokens
      token = tokens.first.downcase.to_sym

      if VALID_COMMANDS.include?(token)
        token
      else
        raise UnrecognizedCommandError
      end
    end
  end

  class UnrecognizedCommandError < Error; end
  class CommandDoesNotSupportCardNumbersError < Error; end
  class CommandDoesNotSupportCardLimitsError < Error; end
end