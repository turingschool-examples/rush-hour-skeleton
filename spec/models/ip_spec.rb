require_relative '../spec_helper'

RSpec.describe "Ip" do
  
  it "is valid with an ip" do
    ip = Ip.new(ip: "bah")
    
    expect(ip).to be_valid
  end
  
  it "is invalid without an event" do
    ip = Ip.new()
    
    expect(ip).to_not be_valid
  end
  
  
end