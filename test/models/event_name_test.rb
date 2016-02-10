require_relative '../test_helper'

class EventNameTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert EventName
  end

  def test_can_create_event_id
    payload1 = {
      url_id:             Url.create(address: "http://jumpstartlab.com/tutorials").id,
      requested_at:       "2013-02-17 20: 44: 28 -0700",
      responded_in:       40,
      referrer_url_id:    ReferrerUrl.create(url_address: "http://jumpstartlab.com").id,
      request_type_id:    RequestType.create(verb: "GET").id,
      parameters:         [],
      event_name_id:      EventName.create(event_name: "socialLogin").id,
      user_agent_id:      UserAgent.create(browser: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML,
       like Gecko) Chrome/24.0.1309.0 Safari/537.17").id,
      resolution_id:      Resolution.create(
                            width: "1920",
                            height: "1280").id,
      ip_id:              Ip.create(ip_address: "63.29.38.211").id
    }

    pr = PayloadRequest.create(payload1)

    assert_equal "socialLogin", EventName.find(1).event_name
  end
end
