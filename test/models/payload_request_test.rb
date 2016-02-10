require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_payload_request_assigned_correctly
    payload = {
      "url": "http://jumpstartlab.com/blog",
      "requestedAt": "2013-02-16 21:38:28 -0700",
      "respondedIn": 37,
      "referredBy": "http://jumpstartlab.com",
      "requestType": "GET",
      "parameters": [],
      "eventName": "socialLogin",
      "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth": "1920",
      "resolutionHeight": "1280",
      "ip": "63.29.38.211"
    }
    pr = PayloadRequest.create(payload)

    assert_equal "2013-02-16 21:38:28 -0700", pr.requestedAt
  end

  def test_payload_cannot_be_created_without_ip_address
    payload = {
      "url": "http://jumpstartlab.com/blog",
      "requestedAt": "2013-02-16 21:38:28 -0700",
      "respondedIn": 37,
      "referredBy": "http://jumpstartlab.com",
      "requestType": "GET",
      "parameters": [],
      "eventName": "socialLogin",
      "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth": "1920",
      "resolutionHeight": "1280",
    }
    pr = PayloadRequest.new(payload)

    refute pr.valid?
  end

  def create_three_payloads
    payload1 = {"url": "http: //jumpstartlab.com/blog",
      "requestedAt": "2013-02-16 21: 38: 28 -0700",
      "respondedIn": 30,
      "referredBy": "http: //jumpstartlab.com",
      "requestType": "GET",
      "parameters": [],
      "eventName":  "socialLogin",
      "userAgent": "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML,
       like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth": "1920",
      "resolutionHeight": "1280",
      "ip": "63.29.38.211"}

    payload2 = {"url": "http: //jumpstartlab.com/tutorials",
      "requestedAt": "2013-02-17 20: 44: 28 -0700",
      "respondedIn": 40,
      "referredBy": "http: //jumpstartlab.com",
      "requestType": "GET",
      "parameters": [],
      "eventName":  "socialLogin",
      "userAgent": "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML,
       like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth": "1920",
      "resolutionHeight": "1280",
      "ip": "63.29.38.211"}

    payload3 = {"url": "http: //jumpstartlab.com/about",
      "requestedAt": "2013-02-17 10: 34: 18 -0700",
      "respondedIn": 50,
      "referredBy": "http: //google.com",
      "requestType": "GET",
      "parameters": [],
      "eventName":  "socialLogin",
      "userAgent": "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML,
       like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth": "1920",
      "resolutionHeight": "1280",
      "ip": "63.29.38.211"}

    pr1 = PayloadRequest.create(payload1)
    pr2 = PayloadRequest.create(payload2)
    pr3 = PayloadRequest.create(payload3)
    [pr1, pr2, pr3]
  end

  def test_calculated_average_response_time
    pr1, pr2, pr3 = create_three_payloads

    assert_equal 40, PayloadRequest.average_response_time
  end
end
