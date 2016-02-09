require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_payload_has_the_attributes
    payload_request = PayloadRequest.new

    assert_respond_to payload_request, :url
    assert_respond_to payload_request, :requested_at
    assert_respond_to payload_request, :requested_in
    assert_respond_to payload_request, :referred_by
    assert_respond_to payload_request, :request_type
    assert_respond_to payload_request, :parameters
    assert_respond_to payload_request, :event_name
    assert_respond_to payload_request, :user_agent
    assert_respond_to payload_request, :resolution_width
    assert_respond_to payload_request, :resolution_height
    assert_respond_to payload_request, :ip
  end
end
