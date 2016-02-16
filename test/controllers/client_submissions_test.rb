require_relative '../test_helper'

class ClientRegistrationTest < Minitest::Test
  include TestHelpers

  def payload
    {
      "payload"=>
        "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
    }
  end

  def test_the_client_successfully_posts_data
    Client.create(identifier: "google", root_url: "http://google.com")
    post '/sources/google/data', payload
    assert_equal 1, PayloadRequest.count
    assert_equal 200, last_response.status
    assert_equal "Payload Received", last_response.body

    payload = PayloadRequest.last

    assert_equal "http://jumpstartlab.com/blog", payload.url.address
    assert_equal "2013-02-16 21:38:28 -0700", payload.requested_at
    assert_equal  37, payload.responded_in
    assert_equal "http://jumpstartlab.com", payload.referrer_url.url_address
    assert_equal "GET", payload.request_type.verb
    assert_equal "socialLogin", payload.event_name.event_name #change
    assert_equal "Chrome", payload.user_system.browser_type
    assert_equal "Macintosh", payload.user_system.operating_system
    assert_equal "1920", payload.resolution.width
    assert_equal "1280", payload.resolution.height
    assert_equal "63.29.38.211", payload.ip.ip_address
    assert_equal "google", payload.client.identifier
  end

  def test_missing_payload_error_response
    Client.create(identifier: "google", root_url: "http://google.com")
    post '/sources/google/data', payload

    assert_equal 1, PayloadRequest.count
    assert_equal 200, last_response.status
    assert_equal "Payload Received", last_response.body

    post '/sources/google/data', payload
    assert_equal 1, PayloadRequest.count
    assert_equal 403, last_response.status
    assert_equal "Error, Payload Already Received", last_response.body
  end

  def test_returns_403_when_payload_request_has_already_been_received
    Client.create(identifier: "google", root_url: "http://google.com")
    post '/sources/google/data', { :payload => {}.to_json }

    assert_equal 0, PayloadRequest.count
    assert_equal 400, last_response.status
    assert_equal "Missing Payload", last_response.body
  end

  def test_returns_403_if_client_is_not_registered
    post '/sources/google/data', payload

    assert_equal 0, PayloadRequest.count
    assert_equal 403, last_response.status
    assert_equal "Client is not registered", last_response.body
  end
end
