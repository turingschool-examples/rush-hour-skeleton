require_relative "../test_helper"

class SoftwareAgentTest < Minitest::Test
  include TestHelpers
  def test_validations_work
    user = SoftwareAgent.create({
        os: "Lucy's BADDDDDD boys",
        browser: "idjkjdf"})
    assert user.valid?
  end

  def test_empty_string_is_invalid
    user = SoftwareAgent.create({
        os: "",
        browser: ""})
    assert user.invalid?
  end

  def test_nil_is_invalid
    user = SoftwareAgent.create({
        os: nil,
        browser: nil})
    assert user.invalid?
  end


  def test_no_info_is_invalid
    user = SoftwareAgent.create
    assert user.invalid?
  end


  def test_it_has_relationship_with_payload_request
    u = SoftwareAgent.new
    assert_respond_to(u, :payload_requests)
  end

  def test_it_outputs_all_browsers
    p1 = '{
      "url":"'"http://jumpstartlab.com/"'",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{1 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{1}"'",
      "requestType":"GET",
      "parameters": [],
      "eventName":"'"socialLogin#{1}"'",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{1}"'"
    }'

    p2 =  '{
      "url":"http://jumpstartlab.com/",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{2 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{2}"'",
      "requestType":"GET",
      "parameters": [],
      "eventName":"'"socialLogin#{2}"'",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Safari /24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{2}"'"
    }'

    [p1,p2].each {|payload| PayloadParser.new(payload)}
    assert_equal ["Chrome", "Safari"], SoftwareAgent.all_browsers
  end

  def test_it_outputs_all_operating_systems
    p1 = '{
      "url":"'"http://jumpstartlab.com/"'",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{1 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{1}"'",
      "requestType":"GET",
      "parameters": [],
      "eventName":"'"socialLogin#{1}"'",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{1}"'"
    }'

    p2 =  '{
      "url":"http://jumpstartlab.com/",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{2 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{2}"'",
      "requestType":"GET",
      "parameters": [],
      "eventName":"'"socialLogin#{2}"'",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_4_1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{2}"'"
    }'

    [p1,p2].each {|payload| PayloadParser.new(payload)}
    assert_equal ["OS X 10.8.2", "OS X 10.4.1"], SoftwareAgent.all_os
  end
end
