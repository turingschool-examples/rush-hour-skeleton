require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers
  attr_reader :payload, :url, :referrer, :request_type, :event_name,
              :user_agent, :resolution, :ip


  def test_resolution_breakdown_returns_resolution_with_count
    resolution2 = Resolution.create({:width => "1920", :height => "1280"})
    PayloadRequest.create({
      :url_id => url.id,
      :referrer_id => referrer.id,
      :request_type_id => request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => event_name.id,
      :user_agent_id => user_agent.id,
      :responded_in => 39,
      :parameters => [],
      :ip_id => ip.id,
      :resolution_id => resolution2.id
      })
    assert_equal ({"1280 x 1920" => 2}), Resolution.resolutions_breakdown
  end


end
