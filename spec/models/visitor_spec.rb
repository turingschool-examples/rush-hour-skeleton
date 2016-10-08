require_relative '../spec_helper'

RSpec.describe "Visitor" do
  describe "validation" do
    it "is invalid without ip" do
      visitor = Visitor.create

      expect(visitor).to_not be_valid
    end
  end
end
