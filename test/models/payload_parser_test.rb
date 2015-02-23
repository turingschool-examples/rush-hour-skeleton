require './test/test_helper'

class PayloadParserTest < Minitest::Test

  def teardown
    DatabaseCleaner.clean
  end

  def setup
  # payload represents one visit to a client's particular page
    @payload = {
    "url"               => "http://jumpstartlab.com/blog",
    "requestedAt"       => "2013-02-16 21:38:28 -0700",
    "respondedIn"       => 37,
    "referredBy"        => "http://jumpstartlab.com",
    "requestType"       => "GET",
    "parameters"        => [],
    "eventName"         =>  "socialLogin",
    "userAgent"         => "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth"   => "1920",
    "resolutionHeight"  => "1280",
    "ip"                 => "63.29.38.211"
    }
  # we need a sample client in the user table
    @sample_user = User.create({
      "identifier"  => "jumpstartlab",
      "rootUrl"     => "http://jumpstartlab.com"})
  end

  def test_it_parses_a_payload_correctly
    PayloadParser.parse(@sample_user, @payload)
    assert_equal "2013-02-16 21:38:28 -0700", @sample_user.payloads.first.requestedAt
    assert_equal "1920", @sample_user.payloads.first.resolutionWidth
  end

  def test_it_connects_a_url_to_a_payload
    PayloadParser.parse(@sample_user, @payload)
    assert_equal "http://jumpstartlab.com/blog", @sample_user.payloads.first.urls.first.page
  end

  def test_it_connects_an_event_to_a_payload
    PayloadParser.parse(@sample_user, @payload)
    assert_equal "socialLogin", @sample_user.payloads.first.events.first.eventName
  end


end