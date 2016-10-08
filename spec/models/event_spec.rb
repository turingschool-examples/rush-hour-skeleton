require_relative '../spec_helper'

RSpec.describe "Event" do
  describe "validation" do
    it "is invalid without event_name" do
      event = Event.create

      expect(event).to_not be_valid
    end

    it "is valid with an event_name" do
      event = Event.create( event_name: "Halloween")

      expect(event).to be_valid
    end

    it "has a unique event_name" do
      event1 = Event.create( event_name: "Halloween")
      event2 = Event.create( event_name: "Halloween")

      expect(event2).to_not be_valid
    end
  end
end
