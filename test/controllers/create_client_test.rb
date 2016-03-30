require_relative '../test_helper'

class CreateClientTest < Minitest::Test
  include TestHelpers
  include Rack::Test::Methods

  def test_registers_a_client_with_valid_attributes
    register_client

    assert_equal 1, Client.count
    assert_equal "jumpstartlab", Client.all.first.identifier
    assert_equal "http://jumpstartlab.com", Client.all.first.root_url
    assert_equal 200, last_response.status
    assert_equal "good request", last_response.body
  end

  def test_returns_correct_count_given_multiple_post
    register_client
    post '/sources', { client: {}}

    assert_equal 1, Client.all.count
  end


  def test_returns_error_for_an_invalid_client
    # register_client
    post '/sources', { client: { identifier: "dfgdf", root_url: ""}}

    assert_equal 0, Client.all.count
    assert_equal 401, last_response.status
    assert_equal "invalid root_url", last_response.body
  end

end
