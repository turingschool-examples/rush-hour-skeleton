require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_payload_has_the_attributes
    payload_request = PayloadRequest.new

    assert_respond_to payload_request, :url
    assert_respond_to payload_request, :requestedAt
    assert_respond_to payload_request, :respondedIn
    assert_respond_to payload_request, :referredBy
    assert_respond_to payload_request, :requestType
    assert_respond_to payload_request, :parameters
    assert_respond_to payload_request, :eventName
    assert_respond_to payload_request, :userAgent
    assert_respond_to payload_request, :resolutionWidth
    assert_respond_to payload_request, :resolutionHeight
    assert_respond_to payload_request, :ip
  end

  def test_attributes_must_be_present_when_saving
    payload_request = PayloadRequest.new
    
    payload_request.save

    assert_equal 0, PayloadRequest.all.count
  end
end
