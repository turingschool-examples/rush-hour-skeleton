require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_it_creates_client_with_correct_attributes
    create_payloads(1)
    client = Client.find(1)

    assert_equal "jumpstartlab 0", client.identifier
    assert_equal "http://jumpstartlab.com0", client.root_url
  end

  def test_all_through_client_relationships
    create_payloads(1)
    client = Client.find(1)

    assert_equal 1, client.urls.count
    assert_equal 1, client.referrers.count
    assert_equal 1, client.request_types.count
    assert_equal 1, client.requested_ats.count
    assert_equal 1, client.user_agents.count
    assert_equal 1, client.responded_ins.count
    assert_equal 1, client.parameters.count
    assert_equal 1, client.ips.count
    assert_equal 1, client.resolutions.count
    assert_equal 1, client.event_names.count
  end

end
