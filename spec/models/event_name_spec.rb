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

  describe "events_by_hour" do
    it "returns hash hour => times" do

      client = Client.create(identifier: "Alphonse", root_url: "http://beesbeesbees.com")

      event = EventName.create(event_name: "thing")

      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1,
                            client_id: 1)

      payload2 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 23:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 2,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1,
                            client_id: 1)

      expect(event.events_by_hour(client)).to eq({21=>1, 23=>1})
    end
  end
end
