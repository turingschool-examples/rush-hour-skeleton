require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert Url
  end

  def test_can_create_url_addresses
    url_address = {address: "http://jumpstartlab.com"}
    url = Url.create(url_address)

    assert_equal "http://jumpstartlab.com", url.address
    assert_equal 1, url.id
  end

  def create_three_payloads
    payload1 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
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
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
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
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com/blog").id,
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

  def test_can_return_specific_url_max_response_time
    pr1, pr2, pr3 = create_three_payloads
    url = Url.find(1)
    assert_equal 40, url.max_response_time
  end

  def test_can_return_specific_url_min_response_time
    pr1, pr2, pr3 = create_three_payloads
    url = Url.find(1)
    assert_equal 30, url.min_response_time
  end

  def test_returns_all_response_times_from_longest_to_shortest_for_specific_url
    pr1, pr2, pr3 = create_three_payloads
    url = Url.find(1)
    expected = [40, 30]
    assert_equal expected, url.all_response_times
  end

  def test_can_return_average_response_for_specific_url
    skip

    assert_equal expected, url.url_average_response_times(url)
  end

  def test_returns_http_verbs_for_specific_url
    skip

    assert_equal expected, url.url_http_verbs(url)
  end

  def test_returns_three_most_popular_referrers_for_specific_url
    skip

    assert_equal expected, url.url_top_three_referrers(url)
  end

  def test_returns_three_most_popular_user_agents_for_specific_url
    skip

    assert_equal expected, url.url_top_three_user_agents(url)
  end
end
