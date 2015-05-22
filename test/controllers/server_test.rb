require './test/test_helper'

class ServerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
    @pload =
    'payload={"url": "http://jumpstartlab.com/blog",
      "requestedAt"       : "2013-02-16 21:38:28 -0700",
      "respondedIn"       : 37,
      "referredBy"        : "http://jumpstartlab.com",
      "requestType"       : "GET",
      "parameters"         : [],
      "eventName"         :  "socialLogin",
      "userAgent"         : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth"   : "1920",
      "resolutionHeight"  : "1280",
      "ip"                 : "63.29.38.211"}'
    @source = 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_create_registration_with_parameter
    assert_equal 0, Source.count
    post '/sources' , {"identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 1, Source.count
    assert_equal 200, last_response.status
    assert_equal "Success", last_response.body
  end

  def test_fail_when_create_with_missing_title
    assert_equal 0, Source.count
    post '/sources' ,{"rootUrl" => "http://jumpstartlab.com" }
    assert_equal 0, Source.count
    assert_equal 400, last_response.status
    assert_equal "Parameters cannot be empty", last_response.body
  end

  def test_fail_when_create_with_missing_root_url
    assert_equal 0, Source.count
    post '/sources' ,{"identifier" => "jumpstartlab"}
    assert_equal 0, Source.count
    assert_equal 400, last_response.status
    assert_equal "Parameters cannot be empty", last_response.body
  end

  def test_identifier_already_exist_error
    assert_equal 0, Source.count
    post '/sources' ,{"identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 1, Source.count
    assert_equal 200, last_response.status
    assert_equal "Success", last_response.body
    post '/sources' ,{"identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 1, Source.count
    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken", last_response.body
  end

  def test_payload_returns_200_when_request_is_unique
    skip
#    post '/sources', {"identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" )
    post '/sources/jumpstartlab/data', @pload
    assert_equal 200, last_response.status
    assert_equal "Success", last_response.body
    payload = Payload.last
    assert_equal "http://jumpstartlab.com/blog", payload.url
  end

  def test_response_when_identifier_doesnt_exist
    skip
    Source.create(identifier: "identifier1", root_url: "http://jumpstartlab.com" )
    post '/sources/identifier1/data',  'payload={"url": "http://jumpstartlab.com/blog",
                    "ip"                 : "63.29.38.211"}'
   #  assert_equal 403, last_response.status
    assert_equal "application url does not exist", last_response.body
  end

  def test_that_attributes_are_being_created
    source = Source.create(identifier: "identifier1", root_url: "http://jumpstartlab.com" )
    post '/sources/identifier1/data', @pload
    payload = Payload.last
    assert_equal 200, last_response.status
    assert_equal source, payload.source
    assert_equal "http://jumpstartlab.com/blog", payload.url.url
    assert_equal "/blog", payload.url.relative_path
    assert_equal "2013-02-16 21:38:28 -0700", payload.requested_at
    assert_equal 37, payload.responded_in
    assert_equal "http://jumpstartlab.com", payload.referrer.referred_by_url
    assert_equal "GET", payload.request_type.request_type
    assert_equal [], payload.parameters
    assert_equal "socialLogin", payload.event_name.event_name
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
 payload.user_agent.web_browser
    assert_equal "1920", payload.screen_resolution.resolution_width
    assert_equal "1280", payload.screen_resolution.resolution_height
    assert_equal "63.29.38.211", payload.ip
  end

  # def test_response_when_payload_is_identical
  #   post '/sources/jadvaerbaerbllltarklab/data',  @pload
  #   assert_equal 200, last_response.status
    # post '/sources/jadvaerbaerbllltarklab/data',  @pload
  #   assert_equal 403, last_response.status
  # end

  # def test_payload_returns_400_when_payload_missing_or_empty_hash
  #   skip
    #post '/sources' ,{identifier: "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    #post '/sources/jumpstartlab/data', {payload: '{}'}
    #assert_equal 400, last_response.status
    #assert_equal "bad_request", last_response.body
    #post '/sources/jumpstartlab/data', {payload: nil }
    #assert_equal 400, last_response.status
    #assert_equal "bad_request", last_response.body
  # end
end
