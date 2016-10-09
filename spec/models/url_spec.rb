require_relative '../spec_helper'

describe Url do
  it "is invalid without a root url" do
    url = Url.create(path: "test")

    expect(url).to_not be_valid
  end

  it "is invalid without a path" do
    url = Url.create(root_url: "test")

    expect(url).to_not be_valid
  end

  it "gives max response time of specific url" do
    url = Url.create(root_url: "test", path: "whatever")
    Payload.create(url_id: url.id,
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   resolution_id: 6,
                   requested_at: "twest",
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 10,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)


    expect(Url.max_response_time(url.id)).to eq(12)
  end

  it "gives min response time of specific url" do
    url = Url.create(root_url: "test", path: "whatever")
    Payload.create(url_id: url.id,
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   resolution_id: 6,
                   requested_at: "twest",
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 10,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)


    expect(Url.min_response_time(url.id)).to eq(8)
  end

  it "gives response time from max to min of specific url" do
    url = Url.create(root_url: "test", path: "whatever")
    Payload.create(url_id: url.id,
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   resolution_id: 6,
                   requested_at: "twest",
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 10,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)


    expect(Url.response_times_desc(url.id)).to eq([12, 10, 8])
  end

  it "lists all http verbs for specific url" do
    url = Url.create(root_url: "test", path: "whatever")
    get = RequestType.create(http_verb: "GET")
    post = RequestType.create(http_verb: "POST")
    delete = RequestType.create(http_verb: "DELETE")

    Payload.create(url_id: url.id,
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: get.id,
                   event_id: 4,
                   agent_id: 5,
                   resolution_id: 6,
                   requested_at: "twest",
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 10,
                   referred_by_id: 2,
                   request_type_id: post.id,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: 2,
                   request_type_id: delete.id,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: 99,
                   responded_in: 8,
                   referred_by_id: 2,
                   request_type_id: delete.id,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)


    expect(Url.all_http_verbs(url.id)).to eq(["DELETE", "GET", "POST"])
  end

  it "gives three most popular referred bys of specific url" do
    url = Url.create(root_url: "test", path: "whatever")
    google = ReferredBy.create(root_url: "google.com", path: "/images")
    yahoo = ReferredBy.create(root_url: "yahoo.com", path: "/images")
    bing = ReferredBy.create(root_url: "bing.com", path: "/images")
    askjeeves = ReferredBy.create(root_url: "askjeeves.com", path: "/images")


    Payload.create(url_id: url.id,
                   responded_in: 12,
                   referred_by_id: google.id,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   resolution_id: 6,
                   requested_at: "twest",
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 10,
                   referred_by_id: google.id,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: google.id,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: yahoo.id,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: yahoo.id,
                   request_type_id: 4,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: askjeeves.id,
                   request_type_id: 2,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: bing.id,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: 5,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    expect(Url.top_three_referrals(url.id)).to eq(["google.com/images", "yahoo.com/images", "askjeeves.com/images"])
  end

  it "gives three most popular user agents for specific url" do
    url = Url.create(root_url: "test", path: "whatever")
    safari = Agent.create(browser: "Safari", operating_system: "OSX")
    mozilla = Agent.create(browser: "Mozilla", operating_system: "Windows")
    chrome = Agent.create(browser: "Chrome", operating_system: "Linux")
    ie = Agent.create(browser: "IE", operating_system: "OSX")


    Payload.create(url_id: url.id,
                   responded_in: 12,
                   referred_by_id: 5,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: safari.id,
                   resolution_id: 6,
                   requested_at: "twest",
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 10,
                   referred_by_id: 5,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: safari.id,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: 5,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: safari.id,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: 5,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: chrome.id,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: 5,
                   request_type_id: 4,
                   event_id: 4,
                   agent_id: chrome.id,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: 5,
                   request_type_id: 2,
                   event_id: 4,
                   agent_id: ie.id,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    Payload.create(url_id: url.id,
                   responded_in: 8,
                   referred_by_id: 5,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: mozilla.id,
                   requested_at: "twest",
                   resolution_id: 6,
                   ip_id: 7,
                   client_id: 3)

    expect(Url.top_three_agents(url.id)).to eq(["Safari OSX", "Chrome Linux", "IE OSX"])
  end


end
