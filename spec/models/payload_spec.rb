require_relative '../spec_helper'

RSpec.describe "Payload" do
  describe "validation" do
    it "is invalid without url_id" do
      payload = Payload.create( responded_in:       37,
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                referral_id:        2,
                                request_id:         3,
                                event_id:           4,
                                user_agent_stat_id: 5,
                                resolution_id:      6,
                                visitor_id:         7 )

      expect(payload).to_not be_valid
    end

    it "is invalid without requested_at" do
      payload = Payload.create( url_id:             12,
                                responded_in:       37,
                                referral_id:        2,
                                request_id:         3,
                                event_id:           4,
                                user_agent_stat_id: 5,
                                resolution_id:      6,
                                visitor_id:         7 )

      expect(payload).to_not be_valid
    end

    it "is invalid without responded_in" do
      payload = Payload.create( url_id:             12,
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                referral_id:        2,
                                request_id:         3,
                                event_id:           4,
                                user_agent_stat_id: 5,
                                resolution_id:      6,
                                visitor_id:         7 )

      expect(payload).to_not be_valid
    end

    it "is invalid without referral_id" do
      payload = Payload.create( url_id:             12,
                                responded_in:       37,
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                request_id:         3,
                                event_id:           4,
                                user_agent_stat_id: 5,
                                resolution_id:      6,
                                visitor_id:         7 )

      expect(payload).to_not be_valid
    end

    it "is invalid without request_id" do
      payload = Payload.create( url_id:             12,
                                responded_in:       37,
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                referral_id:        2,
                                event_id:           4,
                                user_agent_stat_id: 5,
                                resolution_id:      6,
                                visitor_id:         7 )

      expect(payload).to_not be_valid
    end

    it "is invalid without event_id" do
      payload = Payload.create( url_id:             12,
                                responded_in:       37,
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                referral_id:        2,
                                request_id:         3,
                                user_agent_stat_id: 5,
                                resolution_id:      6,
                                visitor_id:         7 )

      expect(payload).to_not be_valid
    end

    it "is invalid without user_agent_stat_id" do
      payload = Payload.create( url_id:             12,
                                responded_in:       37,
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                referral_id:        2,
                                request_id:         3,
                                event_id:           4,
                                resolution_id:      6,
                                visitor_id:         7 )

      expect(payload).to_not be_valid
    end

    it "is invalid without resolution_id" do
      payload = Payload.create( url_id:             12,
                                responded_in:       37,
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                referral_id:        2,
                                request_id:         3,
                                event_id:           4,
                                user_agent_stat_id: 5,
                                visitor_id:         7 )

      expect(payload).to_not be_valid
    end

    it "is invalid without visitor_id" do
      payload = Payload.create( url_id:             12,
                                responded_in:       37,
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                referral_id:        2,
                                request_id:         3,
                                event_id:           4,
                                user_agent_stat_id: 5,
                                resolution_id:      6 )

      expect(payload).to_not be_valid
    end

    it "is valid with all atributes" do
      payload = Payload.create( url_id:             12,
                                responded_in:       37,
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                referral_id:        2,
                                request_id:         3,
                                event_id:           4,
                                user_agent_stat_id: 5,
                                resolution_id:      6,
                                visitor_id:         7 )

      expect(payload).to be_valid
    end

    it "is invalid unless responded_in is unique" do
      payload1 = Payload.create( url_id:             12,
                                 responded_in:       37,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             12,
                                 responded_in:       37,
                                 requested_at:       "2016-01-30",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      expect(payload2).to_not be_valid
    end

    it "is invalid unless requested_at is unique" do
      payload1 = Payload.create( url_id:             12,
                                 responded_in:       37,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             12,
                                 responded_in:       17,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

     expect(payload2).to_not be_valid
    end
  end

  describe ".average_response_time" do
    it "returns average response time across all payloads" do
      payload1 = Payload.create( url_id:             12,
                                 responded_in:       20,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             12,
                                 responded_in:       30,
                                 requested_at:       "2016-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

     expect(Payload.average_response_time).to eq(25)
    end
  end

  describe ".max_response_time" do
    it "returns the longest response time across all payloads" do
      payload1 = Payload.create( url_id:             12,
                                 responded_in:       20,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             12,
                                 responded_in:       30,
                                 requested_at:       "2014-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload3 = Payload.create( url_id:             12,
                                 responded_in:       40,
                                 requested_at:       "2016-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

     expect(Payload.max_response_time).to eq(40)
    end
  end

  describe ".min_response_time" do
    it "returns the shortest response time across all payloads" do
      payload1 = Payload.create( url_id:             12,
                                 responded_in:       20,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             12,
                                 responded_in:       30,
                                 requested_at:       "2014-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload3 = Payload.create( url_id:             12,
                                 responded_in:       40,
                                 requested_at:       "2016-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      expect(Payload.min_response_time).to eq(20)
    end
  end

  describe ".all_response_times" do
    it "returns sorted response times across all payloads" do
      payload1 = Payload.create( url_id:             12,
                                 responded_in:       40,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             12,
                                 responded_in:       30,
                                 requested_at:       "2014-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload3 = Payload.create( url_id:             12,
                                 responded_in:       20,
                                 requested_at:       "2016-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      expected = [20, 30, 40]
      expect(Payload.all_response_times).to eq(expected)
    end
  end
end
