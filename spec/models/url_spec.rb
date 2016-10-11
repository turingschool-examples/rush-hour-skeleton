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

      expect(Url.max_response_time_by_url("http://beesbeesbees")).to eq(39)
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

      expect(Url.min_response_time_by_url("http://beesbeesbees")).to eq(37)
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

      expect(Url.all_response_times_by_url("http://beesbeesbees")).to eq([39, 37])
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

      expect(Url.average_response_time_by_url("http://beesbeesbees")).to eq(38)
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

      expect(Url.http_verbs_by_url("http://beesbeesbees")).to eq(["GET", "POST"])
      expect(Url.http_verbs_by_url("http://waspswaspswasps")).to eq(["DELETE"])
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

      expect(Url.most_to_least_requested).to eq(["http://waspswaspswasps", "http://beesbeesbees"])
    end
  end

end
