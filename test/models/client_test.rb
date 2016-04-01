require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelper

  def test_it_can_save_a_client
    Client.create(identifier: "jumpstartlab",
                     root_url: "www.jumpstartlabs.com")

    client = Client.first

    assert_equal "jumpstartlab", client.identifier
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
end
