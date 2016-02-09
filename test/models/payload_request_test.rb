require_relative "../test_helper"

class PayloadRequestTest < Minitest::Test
  include TestHelpers
  def test_all_attributes_exist
    pr = PayloadRequest.new
    assert_respond_to pr, :url
    assert_respond_to pr, :requestedAt
    assert_respond_to pr, :respondedIn
    assert_respond_to pr, :referredBy
    assert_respond_to pr, :requestType
    assert_respond_to pr, :parameters
    assert_respond_to pr, :eventName
    assert_respond_to pr, :userAgent
    assert_respond_to pr, :resolutionWidth
    assert_respond_to pr, :resolutionHeight
    assert_respond_to pr, :ip
  end

  def test_can_add_a_payload_request_to_database
    PayloadRequest.create ({"url":"http://jumpstartlab.com/blog",
    "requestedAt":"2013-02-16 21:38:28 -0700",
    "respondedIn":37,
    "referredBy":"http://jumpstartlab.com",
    "requestType":"GET",
    "parameters": [],
    "eventName": "socialLogin",
    "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth":"1920",
    "resolutionHeight":"1280",
    "ip":"63.29.38.211"})

    pr = PayloadRequest.all.first
    assert_equal 1, PayloadRequest.all.count
    assert_equal "GET", pr.requestType
  end

  def test_parameters_has_empty_array_loaded_by_default
    pr = PayloadRequest.new()
    assert_equal [], pr.parameters

    payload = example_payload
    payload.delete(:parameters)
    assert_nil payload[:parameters]
    pr = PayloadRequest.new(payload)
    assert_equal [], pr.parameters
  end

  def test_will_not_create_payload_request_without_all_params
    example_payload.keys.each do |key|
      unless key == :parameters
        payload = example_payload
        payload.delete(key)
        PayloadRequest.create(payload)
        assert_equal 0, PayloadRequest.all.count
      end
    end
  end

  def test_will_not_create_payload_request_when_request_details_are_empty
    example_payload.each do |key,value|
      if value.class == String
        payload = example_payload
        payload[key] = ""
        PayloadRequest.create(payload)
        assert_equal 0, PayloadRequest.all.count
      end
    end
  end

  def example_payload
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
  end

end
