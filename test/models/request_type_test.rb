require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert RequestType
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
      user_system_id:    UserSystem.find_or_create_by(browser_type: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
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
      user_system_id:    UserSystem.find_or_create_by(browser_type: "Mozilla/5.0 (Linux; Android 5.1.1; Nexus 5 Build/LMY48B; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/43.0.2357.65 Mobile Safari/537").id,
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
      user_system_id:    UserSystem.find_or_create_by(browser_type: "Mozilla/5.0 (Linux; Android 4.4; Nexus 5 Build/_BuildID_) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/30.0.0.0 Mobile Safari/537.36").id,
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


  # List of all HTTP verbs used
  def test_finds_all_http_verbs_used
    pr1, pr2, pr3 = create_three_payloads

    assert_equal ["GET", "POST", "PUT"], RequestType.all_http_verbs_used
  end

end
