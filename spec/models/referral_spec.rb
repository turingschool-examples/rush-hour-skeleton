require_relative '../spec_helper'

RSpec.describe "Referral" do
  describe "validation" do
    it "is invalid without source" do
      referral = Referral.create

      expect(referral).to_not be_valid
    end
  end
end
