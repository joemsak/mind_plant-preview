require "mind_plant/version"

module MindPlant
  autoload :Card, 'mind_plant/card'
  autoload :CommandTokenizer, 'mind_plant/command_tokenizer'

  class Error < StandardError; end
  # Your code goes here...
end
