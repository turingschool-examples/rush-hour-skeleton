require_relative '../spec_helper'

RSpec.describe "Referral" do
  describe "validation" do
    it "is invalid without source" do
      referral = Referral.create

      expect(referral).to_not be_valid
    end

    it "is valid with source" do
      referral = Referral.create(source: "http://jumpstartlab.com")

      expect(referral).to be_valid
    end

    it "has a unique source" do
      referral1 = Referral.create(source: "http://jumpstartlab.com")
      referral2 = Referral.create(source: "http://jumpstartlab.com")

      expect(referral2).to_not be_valid
    end
  end
end
