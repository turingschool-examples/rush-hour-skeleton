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
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Chrome",
                          operating_system: "Mac OSX").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id
    }

    payload2 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
      requested_at:     "2014-02-16 21:38:28 -0700",
      responded_in:     40,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://google.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "POST").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Firefox",
                          operating_system: "Windows").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id
    }

    payload3 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com/blog").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://yahoo.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "PUT").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Safari",
                          operating_system: "iphone").id,
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
    pr1, pr2, pr3 = create_three_payloads
    url = Url.find(1)

    assert_equal 35, url.average_response_time
  end

  def test_returns_http_verbs_for_specific_url
    pr1, pr2, pr3 = create_three_payloads
    url = Url.find(1)

    assert_equal ["GET", "POST"], url.all_http_verbs.sort
  end

  def test_returns_three_most_popular_referrers_for_specific_url
    pr1, pr2, pr3 = create_three_payloads
    pr4, pr5, pr6 = create_three_payloads

    payload7 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://askjeeves.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "PUT").id,
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
    PayloadRequest.create(payload7)

    payload8 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://yahoo.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "PUT").id,
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
    PayloadRequest.create(payload8)
    PayloadRequest.create(payload8)

    expected = ["http://google.com", "http://jumpstartlab.com", "http://yahoo.com"]
    url = Url.find(1)
    assert_equal expected, url.top_three_referrers.sort
  end

  def test_returns_three_most_popular_user_systems_for_specific_url
    pr1, pr2, pr3 = create_three_payloads
    pr4, pr5, pr6 = create_three_payloads

    payload7 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://askjeeves.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "PUT").id,
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
    PayloadRequest.create(payload7)

    payload8 = {
      url_id:           Url.find_or_create_by(address: "http://jumpstartlab.com").id,
      requested_at:     "2015-02-16 21:38:28 -0700",
      responded_in:     50,
      referrer_url_id:  ReferrerUrl.find_or_create_by(url_address: "http://yahoo.com").id,
      request_type_id:  RequestType.find_or_create_by(verb: "PUT").id,
      parameters:       [],
      event_name_id:    EventName.find_or_create_by(event_name: "socialLogin").id,
      user_system_id:   UserSystem.find_or_create_by(
                          browser_type: "Fake",
                          operating_system: "Other").id,
      resolution_id:    Resolution.find_or_create_by(
                          width: "1920",
                          height: "1280").id,
      ip_id:            Ip.find_or_create_by(ip_address: "63.29.38.211").id
    }
    PayloadRequest.create(payload8)
    PayloadRequest.create(payload8)
    PayloadRequest.create(payload8)

    expected = [["Fake", "Other"], ["Firefox", "Windows"], ["Chrome", "Mac OSX"]]
    url = Url.find(1)

    assert_equal expected, url.top_three_user_systems
  end
end
