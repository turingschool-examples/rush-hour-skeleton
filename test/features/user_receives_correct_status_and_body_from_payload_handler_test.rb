require_relative '../test_helper'

class UserReceivesCorrectStatusAndBodyFromPayloadHandlerTest < Minitest::Test

  def setup
    Client.create({"name" => "jumpstartlab", "root_url" => "http://jumpstartlab.com"})
  end

  def payload
    {"payload"=>
     "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "identifier"=>"jumpstartlab"}
  end

  def unregistered_payload
    {"payload"=>
     "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "identifier"=>"binglol"}
  end

  def nil_payload
    {"payload"=> nil,
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "identifier"=>"jumpstartlab"}
  end

  def test_user_receives_200_http_status_with_valid_payload
    post '/sources/jumpstartlab/data', payload

    assert_equal 200, last_response.status
  end

  def test_user_receives_400_http_status_and_payload_missing_body_with_missing_payload
    post '/sources/jumpstartlab/data', nil_payload

    assert_equal 400, last_response.status
    assert_equal "Payload Missing.", last_response.body
  end

  def test_user_receives_403_http_status_for_unregistered_application
    post '/sources/binglol/data', payload

    assert_equal 403, last_response.status
    assert_equal "Application Not Registered.", last_response.body
  end

  def test_user_receives_403_http_status_for_duplicate_payload
    post '/sources/jumpstartlab/data', payload
    post '/sources/jumpstartlab/data', payload

    assert_equal 403, last_response.status
    assert_equal 1, Client.count
    assert_equal "Duplicate Payload.", last_response.body
  end

end
