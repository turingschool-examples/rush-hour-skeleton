require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_payload_parser
    assert_equal "http://jumpstartlab.com/blog", payload_parser[:url]
    assert_equal "2013-02-16 21:38:28 -0700", payload_parser[:requested_at]
    assert_equal 37, payload_parser[:responded_in]
    assert_equal "http://jumpstartlab.com", payload_parser[:referral]
    assert_equal "GET", payload_parser[:request_type]
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", payload_parser[:software_agent]
    assert_equal "1920", payload_parser[:resolution_width]
    assert_equal "1280", payload_parser[:resolution_height]
    assert_equal "63.29.38.211", payload_parser[:ip]
  end

  def test_it_cannot_create_payload_request_without_requested_at
    payload = PayloadRequest.new(
    responded_in: payload_parser[:responded_in],
    url_id: create_url.id,
    ip_id: create_ip.id,
    request_type_id: create_request_type.id,
    software_agent_id: create_software_agent.id,
    resolution_id: create_resolution.id
    )

    refute payload.valid?
  end

  def test_it_cannot_create_payload_request_without_responded_in
    payload = PayloadRequest.new(
    requested_at: payload_parser[:requested_at],
    url_id: create_url.id,
    ip_id: create_ip.id,
    request_type_id: create_request_type.id,
    software_agent_id: create_software_agent.id,
    resolution_id: create_resolution.id
    )

    refute payload.valid?
  end

  def test_it_cannot_create_payload_request_without_url_id
    payload = PayloadRequest.new(
    requested_at: payload_parser[:requested_at],
    responded_in: payload_parser[:responded_in],
    ip_id: create_ip.id,
    request_type_id: create_request_type.id,
    software_agent_id: create_software_agent.id,
    resolution_id: create_resolution.id
    )

    refute payload.valid?
  end

  def test_it_cannot_create_payload_request_without_ip_id
    payload = PayloadRequest.new(
    requested_at: payload_parser[:requested_at],
    responded_in: payload_parser[:responded_in],
    url_id: create_url.id,
    request_type_id: create_request_type.id,
    software_agent_id: create_software_agent.id,
    resolution_id: create_resolution.id
    )

    refute payload.valid?
  end

  def test_it_cannot_create_payload_request_without_request_type_id
    payload = PayloadRequest.new(
    requested_at: payload_parser[:requested_at],
    responded_in: payload_parser[:responded_in],
    url_id: create_url.id,
    ip_id: create_ip.id,
    software_agent_id: create_software_agent.id,
    resolution_id: create_resolution.id
    )

    refute payload.valid?
  end

  def test_it_cannot_create_payload_request_without_software_agent_id
    payload = PayloadRequest.new(
    requested_at: payload_parser[:requested_at],
    responded_in: payload_parser[:responded_in],
    url_id: create_url.id,
    ip_id: create_ip.id,
    request_type_id: create_request_type.id,
    resolution_id: create_resolution.id
    )

    refute payload.valid?
  end

  def test_it_cannot_create_payload_request_without_resolution_id
    payload = PayloadRequest.new(
    requested_at: payload_parser[:requested_at],
    responded_in: payload_parser[:responded_in],
    url_id: create_url.id,
    ip_id: create_ip.id,
    request_type_id: create_request_type.id,
    software_agent_id: create_software_agent.id
    )

    refute payload.valid?
  end

  def test_can_create_faker_payloads
    create_faker_payloads(5)
    assert_equal 5, PayloadRequest.count
  end


end
