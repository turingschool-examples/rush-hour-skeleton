require './test/test_helper.rb'

class RegisterUserTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server #may change this name later - SP
  end

  def test_new_user_can_register
    post '/sources' { user: { data_identifier: "example", root_url: "HTTP://Example.com"}}
 # {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}
    assert_equal 1, User.count
    assert_equal 200, last_response.status
    assert_equal "Success - 200 OK", last_response.body
  end

  def test_unregistered_user_receives_error_when_id_missing
    post '/sources' { user: { root_url: "HTTP://Example.com"}}

    assert_equal 0, User.count
    assert_equal 400, last_response.status
    assert_equal "Missing Params 400 - Bad Request", last_response.body

  end

  def test_unregistered_user_receives_error_when_url_missing
    post '/sources' { user: { data_identifier: "example"}}

    assert_equal 0, User.count
    assert_equal 400, last_response.status
    assert_equal "Missing Params 400 - Bad Request", last_response.body
  end

  def test_unregistered_user_receives_error_when_id_and_url_missing
    post '/sources' { user: { }}

    assert_equal 0, User.count
    assert_equal 400, last_response.status
    assert_equal "Missing Params 400 - Bad Request", last_response.body
  end

  def test_registered_user_receives_error_when_registering
    # create a user with the data_id "example" and root_url "http://example.com"
    assert_equal 1, User.count
    post '/sources' { user: { data_identifier: "example", root_url: "HTTP://Example.com"}}

    assert_equal 1, User.count
    assert_equal 403, last_response.status
    assert_equal "User already exists 403 - Bad Request", last_response.body

  end
end
