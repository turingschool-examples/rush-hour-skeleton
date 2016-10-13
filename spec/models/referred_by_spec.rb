require_relative '../spec_helper'

RSpec.describe "ReferredBy" do
  
  it "is valid with a referred_by" do
    referred_by = ReferredBy.new(referred_by: "bah")
    
    expect(referred_by).to be_valid
  end
  
  it "is invalid without a referred_by" do
    referred_by = ReferredBy.new()
    
    expect(referred_by).to_not be_valid
  end
  
  
end