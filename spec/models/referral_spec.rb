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
  end

  describe ".three_most_popular" do
    it "returns three most popular referrers" do
      referral1  = Referral.create(source: "http://google.com")
      referral2  = Referral.create(source: "http://jumpstartlab.com")
      referral3  = Referral.create(source: "http://jumpstartlab.com")
      referral4  = Referral.create(source: "http://jumpstartlab.com")
      referral5  = Referral.create(source: "http://jumpstartlab.com")
      referral6  = Referral.create(source: "http://turing.io")
      referral7  = Referral.create(source: "http://turing.io")
      referral8  = Referral.create(source: "http://turing.io")
      referral9  = Referral.create(source: "http://amazon.com")
      referral10 = Referral.create(source: "http://amazon.com")
      referral11 = Referral.create(source: "http://waffle.io")

      expected = ["http://jumpstartlab.com", "http://turing.io", "http://amazon.com"]
      expect(Referral.three_most_popular).to eq(expected)
    end
  end
end
