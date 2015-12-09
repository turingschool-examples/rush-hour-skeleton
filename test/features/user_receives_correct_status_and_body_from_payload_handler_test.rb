require_relative '../test_helper'

class UserReceivesCorrectStatusAndBodyFromPayloadHandlerTest < Minitest::Test

  def payload
    {"payload"=>
     "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "identifier"=>"jumpstartlab"}
  end

  def nil_payload
    {"payload"=> nil,
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "identifier"=>"jumpstartlab"}
  end

  def test_user_receives_200_http_status_with_valid_payload
    post '/sources/:identifier/data', payload

    assert_equal 200, last_response.status
  end

  def test_user_receives_400_http_status_and_payload_missing_body_with_missing_payload
    post '/sources/:identifier/data', nil_payload

    assert_equal 400, last_response.status
    assert_equal "Payload Missing.", last_response.body
  end

end
