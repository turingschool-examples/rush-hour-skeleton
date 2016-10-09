require_relative '../spec_helper'

RSpec.describe "Resolution" do
  describe "validation" do
    it "is invalid without height" do
      resolution = Resolution.create(width: "10")

      expect(resolution).to_not be_valid
    end

    it "is invalid without width" do
      resolution = Resolution.create(height: "10")

      expect(resolution).to_not be_valid
    end

    it "is valid with all attributes" do
      resolution = Resolution.create(height: "10", width: "10")

      expect(resolution).to be_valid
    end
  end

  describe ".height_breakdown" do
    it "breaks down resolution height across all payloads" do
      resolution1 = Resolution.create(height: "5", width: "10")
      resolution2 = Resolution.create(height: "5", width: "6")
      resolution3 = Resolution.create(height: "4", width: "6")

      payload1 = Payload.create( url_id:             12,
                                 responded_in:       40,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      resolution1.id,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             12,
                                 responded_in:       30,
                                 requested_at:       "2014-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      resolution2.id,
                                 visitor_id:         7 )

      payload3 = Payload.create( url_id:             12,
                                 responded_in:       20,
                                 requested_at:       "2016-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      resolution3.id,
                                 visitor_id:         7 )

      expected = {"5"=>2, "4"=>1}
      expect(Resolution.height_breakdown).to eq(expected)
    end
  end

  describe ".width_breakdown" do
    it "breaks down resolution width across all payloads" do
      resolution1 = Resolution.create(height: "5", width: "10")
      resolution2 = Resolution.create(height: "5", width: "6")
      resolution3 = Resolution.create(height: "4", width: "6")

      payload1 = Payload.create( url_id:             12,
                                 responded_in:       40,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      resolution1.id,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             12,
                                 responded_in:       30,
                                 requested_at:       "2014-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      resolution2.id,
                                 visitor_id:         7 )

      payload3 = Payload.create( url_id:             12,
                                 responded_in:       20,
                                 requested_at:       "2016-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      resolution3.id,
                                 visitor_id:         7 )

      expected = {"10"=>1, "6"=>2}
      expect(Resolution.width_breakdown).to eq(expected)
    end
  end

  describe ".resolutions_across_all_payloads" do
    it "returns resolutions across all payloads" do
      resolution1 = Resolution.create(height: "5", width: "10")
      resolution2 = Resolution.create(height: "5", width: "10")
      resolution3 = Resolution.create(height: "4", width: "6")

      payload1 = Payload.create( url_id:             12,
                                 responded_in:       40,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      resolution1.id,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             12,
                                 responded_in:       30,
                                 requested_at:       "2014-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      resolution2.id,
                                 visitor_id:         7 )

      payload3 = Payload.create( url_id:             12,
                                 responded_in:       20,
                                 requested_at:       "2016-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: 5,
                                 resolution_id:      resolution3.id,
                                 visitor_id:         7 )

      expected = {["5", "10"]=>2, ["4", "6"]=>1}
      expect(Resolution.resolutions_across_all_payloads).to eq(expected)
    end
  end
end
