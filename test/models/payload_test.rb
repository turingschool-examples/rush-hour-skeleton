require_relative '../test_helper'

class PayloadTest < Minitest::Test
  def test_valid_attributes
    payload = Payload.create({:url=>                "http://#{identifier}.com/blog",
                              :requested_at=>       "2013-02-16 21:38:28 -0700",
                              :responded_in=>       37,
                              :referred_by=>        "http://#{identifier}.com",
                              :request_type=>       "GET",
                              :event_name=>         "socialLogin",
                              :user_agent=>         "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                              :resolution_width=>   " 1920",
                              :resolution_height=>  "1280",
                              :ip=>                 "63.29.38.211"
                              })

    assert_equal "2013-02-16 21:38:28 -0700", payload.requested_at
  end

  def test_valid_uniqueness_of_requested_at
    payload_one = Payload.create({requested_at: "2013-02-16 21:38:28 -0700"})
    payload_two = Payload.create({requested_at: "2013-02-16 21:38:28 -0700"})

    assert payload_one.valid?
    refute payload_two.valid?
    assert_equal 1, Payload.count
  end

  def test_invalid_without_requested_at
    payload = Payload.create

    refute payload.valid?
  end
end
