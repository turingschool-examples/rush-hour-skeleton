require_relative "../test_helper"

class UrlTest < Minitest::Test
include TestHelpers

  def test_it_has_relationship_with_payload_request
    url = Url.new
    assert_respond_to(url, :payload_requests)
  end

  def test_validations_work
    url = Url.create({
        url: "Lucy's BADDDDDD boys"
      })
    assert url.valid?
  end

  def test_empty_string_is_invalid
    url = Url.create({
        url: ""
      })
    assert url.invalid?
  end

  def test_nil_is_invalid
    url = Url.create({
        url: nil
      })
    assert url.invalid?
  end

  def test_no_info_is_invalid
    url = Url.create
    assert url.invalid?
  end

  def test_it_can_give_the_most_to_least_requested_urls
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
      "eventName":"'"socialLogin#{3}"'",
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
      "eventName":"'"socialLogin#{1}"'",
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
      "eventName":"'"socialLogin#{2}"'",
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
      "eventName":"'"socialLogin#{3}"'",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{3}"'"
    }'
    payloads = [p6, p2, p4, p1, p3, p5]
    payloads.each {|payload| PayloadParser.new(payload)}
    url1 = "http://jumpstartlab.com/"
    url2 = "http://facebook.com/"
    url3 = "http://google.com/"
    urls = [url1, url2, url3]
    assert_equal urls, Url.most_to_least_requested_urls
  end

  def test_max_response_time_for_specific_url
    p1 =  '{
      "url":"http://facebook.com/",
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
    p2 =  '{
      "url":"http://facebook.com/",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{2 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{3}"'",
      "requestType":"POST",
      "parameters": [],
      "eventName":"'"socialLogin#{3}"'",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{3}"'"
    }'
    [p1, p2].each {|payload| PayloadParser.new(payload)}
    assert_equal 30, Url.find(1).max_response_time
  end

  def test_min_response_time_for_specific_url
    p1 =  '{
      "url":"http://facebook.com/",
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
    p2 =  '{
      "url":"http://facebook.com/",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{2 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{3}"'",
      "requestType":"POST",
      "parameters": [],
      "eventName":"'"socialLogin#{3}"'",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{3}"'"
    }'
    [p1, p2].each {|payload| PayloadParser.new(payload)}
    assert_equal 20, Url.find(1).min_response_time
  end

  def test_all_response_times_for_specific_url
    p1 =  '{
      "url":"http://facebook.com/",
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
    p2 =  '{
      "url":"http://facebook.com/",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{2 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{3}"'",
      "requestType":"POST",
      "parameters": [],
      "eventName":"'"socialLogin#{3}"'",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{3}"'"
    }'
    p3 =  '{
      "url":"http://facebook.com/",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":"5",
      "referredBy":"'"http://jumpstartlab.com/#{3}"'",
      "requestType":"POST",
      "parameters": [],
      "eventName":"'"socialLogin#{3}"'",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{3}"'"
    }'
    [p1, p2, p3].each {|payload| PayloadParser.new(payload)}
    assert_equal [30, 20, 5], Url.find(1).all_response_times
  end

  def test_all_response_times_for_specific_url
    p1 =  '{
      "url":"http://facebook.com/",
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
    p2 =  '{
      "url":"http://facebook.com/",
      "requestedAt":"'"#{Time.now}"'",
      "respondedIn":'"#{2 * 10}"',
      "referredBy":"'"http://jumpstartlab.com/#{3}"'",
      "requestType":"POST",
      "parameters": [],
      "eventName":"'"socialLogin#{3}"'",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"'"63.29.38.21#{3}"'"
    }'

    [p1, p2].each {|payload| PayloadParser.new(payload)}
    assert_equal 25, Url.find(1).average_response_time
  end

  def test_it_can_give_the_list_of_http_verbs_for_a_specific_url

      p1 =  '{
        "url":"http://facebook.com/",
        "requestedAt":"'"#{Time.now}"'",
        "respondedIn":'"#{3 * 10}"',
        "referredBy":"'"http://jumpstartlab.com/#{3}"'",
        "requestType":"GET",
        "parameters": [],
        "eventName":"'"socialLogin#{3}"'",
        "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth":"1920",
        "resolutionHeight":"1280",
        "ip":"'"63.29.38.21#{3}"'"
      }'
      p2 =  '{
        "url":"http://facebook.com/",
        "requestedAt":"'"#{Time.now}"'",
        "respondedIn":'"#{2 * 10}"',
        "referredBy":"'"http://jumpstartlab.com/#{3}"'",
        "requestType":"POST",
        "parameters": [],
        "eventName":"'"socialLogin#{3}"'",
        "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth":"1920",
        "resolutionHeight":"1280",
        "ip":"'"63.29.38.21#{3}"'"
      }'

      [p1, p2].each {|payload| PayloadParser.new(payload)}
      assert_equal ["GET", "POST"], Url.find(1).all_http_verbs
  end

  def test_it_can_give_the_top_three_referers
    p2 = create_payloads_with_same_references_for_url(2, "http://twitter.com")
    p4 = create_payloads_with_same_references_for_url(4, "http://google.com")
    p1 = create_payloads_with_same_references_for_url(1, "http://instagram.com")
    p3 = create_payloads_with_same_references_for_url(3, "http://facebook.com")
    [p1, p2, p3, p4].flatten.each {|payload| PayloadParser.new(payload)}
      assert_equal ["http://google.com",
                    "http://facebook.com",
                    "http://twitter.com"], Url.find(1).top_three_referrers
  end
end
