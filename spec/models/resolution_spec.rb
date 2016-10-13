require_relative '../spec_helper'

describe Resolution do
  it "is invalid without a height" do
    resolution = Resolution.create(width: "test")

    expect(resolution).to_not be_valid
  end

  it "is invalid without a width" do
    resolution = Resolution.create(height: "test2")

    expect(resolution).to_not be_valid
  end
end
