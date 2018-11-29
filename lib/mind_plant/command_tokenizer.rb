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
      for_supported_commands(:add) do
        tokens[2]
      end
    end

    def amount
      for_supported_commands(:charge, :credit) do
        sanitize_dollar_amount(tokens[2])
      end
    end

    def card_limit
      for_supported_commands(:add) do
        sanitize_dollar_amount(tokens[3])
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

    def sanitize_dollar_amount(token)
      # Reminder: In this iteration, the following input assumptions are true:
        # dollar amounts are always whole
        # and they always begin with a `$`
      token.sub("$", "").to_i
    end

    def for_supported_commands(*supported_commands, &block)
      if supported_commands.include?(command)
        block.call
      else
        method_name = caller_locations(1,1)[0].label
        raise_unsupported_method_for_command_error(method_name)
      end
    end

    def raise_unsupported_method_for_command_error(method_name)
      error_name = "command_does_not_support_#{method_name}_error"
      error_const = error_name.split('_').map(&:capitalize).join
      raise Object.const_get("MindPlant::#{error_const}")
    end
  end

  class UnrecognizedCommandError < Error; end
  class CommandDoesNotSupportCardNumberError < Error; end
  class CommandDoesNotSupportCardLimitError < Error; end
  class CommandDoesNotSupportAmountError < Error; end
end