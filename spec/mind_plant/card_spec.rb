require "spec_helper"

RSpec.describe MindPlant::Card do
  let(:valid_number) { '4111111111111111' }
  let(:number_validator) { double(:NumberValidator) }

  subject do
    MindPlant::Card.new('Joseph Sak', valid_number, 10_000, number_validator)
  end

  describe "attributes" do
    its(:name)             { is_expected.to eq('Joseph Sak') }
    its(:number)           { is_expected.to eq(valid_number) }
    its(:limit)            { is_expected.to eq(10_000) }
    its(:number_validator) { is_expected.to eq(number_validator) }
    its(:balance)          { is_expected.to eq(0) }
    its(:charges)          { are_expected.to be_empty }
  end

  describe "#valid?" do
    it "validates its numbers with the validator" do
      expect(number_validator).to receive(:valid?).with(valid_number).and_return(true)
      expect(subject.valid?).to be true
    end
  end

  describe "#charge" do
    it "adds to the list of charges" do
      Timecop.freeze do
        subject.charge(10)
        expect(subject.charges).to eq([
          { processed_at: Time.now.to_i, amount: 10 }
        ])
      end
    end

    it "affects the balance" do
      subject.charge(10)
      subject.charge(9.99)
      subject.charge(18.76)

      expect(subject.balance).to eq(38.75)
    end

    it "ignores charges which would increase the balance the limit" do
      expect {
        subject.charge(10_000.01)
      }.not_to change {
        subject.balance
      }
    end
  end
end