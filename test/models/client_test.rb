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

  def test_identifier_already_exists_in_clients_table
    
  end
end
