require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert PayloadRequest
    assert EventName
  end

  def create_three_payloads
    payload1 = {
      url_id:           Url.create(address: "http://jumpstartlab.com/blog").id,
      requested_at:     "2013-02-16 21:38:28 -0700",
      responded_in:     30,
      referrer_url_id:  ReferrerUrl.create(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.create(verb: "GET").id,
      parameters:       [],
      event_name_id:    EventName.create(event_name: "socialLogin").id,
      user_agent_id:    UserAgent.create(browser: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML,
       like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
      resolution_id:    Resolution.create(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.create(ip_address: "63.29.38.211").id
    }

    payload2 = {
      url_id:           Url.create(address: "http://jumpstartlab.com/tutorials").id,
      requested_at:     "2014-02-16 21:38:28 -0700",
      responded_in:     40,
      referrer_url_id:  ReferrerUrl.create(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.create(verb: "POST").id,
      parameters:       [],
      event_name_id:    EventName.create(event_name: "socialLogin").id,
      user_agent_id:    UserAgent.create(browser: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML,
       like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
      resolution_id:    Resolution.create(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.create(ip_address: "63.29.38.211").id
    }

    payload3 = {
      url_id:           Url.create(address: "http://jumpstartlab.com").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.create(url_address: "http://jumpstartlab.com").id,
      request_type_id:  RequestType.create(verb: "GET").id,
      parameters:       [],
      event_name_id:    EventName.create(event_name: "socialLogin").id,
      user_agent_id:    UserAgent.create(browser: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML,
       like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
      resolution_id:    Resolution.create(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.create(ip_address: "63.29.38.211").id
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

  def test_can_return_specific_url_max_response_time
    skip
    assert_equal expected, PayloadRequest.url_max_response_time(url)
  end

  def test_can_return_specific_url_min_response_time
    skip

    assert_equal expected, PayloadRequest.url_min_response_time(url)
  end

  def test_returns_all_response_times_from_longest_to_shortest_for_specific_url
    skip

    assert_equal expected, PayloadRequest.url_all_response_times(url)
  end

  def test_can_return_average_response_for_specific_url
    skip

    assert_equal expected, PayloadRequest.url_average_response_times(url)
  end

  def test_returns_http_verbs_for_specific_url
    skip

    assert_equal expected, PayloadRequest.url_http_verbs(url)
  end

  def test_returns_three_most_popular_referrers_for_specific_url
    skip

    assert_equal expected, PayloadRequest.url_top_three_referrers(url)
  end

  def test_returns_three_most_popular_user_agents_for_specific_url
    skip

    assert_equal expected, PayloadRequest.url_top_three_user_agents(url)
  end
end
