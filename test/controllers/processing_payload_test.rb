require_relative '../test_helper'
require 'json'

class ProcessingPayloadTest < ControllerTest
  def create_source(identifier)
    post('/sources', {identifier: identifier, rootUrl: "http://#{identifier}.com" })
  end
  
  def create_payload_post
    post('/sources/jumpstartlab/data', { payload: 
        { :url=>              "http://jumpstartlab.com/blog",
          :requestedAt=>      "2013-02-16 21:38:28 -0700",
          :respondedIn=>      37,
          :referredBy=>       "http://jumpstartlab.com",
          :requestType=>      "GET",
          :parameters=>       [],
          :eventName=>        "socialLogin",
          :userAgent=>        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
          :resolutionWidth=>  "1920",
          :resolutionHeight=> "1280",
          :ip=>               "63.29.38.211"
        }.to_json } )
  end
  
  def test_processes_unique_payload_for_source
    create_source("jumpstartlab")
    initial_count = Payload.count
    create_payload_post
    final_count = Payload.count

    assert_equal 200, last_response.status
    assert_equal 1, final_count - initial_count
  end

  def test_returns_error_for_missing_payload_data
    create_source("jumpstartlab")
    initial_count = Payload.count
    post('/sources/jumpstartlab/data', {identifier: "jumpstartlab"})
    final_count = Payload.count
    
    assert_equal 400, last_response.status
    assert_equal "Missing payload data", last_response.body
    assert_equal final_count, initial_count
  end

  def test_it_returns_error_for_already_received_request
    create_source("jumpstartlab")
    initial_count = Payload.count
    create_payload_post
    create_payload_post
    final_count = Payload.count

    assert_equal 403, last_response.status
    assert_equal "Already received payload", last_response.body
    assert_equal 1, final_count - initial_count
  end

  def test_it_returns_error_for_unregistered_source
    initial_count = Payload.count
    create_payload_post
    final_count = Payload.count

    assert_equal 403, last_response.status
    assert_equal "Unregistered source", last_response.body
    assert_equal final_count, initial_count
  end
end
