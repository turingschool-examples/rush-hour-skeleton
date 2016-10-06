require_relative '../spec_helper'

describe Payload do
  it "is invalid without a URL" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by: "test",
                   request_type: "test",
                   event_name: "test",
                   user_agent: "test",
                   resolution_width: "test",
                   resolution_height: "test",
                   ip: "test")

    expect(payload).to_not be_valid
  end

  it "is invalid without a requested at" do
    payload = Payload.create(url: "test",
                   responded_in: 12,
                   referred_by: "test",
                   request_type: "test",
                   event_name: "test",
                   user_agent: "test",
                   resolution_width: "test",
                   resolution_height: "test",
                   ip: "test")

    expect(payload).to_not be_valid
  end

  it "is invalid without a responded in" do
    payload = Payload.create(requested_at: "test",
                   url: "test",
                   referred_by: "test",
                   request_type: "test",
                   event_name: "test",
                   user_agent: "test",
                   resolution_width: "test",
                   resolution_height: "test",
                   ip: "test")

    expect(payload).to_not be_valid
  end

  it "is invalid without a referred by" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   url: "test",
                   request_type: "test",
                   event_name: "test",
                   user_agent: "test",
                   resolution_width: "test",
                   resolution_height: "test",
                   ip: "test")

    expect(payload).to_not be_valid
  end

  it "is invalid without a request type" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by: "test",
                   url: "test",
                   event_name: "test",
                   user_agent: "test",
                   resolution_width: "test",
                   resolution_height: "test",
                   ip: "test")

    expect(payload).to_not be_valid
  end

  it "is invalid without a event nae" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by: "test",
                   request_type: "test",
                   url: "test",
                   user_agent: "test",
                   resolution_width: "test",
                   resolution_height: "test",
                   ip: "test")

    expect(payload).to_not be_valid
  end

  it "is invalid without a resolution width" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by: "test",
                   request_type: "test",
                   event_name: "test",
                   user_agent: "test",
                   url: "test",
                   resolution_height: "test",
                   ip: "test")

    expect(payload).to_not be_valid
  end

  it "is invalid without a resolution height" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by: "test",
                   request_type: "test",
                   event_name: "test",
                   user_agent: "test",
                   resolution_width: "test",
                   url: "test",
                   ip: "test")

    expect(payload).to_not be_valid
  end

  it "is invalid without a IP" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by: "test",
                   request_type: "test",
                   event_name: "test",
                   user_agent: "test",
                   resolution_width: "test",
                   resolution_height: "test",
                   url: "test")

    expect(payload).to_not be_valid
  end

end
