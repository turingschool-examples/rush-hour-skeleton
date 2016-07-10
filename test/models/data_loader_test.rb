require_relative '../test_helper'

class DataLoaderTest < Minitest::Test
  include TestHelpers

  def test_it_loads_a_parsed_payload_of_data
    client = Client.create(identifier: "test", root_url: "http://test.com")

    parsed_payload = {
      "url" => "http://test.com",
      "requestedAt" => "2013-02-16 21:38:28 -0700",
      "respondedIn" => 36,
      "referredBy" => "http://test.com",
      "requestType" => "POST",
      "parameters" => [],
      "eventName" => "test",
      "software_agent" => Parser.parse_user_agent("Mozilla/5.0 (Windows; Intel Mac OS X 10_6_8) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.56 Safari/536.5"),
      "ip" => "127.0.0.1",
      "resolutionWidth" => "1",
      "resolutionHeight" => "2" }
      identifier = "test"

      DataLoader.load(parsed_payload, identifier)
      
      assert_equal 1, Url.count
      assert_equal 1, RequestType.count
      assert_equal 1, Referrer.count
      assert_equal 1, SoftwareAgent.count
      assert_equal 1, Client.count
      assert_equal 1, Ip.count
      assert_equal 1, Resolution.count
      assert_equal 1, PayloadRequest.count
    end


  end
