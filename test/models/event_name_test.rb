require_relative '../test_helper'

class EventNameTest < Minitest::Test
  include TestHelpers

  def test_class_exists
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
      user_system_id:   UserSystem.find_or_create_by(browser_type: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
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
      user_system_id:    UserSystem.find_or_create_by(browser_type: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
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
      user_system_id:    UserSystem.find_or_create_by(browser_type: "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A543 Safari/419.3").id,

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

  def test_can_create_event_id_through_payload_request
    payload1 = {
      url_id:             Url.create(address: "http://jumpstartlab.com/tutorials").id,
      requested_at:       "2013-02-17 20: 44: 28 -0700",
      responded_in:       40,
      referrer_url_id:    ReferrerUrl.create(url_address: "http://jumpstartlab.com").id,
      request_type_id:    RequestType.create(verb: "GET").id,
      parameters:         [],
      event_name_id:      EventName.create(event_name: "socialLogin").id,
      user_system_id:     UserSystem.create(browser_type: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML,
       like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
      resolution_id:      Resolution.create(
                            width: "1920",
                            height: "1280").id,
      ip_id:              Ip.create(ip_address: "63.29.38.211").id
    }

    pr = PayloadRequest.create(payload1)

    assert_equal "socialLogin", EventName.find(1).event_name
    assert_equal 1, pr.event_name_id
  end

  def test_can_create_event_names
    name = {event_name: "socialLogin"}
    en = EventName.create(name)

    assert_equal "socialLogin", en.event_name
    assert_equal 1, en.id
  end
end
