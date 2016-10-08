require_relative '../spec_helper'

RSpec.describe "Resolution" do
  describe "validation" do
    it "is invalid without height" do
      resolution = Resolution.create(width: "10")

      expect(resolution).to_not be_valid
    end

    it "is invalid without width" do
      resolution = Resolution.create(height: "10")

      expect(resolution).to_not be_valid
    end

    it "is valid with all attributes" do
      resolution = Resolution.create(height: "10", width: "10")

      expect(resolution).to be_valid
    end
  end
end
