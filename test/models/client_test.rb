require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_it_creates_client_with_correct_attributes
    create_payload(1)
    client = Client.find(1)

    assert_equal "jumpstartlab0", client.identifier
    assert_equal "http://jumpstartlab.com0", client.root_url
  end

  def test_all_through_client_relationships
    create_payload(1)

    client = Client.find(1)

    assert_equal 1, client.urls.length
    assert_equal 1, client.request_types.length
    assert_equal 1, client.ips.length
    assert_equal 1, client.request_types.length
    assert_equal 1, client.resolutions.length
    binding.pry
    # assert_equal 1, client.referrers.length
    # assert_equal 1, client.software_agents.length
  end
end
