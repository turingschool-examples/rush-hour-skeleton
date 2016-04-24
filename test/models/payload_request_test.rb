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
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Firefox",
                          operating_system: "Mac OSX").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "960",
                          height: "1400").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id
    }

    payload2 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com/tutorials").id,
      requested_at:     "2014-02-16 21:38:28 -0700",
      responded_in:     40,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "POST").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "signOut").id,
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Safari",
                          operating_system: "Windows").id,
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
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Firefox",
                          operating_system: "Mac OSX").id,
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
    assert_equal 1, pr.user_system_id
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
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Chrome",
                          operating_system: "Mac OSX").id,
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

  # List of URLs listed form most requested to least requested
  def test_sort_urls_by_request_freqency_most_to_least
    payload4 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com/tutorials").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "GET").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Chrome",
                          operating_system: "Mac OSX").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id
    }

    pl4 = PayloadRequest.create(payload4)
    pr1, pr2, pr3 = create_three_payloads

    assert_equal ["http://jumpstartlab.com/tutorials", "http://jumpstartlab.com", "http://jumpstartlab.com/blog"], PayloadRequest.sort_urls_by_request_freqency
  end

  # Web browser breakdown across all requests(userSystem)
  def test_list_browser_breakdown_for_all_requests
    pr1, pr2, pr3 = create_three_payloads

    assert_equal ["Firefox", "Safari"], PayloadRequest.browser_breakdown.sort
  end

  # OS breakdown across all requests(userSystem)
  def test_os_browser_breakdown_across_all_requests
    pr1, pr2, pr3 = create_three_payloads
    expected = ["Mac OSX", "Windows"]
    assert_equal expected, PayloadRequest.os_breakdown.sort
  end

  # Screen Resolutions across all requests (resolutionWidth x resolutionHeight)
  def test_list_screen_resolutions_across_all_request
    pr1, pr2, pr3 = create_three_payloads
    expected = [["960", "1400"], ["1920", "1280"]]
    assert_equal expected, PayloadRequest.screen_resolutions
  end

  # Events listed from most received to least.(When no events have been defined display a message that states no events have been defined)
  def test_sort_events_most_received_to_least
    pr1, pr2, pr3 = create_three_payloads
    expected = ["socialLogin", "signOut"]
    assert_equal expected, PayloadRequest.sort_events_most_received_to_least
  end

  def test_returns_message_if_no_event_have_been_defined
    expected = "No events have been defined"
    assert_equal expected, PayloadRequest.sort_events_most_received_to_least
  end

  def test_returns_message_if_event_name_is_missing
    payload = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "GET").id,
      parameters:       [],
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Firefox",
                          operating_system: "Mac OSX").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id
    }
    PayloadRequest.create(payload)

    expected = "No events have been defined"
    assert_equal expected, PayloadRequest.sort_events_most_received_to_least
  end
end
