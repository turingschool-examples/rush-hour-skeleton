require './test/test_helper'

class SendPayloadTest < Minitest::Test
  include TestHelper
  include Rack::Test::Methods

  def app
    RushHour::Server
  end

  def test_returns_success_post_valid_payload_request
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body

    post '/sources/jumpstartlab/data', payload_request

    # require 'pry'; binding.pry
    assert_equal 1, PayloadRequest.count
    assert_equal 200, last_response.status
    assert_equal "Payload successfully created", last_response.body
  end

  def test_returns_attributes_missing_when_payload_request_contains_one_or_more_attributes
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body

    post '/sources/jumpstartlab/data', payload_request.sub("\"respondedIn\":37,", "")

    assert_equal 0, PayloadRequest.count
    assert_equal 400, last_response.status
    assert_equal "missing one or more attributes", last_response.body
  end

  def test_returns_already_received_when_duplicate_payload_request_is_recieved
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body

    post '/sources/jumpstartlab/data', payload_request
    post '/sources/jumpstartlab/data', payload_request

    assert_equal 1, PayloadRequest.count
    assert_equal 403, last_response.status
    assert_equal "Payload has already been received", last_response.body
  end

  def test_returns_payload_missing_when_no_payload_is_present
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body

    post '/sources/jumpstartlab/data'

    assert_equal 0, PayloadRequest.count
    assert_equal 400, last_response.status
    assert_equal "No payload present", last_response.body
  end

  def test_returns_client_does_not_exist_when__no_matching_client
    post '/sources/jumpstartlab/data', payload_request

    assert_equal 0, PayloadRequest.count
    assert_equal 403, last_response.status
    assert_equal "Client does not exist", last_response.body
  end


  def payload_request
    "payload={\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com/\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
  end


end
