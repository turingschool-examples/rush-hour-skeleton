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

  def test_average_response_time_for_all_requests
    create_faker_payloads(2)

    sum_response_time = PayloadRequest.sum(:responded_in)
    average_time = (sum_response_time / PayloadRequest.count)
    average_time = average_time

    assert_equal 2, PayloadRequest.count
    assert_equal average_time, PayloadRequest.average(:responded_in).to_i
  end

  def test_max_response_time_for_all_requests
    create_faker_payloads(2)

    max = PayloadRequest.all.pluck(:responded_in).max

    assert_equal max, PayloadRequest.maximum(:responded_in)
  end

  def test_min_response_time_for_all_requests
    create_faker_payloads(2)

    min = PayloadRequest.all.pluck(:responded_in).min

    assert_equal min, PayloadRequest.minimum(:responded_in)
  end

  def test_most_frequent_request_type
    three_relationship_requests

    assert_equal "POST", PayloadRequest.all.most_frequent_request_type
  end

  def test_return_all_verbs_for_request_type
    three_relationship_requests

    assert_equal ["GET","POST"], RequestType.all_verbs_used
  end

  def test_most_frequest_to_least_for_url
    three_relationship_requests

    assert_equal ["http://example.com/jasonisnice","http://example.com/mattisnice"], PayloadRequest.url_frequency
  end

  def test_max_response_time_for_all_requests
    three_relationship_requests

    assert_equal 42, PayloadRequest.max_response_time
  end

  def test_max_response_time_for_a_url
    three_relationship_requests
    url = 'http://example.com/jasonisnice'

    assert_equal 37, PayloadRequest.all.max_response_time_by_url(url)

    url = 'http://example.com/mattisnice'

    assert_equal 42, PayloadRequest.all.max_response_time_by_url(url)
  end

  def test_min_response_time_for_a_url
    three_relationship_requests
    url = 'http://example.com/jasonisnice'

    assert_equal 28, PayloadRequest.all.min_response_time_by_url(url)

    url = 'http://example.com/mattisnice'

    assert_equal 42, PayloadRequest.all.min_response_time_by_url(url)
  end

end
