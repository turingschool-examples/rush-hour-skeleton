require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_browser_breakdown_returns_browser_with_count
    user_agent2 = UserAgent.create({:browser => "Chrome", :platform => "Windows"})
    PayloadRequest.create({
      :url_id => url.id,
      :referrer_id => referrer.id,
      :request_type_id => request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => event_name.id,
      :user_agent_id => user_agent2.id,
      :responded_in => 39,
      :parameters => [],
      :ip_id => ip.id,
      :resolution_id => resolution.id,
      :client_id => client.id
      })
    assert_equal ({"Mozilla" => 1, "Chrome" => 1}), UserAgent.web_browser_breakdown
  end

  def test_platform_breakdown_returns_platform_with_count
    user_agent2 = UserAgent.create({:browser => "Chrome", :platform => "Macintosh"})
    PayloadRequest.create({
      :url_id => url.id,
      :referrer_id => referrer.id,
      :request_type_id => request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => event_name.id,
      :user_agent_id => user_agent2.id,
      :responded_in => 39,
      :parameters => [],
      :ip_id => ip.id,
      :resolution_id => resolution.id,
      :client_id => client.id
      })
    assert_equal ({"Macintosh" => 2}), UserAgent.web_platform_breakdown
  end

end
