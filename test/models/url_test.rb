require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_that_it_creates_a_url_row
    url = Url.new(root: "www.google.com", path: "/blog")
    assert url.valid?
  end

  def test_it_does_not_get_created_without_browser_info
    url = Url.new(root: nil, path: "/blog")
    refute url.valid?
  end

  def test_it_does_not_get_created_without_browser_info
    url = Url.new(root: "www.google.com", path: nil)
    refute url.valid?
  end

  def test_it_has_a_relationship_with_payload_requests
    url = Url.new
    assert url.respond_to?(:payload_requests)
  end

  def test_it_has_unique_path_for_each_url_root
    url = Url.create(root: "www.google.com", path: "/blog")
    url2 = Url.create(root: "www.google.com", path: "/blog")
    url3 = Url.create(root: "www.google.com", path: "/news")

    assert url.valid?
    refute url2.valid?
    assert url3.valid?
    assert_equal 2, Url.count
  end

  def test_finds_verbs_associated_with_url
    skip
    payload1= '{"url":"http://www.newyorktimes.com/blog",
    "requestedAt":"2013-02-16 21:38:28 -0700",
    "respondedIn":37,
    "referredBy":"http://www.newyorktimes.com",
    "requestType":"PUT",
    "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth":"1920",
    "resolutionHeight":"1280",
    "ip":"63.29.38.211"}'

    payload2= '{"url":"http://www.newyorktimes.com/blog",
    "requestedAt":"2013-02-16 21:38:28 -0700",
    "respondedIn":37,
    "referredBy":"http://www.newyorktimes.com",
    "requestType":"POST",
    "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth":"1920",
    "resolutionHeight":"1280",
    "ip":"63.29.38.211"}'

    payload3= '{"url":"http://www.newyorktimes.com/blog",
    "requestedAt":"2013-02-16 21:38:28 -0700",
    "respondedIn":37,
    "referredBy":"http://www.newyorktimes.com",
    "requestType":"GET",
    "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth":"1920",
    "resolutionHeight":"1280",
    "ip":"63.29.38.211"}'

    DataParser.new(payload1)
    DataParser.new(payload2)
    DataParser.new(payload3)

    url = PayloadRequest[:url].first

    assert_equal "PUT, POST, GET", url.verbs
  end

end
