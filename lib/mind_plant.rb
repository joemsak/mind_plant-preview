require "mind_plant/version"

module MindPlant
  autoload :Application, 'mind_plant/application'
  autoload :Card, 'mind_plant/card'
  autoload :CommandTokenizer, 'mind_plant/command_tokenizer'
  autoload :Report, 'mind_plant/report'

  autoload :FileInput, 'mind_plant/file_input'
  autoload :ConsoleInput, 'mind_plant/console_input'

  class Error < StandardError; end
  # Your code goes here...
end
