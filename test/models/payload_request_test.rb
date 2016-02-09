require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_payload_has_the_attributes
    payload_request = PayloadRequest.new

    assert_respond_to payload_request, :requestedAt
    assert_respond_to payload_request, :respondedIn
    assert_respond_to payload_request, :resolution_id
    assert_respond_to payload_request, :referrer_id
    assert_respond_to payload_request, :url_request_id
    assert_respond_to payload_request, :user_data_id
  end

  def test_attributes_must_be_present_when_saving
    payload_request = PayloadRequest.new

    payload_request.save

    assert_equal 0, PayloadRequest.all.count
  end

  def test_payload_request_has_attribute_values
    p = PayloadRequest.new(respondedIn: payload[:respondedIn],
                           requestedAt: payload[:requestedAt])

    assert_equal "2013-02-16 21:38:28 -0700", p.requestedAt
    assert_equal 37, p.respondedIn
  end

  def test_creates_a_relationship_with_referrer
    r = Referrer.create(referredBy: payload[:referredBy])

    p = PayloadRequest.create(requestedAt: payload[:requestedAt],
                           respondedIn: payload[:respondedIn])

    r.payload_requests << p

    assert_equal r.id, p.referrer_id
  end

end
