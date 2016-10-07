require_relative '../spec_helper'

RSpec.describe "UserAgent" do
  
  it "is valid with a user_agent" do
    user_agent = UserAgent.new(user_agent: "bah")
    
    expect(user_agent).to be_valid
  end
  
  it "is invalid without an event" do
    user_agent = UserAgent.new()
    
    expect(user_agent).to_not be_valid
  end
  
  
end