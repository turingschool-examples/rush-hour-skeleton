require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert PayloadRequest
    assert Client
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

end
