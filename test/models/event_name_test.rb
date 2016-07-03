require_relative "../test_helper"

class EventNameTest < Minitest::Test
  include TestHelpers
  def test_validations_work
    event = EventName.create({
        event_name: "Lucy's BADDDDDD boys"
      })
    assert event.valid?
  end

  def test_empty_string_is_invalid
    event = EventName.create({
        event_name: ""
      })
    assert event.invalid?
  end

  def test_nil_is_invalid
    event = EventName.create({
        event_name: nil
      })
    assert event.invalid?
  end


  def test_no_info_is_invalid
    event = EventName.create
    assert event.invalid?
  end

  def test_it_has_relationship_with_payload_request
    name = EventName.new
    assert_respond_to(name, :payload_requests)
  end

  def test_it_can_give_the_most_to_least_requested_urls
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
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
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
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{3}"'"
    }'

    p4 = '{
      "url":"'"http://jumpstartlab.com/"'",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{1 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{1}"'",
      "requestType":"GET",
      "parameters": [],
      "eventName":"search",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{1}"'"
    }'

    p5 =  '{
      "url":"http://facebook.com/",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{2 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{2}"'",
      "requestType":"GET",
      "parameters": [],
      "eventName":"'"socialLogin"'",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{2}"'"
    }'

    p6 =  '{
      "url":"http://facebook.com/",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{3 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{3}"'",
      "requestType":"POST",
      "parameters": [],
      "eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{3}"'"
    }'
    payloads = [p1, p2, p3, p4, p5, p6]
    payloads.each {|payload| PayloadParser.new(payload)}
    en1 = "login"
    en2 = "search"
    en3 = "socialLogin"
    en = [en2, en3, en1]
    assert_equal en, EventName.most_to_least_requested_event_names
  end
end
