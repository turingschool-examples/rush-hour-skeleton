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

  describe "longest_to_shortest_response_time" do
    it "returns an array of longest to shortest response times" do
      url1 = Url.create( url_address: "www.google.com")
      url2 = Url.create( url_address: "www.yahoo.com")

      payload1 = Payload.create( url_id:             url1.id,
                                 responded_in:       30,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             url1.id,
                                 responded_in:       40,
                                 requested_at:       "2014-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload3 = Payload.create( url_id:             url2.id,
                                 responded_in:       20,
                                 requested_at:       "2016-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      response_times = [40, 30]
      expect(url1.longest_to_shortest_response_time).to eq(response_times)
    end
  end

  describe ".list_of_http_verbs" do
    it "return the list of all http verbs across payloads" do
      url = Url.create(url_address: "http://jumpstartlab.com")

      request_1 = Request.create(request_type: "GET")
      request_2 = Request.create(request_type: "PUT")
      request_3 = Request.create(request_type: "POST")

      payload1 = Payload.create( url_id:             url.id,
                                 responded_in:       40,
                                 requested_at:       "2013-02-16",
                                 referral_id:        1,
                                 request_id:         request_1.id,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             url.id,
                                 responded_in:       30,
                                 requested_at:       "2014-02-16",
                                 referral_id:        1,
                                 request_id:         request_2.id,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload3 = Payload.create( url_id:             url.id,
                                 responded_in:       20,
                                 requested_at:       "2016-02-16",
                                 referral_id:        1,
                                 request_id:         request_3.id,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload4 = Payload.create( url_id:             url.id,
                                 responded_in:       40,
                                 requested_at:       "2013-02-16",
                                 referral_id:        1,
                                 request_id:         request_1.id,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      all_verbs = ["PUT", "GET", "POST"]
      expect(url.list_of_http_verbs).to eq(all_verbs)
    end
  end


  describe ".three_most_popular_referrals" do
    it "returns three most popular referrers" do
      url = Url.create(url_address: "http://jumpstartlab.com")

      ref1  = Referral.create(source: "http://google.com")
      ref2  = Referral.create(source: "http://coursereport.com")
      ref3  = Referral.create(source: "http://turing.io")

      payload1 = Payload.create( url_id:             url.id,
                                 responded_in:       40,
                                 requested_at:       "2013-02-16",
                                 referral_id:        ref1.id,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             url.id,
                                 responded_in:       30,
                                 requested_at:       "2014-02-16",
                                 referral_id:        ref2.id,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload3 = Payload.create( url_id:             url.id,
                                 responded_in:       20,
                                 requested_at:       "2016-02-16",
                                 referral_id:        ref3.id,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload4 = Payload.create( url_id:             url.id,
                                 responded_in:       40,
                                 requested_at:       "2013-02-16",
                                 referral_id:        ref2.id,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload5 = Payload.create( url_id:             url.id,
                                 responded_in:       30,
                                 requested_at:       "2014-02-16",
                                 referral_id:        ref1.id,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload6 = Payload.create( url_id:             url.id,
                                 responded_in:       20,
                                 requested_at:       "2016-02-16",
                                 referral_id:        ref2.id,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      top_three = ["http://coursereport.com", "http://google.com", "http://turing.io"]
      expect(url.three_most_popular_referrals).to eq(top_three)
    end
  end

  describe ".three_most_popular_user_agents" do
    it "returns three most popular user agents" do
      url = Url.create(url_address: "http://jumpstartlab.com")

      uas1 = UserAgentStat.create(operating_system: "Windows", browser: "Chrome")
      uas2 = UserAgentStat.create(operating_system: "Mac OS",  browser: "Chrome")
      uas3 = UserAgentStat.create(operating_system: "Mac OS",  browser: "Safari")

      payload1 = Payload.create( url_id:             url.id,
                                 responded_in:       40,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: uas1.id,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             url.id,
                                 responded_in:       30,
                                 requested_at:       "2014-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: uas2.id,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload3 = Payload.create( url_id:             url.id,
                                 responded_in:       20,
                                 requested_at:       "2016-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: uas3.id,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload4 = Payload.create( url_id:             url.id,
                                 responded_in:       40,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: uas2.id,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload5 = Payload.create( url_id:             url.id,
                                 responded_in:       30,
                                 requested_at:       "2014-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: uas1.id,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload6 = Payload.create( url_id:             url.id,
                                 responded_in:       20,
                                 requested_at:       "2016-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: uas2.id,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      top_three = [["Chrome", "Mac OS"], ["Chrome", "Windows"], ["Safari", "Mac OS"]]
      expect(url.three_most_popular_user_agents).to eq(top_three)
    end
  end
end
