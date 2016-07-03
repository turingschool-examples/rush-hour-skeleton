require_relative "../test_helper"

class RequestTypeTest < Minitest::Test
  include TestHelpers
  def test_validations_work
    request = RequestType.create({
        request_type: "Lucy's BADDDDDD boys"
      })
    assert request.valid?
  end

  def test_empty_string_is_invalid
    request = RequestType.create({
        request_type: ""
      })
    assert request.invalid?
  end

  def test_nil_is_invalid
    request = RequestType.create({
        request_type: nil
      })
    assert request.invalid?
  end

  def test_no_info_is_invalid
    request = RequestType.create
    assert request.invalid?
  end

  def test_it_has_relationship_with_payload_request
    r = RequestType.new
    assert_respond_to(r, :payload_requests)
  end

  def test_all_verbs
    payloads = create_payloads(1)
    payloads.each {|payload| PayloadParser.new(payload)}
    verb = RequestType.find(1).request_type
    assert_equal [verb], RequestType.all_verbs
  end

  def test_it_finds_most_frequent_request_type
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
      "url":"'"http://jumpstartlab.com/#{2}"'",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{2 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{2}"'",
      "requestType":"GET",
      "parameters": [],
      "eventName":"'"socialLogin#{2}"'",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{2}"'"
    }'

    p3 =  '{
      "url":"'"http://jumpstartlab.com/#{3}"'",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{3 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{3}"'",
      "requestType":"POST",
      "parameters": [],
      "eventName":"'"socialLogin#{3}"'",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{3}"'"
    }'
    payloads = [p1, p2, p3]
    payloads.each {|payload| PayloadParser.new(payload)}
    assert_equal "GET", RequestType.most_frequent_request_verbs
  end

  def test_it_returns_the_first_verb_when_there_is_a_tie_for_most_frequent_type

        p1 =  '{
          "url":"'"http://jumpstartlab.com/#{2}"'",
          "requestedAt":"'"#{Time.now}"'",
          "respondedIn":'"#{2 * 10}"',
          "referredBy":"'"http://jumpstartlab.com/#{2}"'",
          "requestType":"GET",
          "parameters": [],
          "eventName":"'"socialLogin#{2}"'",
          "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
          "resolutionWidth":"1920",
          "resolutionHeight":"1280",
          "ip":"'"63.29.38.21#{2}"'"
        }'

        p2 =  '{
          "url":"'"http://jumpstartlab.com/#{3}"'",
          "requestedAt":"'"#{Time.now}"'",
          "respondedIn":'"#{3 * 10}"',
          "referredBy":"'"http://jumpstartlab.com/#{3}"'",
          "requestType":"POST",
          "parameters": [],
          "eventName":"'"socialLogin#{3}"'",
          "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
          "resolutionWidth":"1920",
          "resolutionHeight":"1280",
          "ip":"'"63.29.38.21#{3}"'"
        }'
    payloads = [p1, p2]
    payloads.each {|payload| PayloadParser.new(payload)}
    assert_equal "GET", RequestType.most_frequent_request_verbs

  end
end
