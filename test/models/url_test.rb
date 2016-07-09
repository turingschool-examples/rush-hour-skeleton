require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_exists
    assert Url
  end

  def test_that_it_creates_a_url_row
    url = Url.create(path: "/blog" , root: "www.google.com" )
    assert url.valid?
  end

  def test_can_not_create_without_root
#need to do this
  end

  def test_finds_verbs_associated_with_url
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
