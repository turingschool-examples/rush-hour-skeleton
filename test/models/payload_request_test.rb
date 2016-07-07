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
 #
 # def test_min_response_time_for_all_requests
 #   create_faker_payload(2)
 #
 #   assert_equal 0, PayloadRequest.minimum(:responded_in)
 # end
 #
 # def test_most_frequent_request_type
 #   create_faker_payload(10)
 #
 #   assert_equal "GET", RequestType.most_frequent_request
 # end
 #
 # def test_return_all_verbs_for_request_type
 #   create_faker_payload(10)
 #
 #   assert_equal 0, RequestType.all_verbs
 # end
 #
 # def test_most_frequest_to_least_for_url
 #   create_faker_payload(10)
 #
 #   most = Url.most_frequent
 #   least = Url.least_frequent
 #
 #   assert_equal most, Url.most_to_least.first
 #   assert_equal least, Url.most_to_least.last
 # end
 #
 # def test_web_browser_breakdown_for_software_agent
 #   create_faker_payload(10)
 #
 #   assert_equal 0, SoftwareAgent.all(:browser)
 # end
 #
 # def test_os_breakdown_for_software_agent
 #   create_faker_payload(10)
 #
 #   assert_equal 0, SoftwareAgent.all(:os)
 # end
 #
 # def test_resolution_breakdown_for_resolution
 #   create_faker_payload(10)
 #   #for each do ("#{:width} x #{:height}")
 #
 #   assert_equal 0, Resolution.all_resolutions


end
