require_relative '../test_helper'
class ServerTest < Minitest::Test
  include TestHelpers


  def test_it_can_create_a_client
    post '/sources', {client: {identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"} }
    assert_equal 200, last_response.status
    assert_equal 1, Client.count
    assert_equal "Success!", last_response.body
  end

  def test_it_returns_error_if_client_invalid
    post '/sources', {client: {root_url: "http://jumpstartlab.com"} }
    assert_equal 400, last_response.status
    assert_equal "Missing Parameters", last_response.body
    assert_equal 0, Client.count
  end

  def test_it_returns_error_if_client_already_exists
    post '/sources', {client: {identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"} }

    assert_equal 1, Client.count

    post '/sources', {client: {identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"} }

    assert_equal 403, last_response.status
    assert_equal 1, Client.count
    assert_equal "Identifier Already Exists", last_response.body
  end

end
