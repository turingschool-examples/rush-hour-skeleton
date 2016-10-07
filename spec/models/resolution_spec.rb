require_relative '../spec_helper'

RSpec.describe "Resolution" do
  
  it "is valid with all types of resolution" do
    resolution = Resolution.new(resolution_width: 48,
                                resolution_height: 16)
    expect(resolution).to be_valid
  end
  
  it "is invalid without a height" do
    resolution = Resolution.new(resolution_width: 48)
    
    expect(resolution).to_not be_valid
  end
  
  it "is invalid without a width" do
    resolution = Resolution.new(resolution_height: 48)
    
    expect(resolution).to_not be_valid
  end
  
end