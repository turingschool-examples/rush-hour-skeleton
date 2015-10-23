require './test/test_helper.rb'

class PayloadTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def test_request_contains_payload
    post '/sources', {"identifier" => "jumpstartlab", "rootUrl" => "HTTP://Example.com"}
    post '/sources/jumpstartlab/data', {"payload"=> "{\"url\":\"http://jumpstartlab.com/blog\",
                                                      \"requestedAt\":\"2013-02-16 21:38:28 -0700\",
                                                      \"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",
                                                      \"requestType\":\"GET\",
                                                      \"parameters\":[],
                                                      \"eventName\": \"socialLogin\",
                                                      \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
                                                      \"resolutionWidth\":\"1920\",
                                                      \"resolutionHeight\":\"1280\",
                                                      \"ip\":\"63.29.38.211\"}"}


    assert_equal 200, last_response.status
  end

  def test_that_request_denied_if_request_is_not_unique
    skip
    post '/sources', {"identifier" => "jumpstartlab", "rootUrl" => "HTTP://Example.com"}
    post '/sources/jumpstartlab/data', {"payload"=> "{\"url\":\"http://jumpstartlab.com/blog\",
                                                      \"requestedAt\":\"2013-02-16 21:38:28 -0700\",
                                                      \"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",
                                                      \"requestType\":\"GET\",
                                                      \"parameters\":[],
                                                      \"eventName\": \"socialLogin\",
                                                      \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
                                                      \"resolutionWidth\":\"1920\",
                                                      \"resolutionHeight\":\"1280\",
                                                      \"ip\":\"63.29.38.211\"}"}
    assert_equal 1, Payload.count
    post '/sources/jumpstartlab/data', {"payload"=> "{\"url\":\"http://jumpstartlab.com/blog\",
                                                      \"requestedAt\":\"2013-02-16 21:38:28 -0700\",
                                                      \"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",
                                                      \"requestType\":\"GET\",
                                                      \"parameters\":[],
                                                      \"eventName\": \"socialLogin\",
                                                      \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
                                                      \"resolutionWidth\":\"1920\",
                                                      \"resolutionHeight\":\"1280\",
                                                      \"ip\":\"63.29.38.211\"}"}

    assert_equal 1, Payload.count
    assert_equal 403, last_response.status
    assert_equal "403 Forbidden - Duplicate Payload", last_response.body
  end

  def test_that_request_denied_if_user_is_unregistered
    post '/sources/jumpstartlab/data', {"payload"=> "{\"url\":\"http://jumpstartlab.com/blog\",
                                                      \"requestedAt\":\"2013-02-16 21:38:28 -0700\",
                                                      \"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",
                                                      \"requestType\":\"GET\",
                                                      \"parameters\":[],
                                                      \"eventName\": \"socialLogin\",
                                                      \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
                                                      \"resolutionWidth\":\"1920\",
                                                      \"resolutionHeight\":\"1280\",
                                                      \"ip\":\"63.29.38.211\"}"}

    assert_equal 0, Payload.count
    assert_equal 403, last_response.status
    assert_equal "403 Forbidden - User Does Not Exist", last_response.body
  end

  def test_that_request_denied_if_payload_is_empty
    post '/sources/jumpstartlab/data'

    assert_equal 0, Payload.count
    assert_equal 400, last_response.status
    assert_equal "400 Bad Request - Payload Missing", last_response.body
  end
end
