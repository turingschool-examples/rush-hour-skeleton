require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelper

  def test_it_can_save_a_client
    create_client

    client = Client.first

    assert_equal "jumpstartlabs", client.identifier
    assert_equal "www.jumpstartlabs.com", client.root_url
  end

  def test_it_doesnt_save_client_with_invalid_root_url
    Client.create(identifier: "jumpstartlab")

    assert_equal [], Client.all.to_a
  end

  def test_it_doesnt_save_client_with_invalid_identifier
    Client.create(root_url: "www.jumpstartlabs.com")

    assert_equal [], Client.all.to_a
  end

  def test_it_has_many_payload_requests
    client = create_client

    create_generic_payload_requests

    assert_equal 2, client.payload_requests.count
  end

  def test_it_has_many_user_agents
    client = create_client

    create_user_agent

    create_generic_payload_requests

    assert_equal 2, client.user_agents.count
  end

  def test_it_has_many_request_types
    client = create_client

    create_request_type

    create_generic_payload_requests

    assert_equal 2, client.request_types.count
  end

  def test_it_has_many_urls
    client = create_client

    create_url

    create_generic_payload_requests

    assert_equal 2, client.urls.count
  end

  def test_it_has_many_resolutions
    client = create_client

    create_resolution

    create_generic_payload_requests

    assert_equal 2, client.resolutions.count
  end

  def test_it_returns_it_has_payload_requests
    client = create_client

    create_generic_payload_requests

    assert client.has_payload_requests?
  end

  def test_it_returns_it_doesnt_have_payload_requests
    client = create_client

    refute client.has_payload_requests?
  end
end
