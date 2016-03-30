require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_it_can_accept_client
    setup_client

    assert_equal 1, Client.all.first.id
    assert_equal "jumpstartlab", Client.all.first.identifier
    assert_equal "http://jumpstartlab.com", Client.all.first.root_url
  end

  def test_it_fails_with_a_client_with_no_identifier
    setup_client
    Client.create(identifier: nil, root_url: "http://jumpstartlab.com")

    assert_equal 1, Client.all.count
  end

  def test_it_fails_with_a_client_with_no_root_url
    setup_client
    Client.create(identifier: "jumpstartlab", root_url: nil)

    assert_equal 1, Client.all.count
  end

  # def test_it_checks_for_empty_address
  #   url = Client.create(address: nil)
  #
  #   assert_nil url.address
  # end
  #
  # def test_it_responds_with_an_error_message
  #   url = Client.create(address: nil)
  #
  #   assert_equal "can't be blank", url.errors.messages[:address][0]
  # end
  #
  # def test_it_returns_from_most_to_least_requested_urls
  #   setup_data
  #
  #   assert_equal ["http://jumpstartlab.com", "http://turing.io"], Client.most_to_least_requested
  # end

end
