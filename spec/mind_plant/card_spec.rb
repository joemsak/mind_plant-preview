require "spec_helper"

RSpec.describe MindPlant::Card do
  let(:valid_number) { '4111111111111111' }
  let(:number_validator) { double(:NumberValidator, :valid? => true) }

  subject do
    MindPlant::Card.new(valid_number, 10_000, number_validator)
  end

  describe "attributes" do
    its(:number)           { is_expected.to eq(valid_number) }
    its(:limit)            { is_expected.to eq(10_000) }
    its(:number_validator) { is_expected.to eq(number_validator) }
    its(:balance)          { is_expected.to eq(0) }
    its(:charges)          { are_expected.to be_empty }
    its(:credits)          { are_expected.to be_empty }
  end

  describe "#valid?" do
    it "validates its numbers with the validator" do
      expect(number_validator).to receive(:valid?).with(valid_number).and_return(true)
      expect(subject.valid?).to be true
    end
  end

  describe "#charge" do
    it "adds to the list of charges" do
      subject.charge(10)
      expect(subject.charges).to eq([10])
    end

    it "affects the balance" do
      expect {
        subject.charge(10)
        subject.charge(9.99)
        subject.charge(18.76)
      }.to change {
        subject.balance
      }.from(0).to(38.75)
    end

    it "ignores charges which would increase the balance beyond the limit" do
      expect {
        subject.charge(10_000.01)
      }.to not_change {
        subject.charges.count
      }.and not_change {
        subject.balance
      }
    end

    it "ignores charges on invalid cards" do
      expect(number_validator).to receive(:valid?)
        .with(valid_number)
        .and_return(false)

      expect {
        subject.charge(10)
      }.to not_change {
        subject.charges.count
      }.and not_change {
        subject.balance
      }
    end
  end

  describe "#credit" do
    it "adds to the list of credits" do
      subject.credit(10)
      expect(subject.credits).to eq([10])
    end

    it "affects the balance" do
      subject.charge(10)

      expect {
        subject.credit(1)
      }.to change {
        subject.balance
      }.from(10).to(9)
    end

    it "allows credits which would decrease the balance below $0" do
      expect {
        subject.credit(10_000.01)
      }.to change {
        subject.balance
      }.from(0).to(-10_000.01)
    end

    it "ignores credits on invalid cards" do
      expect(number_validator).to receive(:valid?)
        .with(valid_number)
        .and_return(false)

      expect {
        subject.credit(10)
      }.to not_change {
        subject.credits.count
      }.and not_change {
        subject.balance
      }
    end
  end
end