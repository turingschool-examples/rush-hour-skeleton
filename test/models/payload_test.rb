require_relative '../test_helper'

class PayloadTest < Minitest::Test
  def setup
    @payload = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName": "socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
    }
  end

  def test_responds_to_other_methods
    e = Payload.create(@payload)
    methods = [:event_names, :ips, :refers, :resolutions, :urls, :user_environments]

    methods.each do |method|
      assert e.respond_to? method
    end
  end

  def test_brings_in_correct_data
    e = Payload.create(@payload)

    assert_equal "63.29.38.211", e.ip
  end

  def test_wont_validate_incorrect_data
    e = Payload.create
    assert_nil e.id

    d = Payload.new ip: nil
    assert_nil d.ip
  end
end
