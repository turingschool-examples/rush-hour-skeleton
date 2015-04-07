require './test/test_helper'

class ServerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_create_registration_with_parameter
    post '/sources' ,{identifier: {title: "jumpstartlab", root_url: "http://jumpstartlab.com" }}
    assert_equal 200, last_response.status
    assert_equal "success", last_response.body
  end

  def test_fail_when_create_with_missing_title
    post '/sources' ,{identifier: {root_url: "http://jumpstartlab.com" }}
    assert_equal 400, last_response.status
    assert_equal "Title can't be blank", last_response.body
  end

  def test_fail_when_create_with_missing_root_url
    post '/sources' ,{identifier: {title: "jumpstartlab"}}
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end

  def test_identifier_already_exist_error
    post '/sources' ,{identifier: {title: "jumpstartlab", root_url: "http://jumpstartlab.com" }}
    assert_equal 200, last_response.status
    assert_equal "success", last_response.body
    post '/sources' ,{identifier: {title: "jumpstartlab", root_url: "http://jumpstartlab.com" }}
    assert_equal 403, last_response.status
    assert_equal "Title has already been taken", last_response.body
  end
end
