require "spec_helper"

RSpec.describe MindPlant::Report do
  subject { MindPlant::Report }

  it "prints the card names with their balance" do
    cards = {
      "Erik" => double(:Card, balance: 500, :valid? => true),
      "Joe" => double(:Card, balance: -93, :valid? => true)
    }

    report = subject.new(cards)

    expect($stdout).to receive(:puts).with("Erik: $500").ordered
    expect($stdout).to receive(:puts).with("Joe: $-93").ordered

    report.print_summary
  end

  it "prints the names in alphabetical order" do
    cards = {
      "Joe" => double(:Card, balance: -93, :valid? => true),
      "Erik" => double(:Card, balance: 500, :valid? => true)
    }

    report = subject.new(cards)

    expect($stdout).to receive(:puts).with("Erik: $500").ordered
    expect($stdout).to receive(:puts).with("Joe: $-93").ordered

    report.print_summary
  end

  it "prints an error in place of balance for invalid cards" do
    cards = {
      "Joe" => double(:Card, balance: -93, :valid? => true),
      "Quincy" => double(:Card, :valid? => false),
      "Erik" => double(:Card, balance: 500, :valid? => true)
    }

    report = subject.new(cards)

    expect($stdout).to receive(:puts).with("Erik: $500").ordered
    expect($stdout).to receive(:puts).with("Joe: $-93").ordered
    expect($stdout).to receive(:puts).with("Quincy: error").ordered

    report.print_summary
  end
end