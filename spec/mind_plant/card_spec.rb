require "spec_helper"

RSpec.describe MindPlant::Card do
  describe ".new" do
    let(:valid_number) { '4111111111111111' }
    let(:number_validator) { double(:NumberValidator) }

    subject do
      MindPlant::Card.new('Joseph Sak', valid_number, 10_000, number_validator)
    end

    its(:name) { is_expected.to eq('Joseph Sak') }
    its(:number) { is_expected.to eq(valid_number) }
    its(:limit) { is_expected.to eq(10_000) }
    its(:number_validator) { is_expected.to eq(number_validator) }

    it "validates its numbers with the validator" do
      expect(number_validator).to receive(:valid?).with(valid_number).and_return(true)
      expect(subject.valid?).to be true
    end
  end
end