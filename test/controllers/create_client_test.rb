require './test/test_helper'

class CreateClientTest < Minitest::Test
  include TestHelper
  include Rack::Test::Methods

  def app
    RushHour::Server
  end

  def test_create_client_with_valid_params
    assert_equal 0, Client.count

    post '/sources', {
                       identifier: "name",
                       rootUrl: "www.example.com"
                     }

    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"name\"}\n", last_response.body
  end

  def test_create_client_with_invalid_params_no_rootUrl
    assert_equal 0, Client.count

    post '/sources', {
                       identifier: "name"
                     }
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank\n", last_response.body
  end

  def test_create_client_with_invalid_params_no_identifier
    assert_equal 0, Client.count

    post '/sources', {
                       rootUrl: "www.example.com"
                     }
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank\n", last_response.body
  end

  def test_create_duplicate_client
    # skip
    assert_equal 0, Client.count

    post '/sources', {
                       identifier: "name",
                       rootUrl: "www.example.com"
                     }

    assert_equal 1, Client.count

    post '/sources', {
                       identifier: "name",
                       rootUrl: "www.example.com"
                     }

    assert_equal 1, Client.count
    assert_equal 403, last_response.status
    assert_equal "Client with identifier: \"name\" already exists!\n", last_response.body
  end
end
