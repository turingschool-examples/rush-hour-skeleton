require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_browser_breakdown_returns_browser_with_count
    event_name2 = EventName.create({:name => "Show"})
    PayloadRequest.create({
      :url_id => url.id,
      :referrer_id => referrer.id,
      :request_type_id => request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => event_name2.id,
      :user_agent_id => user_agent.id,
      :responded_in => 39,
      :parameters => [],
      :ip_id => ip.id,
      :resolution_id => resolution.id,
      :client_id => client.id
      })
    assert_equal ({"socialLogin" => 1, "Show" => 1}), EventName.events_breakdown
  end

end
