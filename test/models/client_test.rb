require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_it_validates_client_attributes
    client = Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    assert client.valid?
    assert_equal 1, Client.all.count
  end

end
