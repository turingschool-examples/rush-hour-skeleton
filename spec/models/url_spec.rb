require_relative '../spec_helper'

RSpec.describe "Url" do

  it "is valid with a url" do
    url = Url.new(url: "bah")

    expect(url).to be_valid
  end

  it "is invalid without an event" do
    url = Url.new()

    expect(url).to_not be_valid
  end

  describe ".max_response_time_by_url" do
    it "returns max_response_time_by_url" do

      Url.create(url: "http://beesbeesbees")
      Url.create(url: "http://waspswaspswasps")

      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload2 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload3 = Payload.create(url_id: 2,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 45,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      url = Url.find_by(url: "http://beesbeesbees")
      expect(url.max_response_time_by_url).to eq(39)
    end
  end

  describe ".min_response_time_by_url" do
    it "returns min_response_time_by_url" do

      Url.create(url: "http://beesbeesbees")
      Url.create(url: "http://waspswaspswasps")

      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload2 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload3 = Payload.create(url_id: 2,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 34,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      url = Url.find_by(url: "http://beesbeesbees")
      expect(url.min_response_time_by_url).to eq(37)
    end
  end

  describe ".all_response_times_by_url" do
    it "returns all_response_times_by_url" do

      Url.create(url: "http://beesbeesbees")
      Url.create(url: "http://waspswaspswasps")

      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload2 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload3 = Payload.create(url_id: 2,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 34,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)
      url = Url.find_by(url: "http://beesbeesbees")
      expect(url.all_response_times_by_url).to eq([39, 37])
    end
  end

  describe ".average_response_time_by_url" do
    it "returns average_response_time_by_url" do

      Url.create(url: "http://beesbeesbees")
      Url.create(url: "http://waspswaspswasps")

      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload2 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload3 = Payload.create(url_id: 2,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 34,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      url = Url.find_by(url: "http://beesbeesbees")
      expect(url.average_response_time_by_url).to eq(38)
    end
  end

  describe "http:verbs_by_url" do
    it "returns http_verbs_by_url" do

      Url.create(url: "http://beesbeesbees")
      Url.create(url: "http://waspswaspswasps")

      RequestType.create(request_type: "GET")
      RequestType.create(request_type: "POST")
      RequestType.create(request_type: "PUT")
      RequestType.create(request_type: "PATCH")
      RequestType.create(request_type: "DELETE")

      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload2 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 2,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload3 = Payload.create(url_id: 2,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 34,
                            referred_by_id: 1,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      url = Url.find_by(url: "http://beesbeesbees")
      url2 = Url.find_by(url: "http://waspswaspswasps")

      expect(url.http_verbs_by_url).to eq(["GET", "POST"])
      expect(url2.http_verbs_by_url).to eq(["DELETE"])
    end
  end

  describe ".most_to_least_requested" do
    it "returns request types by frequency" do
      Url.create(url: "http://beesbeesbees")
      Url.create(url: "http://waspswaspswasps")

      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload2 = Payload.create(url_id: 2,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 2,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload3 = Payload.create(url_id: 2,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 2,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      expect(Url.most_to_least_requested(Payload.all)).to eq(["http://waspswaspswasps", "http://beesbeesbees"])
    end
  end

  describe "http:verbs_by_url" do
    it "returns http_verbs_by_url" do

      Url.create(url: "http://beesbeesbees")

      ReferredBy.create(referred_by: "http://ghostsghostsghosts")
      ReferredBy.create(referred_by: "http://dogsdogsdogs")
      ReferredBy.create(referred_by: "http://coffeecoffeecoffee")
      ReferredBy.create(referred_by: "http://teateatea")
      ReferredBy.create(referred_by: "http://boatsboatsboats")

      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:27 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload2 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:29 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 2,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload3 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:22 -0700",
                            responded_in: 34,
                            referred_by_id: 2,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload4 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:21 -0700",
                            responded_in: 34,
                            referred_by_id: 2,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload5 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:23 -0700",
                            responded_in: 34,
                            referred_by_id: 3,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload6 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:30 -0700",
                            responded_in: 34,
                            referred_by_id: 3,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload7 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:31 -0700",
                            responded_in: 34,
                            referred_by_id: 4,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload8 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:18 -0700",
                            responded_in: 34,
                            referred_by_id: 5,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload9 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:58 -0700",
                            responded_in: 34,
                            referred_by_id: 2,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)
      url = Url.find_by(url: "http://beesbeesbees")
      expect(url.three_most_popular_referrers).to eq([["http://dogsdogsdogs", 3], ["http://coffeecoffeecoffee", 2], ["http://ghostsghostsghosts", 2]])
    end
  end

  describe "http:verbs_by_url" do
    it "returns http_verbs_by_url" do

      Url.create(url: "http://beesbeesbees")

      Agent.create(agent: "Mozilla/5.0 (Macintosh_1; Intel Mac OS X 10_9) AppleWebKit/537.17 (KHTML, like Gecko) Chrome1_test_1/24.0.1309.0 Safari/537.17")
      Agent.create(agent: "Mozilla/5.0 (Macintosh_1; Intel Mac OS X 10_10) AppleWebKit/537.17 (KHTML, like Gecko) Firefox/537.17")
      Agent.create(agent: "Mozilla/5.0 (Macintosh_2; Intel Mac OS X 10_11) AppleWebKit/537.17 (KHTML, like Gecko) Safari/537.17")
      Agent.create(agent: "Mozilla/5.0 (Macintosh_2; Intel Mac OS X 10_12) AppleWebKit/537.17 (KHTML, like Gecko) Safari/537.17")
      Agent.create(agent: "Mozilla/5.0 (Macintosh_3; Intel Mac OS X 10_13) AppleWebKit/537.17 (KHTML, like Gecko) Safari/537.17")

      payload1 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 1,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload2 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referred_by_id: 1,
                            request_type_id: 2,
                            event_name_id: 1,
                            agent_id: 1,
                            resolution_id: 1,
                            ip_id: 1)

      payload3 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 34,
                            referred_by_id: 2,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 2,
                            resolution_id: 1,
                            ip_id: 1)

      payload4 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 34,
                            referred_by_id: 2,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 2,
                            resolution_id: 1,
                            ip_id: 2)

      payload5 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 34,
                            referred_by_id: 3,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 3,
                            resolution_id: 1,
                            ip_id: 2)

      payload6 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:29 -0700",
                            responded_in: 34,
                            referred_by_id: 3,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 3,
                            resolution_id: 1,
                            ip_id: 1)

      payload7 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:27 -0700",
                            responded_in: 34,
                            referred_by_id: 4,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 3,
                            resolution_id: 1,
                            ip_id: 1)

      payload8 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:22 -0700",
                            responded_in: 34,
                            referred_by_id: 5,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 4,
                            resolution_id: 1,
                            ip_id: 1)

      payload9 = Payload.create(url_id: 1,
                            requested_at: "2013-02-16 21:38:30 -0700",
                            responded_in: 34,
                            referred_by_id: 2,
                            request_type_id: 5,
                            event_name_id: 1,
                            agent_id: 5,
                            resolution_id: 1,
                            ip_id: 1)

      url = Url.find_by(url: "http://beesbeesbees")
      expect(url.three_most_popular_user_agents).to eq([["OS X 10.11", "safari"], ["OS X 10.10", "firefox"], ["OS X 10.9", "chrome"]])
    end
  end

end
