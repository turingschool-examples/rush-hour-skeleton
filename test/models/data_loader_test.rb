require_relative '../test_helper'

class DataLoaderTest < Minitest::Test
  include TestHelpers

  def test_it_loads_a_parsed_payload_of_data
    parsed_payload = {
     "url" => "http://test.com",
     "requestedAt" => "2013-02-16 21:38:28 -0700",
     "respondedIn" => 36,
     "referredBy" => "http://test.com", #Bug?
     "requestType" => "POST",
     "parameters" => [],
     "eventName" => "test",
     "userAgent" => Parser.parse_user_agent("Mozilla/5.0 (Windows; Intel Mac OS X 10_6_8) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.56 Safari/536.5"),
     "ip" => "127.0.0.1", #bug?
     "resolutionWidth" => "1",
     "resolutionHeight" => "2" }
    identifier = "test"
    rootUrl = "http://test.com"

    DataLoader.load(parsed_payload, identifier, rootUrl)

    assert_equal 2, Url.count
    assert_equal 2, RequestType.count
    assert_equal 2, Referrer.count
    assert_equal 2, EventName.count
    assert_equal 2, PayloadUserAgent.count
    assert_equal 2, Client.count
    assert_equal 2, Ip.count
    assert_equal 2, Resolution.count
    assert_equal 2, PayloadRequest.count
  end
end
