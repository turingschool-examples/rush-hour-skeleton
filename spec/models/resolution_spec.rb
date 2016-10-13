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

  describe ".height_breakdown" do
    it "breaks down resolution height across all payloads" do
      build_linked_resolutions_and_payloads
      
      expected = {"5"=>2, "4"=>1}
      expect(Resolution.height_breakdown).to eq(expected)
    end
  end

  describe ".width_breakdown" do
    it "breaks down resolution width across all payloads" do
      build_linked_resolutions_and_payloads

      expected = {"10"=>1, "6"=>2}
      expect(Resolution.width_breakdown).to eq(expected)
    end
  end

  describe ".resolutions_across_all_payloads" do
    it "returns resolutions across all payloads" do
      build_linked_resolutions_and_payloads

      expected = {["5", "10"]=>1, ["5", "6"]=>1, ["4", "6"]=>1}
      expect(Resolution.resolutions_across_all_payloads).to eq(expected)
    end
  end
end
