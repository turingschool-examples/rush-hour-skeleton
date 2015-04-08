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

  def test_payload_returns_200_when_request_is_unique
    skip
    post '/sources' ,{identifier: {title: "jumpstartlab", root_url: "http://jumpstartlab.com" }}
    post '/sources/jumpstartlab/data', {payload: '{"url": "http://jumpstartlab.com/blog",
      "requested_at"       : "2013-02-16 21:38:28 -0700",
      "responded_in"       : 37,
      "referred_by"        : "http://jumpstartlab.com",
      "request_type"       : "GET",
      "parameters"         : [],
      "event_name"         :  "socialLogin",
      "user_agent"         : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolution_width"   : "1920",
      "resolution_height"  : "1280",
      "ip"                 : "63.29.38.211"}'}
    assert_equal 200, last_response.status
    assert_equal "success", last_response.body
  end

  def test_payload_returns_400_when_payload_missing_or_empty_hash
    skip
    # we're taking in the payload request information
    # we're sending that to the JSON.parse method
    # before the JSON.parse method is called, we want to make sure the info is valid
    # it can't be nil or an empty hash
    # if it isn't then we run it through JSON parse
    # and create a new object



    #post '/sources' ,{identifier: {title: "jumpstartlab", root_url: "http://jumpstartlab.com" }}
    #post '/sources/jumpstartlab/data', {payload: '{}'}
    #assert_equal 400, last_response.status
    #assert_equal "bad_request", last_response.body
    #post '/sources/jumpstartlab/data', {payload: nil }
    #assert_equal 400, last_response.status
    #assert_equal "bad_request", last_response.body
  end
end
