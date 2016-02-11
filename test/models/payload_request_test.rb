require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert PayloadRequest
    assert EventName
  end

  def create_three_payloads
    payload1 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com/blog").id,
      requested_at:     "2013-02-16 21:38:28 -0700",
      responded_in:     30,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "GET").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_agent_id:    UserAgent.find_or_create_by(browser: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML,
       like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id
    }

    payload2 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com/tutorials").id,
      requested_at:     "2014-02-16 21:38:28 -0700",
      responded_in:     40,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "POST").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_agent_id:    UserAgent.find_or_create_by(browser: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML,
       like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id
    }

    payload3 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "GET").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_agent_id:    UserAgent.find_or_create_by(browser: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML,
       like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id
    }

    pr1 = PayloadRequest.create(payload1)
    pr2 = PayloadRequest.create(payload2)
    pr3 = PayloadRequest.create(payload3)
    [pr1, pr2, pr3]
  end

  def test_payload_request_assigns_all_values_correctly
    pr = create_three_payloads[0]

    assert_equal 1, pr.url_id
    assert_equal "2013-02-16 21:38:28 -0700", pr.requested_at
    assert_equal 30, pr.responded_in
    assert_equal 1, pr.referrer_url_id
    assert_equal 1, pr.request_type_id
    assert_equal "[]", pr.parameters
    assert_equal 1, pr.event_name_id
    assert_equal 1, pr.user_agent_id
    assert_equal 1, pr.resolution_id
    assert_equal 1, pr.ip_id
  end

  def test_payload_cannot_be_created_without_ip_address
    payload = {
      url_id:           Url.create(address: "http://jumpstartlab.com/tutorials").id,
      requested_at:     "2013-02-16 21:38:28 -0700",
      responded_in:     37,
      referrer_url_id:  ReferrerUrl.create(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.create(verb: "GET").id,
      parameters:       [],
      event_name_id:    EventName.create(event_name: "socialLogin").id,
      user_agent_id:    UserAgent.create(browser: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML,
       like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
      resolution_id:    Resolution.create(
                          width: "1920",
                          height: "1280").id
    }

    pr = PayloadRequest.new(payload)

    refute pr.valid?
  end

  def test_calculates_average_response_time
    pr1, pr2, pr3 = create_three_payloads

    assert_equal 40, PayloadRequest.average_response_time
  end

  # Max Response time across all requests
  def test_calculates_max_response_time
    pr1, pr2, pr3 = create_three_payloads

    assert_equal 50, PayloadRequest.max_response_time
  end

  # Min Response time across all requests
  def test_calculates_min_response_time
    pr1, pr2, pr3 = create_three_payloads

    assert_equal 30, PayloadRequest.min_response_time
  end

  # Most frequent request type
  def test_finds_most_frequent_request_type
    pr1, pr2, pr3 = create_three_payloads
    assert_equal "GET", PayloadRequest.most_frequent_request_type
  end

  # List of all HTTP verbs used
  def test_finds_all_http_verbs_used
    pr1, pr2, pr3 = create_three_payloads

    assert_equal ["GET","POST"], PayloadRequest.all_http_verbs_used
  end

  # List of URLs listed form most requested to least requested
  def test_sort_urls_by_request_freqency_most_to_least

  end

  # Web browser breakdown across all requests(userAgent)
  def test_list_browser_breakdown_for_all_requests

  end

  # OS breakdown across all requests(userAgent)
  def test_os_browser_breakdown_across_all_requests

  end

  # Screen Resolutions across all requests (resolutionWidth x resolutionHeight)
  def test_list_screen_resolutions_across_all_request

  end

  # Events listed from most received to least.(When no events have been defined display a message that states no events have been defined)
  def test_sort_events_most_recieved_to_least

  end



end
