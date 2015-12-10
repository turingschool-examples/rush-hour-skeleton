require_relative '../test_helper'
# require 'json'

class ServerPayloadTest < TrafficTest
  include PayloadPrep

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
    first_count = TrafficSpy::Payload.count
    post '/sources/jumpstartlab/data', payload_params
    second_count = TrafficSpy::Payload.count

    assert_equal 200, last_response.status
    assert_equal 1, (second_count - first_count)
  end

  def test_duplicate_payload_is_rejected
    register_user('jumpstartlab')
    post '/sources/jumpstartlab/data', payload_params
    post '/sources/jumpstartlab/data', payload_params
    response = "This specific payload already exists in the database..."

    assert_equal 403, last_response.status
    assert_equal response, last_response.body
  end

  def test_missing_payload_is_rejected
    register_user('jumpstartlab')
    post '/sources/jumpstartlab/data'
    response = "No payload received in the request"

    assert_equal 400, last_response.status
    assert_equal response, last_response.body
  end

  def test_unregistered_user_cannot_submit_payload
    post '/sources/jumpstartlab/data', payload_params1
    response = "jumpstartlab is not registered"

    assert_equal 403, last_response.status
    assert_equal response, last_response.body
  end

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
