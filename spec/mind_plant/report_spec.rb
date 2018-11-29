require "spec_helper"

RSpec.describe MindPlant::Report do
  subject { MindPlant::Report }

  it "prints the card names with their balance" do
    cards = [
      double(:Card, name: "Erik", balance: 500, :valid? => true),
      double(:Card, name: "Joe", balance: -93, :valid? => true)
    ]

    report = subject.new(cards)

    expect($stdout).to receive(:puts).with("Erik: $500").ordered
    expect($stdout).to receive(:puts).with("Joe: $-93").ordered

    report.print_summary
  end

  it "prints the names in alphabetical order" do
    cards = [
      double(:Card, name: "Joe", balance: -93, :valid? => true),
      double(:Card, name: "Erik", balance: 500, :valid? => true)
    ]

    report = subject.new(cards)

    expect($stdout).to receive(:puts).with("Erik: $500").ordered
    expect($stdout).to receive(:puts).with("Joe: $-93").ordered

    report.print_summary
  end

  it "prints an error in place of balance for invalid cards" do
    cards = [
      double(:Card, name: "Joe", balance: -93, :valid? => true),
      double(:Card, name: "Quincy", :valid? => false),
      double(:Card, name: "Erik", balance: 500, :valid? => true)
    ]

    report = subject.new(cards)

    expect($stdout).to receive(:puts).with("Erik: $500").ordered
    expect($stdout).to receive(:puts).with("Joe: $-93").ordered
    expect($stdout).to receive(:puts).with("Quincy: error").ordered

    report.print_summary
  end
end