require_relative '../spec_helper'

describe Event do
  it "is invalid without a event name" do
    event = Event.create()

    expect(event).to_not be_valid
  end
end
