require "spec_helper"

RSpec.describe "Valid Credit Card Numbers" do
  it "validates an exhaustive list of examples" do
    # Examples sourced from:
    # https://www.freeformatter.com/credit-card-number-generator-validator.html#fakeNumbers
    valids = [
      '6381212382686852',
      '4913290042215140',
      '6762265506947427',
      '36129633112102',
      '30458171269719',
      '5510358959478284',
      '3544979583530845979',
      '3541697175503674',
      '6011360910427293696',
      '6011268190151362',
      '374535514099228',
      '2720996334951567',
      '4556942736886045134',
      '4485946406192542',
      '0317947361391944907'
    ]

    valids.each do |valid|
      card = MindPlant::Card.new(valid, 30_000)
      expect(card).to be_valid
    end
  end

  it "invalidates a sample of invalid numbers" do
    # Same as above, but with invalid checksums
    invalids = [
      '6381212382686851',
      '4913290042215142',
      '6762265506947424',
      '36129633112104',
      '30458171269714',
      '5510358959478288',
      '3544979583530845978',
      '3541697175503670',
      '6011360910427293691',
      '6011268190151364',
      '374535514099226',
      '2720996334951569',
      '4556942736886045132',
      '4485946406192540',
      '0317947361391944909'
    ]

    invalids.each do |invalid|
      card = MindPlant::Card.new(invalid, 30_000)
      expect(card).not_to be_valid
    end
  end
end