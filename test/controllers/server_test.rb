require_relative '../test_helper'

class ServerAppTest < Minitest::Test
  include TestHelpers

  def test_the_application_can_create_a_client
    skip
    post '/sources', {identifier: "turing", root_url: "https://turing.io"}
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "Client created", last_response.body
  end

  def test_the_application_cannot_create_a_client_without_an_identifier
    skip
    post '/sources', {root_url: "https://google.com"}
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_the_application_cannot_create_a_client_without_a_root_url
    post '/sources', {identifier: "google"}
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end

  def test_client_receives_error_if_client_identifier_is_taken
    post '/sources', {identifier: "turing", root_url: "https://turing.io"}
    post '/sources', {identifier: "turing", root_url: "https://turing.io"}
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end

end
