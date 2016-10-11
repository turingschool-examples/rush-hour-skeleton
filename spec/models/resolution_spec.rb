require_relative '../spec_helper'

RSpec.describe "Resolution" do

  it "is valid with all types of resolution" do
    resolution = Resolution.new(resolution_width: 48,
                                resolution_height: 16)
    expect(resolution).to be_valid
  end

  it "is invalid without a height" do
    resolution = Resolution.new(resolution_width: 48)

    expect(resolution).to_not be_valid
  end

  it "is invalid without a width" do
    resolution = Resolution.new(resolution_height: 48)

    expect(resolution).to_not be_valid
  end

  describe ".resolution_breakdown" do
    it "resolution => count" do
      Resolution.create(resolution_width: 5, resolution_height: 5)
      Resolution.create(resolution_width: 5, resolution_height: 10)
      Resolution.create(resolution_width: 10, resolution_height: 5)
      Resolution.create(resolution_width: 10, resolution_height: 10)

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
                            resolution_id: 2,
                            ip_id: 1)

      payload3 = Payload.create(url_id: 2,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 2,
                            event_name_id: 1,
                            agent_id: 2,
                            resolution_id: 3,
                            ip_id: 1)

      payload4 = Payload.create(url_id: 2,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 2,
                            event_name_id: 1,
                            agent_id: 2,
                            resolution_id: 4,
                            ip_id: 1)

      payload5 = Payload.create(url_id: 2,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 39,
                            referred_by_id: 1,
                            request_type_id: 2,
                            event_name_id: 1,
                            agent_id: 2,
                            resolution_id: 1,
                            ip_id: 1)

      expect(Resolution.resolution_breakdown).to eq({"10 x 10" => 1, "10 x 5" => 1, "5 x 10" => 1, "5 x 5" => 2})
    end
  end

end
