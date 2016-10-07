require_relative '../spec_helper'

RSpec.describe "EventName" do
  
  it "is valid with an event" do
    event_name = EventName.new(event_name: "bah")
    
    expect(event_name).to be_valid
  end
  
  it "is invalid without an event" do
    event_name = EventName.new()
    
    expect(event_name).to_not be_valid
  end
  
  
end