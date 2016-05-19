require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_it_creates_client_with_correct_attributes
    assert_equal "jumpstartlab", client.identifier
    assert_equal "http://jumpstartlab.com", client.root_url
  end

  def test_all_through_client_relationships
    assert_equal 1, client.urls.count
    assert_equal 1, client.referrers.count
    assert_equal 1, client.request_types.count
    assert_equal 1, client.user_agents.count
    assert_equal 1, client.ips.count
    assert_equal 1, client.resolutions.count
    assert_equal 1, client.event_names.count
  end

end
