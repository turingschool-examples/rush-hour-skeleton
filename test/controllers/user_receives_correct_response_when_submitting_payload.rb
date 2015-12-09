require_relative '../test_helper'
require 'json'

class PayloadTest < TrafficTest

  def register_user(identifier)
    post '/sources', {rootUrl: 'http://turing.io', identifier: identifier}
  end

  def payload_params
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}
  end

  def test_payload_table_loads_valid_data
    register_user('jumpstartlab')
    first_count = Payload.count
    post '/sources/jumpstartlab/data', payload_params
    second_count = Payload.count

    assert_equal 200, last_response.status
    assert_equal 1, (second_count - first_count)
  end
  # {"url"=>"http://jumpstartlab.com/blog",
  #  "requestedAt"=>"2013-02-16 21:38:28 -0700",
  #  "respondedIn"=>37,
  #  "referredBy"=>"http://jumpstartlab.com",
  #  "requestType"=>"GET",
  #  "parameters"=>[],
  #  "eventName"=>"socialLogin",
  #  "userAgent"=>
  #   "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
  #  "resolutionWidth"=>"1920",
  #  "resolutionHeight"=>"1280",
  #  "ip"=>"63.29.38.211"}

end
