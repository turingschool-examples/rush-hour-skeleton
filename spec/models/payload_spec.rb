require_relative '../spec_helper'

describe Payload do
  it "is invalid without a URL" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_name_id: 4,
                   user_agent_id: 5,
                   resolution_id: 6,
                   ip_id: 7)

    expect(payload).to_not be_valid
  end

  it "is invalid without a requested at" do
    payload = Payload.create(url_id: 1,
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_name_id: 4,
                   user_agent_id: 5,
                   resolution_id: 6,
                   ip_id: 7)

    expect(payload).to_not be_valid
  end

  it "is invalid without a responded in" do
    payload = Payload.create(requested_at: "test",
                   url_id: 1,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_name_id: 4,
                   user_agent_id: 5,
                   resolution_id: 6,
                   ip_id: 7)

    expect(payload).to_not be_valid
  end

  it "is invalid without a referred by" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   url_id: 1,
                   request_type_id: 3,
                   event_name_id: 4,
                   user_agent_id: 5,
                   resolution_id: 6,
                   ip_id: 7)

    expect(payload).to_not be_valid
  end

  it "is invalid without a request type" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   url_id: 1,
                   event_name_id: 4,
                   user_agent_id: 5,
                   resolution_id: 6,
                   ip_id: 7)

    expect(payload).to_not be_valid
  end

  it "is invalid without a event nae" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   url_id: 1,
                   user_agent_id: 5,
                   resolution_id: 6,
                   ip_id: 7)

    expect(payload).to_not be_valid
  end

  it "is invalid without a resolution width" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_name_id: 4,
                   user_agent_id: 5,
                   url_id: 1,
                   ip_id: 7)

    expect(payload).to_not be_valid
  end

  it "is invalid without a IP" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_name_id: 4,
                   user_agent_id: 5,
                   resolution_id: 6,
                   url_id: 1)

    expect(payload).to_not be_valid
  end

end
