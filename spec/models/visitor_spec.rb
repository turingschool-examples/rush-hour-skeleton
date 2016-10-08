require_relative '../spec_helper'

RSpec.describe "Visitor" do
  describe "validation" do
    it "is invalid without ip address" do
      visitor = Visitor.create

      expect(visitor).to_not be_valid
    end

    it "is valid with ip addres" do
      visitor = Visitor.create(ip: "63.29.38.211")

      expect(visitor).to be_valid
    end
  end
end
