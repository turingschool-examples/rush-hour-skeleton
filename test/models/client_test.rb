require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert PayloadRequest
    assert Client
  end


  def test_can_create_client_through_payload_request
    pr = create_payload_1

    assert_equal "jumpstartlab", Client.find(1).identifier
    assert_equal 1, pr.client.id
  end

  def test_can_create_client_root_url

    client = {identifier: "google", root_url:  "http://www.google.com"}
     client_data = Client.create(client)

    assert client_data.valid?
    assert_equal "http://www.google.com", client_data.root_url
    assert_equal 1, client_data.id
  end

  def test_the_same_client_will_not_be_added_to_database

    client = {identifier: "google", root_url: "http://www.google.com"}
    client_data = Client.create(client)

    assert_equal 1, Client.all.count

    client2 = {identifier: "google", root_url: "http://www.google.com"}

    client2_data = Client.create(client2)

    refute client2_data.valid?
    assert client2_data.id.nil?
    assert_equal 1, Client.all.count
  end

end
