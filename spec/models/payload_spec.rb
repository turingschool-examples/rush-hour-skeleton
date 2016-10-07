require_relative '../spec_helper'

describe Payload do
  it "is invalid without a URL" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   resolution_id: 6,
                   ip_id: 7)

    expect(payload).to_not be_valid
  end

  it "is invalid without a requested at" do
    payload = Payload.create(url_id: 1,
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   resolution_id: 6,
                   ip_id: 7)

    expect(payload).to_not be_valid
  end

  it "is invalid without a responded in" do
    payload = Payload.create(requested_at: "test",
                   url_id: 1,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   resolution_id: 6,
                   ip_id: 7)

    expect(payload).to_not be_valid
  end

  it "is invalid without a referred by" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   url_id: 1,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   resolution_id: 6,
                   ip_id: 7)

    expect(payload).to_not be_valid
  end

  it "is invalid without a request type" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   url_id: 1,
                   event_id: 4,
                   agent_id: 5,
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
                   agent_id: 5,
                   resolution_id: 6,
                   ip_id: 7)

    expect(payload).to_not be_valid
  end

  it "is invalid without a resolution width" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   url_id: 1,
                   ip_id: 7)

    expect(payload).to_not be_valid
  end

  it "is invalid without a IP" do
    payload = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   resolution_id: 6,
                   url_id: 1)

    expect(payload).to_not be_valid
  end

  it "payload return associated agent" do
    a = Agent.create(browser: "safari", operating_system: "mac os")
    payload = Payload.create(requested_at: "test",
                 responded_in: 12,
                 referred_by_id: 2,
                 request_type_id: 3,
                 event_id: 4,
                 agent_id: a.id,
                 resolution_id: 6,
                 ip_id: 7)

  expect(payload.agent.class).to eq(Agent)
  expect(payload.agent.browser).to eq("safari")
  expect(payload.agent.operating_system).to eq("mac os")
  end

  it "payload return associated event" do
    e = Event.create(event_name: "social_login")
    payload = Payload.create(requested_at: "test",
                 responded_in: 12,
                 referred_by_id: 2,
                 request_type_id: 3,
                 event_id: e.id,
                 agent_id: 3,
                 resolution_id: 6,
                 ip_id: 7)

    expect(payload.event.class).to eq(Event)
    expect(payload.event.event_name).to eq("social_login")
  end

  it "payload return associated ip" do
    i = Ip.create(address: "192.4.5.6")
    payload = Payload.create(requested_at: "test",
                 responded_in: 12,
                 referred_by_id: 2,
                 request_type_id: 3,
                 event_id: 7,
                 agent_id: 3,
                 resolution_id: 6,
                 ip_id: i.id)

    expect(payload.ip.class).to eq(Ip)
    expect(payload.ip.address).to eq("192.4.5.6")
  end

  it "payload return associated referred by" do
    rb = ReferredBy.create(root_url: "turing.io", path: "students")
    payload = Payload.create(requested_at: "test",
                 responded_in: 12,
                 referred_by_id: rb.id,
                 request_type_id: 3,
                 event_id: 7,
                 agent_id: 3,
                 resolution_id: 6,
                 ip_id: 1)

    expect(payload.referred_by.class).to eq(ReferredBy)
    expect(payload.referred_by.root_url).to eq("turing.io")
    expect(payload.referred_by.path).to eq("students")
  end

  it "payload return associated request type" do
    rt = RequestType.create(http_verb: "GET")
    payload = Payload.create(requested_at: "test",
                 responded_in: 12,
                 referred_by_id: 8,
                 request_type_id: rt.id,
                 event_id: 7,
                 agent_id: 3,
                 resolution_id: 6,
                 ip_id: 1)

    expect(payload.request_type.class).to eq(RequestType)
    expect(payload.request_type.http_verb).to eq("GET")
  end

  it "payload return associated resolution" do
    r = Resolution.create(height: "1", width: "2")
    payload = Payload.create(requested_at: "test",
                 responded_in: 12,
                 referred_by_id: 8,
                 request_type_id: 1,
                 event_id: 7,
                 agent_id: 3,
                 resolution_id: r.id,
                 ip_id: 1)

    expect(payload.resolution.class).to eq(Resolution)
    expect(payload.resolution.height).to eq("1")
    expect(payload.resolution.width).to eq("2")
  end

  it "payload return associated url" do
    u = Url.create(root_url: "google.com", path: "images")
    payload = Payload.create(requested_at: "test",
                 responded_in: 12,
                 referred_by_id: 8,
                 request_type_id: 1,
                 event_id: 7,
                 agent_id: 3,
                 resolution_id: 1,
                 url_id: u.id,
                 ip_id: 1)

    expect(payload.url.class).to eq(Url)
    expect(payload.url.root_url).to eq("google.com")
    expect(payload.url.path).to eq("images")
  end
end
