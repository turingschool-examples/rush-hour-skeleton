require './test/test_helper'

class Iteration0Test < Minitest::Test

  def test_payload_request_exists
    assert PayloadRequest.new
  end

  def test_payload_request_has_correct_attributes
    create_payload_request

    payload = PayloadRequest.first

    assert_respond_to payload, :url
    assert_respond_to payload, :requestedAt
    assert_respond_to payload, :respondedIn
    assert_respond_to payload, :referredBy
    assert_respond_to payload, :requestType
    assert_respond_to payload, :eventName
    assert_respond_to payload, :userAgent
    assert_respond_to payload, :resolutionWidth
    assert_respond_to payload, :resolutionHeight
    assert_respond_to payload, :ip
  end

  def test_presence_of_attributes
    payload = {
                "url":"http://jumpstartlab.com/blog",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":37,
                "referredBy":"http://jumpstartlab.com",
                "requestType":"GET",
                "parameters":[],
                "eventName": "socialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }

    temp_payload.each_pair do |key, value|
      temp_payload = payload

      temp_payload.delete(key)

      refute PayloadRequest.create(temp_payload)
    end
  end
end
