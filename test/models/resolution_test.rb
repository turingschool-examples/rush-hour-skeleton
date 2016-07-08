require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def payload
    '{"url":"http://jumpstartlab.com/blog",
    "requestedAt":"2013-02-16 21:38:28 -0700",
    "respondedIn":37,
    "referredBy":"http://jumpstartlab.com",
    "requestType":"GET",
    "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth":"1920",
    "resolutionHeight":"1280",
    "ip":"63.29.38.211"}'
  end

  def parsed_payload
    JSON.parse(payload)
  end

  def test_it_returns_values
    parsed_payload["resolutionWidth"] => "1920"
    parsed_payload["resolutionHeight"] => "1280"
  end

  def test_that_it_creates_a_resolution_height_row
    res = Resolution.new(height: "600", width: "800")
    assert res.valid?
  end

  def test_that_it_fails_when_only_a_resolution_width_is_provided
    res = Resolution.new(width: "800")
    refute res.valid?
    assert res.invalid?
  end

  def test_that_it_fails_when_only_a_resolution_height_is_provided
    res = Resolution.new(height: "600")
    refute res.valid?
    assert res.invalid?
  end

  def test_there_is_a_relationship_with_payload_requests
    pr = PayloadRequest.new(requested_at: "2013-02-16 21:38:28 -0700",
    responded_in: 37, url_id: 1, referral_id: 1, request_type_id: 1,
    user_agent_device_id: 1, resolution_id: 1, ip_id: 1)
    res = Resolution.new(height: "600", width: "800")

    assert pr.respond_to?(:resolution)
  end

end
