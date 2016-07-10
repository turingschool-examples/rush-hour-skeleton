require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_that_it_creates_an_client_row
    client = Client.new(identifier: "turing", root_url: "http://turing.io")
    assert client.valid?
  end

  def test_it_fails_when_required_info_is_not_entered
    client = Client.new(identifier: "turing", root_url: nil)
    refute client.valid?
  end

  def test_it_does_not_save_when_arg_is_missing
    client = Client.new
    refute client.save
  end

  def test_it_has_a_relationship_with_payload_requests
    client = Client.new
    assert client.respond_to?(:payload_requests)
  end

  def test_client_does_not_have_relationship_with_missing_table
    client = Client.new
    refute client.respond_to?(:nonepizza)
  end

  def test_client_has_relationship_with_urls
    client = Client.new
    assert client.respond_to?(:urls)
  end

  def test_client_has_relationship_with_user_agent_devices
    client = Client.new
    assert client.respond_to?(:user_agent_devices)
  end

  def test_client_has_relationship_with_ips
    client = Client.new
    assert client.respond_to?(:ips)
  end

  def test_client_has_relationship_with_referrers
    client = Client.new
    assert client.respond_to?(:referrals)
  end

  def test_client_has_relationship_with_request_types
    client = Client.new
    assert client.respond_to?(:request_types)
  end

  def test_client_has_relationship_with_resolutions
    client = Client.new
    assert client.respond_to?(:resolutions)
  end

end
