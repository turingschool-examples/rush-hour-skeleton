require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert PayloadRequest
    assert EventName
  end

  def test_payload_request_assigns_all_values_correctly
    pr = create_payload_1

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
      url_id:           Url.create(address: "http://www.jumpstartlab.com/tutorials").id,
      requested_at:     "2013-02-16 21:38:28 -0700",
      responded_in:     37,
      referrer_url_id:  ReferrerUrl.create(url_address: "http://www.jumpstartlab.com").id,
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

  def test_payload_is_not_created_if_not_unique
    pr1 = create_payload_1
    pr2 = create_payload_1

    refute pr2.valid?
  end

  def test_calculates_average_response_time
    create_payload_1
    create_payload_2
    create_payload_3

    assert_equal 40, PayloadRequest.average_response_time
  end

  # Max Response time across all requests
  def test_calculates_max_response_time
    create_payload_1
    create_payload_2
    create_payload_3

    assert_equal 50, PayloadRequest.max_response_time
  end

  # Min Response time across all requests
  def test_calculates_min_response_time
    create_payload_1
    create_payload_2
    create_payload_3

    assert_equal 30, PayloadRequest.min_response_time
  end

  # Most frequent request type
  def test_finds_most_frequent_request_type
    create_payload_1
    create_payload_2
    create_payload_3
    create_payload_4

    assert_equal "POST", PayloadRequest.most_frequent_request_type
  end

  # List of URLs listed form most requested to least requested
  def test_sort_urls_by_request_freqency_most_to_least
    create_payload_1
    create_payload_2
    create_payload_2
    create_payload_3
    create_payload_3
    create_payload_3

    assert_equal ["http://www.jumpstartlab.com", "http://www.jumpstartlab.com/tutorials", "http://www.jumpstartlab.com/blog"], PayloadRequest.sort_urls_by_request_freqency
  end

  # Events listed from most received to least.(When no events have been defined display a message that states no events have been defined)
  def test_sort_events_most_received_to_least
    create_payload_1
    create_payload_2
    create_payload_3

    expected = ["socialLogin", "signOut"]
    assert_equal expected, PayloadRequest.sort_events_most_received_to_least
  end

  def test_returns_message_if_no_event_have_been_defined
    expected = "No events have been defined"
    assert_equal expected, PayloadRequest.sort_events_most_received_to_least
  end

  def test_returns_message_if_event_name_is_missing
    payload = {
      url_id:           Url.find_or_create_by(address: "http://www.jumpstartlab.com").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://www.jumpstartlab.com").id,
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
