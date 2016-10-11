require_relative '../spec_helper'
require_relative '../../app/models/payload'

RSpec.describe "Payload" do

  it "is valid with everything" do
    payload = Payload.new(url_id: "http://jumpstartlab.com/blog",
                          requested_at: "2013-02-16 21:38:28 -0700",
                          responded_in: 37,
                          referred_by_id: "http://jumpstartlab.com",
                          request_type_id: "GET",
                          event_name_id: "socialLogin",
                          agent_id: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          resolution_id: 1280,
                          ip_id:"63.29.38.211")

    expect(payload).to be_valid
  end

  it "is invalid without a url_id" do
    payload = Payload.new(requested_at: "2013-02-16 21:38:28 -0700",
                          responded_in: 37,
                          referred_by_id: "http://jumpstartlab.com",
                          request_type_id: "GET",
                          event_name_id: "socialLogin",
                          agent_id: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          resolution_id: 1280,
                          ip_id:"63.29.38.211")

    expect(payload).to_not be_valid
  end

  it "is invalid without requested_at" do
    payload = Payload.new(url_id: "http://jumpstartlab.com/blog",
                          responded_in: 37,
                          referred_by_id: "http://jumpstartlab.com",
                          request_type_id: "GET",
                          event_name_id: "socialLogin",
                          agent_id: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          resolution_id: 1280,
                          ip_id:"63.29.38.211")

    expect(payload).to_not be_valid
  end

  it "is invalid without responded_in" do
    payload = Payload.new(url_id: "http://jumpstartlab.com/blog",
                          requested_at: "2013-02-16 21:38:28 -0700",
                          referred_by_id: "http://jumpstartlab.com",
                          request_type_id: "GET",
                          event_name_id: "socialLogin",
                          agent_id: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          resolution_id: 1280,
                          ip_id:"63.29.38.211")

    expect(payload).to_not be_valid
  end

  it "is invalid without referred_by_id" do
    payload = Payload.new(url_id: "http://jumpstartlab.com/blog",
                          requested_at: "2013-02-16 21:38:28 -0700",
                          responded_in: 37,
                          request_type_id: "GET",
                          event_name_id: "socialLogin",
                          agent_id: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          resolution_id: 1280,
                          ip_id:"63.29.38.211")

    expect(payload).to_not be_valid
  end

  it "is invalid without request_type" do
    payload = Payload.new(url_id: "http://jumpstartlab.com/blog",
                          requested_at: "2013-02-16 21:38:28 -0700",
                          responded_in: 37,
                          referred_by_id: "http://jumpstartlab.com",
                          event_name_id: "socialLogin",
                          agent_id: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          resolution_id: 1280,
                          ip_id:"63.29.38.211")

    expect(payload).to_not be_valid
  end

  it "is invalid without event_name_id" do
    payload = Payload.new(url_id: "http://jumpstartlab.com/blog",
                          requested_at: "2013-02-16 21:38:28 -0700",
                          responded_in: 37,
                          referred_by_id: "http://jumpstartlab.com",
                          request_type_id: "GET",
                          agent_id: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          resolution_id: 1280,
                          ip_id:"63.29.38.211")

    expect(payload).to_not be_valid
  end

  it "is invalid without user_agent_id" do
    payload = Payload.new(url_id: "http://jumpstartlab.com/blog",
                          requested_at: "2013-02-16 21:38:28 -0700",
                          responded_in: 37,
                          referred_by_id: "http://jumpstartlab.com",
                          request_type_id: "GET",
                          event_name_id: "socialLogin",
                          resolution_id: 1280,
                          ip_id:"63.29.38.211")

    expect(payload).to_not be_valid
  end

  it "is invalid without resolution_id" do
    payload = Payload.new(url_id: "http://jumpstartlab.com/blog",
                          requested_at: "2013-02-16 21:38:28 -0700",
                          responded_in: 37,
                          referred_by_id: "http://jumpstartlab.com",
                          request_type_id: "GET",
                          event_name_id: "socialLogin",
                          agent_id: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          ip_id:"63.29.38.211")

    expect(payload).to_not be_valid
  end

  it "is invalid without ip_id" do
    payload = Payload.new(url_id: "http://jumpstartlab.com/blog",
                          requested_at: "2013-02-16 21:38:28 -0700",
                          responded_in: 37,
                          referred_by_id: "http://jumpstartlab.com",
                          request_type_id: 1,
                          event_name_id: "socialLogin",
                          agent_id: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          resolution_id: 1280)

    expect(payload).to_not be_valid
  end

  describe ".request_type" do

    it "payload is associated with request type" do
      RequestType.create(request_type: "GET")
      payload = Payload.new(url_id: "http://jumpstartlab.com/blog",
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: "http://jumpstartlab.com",
                            request_type_id: 1,
                            event_name_id: "socialLogin",
                            agent_id: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                            resolution_id: 1280,
                            ip_id:"63.29.38.211")

      expect(payload.request_type.request_type).to eq("GET")
    end
  end

  describe ".url" do
    it "associates a url with a payload" do
      Url.create(url: "http://beesbeesbees.com")
      payload = Payload.new(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: "http://jumpstartlab.com",
                            request_type_id: 1,
                            event_name_id: "socialLogin",
                            agent_id: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                            resolution_id: 1280,
                            ip_id:"63.29.38.211")

      expect(payload.url.url).to eq("http://beesbeesbees.com")
    end
  end

  describe ".referred_by" do
    it "associates referred_by with a payload" do
      ReferredBy.create(referred_by: "http://beesbeesbees.com")
      payload = Payload.new(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: "socialLogin",
                            agent_id: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                            resolution_id: 1280,
                            ip_id:"63.29.38.211")

      expect(payload.referred_by.referred_by).to eq("http://beesbeesbees.com")
    end
  end

  describe ".event_name" do
    it "associates an event name with a payload" do
      EventName.create(event_name: "socialLogin")
      payload = Payload.new(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                            resolution_id: 1280,
                            ip_id:"63.29.38.211")

      expect(payload.event_name.event_name).to eq("socialLogin")
    end
  end

  describe ".agent" do
    it "associates a user agent with a payload" do
      Agent.create(agent: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
      payload = Payload.new(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1280,
                            ip_id:"63.29.38.211")

      expect(payload.agent.agent).to eq("Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    end
  end

  describe ".resolution_id" do
    it "associates a resolution with a payload" do
      Resolution.create(resolution_width: 1280, resolution_height: 720)
      payload = Payload.new(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id:"63.29.38.211")

      expect(payload.resolution.resolution_width).to eq(1280)
      expect(payload.resolution.resolution_height).to eq(720)

    end
  end

  describe ".ip_id" do
    it "associates an ip with a payload" do
      Ip.create(ip: "63.29.38.211")
      payload = Payload.new(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      expect(payload.ip.ip).to eq("63.29.38.211")
    end
  end

  describe ".average_response_time" do
    it "returns average_response_time" do
      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload2 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      expect(Payload.average_response_time).to eq(38)
    end
  end

  describe ".max_response_time" do
    it "returns max_response_time" do
      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload2 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      expect(Payload.max_response_time).to eq(39)
    end
  end

  describe ".min_response_time" do
    it "returns min_response_time" do
      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload2 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      expect(Payload.min_response_time).to eq(37)
    end
  end

  describe ".most_frequent_request_type" do
    it "returns most frequent request type" do
      RequestType.create(request_type: "GET")
      RequestType.create(request_type: "POST")
      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload2 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload3 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 2,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      expect(Payload.most_frequent(:request_type)).to eq("GET")
    end

    it "returns dynamic responses" do
      RequestType.create(request_type: "GET")
      RequestType.create(request_type: "POST")
      EventName.create(event_name: "Bill")
      EventName.create(event_name: "Ted")

      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload2 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 2,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload3 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 2,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      expect(Payload.most_frequent(:request_type)).to eq("GET")
      # expect(Payload.most_frequent(:event_name)).to eq("Ted")
    end
  end

end
