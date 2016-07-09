require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_there_is_client
    assert Client

  end

  def test_it_can_create_client_instance
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')

    assert_equal 1, Client.count
    assert_equal 'jumpstartlab', client.identifier
    assert_equal 'http://jumpstartlab.com', client.root_url
  end

  def test_client_relationship_to_payload_requests
    three_relationship_requests

    client = Client.first
    client.payload_requests << PayloadRequest.all.first

    assert client.respond_to?(:payload_requests)
    assert_instance_of PayloadRequest, client.payload_requests.first

  end

  def test_it_cannot_create_client_without_identifer
    client = Client.new(root_url: 'http://jumpstartlab.com')

    refute client.valid?
  end

  def test_it_cannot_create_client_without_root_url
    client = Client.new(identifier: 'jumpstartlab')

    refute client.valid?
  end

  def test_it_cannot_create_client_with_existing_identifier

    client = Client.new(identifier: 'jumpstartlab')

    refute client.valid?
  end
end
