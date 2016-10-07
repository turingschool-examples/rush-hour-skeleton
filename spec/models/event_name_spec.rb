require_relative '../spec_helper'

describe EventName do
  it "is invalid without a event name" do
    event_name = EventName.create()

    expect(event_name).to_not be_valid
  end
end
