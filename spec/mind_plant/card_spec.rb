require "spec_helper"

RSpec.describe MindPlant::Card do
  describe ".new" do
    subject do
      MindPlant::Card.new('Joseph Sak', '4111111111111111', 10_000)
    end

    its(:name) { is_expected.to eq('Joseph Sak') }
    its(:number) { is_expected.to eq('4111111111111111') }
    its(:limit) { is_expected.to eq(10_000) }
  end
end