require_relative '../test_helper'
require './app/models/client'

class ClientTest < ModelTest
  def test_it_has_rootUrl
    client = Client.new({root_url: "http://example.com",
                          identifier: 'exmaple'})

    client_sad = Client.new({})
    assert client.save
    refute client_sad.save
  end
end
