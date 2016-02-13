require_relative '../test_helper'

class ClientRegistrationTest < Minitest::Test
  include Rack::Test::Methods     # allows us to use get, post, last_request, etc.

  def app     # def app is something that Rack::Test is looking for
    RushHour::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_create_a_genre_with_valid_attributes
    post '/sources', { "rootUrl" => "http://www.google.com", "identifier" => "google" }
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"google\"}", last_response.body
  end

  def test_returns_error_message_for_missing_identifier
    post '/sources', { "rootUrl" => "http://www.google.com" }
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Missing Parameters", last_response.body
  end

  def test_returns_error_message_for_missing_url
    post '/sources', { "identifier" => "google" }
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Missing Parameters", last_response.body
  end
  #

  def test_returns_error_message_for_preexisting_identifier
    post '/sources', { "rootUrl" => "http://www.google.com", "identifier" => "google" }

    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"google\"}", last_response.body

    post '/sources', { "rootUrl" => "http://www.google.com", "identifier" => "google" }

    assert_equal 1, Client.count
    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken, Root url has already been taken", last_response.body
  end

end
