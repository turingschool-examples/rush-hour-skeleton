require './test/test_helper'

class CreateClientTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_create_client_with_valid_params
    skip
    assert_equal 0, Client.count

    post '/sources', {
                       identifier: "name",
                       rootUrl: "www.example.com"
                     }

    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{\"name\":\"www.example.com\"}", last_response.body
  end

end
