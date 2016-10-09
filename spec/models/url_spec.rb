require_relative '../spec_helper'

RSpec.describe "Url" do
  describe "validation" do
    it "is invalid without url_address" do
      url = Url.create

      expect(url).to_not be_valid
    end

    it "is valid with url_address" do
      url = Url.create( url_address: "www.google.com")

      expect(url).to be_valid
    end

    it "has a unique url address" do
      url1 = Url.create( url_address: "www.google.com")
      url2 = Url.create( url_address: "www.google.com")

      expect(url2).to_not be_valid
    end
  end

  describe ".most_to_least_requested" do
    it "lists urls from most requested to least" do
      url1 = Url.create( url_address: "www.google.com")
      url2 = Url.create( url_address: "www.yahoo.com")

      payload1 = Payload.create(  url_id:            url1.id,
                                  responded_in:       37,
                                  requested_at:       "2013-02-16 21:38:28 -0700",
                                  referral_id:        2,
                                  request_id:         3,
                                  event_id:           4,
                                  user_agent_stat_id: 5,
                                  resolution_id:      6,
                                  visitor_id:         7 )

      payload2 = Payload.create(  url_id:            url1.id,
                                  responded_in:       38,
                                  requested_at:       "2014-02-16 21:38:28 -0700",
                                  referral_id:        2,
                                  request_id:         3,
                                  event_id:           4,
                                  user_agent_stat_id: 5,
                                  resolution_id:      6,
                                  visitor_id:         7 )

      payload3 = Payload.create(  url_id:            url2.id,
                                  responded_in:       39,
                                  requested_at:       "2015-02-16 21:38:28 -0700",
                                  referral_id:        2,
                                  request_id:         3,
                                  event_id:           4,
                                  user_agent_stat_id: 5,
                                  resolution_id:      6,
                                  visitor_id:         7 )

      most_to_least = [url1.url_address, url2.url_address]

      expect(Url.most_to_least_requested).to eq(most_to_least)
    end
  end

  describe ".max_response_time" do
    it "returns max response time for a specific url" do
      url1 = Url.create( url_address: "www.google.com")
      url2 = Url.create( url_address: "www.yahoo.com")

      payload1 = Payload.create(  url_id:            url1.id,
                                  responded_in:       37,
                                  requested_at:       "2013-02-16 21:38:28 -0700",
                                  referral_id:        2,
                                  request_id:         3,
                                  event_id:           4,
                                  user_agent_stat_id: 5,
                                  resolution_id:      6,
                                  visitor_id:         7 )

      payload2 = Payload.create(  url_id:            url1.id,
                                  responded_in:       38,
                                  requested_at:       "2014-02-16 21:38:28 -0700",
                                  referral_id:        2,
                                  request_id:         3,
                                  event_id:           4,
                                  user_agent_stat_id: 5,
                                  resolution_id:      6,
                                  visitor_id:         7 )

      payload3 = Payload.create(  url_id:            url2.id,
                                  responded_in:       39,
                                  requested_at:       "2015-02-16 21:38:28 -0700",
                                  referral_id:        2,
                                  request_id:         3,
                                  event_id:           4,
                                  user_agent_stat_id: 5,
                                  resolution_id:      6,
                                  visitor_id:         7 )

      expect(url1.max_response_time(url1)).to eq(38)
    end
  end

  describe "min_response_time" do
    it "returns min response time for a specific url" do
      url1 = Url.create( url_address: "www.google.com")
      url2 = Url.create( url_address: "www.yahoo.com")

      payload1 = Payload.create(  url_id:            url1.id,
                                  responded_in:       37,
                                  requested_at:       "2013-02-16 21:38:28 -0700",
                                  referral_id:        2,
                                  request_id:         3,
                                  event_id:           4,
                                  user_agent_stat_id: 5,
                                  resolution_id:      6,
                                  visitor_id:         7 )

      payload2 = Payload.create(  url_id:            url1.id,
                                  responded_in:       38,
                                  requested_at:       "2014-02-16 21:38:28 -0700",
                                  referral_id:        2,
                                  request_id:         3,
                                  event_id:           4,
                                  user_agent_stat_id: 5,
                                  resolution_id:      6,
                                  visitor_id:         7 )

      payload3 = Payload.create(  url_id:            url2.id,
                                  responded_in:       39,
                                  requested_at:       "2015-02-16 21:38:28 -0700",
                                  referral_id:        2,
                                  request_id:         3,
                                  event_id:           4,
                                  user_agent_stat_id: 5,
                                  resolution_id:      6,
                                  visitor_id:         7 )

      expect(url1.min_response_time(url1)).to eq(37)
    end
  end

g
    it "returns max response time for a specific url" do
      url1 = Url.create( url_address: "www.google.com")
      url2 = Url.create( url_address: "www.yahoo.com")

      payload1 = Payload.create(  url_id:            url1.id,
                                  responded_in:       38,
                                  requested_at:       "2013-02-16 21:38:28 -0700",
                                  referral_id:        2,
                                  request_id:         3,
                                  event_id:           4,
                                  user_agent_stat_id: 5,
                                  resolution_id:      6,
                                  visitor_id:         7 )

      payload2 = Payload.create(  url_id:            url1.id,
                                  responded_in:       40,
                                  requested_at:       "2014-02-16 21:38:28 -0700",
                                  referral_id:        2,
                                  request_id:         3,
                                  event_id:           4,
                                  user_agent_stat_id: 5,
                                  resolution_id:      6,
                                  visitor_id:         7 )

      payload3 = Payload.create(  url_id:            url2.id,
                                  responded_in:       32,
                                  requested_at:       "2015-02-16 21:38:28 -0700",
                                  referral_id:        2,
                                  request_id:         3,
                                  event_id:           4,
                                  user_agent_stat_id: 5,
                                  resolution_id:      6,
                                  visitor_id:         7 )

      expect(url1.average_response_time(url1)).to eq(39)
    end
  end

end
