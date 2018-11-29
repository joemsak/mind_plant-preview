require "spec_helper"

RSpec.describe MindPlant::Application do
  its(:cards) { is_expected.to be_empty }

  describe "#run_command" do
    it "adds cards" do
      expect {
        subject.run_command("Add Tom 4111111111111111 $1000")
      }.to change {
        subject.cards.count
      }.from(0).to(1)

      card = subject.cards.first
      expect(card.name).to eq("Tom")
      expect(card.number).to eq("4111111111111111")
      expect(card.limit).to eq(1000)
    end

    it "charges cards" do
      subject.run_command("Add Tom 4111111111111111 $1000")
      card = subject.cards.first

      expect {
        subject.run_command("Charge Tom $50")
      }.to change {
        card.charges.count
      }.from(0).to(1)
      .and change {
        card.balance
      }.from(0).to(50)
    end

    it "ignores invalid charges" do
      subject.run_command("Add Tom 4111111111111111 $1000")
      card = subject.cards.first

      expect {
        subject.run_command("Charge Tom $1001")
      }.to not_change {
        card.charges.count
      }.and not_change {
        card.balance
      }
    end

    it "ignores charges on invalid cards" do
      subject.run_command("Add Tom 4111111111111112 $1000")
      card = subject.cards.first

      expect {
        subject.run_command("Charge Tom $50")
      }.to not_change {
        card.charges.count
      }.and not_change {
        card.balance
      }
    end

    it "credits cards" do
      subject.run_command("Add Tom 4111111111111111 $1000")
      card = subject.cards.first

      expect {
        subject.run_command("Credit Tom $50")
      }.to change {
        card.credits.count
      }.from(0).to(1)
      .and change {
        card.balance
      }.from(0).to(-50)
    end

    it "ignores credits on invalid cards" do
      subject.run_command("Add Tom 4111111111111112 $1000")
      card = subject.cards.first

      expect {
        subject.run_command("Credit Tom $50")
      }.to not_change {
        card.credits.count
      }.and not_change {
        card.balance
      }
    end
  end

  describe "#print_report" do
    it "prints the resulting summary of running commands" do
      subject.run_command("Add Tom 4111111111111111 $1000")
      subject.run_command("Add Lisa 5454545454545454 $3000")
      subject.run_command("Add Quincy 1234567890123456 $2000")

      subject.run_command("Charge Tom $500")
      subject.run_command("Charge Tom $800")
      subject.run_command("Charge Lisa $7")

      subject.run_command("Credit Lisa $100")
      subject.run_command("Credit Quincy $200")

      expect($stdout).to receive(:puts).with("Lisa: $-93").ordered
      expect($stdout).to receive(:puts).with("Quincy: error").ordered
      expect($stdout).to receive(:puts).with("Tom: $500").ordered

      subject.print_report
    end
  end
end