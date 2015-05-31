require_relative '../test_helper'

class PayloadTest < Minitest::Test
  def test_valid_attributes
    payload = Payload.create({:url=>                "http://jumpstartlab.com/blog",
                              :requested_at=>       "2013-02-16 21:38:28 -0700",
                              :responded_in=>       37,
                              # :referred_by=>        "http://jumpstartlab.com",
                              # :request_type=>       "GET",
                              :event_name=>         "socialLogin",
                              :user_agent=>         "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                              :resolution_width=>   "1920",
                              :resolution_height=>  "1280",
                              # :ip=>                 "63.29.38.211"
                              })
    assert_equal "http://jumpstartlab.com/blog", payload.url
    assert_equal "2013-02-16 21:38:28 -0700", payload.requested_at
    assert_equal 37, payload.responded_in
    # assert_equal "http://jumpstartlab.com", payload.referred_by
    # assert_equal "GET", payload.request_type --
    assert_equal "socialLogin", payload.event_name
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", payload.user_agent
    assert_equal "1920", payload.resolution_width
    assert_equal "1280", payload.resolution_height
    # assert_equal "63.29.38.211", payload.ip --
  end
end
