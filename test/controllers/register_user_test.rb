require './test/test_helper.rb'

class RegisterUserTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def test_new_user_can_register
    post '/sources', {"identifier" => "example", "rootUrl" => "HTTP://Example.com"}

    assert_equal 1, User.count
    assert_equal 200, last_response.status
    assert_equal "Success - 200 OK", last_response.body
  end

  def test_unregistered_user_receives_error_when_id_missing
    post '/sources', {"rootUrl" => "HTTP://Example.com"}

    assert_equal 0, User.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body

  end

  def test_unregistered_user_receives_error_when_url_missing
    post '/sources', { "identifier" => "example"}

    assert_equal 0, User.count
    assert_equal 400, last_response.status
    assert_equal "Rooturl can't be blank", last_response.body
  end

  def test_unregistered_user_receives_error_when_id_and_url_missing
    post '/sources', {}

    assert_equal 0, User.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank, Rooturl can't be blank", last_response.body
  end

  def test_registered_user_receives_error_when_registering
    post '/sources', {"identifier" => "example", "rootUrl" => "HTTP://Example.com"}
    assert_equal 1, User.count
    post '/sources', {"identifier" => "example", "rootUrl" => "HTTP://Example.com"}

    assert_equal 1, User.count
    assert_equal 403, last_response.status
    assert_equal "User already exists 403 - Bad Request", last_response.body

  end
end
