require_relative '../test_helper'
require 'json'

class PayloadTest < Minitest::Test

  def create_source(identifier)
    Source.create({identifier: identifier, root_url: "http://#{identifier}.com" })
  end

  def json(identifier)
    { :url=>              "http://#{identifier}.com/blog",
      :requestedAt=>      "2013-02-16 21:38:28 -0700",
      :respondedIn=>      37,
      :referredBy=>       "http://#{identifier}.com",
      :requestType=>      "GET",
      :parameters=>       [],
      :eventName=>        "socialLogin",
      :userAgent=>        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      :resolutionWidth=>  "1920",
      :resolutionHeight=> "1280",
      :ip=>               "63.29.38.211"
    }.to_json
  end
  
  def test_it_takes_parses_json
    identifier = "yahoo"
    create_source(identifier)
    payload_creator = PayloadCreator.new(json(identifier), identifier)
    
    assert_equal JSON.parse(json(identifier)), payload_creator.payload_data
  end

  def test_it_generates_payload_with_correct_column_data
    identifier = "google"
    create_source(identifier)
    
    PayloadCreator.new(json(identifier), identifier)
    payload = Payload.all.last
    
    assert_equal "2013-02-16 21:38:28 -0700", payload.requested_at
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                 payload.user_agent
    assert_equal "http://google.com/blog", payload.url
    assert_equal 37, payload.responded_in
    assert_equal "socialLogin", payload.event_name
  end
end
