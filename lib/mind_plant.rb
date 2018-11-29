require "mind_plant/version"

module MindPlant
  autoload :Application, 'mind_plant/application'
  autoload :Card, 'mind_plant/card'
  autoload :CommandTokenizer, 'mind_plant/command_tokenizer'
  autoload :Report, 'mind_plant/report'

  class Error < StandardError; end
  # Your code goes here...
end
