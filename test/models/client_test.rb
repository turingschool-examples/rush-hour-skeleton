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

  def test_average_response_time_for_client
    five_payload_requests

    client = Client.first

    assert_equal 39, client.average_response_time
  end

  def test_max_response_time_for_a_client
    five_payload_requests

    client = Client.first

    assert_equal 60, client.max_response_time
  end

  def test_min_response_time_for_a_client
    five_payload_requests

    client = Client.first

    assert_equal 20, client.min_response_time
  end

  def test_most_frequent_request_type
    eight_payload_requests

    client = Client.first

    assert_equal "POST", client.most_frequent_request_type
  end

  # def test_average_response_time_for_client
  #   five_payload_requests
  #
  #   assert_equal 39, Client.average_response_time("jumplab")
  #   assert_equal 35, Client.average_response_time("startlab")
  # end
  #
  # def test_max_response_time_for_a_client
  #   five_payload_requests
  #
  #   assert_equal 60, Client.max_response_time("jumplab")
  #   assert_equal 42, Client.max_response_time("startlab")
  # end
  #
  # def test_min_response_time_for_a_client
  #   five_payload_requests
  #
  #   assert_equal 20, Client.min_response_time("jumplab")
  #   assert_equal 28, Client.min_response_time("startlab")
  # end
end
