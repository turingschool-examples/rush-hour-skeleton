require_relative '../test_helper'

class PostPayloadTest < Minitest::Test
  def payload
    {"payload"=>"{
      \"url\":\"http://jumpstartlab.com/blog\",
      \"requestedAt\":\"2013-02-16 21:38:28 -0700\",
      \"respondedIn\":37,
      \"referredBy\":\"http://jumpstartlab.com\",
      \"requestType\":\"GET\",
      \"parameters\":[],
      \"eventName\": \"socialLogin\",
      \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
      \"resolutionWidth\":\"1920\",
      \"resolutionHeight\":\"1280\",
      \"ip\":\"63.29.38.211\"}",
 "splat"=>[],
 "captures"=>["jumpstartlab"],
 "id"=>"jumpstartlab"}
    # {"payload"=>
    #    "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16
    #    21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":
    #    \"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],
    #    \"eventName\":\"socialLogin\",\"userAgent\":
    #    \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17
    #    (KHTML, like Gecko) Chrome/24.0.1309.0
    #    Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":
    #    \"1280\",\"ip\":\"63.29.38.211\"}",
    #    "splat"=>[],
    #    "captures"=>["jumpstartlab"],
    #    "id"=>"jumpstartlab"}
  end

  def test_a_request_gets_created_with_valid_data
    Application.create(identifier: 'jumpstartlab', root_url: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', payload

    assert_equal 200, last_response.status
    assert_equal 1, Request.count
  end

  def test_request_is_not_created_if_missing_payload
    Application.create(identifier: 'jumpstartlab', root_url: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', {}

    assert_equal 400, last_response.status
    assert_equal 0, Request.count
    assert_equal "Missing payload.", last_response.body
  end

  def test_request_is_not_created_if_duplicated
    Application.create(identifier: 'jumpstartlab', root_url: "http://jumpstartlab.com")
    Request.create(request_hash: Digest::SHA1.hexdigest(payload["payload"]))

    post '/sources/jumpstartlab/data', payload

    assert_equal 1, Request.count
    assert_equal 400, last_response.status
    assert_equal "Duplicate entry.", last_response.body
  end

  def test_request_is_not_created_if_application_not_registered
    post '/sources/jumpstartlab/data', payload

    assert_equal 0, Request.count
    assert_equal 403, last_response.status
    assert_equal "Application not registered.", last_response.body
    assert_equal 0, Url.count
  end
end
