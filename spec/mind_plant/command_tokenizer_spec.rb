require "spec_helper"

RSpec.describe MindPlant::CommandTokenizer do
  subject { MindPlant::CommandTokenizer }

  it "parses Add commands" do
    tokenizer = subject.new("Add Tom 4111111111111111 $1000")
    expect(tokenizer.command).to eq(:add)
  end

  it "parses Charge commands" do
    tokenizer = subject.new("Charge Tom $500")
    expect(tokenizer.command).to eq(:charge)
  end

  it "parses Credit commands" do
    tokenizer = subject.new("Credit Quincy $200")
    expect(tokenizer.command).to eq(:credit)
  end

  it "raises an Error for unrecognized commands" do
    expect {
      subject.new("Give Quincy $200")
    }.to raise_error(MindPlant::UnrecognizedCommandError)
  end

  it "parses names" do
    tokenizer = subject.new("Add Tom 4111111111111111 $5000")
    expect(tokenizer.name).to eq("Tom")
  end

  it "parses card numbers in Add commands" do
    tokenizer = subject.new("Add Tom 4111111111111111 $5000")
    expect(tokenizer.card_number).to eq("4111111111111111")
  end

  it "raises an Error on #card_number for other commands" do
    tokenizer = subject.new("Charge Tom $500")

    expect {
      tokenizer.card_number
    }.to raise_error(MindPlant::CommandDoesNotSupportCardNumbersError)
  end

  it "parses limit amounts" do
    tokenizer = subject.new("Add Tom 4111111111111111 $5000")
    expect(tokenizer.card_limit).to eq(5000)
  end

  it "raises an Error on #card_limit for other commands" do
    tokenizer = subject.new("Charge Tom $500")

    expect {
      tokenizer.card_limit
    }.to raise_error(MindPlant::CommandDoesNotSupportCardLimitsError)
  end
end