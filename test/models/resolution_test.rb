require_relative "../test_helper"

class ResolutionTest < Minitest::Test
  include TestHelpers
  def test_validations_work
    resolution = Resolution.create({
        resolution_width: "Lucy's BADDDDDD boys",
        resolution_height: "idjkjdf"})
    assert resolution.valid?
  end

  def test_empty_string_is_invalid
    resolution = Resolution.create({
        resolution_width: "",
        resolution_height: ""})
    assert resolution.invalid?
  end

  def test_nil_is_invalid
    resolution = Resolution.create({
        resolution_width: nil,
        resolution_height: nil})
    assert resolution.invalid?
  end


  def test_no_info_is_invalid
    resolution = Resolution.create
    assert resolution.invalid?
  end

  def test_it_has_relationship_with_payload_request
    r = Resolution.new
    assert_respond_to(r, :payload_requests)
  end

  def test_it_returns_all_screen_resolutions
    p1 = '{
      "url":"'"http://jumpstartlab.com/"'",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{1 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{1}"'",
      "requestType":"GET",
      "parameters": [],
      "eventName":"login",
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
      "eventName":"search",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"192",
      "resolutionHeight":"128",
      "ip":"'"63.29.38.21#{2}"'"
    }'

    p3 =  '{
      "url":"http://google.com/",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{3 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{3}"'",
      "requestType":"POST",
      "parameters": [],
      "eventName":"search",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"19",
      "resolutionHeight":"12",
      "ip":"'"63.29.38.21#{3}"'"
    }'

    payloads = [p1, p2, p3]
    payloads.each {|payload| PayloadParser.new(payload)}
    r1 = ["1920", "1280"]
    r2 =[ "192", "128"]
    r3 = ["19", "12"]
    r = [r1, r2, r3]
    assert_equal r, Resolution.all_widths_by_heights
  end
end
