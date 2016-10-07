require_relative '../spec_helper'

RSpec.describe "Url" do
  
  it "is valid with a url" do
    url = Url.new(url: "bah")
    
    expect(url).to be_valid
  end
  
  it "is invalid without an event" do
    url = Url.new()
    
    expect(url).to_not be_valid
  end
  
  
end